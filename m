Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275014F67DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiDFR41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiDFR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:56:08 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 29CBB3C30F9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:20:06 -0700 (PDT)
Received: (qmail 192537 invoked by uid 1000); 6 Apr 2022 12:20:05 -0400
Date:   Wed, 6 Apr 2022 12:20:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
Subject: Re: [PATCH] USB:Fix ehci infinite suspend-resume loop issue in
 zhaoxin
Message-ID: <Yk29tZpy9pLDlPj2@rowland.harvard.edu>
References: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
 <Yi9QIk+6VIWW6V/W@rowland.harvard.edu>
 <320584eb-ef89-3759-509c-e7e9cb10f983@zhaoxin.com>
 <YjCuOXRFZ8CjK9SD@rowland.harvard.edu>
 <ac40c227-ea26-bccd-d254-5a2034103184@zhaoxin.com>
 <YkxoHY2SVomGwGdh@rowland.harvard.edu>
 <bbd9148d-5970-2233-6ee9-625e961cd2f5@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd9148d-5970-2233-6ee9-625e961cd2f5@zhaoxin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:38:28AM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> On 2022/4/6 00:02, Alan Stern wrote:
> > In fact, the resume kernel doesn't call ehci_resume at all.  Here's what
> > it does:
> > 
> > 	The resume kernel boots;
> > 
> > 	If your patch causes STS_PCD to be set at this point, the flag
> > 	should get cleared shortly afterward by ehci_irq;
> > 
> > 	ehci-hcd goes into runtime suspend;
> > 
> > 	The kernel reads the system image that was stored earlier when
> > 	hibernation began;
> > 
> > 	After the image is loaded, the system goes into the freeze
> > 	state (this does not call any routines in ehci-hcd);
> On this phase, pci_pm_freeze will be called for pci device. In this
> function, pm_runtime_resume will be called to resume already
> runtime-suspend devices. which will cause ehci_resume to be called.
> Thus STS_PCD flag will be set in ehci_resume function.

Aha!  I was missing that piece of information, thanks.

But this still doesn't explain why check_root_hub_suspended is failing.  
That routine checks the HCD_RH_RUNNING bit, which gets set in 
hcd_bus_resume.  hcd_bus_resume gets called as part of resuming the root 
hub, and in ehci-hcd this happens when ehci_irq sees that STS_PCD is set 
and calls usb_hcd_resume_root_hub.  That routine queues a wakeup request 
on the pm_wq work queue, which is then supposed to run hcd_resume_work 
to actually restart the root hub.

But pm_wq is a freezable work queue!  While the system is in the freeze 
state, the work queue isn't running.  This means that the root hub 
should remain suspended until the end of the freeze phase, and so the 
call to check_root_hub_suspended should succeed.

Can you check to see what's really happening on your system?  Something 
must be wrong with my analysis, but I can't tell what it is.  I'm still 
puzzled.

Alan Stern
