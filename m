Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581A149F7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiA1K5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbiA1K5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:57:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2583EC061714;
        Fri, 28 Jan 2022 02:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C02C261E8E;
        Fri, 28 Jan 2022 10:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB35FC340E0;
        Fri, 28 Jan 2022 10:57:01 +0000 (UTC)
Message-ID: <3f5a10aa-fda8-ea3d-9ca2-eba77c720338@xs4all.nl>
Date:   Fri, 28 Jan 2022 11:57:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv3 4/4] media: imx: Use dedicated format handler for
 i.MX7/8
Content-Language: en-US
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
References: <20211019120047.827915-1-dorota.czaplejewicz@puri.sm>
 <20211019120047.827915-4-dorota.czaplejewicz@puri.sm>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211019120047.827915-4-dorota.czaplejewicz@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dorota,

Since I marked "media: Add 16-bit Bayer formats" as 'Changes Requested', and since
this patch appears to depend on that patch based on a comment in the first patch,
I decided to mark this series as 'Changes Requested' (except for patch 1 which has
already been accepted).

Please post a v4 if you want this in, and add the "media: Add 16-bit Bayer formats"
patch as well to that v4 series.

Thanks!

	Hans

On 19/10/2021 14:14, Dorota Czaplejewicz wrote:
> This splits out a format handler which takes into account
> the capabilities of the i.MX7/8 video device,
> as opposed to the default handler compatible with both i.MX5/6 and i.MX7/8.
> 
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> ---
>  drivers/staging/media/imx/imx-media-utils.c | 56 +++++++++++++++++++--
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index 8b5c6bcfd4fa..1ff7ec4c877a 100644
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
> +				  enum imx_media_device_type type) {
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

