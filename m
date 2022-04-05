Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620BE4F4C1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575886AbiDEXJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457528AbiDEQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:04:37 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CF27BCD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:02:38 -0700 (PDT)
Received: (qmail 155879 invoked by uid 1000); 5 Apr 2022 12:02:37 -0400
Date:   Tue, 5 Apr 2022 12:02:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
Subject: Re: [PATCH] USB:Fix ehci infinite suspend-resume loop issue in
 zhaoxin
Message-ID: <YkxoHY2SVomGwGdh@rowland.harvard.edu>
References: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
 <Yi9QIk+6VIWW6V/W@rowland.harvard.edu>
 <320584eb-ef89-3759-509c-e7e9cb10f983@zhaoxin.com>
 <YjCuOXRFZ8CjK9SD@rowland.harvard.edu>
 <ac40c227-ea26-bccd-d254-5a2034103184@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac40c227-ea26-bccd-d254-5a2034103184@zhaoxin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:18:39AM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> On 2022/3/15 11:18, Alan Stern wrote:
> > On Tue, Mar 15, 2022 at 08:39:09PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> > > I have encountered the following situation if EHCI runtime suspend is
> > > enabled by default.

Some things about this still confuse me...

> > > 1.Wake from system to disk and boot OS.
> > 
> > You're talking about resuming after hibernation, right?
> 
> You're right.
> > > 2.EHCI will entry runtime suspend after enumerated by driver during boot
> > > phase of suspend to disk
> > 
> > I'm not sure what you mean by "boot phase of suspend to disk".  This is
> > while the restore kernel is starting up at the beginning of resume from
> > hibernation, right?
> > 
> You understood exactly what I was saying.

Okay, so we're waking up from hibernation.

> > > 3.EHCI will be placed to freeze state and ehci_resume is called after image
> > > is loaded.
> > 
> > ehci_resume is called to leave runtime suspend.  Going into the freeze
> > state doesn't require any changes.

In fact, the resume kernel doesn't call ehci_resume at all.  Here's what 
it does:

	The resume kernel boots;

	If your patch causes STS_PCD to be set at this point, the flag 
	should get cleared shortly afterward by ehci_irq;

	ehci-hcd goes into runtime suspend;

	The kernel reads the system image that was stored earlier when
	hibernation began;

	After the image is loaded, the system goes into the freeze
	state (this does not call any routines in ehci-hcd);

	The resume kernel transfers control to the image kernel;

Now the image kernel is running.  It goes into the restore state, which 
involves calling ehci_resume.  Presumably your patch cases the STS_PCD 
flag to get set at this point.

But that's all!  The system is now back up, out of hibernation, and 
running normally.  There are no more calls to check_root_hub_suspended

> > > 4.If PCD flag is set(caused by patch), then HCD_FLAG_RH_RUNNING will be set.
> > > 
> > > 5.Pci_pm_freeze_noirq is called to check ehci root hub state and return
> > > value is -EBUSY. which will cause
> > >   quiesce phase of suspend to disk fail.
> > 
> > You're talking about check_root_hub_suspended() in hcd-pci.c, right?
> > 
> It's right.

So how can this happen, given that the image kernel doesn't call 
pci_pm_freeze_noirq?

Alan Stern
