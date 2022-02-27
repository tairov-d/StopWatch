//
//  ViewController.swift
//  StopWatch
//
//  Created by Daniel on 20/2/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedlControl: UISegmentedControl!
    @IBOutlet var startOutlet: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedTime = Date() {
        didSet {
            timeLabel.text = formattedDate(time: selectedTime)
            time = getTime(time: selectedTime)
        }
    }
    var timer = Timer()
    var isTimer = false
    //    var (hours, minutes, seconds) = (0, 0, 0)
    var time = 0
    var hours: Int {
        time / 3600
    }
    var minutes: Int {
        time % 3600 / 60
    }
    var seconds: Int {
        time % 3600 % 60
    }
    //    var timerTime: Int {
    //        hours * 3600 + minutes * 60 + seconds
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch segmentedlControl.selectedSegmentIndex {
        case 0:
            isTimer = false
            datePicker.isHidden = true
        case 1:
            isTimer = true
            datePicker.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        timer.invalidate()
        startOutlet.isHidden = false
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        
        timer.invalidate()
        time = 0
        timeLabel.text = "00:00:00"
        startOutlet.isHidden = false
        
    }
    
    
    @IBAction func playButton(_ sender: UIButton) {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(keepTimer), userInfo: nil, repeats: true)
        
        
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        selectedTime = sender.date
    }
    
    @objc func keepTimer(){
        if isTimer {
            time -= 1
            if time == 0 {
                stopButton(UIButton())
            }
        } else {
            time += 1
        }
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let hoursString = hours > 9 ? "\(hours)" : "0\(hours)"
        
        
        timeLabel.text = "\(hoursString):\(minutesString):\(secondsString)"
    }
    
    func formattedDate(time: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:SS"
        return formatter.string(from: time)
    }
    
    func getTime(time: Date) -> Int {
        guard
            let string = formattedDate(time: time)
        else { return 0 }
        let array = string.split(separator: ":")
        guard
            array.count == 3,
            let hour = Int(array[0]),
            let minute = Int(array[1]),
            let second = Int(array[2])
        else { return 0 }
        return hour * 3600 +  minute * 60 + second
    }
}
