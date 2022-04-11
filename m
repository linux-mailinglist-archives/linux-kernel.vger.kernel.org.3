Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3804FBF92
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347505AbiDKOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347653AbiDKOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:53:09 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EDED838A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:50:54 -0700 (PDT)
Received: (qmail 343252 invoked by uid 1000); 11 Apr 2022 10:50:54 -0400
Date:   Mon, 11 Apr 2022 10:50:54 -0400
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
Message-ID: <YlRATrMxRWt9gVqt@rowland.harvard.edu>
References: <20220407115918.1.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
 <YlBGvFFSp/R2CBmh@rowland.harvard.edu>
 <CAE=gft7Zi9tpJ74Tf2iqPRbwJkmSLiKJt-WhwD+h-DxQh75D6g@mail.gmail.com>
 <YlDoSY19HYNJGI50@rowland.harvard.edu>
 <022a50ac-7866-2140-1b40-776255f3a036@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022a50ac-7866-2140-1b40-776255f3a036@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 01:43:15PM +0300, Mathias Nyman wrote:
> Hi
> 
> On 9.4.2022 4.58, Alan Stern wrote:
> >>> So during freeze, wakeups should be disabled on root hubs.  Currently I
> >>> believe we don't do this; if a root hub was already runtime suspended when
> >>> asked to go into freeze, its wakeup setting will remain unchanged.  _That_
> 
> In xHCI case freeze will suspend the roothub and make sure all connected devices
> are in suspended U3 state, but it won't prevent interrupts.
> 
> And yes, my understanding is also that if devices were runtime suspended with wake
> enabled before freeze, then devices can can initiate resume any time in the first
> stages of hibernate (freeze-thaw), causing an interrupt.

Yeah.  I think we need to change that.

> We can reduce interrupts by disabling device wake in freeze, but any port change
> can still cause interrupts.

Are you sure about this?  Disabling wakeup for the root-hub device is 
supposed to prevent interrupts from being generated when a port-change 
event happens.

> >> I think xhci may still find reasons to generate interrupts even if all
> >> of its root hub ports are suspended without wake events. For example,
> >> won't Port Status Change Events still come in if a device is unplugged
> >> or overcurrents in between freeze() and thaw()?
> 
> Yes, as long as host is running, and host is running between freeze and thaw. 

It's okay for the events to come in, but if wakeup is disabled on the 
root hub then the events should not cause an interrupt request.

> > I'm not an expert on xHCI or xhci-hcd.  For that, we should ask the xhci-hcd 
> > maintainer (CC'ed).  In fact, he should have been CC'ed on the original 
> > patch since it was meant to fix a problem involving xHCI controllers.
> > 
> > With EHCI, for example, if a port status change event occurs while the root 
> > hub is suspended with wakeups disabled, no interrupt request will be 
> > generated because the port-specific WKOC_E, WKDSCNNT_E, and WKCNNT_E (Wake 
> > on Over-Current Enable, Wake on Disconnect Enable, and Wake on Connect 
> > Enable) bits are turned off.  In effect, the port-status change events can 
> > occur but they aren't treated as wakeup events.
> 
> The port-specific wake flags in xHCI only affects interrupt and wake generation
> for a suspended host. In the freeze() to thaw() stage host is running so flags
> don't have any effect 

Is it possible to prevent xHCI from generating an interrupt request if a 
port change occurs on the root hub while the root hub is suspended but 
the controller is running?

For example, what would happen if the user unplugs a device right in the 
middle of the freeze transition, after the root hub has been frozen but 
before the controller is frozen?  We don't want such an unplug event to 
prevent the system from going into hibernation -- especially if the root 
hub was not enabled for wakeup.

(If the root hub _is_ enabled for wakeup then it's questionable.  
Unplugging a device would be a wakeup event, so you could easily argue 
that it _should_ prevent the system from going into hibernation.  After 
all, if the unplug happened a few milliseconds later, after the system 
had fully gone into hibernation, then it would cause the system to wake 
up.)

> Would it make sense prevent xHCI interrupt generation in the host
> freeze() stage, clearing the xHCI EINT bit in addition to calling 
> check_roothub_suspend()?
> Then enable it back in thaw()

That won't fully eliminate the problem mentioned in the preceding 
paragraphs, although I guess it would help somewhat.

Alan Stern
