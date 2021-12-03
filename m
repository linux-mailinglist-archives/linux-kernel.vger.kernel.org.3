Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599EE46796B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381476AbhLCOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:33:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:54386 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhLCOdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:33:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="300365903"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="300365903"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 06:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="656096289"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2021 06:30:06 -0800
Subject: Re: earlyprintk=xdbc seems broken
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
Date:   Fri, 3 Dec 2021 16:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.12.2021 2.52, Lu Baolu wrote:
> Hi Peter,
> 
> On 12/2/21 11:22 PM, Peter Zijlstra wrote:
>> Hi Lu,
>>
>> I was unfortunate enough to need xdbc and can't get my machine to boot
>> with earlyprintk=xdbc on the cmdline.
>>
>> When I boot the target without the earlyprintk=xdbc, but have the cable
>> attached, it won't boot because boot gets stuck like:
>>
>> Dec  2 15:08:10 tigerlake kernel: [   42.043137] usb usb4-port3: Cannot enable. Maybe the USB cable is bad?
>> Dec  2 15:08:10 tigerlake kernel: [   42.043227] usb usb4-port3: config error
>>
>> However, when I boot without earlyprintk=xdbc, without the cable
>> attached, then I can attach the cable and:
>>
>> $ echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc
>>
>> will actually work, and it shows up on my host system:
>>
>> [1023855.419430] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
>> [1023855.419455] usb usb2-port3: config error
>> [1023859.491476] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
>> [1023859.491487] usb usb2-port3: config error
>> [1023861.335436] usb usb2-port3: config error
>> [1023861.607476] usb 2-3: new SuperSpeed USB device number 7 using xhci_hcd
>> [1023861.627614] usb 2-3: LPM exit latency is zeroed, disabling LPM.
>> [1023861.627853] usb 2-3: New USB device found, idVendor=1d6b, idProduct=0010, bcdDevice= 0.10
>> [1023861.627855] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> [1023861.627856] usb 2-3: Product: Linux USB Debug Target
>> [1023861.627857] usb 2-3: Manufacturer: Linux Foundation
>> [1023861.627858] usb 2-3: SerialNumber: 0001
>> [1023861.629344] usb_debug 2-3:1.0: xhci_dbc converter detected
>> [1023861.629532] usb 2-3: xhci_dbc converter now attached to ttyUSB0
>>
>>
>> Can you please see if you can repro and fix this?
>>
>> This all was with current 5.16-rc3 on a tigerlake nuc.
>>
>> Also, perhaps you can update the guide on what sort of setup/cables
>> etc.. you need when either the host or the client is a usb3.1 usb-c only
>> device.
>>
> 
> + Mathias, maybe he still has a USB 3.0 debugging cable.
> 

Should have at the office, I'll pick it up next week and try it out.

-Mathias
