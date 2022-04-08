Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9493E4F980E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiDHObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDHObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:31:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1AFE4362201
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:29:17 -0700 (PDT)
Received: (qmail 257248 invoked by uid 1000); 8 Apr 2022 10:29:16 -0400
Date:   Fri, 8 Apr 2022 10:29:16 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evan Green <evgreen@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: hcd-pci: Fully suspend across freeze/thaw cycle
Message-ID: <YlBGvFFSp/R2CBmh@rowland.harvard.edu>
References: <20220407115918.1.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407115918.1.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:59:55AM -0700, Evan Green wrote:
> The documentation for the freeze() method says that it "should quiesce
> the device so that it doesn't generate IRQs or DMA". The unspoken
> consequence of not doing this is that MSIs aimed at non-boot CPUs may
> get fully lost if they're sent during the period where the target CPU is
> offline.
> 
> The current callbacks for USB HCD do not fully quiesce interrupts,
> specifically on XHCI. Change to use the full suspend/resume flow for
> freeze/thaw to ensure interrupts are fully quiesced. This fixes issues
> where USB devices fail to thaw during hibernation because XHCI misses
> its interrupt and fails to recover.

I don't think your interpretation is quite right.  The problem doesn't lie 
in the HCD callbacks but rather in the root-hub callbacks.

Correct me if I'm wrong about xHCI, but AFAIK the host controller doesn't 
issue any interrupt requests on its own behalf; it issues IRQs only on 
behalf of its root hubs.  Given that the root hubs should be suspended 
(i.e., frozen) at this point, and hence not running, the only IRQs they 
might make would be for wakeup requests.

So during freeze, wakeups should be disabled on root hubs.  Currently I 
believe we don't do this; if a root hub was already runtime suspended when 
asked to go into freeze, its wakeup setting will remain unchanged.  _That_ 
is the bug which needs to be fixed.  (Consider what would happen if a root 
hub wakes up after it is frozen but before the host controller is frozen: 
The attempt to freeze the host controller would fail, causing the entire 
hibernation transition to fail.)

The whole issue of how wakeup requests should be handled during hibernation 
is a difficult one.  I don't think we have any good protection against cases 
where a wakeup request races with the system entering hibernation.  For 
instance, if a wakeup event occurs after we go into the thaw state, it won't 
even be recognized as such because the system will be running normally and 
will handle it as an ordinary event.  But then it will be consumed, so the 
wakeup signal won't remain on to reactivate the system once it has shut 
down, and when the stored kernel image is eventually restored it won't 
remember that the event ever happened.

Alan Stern

> Signed-off-by: Evan Green <evgreen@chromium.org> ---
> 
> You may be able to reproduce this issue on your own machine via the
> following:
> 1. Disable runtime PM on your XHCI controller
> 2. Aim your XHCI IRQ at a non-boot CPU (replace 174): echo 2 >
>    /proc/irq/174/smp_affinity
> 3. Attempt to hibernate (no need to actually go all the way down).
> 
> I run 2 and 3 in a loop, and can usually hit a hang or dead XHCI
> controller within 1-2 iterations. I happened to notice this on an
> Alderlake system where runtime PM is accidentally disabled for one of
> the XHCI controllers. Some more discussion and debugging can be found at
> [1].
> 
> [1] https://lore.kernel.org/linux-pci/CAE=gft4a-QL82iFJE_xRQ3JrMmz-KZKWREtz=MghhjFbJeK=8A@mail.gmail.com/T/#u
> 
> ---
>  drivers/usb/core/hcd-pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 8176bc81a635d6..e02506807ffc6c 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -616,10 +616,10 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>  	.suspend_noirq	= hcd_pci_suspend_noirq,
>  	.resume_noirq	= hcd_pci_resume_noirq,
>  	.resume		= hcd_pci_resume,
> -	.freeze		= check_root_hub_suspended,
> -	.freeze_noirq	= check_root_hub_suspended,
> -	.thaw_noirq	= NULL,
> -	.thaw		= NULL,
> +	.freeze		= hcd_pci_suspend,
> +	.freeze_noirq	= hcd_pci_suspend_noirq,
> +	.thaw_noirq	= hcd_pci_resume_noirq,
> +	.thaw		= hcd_pci_resume,
>  	.poweroff	= hcd_pci_suspend,
>  	.poweroff_noirq	= hcd_pci_suspend_noirq,
>  	.restore_noirq	= hcd_pci_resume_noirq,
> -- 
> 2.31.0
> 
