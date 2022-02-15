Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84D24B77DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiBOQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:49:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiBOQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:48:57 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 25DFBC12F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:48:47 -0800 (PST)
Received: (qmail 754088 invoked by uid 1000); 15 Feb 2022 11:48:46 -0500
Date:   Tue, 15 Feb 2022 11:48:46 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-platform: Update brcm, xgs-iproc-ehci
 workaround
Message-ID: <YgvZblgRiqzi6QlI@rowland.harvard.edu>
References: <20220215000813.1779032-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215000813.1779032-1-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:08:13PM +1300, Chris Packham wrote:
> The original workaround was added prior to commit e4788edc730a ("USB:
> EHCI: Add alias for Broadcom INSNREG"). Now that brcm_insnreg exists in
> struct ehci_regs we can use that instead of having a local definition.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-platform.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index c3dc906274d9..1115431a255d 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -43,7 +43,6 @@
>  #define hcd_to_ehci_priv(h) ((struct ehci_platform_priv *)hcd_to_ehci(h)->priv)
>  
>  #define BCM_USB_FIFO_THRESHOLD	0x00800040
> -#define bcm_iproc_insnreg01	hostpc[0]
>  
>  struct ehci_platform_priv {
>  	struct clk *clks[EHCI_MAX_CLKS];
> @@ -81,7 +80,7 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  
>  	if (of_device_is_compatible(pdev->dev.of_node, "brcm,xgs-iproc-ehci"))
>  		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
> -			    &ehci->regs->bcm_iproc_insnreg01);
> +			    &ehci->regs->brcm_insnreg[1]);
>  
>  	return 0;
>  }
