Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005A64F644C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiDFPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiDFPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:52:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A4152750A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:13:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso1654255otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s4UyoymKo0MiCMqo3D+Ez+F5rfIje+Ebwuy8rUwudOc=;
        b=5AgWHpt/wFkkkhRVPiGRh2h5NWqz7wgeP6+v9hoeFWMimCKpOvsFJj/TJ1hH7xyr0s
         mHCIbT5UCrP0c1G238A06Tm63Yx4XF5XpXtIEmsuagWRRg4kp9dhxP0EVmasUMY5KYl1
         hNsMM8PO6ckRIPVFYodk/Dd53TQTCFKNjMBvdavRBFyplW1GGROcvUW/Ah0ERVsoK50F
         O4Tx1iP/trhe7bJwoOzsPokuj1yAKbuDvlm4Up6eJjTvcFayUTnISLPemlEEteKjHo+S
         xGjwj1CHR6VMGK2CXMk5mwLMm6+ZAzoxWEUpDOS+Fm3+mQK86lNpEltD3k+bpnHx2oYg
         a41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s4UyoymKo0MiCMqo3D+Ez+F5rfIje+Ebwuy8rUwudOc=;
        b=buIvJF+dc4i3a/ZDfOU6yUTGIYMfa66yG/hHyMGsuIipIwx61wL5UG6rFsw8qHieCl
         Vf2VKMG1IvnCEiWeopjKEb+xd9YZWy/3muPpnstVEfPcRhTct2SSkESwG+wVnkKAa2LI
         1V88+EUXmQUwu6FPJwsLBGNLMWX9B1FcTv8fjUybdcCVf0COjgBjNeAnaCgjgKFqTOK1
         YxCIQhul90NnGQOG0eO/BkrQHycuek1Syf24LZ0j+eLDAhHgRveQ4ja+CSGIerTbI/C5
         58hTgBay1vErXb9362wONFO4a179ejcuFNw+EnKSyDfUh2dW8fEuKNo1BzcrtyebicXg
         rcmA==
X-Gm-Message-State: AOAM531SpxsyWraXvJZbX9mO+VS6vhj7tw0TMr72EWwKrkkqk4v4e8V3
        du3EETuSQweGcFsHnQ+C+FBcOg==
X-Google-Smtp-Source: ABdhPJzjVmDCX/NGQsNm7peF0uT2TgG0ug/jXOoWpZ33ZfKWn24G5Q30lQrniT8uYl9jb0xZ58UTWQ==
X-Received: by 2002:a05:6830:241d:b0:5ce:94f4:203a with SMTP id j29-20020a056830241d00b005ce94f4203amr2900784ots.241.1649250773502;
        Wed, 06 Apr 2022 06:12:53 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id y18-20020a056871011200b000e1f5910d45sm3894141oab.7.2022.04.06.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:12:52 -0700 (PDT)
Date:   Wed, 6 Apr 2022 10:12:47 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 16/24] media: rkvdec: h264: Validate and use pic width
 and height in mbs
Message-ID: <Yk2Rzzpye8KUodmu@eze-laptop>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-17-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405204426.259074-17-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:44:17PM -0400, Nicolas Dufresne wrote:
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

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

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
> -- 
> 2.34.1
> 
