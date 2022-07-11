Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC13D570CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiGKVWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKVWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:22:04 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B32B272
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:22:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id p132so2163019oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DlVNbxuhHiE0YW6IfxJk+i5c5jEODpePbQ6g9q+lpxA=;
        b=LwQWUEinUCMBYYBc7qN0jExmAf2FO1r7LHie57nyLt7LixbPeeSEj7hUEJpKkzW/Fm
         WyRVBjp5IRx/nfORkIB8sLI8hBJqSZArmXI2x/3EMVw9B7BLhREJIzGu6w189Cab8vie
         PT8LeimE+0s5AQVydZTLezmrvDOrxHH0Tehe6doNqv9q6kwQ9HJkpwgco8LU30Xo8y12
         0NBcP/pqmrWALkCaprRW3cVGgJKAu1HBjRd2GhtH+Iuv0xFhQb+k5PnugA14UIPqH0R8
         Gp9qXg7dtiXDb2quprYaa5Dk3F2PUEIU3ircOaoZN9Wko4fdp2Yd6KZOur8FC6n9Dypl
         vgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DlVNbxuhHiE0YW6IfxJk+i5c5jEODpePbQ6g9q+lpxA=;
        b=MT+NI96/r2vfAMJNLoT93NrMAMVCjfrG9YEPnu5zuEmQvik3OEfxGaDq2Wr4QCdzSf
         3o8hljjfEW4WOzMzfBsHpqGuuDkJ9dv+mDMBn0OcLjICmhQbFWUGX9tZSvnd/qCmGJ+O
         58rtq9DJ1rETLb7kOheJjd13s0rztXf08pTzDRG94dc0/sTaipH3Oiv02A80Lv8G26SB
         XbbWCXRpQEB9FoNUpFVAiXaPXLxys8bXr51x61JtizFDlWAFzoF0wgJsqCzOT2iEx5q6
         QWA53Yr9sL7uEPCuOpbgmYuu8fpXKADXlgCd7UdhMVcapFXPoxdIjQrY6fq6icDeJ3XT
         bmMw==
X-Gm-Message-State: AJIora8Yzrq5l0iXAiKuVT82OO6JFPlDrxK1Z8M6L4+ipcdBmI8D6auZ
        cuHg57YTWPG8jaSBipl4qhoC7Q==
X-Google-Smtp-Source: AGRyM1suX5HCZoxqdbv5pRbmEJaW0Gk9ndmhHnqFYwBqop5sOUVwue3ket7abTy1gwO4u/a3nPw/mg==
X-Received: by 2002:a05:6808:1a11:b0:33a:87d:d9c3 with SMTP id bk17-20020a0568081a1100b0033a087dd9c3mr211788oib.175.1657574522456;
        Mon, 11 Jul 2022 14:22:02 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d6644000000b00616d98ad780sm3032840otm.52.2022.07.11.14.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:22:01 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:21:56 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, mchehab@kernel.org,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] media: cedrus: Add error handling for failed setup
Message-ID: <YsyUdCcMHYBJCFY9@eze-laptop>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
 <20220620175517.648767-5-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620175517.648767-5-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Mon, Jun 20, 2022 at 07:55:14PM +0200, Jernej Skrabec wrote:
> During decoding setup stage for complex codecs like HEVC driver can
> detect inconsistent values in controls or some other task, like
> allocating memory, can fail.
> 
> Currently setup stage has no way of signalling error. Change return type
> of setup callback to int and if returned value is not zero, skip
> decoding and finish job immediately with error flag.
> 
> While currently there is only one place when setup can fail, it's
> expected that there will be more such cases in the future, when HEVC
> decoding is improved.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Looks good and it's very typical to have a setup stage
to put actions that can be allowed to fail.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.h   |  2 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   | 21 ++++++++++++++-----
>  .../staging/media/sunxi/cedrus/cedrus_h264.c  |  5 +++--
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  |  8 +++----
>  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |  4 +++-
>  .../staging/media/sunxi/cedrus/cedrus_vp8.c   |  5 +++--
>  6 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
> index 3bc094eb497f..d2b697a9ded2 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -162,7 +162,7 @@ struct cedrus_dec_ops {
>  	void (*irq_clear)(struct cedrus_ctx *ctx);
>  	void (*irq_disable)(struct cedrus_ctx *ctx);
>  	enum cedrus_irq_status (*irq_status)(struct cedrus_ctx *ctx);
> -	void (*setup)(struct cedrus_ctx *ctx, struct cedrus_run *run);
> +	int (*setup)(struct cedrus_ctx *ctx, struct cedrus_run *run);
>  	int (*start)(struct cedrus_ctx *ctx);
>  	void (*stop)(struct cedrus_ctx *ctx);
>  	void (*trigger)(struct cedrus_ctx *ctx);
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> index aabe6253078e..b0944abaacbd 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -28,6 +28,7 @@ void cedrus_device_run(void *priv)
>  	struct cedrus_dev *dev = ctx->dev;
>  	struct cedrus_run run = {};
>  	struct media_request *src_req;
> +	int error;
>  
>  	run.src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
>  	run.dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> @@ -89,16 +90,26 @@ void cedrus_device_run(void *priv)
>  
>  	cedrus_dst_format_set(dev, &ctx->dst_fmt);
>  
> -	dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
> +	error = dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
> +	if (error)
> +		v4l2_err(&ctx->dev->v4l2_dev,
> +			 "Failed to setup decoding job: %d\n", error);
>  
>  	/* Complete request(s) controls if needed. */
>  
>  	if (src_req)
>  		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
>  
> -	dev->dec_ops[ctx->current_codec]->trigger(ctx);
> +	/* Trigger decoding if setup went well, bail out otherwise. */
> +	if (!error) {
> +		dev->dec_ops[ctx->current_codec]->trigger(ctx);
>  
> -	/* Start the watchdog timer. */
> -	schedule_delayed_work(&dev->watchdog_work,
> -			      msecs_to_jiffies(2000));
> +		/* Start the watchdog timer. */
> +		schedule_delayed_work(&dev->watchdog_work,
> +				      msecs_to_jiffies(2000));
> +	} else {
> +		v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev,
> +						 ctx->fh.m2m_ctx,
> +						 VB2_BUF_STATE_ERROR);
> +	}
>  }
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> index d8fb93035470..c345e67ba9bc 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -493,8 +493,7 @@ static void cedrus_h264_irq_disable(struct cedrus_ctx *ctx)
>  		     reg & ~VE_H264_CTRL_INT_MASK);
>  }
>  
> -static void cedrus_h264_setup(struct cedrus_ctx *ctx,
> -			      struct cedrus_run *run)
> +static int cedrus_h264_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  {
>  	struct cedrus_dev *dev = ctx->dev;
>  
> @@ -510,6 +509,8 @@ static void cedrus_h264_setup(struct cedrus_ctx *ctx,
>  	cedrus_write_frame_list(ctx, run);
>  
>  	cedrus_set_params(ctx, run);
> +
> +	return 0;
>  }
>  
>  static int cedrus_h264_start(struct cedrus_ctx *ctx)
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> index 46119912c387..cfde4ccf6011 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -326,8 +326,7 @@ static int cedrus_h265_is_low_delay(struct cedrus_run *run)
>  	return 0;
>  }
>  
> -static void cedrus_h265_setup(struct cedrus_ctx *ctx,
> -			      struct cedrus_run *run)
> +static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  {
>  	struct cedrus_dev *dev = ctx->dev;
>  	const struct v4l2_ctrl_hevc_sps *sps;
> @@ -385,8 +384,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>  					GFP_KERNEL, DMA_ATTR_NO_KERNEL_MAPPING);
>  		if (!ctx->codec.h265.mv_col_buf) {
>  			ctx->codec.h265.mv_col_buf_size = 0;
> -			// TODO: Abort the process here.
> -			return;
> +			return -ENOMEM;
>  		}
>  	}
>  
> @@ -703,6 +701,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>  
>  	/* Enable appropriate interruptions. */
>  	cedrus_write(dev, VE_DEC_H265_CTRL, VE_DEC_H265_CTRL_IRQ_MASK);
> +
> +	return 0;
>  }
>  
>  static int cedrus_h265_start(struct cedrus_ctx *ctx)
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> index 5dad2f296c6d..4cfc4a3c8a7f 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> @@ -48,7 +48,7 @@ static void cedrus_mpeg2_irq_disable(struct cedrus_ctx *ctx)
>  	cedrus_write(dev, VE_DEC_MPEG_CTRL, reg);
>  }
>  
> -static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
> +static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  {
>  	const struct v4l2_ctrl_mpeg2_sequence *seq;
>  	const struct v4l2_ctrl_mpeg2_picture *pic;
> @@ -185,6 +185,8 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  	      VE_DEC_MPEG_CTRL_MC_CACHE_EN;
>  
>  	cedrus_write(dev, VE_DEC_MPEG_CTRL, reg);
> +
> +	return 0;
>  }
>  
>  static void cedrus_mpeg2_trigger(struct cedrus_ctx *ctx)
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> index f4016684b32d..3f750d1795b6 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> @@ -651,8 +651,7 @@ static void cedrus_vp8_irq_disable(struct cedrus_ctx *ctx)
>  		     reg & ~VE_H264_CTRL_INT_MASK);
>  }
>  
> -static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
> -			     struct cedrus_run *run)
> +static int cedrus_vp8_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  {
>  	const struct v4l2_ctrl_vp8_frame *slice = run->vp8.frame_params;
>  	struct vb2_queue *cap_q = &ctx->fh.m2m_ctx->cap_q_ctx.q;
> @@ -855,6 +854,8 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
>  		ctx->codec.vp8.last_sharpness_level =
>  			slice->lf.sharpness_level;
>  	}
> +
> +	return 0;
>  }
>  
>  static int cedrus_vp8_start(struct cedrus_ctx *ctx)
> -- 
> 2.36.1
> 
