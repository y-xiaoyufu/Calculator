//
//  ViewController.swift
//  Calculator
//
//  Created by xiaoyufu on 2018/6/27.
//  Copyright © 2018年 xiaoyufu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false;

    @IBAction func addpendDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!;
        
        if(userIsInTheMiddleOfTypingANumber){
            
            display.text = display.text! + digit;
        }else{
            userIsInTheMiddleOfTypingANumber = true;
            
            display.text = digit;
        }
        
    }
    
    var operandStack = Array<Double>();
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!;
        if(userIsInTheMiddleOfTypingANumber){
            enter();
        }
        
        switch operation {
        case "×":
    
            performOperation { $0 * $1 };
        case "÷":
            performOperation { $0 / $1 };
        case "+":
            performOperation { $0 + $1 };
        case "−":
            performOperation { $0 - $1 };
        case "√":
            performOperation { sqrt($0) };
        default:
            break;
        }
        
        
    }
    
    
    func performOperation(operation:(Double,Double) -> Double){
        
        if(operandStack.count >= 2){
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast());
            enter();
        }
        
    }
    
    func performOperation(operation:(Double) -> Double){
        
        if(operandStack.count >= 1){
            displayValue = operation(operandStack.removeLast());
            enter();
        }
        
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false;
        operandStack.append(displayValue);
        print("operandStack = \(operandStack)");
    }
    
    var displayValue:Double{
        get{
            return NSString(string:display.text!).doubleValue;
        }
        
        set{
            display.text = "\(newValue)";
            userIsInTheMiddleOfTypingANumber = false;
        }
        
    }
    
}

