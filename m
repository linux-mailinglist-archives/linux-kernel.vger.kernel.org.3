Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A694FA176
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiDICAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240457AbiDICAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:00:40 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 214192715F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 18:58:34 -0700 (PDT)
Received: (qmail 273585 invoked by uid 1000); 8 Apr 2022 21:58:33 -0400
Date:   Fri, 8 Apr 2022 21:58:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evan Green <evgreen@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: hcd-pci: Fully suspend across freeze/thaw cycle
Message-ID: <YlDoSY19HYNJGI50@rowland.harvard.edu>
References: <20220407115918.1.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
 <YlBGvFFSp/R2CBmh@rowland.harvard.edu>
 <CAE=gft7Zi9tpJ74Tf2iqPRbwJkmSLiKJt-WhwD+h-DxQh75D6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft7Zi9tpJ74Tf2iqPRbwJkmSLiKJt-WhwD+h-DxQh75D6g@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:52:30PM -0700, Evan Green wrote:
> Hi Alan,

Hello.

> On Fri, Apr 8, 2022 at 7:29 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, Apr 07, 2022 at 11:59:55AM -0700, Evan Green wrote:
> > > The documentation for the freeze() method says that it "should quiesce
> > > the device so that it doesn't generate IRQs or DMA". The unspoken
> > > consequence of not doing this is that MSIs aimed at non-boot CPUs may
> > > get fully lost if they're sent during the period where the target CPU is
> > > offline.
> > >
> > > The current callbacks for USB HCD do not fully quiesce interrupts,
> > > specifically on XHCI. Change to use the full suspend/resume flow for
> > > freeze/thaw to ensure interrupts are fully quiesced. This fixes issues
> > > where USB devices fail to thaw during hibernation because XHCI misses
> > > its interrupt and fails to recover.
> >
> > I don't think your interpretation is quite right.  The problem doesn't lie
> > in the HCD callbacks but rather in the root-hub callbacks.
> >
> > Correct me if I'm wrong about xHCI, but AFAIK the host controller doesn't
> > issue any interrupt requests on its own behalf; it issues IRQs only on
> > behalf of its root hubs.  Given that the root hubs should be suspended
> > (i.e., frozen) at this point, and hence not running, the only IRQs they
> > might make would be for wakeup requests.
> >
> > So during freeze, wakeups should be disabled on root hubs.  Currently I
> > believe we don't do this; if a root hub was already runtime suspended when
> > asked to go into freeze, its wakeup setting will remain unchanged.  _That_
> 
> For my issue at least, it's the opposite. Enabling runtime pm on the
> controller significantly reduces the repro rate of the lost interrupt.

That doesn't seem to make sense.  If the controller is in runtime suspend at 
the start of hibernation, the pci_pm_freeze() routine will do a runtime 
resume before calling the HCD freeze function.  So when the controller gets 
put into the freeze state, it is guaranteed not to be runtime suspended 
regardless of what you enable.

> I think having the controller runtime suspended reduces the overall
> number of interrupts that flow in, which is why my chances to hit an
> interrupt in this window drop, but aren't fully eliminated.

When you ran your tests, was wakeup enabled for the host controller?

> I think xhci may still find reasons to generate interrupts even if all
> of its root hub ports are suspended without wake events. For example,
> won't Port Status Change Events still come in if a device is unplugged
> or overcurrents in between freeze() and thaw()?

I'm not an expert on xHCI or xhci-hcd.  For that, we should ask the xhci-hcd 
maintainer (CC'ed).  In fact, he should have been CC'ed on the original 
patch since it was meant to fix a problem involving xHCI controllers.

With EHCI, for example, if a port status change event occurs while the root 
hub is suspended with wakeups disabled, no interrupt request will be 
generated because the port-specific WKOC_E, WKDSCNNT_E, and WKCNNT_E (Wake 
on Over-Current Enable, Wake on Disconnect Enable, and Wake on Connect 
Enable) bits are turned off.  In effect, the port-status change events can 
occur but they aren't treated as wakeup events.

>  The spec does mention
> that generation of this event is gated by the HCHalted flag, but at
> least in my digging around I couldn't find a place where we halt the
> controller through this path.

Bear in mind that suspending the controller and suspending the root hub are 
two different things.

>  With how fragile xhci (and maybe
> others?) are towards lost interrupts, even if it does happen to be
> perfect now, it seems like it would be more resilient to just fully
> suspend the controller across this transition.

Suspending the controller won't fix the problem if the wakeup settings for 
the root hubs are wrong (although it may reduce the window for a race, like 
what you mentioned above).  Conversely, if the wakeup settings for the root 
hubs are correct then suspending the controller shouldn't make any 
difference.

> I'd also put forward the hypothesis (feel free to shoot it down!) that
> unless there's a human-scale time penalty with this change, the
> downsides of being more heavy handed like this across freeze/thaw are
> minimal. There's always a thaw() right on the heels of freeze(), and
> hibernation is such a rare and jarring transition that being able to
> recover after the transition is more important than accomplishing the
> transition quickly.

That's true, but it ignores the underlying problem described in the 
preceding paragraphs.

Alan Stern
