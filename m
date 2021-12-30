Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1017D481951
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhL3Ecd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhL3Ecc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:32:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED396C061574;
        Wed, 29 Dec 2021 20:32:31 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B8A92A5;
        Thu, 30 Dec 2021 05:32:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640838748;
        bh=ftELy5VE4M+euGWWVqK7kPuZCvGLyOJ/DIvEWHDtzv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzzkoXQ51GKSOV2jc6I/NLya76ek2Cg/W/d8iTENgxTpHgltVd6HwES6XpwsZZLKO
         8o+QiBror+8PJ3XoSP5HzoOJHorE2LSlExcuzMBkafWvZNkO26vkOZVdS5s3CZ1FfT
         A8mxl0LOuDDRKAEx3ngk9SSNo26jSqrv4NqZTiTA=
Date:   Thu, 30 Dec 2021 06:32:26 +0200
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
Subject: Re: [PATCH v5 03/14] media: cadence: csi2rx: Add get_fmt and set_fmt
 pad ops
Message-ID: <Yc02WlMLA+mafKDo@pendragon.ideasonboard.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
 <20211223191615.17803-4-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223191615.17803-4-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Fri, Dec 24, 2021 at 12:46:04AM +0530, Pratyush Yadav wrote:
> The format is needed to calculate the link speed for the external DPHY
> configuration. It is not right to query the format from the source
> subdev. Add get_fmt and set_fmt pad operations so that the format can be
> configured and correct bpp be selected.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v5:
> - Use YUV 1X16 formats instead of 2X8.
> - New in v5.
> 
>  drivers/media/platform/cadence/cdns-csi2rx.c | 137 +++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 2547903f2e8e..4a2a5a9d019b 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -54,6 +54,11 @@ enum csi2rx_pads {
>  	CSI2RX_PAD_MAX,
>  };
>  
> +struct csi2rx_fmt {
> +	u32				code;
> +	u8				bpp;
> +};
> +
>  struct csi2rx_priv {
>  	struct device			*dev;
>  	unsigned int			count;
> @@ -79,12 +84,43 @@ struct csi2rx_priv {
>  	struct v4l2_subdev		subdev;
>  	struct v4l2_async_notifier	notifier;
>  	struct media_pad		pads[CSI2RX_PAD_MAX];
> +	struct v4l2_mbus_framefmt	fmt;
>  
>  	/* Remote source */
>  	struct v4l2_subdev		*source_subdev;
>  	int				source_pad;
>  };
>  
> +static const struct csi2rx_fmt formats[] = {
> +	{
> +		.code	= MEDIA_BUS_FMT_YUYV8_1X16,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_UYVY8_1X16,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_YVYU8_1X16,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_VYUY8_1X16,
> +		.bpp	= 16,
> +	},
> +};

bpp isn't used. Unless you need it in a subsequent patch in the series,
you can turn the formats array into a u32 array.

> +
> +static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(formats); i++)
> +		if (formats[i].code == code)
> +			return &formats[i];
> +
> +	return NULL;
> +}
> +
>  static inline
>  struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
>  {
> @@ -236,12 +272,109 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
>  	return ret;
>  }
>  
> +static struct v4l2_mbus_framefmt *
> +csi2rx_get_pad_format(struct csi2rx_priv *csi2rx,
> +		      struct v4l2_subdev_state *state,
> +		      unsigned int pad, u32 which)
> +{
> +	switch (which) {
> +	case V4L2_SUBDEV_FORMAT_TRY:
> +		return v4l2_subdev_get_try_format(&csi2rx->subdev, state, pad);
> +	case V4L2_SUBDEV_FORMAT_ACTIVE:
> +		return &csi2rx->fmt;
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static int csi2rx_get_fmt(struct v4l2_subdev *subdev,
> +			  struct v4l2_subdev_state *state,
> +			  struct v4l2_subdev_format *format)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +	struct v4l2_mbus_framefmt *framefmt;
> +
> +	mutex_lock(&csi2rx->lock);
> +
> +	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
> +					 format->which);
> +	mutex_unlock(&csi2rx->lock);
> +
> +	if (!framefmt)
> +		return -EINVAL;

This can't happen, you can drop the check.

> +
> +	format->format = *framefmt;

This is the assignment that needs to be protected by the lock.
csi2rx_get_pad_format() returns a pointer to the storage, it doesn't
modify it.

	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
					 format->which);

	mutex_lock(&csi2rx->lock);
	format->format = *framefmt;
	mutex_unlock(&csi2rx->lock);

Same comments for csi2rx_set_fmt().

> +
> +	return 0;
> +}
> +
> +static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
> +			  struct v4l2_subdev_state *state,
> +			  struct v4l2_subdev_format *format)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +	struct v4l2_mbus_framefmt *framefmt;
> +	const struct csi2rx_fmt *fmt;
> +
> +	/* No transcoding, source and sink formats must match. */
> +	if (format->pad != CSI2RX_PAD_SINK)
> +		return csi2rx_get_fmt(subdev, state, format);
> +
> +	fmt = csi2rx_get_fmt_by_code(format->format.code);
> +	if (!fmt)
> +		return -EOPNOTSUPP;

This should not return an error, but instead adjust the code:

	if (!csi2rx_get_fmt_by_code(format->format.code))
		format->format.code = formats[0].code;

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
> +	format->format.field = V4L2_FIELD_NONE;
> +
> +	mutex_lock(&csi2rx->lock);
> +	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
> +					 format->which);
> +	if (!framefmt) {
> +		mutex_unlock(&csi2rx->lock);
> +		return -EINVAL;
> +	}
> +
> +	*framefmt = format->format;
> +	mutex_unlock(&csi2rx->lock);
> +
> +	return 0;
> +}
> +
> +static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
> +			   struct v4l2_subdev_state *state)
> +{
> +	struct v4l2_subdev_format format = {
> +		.which = state ? V4L2_SUBDEV_FORMAT_TRY
> +			: V4L2_SUBDEV_FORMAT_ACTIVE,
> +		.pad = CSI2RX_PAD_SINK,
> +		.format = {
> +			.width = 640,
> +			.height = 480,
> +			.code = MEDIA_BUS_FMT_UYVY8_1X16,
> +			.field = V4L2_FIELD_NONE,
> +			.colorspace = V4L2_COLORSPACE_SRGB,
> +			.ycbcr_enc = V4L2_YCBCR_ENC_601,
> +			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
> +			.xfer_func = V4L2_XFER_FUNC_SRGB,
> +		},
> +	};
> +
> +	return csi2rx_set_fmt(subdev, state, &format);
> +}
> +
> +static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
> +	.get_fmt	= csi2rx_get_fmt,
> +	.set_fmt	= csi2rx_set_fmt,
> +	.init_cfg	= csi2rx_init_cfg,
> +};
> +
>  static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
>  	.s_stream	= csi2rx_s_stream,
>  };
>  
>  static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
>  	.video		= &csi2rx_video_ops,
> +	.pad		= &csi2rx_pad_ops,
>  };
>  
>  static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
> @@ -457,6 +590,10 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_cleanup;
>  
> +	ret = csi2rx_init_cfg(&csi2rx->subdev, NULL);
> +	if (ret)
> +		goto err_cleanup;
> +
>  	ret = v4l2_async_register_subdev(&csi2rx->subdev);
>  	if (ret < 0)
>  		goto err_cleanup;

-- 
Regards,

Laurent Pinchart
