Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5234FE4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357208AbiDLPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357332AbiDLPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:43:05 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2137D5D661
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:40:47 -0700 (PDT)
Received: (qmail 377970 invoked by uid 1000); 12 Apr 2022 11:40:46 -0400
Date:   Tue, 12 Apr 2022 11:40:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: hcd-pci: Fully suspend across freeze/thaw cycle
Message-ID: <YlWdfWRXYjkfHLIP@rowland.harvard.edu>
References: <20220407115918.1.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
 <YlBGvFFSp/R2CBmh@rowland.harvard.edu>
 <CAE=gft7Zi9tpJ74Tf2iqPRbwJkmSLiKJt-WhwD+h-DxQh75D6g@mail.gmail.com>
 <YlDoSY19HYNJGI50@rowland.harvard.edu>
 <022a50ac-7866-2140-1b40-776255f3a036@linux.intel.com>
 <YlRATrMxRWt9gVqt@rowland.harvard.edu>
 <4353a956-9855-9c14-7dbf-bf16580abe32@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4353a956-9855-9c14-7dbf-bf16580abe32@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 05:56:42PM +0300, Mathias Nyman wrote:
> On 11.4.2022 17.50, Alan Stern wrote:
> > For example, what would happen if the user unplugs a device right in the 
> > middle of the freeze transition, after the root hub has been frozen but 
> > before the controller is frozen?  We don't want such an unplug event to 
> > prevent the system from going into hibernation -- especially if the root 
> > hub was not enabled for wakeup.
> 
> We should be able to let system go to hibernate even if we get a disconnect
> interrupt between roothub and host controller freeze.
> Host is not yet suspended so no PME# wake is generated, only an interrupt.
> 
> From Linux PM point of view it should be ok as well as the actual xhci
> device that is generating the interrupt is hasnt completer freeze() 
> 
> The xhci interrupt handler just needs to make sure that the disconnect
> isn't propagated if roothub is suspended and wake on disconnect
> is not set. And definitely make sure xhci doesn't start roothub polling. 
> 
> When freeze() is called for the host we should prevent the host from 
> generating interrupts.

I guess that means adding a new callback.  Or we could just suspend the 
controller, like Evan proposed originally.

> > (If the root hub _is_ enabled for wakeup then it's questionable.  
> > Unplugging a device would be a wakeup event, so you could easily argue 
> > that it _should_ prevent the system from going into hibernation.  After 
> > all, if the unplug happened a few milliseconds later, after the system 
> > had fully gone into hibernation, then it would cause the system to wake 
> > up.)
> > 
> >> Would it make sense prevent xHCI interrupt generation in the host
> >> freeze() stage, clearing the xHCI EINT bit in addition to calling 
> >> check_roothub_suspend()?
> >> Then enable it back in thaw()
> > 
> > That won't fully eliminate the problem mentioned in the preceding 
> > paragraphs, although I guess it would help somewhat.
> 
> Would the following steps solve this?
> 
> 1. Disable device initiated resume for connected usb devices in freeze()
> 
> 2. Don't propagate connect or OC changes if roothub is suspended and port wake
>    flags are disabled. I.E don't kick roothub polling in xhci interrupt
>    handler here.

I guess you can't just halt the entire host controller when only one of 
the root hubs is suspended with wakeup disabled.  That does complicate 
things.  But you could halt it as soon as both of the root hubs are 
frozen.  Wouldn't that prevent interrupt generation?

> 3 Disable host interrupt generation in host freeze(), and re-enable in thaw()

And then this step wouldn't be necessary, right?

Alan Stern
