Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9024AA642
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379232AbiBEDcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:32:06 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53438 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379226AbiBEDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:32:02 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 13910472;
        Sat,  5 Feb 2022 04:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644031921;
        bh=SrkGQlf2EU1eLY/+UA1XooxeJOZ8W6H/0uZw7v2rA08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axBERtk2GYLbaU4jANuPSUKctb5hTkxD98/2XceNnmb/zbr06saHj5alzjf+Joqy6
         pNLwUxWLjDJcfukkBn9wmULjjs53WTD3QVJSd1SjAOWqtHkhGyCSaS+Q0iaa0SFnCs
         s/ITgEM1a7aEFCvDGoYkqPuhrjMgCe80JBhZ1tpk=
Date:   Sat, 5 Feb 2022 05:31:36 +0200
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
Subject: Re: [PATCH 7/8] media: imx: utils: Add more Bayer formats
Message-ID: <Yf3vmMP6EfjyeXOb@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
 <20220204121514.2762676-8-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204121514.2762676-8-alexander.stein@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Thank you for the patch.

On Fri, Feb 04, 2022 at 01:15:13PM +0100, Alexander Stein wrote:
> Without this the ioctl VIDIOC_ENUM_FMT will not list the 10/12/14-Bit
> Bayer formats. This in return results in
> "v4l2-ctl --set-fmt-video pixelformat='RG10'" failing to set the
> pixelformat as it is not enumerated as supported format.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Do IPUv3-based SoCs support 10-, 12- and 14-bit formats ? If so,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> This adds the following formats to `v4l2-ctl --list-formats`
> [...]
>         [18]: 'BG10' (10-bit Bayer BGBG/GRGR)
>         [19]: 'GB10' (10-bit Bayer GBGB/RGRG)
>         [20]: 'BA10' (10-bit Bayer GRGR/BGBG)
>         [21]: 'RG10' (10-bit Bayer RGRG/GBGB)
>         [22]: 'BG12' (12-bit Bayer BGBG/GRGR)
>         [23]: 'GB12' (12-bit Bayer GBGB/RGRG)
>         [24]: 'BA12' (12-bit Bayer GRGR/BGBG)
>         [25]: 'RG12' (12-bit Bayer RGRG/GBGB)
>         [26]: 'BG14' (14-bit Bayer BGBG/GRGR)
>         [27]: 'GB14' (14-bit Bayer GBGB/RGRG)
>         [28]: 'GR14' (14-bit Bayer GRGR/BGBG)
>         [29]: 'RG14' (14-bit Bayer RGRG/GBGB)
> [...]
> 
>  drivers/staging/media/imx/imx-media-utils.c | 72 +++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index e0a256a08c3b..ea56c82d3b32 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -130,6 +130,78 @@ static const struct imx_media_pixfmt pixel_formats[] = {
>  		.cs     = IPUV3_COLORSPACE_RGB,
>  		.bpp    = 8,
>  		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SBGGR10,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR10_1X10),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 10,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGBRG10,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG10_1X10),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 10,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGRBG10,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG10_1X10),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 10,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SRGGB10,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB10_1X10),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 10,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SBGGR12,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR12_1X12),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 12,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGBRG12,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG12_1X12),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 12,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGRBG12,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG12_1X12),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 12,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SRGGB12,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB12_1X12),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 12,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SBGGR14,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR14_1X14),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 14,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGBRG14,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG14_1X14),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 14,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGRBG14,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG14_1X14),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 14,
> +		.bayer  = true,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SRGGB14,
> +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB14_1X14),
> +		.cs     = IPUV3_COLORSPACE_RGB,
> +		.bpp    = 14,
> +		.bayer  = true,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_SBGGR16,
>  		.codes  = IMX_BUS_FMTS(

-- 
Regards,

Laurent Pinchart
