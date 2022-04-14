Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F60501743
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbiDNPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348105AbiDNOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:02:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39F5D672;
        Thu, 14 Apr 2022 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649944701; x=1681480701;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VmrXDG9iJKewRIG8lSEXIl4FCcpuFmOe4gRwKxCybl4=;
  b=RfMoz9ZBhmLCfkBbLiYpwQz0khne0f906HyRjFYDD/w5x8hL4r/OAQR7
   bu8RKcz8d2xBuRY7wkEa2b6sI29QN8/0JTAkI3mJPu5UVcl+f5LjqpxzH
   WAgHxmTt/SHTOwcavwI4zl76AqoaTR03B2Mx+pUhX5McSOhEdoK9IjrZP
   P0hU948fNn3JGhynDK3DwoRpE++NIZT1X/UUHnQWkAk+frB+UjLo5r7nr
   Naa1JF3m+GwNe+/pM5pfUbHS/hDi4iWpL/+38HgMfV3VxlNgt0JIb3zYn
   3CQ0CWKGlmYjL8CZkJuY8P4/A1vN5nXj1O7laU2x0hweHdwrXheEUocFF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262686545"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="262686545"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="725372894"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2022 06:58:17 -0700
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
 <4353a956-9855-9c14-7dbf-bf16580abe32@linux.intel.com>
 <YlWdfWRXYjkfHLIP@rowland.harvard.edu>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] USB: hcd-pci: Fully suspend across freeze/thaw cycle
Message-ID: <b1df80e4-af6a-e84f-f49d-c74500bdec05@linux.intel.com>
Date:   Thu, 14 Apr 2022 17:00:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YlWdfWRXYjkfHLIP@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.4.2022 18.40, Alan Stern wrote:
> On Tue, Apr 12, 2022 at 05:56:42PM +0300, Mathias Nyman wrote:
>> On 11.4.2022 17.50, Alan Stern wrote:
>>> For example, what would happen if the user unplugs a device right in the 
>>> middle of the freeze transition, after the root hub has been frozen but 
>>> before the controller is frozen?  We don't want such an unplug event to 
>>> prevent the system from going into hibernation -- especially if the root 
>>> hub was not enabled for wakeup.
>>
>> We should be able to let system go to hibernate even if we get a disconnect
>> interrupt between roothub and host controller freeze.
>> Host is not yet suspended so no PME# wake is generated, only an interrupt.
>>
>> From Linux PM point of view it should be ok as well as the actual xhci
>> device that is generating the interrupt is hasnt completer freeze() 
>>
>> The xhci interrupt handler just needs to make sure that the disconnect
>> isn't propagated if roothub is suspended and wake on disconnect
>> is not set. And definitely make sure xhci doesn't start roothub polling. 
>>
>> When freeze() is called for the host we should prevent the host from 
>> generating interrupts.
> 
> I guess that means adding a new callback.  Or we could just suspend the 
> controller, like Evan proposed originally

Suspending the host in freeze should work.
It will do an extra xhci controller state save stage, but that should be harmless.

But is there really a need for the suggested noirq part?

+	.freeze_noirq	= hcd_pci_suspend_noirq, 

That will try to set the host to PCI D3 state.
It seems a bit unnecessary for freeze.

> 
>>> (If the root hub _is_ enabled for wakeup then it's questionable.  
>>> Unplugging a device would be a wakeup event, so you could easily argue 
>>> that it _should_ prevent the system from going into hibernation.  After 
>>> all, if the unplug happened a few milliseconds later, after the system 
>>> had fully gone into hibernation, then it would cause the system to wake 
>>> up.)
>>>
>>>> Would it make sense prevent xHCI interrupt generation in the host
>>>> freeze() stage, clearing the xHCI EINT bit in addition to calling 
>>>> check_roothub_suspend()?
>>>> Then enable it back in thaw()
>>>
>>> That won't fully eliminate the problem mentioned in the preceding 
>>> paragraphs, although I guess it would help somewhat.
>>
>> Would the following steps solve this?
>>
>> 1. Disable device initiated resume for connected usb devices in freeze()
>>
>> 2. Don't propagate connect or OC changes if roothub is suspended and port wake
>>    flags are disabled. I.E don't kick roothub polling in xhci interrupt
>>    handler here.
> 
> I guess you can't just halt the entire host controller when only one of 
> the root hubs is suspended with wakeup disabled.  That does complicate 
> things.  But you could halt it as soon as both of the root hubs are 
> frozen.  Wouldn't that prevent interrupt generation?

True, but probably easier to just suspend host in freeze() as you stated above.

-Mathias
