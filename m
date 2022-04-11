Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414F94FB9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345661AbiDKKnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiDKKni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:43:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E03F32B;
        Mon, 11 Apr 2022 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649673684; x=1681209684;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=F7BhIvlrt00kTkPSYro8/o/CAvwADvOIxE2+7hXIp+s=;
  b=dVwVmRgDHk8kNBNsSARxPmMIbiyJXYmy+W+rtMFlcNwquCBkhKHDSYcY
   f15ZMeKFmNBEVAJRSPxXIl/L8Rx+8zb+nzaL9rsaGBDHKLmfAAJVXKqyP
   My3nIoBO2aeDjx5oZ+s/Am5KXPbG77F8tNqJbuZ7CzIUWq9Dpcpaeh+l8
   r5wqk0T0clVxtbOrgFnXQCCVuTBzc5slltEBaU8ISF53BYGdMfe2gdySp
   PZIY/oCjwA9qKzSO528z2CgYNnquuUy4yJK3CpvCRp90CGfl3wHMkF1Xr
   SJCsZW5SFL/eyjTsA7yoTzLSgcUBSHA966kIPKlPq3B9iPXBnHmd7HTgr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="348523635"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="348523635"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="723919511"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2022 03:41:21 -0700
To:     Alan Stern <stern@rowland.harvard.edu>,
        Evan Green <evgreen@chromium.org>
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
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] USB: hcd-pci: Fully suspend across freeze/thaw cycle
Message-ID: <022a50ac-7866-2140-1b40-776255f3a036@linux.intel.com>
Date:   Mon, 11 Apr 2022 13:43:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YlDoSY19HYNJGI50@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 9.4.2022 4.58, Alan Stern wrote:
> On Fri, Apr 08, 2022 at 02:52:30PM -0700, Evan Green wrote:
>> Hi Alan,
> 
> Hello.
> 
>> On Fri, Apr 8, 2022 at 7:29 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>>>
>>> On Thu, Apr 07, 2022 at 11:59:55AM -0700, Evan Green wrote:
>>>> The documentation for the freeze() method says that it "should quiesce
>>>> the device so that it doesn't generate IRQs or DMA". The unspoken
>>>> consequence of not doing this is that MSIs aimed at non-boot CPUs may
>>>> get fully lost if they're sent during the period where the target CPU is
>>>> offline.
>>>>
>>>> The current callbacks for USB HCD do not fully quiesce interrupts,
>>>> specifically on XHCI. Change to use the full suspend/resume flow for
>>>> freeze/thaw to ensure interrupts are fully quiesced. This fixes issues
>>>> where USB devices fail to thaw during hibernation because XHCI misses
>>>> its interrupt and fails to recover.
>>>
>>> I don't think your interpretation is quite right.  The problem doesn't lie
>>> in the HCD callbacks but rather in the root-hub callbacks.
>>>
>>> Correct me if I'm wrong about xHCI, but AFAIK the host controller doesn't
>>> issue any interrupt requests on its own behalf; it issues IRQs only on
>>> behalf of its root hubs.  Given that the root hubs should be suspended
>>> (i.e., frozen) at this point, and hence not running, the only IRQs they
>>> might make would be for wakeup requests.
>>>
>>> So during freeze, wakeups should be disabled on root hubs.  Currently I
>>> believe we don't do this; if a root hub was already runtime suspended when
>>> asked to go into freeze, its wakeup setting will remain unchanged.  _That_

In xHCI case freeze will suspend the roothub and make sure all connected devices
are in suspended U3 state, but it won't prevent interrupts.

And yes, my understanding is also that if devices were runtime suspended with wake
enabled before freeze, then devices can can initiate resume any time in the first
stages of hibernate (freeze-thaw), causing an interrupt.

We can reduce interrupts by disabling device wake in freeze, but any port change
can still cause interrupts.

>>
>> For my issue at least, it's the opposite. Enabling runtime pm on the
>> controller significantly reduces the repro rate of the lost interrupt.
> 
> That doesn't seem to make sense.  If the controller is in runtime suspend at 
> the start of hibernation, the pci_pm_freeze() routine will do a runtime 
> resume before calling the HCD freeze function.  So when the controller gets 
> put into the freeze state, it is guaranteed not to be runtime suspended 
> regardless of what you enable.
> 
>> I think having the controller runtime suspended reduces the overall
>> number of interrupts that flow in, which is why my chances to hit an
>> interrupt in this window drop, but aren't fully eliminated.
> 
> When you ran your tests, was wakeup enabled for the host controller?
> 
>> I think xhci may still find reasons to generate interrupts even if all
>> of its root hub ports are suspended without wake events. For example,
>> won't Port Status Change Events still come in if a device is unplugged
>> or overcurrents in between freeze() and thaw()?

Yes, as long as host is running, and host is running between freeze and thaw. 

> 
> I'm not an expert on xHCI or xhci-hcd.  For that, we should ask the xhci-hcd 
> maintainer (CC'ed).  In fact, he should have been CC'ed on the original 
> patch since it was meant to fix a problem involving xHCI controllers.
> 
> With EHCI, for example, if a port status change event occurs while the root 
> hub is suspended with wakeups disabled, no interrupt request will be 
> generated because the port-specific WKOC_E, WKDSCNNT_E, and WKCNNT_E (Wake 
> on Over-Current Enable, Wake on Disconnect Enable, and Wake on Connect 
> Enable) bits are turned off.  In effect, the port-status change events can 
> occur but they aren't treated as wakeup events.

The port-specific wake flags in xHCI only affects interrupt and wake generation
for a suspended host. In the freeze() to thaw() stage host is running so flags
don't have any effect 

> 
>>  The spec does mention
>> that generation of this event is gated by the HCHalted flag, but at
>> least in my digging around I couldn't find a place where we halt the
>> controller through this path.
> 
> Bear in mind that suspending the controller and suspending the root hub are 
> two different things.
> 
>>  With how fragile xhci (and maybe
>> others?) are towards lost interrupts, even if it does happen to be
>> perfect now, it seems like it would be more resilient to just fully
>> suspend the controller across this transition.
> 
> Suspending the controller won't fix the problem if the wakeup settings for 
> the root hubs are wrong (although it may reduce the window for a race, like 
> what you mentioned above).  Conversely, if the wakeup settings for the root 
> hubs are correct then suspending the controller shouldn't make any 
> difference.
> 
>> I'd also put forward the hypothesis (feel free to shoot it down!) that
>> unless there's a human-scale time penalty with this change, the
>> downsides of being more heavy handed like this across freeze/thaw are
>> minimal. There's always a thaw() right on the heels of freeze(), and
>> hibernation is such a rare and jarring transition that being able to
>> recover after the transition is more important than accomplishing the
>> transition quickly.
> 
> That's true, but it ignores the underlying problem described in the 
> preceding paragraphs.
> 

Would it make sense prevent xHCI interrupt generation in the host
freeze() stage, clearing the xHCI EINT bit in addition to calling 
check_roothub_suspend()?
Then enable it back in thaw()

Thanks
-Mathias
