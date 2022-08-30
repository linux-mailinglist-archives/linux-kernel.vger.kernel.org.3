Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A335E5A6877
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH3QdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiH3QdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:33:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706DA2870;
        Tue, 30 Aug 2022 09:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8E53B80EF4;
        Tue, 30 Aug 2022 16:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3093EC433C1;
        Tue, 30 Aug 2022 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661877178;
        bh=FrrYBNZmq5m8AWU7FMr8w2U8JHpQVuWiuOPwjM7XUhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETPh+s/kfn0Cko2GsXIMEAP/CKuJMrP2DN4yR9+lexieQQCY8Cv2/bkXOhd6SgHUJ
         cfx1Egm+OlE72rGU7sGqVfKeZlT9BVUNIZJqV6bHy5bezyvJPRbYA7dUEorov3ppJD
         Nb8WW4iPNVB+UngrTJV8kqYK/92v+Xy7U92mEaro=
Date:   Tue, 30 Aug 2022 18:32:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being
 a V0.96 controller
Message-ID: <Yw47t5xOr6qY8Hru@kroah.com>
References: <em007c3aa5-02c9-4a51-b789-6973e5f116ef@607fe812.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em007c3aa5-02c9-4a51-b789-6973e5f116ef@607fe812.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:27:42PM +0000, Jens Glathe wrote:
> Hi there,
> 
> first try at a patch which was an actual pain with my Lenovo T500 notebook,
> augmented with an USB3 PCMCIA card that has an ASM1042 chip. Inspired by
> this email thread: https://markmail.org/thread/7vzqbe7t6du6qsw3
> 
> ASM1042 identifies as a 0x96 XHCI host, brings spurious transfer event
> errors with a r8152 (Realtek 8153a) USB3 enthernet adapter. Additionally
> setting quirk XHCI_SPURIOUS_SUCCESS seems to resolve this issue in this
> case.
> 
> wiith best regards
> 
> Jens Glathe

> From eac3410eeaf03c111add4dce247c4002fc58ba5d Mon Sep 17 00:00:00 2001
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Date: Sun, 28 Aug 2022 16:23:41 +0200
> Subject: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
>  V0.96 controller
> 
> only if it reports as a V0.96 XHCI controller. Appears to fix the errors
> "xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 13"
> that appear spuriously (or pretty often) when using a r8152 USB3 ethernet adapter with integrated hub.
> ---
>  drivers/usb/host/xhci-pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index dce6c0ec8d34..035229bc6d29 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -306,8 +306,14 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	}
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> -		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
> +		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
> +    /* try to tame the ASMedia 1042 controller which is 0.96 
> +    */
> +	  if (xhci->hci_version == 0x96) {
> +      xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> +    }
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
> +	}
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>  		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
