Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE3A5A23E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245416AbiHZJPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245000AbiHZJPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:15:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69848C0B45;
        Fri, 26 Aug 2022 02:15:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 618162B3;
        Fri, 26 Aug 2022 11:15:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661505335;
        bh=1GJGrQ/9WKZNsUX5i1mOWnWo11yEkdsCXAB1SWersAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itbawn55uYKc9nCTaUut9zy0LcTIBkDSdY49Yz1HQ5+X5AxHHQlYx735N3x/aP5Hl
         1esNthiLTbuZHNLL7HPtD8DXDJZEQv85rsJ+MGHOgJZxJSiVEvWPlvlgG9M7vBmKNk
         POBTR3sCOqzfyYy12gkxP34CMbDjph/j7KVnTtKI=
Date:   Fri, 26 Aug 2022 12:15:28 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Shi Hao <hao.shi@amlogic.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, hans.verkuil@cisco.com,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        stanimir.varbanov@linaro.org, nanxin.qin@amlogic.com
Subject: Re: [PATCH] [media] v4l2: Add AV1, AVS and AVS2 format
Message-ID: <YwiPMOyfXKM8lxIR@pendragon.ideasonboard.com>
References: <20220826030003.1066976-1-hao.shi@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826030003.1066976-1-hao.shi@amlogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shi,

Thank you for the patch.

On Fri, Aug 26, 2022 at 11:00:03AM +0800, Shi Hao wrote:
> From: "hao.shi" <hao.shi@amlogic.com>
> 
> Add AV1, AVS and AVS2 compressed pixel formats. They are
> the more common formats.
> 
> Signed-off-by: Shi Hao <hao.shi@amlogic.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 3 +++
>  include/uapi/linux/videodev2.h       | 3 +++

The patch also needs to document the formats, in
Documentation/userspace-api/media/v4l/.

>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index c314025d977e..7b102c2f59b1 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1497,6 +1497,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>  		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
>  		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
> +		case V4L2_PIX_FMT_AV1:		descr = "AV1"; break;
> +		case V4L2_PIX_FMT_AVS:		descr = "AVS"; break;
> +		case V4L2_PIX_FMT_AVS2:		descr = "AVS2"; break;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 01e630f2ec78..fa8ec0ddde3d 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -738,6 +738,9 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
>  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
> +#define V4L2_PIX_FMT_AVS      v4l2_fourcc('A', 'V', 'S', '0') /* AVS */
> +#define V4L2_PIX_FMT_AVS2     v4l2_fourcc('A', 'V', 'S', '2') /* AVS2 */
>  
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

-- 
Regards,

Laurent Pinchart
