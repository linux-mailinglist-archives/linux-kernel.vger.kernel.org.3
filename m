Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E139466ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbhLCA4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:56:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:47802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232416AbhLCA4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:56:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="260883577"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="260883577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 16:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="513459179"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 16:52:56 -0800
Cc:     baolu.lu@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Subject: Re: earlyprintk=xdbc seems broken
To:     Peter Zijlstra <peterz@infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
Date:   Fri, 3 Dec 2021 08:52:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 12/2/21 11:22 PM, Peter Zijlstra wrote:
> Hi Lu,
> 
> I was unfortunate enough to need xdbc and can't get my machine to boot
> with earlyprintk=xdbc on the cmdline.
> 
> When I boot the target without the earlyprintk=xdbc, but have the cable
> attached, it won't boot because boot gets stuck like:
> 
> Dec  2 15:08:10 tigerlake kernel: [   42.043137] usb usb4-port3: Cannot enable. Maybe the USB cable is bad?
> Dec  2 15:08:10 tigerlake kernel: [   42.043227] usb usb4-port3: config error
> 
> However, when I boot without earlyprintk=xdbc, without the cable
> attached, then I can attach the cable and:
> 
> $ echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc
> 
> will actually work, and it shows up on my host system:
> 
> [1023855.419430] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
> [1023855.419455] usb usb2-port3: config error
> [1023859.491476] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
> [1023859.491487] usb usb2-port3: config error
> [1023861.335436] usb usb2-port3: config error
> [1023861.607476] usb 2-3: new SuperSpeed USB device number 7 using xhci_hcd
> [1023861.627614] usb 2-3: LPM exit latency is zeroed, disabling LPM.
> [1023861.627853] usb 2-3: New USB device found, idVendor=1d6b, idProduct=0010, bcdDevice= 0.10
> [1023861.627855] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [1023861.627856] usb 2-3: Product: Linux USB Debug Target
> [1023861.627857] usb 2-3: Manufacturer: Linux Foundation
> [1023861.627858] usb 2-3: SerialNumber: 0001
> [1023861.629344] usb_debug 2-3:1.0: xhci_dbc converter detected
> [1023861.629532] usb 2-3: xhci_dbc converter now attached to ttyUSB0
> 
> 
> Can you please see if you can repro and fix this?
> 
> This all was with current 5.16-rc3 on a tigerlake nuc.
> 
> Also, perhaps you can update the guide on what sort of setup/cables
> etc.. you need when either the host or the client is a usb3.1 usb-c only
> device.
> 

+ Mathias, maybe he still has a USB 3.0 debugging cable.

Best regards,
baolu
