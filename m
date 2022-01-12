Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14248C815
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355037AbiALQSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbiALQSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:18:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42337C06173F;
        Wed, 12 Jan 2022 08:18:22 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2866340;
        Wed, 12 Jan 2022 17:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642004300;
        bh=ho0GztGidqsgkHFOy/IoivSO/mjCjEUyQTHM2LUcs1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOidp/TgjysAdxA6sWUh1C6DvRc/IXPdx+bLugyK2SiOS7PXlZ+YmHlE3Mb4dDbC8
         /JeSbFcPIJdEe3SFtDX2TK3Ay5GK5RVXi+RW73jA9R7qKsWEdgHu/JvQ1dLg43lF+z
         UbcbfTwe11zklTu9pLSsUtjBXBU+YQTrCARig4lI=
Date:   Wed, 12 Jan 2022 18:18:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, dave.stevenson@raspberrypi.com
Subject: Re: [PATCH 2/3] media: v4l: Add V4L2-PIX-FMT-Y12P format
Message-ID: <Yd7/QSBE6SgoN6ic@pendragon.ideasonboard.com>
References: <20220112161014.972076-1-jeanmichel.hautbois@ideasonboard.com>
 <20220112161014.972076-3-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220112161014.972076-3-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Wed, Jan 12, 2022 at 05:10:13PM +0100, Jean-Michel Hautbois wrote:
> This is a packed grey-scale image format with a depth of 12 bits per
> pixel. Two consecutive pixels are packed into 3 bytes. The first 2 bytes
> contain the 8 high order bits of the pixels, and the 3rd byte contains
> the 4 least significants bits of each pixel, in the same order.
> 
> Add the entry in userspace API, and document it.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../userspace-api/media/v4l/pixfmt-yuv-luma.rst       | 11 +++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                  |  1 +
>  include/uapi/linux/videodev2.h                        |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> index 8ebd58c3588f..d37ce6027095 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> @@ -92,6 +92,17 @@ are often referred to as greyscale formats.
>        - ...
>        - ...
>  
> +    * .. _V4L2-PIX-FMT-Y12P:
> +
> +      - ``V4L2_PIX_FMT_Y12P``
> +      - 'Y12P'
> +
> +      - Y'\ :sub:`0`\ [11:4]
> +      - Y'\ :sub:`1`\ [11:4]
> +      - Y'\ :sub:`1`\ [3:0] Y'\ :sub:`0`\ [3:0]
> +      - ...
> +      - ...
> +
>      * .. _V4L2-PIX-FMT-Y14:
>  
>        - ``V4L2_PIX_FMT_Y14``
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 9ac557b8e146..e90979af8efb 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1263,6 +1263,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_Y16_BE:	descr = "16-bit Greyscale BE"; break;
>  	case V4L2_PIX_FMT_Y10BPACK:	descr = "10-bit Greyscale (Packed)"; break;
>  	case V4L2_PIX_FMT_Y10P:		descr = "10-bit Greyscale (MIPI Packed)"; break;
> +	case V4L2_PIX_FMT_Y12P:		descr = "12-bit Greyscale (MIPI Packed)"; break;
>  	case V4L2_PIX_FMT_Y8I:		descr = "Interleaved 8-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y12I:		descr = "Interleaved 12-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Z16:		descr = "16-bit Depth"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index df8b9c486ba1..39ab8c216fe8 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -569,6 +569,7 @@ struct v4l2_pix_format {
>  /* Grey bit-packed formats */
>  #define V4L2_PIX_FMT_Y10BPACK    v4l2_fourcc('Y', '1', '0', 'B') /* 10  Greyscale bit-packed */
>  #define V4L2_PIX_FMT_Y10P    v4l2_fourcc('Y', '1', '0', 'P') /* 10  Greyscale, MIPI RAW10 packed */
> +#define V4L2_PIX_FMT_Y12P    v4l2_fourcc('Y', '1', '2', 'P') /* 12  Greyscale, MIPI RAW12 packed */
>  
>  /* Palette formats */
>  #define V4L2_PIX_FMT_PAL8    v4l2_fourcc('P', 'A', 'L', '8') /*  8  8-bit palette */

-- 
Regards,

Laurent Pinchart
