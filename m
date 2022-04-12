Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB884FE438
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356771AbiDLO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356768AbiDLO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:57:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F63434B8;
        Tue, 12 Apr 2022 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649775291; x=1681311291;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3Yi8Lm0QcJEtJvg64NU9bMmQ1C2AdaG2Xu38n8fuDTI=;
  b=OZegW9VHjleFbXF69KxRZA6GN3BmWvHI+ylpzZC4F5OkUt62zULutoRV
   45zvuOA0EwzfWWPmIHBYKoVK4gtvj3856mDrOBL/qjsWTkdS2EaMJxGKF
   XbC65Tv2k3RbEpd/OhYfJ0X1Y7XVwKJFqFqflNDVQhpfbLhLj7oyiQkqE
   8xzt+hazQ1ta7IrZ0kfPV6VHF3YMFJs447rVCeWseqdU+3jg1cwwANque
   n8N3DiBrOT2LETCp4JK4n6ckgaAFKMaR1xWqI/Vv/Jm2S53fToR/yrQ80
   91wQRbEldf5qOReRtpzmEG3Xbn/GfoGtYaVAq8lY8IbOn03QqBfUgUQ+R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="242332566"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="242332566"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="724476804"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2022 07:54:48 -0700
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
References: <20220407115918.1.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
 <YlBGvFFSp/R2CBmh@rowland.harvard.edu>
 <CAE=gft7Zi9tpJ74Tf2iqPRbwJkmSLiKJt-WhwD+h-DxQh75D6g@mail.gmail.com>
 <YlDoSY19HYNJGI50@rowland.harvard.edu>
 <022a50ac-7866-2140-1b40-776255f3a036@linux.intel.com>
 <YlRATrMxRWt9gVqt@rowland.harvard.edu>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] USB: hcd-pci: Fully suspend across freeze/thaw cycle
Message-ID: <4353a956-9855-9c14-7dbf-bf16580abe32@linux.intel.com>
Date:   Tue, 12 Apr 2022 17:56:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YlRATrMxRWt9gVqt@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.4.2022 17.50, Alan Stern wrote:
> On Mon, Apr 11, 2022 at 01:43:15PM +0300, Mathias Nyman wrote:
>> Hi
>>
>> On 9.4.2022 4.58, Alan Stern wrote:
>>>>> So during freeze, wakeups should be disabled on root hubs.  Currently I
>>>>> believe we don't do this; if a root hub was already runtime suspended when
>>>>> asked to go into freeze, its wakeup setting will remain unchanged.  _That_
>>
>> In xHCI case freeze will suspend the roothub and make sure all connected devices
>> are in suspended U3 state, but it won't prevent interrupts.
>>
>> And yes, my understanding is also that if devices were runtime suspended with wake
>> enabled before freeze, then devices can can initiate resume any time in the first
>> stages of hibernate (freeze-thaw), causing an interrupt.
> 
> Yeah.  I think we need to change that.
> 
>> We can reduce interrupts by disabling device wake in freeze, but any port change
>> can still cause interrupts.
> 
> Are you sure about this?  Disabling wakeup for the root-hub device is 
> supposed to prevent interrupts from being generated when a port-change 
> event happens.

Just tested connecting a device with roothub suspended and host running.
Roothub ports had wake on connect disabled. It still caused interrupts.

# cat power/runtime_status
active
# cat usb2/power/runtime_status
suspended
# dmesg -C
# dmesg -w
[  789.341756] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 15, portsc: 0x21203
[  789.479484] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 15, portsc: 0x201203

> 
>>>> I think xhci may still find reasons to generate interrupts even if all
>>>> of its root hub ports are suspended without wake events. For example,
>>>> won't Port Status Change Events still come in if a device is unplugged
>>>> or overcurrents in between freeze() and thaw()?
>>
>> Yes, as long as host is running, and host is running between freeze and thaw. 
> 
> It's okay for the events to come in, but if wakeup is disabled on the 
> root hub then the events should not cause an interrupt request.
> 
>>> I'm not an expert on xHCI or xhci-hcd.  For that, we should ask the xhci-hcd 
>>> maintainer (CC'ed).  In fact, he should have been CC'ed on the original 
>>> patch since it was meant to fix a problem involving xHCI controllers.
>>>
>>> With EHCI, for example, if a port status change event occurs while the root 
>>> hub is suspended with wakeups disabled, no interrupt request will be 
>>> generated because the port-specific WKOC_E, WKDSCNNT_E, and WKCNNT_E (Wake 
>>> on Over-Current Enable, Wake on Disconnect Enable, and Wake on Connect 
>>> Enable) bits are turned off.  In effect, the port-status change events can 
>>> occur but they aren't treated as wakeup events.
>>
>> The port-specific wake flags in xHCI only affects interrupt and wake generation
>> for a suspended host. In the freeze() to thaw() stage host is running so flags
>> don't have any effect 
> 
> Is it possible to prevent xHCI from generating an interrupt request if a 
> port change occurs on the root hub while the root hub is suspended but 
> the controller is running?
> 

Didn't find a good way.
No new interrupt will be generated by a port change if there is a uncleared
previous change bit set in that ports PORTSC register.
But there is no way to manually set those bits (write 1 to clear)

> For example, what would happen if the user unplugs a device right in the 
> middle of the freeze transition, after the root hub has been frozen but 
> before the controller is frozen?  We don't want such an unplug event to 
> prevent the system from going into hibernation -- especially if the root 
> hub was not enabled for wakeup.

We should be able to let system go to hibernate even if we get a disconnect
interrupt between roothub and host controller freeze.
Host is not yet suspended so no PME# wake is generated, only an interrupt.

From Linux PM point of view it should be ok as well as the actual xhci
device that is generating the interrupt is hasnt completer freeze() 

The xhci interrupt handler just needs to make sure that the disconnect
isn't propagated if roothub is suspended and wake on disconnect
is not set. And definitely make sure xhci doesn't start roothub polling. 

When freeze() is called for the host we should prevent the host from 
generating interrupts.

> 
> (If the root hub _is_ enabled for wakeup then it's questionable.  
> Unplugging a device would be a wakeup event, so you could easily argue 
> that it _should_ prevent the system from going into hibernation.  After 
> all, if the unplug happened a few milliseconds later, after the system 
> had fully gone into hibernation, then it would cause the system to wake 
> up.)
> 
>> Would it make sense prevent xHCI interrupt generation in the host
>> freeze() stage, clearing the xHCI EINT bit in addition to calling 
>> check_roothub_suspend()?
>> Then enable it back in thaw()
> 
> That won't fully eliminate the problem mentioned in the preceding 
> paragraphs, although I guess it would help somewhat.

Would the following steps solve this?

1. Disable device initiated resume for connected usb devices in freeze()

2. Don't propagate connect or OC changes if roothub is suspended and port wake
   flags are disabled. I.E don't kick roothub polling in xhci interrupt
   handler here.
  
3 Disable host interrupt generation in host freeze(), and re-enable in thaw()

-Mathias

