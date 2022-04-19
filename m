Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A385070EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351088AbiDSOqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351904AbiDSOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:46:25 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B4F883A71A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:43:18 -0700 (PDT)
Received: (qmail 594300 invoked by uid 1000); 19 Apr 2022 10:43:02 -0400
Date:   Tue, 19 Apr 2022 10:43:02 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evan Green <evgreen@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] USB: hcd-pci: Fully suspend across freeze/thaw
 cycle
Message-ID: <Yl7KdjrrUrqMkzq8@rowland.harvard.edu>
References: <20220418210046.2060937-1-evgreen@chromium.org>
 <20220418135819.v2.2.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418135819.v2.2.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 02:00:46PM -0700, Evan Green wrote:
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
> its interrupt and cannot recover.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> Changes in v2:
>  - Added the patch modifying the remote wakeup state

That wasn't a change to this patch.  No matter.

>  - Removed the change to freeze_noirq/thaw_noirq
> 
>  drivers/usb/core/hcd-pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 8176bc81a635d6..ae5e6d572376be 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -616,10 +616,10 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>  	.suspend_noirq	= hcd_pci_suspend_noirq,
>  	.resume_noirq	= hcd_pci_resume_noirq,
>  	.resume		= hcd_pci_resume,
> -	.freeze		= check_root_hub_suspended,
> +	.freeze		= hcd_pci_suspend,
>  	.freeze_noirq	= check_root_hub_suspended,
>  	.thaw_noirq	= NULL,
> -	.thaw		= NULL,
> +	.thaw		= hcd_pci_resume,
>  	.poweroff	= hcd_pci_suspend,
>  	.poweroff_noirq	= hcd_pci_suspend_noirq,
>  	.restore_noirq	= hcd_pci_resume_noirq,
