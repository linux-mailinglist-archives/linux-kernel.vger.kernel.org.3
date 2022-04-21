Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB5509C50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387624AbiDUJ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiDUJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:28:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2A275D6;
        Thu, 21 Apr 2022 02:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A92EB8239E;
        Thu, 21 Apr 2022 09:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190B4C385A5;
        Thu, 21 Apr 2022 09:25:59 +0000 (UTC)
Message-ID: <9565c089-03a7-0936-fd20-ae40644300fb@xs4all.nl>
Date:   Thu, 21 Apr 2022 11:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: Add P010 video format
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, p.zabel@pengutronix.de,
        nicolas@ndufresne.ca, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <20220404090116.353034-1-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220404090116.353034-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 04/04/2022 11:01, Benjamin Gaignard wrote:
> P010 is a YUV format with 10-bits per pixel with interleaved UV.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> Note that P010 is already known in GStreamer, only the mapping with
> v4l2 pixel format is missing.
> 
> This patch has been acked in this series but never merged:
> https://patchwork.kernel.org/project/linux-rockchip/patch/20210618131526.566762-5-benjamin.gaignard@collabora.com/
> After rebased it on v5.18-rc1, resend in standalone mode.
> 
>  .../media/v4l/pixfmt-yuv-planar.rst           | 76 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  include/uapi/linux/videodev2.h                |  1 +
>  4 files changed, 79 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 8dff5906639b..6d65c8ac44f0 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -102,6 +102,13 @@ All components are stored with the same number of bits per component.
>        - 64x32 tiles
>  
>          Horizontal Z order
> +    * - V4L2_PIX_FMT_P010
> +      - 'P010'
> +      - 16
> +      - 4:2:0
> +      - Cb, Cr
> +      - No
> +      - Linear

This entry should go after V4L2_PIX_FMT_NV12MT_16X16...

>      * - V4L2_PIX_FMT_NV12MT_16X16
>        - 'VM12'
>        - 8

...and the V4L2_PIX_FMT_NV12MT_16X16 entry should be fixed: it says 4:2:2 for the Subsampling
column, but that should be 4:2:0.

> @@ -171,6 +178,7 @@ horizontally.
>  .. _V4L2-PIX-FMT-NV21:
>  .. _V4L2-PIX-FMT-NV12M:
>  .. _V4L2-PIX-FMT-NV21M:
> +.. _V4L2-PIX-FMT-P010:
>  
>  NV12, NV21, NV12M and NV21M
>  ---------------------------
> @@ -519,6 +527,74 @@ number of lines as the luma plane.
>        - Cb\ :sub:`33`
>        - Cr\ :sub:`33`
>  
> +.. _V4L2_PIX_FMT_P010:
> +
> +P010
> +----
> +
> +The number of bytes in one luminance row must be divisible by 16,

Um, isn't that something that the driver enforces in the bytesperline field
of struct v4l2_pix_format? I don't think this should be a limitation of the
format.

> +which means there will be padded 0 in the right edge when necessary.
> +
> +.. raw:: latex
> +
> +    \begingroup
> +    \small
> +    \setlength{\tabcolsep}{2pt}
> +
> +.. tabularcolumns:: |p{2.6cm}|p{0.70cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
> +
> +.. flat-table:: P010 16 Bits per component
> +    :header-rows:  2
> +    :stub-columns: 0
> +
> +    * - Identifier
> +      - Code
> +      - :cspan:`7` Byte 0 in memory
> +
> +      - :cspan:`7` Byte 1
> +    * -
> +      -
> +      - 7
> +      - 6
> +      - 5
> +      - 4
> +      - 3
> +      - 2
> +      - 1
> +      - 0
> +
> +      - 7
> +      - 6
> +      - 5
> +      - 4
> +      - 3
> +      - 2
> +      - 1
> +      - 0
> +    * - ``V4L2_PIX_FMT_P010``
> +      - 'P010'
> +
> +      - Y\ :sub:`9`
> +      - Y\ :sub:`8`
> +      - Y\ :sub:`7`
> +      - Y\ :sub:`6`
> +      - Y\ :sub:`5`
> +      - Y\ :sub:`4`
> +      - Y\ :sub:`3`
> +      - Y\ :sub:`2`
> +
> +      - Y\ :sub:`1`
> +      - Y\ :sub:`0`
> +      - 0
> +      - 0
> +      - 0
> +      - 0
> +      - 0
> +      - 0

This just shows the Y component, but not the CbCr components. I would expect to see
something similar to the 'Sample 4x4 NV12M Image' table in section 2.7.1.2.1.1.

Regards,

	Hans

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
> index 96e307fe3aab..e14d7e1a038e 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1301,6 +1301,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
>  	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
> +	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CrCb 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 4c09969e7112..2e451c454db3 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -601,6 +601,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
>  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
>  #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
> +#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 15  Y/CbCr 4:2:0 10-bit per pixel*/
>  
>  /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */

