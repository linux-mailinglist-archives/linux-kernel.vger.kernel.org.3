Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0B4F8182
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbiDGOYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbiDGOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:24:38 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EDCA0182AC1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:22:37 -0700 (PDT)
Received: (qmail 223203 invoked by uid 1000); 7 Apr 2022 10:22:37 -0400
Date:   Thu, 7 Apr 2022 10:22:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
Subject: Re: [PATCH] USB:Fix ehci infinite suspend-resume loop issue in
 zhaoxin
Message-ID: <Yk7zrRWDwJsMvX6s@rowland.harvard.edu>
References: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
 <Yi9QIk+6VIWW6V/W@rowland.harvard.edu>
 <320584eb-ef89-3759-509c-e7e9cb10f983@zhaoxin.com>
 <YjCuOXRFZ8CjK9SD@rowland.harvard.edu>
 <ac40c227-ea26-bccd-d254-5a2034103184@zhaoxin.com>
 <YkxoHY2SVomGwGdh@rowland.harvard.edu>
 <bbd9148d-5970-2233-6ee9-625e961cd2f5@zhaoxin.com>
 <Yk29tZpy9pLDlPj2@rowland.harvard.edu>
 <bd43807d-a2d7-5742-4253-c443cdf5c2f0@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd43807d-a2d7-5742-4253-c443cdf5c2f0@zhaoxin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:15:29PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> On 2022/4/7 00:20, Alan Stern wrote:
> > On Wed, Apr 06, 2022 at 10:38:28AM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> > > On 2022/4/6 00:02, Alan Stern wrote:
> > > > In fact, the resume kernel doesn't call ehci_resume at all.  Here's what
> > > > it does:
> > > > 
> > > > 	The resume kernel boots;
> > > > 
> > > > 	If your patch causes STS_PCD to be set at this point, the flag
> > > > 	should get cleared shortly afterward by ehci_irq;
> > > > 
> > > > 	ehci-hcd goes into runtime suspend;
> > > > 
> > > > 	The kernel reads the system image that was stored earlier when
> > > > 	hibernation began;
> > > > 
> > > > 	After the image is loaded, the system goes into the freeze
> > > > 	state (this does not call any routines in ehci-hcd);
> > > On this phase, pci_pm_freeze will be called for pci device. In this
> > > function, pm_runtime_resume will be called to resume already
> > > runtime-suspend devices. which will cause ehci_resume to be called.
> > > Thus STS_PCD flag will be set in ehci_resume function.
> > 
> > Aha!  I was missing that piece of information, thanks.
> > 
> > But this still doesn't explain why check_root_hub_suspended is failing.
> > That routine checks the HCD_RH_RUNNING bit, which gets set in
> > hcd_bus_resume.  hcd_bus_resume gets called as part of resuming the root
> > hub, and in ehci-hcd this happens when ehci_irq sees that STS_PCD is set
> > and calls usb_hcd_resume_root_hub.  That routine queues a wakeup request
> > on the pm_wq work queue, which is then supposed to run hcd_resume_work
> > to actually restart the root hub.
> > 
> > But pm_wq is a freezable work queue!  While the system is in the freeze
> > state, the work queue isn't running.  This means that the root hub
> > should remain suspended until the end of the freeze phase, and so the
> > call to check_root_hub_suspended should succeed.
> > 
> > Can you check to see what's really happening on your system?  Something
> > must be wrong with my analysis, but I can't tell what it is.  I'm still
> > puzzled.
> > 
> > Alan Stern
> Your analysis is right, my test platform's kernel version is not the
> latest, this kernel not call freeze_kernel_threads on software_resume
> function.
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/power/hibernate.c?h=v5.18-rc1&id=2351f8d295ed63393190e39c2f7c1fee1a80578f)
> So pm_wq is active and can handle root hub power events.
> Update my kernel to fix the issue in the url above, system hibernation
> test was successful with our patch(not clear STS_PCD bit).
> Thanks for your clarification.

Great!  I'm glad we sorted that out.

So check_root_hub_suspended doesn't need any changes, and the patch you 
already submitted takes care of everything.

Alan Stern
