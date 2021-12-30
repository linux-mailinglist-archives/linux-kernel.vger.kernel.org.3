Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1E4817D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 01:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhL3AGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 19:06:35 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38768 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhL3AGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 19:06:34 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 13AE22A5;
        Thu, 30 Dec 2021 01:06:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640822792;
        bh=n+Hc7buMoMiLKM4WVjrny3p/9Yk7YkkYUCSeukrrnBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmigCNdlYBBKH8ySeTpw2NlyFI9KW9x+1y1+07lj59pI03ottikanvpF9ZFzqNpn5
         oD+EJUq6kMiZUNLVsdyclhRrSlOkbTLCbGyEYLI9pZyRG5eUOqtJ9No9IZ9gv0XauQ
         gxvfPw+seiboYf3CmBTYz9AJwrMLfsaJoMM3GDMA=
Date:   Thu, 30 Dec 2021 02:06:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-media@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 01/13] media: vsp1: Use platform_get_irq() to get the
 interrupt
Message-ID: <Ycz4Ba5P1Srx3ALv@pendragon.ideasonboard.com>
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223173015.22251-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Thu, Dec 23, 2021 at 05:30:02PM +0000, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Will you get this merged with the whole series, or should I take it in
my tree ?

> ---
>  drivers/media/platform/vsp1/vsp1_drv.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
> index c9044785b903..bbba91a65a0f 100644
> --- a/drivers/media/platform/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/vsp1/vsp1_drv.c
> @@ -794,7 +794,6 @@ static int vsp1_probe(struct platform_device *pdev)
>  {
>  	struct vsp1_device *vsp1;
>  	struct device_node *fcp_node;
> -	struct resource *irq;
>  	unsigned int i;
>  	int ret;
>  
> @@ -813,14 +812,12 @@ static int vsp1_probe(struct platform_device *pdev)
>  	if (IS_ERR(vsp1->mmio))
>  		return PTR_ERR(vsp1->mmio);
>  
> -	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!irq) {
> -		dev_err(&pdev->dev, "missing IRQ\n");
> -		return -EINVAL;
> -	}
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;

I'd use an int irq local variable, but it doesn't matter much. Up to
you.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
> -	ret = devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
> -			      IRQF_SHARED, dev_name(&pdev->dev), vsp1);
> +	ret = devm_request_irq(&pdev->dev, ret, vsp1_irq_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), vsp1);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>  		return ret;

-- 
Regards,

Laurent Pinchart
