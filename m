Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00C252B91A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiERLwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbiERLwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:52:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF83614D;
        Wed, 18 May 2022 04:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4380B81F4C;
        Wed, 18 May 2022 11:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8B5C385A5;
        Wed, 18 May 2022 11:52:46 +0000 (UTC)
Message-ID: <aaa42afe-2edc-cde9-c689-7df5f91dae09@xs4all.nl>
Date:   Wed, 18 May 2022 13:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] media: Add P010 video format
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220517091419.248265-1-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220517091419.248265-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 5/17/22 11:14, Benjamin Gaignard wrote:
> P010 is a YUV format with 16-bits per pixel with interleaved UV.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> version 3:
> - remove LE suffix
> - rebased on media_tree_master branch
> 
>  .../media/v4l/pixfmt-yuv-planar.rst           | 53 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  include/uapi/linux/videodev2.h                |  1 +
>  4 files changed, 56 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 8dff5906639b..fc2fc17cb371 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -109,6 +109,13 @@ All components are stored with the same number of bits per component.
>        - Cb, Cr
>        - No
>        - 16x16 tiles
> +    * - V4L2_PIX_FMT_P010
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
> +.. _V4L2-PIX-FMT-P010:
>  
>  NV12, NV21, NV12M and NV21M
>  ---------------------------
> @@ -519,6 +527,51 @@ number of lines as the luma plane.
>        - Cb\ :sub:`33`
>        - Cr\ :sub:`33`
>  
> +.. _V4L2_PIX_FMT_P010:
> +
> +P010
> +----
> +
> +Like NV12 with 16 bits per component, data in the 10 high bits, zeros in the 6 low bits, arranged in little endian order

Missing period at the end of the sentence.

I would also say that this has 10 bits per component. The remainder is padding
and it's just how it is stored, but precision-wise this format has just 10 bits.

> +
> +.. flat-table:: Sample 4x4 P010 Image
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
> index df34b2a283bc..1e38ad8906a2 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -266,6 +266,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  		{ .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> +		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  
>  		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
>  		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index e2636539c9db..857a4e0d74a1 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1305,6 +1305,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
>  	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
> +	case V4L2_PIX_FMT_P010:		descr = "16-bit Y/CrCb 4:2:0"; break;

So this becomes 10-bit as well (also conform a similar format like FMT_Y10).

>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 6d465dc443b7..311f106bbdf5 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -601,6 +601,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
>  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
>  #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
> +#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 16  Y/CbCr 4:2:0 16-bit per pixel */

Ditto.

>  
>  /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */

Regards,

	Hans
