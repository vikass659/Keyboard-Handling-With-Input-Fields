//
//  VCSampleForm.swift
//  Keyboard Handling With Input Fields
//
//  Created by Vikas Ninawe on 3/25/18.
//  Copyright © 2018 VSN. All rights reserved.
//

import UIKit

class VCSampleForm: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var scrollVw: UIScrollView!
    @IBOutlet var baseVw: UIView!
    @IBOutlet weak var txtFldUsername: UITextField!
    @IBOutlet weak var txtFldCode: UITextField!
    @IBOutlet weak var txtFldMobile: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtVwAddress: UITextView!
    
    var activeTxtFld:UITextField?
    var activeTxtVw:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFldUsername.delegate = self
        txtFldCode.delegate = self
        txtFldMobile.delegate = self
        txtFldPassword.delegate = self
        txtVwAddress.delegate = self
        
        txtVwAddress.text = "Address"
        txtVwAddress.textColor = .lightGray
        txtVwAddress.layer.cornerRadius = 3.0
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.hideKeyboard))
        self.baseVw.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillShow), name:Notification.Name.UIKeyboardWillShow, object:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillHide), name:Notification.Name.UIKeyboardWillHide, object:nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name:Notification.Name.UIKeyboardWillShow, object:nil)
        
        NotificationCenter.default.removeObserver(self, name:Notification.Name.UIKeyboardWillHide, object:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Keyboard notification delegate methods
    
    func keyBoardWillShow(_ notification:Notification){
        let info = notification.userInfo
        let keyboardSize = (info?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top:0, left:0, bottom:keyboardSize.height, right:0)
        self.scrollVw.contentInset = contentInsets
        self.scrollVw.scrollIndicatorInsets = contentInsets
        
        if self.activeTxtFld != nil {
            self.scrollVw.scrollRectToVisible((self.activeTxtFld?.frame)!, animated: true)
        }
        if self.activeTxtVw != nil {
            self.scrollVw.scrollRectToVisible((self.activeTxtVw?.frame)!, animated: true)
        }
    }
    
    func keyBoardWillHide(_ notification:Notification){
        let contentInsets = UIEdgeInsets(top:0, left:0, bottom:0, right:0)
        self.scrollVw.contentInset = contentInsets
        self.scrollVw.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    // Textfields delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTxtFld = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTxtFld = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // TextView delegate methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.activeTxtVw = nil
        if textView.text.isEmpty {
            textView.text = "Address"
            textView.textColor = .lightGray
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.activeTxtVw = textView
        return true;
    }
    
}


