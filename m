Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6609F48196B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhL3ErK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:47:10 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45560 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhL3ErI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:47:08 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C802D2A5;
        Thu, 30 Dec 2021 05:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640839627;
        bh=G15gZW905KB243ho6yQhK1kDfRd85eBmtfZLhHsHCgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJztqi+xnek8fpdvPMxqTz6djSuCaRXg5AXhkb92AmgAxZGk2ohS32tQmjiu/Oxob
         c5Vd9LIwRa9kVxpiKfq8mgLpZQrtTKStHcHoxHZUnCSHLRapjdA/Tcgc/mtzmGK7GA
         p77dwRhzeCXxSzfkzhix/zxIshruzAT/PB4IC+h0=
Date:   Thu, 30 Dec 2021 06:47:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 09/14] media: cadence: csi2rx: Add link validation
Message-ID: <Yc05yD/P/UQlSG8B@pendragon.ideasonboard.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
 <20211223191615.17803-10-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223191615.17803-10-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Fri, Dec 24, 2021 at 12:46:10AM +0530, Pratyush Yadav wrote:
> Add media link validation to make sure incorrectly configured pipelines
> are caught. Since there is no support for transcoding, rely on the
> default link validation function to make sure formats across source and
> sink pads are the same.

I think the commit message is a bit misleading. The default link
validation function ensures that formats on the source and sink sides of
a link match. It doesn't compare the formats on the sink and source pads
of the subdev. Whether the subdev can transcode or not is thus not
relevant here.

> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v5:
> - New in v5.
> 
>  drivers/media/platform/cadence/cdns-csi2rx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 53659776a906..119c7540c75a 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -492,6 +492,10 @@ static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
>  	.pad		= &csi2rx_pad_ops,
>  };
>  
> +static struct media_entity_operations csi2rx_media_ops = {

static const

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	.link_validate = v4l2_subdev_link_validate,
> +};
> +
>  static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
>  			      struct v4l2_subdev *s_subdev,
>  			      struct v4l2_async_subdev *asd)
> @@ -691,6 +695,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
>  		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
>  	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +	csi2rx->subdev.entity.ops = &csi2rx_media_ops;
>  
>  	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
>  				     csi2rx->pads);

-- 
Regards,

Laurent Pinchart
