Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB75B47772E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbhLPQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:10:14 -0500
Received: from netrider.rowland.org ([192.131.102.5]:35205 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S239032AbhLPQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:10:11 -0500
Received: (qmail 819159 invoked by uid 1000); 16 Dec 2021 11:10:10 -0500
Date:   Thu, 16 Dec 2021 11:10:10 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: uhci: Use platform_get_irq() to get the interrupt
Message-ID: <Ybtk4qqN2NYQSZKP@rowland.harvard.edu>
References: <20211215225203.1991003-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215225203.1991003-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 04:52:03PM -0600, Rob Herring wrote:
> Accessing platform device resources directly has long been deprecated for
> DT as IRQ resources may not be available at device creation time. Drivers
> continuing to use static IRQ resources is blocking removing the static setup
> from the DT core code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/uhci-platform.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index 70dbd95c3f06..b854699e9e4e 100644
> --- a/drivers/usb/host/uhci-platform.c
> +++ b/drivers/usb/host/uhci-platform.c
> @@ -132,7 +132,11 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
>  		goto err_rmr;
>  	}
>  
> -	ret = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_SHARED);
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		goto err_clk;
> +
> +	ret = usb_add_hcd(hcd, ret, IRQF_SHARED);
>  	if (ret)
>  		goto err_clk;
>  
> -- 
> 2.32.0
> 
