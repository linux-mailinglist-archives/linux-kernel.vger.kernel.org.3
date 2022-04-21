Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4ED50A622
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiDUQvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiDUQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2CA49690;
        Thu, 21 Apr 2022 09:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74AE861CD9;
        Thu, 21 Apr 2022 16:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623E5C385A1;
        Thu, 21 Apr 2022 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650559723;
        bh=yP8brE5xLFSZ4V+019DWeeykSrtQQtHPVTTnvr0EayY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfT+bMpAmzLMFlJadFbYxAXzctEsG9vI5g3xuKM28TFO9Zb45KHhP/bpb+r2GV6kk
         LnIH/COSCtqnDsqgMBC7oSwBwVAFvtETfczvM8uWEUBYdKpmqT0hqmscKFDUL4I2tZ
         uh+tezDqfQH242oZ8+joIgEc5xHBumdbD5JQ71dE=
Date:   Thu, 21 Apr 2022 18:48:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tao Wang <quic_wat@quicinc.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        quic_linyyuan@quicinc.com
Subject: Re: [PATCH] usb: hcd: add a flag for whether using shared_hcd priv
Message-ID: <YmGK6DXDdM5vx3Qe@kroah.com>
References: <1649299514-64014-1-git-send-email-quic_wat@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649299514-64014-1-git-send-email-quic_wat@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:45:14AM +0800, Tao Wang wrote:
> The shared_hcd->hcd_priv is not used in xhci, so not
> need to malloc hcd priv memory for shared_hcd.

What is the problem with allocating that memory?  Do you have systems
with thousands of USB host controllers where this memory is wasted?

> This change add a shared_hcd_no_priv flag to indicate
> if shared_hcd use priv, and set the flag of xhci to 1.

1 is not a boolean :(

> 
> Signed-off-by: Tao Wang <quic_wat@quicinc.com>
> ---
>  drivers/usb/core/hcd.c       | 6 +++++-
>  drivers/usb/host/xhci-plat.c | 1 +
>  include/linux/usb/hcd.h      | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 99908d8..f339c3e 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2419,7 +2419,11 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
>  {
>  	struct usb_hcd *hcd;
>  
> -	hcd = kzalloc(sizeof(*hcd) + driver->hcd_priv_size, GFP_KERNEL);
> +	if (primary_hcd && driver->shared_hcd_no_priv)
> +		hcd = kzalloc(sizeof(*hcd), GFP_KERNEL);
> +	else
> +		hcd = kzalloc(sizeof(*hcd) + driver->hcd_priv_size, GFP_KERNEL);
> +
>  	if (!hcd)
>  		return NULL;
>  	if (primary_hcd == NULL) {
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 21280a6..223e508 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -236,6 +236,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	driver = &xhci_plat_hc_driver;
> +	driver->shared_hcd_no_priv = 1;

true?

>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 2ffafbd..03ac312 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -256,6 +256,7 @@ struct hc_driver {
>  	const char	*description;	/* "ehci-hcd" etc */
>  	const char	*product_desc;	/* product/vendor string */
>  	size_t		hcd_priv_size;	/* size of private data */
> +	bool		shared_hcd_no_priv;	/* 0 use priv, 1 not use priv*/

Did you check to see how much extra padding you just added to the
structure?  When writing a change to try to save memory, do not cause
extra memory to be wasted for everyone.

thanks,

greg k-h
