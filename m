Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701534B5A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiBNTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:04:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiBNTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:04:21 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE528D6B0;
        Mon, 14 Feb 2022 11:04:02 -0800 (PST)
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id D60B6CECFF;
        Mon, 14 Feb 2022 18:51:33 +0000 (UTC)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id F3FA21C0006;
        Mon, 14 Feb 2022 18:50:06 +0000 (UTC)
Date:   Mon, 14 Feb 2022 19:51:15 +0100
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
Subject: Re: [PATCH v2 3/9] media: imx: Use dedicated format handler for
 i.MX7/8
Message-ID: <20220214185115.y3rdxyvi7dmupeye@uno.localdomain>
References: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
 <20220211142752.779952-4-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211142752.779952-4-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Fri, Feb 11, 2022 at 03:27:46PM +0100, Alexander Stein wrote:
> From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
>
> This splits out a format handler which takes into account
> the capabilities of the i.MX7/8 video device,
> as opposed to the default handler compatible with both i.MX5/6 and i.MX7/8.
>
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Switch back to using enum
> * Get rid of an additional call to v4l2_fill_pixfmt()
>
>  drivers/staging/media/imx/imx-media-utils.c | 60 +++++++++++++++++++--
>  1 file changed, 56 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index c42f3da8e3a8..02a4cb124d37 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -516,10 +516,9 @@ void imx_media_try_colorimetry(struct v4l2_mbus_framefmt *tryfmt,
>  }
>  EXPORT_SYMBOL_GPL(imx_media_try_colorimetry);
>
> -int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> -				  const struct v4l2_mbus_framefmt *mbus,
> -				  const struct imx_media_pixfmt *cc,
> -				  enum imx_media_device_type type)
> +static int imx56_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> +					   const struct v4l2_mbus_framefmt *mbus,
> +					   const struct imx_media_pixfmt *cc)
>  {
>  	u32 width;
>  	u32 stride;
> @@ -568,6 +567,59 @@ int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
>
>  	return 0;
>  }
> +
> +static int imx78_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> +					   const struct v4l2_mbus_framefmt *mbus,
> +					   const struct imx_media_pixfmt *cc)
> +{
> +	u32 aligned_width;
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
> +	 * Only 8bits-per-pixel formats may need to get aligned to 8 pixels,
> +	 * because both 10-bit and 16-bit pixels occupy 2 bytes.
> +	 * In those, 4-pixel aligmnent is equal to 8-byte alignment.
> +	 */
> +	if (cc->bpp == 1)

Am I mistaken or in the format enumeration bpp is expressed in bits
and not bytes ?

Thanks
  j

> +		aligned_width = round_up(mbus->width, 8);
> +	else
> +		aligned_width = round_up(mbus->width, 4);
> +
> +	ret = v4l2_fill_pixfmt(pix, cc->fourcc,
> +			       aligned_width, mbus->height);
> +	if (ret)
> +		return ret;
> +
> +	pix->colorspace = mbus->colorspace;
> +	pix->xfer_func = mbus->xfer_func;
> +	pix->ycbcr_enc = mbus->ycbcr_enc;
> +	pix->quantization = mbus->quantization;
> +	pix->field = mbus->field;
> +
> +	return ret;
> +}
> +
> +int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> +				  const struct v4l2_mbus_framefmt *mbus,
> +				  const struct imx_media_pixfmt *cc,
> +				  enum imx_media_device_type type)
> +{
> +	switch (type) {
> +	case DEVICE_TYPE_IMX56:
> +		return imx56_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
> +	case DEVICE_TYPE_IMX78:
> +		return imx78_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
> +	}
> +	return -EINVAL;
> +}
>  EXPORT_SYMBOL_GPL(imx_media_mbus_fmt_to_pix_fmt);
>
>  void imx_media_free_dma_buf(struct device *dev,
> --
> 2.25.1
>
