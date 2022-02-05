Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E664AA64D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379268AbiBEDls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBEDlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:41:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F44C061346;
        Fri,  4 Feb 2022 19:41:46 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A4A95472;
        Sat,  5 Feb 2022 04:41:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644032504;
        bh=ls9fvq3A45YbaeIEXzVRsHp5ZlyRc/CArttx7bQLOss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+lFttUc02i2HKa3dFdW89YX7EmP/kFCvHo+PIK5VgUMXnVX3UQdqi028ufX0x1px
         A35ALAd3kaby7JGqecwkaBZPizqn29JcTZgPbea+M3tKk0KAPLfUPJ1eOxjOJTlxcE
         HE4vS9iQeCyMTU8E1Ns8uzjPjd9BRDiB2a18/R1k=
Date:   Sat, 5 Feb 2022 05:41:20 +0200
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
Subject: Re: [PATCH 2/8] media: imx: Forward type of hardware implementation
Message-ID: <Yf3x4FnQcBRLHBy8@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
 <20220204121514.2762676-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204121514.2762676-3-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander and Dorota,

Thank you for the patch.

On Fri, Feb 04, 2022 at 01:15:08PM +0100, Alexander Stein wrote:
> From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> 
> Pass down the hardware type so imx_media_mbus_fmt_to_pix_fmt can do
> the actual switch.
> 
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Turning the bool into an enum as mentioned in the review of 1/8,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in comparison to original commit from Dorota:
> * is_imx56 is used instead of enum
> 
>  drivers/staging/media/imx/imx-media-capture.c | 15 +++++++++------
>  drivers/staging/media/imx/imx-media-utils.c   |  3 ++-
>  drivers/staging/media/imx/imx-media.h         |  3 ++-
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
> index b61bf9f8ddf8..8aad6d6d350e 100644
> --- a/drivers/staging/media/imx/imx-media-capture.c
> +++ b/drivers/staging/media/imx/imx-media-capture.c
> @@ -139,7 +139,8 @@ static int capture_g_fmt_vid_cap(struct file *file, void *fh,
>  }
>  
>  static const struct imx_media_pixfmt *
> -__capture_try_fmt(struct v4l2_pix_format *pixfmt, struct v4l2_rect *compose)
> +__capture_try_fmt(struct v4l2_pix_format *pixfmt, struct v4l2_rect *compose,
> +		  bool is_imx56)
>  {
>  	struct v4l2_mbus_framefmt fmt_src;
>  	const struct imx_media_pixfmt *cc;
> @@ -171,7 +172,7 @@ __capture_try_fmt(struct v4l2_pix_format *pixfmt, struct v4l2_rect *compose)
>  	}
>  
>  	v4l2_fill_mbus_format(&fmt_src, pixfmt, 0);
> -	imx_media_mbus_fmt_to_pix_fmt(pixfmt, &fmt_src, cc);
> +	imx_media_mbus_fmt_to_pix_fmt(pixfmt, &fmt_src, cc, is_imx56);
>  
>  	if (compose) {
>  		compose->width = fmt_src.width;
> @@ -184,7 +185,9 @@ __capture_try_fmt(struct v4l2_pix_format *pixfmt, struct v4l2_rect *compose)
>  static int capture_try_fmt_vid_cap(struct file *file, void *fh,
>  				   struct v4l2_format *f)
>  {
> -	__capture_try_fmt(&f->fmt.pix, NULL);
> +	struct capture_priv *priv = video_drvdata(file);
> +
> +	__capture_try_fmt(&f->fmt.pix, NULL, priv->is_imx56);
>  	return 0;
>  }
>  
> @@ -199,7 +202,7 @@ static int capture_s_fmt_vid_cap(struct file *file, void *fh,
>  		return -EBUSY;
>  	}
>  
> -	cc = __capture_try_fmt(&f->fmt.pix, &priv->vdev.compose);
> +	cc = __capture_try_fmt(&f->fmt.pix, &priv->vdev.compose, priv->is_imx56);
>  
>  	priv->vdev.cc = cc;
>  	priv->vdev.fmt = f->fmt.pix;
> @@ -418,7 +421,7 @@ __capture_legacy_try_fmt(struct capture_priv *priv,
>  		}
>  	}
>  
> -	imx_media_mbus_fmt_to_pix_fmt(pixfmt, &fmt_src->format, cc);
> +	imx_media_mbus_fmt_to_pix_fmt(pixfmt, &fmt_src->format, cc, priv->is_imx56);
>  
>  	return cc;
>  }
> @@ -889,7 +892,7 @@ static int capture_init_format(struct capture_priv *priv)
>  		fmt_src.format.height = IMX_MEDIA_DEF_PIX_HEIGHT;
>  	}
>  
> -	imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt, &fmt_src.format, NULL);
> +	imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt, &fmt_src.format, NULL, priv->is_imx56);
>  	vdev->compose.width = fmt_src.format.width;
>  	vdev->compose.height = fmt_src.format.height;
>  
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index 94bc866ca28c..0daa6aad45f4 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -518,7 +518,8 @@ EXPORT_SYMBOL_GPL(imx_media_try_colorimetry);
>  
>  int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
>  				  const struct v4l2_mbus_framefmt *mbus,
> -				  const struct imx_media_pixfmt *cc)
> +				  const struct imx_media_pixfmt *cc,
> +				  bool is_imx56)
>  {
>  	u32 width;
>  	u32 stride;
> diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
> index 73e8e6e0d8e8..2be1bc97955c 100644
> --- a/drivers/staging/media/imx/imx-media.h
> +++ b/drivers/staging/media/imx/imx-media.h
> @@ -198,7 +198,8 @@ void imx_media_try_colorimetry(struct v4l2_mbus_framefmt *tryfmt,
>  			       bool ic_route);
>  int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
>  				  const struct v4l2_mbus_framefmt *mbus,
> -				  const struct imx_media_pixfmt *cc);
> +				  const struct imx_media_pixfmt *cc,
> +				  bool is_imx56);
>  void imx_media_grp_id_to_sd_name(char *sd_name, int sz,
>  				 u32 grp_id, int ipu_id);
>  struct v4l2_subdev *

-- 
Regards,

Laurent Pinchart
