Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A832347B0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhLTP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhLTP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:59:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E12C061574;
        Mon, 20 Dec 2021 07:59:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0A42B80EDE;
        Mon, 20 Dec 2021 15:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43561C36AE7;
        Mon, 20 Dec 2021 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640015955;
        bh=a6D5AcKl2s8KjzQmrDHkkawywm4+FO0HkiMb5d4UetM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YF3VT8hJ7xpTbHhdpaEs+ssZvDYcDDcY25fW8CvAx7tCibqYjbY7lZUX+f7+r71F6
         31qNSv2KHwJNDnhPM8q6rChY3T8uJdEg1bt+yt85iM2Lv0WnN4/xFOv48yZpyAWM7/
         d+BSyK99dJc352JMyIaOjD/w9i5G1NwygB5mR5Ck=
Date:   Mon, 20 Dec 2021 16:59:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v4] usb: ohci: add check for host controller functional
 states
Message-ID: <YcCoUb7UBUErfvkm@kroah.com>
References: <1633957378-39631-1-git-send-email-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633957378-39631-1-git-send-email-zhuyinbo@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 09:02:58PM +0800, Yinbo Zhu wrote:
> The usb states of ohci controller include UsbOperational, UsbReset,
> UsbSuspend and UsbResume. Among them, only the UsbOperational state
> supports launching the start of frame for host controller according
> the ohci protocol spec, but in S3 and S4 (suspend to memory/suspend
> to disk) press test procedure, it may happen that the start of
> frame was launched in other usb states and cause ohci works failed,
> that the phenomenon was hc will allways reproduce the SoF interrupt
> and consider that hc doesn't deal with the ed/td/done list in non-
> UsbOperational, and this patch was to add check for host controller
> functional states and if it is not UsbOperational state that need
> set INTR_SF in intrdisable register to ensure SOF Token generation
> was been disabled so that it can fix ohci SoF abnormally interrupt.

I do not understand this change.  What commit is this fixing?  What
devices today do not work with the code as-is?

> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v4:
> 		Rework the commit log information.
> 		Remove the extra unnecessary blank line. 
> 
> 
>  drivers/usb/host/ohci-hcd.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 1f5e693..4fd59fa 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -879,7 +879,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  {
>  	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
>  	struct ohci_regs __iomem *regs = ohci->regs;
> -	int			ints;
> +	int			ints, ctl;

New line for a new variable please.

>  
>  	/* Read interrupt status (and flush pending writes).  We ignore the
>  	 * optimization of checking the LSB of hcca->done_head; it doesn't
> @@ -969,9 +969,14 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  	 * when there's still unlinking to be done (next frame).
>  	 */
>  	ohci_work(ohci);
> -	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
> -			&& ohci->rh_state == OHCI_RH_RUNNING)
> +
> +	ctl = ohci_readl(ohci, &regs->control);
> +	if (((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
> +			&& ohci->rh_state == OHCI_RH_RUNNING) ||
> +			((ctl & OHCI_CTRL_HCFS) != OHCI_USB_OPER)) {
>  		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
> +		(void)ohci_readl(ohci, &regs->intrdisable);

No need for (void).

thanks,

greg k-h
