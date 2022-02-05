Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616444AA62E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379163AbiBEDWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiBEDWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:22:02 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E6C061346;
        Fri,  4 Feb 2022 19:22:00 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C886739;
        Sat,  5 Feb 2022 04:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644031319;
        bh=zVny9yGSTZmROfuUbpm0pCNnZE6zuIUDaAikHYurkBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbOV0NsxkY1YnEtBUQlModnzykQoMgkI2ALPtD86Ugk2K9P9JlAjY7QEyH9MbVeog
         +RURMhGDRBVldc8uylDPSDWSP8zxARosbuqcu/i8dZ3oHtWgWiYzrfQA0vbtCisI34
         0PvoHSskk+mXpmKddCNUpRHQibdytmiiR75DU74w=
Date:   Sat, 5 Feb 2022 05:21:34 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] media: imx: Store the type of hardware implementation
Message-ID: <Yf3tPuwbyz5UU6eC@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
 <20220204121514.2762676-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204121514.2762676-2-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander and Dorota,

On Fri, Feb 04, 2022 at 01:15:07PM +0100, Alexander Stein wrote:
> From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> 
> The driver covers i.MX5/6, as well as i.MX7/8 hardware.
> Those implementations differ, e.g. in the sizes of buffers they accept.
> 
> Some functionality should be abstracted, and storing type achieves that.

I think that longer term (which ideally shouldn't be too far in the
future) we should decouple the i.MX5/6 and i.MX7/8 drivers (this naming
is actually not quite correct, there are i.MX6 SoCs that have a CSI
bridge, not an IPUv3). The platforms are completely different at the
hardware level, they shouldn't share the same code. That would allow us
to evolve the CSI bridge driver independently from the IPUv3 driver, and
move it from staging to drivers/media/.

I'm not against merging this if it can help short term, but please also
feel free to start decoupling the drivers, even if it results in some
duplicated code.

> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in comparison to original commit from Dorota:
> * Applied the suggestion from Hans at [1].
> 
> [1] https://patchwork.linuxtv.org/project/linux-media/patch/20211104113631.206899-2-dorota.czaplejewicz@puri.sm/
> 
>  drivers/staging/media/imx/imx-ic-prpencvf.c   | 3 ++-
>  drivers/staging/media/imx/imx-media-capture.c | 5 ++++-
>  drivers/staging/media/imx/imx-media-csi.c     | 3 ++-
>  drivers/staging/media/imx/imx-media.h         | 3 ++-
>  drivers/staging/media/imx/imx7-media-csi.c    | 3 ++-
>  5 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index 9b81cfbcd777..caaaac1a515a 100644
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@ -1266,7 +1266,8 @@ static int prp_registered(struct v4l2_subdev *sd)
>  
>  	priv->vdev = imx_media_capture_device_init(ic_priv->ipu_dev,
>  						   &ic_priv->sd,
> -						   PRPENCVF_SRC_PAD, true);
> +						   PRPENCVF_SRC_PAD, true,
> +						   true);
>  	if (IS_ERR(priv->vdev))
>  		return PTR_ERR(priv->vdev);
>  
> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
> index 93ba09236010..b61bf9f8ddf8 100644
> --- a/drivers/staging/media/imx/imx-media-capture.c
> +++ b/drivers/staging/media/imx/imx-media-capture.c
> @@ -47,6 +47,7 @@ struct capture_priv {
>  	struct v4l2_ctrl_handler ctrl_hdlr;	/* Controls inherited from subdevs */
>  
>  	bool legacy_api;			/* Use the legacy (pre-MC) API */
> +	bool is_imx56;				/* Hardware is i.MX5/i.MX6 */

Can we create an enum type instead, to make the code more explicit ?

>  };
>  
>  #define to_capture_priv(v) container_of(v, struct capture_priv, vdev)
> @@ -957,7 +958,8 @@ EXPORT_SYMBOL_GPL(imx_media_capture_device_unregister);
>  
>  struct imx_media_video_dev *
>  imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
> -			      int pad, bool legacy_api)
> +			      int pad, bool legacy_api,
> +			      bool is_imx56)
>  {
>  	struct capture_priv *priv;
>  	struct video_device *vfd;
> @@ -972,6 +974,7 @@ imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
>  	priv->src_sd_pad = pad;
>  	priv->dev = dev;
>  	priv->legacy_api = legacy_api;
> +	priv->is_imx56 = is_imx56;
>  
>  	mutex_init(&priv->mutex);
>  	INIT_LIST_HEAD(&priv->ready_q);
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index bd7f156f2d52..c8f6add00dbb 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1803,7 +1803,8 @@ static int csi_registered(struct v4l2_subdev *sd)
>  	}
>  
>  	priv->vdev = imx_media_capture_device_init(priv->sd.dev, &priv->sd,
> -						   CSI_SRC_PAD_IDMAC, true);
> +						   CSI_SRC_PAD_IDMAC, true,
> +						   true);
>  	if (IS_ERR(priv->vdev)) {
>  		ret = PTR_ERR(priv->vdev);
>  		goto free_fim;
> diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
> index f263fc3adbb9..73e8e6e0d8e8 100644
> --- a/drivers/staging/media/imx/imx-media.h
> +++ b/drivers/staging/media/imx/imx-media.h
> @@ -282,7 +282,8 @@ int imx_media_ic_unregister(struct v4l2_subdev *sd);
>  /* imx-media-capture.c */
>  struct imx_media_video_dev *
>  imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
> -			      int pad, bool legacy_api);
> +			      int pad, bool legacy_api,
> +			      bool is_imx56);
>  void imx_media_capture_device_remove(struct imx_media_video_dev *vdev);
>  int imx_media_capture_device_register(struct imx_media_video_dev *vdev,
>  				      u32 link_flags);
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index 32311fc0e2a4..158d2a736c6d 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1039,7 +1039,8 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
>  	}
>  
>  	csi->vdev = imx_media_capture_device_init(csi->sd.dev, &csi->sd,
> -						  IMX7_CSI_PAD_SRC, false);
> +						  IMX7_CSI_PAD_SRC, false,
> +						  false);
>  	if (IS_ERR(csi->vdev))
>  		return PTR_ERR(csi->vdev);
>  

-- 
Regards,

Laurent Pinchart
