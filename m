Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B265B501C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbiDNUT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiDNUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:19:22 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EBC0AEB094
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:16:56 -0700 (PDT)
Received: (qmail 460007 invoked by uid 1000); 14 Apr 2022 16:16:55 -0400
Date:   Thu, 14 Apr 2022 16:16:55 -0400
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
Message-ID: <YliBN9sLwj8UOkU8@rowland.harvard.edu>
References: <CAE=gft7Zi9tpJ74Tf2iqPRbwJkmSLiKJt-WhwD+h-DxQh75D6g@mail.gmail.com>
 <YlDoSY19HYNJGI50@rowland.harvard.edu>
 <022a50ac-7866-2140-1b40-776255f3a036@linux.intel.com>
 <YlRATrMxRWt9gVqt@rowland.harvard.edu>
 <4353a956-9855-9c14-7dbf-bf16580abe32@linux.intel.com>
 <YlWdfWRXYjkfHLIP@rowland.harvard.edu>
 <b1df80e4-af6a-e84f-f49d-c74500bdec05@linux.intel.com>
 <Ylgt8Y7Mz4nOAhtv@rowland.harvard.edu>
 <CAE=gft7fvjUX7SdjubHBpd=v3abQ=gJrhM-Oc_RxxqSkoG6mSA@mail.gmail.com>
 <039bb05f-32e4-2dd1-89ca-b51c17984a7f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039bb05f-32e4-2dd1-89ca-b51c17984a7f@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 08:06:32PM +0300, Mathias Nyman wrote:
> On 14.4.2022 19.30, Evan Green wrote:
> > Hi Alan and Mathias,
> > 
> > On Thu, Apr 14, 2022 at 7:21 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >> Evan, this discussion suggests that you rewrite your patch as a series
> >> of three:
> >>
> >>      1. Change choose_wakeup() so that for PM_EVENT_FREEZE, wakeup is
> >>         always disabled.
> > 
> > If I understand this correctly, this means potentially runtime
> > resuming the device so its wakeup setting can be consistently set to
> > wakeups disabled across a freeze transition.

The kernel already does this for you.  All you have to do is change the 
routine so that it always decides that wakeup should be off for FREEZE.

> >  Got it I think in terms
> > of the "how".

> >>      2. Change the xhci-hcd interrupt handler so that port-status
> >>         changes are ignored if the port's root hub is suspended with
> >>         wakeup disabled.
> > 
> > This part confuses me. This would be way deep under
> > xhci_handle_event(), probably in handle_port_status(), just throwing
> > away certain events that come in the ring. How would we know to go
> > back and process those events later?

We wouldn't.  There's no need to process the events later.  When a hub 
(including a root hub) is resumed, the hub driver checks the state of 
each port and takes whatever actions are needed to handle any changes 
that occurred while the hub was suspended.

In fact, processing these events wouldnn't really accomplish very much 
in any case.  The driver would request that the root hub be resumed, 
that request would be submitted to a work queue, and then nothing would 
happen because the work queue, like many other kernel threads, gets 
frozen during a hibernation transition.

All that's really needed is to guarantee that the root hub would be 
resumed when we leave hibernation.  And of course, this always happens 
regardless of what events were received in the meantime.

> >  I think we don't need to do this
> > if we suspend the controller as in #3 below. The suspended (halted)
> > controller wouldn't generate event interrupts (since the spec mentions
> > port status change generation is gated on HCHalted). So we're already
> > covered against receiving interrupts in this zone by halting the
> > controller, and the events stay nicely pending for when we restart it
> > in thaw.
> 
> Was thinking the same here. It would be nice to have this to comply with
> usb spec, keeping roothub from propagating connect/disconnect events
> immediately after suspending it with wake flags cleared.
> 
> But it's a lot of work to implement this, and for this issue, and linux 
> hibernate point of view I don't think it has any real benefit.
> The actual device generating the interrupt is the host (parent of roothub),
> and that will stop once freeze() is called for it in #3 

The only reason that approach works is because we never disable resume 
requests during runtime suspend.  But okay...

> > Is the goal of #1 purely a setup change for #2, or does it stand on
> > its own even if we nixed #2? Said differently, is #1 trying to ensure
> > that wake signaling doesn't occur at all between freeze and thaw, even
> > when the controller is suspended and guaranteed not to generate
> > interrupts via its "normal" mechanism? I don't have a crisp mental
> > picture of how the wake signaling works, but if the controller wake
> > mechanism sidesteps the original problem of sending an MSI to a dead
> > CPU (as in, it does not use MSIs), then it might be ok as-is.
> 
> #1 is needed because xHCI can generate wake events even when halted if
> device initiated resume signaling is detected on a roothub port.
> Just like it can generate wake events on connect/disconnect if wake flags
> are set. (xhci spec figure 4-34, see PLS=Resume)
> We want to avoid those wakeups between freeze-thaw

Think of it this way: All USB hubs, including root hubs, always relay 
a resume request upstream when one is received on a downstream port, no 
matter what their wakeup setting is.  A hub's wakeup setting only 
controls whether it generates a resume request on its own in response 
to a port-status change.

> So just #1 and #3 should probably solve this, and be an easier change. 

Let's try it and see.

Alan Stern
