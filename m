Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58247AB50
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhLTOc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:32:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:26946 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233666AbhLTOc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:32:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="227031371"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="227031371"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 06:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="616414489"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2021 06:32:54 -0800
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com> <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <3281618b-64df-711e-4360-c74e6165d7ed@linux.intel.com>
Date:   Mon, 20 Dec 2021 16:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2021 15.55, Peter Zijlstra wrote:
> On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
>> I can reproduce this.
>> Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
>>
>> 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()
> 
> I can confirm, reverting that solves the boot hang, things aren't quite
> working for me though.
> 
>> Seems to hang when read_poll_timeout_atomic() calls ktime_* functions.
>> Maybe  it's too early for ktime.
> 
> It certainly is, using ktime for delay loops sounds daft to me anyhow.
> 
>> After reverting that patch it works again for me.
> 
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
> ...
> [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
> ...
> [    3.161367] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host

Ok, this is some other issue. I got the boot messages over USB
(running minicom at the other end, listening to ttyUSB0)
  
> 
> The machine does boot.. but I *am* getting tons of:
> 
> [  485.546898] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
> [  485.546963] usb usb4-port4: config error

This is expected when xhci driver takes over after the early dbc driver,
xhci driver resets xHC controller, and all ports turn to normal host ports again.

Because of the special cable you now have two hosts connected to each other,
both trying to enumerate a device.

This whole transition from earlyprintk xdbc to normal xhci driver is 
not very userfriendly.

> 
> However, when I do:
> 
> $ echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc
> 

Yes, this works as it turns on the DbC feature on in xHC hardware,
which turns the first USB port into a usb device.

Thanks
-Mathias
