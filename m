Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0720047D41F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbhLVPKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:10:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:17846 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237278AbhLVPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640185821; x=1671721821;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wDsEdZND5Fw7uI60QuLSJ8Os7m5V3R7mG1j0MGh01HY=;
  b=LV654gG9SzgC8yxhK3gi2oWXzHeVvcnFBJQhGu+GhWOP/Fr94bNQZTs2
   07L5eLNwNmdY9v4dHgrd8Il2EGNnuP/j02foRW2Mak1tI/U18seTot8RM
   uQbyfHSekjaI+PQe41WDJ3bAyS+focOpgLKlDaYG8KK8Xeyqnd1k/jYKu
   uoBUUyUL9OKtkk0QkYYDFQY+zk+Ch2D0rbtd2BKfwUsqGWJRDS1Wd6kvE
   w9Z5oeWFpJBS+5NoBo9pr0T6cqvAVVBnlQRpb8zs3K+cKbakmWxGtTVsA
   9nsyJBLu0MY/IYThvEdrN7w2rIvkYB+hjvBSEYvMsmWEbLcASaOdCM8+g
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="239388512"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="239388512"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 07:10:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="484782813"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2021 07:10:18 -0800
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>, Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211126115652.1134230-1-kai.heng.feng@canonical.com>
 <745bd358-c34c-9deb-42e6-6f6a54fd3e2e@linux.intel.com>
 <CAAd53p7ta292yNKYBn3mtav-kPHwtd1GANy9bdCMXL=SPZK+kg@mail.gmail.com>
 <CAAd53p7uifYjFL02fh9m97i89BucdHAwAf4SjgOJkw1XiZ5ezw@mail.gmail.com>
 <66cb505d-8802-9d4c-fa3f-01c47f9734fc@linux.intel.com>
 <CAAd53p68P0zhRvYQj=vdtmhdyGHkk7iKPyJ0rCpW38FwyU0TMA@mail.gmail.com>
 <CAAd53p5Ab2myqQtPfDebaEuOrk-ocGZHoaujXS=vs9MXFd6czw@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] usb: core: Avoid doing warm reset on disconnect event
Message-ID: <99c35f02-d8d3-1357-d309-6bfb8e555600@linux.intel.com>
Date:   Wed, 22 Dec 2021 17:11:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p5Ab2myqQtPfDebaEuOrk-ocGZHoaujXS=vs9MXFd6czw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 5.35, Kai-Heng Feng wrote:
> On Mon, Dec 6, 2021 at 10:52 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> On Fri, Dec 3, 2021 at 10:16 PM Mathias Nyman
>> <mathias.nyman@linux.intel.com> wrote:
>>>
>>> On 2.12.2021 5.10, Kai-Heng Feng wrote:
>>>> On Tue, Nov 30, 2021 at 10:36 AM Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com> wrote:
>>>>>
>>>>> On Mon, Nov 29, 2021 at 6:18 PM Mathias Nyman
>>>>> <mathias.nyman@linux.intel.com> wrote:
>>>>>>
>>>>>> On 26.11.2021 13.56, Kai-Heng Feng wrote:
>>>>>>> Unplugging USB device may cause an incorrect warm reset loop:
>>>>>>> [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x4202c0
>>>>>>> [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
>>>>>>> [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
>>>>>>> [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c0, return 0x4102c0
>>>>>>> [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x4002c0
>>>>>>> [  143.039096] usb usb2-port3: link state change
>>>>>>> [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
>>>>>>> [  143.039101] usb usb2-port3: do warm reset
>>>>>>> [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
>>>>>>> [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
>>>>>>> [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive
>>>>>>> [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x2802a0
>>>>>>> [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
>>>>>>> [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a0, return 0x3002a0
>>>>>>> [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
>>>>>>>
>>>>>>> The warm reset is due to its PLS is in eSS.Inactive state. However, USB
>>>>>>> 3.2 spec table 10-13 mentions "Ports can be disabled by either a fault
>>>>>>> condition (disconnect event or other fault condition)", xHCI 1.2 spec
>>>>>>> table 5-27 also states that "This flag shall automatically be cleared to
>>>>>>> ‘0’ by a disconnect event or other fault condition." on PED.
>>>>>>>
>>>>>>> So use CSC = 0 and PED = 0 as indication that device is disconnecting to
>>>>>>> avoid doing warm reset.
>>>>>>
>>>>>> My understanding is that PED = 0 in case of disconnect, error (PLS=Inactive), or
>>>>>> during active reset signalling. See xHCI Figure 4-27: USB3 Root Hub Port State Machine.
>>>>>> signal states (0,0,0,0) are PP,CCS,PED,PR.
>>>>>
>>>>> I think it's 1,0,0,0? So for my case, the port is in Error state (PLS
>>>>> = Inactive, 1,0,0,0).
>>>
>>> Yes, Port power is still on, so (1,0,0,0) but PED and CCS are both 0.
>>>
>>>>>
>>>>>>
>>>>>> I'm looking at a similar case where Inactive link is reported at disconnect for a while
>>>>>> before missing terminations are detected and link finally goes to RxDetect.
>>>>>
>>>>> So the PLS goes from Inactive to RxDetect after a while?
>>>>> Is the case you are working on also EHL?
>>>
>>> Not EHL this time, anoter platform.
>>>
>>>>>
>>>>>>
>>>>>> If the port was reset immediately when Inactive link state was reported the port stays stuck
>>>>>> in port reset.
>>>>>> This might have been related to the address0 locking issues recently fixed.
>>>>>>
>>>>>> Anyway, to avoid the extra reset of a removed USB3 device I started polling the link state of
>>>>>> the Inactive link for some time before resetting it. This gives the link time to detect
>>>>>> missing terminations and go to RxDetect, and driver can skip the reset.
>>>>>>
>>>>>> Planning on upstreaming it, patch is here:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=fix_avoid_disconnect_reset&id=72d20c026b7812d096c6b5184a3888894401c829
>>>>>
>>>>> Thanks, let me test this out.
>>>>
>>>> The result is negative, here's the relevant log:
>>>> [  128.219129] xhci_hcd 0000:00:14.0: Port change event, 2-2, id 18,
>>>> portsc: 0x4202c0
>>>> [  128.219143] xhci_hcd 0000:00:14.0: handle_port_status: starting port polling.
>>>> [  128.219201] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0004
>>>> [  128.219217] xhci_hcd 0000:00:14.0: Get port status 2-2 read:
>>>> 0x4202c0, return 0x4102c0
>>>> [  128.219244] xhci_hcd 0000:00:14.0: clear port2 connect change,
>>>> portsc: 0x4002c0
>>>> [  128.219256] usb usb2-port2: link state change
>>>> [  128.219264] xhci_hcd 0000:00:14.0: clear port2 link state change,
>>>> portsc: 0x2c0
>>>> [  128.232326] xhci_hcd 0000:00:14.0: xhci_hub_status_data: stopping
>>>> port polling.
>>>> [  128.244356] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
>>>> return 0x2c0
>>>> [  128.244383] usb usb2-port2: Wait for inactive link disconnect detect
>>>> [  128.272342] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
>>>> return 0x2c0
>>>> [  128.272370] usb usb2-port2: Wait for inactive link disconnect detect
>>>> [  128.300348] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
>>>> return 0x2c0
>>>> [  128.300375] usb usb2-port2: Wait for inactive link disconnect detect
>>>> [  128.328342] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
>>>> return 0x2c0
>>>> [  128.328369] usb usb2-port2: Wait for inactive link disconnect detect
>>>> [  128.356343] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
>>>> return 0x2c0
>>>> [  128.356370] usb usb2-port2: Wait for inactive link disconnect detect
>>>> [  128.356374] usb usb2-port2: do warm reset, port only
>>>> [  128.377500] xhci_hcd 0000:00:14.0: Port change event, 1-2, id 2,
>>>> portsc: 0x206e1
>>>> [  128.377515] xhci_hcd 0000:00:14.0: handle_port_status: starting port polling.
>>>> [  128.377570] hub 1-0:1.0: state 7 ports 16 chg 0000 evt 0004
>>>> [  128.377586] xhci_hcd 0000:00:14.0: Get port status 1-2 read:
>>>> 0x206e1, return 0x10101
>>>> [  128.377614] xhci_hcd 0000:00:14.0: clear port2 connect change, portsc: 0x6e1
>>>> [  128.377626] usb usb1-port2: status 0101, change 0001, 12 Mb/s
>>>> [  128.377636] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x6e1,
>>>> return 0x101
>>>> [  128.398304] xhci_hcd 0000:00:14.0: Port change event, 1-2, id 2,
>>>> portsc: 0x202a0
>>>> [  128.398319] xhci_hcd 0000:00:14.0: handle_port_status: starting port polling.
>>>> [  128.412343] xhci_hcd 0000:00:14.0: Get port status 1-2 read:
>>>> 0x202a0, return 0x10100
>>>> [  128.412376] xhci_hcd 0000:00:14.0: clear port2 connect change, portsc: 0x2a0
>>>> [  128.416337] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2b0,
>>>> return 0x2b0
>>>> [  128.416368] usb usb2-port2: not warm reset yet, waiting 50ms
>>>> [  128.448341] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
>>>> return 0x100
>>>> [  128.476335] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2f0,
>>>> return 0x2f0
>>>> [  128.476366] usb usb2-port2: not warm reset yet, waiting 200ms
>>>> [  128.480332] xhci_hcd 0000:00:14.0: xhci_hub_status_data: stopping
>>>> port polling.
>>>> [  128.484343] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
>>>> return 0x100
>>>> [  128.520323] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
>>>> return 0x100
>>>> [  128.556325] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
>>>> return 0x100
>>>> [  128.556353] usb usb1-port2: debounce total 125ms stable 100ms status 0x100
>>>> [  128.556366] hub 1-0:1.0: state 7 ports 16 chg 0000 evt 0004
>>>> [  128.556376] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
>>>> return 0x100
>>>> [  128.684329] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2f0,
>>>> return 0x2f0
>>>> [  128.684360] usb usb2-port2: not warm reset yet, waiting 200ms
>>>> [  128.892325] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2f0,
>>>> return 0x2f0
>>>> [  128.892357] usb usb2-port2: not warm reset yet, waiting 200ms
>>>> [  129.100317] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2f0,
>>>> return 0x2f0
>>>> [  129.100348] usb usb2-port2: not warm reset yet, waiting 200ms
>>>> [  129.100354] hub 2-0:1.0: port_wait_reset: err = -16
>>>> [  129.100358] usb usb2-port2: not enabled, trying warm reset again...
>>>>
>>>
>>> Ok, so after port 2-2 was stuck in inactive (2c0) for long enough we reset it.
>>> It goes to RxDetect with reset asserted(2b0), and then to polling with reset asserted(2f0).
>>> The "RxDetect" and "polling" link states are not very reliable while reset is asserted.
>>>
>>> So problem 1 is that port stays in Inactive for a long time even if device was disconnected.
>>> Issue 2 is that reset never completes. We are stuck in reset.
>>>
>>> Just out of curiosity, does the link go to "RxDetect" from "inactive" if we just
>>> increase the retry, or is it really stuck in inactive state?
>>
>> The result is still negative.
> 
> Mathias,
> 
> So should I refine this patch, or do you want to dig a bit more?
> 
> Kai-Heng

To me it looks like this patch might prevent recovery of a link in "Inactive" error state.

Won't a connected USB3 device after a serious error have the same "Inactive" link status,
and same CCS=0 and PED=0 bits as the disconnect case you described?

In the error case we need the warm reset to recover, and in the disconnect case we should
avoid reset.

Does it make sense to reset at least once, but time how long the reset stays asserted?
If link appears to be stuck in reset then bail out?

Thanks
-Mathias
