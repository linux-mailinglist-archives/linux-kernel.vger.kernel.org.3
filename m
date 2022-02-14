Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191304B5A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiBNTEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:04:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBNTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:04:20 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D18D6A8;
        Mon, 14 Feb 2022 11:04:01 -0800 (PST)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 812EACD6B9;
        Mon, 14 Feb 2022 18:50:10 +0000 (UTC)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id BF614E0005;
        Mon, 14 Feb 2022 18:49:26 +0000 (UTC)
Date:   Mon, 14 Feb 2022 19:50:35 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] media: imx: Store the type of hardware
 implementation
Message-ID: <20220214185035.uomrdkzth7adkw5c@uno.localdomain>
References: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
 <20220211142752.779952-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211142752.779952-2-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander, Dorota,

On Fri, Feb 11, 2022 at 03:27:44PM +0100, Alexander Stein wrote:
> From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
>
> The driver covers i.MX5/6, as well as i.MX7/8 hardware.
> Those implementations differ, e.g. in the sizes of buffers they accept.
>
> Some functionality should be abstracted, and storing type achieves that.
>
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Switch back to using enum
>
>  drivers/staging/media/imx/imx-ic-prpencvf.c   | 3 ++-
>  drivers/staging/media/imx/imx-media-capture.c | 5 ++++-
>  drivers/staging/media/imx/imx-media-csi.c     | 3 ++-
>  drivers/staging/media/imx/imx-media.h         | 8 +++++++-
>  drivers/staging/media/imx/imx7-media-csi.c    | 3 ++-
>  5 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index 9b81cfbcd777..671bb9a681aa 100644
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@ -1266,7 +1266,8 @@ static int prp_registered(struct v4l2_subdev *sd)
>
>  	priv->vdev = imx_media_capture_device_init(ic_priv->ipu_dev,
>  						   &ic_priv->sd,
> -						   PRPENCVF_SRC_PAD, true);
> +						   PRPENCVF_SRC_PAD, true,
> +						   DEVICE_TYPE_IMX56);
>  	if (IS_ERR(priv->vdev))
>  		return PTR_ERR(priv->vdev);
>
> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
> index 93ba09236010..65dc95a48ecc 100644
> --- a/drivers/staging/media/imx/imx-media-capture.c
> +++ b/drivers/staging/media/imx/imx-media-capture.c
> @@ -34,6 +34,7 @@ struct capture_priv {
>
>  	struct imx_media_video_dev vdev;	/* Video device */
>  	struct media_pad vdev_pad;		/* Video device pad */
> +	enum imx_media_device_type type;	/* Type of hardware implementation */
>
>  	struct v4l2_subdev *src_sd;		/* Source subdev */
>  	int src_sd_pad;				/* Source subdev pad */
> @@ -957,7 +958,8 @@ EXPORT_SYMBOL_GPL(imx_media_capture_device_unregister);
>
>  struct imx_media_video_dev *
>  imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
> -			      int pad, bool legacy_api)
> +			      int pad, bool legacy_api,
> +			      enum imx_media_device_type type)
>  {
>  	struct capture_priv *priv;
>  	struct video_device *vfd;
> @@ -972,6 +974,7 @@ imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
>  	priv->src_sd_pad = pad;
>  	priv->dev = dev;
>  	priv->legacy_api = legacy_api;
> +	priv->type = type;
>
>  	mutex_init(&priv->mutex);
>  	INIT_LIST_HEAD(&priv->ready_q);
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index bd7f156f2d52..d5557bb4913d 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1803,7 +1803,8 @@ static int csi_registered(struct v4l2_subdev *sd)
>  	}
>
>  	priv->vdev = imx_media_capture_device_init(priv->sd.dev, &priv->sd,
> -						   CSI_SRC_PAD_IDMAC, true);
> +						   CSI_SRC_PAD_IDMAC, true,
> +						   DEVICE_TYPE_IMX56);
>  	if (IS_ERR(priv->vdev)) {
>  		ret = PTR_ERR(priv->vdev);
>  		goto free_fim;
> diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
> index f263fc3adbb9..e4c22b3ccd57 100644
> --- a/drivers/staging/media/imx/imx-media.h
> +++ b/drivers/staging/media/imx/imx-media.h
> @@ -96,6 +96,11 @@ enum imx_pixfmt_sel {
>  	PIXFMT_SEL_ANY = PIXFMT_SEL_YUV | PIXFMT_SEL_RGB | PIXFMT_SEL_BAYER,
>  };
>
> +enum imx_media_device_type {
> +	DEVICE_TYPE_IMX56,
> +	DEVICE_TYPE_IMX78,
> +};
> +

Isn't this too coarse as a distinction ?

I tried adding per-soc identifiers here:
https://lore.kernel.org/linux-media/20220214184318.409208-5-jacopo@jmondi.org/T/#u

Maybe they can help ?

>  struct imx_media_buffer {
>  	struct vb2_v4l2_buffer vbuf; /* v4l buffer must be first */
>  	struct list_head  list;
> @@ -282,7 +287,8 @@ int imx_media_ic_unregister(struct v4l2_subdev *sd);
>  /* imx-media-capture.c */
>  struct imx_media_video_dev *
>  imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
> -			      int pad, bool legacy_api);
> +			      int pad, bool legacy_api,
> +			      enum imx_media_device_type type);
>  void imx_media_capture_device_remove(struct imx_media_video_dev *vdev);
>  int imx_media_capture_device_register(struct imx_media_video_dev *vdev,
>  				      u32 link_flags);
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index 32311fc0e2a4..173dd014c2d6 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1039,7 +1039,8 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
>  	}
>
>  	csi->vdev = imx_media_capture_device_init(csi->sd.dev, &csi->sd,
> -						  IMX7_CSI_PAD_SRC, false);
> +						  IMX7_CSI_PAD_SRC, false,
> +						  DEVICE_TYPE_IMX78);
>  	if (IS_ERR(csi->vdev))
>  		return PTR_ERR(csi->vdev);
>
> --
> 2.25.1
>
