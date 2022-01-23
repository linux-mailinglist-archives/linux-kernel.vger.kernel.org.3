Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE16D49725D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiAWPOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:14:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:41758 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbiAWPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:14:38 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F31325E;
        Sun, 23 Jan 2022 16:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642950876;
        bh=lkw4wzECJEkp+bcOf6Owph+5NdFygheW5oyJvJLm+9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJs6z5rZuKjljr894WFZJf3VEK6nVBmvFdua3x3osLSTgLRuWEY9zOB6OG9gNfmnh
         PtG4PDxffoeCYdEv2diKWIgu13uDQ2CXH6mTSPMdGj6FP5XgsarK+QKP8ExROh9Np3
         nt2MGwMuS/EvVK/SkjV3y1+PlSxYosLmvQ2S4rs8=
Date:   Sun, 23 Jan 2022 17:13:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v6 03/14] media: cadence: csi2rx: Add get_fmt and set_fmt
 pad ops
Message-ID: <Ye1wjLCaALKgni90@pendragon.ideasonboard.com>
References: <20220121142904.4091481-1-p.yadav@ti.com>
 <20220121142904.4091481-4-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121142904.4091481-4-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Fri, Jan 21, 2022 at 07:58:53PM +0530, Pratyush Yadav wrote:
> The format is needed to calculate the link speed for the external DPHY
> configuration. It is not right to query the format from the source
> subdev. Add get_fmt and set_fmt pad operations so that the format can be
> configured and correct bpp be selected.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v6:
> - Move the lock around the dereference for framefmt in
>   csi2rx_{get,set}_fmt() instead of when we get the pointer.
> - Do not return an error when an unsupported format is set. Instead
>   adjust the code to the first format in the list.
> - Not adding Laurent's R-by since I am making changes in
>   csi2rx_set_fmt() that he didn't explicitly recommend.
> 
> Changes in v5:
> - Use YUV 1X16 formats instead of 2X8.
> - New in v5.
> 
>  drivers/media/platform/cadence/cdns-csi2rx.c | 131 +++++++++++++++++++
>  1 file changed, 131 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 2547903f2e8e..ae3ebdb3890d 100644
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
> @@ -236,12 +272,103 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
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
> +	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
> +					 format->which);
> +	if (!framefmt)
> +		return -EINVAL;
> +
> +	mutex_lock(&csi2rx->lock);
> +	format->format = *framefmt;
> +	mutex_unlock(&csi2rx->lock);
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
> +
> +	/* No transcoding, source and sink formats must match. */
> +	if (format->pad != CSI2RX_PAD_SINK)
> +		return csi2rx_get_fmt(subdev, state, format);
> +
> +	if (!csi2rx_get_fmt_by_code(format->format.code))
> +		format->format.code = formats[0].code;
> +
> +	format->format.field = V4L2_FIELD_NONE;
> +
> +	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
> +					 format->which);
> +	if (!framefmt)
> +		return -EINVAL;
> +
> +	mutex_lock(&csi2rx->lock);
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
> @@ -457,6 +584,10 @@ static int csi2rx_probe(struct platform_device *pdev)
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
