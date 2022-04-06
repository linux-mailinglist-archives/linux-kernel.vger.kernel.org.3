Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944744F57AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiDFHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347877AbiDFGNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:13:31 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506E61DAF95
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:17:55 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id k10so1407043oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EaYNgx8KbJOaAquzTTA9wZHzyzdVTdSankAvb1CZzyQ=;
        b=x5n6cdCJEE/VCj3mLhng1qEaAEHHuW6CnLjYyMKJ8C5R5ZP0Q7JKSOAngNXZvEssT6
         qYwF0nXkMrFHlG642wUJQ96R8zpKlbaA/iAu1W8vgASVZWN7754Y3hfqO2OLH7MlHlKO
         ME6PI4A7vIvIay1Q1f8uJsQT4BK9tIPX8xmd/ugQJKSMeeEZPAKla6chmuZzSlbn/t7P
         mGKdo/EHI/X1JEU3CvMq6WouABaUMJBGUExshvChDadmSyo+WH+DcM5YIqYJa+roV5UP
         F0HGy42FpfZK4jAnq9YXXQQ5XGQc9/lIKTTMJwH4O9fdpI4TOuVX59WoOrmEpLxIWeL0
         B4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EaYNgx8KbJOaAquzTTA9wZHzyzdVTdSankAvb1CZzyQ=;
        b=YmrhWsVJ284FWMpVXuYq726Bd5n/m29rworkMKNc9mCuTet80+DbXBaB9ZkkySQiy6
         pCh2jJUAyB+emL2MqfmIf2A4YIw8A67Ct1YQXsNOlzOfsVkv0bFjdTlzM+W+8s4+BKOU
         qSjCBputK+S3YeitCOG+QRxNx4IBBoT8c2aSmFPPjLiT09t1gl7oBRyzKHb3QOOgW3aL
         4AqqOHaVpq8E/+8j0x1gX4OjeSHWw3pucA2J6yAngYvefulLXp9xKpkyCJiOR8gHmDHR
         i+wOENW3TUaCEKzigtMKjvSbGUQ5YoeXPmdzzCu/joU27wyD3Vvtisxn4yBVC4M40ZMk
         u+DA==
X-Gm-Message-State: AOAM531xHtKAiYWp+LNblcCeI4Aqtx1c9M+lQvFVfOfkwAvYBcZpPUES
        wKTtsJNPddCo1a3XESRQsXaUbg==
X-Google-Smtp-Source: ABdhPJznshMWCCRKhfXQIHf+0aM9ZllfI4xIqhhI3AR7UIbt17C0rKLn8MOFpYfzpZrwKU3Nu8zULQ==
X-Received: by 2002:aca:f286:0:b0:2da:58ba:c578 with SMTP id q128-20020acaf286000000b002da58bac578mr2846902oih.127.1649222274622;
        Tue, 05 Apr 2022 22:17:54 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id gk6-20020a0568703c0600b000de4880b357sm6038605oab.50.2022.04.05.22.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 22:17:53 -0700 (PDT)
Date:   Wed, 6 Apr 2022 02:17:48 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 15/24] media: rkvdec: Move H264 SPS validation in
 rkvdec-h264
Message-ID: <Yk0ifIfQmk9n5vyu@eze-laptop>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-16-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405204426.259074-16-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:44:16PM -0400, Nicolas Dufresne wrote:
> No function change, this moves H264 specific validation into the H264
> specific code. This is in preparation of improving this validation and
> reusing at streamone.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

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
> -- 
> 2.34.1
> 
