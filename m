Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18E84AA65F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 05:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379304AbiBEEFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 23:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBEEFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 23:05:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE2C061346;
        Fri,  4 Feb 2022 20:05:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D293C472;
        Sat,  5 Feb 2022 05:05:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644033915;
        bh=tp0ooT8eHqu9E2DtNBcIlUfXtbZ3KceXo0xZSMsl9AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYoE8dELkqa/Gtxz9uFwJGgxHBEp+AxTQ1z0PlcHunb8XFc8YTfq4aYzS9YzeaPoi
         GewPRH8eOM/QufB1M5RP+BsN1iP5pOTotD8WZ8B1ff5CiHcG/y2+FKAMfrnc8maDJE
         6EAcZabvaPmjb53da+YdklLHTynjxS7cs33w7ZwM=
Date:   Sat, 5 Feb 2022 06:04:50 +0200
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
Subject: Re: [PATCH 3/8] media: imx: Use dedicated format handler for i.MX7/8
Message-ID: <Yf33YviITGDnolHw@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
 <20220204121514.2762676-4-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204121514.2762676-4-alexander.stein@ew.tq-group.com>
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

On Fri, Feb 04, 2022 at 01:15:09PM +0100, Alexander Stein wrote:
> From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> 
> This splits out a format handler which takes into account
> the capabilities of the i.MX7/8 video device,
> as opposed to the default handler compatible with both i.MX5/6 and i.MX7/8.
> 
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in comparison to original commit from Dorota:
> * is_imx56 is used instead of enum
> 
>  drivers/staging/media/imx/imx-media-utils.c | 56 +++++++++++++++++++--
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index 0daa6aad45f4..32aaa2e81bea 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -516,10 +516,9 @@ void imx_media_try_colorimetry(struct v4l2_mbus_framefmt *tryfmt,
>  }
>  EXPORT_SYMBOL_GPL(imx_media_try_colorimetry);
>  
> -int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> -				  const struct v4l2_mbus_framefmt *mbus,
> -				  const struct imx_media_pixfmt *cc,
> -				  bool is_imx56)
> +static int imx56_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> +					   const struct v4l2_mbus_framefmt *mbus,
> +					   const struct imx_media_pixfmt *cc)
>  {
>  	u32 width;
>  	u32 stride;
> @@ -568,6 +567,55 @@ int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
>  
>  	return 0;
>  }
> +
> +static int imx78_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> +					   const struct v4l2_mbus_framefmt *mbus,
> +					   const struct imx_media_pixfmt *cc)
> +{
> +	int ret;
> +
> +	if (!cc)
> +		cc = imx_media_find_mbus_format(mbus->code, PIXFMT_SEL_ANY);
> +
> +	if (!cc)
> +		return -EINVAL;
> +	/*
> +	 * The hardware can handle line lengths divisible by 4 pixels
> +	 * as long as the whole buffer size ends up divisible by 8 bytes.
> +	 * If not, use the value of 8 pixels recommended in the datasheet.
> +	 */
> +	ret = v4l2_fill_pixfmt(pix, cc->fourcc,
> +			       round_up(mbus->width, 4), mbus->height);
> +	if (ret)
> +		return ret;
> +
> +	/* Only 8bits-per-pixel formats may need to get aligned to 8 pixels,
> +	 * because both 10-bit and 16-bit pixels occupy 2 bytes.
> +	 * In those, 4-pixel aligmnent is equal to 8-byte alignment.
> +	 */
> +	if (pix->sizeimage % 8 != 0)
> +		ret = v4l2_fill_pixfmt(pix, cc->fourcc,
> +				       round_up(mbus->width, 8), mbus->height);

I think you could simplify this by using cc->bpp to figure out the
alignment instead of calling v4l2_fill_pixfmt() twice.

> +
> +	pix->colorspace = mbus->colorspace;
> +	pix->xfer_func = mbus->xfer_func;
> +	pix->ycbcr_enc = mbus->ycbcr_enc;
> +	pix->quantization = mbus->quantization;
> +	pix->field = mbus->field;

Should v4l2_fill_pixfmt() be updated to handle colorspace and field too
instead of doing it manually here ?

> +
> +	return ret;
> +}
> +
> +int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> +				  const struct v4l2_mbus_framefmt *mbus,
> +				  const struct imx_media_pixfmt *cc,
> +				  bool is_imx56)
> +{
> +	if (is_imx56)
> +		return imx56_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
> +	else
> +		return imx78_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
> +}
>  EXPORT_SYMBOL_GPL(imx_media_mbus_fmt_to_pix_fmt);
>  
>  void imx_media_free_dma_buf(struct device *dev,

-- 
Regards,

Laurent Pinchart
