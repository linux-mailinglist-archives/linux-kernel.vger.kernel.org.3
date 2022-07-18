Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2F578D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiGRVsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiGRVsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:48:15 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4521E22
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:48:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10bffc214ffso27529830fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0noAhQzGQVMtWJLetRlilDaMj7MfrAaRFRyFgcHLCMM=;
        b=u3ARJ1PUpmrTPv7E047U/1tGFr/i1odGjt06QneaO61cbGgilyqof7rQ5XsWadKn1u
         7hvF2DrypdZGneRPdbgZd81VY2H7iU70HSS2X2aACwxte02V8myv9Ot9ePYbhUfyjEj6
         QzFgrFBin9bUHv+aSPqHddV6EK3sE8iB+cfpXsNyiH2mBbARFIQIHnhOz++N5YbHmeFz
         m8Dcrk5kZakwS0/zapES4a9xUWFL2GQk/GgHfdM9pICIeHvIz+lRgfaOgUtxdAM8hxCr
         9cQwG/lM3NLc1rF+B7iMqY+1yuYwFfviU364Ryc4XRV1en1sgQe7HlMb0BAWA2OBgJJt
         /npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0noAhQzGQVMtWJLetRlilDaMj7MfrAaRFRyFgcHLCMM=;
        b=dZboTk+Vhd0dXkbf02yUy+vjdB4ew7uNp811wbFQLJ9pwIa+Urgo2DQJHDlK3f3Aa9
         5+tFXpA2uTdQpLUiqHr8qhSDx9+GFaBAqkGy8gPs8cUQieqT3GkMzXi5HnAsnju9GjXa
         b41dDlSL3iUnmck1eElli2LZXfDeIAIM4Kxfh+hxRx3x/+VAPLRPDzqzbfWwOtnxVTFy
         fsGb62che4Gb1ipNiOkYOB0OOuqHSuGFJA6IQq40Un6741hW+zQcKkJm3owvkYBB4t0J
         IY9OP90VE/K68sLcwIeUDTq4DpFoZOzDGkHJ3FZHfiADMifmHqVkALUOVJFLyciKHtQX
         Jfcg==
X-Gm-Message-State: AJIora/9i7yUwQUNP+BIRVu2PL93gN6GVTqRIvvjtLjfgyW3dPpSRucQ
        uI+mVMI1lmNBPPbFBZG3jGKUX/ClSGMWaYXI
X-Google-Smtp-Source: AGRyM1tTQDwzzv5YkeOhUVLKlF8hWm/bku6jiWhD3QAaX7OfEtqm/UULZIl0uXRu9J+52YYrR66O2w==
X-Received: by 2002:a05:6870:9590:b0:de:27ca:c60c with SMTP id k16-20020a056870959000b000de27cac60cmr18809306oao.108.1658180893883;
        Mon, 18 Jul 2022 14:48:13 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id g14-20020a056870d20e00b00101c83352c6sm6761492oac.34.2022.07.18.14.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:48:13 -0700 (PDT)
Date:   Mon, 18 Jul 2022 18:48:08 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH] hantro: Remove incorrect HEVC SPS validation
Message-ID: <YtXVGBRUDy5K9+WK@eze-laptop>
References: <20220718214123.73275-1-ezequiel@vanguardiasur.com.ar>
 <20220718214123.73275-3-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718214123.73275-3-ezequiel@vanguardiasur.com.ar>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:41:23PM -0300, Ezequiel Garcia wrote:
> Currently, the driver tries to validat the HEVC SPS
> against the CAPTURE queue format (i.e. the decoded format).
> This is not correct, because typically the SPS control is set
> before the CAPTURE queue is negotiated.
> 
> Fixes: 135ad96cb4d6b ("media: hantro: Be more accurate on pixel formats step_width constraints")
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

This is actually a v2. I've chosen to move the
control checks back to try_ctrl, but leave the tiled
format alignment check.

This ALIGN() check can be optimized, moving the alignment
to the TRY_FMT step (instead of failing at device_run).
However, this is a minor optimization, so I'd like to
avoid the scope creep, and pospone the changes regarding
the tiled format resolution alignment.

Thanks,
Ezequiel

> ---
>  drivers/media/platform/verisilicon/hantro_drv.c  | 12 ++++++------
>  drivers/media/platform/verisilicon/hantro_hevc.c |  9 +--------
>  drivers/media/platform/verisilicon/hantro_hw.h   |  1 -
>  3 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index e5fc0a99b728..2036f72eeb4a 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>  
>  static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -	struct hantro_ctx *ctx;
> -
> -	ctx = container_of(ctrl->handler,
> -			   struct hantro_ctx, ctrl_handler);
> -
>  	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
>  		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
>  
> @@ -271,7 +266,12 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
>  		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
>  
> -		return hantro_hevc_validate_sps(ctx, sps);
> +		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
> +			/* Luma and chroma bit depth mismatch */
> +			return -EINVAL;
> +		if (sps->bit_depth_luma_minus8 != 0)
> +			/* Only 8-bit is supported */
> +			return -EINVAL;
>  	} else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
>  		const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
>  
> diff --git a/drivers/media/platform/verisilicon/hantro_hevc.c b/drivers/media/platform/verisilicon/hantro_hevc.c
> index 5984c5fa6f83..b990bc98164c 100644
> --- a/drivers/media/platform/verisilicon/hantro_hevc.c
> +++ b/drivers/media/platform/verisilicon/hantro_hevc.c
> @@ -154,15 +154,8 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
>  	return -ENOMEM;
>  }
>  
> -int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps)
> +static int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps)
>  {
> -	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
> -		/* Luma and chroma bit depth mismatch */
> -		return -EINVAL;
> -	if (sps->bit_depth_luma_minus8 != 0)
> -		/* Only 8-bit is supported */
> -		return -EINVAL;
> -
>  	/*
>  	 * for tile pixel format check if the width and height match
>  	 * hardware constraints
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
> index 762631d15fdc..e83f0c523a30 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -360,7 +360,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
>  void hantro_hevc_ref_init(struct hantro_ctx *ctx);
>  dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
>  int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
> -int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps);
>  
>  
>  static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
> -- 
> 2.34.3
> 
