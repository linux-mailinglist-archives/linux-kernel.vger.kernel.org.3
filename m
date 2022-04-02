Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECF4F00FC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiDBLSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiDBLSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:18:41 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF815B052
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:16:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id b188so5231264oia.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WjzH3Bp/QUa2TjJHjxkVQdmU8VTnKhEV9IV9oEFA8ak=;
        b=CEdR9sisN7IB5r5tB2HaKFQKMuuVaopkESp5PcnA5otm521+G6ap3QLvZOf64W+uDM
         4z/o9qUzrs6hJxDfNHi+i8kZh8VKUG8L2U5ZhpEhg2r/fhmpvYuxP+Kb5r5w4iWhH//L
         /wRhOSNcUnSYFHBFRT01NOBqLfxeHeRLSyZAaDLzakXgR1k+7GL4zcobbIZ4du3YHQjT
         BA2zG3n3Jn1/q7rUzwWWYeDZ3D/VSpcb7TZHR1ottkM2XhvwEpZMlq6R+AeEIlGCPDHv
         hUHa7xVJ7/CFr2u2SBGrz1A/NSTaB4gRI7shibJASst6BRstnVDp2eKzGAPm1iiXo7Ir
         nUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WjzH3Bp/QUa2TjJHjxkVQdmU8VTnKhEV9IV9oEFA8ak=;
        b=0r4+92pEd30tAe2jKQx39Xq3Jw570oJjP/Y0yXP0DhYMP1H/CA66/S/5hlhxbvI/X+
         IJLSzuOnJ9Wsmerxm9qHKp6jq/piA3c+Ks3VV5KsOWnqtOayNqQvVjrIdHncSeDll8ha
         FrcX+Dp3bZbt41swxatDnjoZEenDe5eB/cmItpTNAapCKxSiPdUSlB5DvyqhlVpi6yrv
         AJvoV7+uzBlMFeCHwRFF/tdFFAGoLha9M4GpDIggJd1NEm+H7PB2vE+VeTw3/TPG5zhZ
         bicXQaC40G9OOGKsP/IFj90OTtvOhJJWjYtbbOkn5JfbHdPAISXo6cxl8KZCoLnX8/KF
         Gufw==
X-Gm-Message-State: AOAM532LktU9WHnyQIN6tu2NnZ/LgcxiR+zVcJotj4KucT3l2q9Av8L0
        /QEmvb3yAnTtXTk07cesxncrJQ==
X-Google-Smtp-Source: ABdhPJwt+k9ISqksCBiUGrS67w5cQJUESwaCZG9FKIOUke5sO/15am/gUUnCSnZtlVN7b/1Iyfy3TQ==
X-Received: by 2002:a05:6808:1247:b0:2d3:5181:449a with SMTP id o7-20020a056808124700b002d35181449amr6301215oiv.83.1648898208790;
        Sat, 02 Apr 2022 04:16:48 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id bm51-20020a0568081ab300b002da5c44e0bdsm1954097oib.28.2022.04.02.04.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:16:48 -0700 (PDT)
Date:   Sat, 2 Apr 2022 08:16:43 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/23] media: rkvdec: h264: Fix dpb_valid
 implementation
Message-ID: <YkgwmwTMa83RysKB@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
 <20220331193726.289559-14-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331193726.289559-14-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:37:15PM -0400, Nicolas Dufresne wrote:
> The ref builder only provided references that are marked as valid in the
> dpb. Thus the current implementation of dpb_valid would always set the
> flag to 1. This is not representing missing frames (this is called
> 'non-existing' pictures in the spec). In some context, these non-existing
> pictures still need to occupy a slot in the reference list according to
> the spec.
> 

Good catch! OOC, did you find this because it was failing a test vector?

> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 33 ++++++++++++++++------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index dff89732ddd0..bcde37d72244 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -112,6 +112,7 @@ struct rkvdec_h264_run {
>  	const struct v4l2_ctrl_h264_sps *sps;
>  	const struct v4l2_ctrl_h264_pps *pps;
>  	const struct v4l2_ctrl_h264_scaling_matrix *scaling_matrix;
> +	int ref_buf_idx[V4L2_H264_NUM_DPB_ENTRIES];
>  };
>  
>  struct rkvdec_h264_ctx {
> @@ -725,6 +726,26 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
>  	}
>  }
>  
> +static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
> +			       struct rkvdec_h264_run *run)
> +{
> +	const struct v4l2_ctrl_h264_decode_params *dec_params = run->decode_params;
> +	u32 i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dec_params->dpb); i++) {
> +		struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> +		const struct v4l2_h264_dpb_entry *dpb = run->decode_params->dpb;
> +		struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> +		int buf_idx = -1;
> +
> +		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> +			buf_idx = vb2_find_timestamp(cap_q,
> +						     dpb[i].reference_ts, 0);
> +
> +		run->ref_buf_idx[i] = buf_idx;
> +	}
> +}
> +
>  static void assemble_hw_rps(struct rkvdec_ctx *ctx,
>  			    struct rkvdec_h264_run *run)
>  {
> @@ -762,7 +783,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
>  
>  	for (j = 0; j < RKVDEC_NUM_REFLIST; j++) {
>  		for (i = 0; i < h264_ctx->reflists.num_valid; i++) {
> -			u8 dpb_valid = 0;
> +			bool dpb_valid = run->ref_buf_idx[i] >= 0;
>  			u8 idx = 0;
>  
>  			switch (j) {
> @@ -779,8 +800,6 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
>  
>  			if (idx >= ARRAY_SIZE(dec_params->dpb))
>  				continue;
> -			dpb_valid = !!(dpb[idx].flags &
> -				       V4L2_H264_DPB_ENTRY_FLAG_ACTIVE);
>  
>  			set_ps_field(hw_rps, DPB_INFO(i, j),
>  				     idx | dpb_valid << 4);
> @@ -859,13 +878,8 @@ get_ref_buf(struct rkvdec_ctx *ctx, struct rkvdec_h264_run *run,
>  	    unsigned int dpb_idx)
>  {
>  	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> -	const struct v4l2_h264_dpb_entry *dpb = run->decode_params->dpb;
>  	struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> -	int buf_idx = -1;
> -
> -	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> -		buf_idx = vb2_find_timestamp(cap_q,
> -					     dpb[dpb_idx].reference_ts, 0);
> +	int buf_idx = run->ref_buf_idx[dpb_idx];
>  
>  	/*
>  	 * If a DPB entry is unused or invalid, address of current destination
> @@ -1102,6 +1116,7 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
>  
>  	assemble_hw_scaling_list(ctx, &run);
>  	assemble_hw_pps(ctx, &run);
> +	lookup_ref_buf_idx(ctx, &run);
>  	assemble_hw_rps(ctx, &run);
>  	config_registers(ctx, &run);
>  
> -- 
> 2.34.1
> 
