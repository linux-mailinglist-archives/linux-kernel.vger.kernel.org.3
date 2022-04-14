Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BFF5019BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbiDNROH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245361AbiDNRNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:13:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECDD326C3;
        Thu, 14 Apr 2022 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649955886; x=1681491886;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=M9pvZ2z0DrNuK7Y81JF7Sp2sNONq9BN0pKSmujNSrEs=;
  b=K1MrvyU6P5ecGDiog1xSNoFVlIcFsMwe6M8HmUagkwhEEfpUQWqHD4OG
   ju7+Gonpm9+0SSwfL6IsVu7dibscKStfgLQk5vbcrk121KERBMEgPA9XO
   w71Awq1Evcu6H3d6HqzlDGnAF/wiRlHIjiHFFOcqHppz1/FGITrEJLlP9
   GGLcxgjRJeyeshlNdV/KDVHQlBedAfIfqy4Ql1lwQ7uxIE2Qzi82Smce4
   WD4kkjIEZ5Y70mWmOoRzbVo3iTUGMowPaG081niMVtbHqqZC/0gSNsdwL
   ZusWGfBVD2yPxGP/At+RW0OX8RBNZ0mgcvzuxWaHh6cJ+zXfJYnti1Vpg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="244865210"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="244865210"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="725440296"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2022 10:04:36 -0700
To:     Evan Green <evgreen@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <4353a956-9855-9c14-7dbf-bf16580abe32@linux.intel.com>
 <YlWdfWRXYjkfHLIP@rowland.harvard.edu>
 <b1df80e4-af6a-e84f-f49d-c74500bdec05@linux.intel.com>
 <Ylgt8Y7Mz4nOAhtv@rowland.harvard.edu>
 <CAE=gft7fvjUX7SdjubHBpd=v3abQ=gJrhM-Oc_RxxqSkoG6mSA@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] USB: hcd-pci: Fully suspend across freeze/thaw cycle
Message-ID: <039bb05f-32e4-2dd1-89ca-b51c17984a7f@linux.intel.com>
Date:   Thu, 14 Apr 2022 20:06:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft7fvjUX7SdjubHBpd=v3abQ=gJrhM-Oc_RxxqSkoG6mSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.4.2022 19.30, Evan Green wrote:
> Hi Alan and Mathias,
> 
> On Thu, Apr 14, 2022 at 7:21 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> On Thu, Apr 14, 2022 at 05:00:12PM +0300, Mathias Nyman wrote:
>>> On 12.4.2022 18.40, Alan Stern wrote:
>>>> On Tue, Apr 12, 2022 at 05:56:42PM +0300, Mathias Nyman wrote:
>>>>> On 11.4.2022 17.50, Alan Stern wrote:
>>>>>> For example, what would happen if the user unplugs a device right in the
>>>>>> middle of the freeze transition, after the root hub has been frozen but
>>>>>> before the controller is frozen?  We don't want such an unplug event to
>>>>>> prevent the system from going into hibernation -- especially if the root
>>>>>> hub was not enabled for wakeup.
>>>>>
>>>>> We should be able to let system go to hibernate even if we get a disconnect
>>>>> interrupt between roothub and host controller freeze.
>>>>> Host is not yet suspended so no PME# wake is generated, only an interrupt.
>>>>>
>>>>> From Linux PM point of view it should be ok as well as the actual xhci
>>>>> device that is generating the interrupt is hasnt completer freeze()
>>>>>
>>>>> The xhci interrupt handler just needs to make sure that the disconnect
>>>>> isn't propagated if roothub is suspended and wake on disconnect
>>>>> is not set. And definitely make sure xhci doesn't start roothub polling.
>>>>>
>>>>> When freeze() is called for the host we should prevent the host from
>>>>> generating interrupts.
>>>>
>>>> I guess that means adding a new callback.  Or we could just suspend the
>>>> controller, like Evan proposed originally
>>>
>>> Suspending the host in freeze should work.
>>> It will do an extra xhci controller state save stage, but that should be harmless.
>>>
>>> But is there really a need for the suggested noirq part?
>>>
>>> +     .freeze_noirq   = hcd_pci_suspend_noirq,
>>>
>>> That will try to set the host to PCI D3 state.
>>> It seems a bit unnecessary for freeze.
>>
>> Agreed.
>>
>>>>>> (If the root hub _is_ enabled for wakeup then it's questionable.
>>>>>> Unplugging a device would be a wakeup event, so you could easily argue
>>>>>> that it _should_ prevent the system from going into hibernation.  After
>>>>>> all, if the unplug happened a few milliseconds later, after the system
>>>>>> had fully gone into hibernation, then it would cause the system to wake
>>>>>> up.)
>>>>>>
>>>>>>> Would it make sense prevent xHCI interrupt generation in the host
>>>>>>> freeze() stage, clearing the xHCI EINT bit in addition to calling
>>>>>>> check_roothub_suspend()?
>>>>>>> Then enable it back in thaw()
>>>>>>
>>>>>> That won't fully eliminate the problem mentioned in the preceding
>>>>>> paragraphs, although I guess it would help somewhat.
>>>>>
>>>>> Would the following steps solve this?
>>>>>
>>>>> 1. Disable device initiated resume for connected usb devices in freeze()
>>>>>
>>>>> 2. Don't propagate connect or OC changes if roothub is suspended and port wake
>>>>>    flags are disabled. I.E don't kick roothub polling in xhci interrupt
>>>>>    handler here.
>>>>
>>>> I guess you can't just halt the entire host controller when only one of
>>>> the root hubs is suspended with wakeup disabled.  That does complicate
>>>> things.  But you could halt it as soon as both of the root hubs are
>>>> frozen.  Wouldn't that prevent interrupt generation?
>>>
>>> True, but probably easier to just suspend host in freeze() as you stated above.
>>
>> Okay.
>>
>> Evan, this discussion suggests that you rewrite your patch as a series
>> of three:
>>
>>      1. Change choose_wakeup() so that for PM_EVENT_FREEZE, wakeup is
>>         always disabled.
> 
> If I understand this correctly, this means potentially runtime
> resuming the device so its wakeup setting can be consistently set to
> wakeups disabled across a freeze transition. Got it I think in terms
> of the "how".
> 
>>
>>      2. Change the xhci-hcd interrupt handler so that port-status
>>         changes are ignored if the port's root hub is suspended with
>>         wakeup disabled.
> 
> This part confuses me. This would be way deep under
> xhci_handle_event(), probably in handle_port_status(), just throwing
> away certain events that come in the ring. How would we know to go
> back and process those events later? I think we don't need to do this
> if we suspend the controller as in #3 below. The suspended (halted)
> controller wouldn't generate event interrupts (since the spec mentions
> port status change generation is gated on HCHalted). So we're already
> covered against receiving interrupts in this zone by halting the
> controller, and the events stay nicely pending for when we restart it
> in thaw.

Was thinking the same here. It would be nice to have this to comply with
usb spec, keeping roothub from propagating connect/disconnect events
immediately after suspending it with wake flags cleared.

But it's a lot of work to implement this, and for this issue, and linux 
hibernate point of view I don't think it has any real benefit.
The actual device generating the interrupt is the host (parent of roothub),
and that will stop once freeze() is called for it in #3 

> 
> Is the goal of #1 purely a setup change for #2, or does it stand on
> its own even if we nixed #2? Said differently, is #1 trying to ensure
> that wake signaling doesn't occur at all between freeze and thaw, even
> when the controller is suspended and guaranteed not to generate
> interrupts via its "normal" mechanism? I don't have a crisp mental
> picture of how the wake signaling works, but if the controller wake
> mechanism sidesteps the original problem of sending an MSI to a dead
> CPU (as in, it does not use MSIs), then it might be ok as-is.

#1 is needed because xHCI can generate wake events even when halted if
device initiated resume signaling is detected on a roothub port.
Just like it can generate wake events on connect/disconnect if wake flags
are set. (xhci spec figure 4-34, see PLS=Resume)
We want to avoid those wakeups between freeze-thaw

So just #1 and #3 should probably solve this, and be an easier change. 

-Mathias

> 
>>
>>      3. As in the original patch, make the .freeze and .thaw callbacks
>>         in hcd-pci.c call the appropriate suspend and resume routines,
>>         but don't do anything for .freeze_noirq and .thaw_noirq.
> 
> Sure. I had made the _noirq paths match suspend for consistency, I
> wasn't sure if those could mix n match without issues. I'll try it out
> leaving the _noirq callbacks alone.
> -Evan
> 
>>
>> How does that sound?
>>
>> Alan Stern

