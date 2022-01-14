Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BEA48E53A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiANILm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:11:42 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.167]:11955 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiANILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:11:41 -0500
X-KPN-MessageId: 82f03557-7511-11ec-9a2e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 82f03557-7511-11ec-9a2e-005056abbe64;
        Fri, 14 Jan 2022 09:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=zuml5cb46ityR8xHyuGQOnCJFEzHf/fVcI6uqZxrEzM=;
        b=Vm1/T/dBf1sPj4g6flqPJ6wMCEQKWb0NGEX/JNEmBIV5EbGt2xf9UOx1U2DP6JFV4WxNuJjmWqEBx
         sNhfvRLyNoRvcXdyBsactU7UjDENlIVnYAlGB3bMWRjcWizc5fxuIxTVrZKQ7t3GykJy5oj1tIOkds
         SAfx6lZvQFfBJbJcawioxz5b20Yi4f4vWa4w8Qi/yTD240rnvbErdcAPfyH7OKOmze69j3UMaiKikk
         +sV48suiT/5Gc5Um5ZZ4f75YltdKHLvdMYECsU27sQg1jobcDb28Q2GfYjjdWL0AJqbOtU4kLmI3kM
         irDZOaZdjGa2nQdEwBvTz8KpU9J4ORA==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|DrdHS/CriUx8uE+kxG18PLhtCM1oJKFMrj1aOy9kvNYQ8+y3N9cmsRAqi8b9Ehc
 3PoMjIdumdoSK61BXN6GlTw==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 98daabcd-7511-11ec-94d2-005056abf0db;
        Fri, 14 Jan 2022 09:11:39 +0100 (CET)
Message-ID: <703ff71e-c76a-9df1-c644-04efed0199ca@xs4all.nl>
Date:   Fri, 14 Jan 2022 09:11:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v8 1/4] media: v4l: Add definition for the Aspeed JPEG
 format
Content-Language: en-US
To:     Jammy Huang <jammy_huang@aspeedtech.com>,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        eajames@linux.ibm.com, mchehab@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211224012738.1551-1-jammy_huang@aspeedtech.com>
 <20211224012738.1551-2-jammy_huang@aspeedtech.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20211224012738.1551-2-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/2021 02:27, Jammy Huang wrote:
> This introduces support for the Aspeed JPEG format, where the new frame
> can refer to previous frame to reduce the amount of compressed data. The
> concept is similar to I/P frame of video compression. It will compare the
> new frame with previous one to decide which macroblock's data is
> changed, and only the changed macroblocks will be compressed.
> 
> This Aspeed JPEG format is used by the video engine on Aspeed platforms,
> which is generally adapted for remote KVM.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
> v8:
>   - Add decoder information for aspeed-jpeg
> v7:
>   - Add more information for aspeed-jpeg
> v6:
>   - Update description for new format, aspeed-jpeg, in Documentation.
> v5:
>   - no update
> v4:
>   - new
> ---
>  .../media/uapi/v4l/pixfmt-reserved.rst          | 17 +++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c            |  1 +
>  include/uapi/linux/videodev2.h                  |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/pixfmt-reserved.rst b/Documentation/media/uapi/v4l/pixfmt-reserved.rst

This is the wrong file! It should be:

Documentation/userspace-api/media/v4l/pixfmt-reserved.rst

Regards,

	Hans

> index b2cd155e691b..1d0dc8d86ed7 100644
> --- a/Documentation/media/uapi/v4l/pixfmt-reserved.rst
> +++ b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
> @@ -264,6 +264,23 @@ please make a proposal on the linux-media mailing list.
>  	of tiles, resulting in 32-aligned resolutions for the luminance plane
>  	and 16-aligned resolutions for the chrominance plane (with 2x2
>  	subsampling).
> +    * .. _V4L2-PIX-FMT-AJPG:
> +
> +      - ``V4L2_PIX_FMT_AJPG``
> +      - 'AJPG'
> +      - ASPEED JPEG format used by the aspeed-video driver on Aspeed platforms,
> +        which is generally adapted for remote KVM.
> +        On each frame compression, I will compare the new frame with previous
> +        one to decide which macroblock's data is changed, and only the changed
> +        macroblocks will be compressed.
> +
> +        The implementation is based on AST2600 A3 datasheet, revision 0.9, which
> +        is not publicly available. Or you can reference Video stream data format
> +        – ASPEED mode compression of SDK_User_Guide which available on
> +        AspeedTech-BMC/openbmc/releases.
> +
> +        Decoder's implementation can be found here,
> +        `https://github.com/AspeedTech-BMC/aspeed_codec/ <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
>  
>  .. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
>  
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 24db33f803c0..00dde01d2f97 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1378,6 +1378,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>  		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
> +		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 3210b3c82a4a..994eb6155ea9 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -726,6 +726,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
>  #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
> +#define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
>  
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */

