Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029150B1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444921AbiDVHkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444912AbiDVHj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:39:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4C50B02;
        Fri, 22 Apr 2022 00:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87676CE2799;
        Fri, 22 Apr 2022 07:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292EDC385A4;
        Fri, 22 Apr 2022 07:37:01 +0000 (UTC)
Message-ID: <db5b60ef-2c1b-2004-69a0-ecdb2909734f@xs4all.nl>
Date:   Fri, 22 Apr 2022 09:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 15/24] media: rkvdec: Move H264 SPS validation in
 rkvdec-h264
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-16-nicolas.dufresne@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220405204426.259074-16-nicolas.dufresne@collabora.com>
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
> No function change, this moves H264 specific validation into the H264

function -> functional

> specific code. This is in preparation of improving this validation and
> reusing at streamone.

streamone? I guess you mean "stream on"? Or perhaps "streaming"?

> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 23 ++++++++++++++++++++++
>  drivers/staging/media/rkvdec/rkvdec.c      | 23 ++++++----------------
>  drivers/staging/media/rkvdec/rkvdec.h      |  1 +
>  3 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 8d44a884a52e..0dcbcb1bac80 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -1137,9 +1137,32 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
>  	return 0;
>  }
>  
> +static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
> +{
> +	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
> +		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
> +		/*
> +		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> +		 * but it's currently broken in the driver.
> +		 * Reject them for now, until it's fixed.
> +		 */
> +		if (sps->chroma_format_idc > 1)
> +			/* Only 4:0:0 and 4:2:0 are supported */
> +			return -EINVAL;
> +		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
> +			/* Luma and chroma bit depth mismatch */
> +			return -EINVAL;
> +		if (sps->bit_depth_luma_minus8 != 0)
> +			/* Only 8-bit is supported */
> +			return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
>  	.adjust_fmt = rkvdec_h264_adjust_fmt,
>  	.start = rkvdec_h264_start,
>  	.stop = rkvdec_h264_stop,
>  	.run = rkvdec_h264_run,
> +	.try_ctrl = rkvdec_h264_try_ctrl,
>  };
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 2df8cf4883e2..e3d44d5b35f3 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -29,23 +29,12 @@
>  
>  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
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
> +	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> +	const struct rkvdec_coded_fmt_desc *desc = ctx->coded_fmt_desc;
> +
> +	if (desc->ops->try_ctrl)
> +		return desc->ops->try_ctrl(ctx, ctrl);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
> index 2f4ea1786b93..9df0fba799a4 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.h
> +++ b/drivers/staging/media/rkvdec/rkvdec.h
> @@ -72,6 +72,7 @@ struct rkvdec_coded_fmt_ops {
>  	void (*done)(struct rkvdec_ctx *ctx, struct vb2_v4l2_buffer *src_buf,
>  		     struct vb2_v4l2_buffer *dst_buf,
>  		     enum vb2_buffer_state result);
> +	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
>  };
>  
>  struct rkvdec_coded_fmt_desc {

Regards,

	Hans
