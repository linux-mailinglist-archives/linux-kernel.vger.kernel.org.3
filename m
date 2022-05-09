Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC81B51F8BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiEIJyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiEIJnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:43:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7AF1E6549;
        Mon,  9 May 2022 02:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3D7EB810B2;
        Mon,  9 May 2022 09:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739E3C385AB;
        Mon,  9 May 2022 09:38:50 +0000 (UTC)
Message-ID: <fa57eef5-19ee-4328-99b0-403571f59e56@xs4all.nl>
Date:   Mon, 9 May 2022 11:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] media: Add P010LE video format
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, p.zabel@pengutronix.de,
        nicolas@ndufresne.ca, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <20220421124349.452404-1-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220421124349.452404-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 4/21/22 14:43, Benjamin Gaignard wrote:
> P010LE is a YUV format with 16-bits per pixel with interleaved UV.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> version 2:
> - Fix Hans's remarks
> - Add 'LE' suffix to pixel name since P010BE can also exist

I don't think you should do this. By default formats are little endian,
unless explicitly stated otherwise. So big endian formats typically
have a _BE suffix, and they use v4l2_fourcc_be() instead of v4l2_fourcc().

This format is standard little endian, so I would just drop the LE bit.

> 
>  .../media/v4l/pixfmt-yuv-planar.rst           | 53 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  include/uapi/linux/videodev2.h                |  1 +
>  4 files changed, 56 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 8dff5906639b..b9dd4f376fe3 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -109,6 +109,13 @@ All components are stored with the same number of bits per component.
>        - Cb, Cr
>        - No
>        - 16x16 tiles
> +    * - V4L2_PIX_FMT_P010LE
> +      - 'P010'
> +      - 16
> +      - 4:2:0
> +      - Cb, Cr
> +      - No
> +      - Linear
>      * - V4L2_PIX_FMT_NV16
>        - 'NV16'
>        - 8
> @@ -171,6 +178,7 @@ horizontally.
>  .. _V4L2-PIX-FMT-NV21:
>  .. _V4L2-PIX-FMT-NV12M:
>  .. _V4L2-PIX-FMT-NV21M:
> +.. _V4L2-PIX-FMT-P010LE:
>  
>  NV12, NV21, NV12M and NV21M
>  ---------------------------
> @@ -519,6 +527,51 @@ number of lines as the luma plane.
>        - Cb\ :sub:`33`
>        - Cr\ :sub:`33`
>  
> +.. _V4L2_PIX_FMT_P010LE:
> +
> +P010LE
> +------
> +
> +Like NV12 with 16 bits per component, data in the 10 high bits, zeros in the 6 low bits, arranged in little endian order

Here it is fine to mention little endian, it's just the fourcc name I have a problem with.

Regards,

	Hans


> +
> +.. flat-table:: Sample 4x4 P010LE Image
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - start + 0:
> +      - Y'\ :sub:`00`
> +      - Y'\ :sub:`01`
> +      - Y'\ :sub:`02`
> +      - Y'\ :sub:`03`
> +    * - start + 8:
> +      - Y'\ :sub:`10`
> +      - Y'\ :sub:`11`
> +      - Y'\ :sub:`12`
> +      - Y'\ :sub:`13`
> +    * - start + 16:
> +      - Y'\ :sub:`20`
> +      - Y'\ :sub:`21`
> +      - Y'\ :sub:`22`
> +      - Y'\ :sub:`23`
> +    * - start + 24:
> +      - Y'\ :sub:`30`
> +      - Y'\ :sub:`31`
> +      - Y'\ :sub:`32`
> +      - Y'\ :sub:`33`
> +    * - start + 32:
> +      - Cb\ :sub:`00`
> +      - Cr\ :sub:`00`
> +      - Cb\ :sub:`01`
> +      - Cr\ :sub:`01`
> +    * - start + 40:
> +      - Cb\ :sub:`10`
> +      - Cr\ :sub:`10`
> +      - Cb\ :sub:`11`
> +      - Cr\ :sub:`11`
> +
> +.. raw:: latex
> +
> +    \endgroup
>  
>  Fully Planar YUV Formats
>  ========================
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index df34b2a283bc..bc73526c41b9 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -266,6 +266,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  		{ .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> +		{ .format = V4L2_PIX_FMT_P010LE,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  
>  		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
>  		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 96e307fe3aab..2ba3440099d0 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1301,6 +1301,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
>  	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
> +	case V4L2_PIX_FMT_P010LE:	descr = "16-bit Y/CrCb 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 4c09969e7112..92822a80a12e 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -601,6 +601,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
>  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
>  #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
> +#define V4L2_PIX_FMT_P010LE  v4l2_fourcc('P', '0', '1', '0') /* 16  Y/CbCr 4:2:0 16-bit per pixel, little endian*/
>  
>  /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */
