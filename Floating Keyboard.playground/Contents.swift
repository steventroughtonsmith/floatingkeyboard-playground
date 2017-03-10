/*
 
 This playground demonstrates the unreleased 'floating' iPad keyboard. This won't work on the 12.9" iPad Pro.
 
 */

import PlaygroundSupport
import Foundation
import UIKit

extension NSObject {
    
    @objc func boolForPreferenceKey_kbpc(_ a:NSString ) -> Bool
    {
        let b = self.boolForPreferenceKey_kbpc(a)
        
        if (a == "KeyboardFloatingEnabled")
        {
            return true
        }
        
        return b
    }
    
}

func performSwizzle()
{
    let UIKeyboardPreferencesController = NSClassFromString("UIKeyboardPreferencesController") as! NSObject.Type
    
    let origMethod = class_getInstanceMethod(UIKeyboardPreferencesController, NSSelectorFromString("boolForPreferenceKey:"))
    let newMethod = class_getInstanceMethod(UIKeyboardPreferencesController,NSSelectorFromString("boolForPreferenceKey_kbpc:"))
    
    method_exchangeImplementations(origMethod, newMethod)
}

performSwizzle()

var tv = UITextView()
tv.text = "Hold the Emoji/Keyboard Select button to toggle 'Floating'. This floating keyboard does not work on the 12.9\" iPad Pro."

PlaygroundPage.current.liveView = tv
tv.perform(NSSelectorFromString("becomeFirstResponder"), with: nil, afterDelay: 0.5)