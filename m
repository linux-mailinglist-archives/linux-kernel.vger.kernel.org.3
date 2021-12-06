Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE23346A188
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352972AbhLFQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:41:07 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49965 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351075AbhLFQk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:40:56 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 28A101BF209;
        Mon,  6 Dec 2021 16:37:22 +0000 (UTC)
Date:   Mon, 6 Dec 2021 17:38:15 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 12/25] media: atmel: atmel-isc-base: fix bytesperline
 value for planar formats
Message-ID: <20211206163815.wq5tq3fcsqkj2etk@uno.localdomain>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-13-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112142509.2230884-13-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Fri, Nov 12, 2021 at 04:24:56PM +0200, Eugen Hristev wrote:
> The bytesperline field of the pixfmt should be only for the first plane
> in case of planar formats like YUV420 or YUV422.
> The bytesperline is used by the driver to compute the framesize.
> We have to report a different bpp (bytes per pixel) to v4l2 in bytesperline
> than the actual bpp.
> For example for YUV420, the real bpp is 12, but the first plane has only
> 8 bpp. Thus we report a bytesperline 8*width instead of 12*width.
> However, for real framezise we have to compute 12*width*height.
> Hence added a new variable to hold this information and to correctly
> compute the frame size.

Using single planar API for multiplanar format is really painful :(

>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/media/platform/atmel/atmel-isc-base.c | 19 +++++++++++++++++--
>  drivers/media/platform/atmel/atmel-isc.h      |  4 ++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index 2cb8446ff90c..d0542b97a391 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -654,6 +654,7 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED8;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 8;
> +		isc->try_config.bpp_v4l2 = 8;
>  		break;
>  	case V4L2_PIX_FMT_SBGGR10:
>  	case V4L2_PIX_FMT_SGBRG10:
> @@ -663,6 +664,7 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	case V4L2_PIX_FMT_SBGGR12:
>  	case V4L2_PIX_FMT_SGBRG12:
> @@ -672,24 +674,28 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	case V4L2_PIX_FMT_RGB565:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_RGB565;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	case V4L2_PIX_FMT_ARGB444:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_ARGB444;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	case V4L2_PIX_FMT_ARGB555:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_ARGB555;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	case V4L2_PIX_FMT_ABGR32:
>  	case V4L2_PIX_FMT_XBGR32:
> @@ -697,42 +703,49 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 32;
> +		isc->try_config.bpp_v4l2 = 32;
>  		break;
>  	case V4L2_PIX_FMT_YUV420:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YYCC;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_YC420P;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PLANAR;
>  		isc->try_config.bpp = 12;
> +		isc->try_config.bpp_v4l2 = 8; /* only first plane */
>  		break;
>  	case V4L2_PIX_FMT_YUV422P:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YYCC;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_YC422P;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PLANAR;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 8; /* only first plane */

This could have also been described with by adding to the format a
subsampling factor for the CbCr plane and fixing the bpp to 8 as it
describes the first plane. In this way you could avoid setting
bpp_v4l2 for all formats that do not need it.

Something like a simple subsampling multiplier would do for planar YUV
formats, more complicated schemes would probably needed for other
formats.

                420:
                bpp = 8
                subsampling = 12
                bytesperline = w * bpp  >> 3
                sizeimage = w * h * subsampling >> 3

                422:
                bpp = 8
                subsampling = 16
                bytesperline = w * bpp  >> 3
                sizeimage = w * h * subsampling >> 3

                444:
                bpp = 8
                subsampling = 24
                bytesperline = w * bpp  >> 3
                sizeimage = w * h * subsampling >> 3

You would anyway need to set subsampling = 8 in other formats or
either
        sizeimage = w * h * (subsampling ? subsampling : 8) >> 3

which is not super nice ;)

As you wish though, this is driver code, so anything goes

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j




>  		break;
>  	case V4L2_PIX_FMT_YUYV:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_YUYV;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	case V4L2_PIX_FMT_UYVY:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_UYVY;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	case V4L2_PIX_FMT_VYUY:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_VYUY;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	case V4L2_PIX_FMT_GREY:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DATY8;
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED8;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 8;
> +		isc->try_config.bpp_v4l2 = 8;
>  		break;
>  	case V4L2_PIX_FMT_Y16:
>  		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DATY10 | ISC_RLP_CFG_LSH;
> @@ -742,6 +755,7 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
>  		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
>  		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
>  		isc->try_config.bpp = 16;
> +		isc->try_config.bpp_v4l2 = 16;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -990,8 +1004,9 @@ static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
>  		pixfmt->height = isc->max_height;
>
>  	pixfmt->field = V4L2_FIELD_NONE;
> -	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp) >> 3;
> -	pixfmt->sizeimage = pixfmt->bytesperline * pixfmt->height;
> +	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp_v4l2) >> 3;
> +	pixfmt->sizeimage = ((pixfmt->width * isc->try_config.bpp) >> 3) *
> +			     pixfmt->height;
>
>  	if (code)
>  		*code = mbus_code;
> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
> index 32448ccfc636..07fa6dbf8460 100644
> --- a/drivers/media/platform/atmel/atmel-isc.h
> +++ b/drivers/media/platform/atmel/atmel-isc.h
> @@ -102,6 +102,9 @@ struct isc_format {
>  			configuration.
>   * @fourcc:		Fourcc code for this format.
>   * @bpp:		Bytes per pixel in the current format.
> + * @bpp_v4l2:		Bytes per pixel in the current format, for v4l2.
> +			This differs from 'bpp' in the sense that in planar
> +			formats, it refers only to the first plane.
>   * @rlp_cfg_mode:	Configuration of the RLP (rounding, limiting packaging)
>   * @dcfg_imode:		Configuration of the input of the DMA module
>   * @dctrl_dview:	Configuration of the output of the DMA module
> @@ -112,6 +115,7 @@ struct fmt_config {
>
>  	u32			fourcc;
>  	u8			bpp;
> +	u8			bpp_v4l2;
>
>  	u32			rlp_cfg_mode;
>  	u32			dcfg_imode;
> --
> 2.25.1
>
