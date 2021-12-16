Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33844477733
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhLPQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:10:37 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33851 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S238883AbhLPQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:10:37 -0500
Received: (qmail 819193 invoked by uid 1000); 16 Dec 2021 11:10:36 -0500
Date:   Thu, 16 Dec 2021 11:10:36 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-s3c2410: Use platform_get_irq() to get the
 interrupt
Message-ID: <Ybtk/KaLV6h+U9h5@rowland.harvard.edu>
References: <20211215225358.1993774-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215225358.1993774-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 04:53:57PM -0600, Rob Herring wrote:
> Accessing platform device resources directly has long been deprecated for
> DT as IRQ resources may not be available at device creation time. Drivers
> relying on the static IRQ resources is blocking removing the static setup
> from the DT core code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-s3c2410.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
> index 1bec9b585e2d..12264c048601 100644
> --- a/drivers/usb/host/ohci-s3c2410.c
> +++ b/drivers/usb/host/ohci-s3c2410.c
> @@ -356,7 +356,7 @@ static int ohci_hcd_s3c2410_probe(struct platform_device *dev)
>  {
>  	struct usb_hcd *hcd = NULL;
>  	struct s3c2410_hcd_info *info = dev_get_platdata(&dev->dev);
> -	int retval;
> +	int retval, irq;
>  
>  	s3c2410_usb_set_power(info, 1, 1);
>  	s3c2410_usb_set_power(info, 2, 1);
> @@ -388,9 +388,15 @@ static int ohci_hcd_s3c2410_probe(struct platform_device *dev)
>  		goto err_put;
>  	}
>  
> +	irq = platform_get_irq(dev, 0);
> +	if (irq < 0) {
> +		retval = irq;
> +		goto err_put;
> +	}
> +
>  	s3c2410_start_hc(dev, hcd);
>  
> -	retval = usb_add_hcd(hcd, dev->resource[1].start, 0);
> +	retval = usb_add_hcd(hcd, irq, 0);
>  	if (retval != 0)
>  		goto err_ioremap;
>  
> -- 
> 2.32.0
> 
