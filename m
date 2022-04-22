Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD5F50B1CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444944AbiDVHna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444957AbiDVHme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:42:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA42517CE;
        Fri, 22 Apr 2022 00:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67F7961F1C;
        Fri, 22 Apr 2022 07:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18169C385A0;
        Fri, 22 Apr 2022 07:39:38 +0000 (UTC)
Message-ID: <d463050e-e9ae-48b1-9271-abb082389e79@xs4all.nl>
Date:   Fri, 22 Apr 2022 09:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 16/24] media: rkvdec: h264: Validate and use pic width
 and height in mbs
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-17-nicolas.dufresne@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220405204426.259074-17-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 22:44, Nicolas Dufresne wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> The width and height in macroblocks is currently configured based on OUTPUT
> buffer resolution, this works for frame pictures but can cause issues for
> field pictures.
> 
> When frame_mbs_only_flag is 0 the height in mbs should be height of
> the field instead of height of frame.
> 
> Validate pic_width_in_mbs_minus1 and pic_height_in_map_units_minus1
> against OUTPUT buffer resolution and use these values to configure HW.
> The validation is happening in both try_ctrt() and start() since it is
> otherwise possible to trick the driver during initialization by changing
> the OUTPUT format after having set a valid control.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 78 ++++++++++++++++------
>  1 file changed, 59 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 0dcbcb1bac80..f081b476340f 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -672,8 +672,16 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
>  		  LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4);
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO),
>  		  DELTA_PIC_ORDER_ALWAYS_ZERO_FLAG);
> -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.width, 16), PIC_WIDTH_IN_MBS);
> -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.height, 16), PIC_HEIGHT_IN_MBS);
> +
> +	/* Use the SPS values since they are already in macroblocks

Move /* to a line by itself.

> +	 * dimensions, height can be field height (halved) if
> +	 * V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY is not set and also it allows
> +	 * decoding smaller images into larger allocation which can be used
> +	 * to implementing SVC spatial layer support.
> +	 */
> +	WRITE_PPS(sps->pic_width_in_mbs_minus1 + 1, PIC_WIDTH_IN_MBS);
> +	WRITE_PPS(sps->pic_height_in_map_units_minus1 + 1, PIC_HEIGHT_IN_MBS);
> +
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY),
>  		  FRAME_MBS_ONLY_FLAG);
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD),
> @@ -1035,13 +1043,59 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
>  	return 0;
>  }
>  
> +static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx,
> +				    const struct v4l2_ctrl_h264_sps *sps)
> +{
> +	unsigned int width, height;

Add empty line here.

> +	/*
> +	 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> +	 * but it's currently broken in the driver.
> +	 * Reject them for now, until it's fixed.
> +	 */
> +	if (sps->chroma_format_idc > 1)
> +		/* Only 4:0:0 and 4:2:0 are supported */
> +		return -EINVAL;
> +	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
> +		/* Luma and chroma bit depth mismatch */
> +		return -EINVAL;
> +	if (sps->bit_depth_luma_minus8 != 0)
> +		/* Only 8-bit is supported */
> +		return -EINVAL;
> +
> +	width = (sps->pic_width_in_mbs_minus1 + 1) * 16;
> +	height = (sps->pic_height_in_map_units_minus1 + 1) * 16;
> +
> +	/* when frame_mbs_only_flag is not set, this is field height,

Place /* on a line by itself. And 'when' should be 'When'.

Regards,

	Hans

> +	 * which is half the final height (see (7-18) in the
> +	 * specification)
> +	 */
> +	if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
> +		height *= 2;
> +
> +	if (width > ctx->coded_fmt.fmt.pix_mp.width ||
> +	    height > ctx->coded_fmt.fmt.pix_mp.height)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
>  {
>  	struct rkvdec_dev *rkvdec = ctx->dev;
>  	struct rkvdec_h264_priv_tbl *priv_tbl;
>  	struct rkvdec_h264_ctx *h264_ctx;
> +	struct v4l2_ctrl *ctrl;
>  	int ret;
>  
> +	ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl,
> +			      V4L2_CID_STATELESS_H264_SPS);
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	ret = rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
> +	if (ret)
> +		return ret;
> +
>  	h264_ctx = kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
>  	if (!h264_ctx)
>  		return -ENOMEM;
> @@ -1139,23 +1193,9 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
>  
>  static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
>  {
> -	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
> -		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
> -		/*
> -		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> -		 * but it's currently broken in the driver.
> -		 * Reject them for now, until it's fixed.
> -		 */
> -		if (sps->chroma_format_idc > 1)
> -			/* Only 4:0:0 and 4:2:0 are supported */
> -			return -EINVAL;
> -		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
> -			/* Luma and chroma bit depth mismatch */
> -			return -EINVAL;
> -		if (sps->bit_depth_luma_minus8 != 0)
> -			/* Only 8-bit is supported */
> -			return -EINVAL;
> -	}
> +	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS)
> +		return rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
> +
>  	return 0;
>  }
>  

