Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EBB4EE282
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241177AbiCaUUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiCaUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:20:37 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C783574BA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:18:49 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso676476otd.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wQjAfS7fQNP+0bjIIqmCMq8qsMvCY7R1nHBvhnmQNXI=;
        b=j10MlezzUpC9JiuA1DYXfc0p9tDkTlUyllrS2JSrfg+4az2Fea/Pxd3qOyo3vhFJAf
         sqTdXREuXvgAbMvHpqFgquPi4HC8CUWBpNp8qbTF6IbqDAm5vmnHhv89ecdqJx6oT7tH
         Bgn6QkG2lvJhZD6fOulEkF9TvlEIEx65uZJBmWP+D432fiawAc5E2i2zMsJr8DGZCCSj
         pxKArQyeFNkWcww1cZBcpb+vo4J13O3Oth9qR0YD9JzDNOHHXmCo+1JU75Z+Kj8m+wCQ
         fFcKsE82F2K2QllygTYgs0Fgb0NjwkiAYEc7z58T3fNWI2LIlajmTS45yKqpBMtYrrAa
         TFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQjAfS7fQNP+0bjIIqmCMq8qsMvCY7R1nHBvhnmQNXI=;
        b=A9P2abOWxfdvxoglPm9mteGE1yeHMMODHDx9lcAzx9KCXH2IJK4PxvM9xKUPEwkS33
         Bs5313oTOVS4/oobk9r59Rs/CqFCCvqNOahbgIUvBG1MOZTsz1T7sxagKq+BNfQ1yq5T
         QYclLnPZwnNhXSxWqQyw1T6WGYngVvwF3gBtjpkrBpCxSPT4cl7MnS+c6Sw+MdfntS3H
         8xdneIUdFh+Kv4jfdqTwWpwdo+WVgHxL0FSxLoBEvOCKnrb2QePtkqPg3ycM6Y8Ubpnm
         gMVWUJ62CfD0LQ8au3AB5qtB+1ygpn3UtM3AZd0hr4nh3R61WWGj/odozvIOTBBZQaAd
         qeig==
X-Gm-Message-State: AOAM5336pHI6tj77/a04SOxYflSmVZEnS3XYGcwvAHGqh185UpBYCdMn
        6g6ZtCkiu55V/9WYloQJysx3Zg==
X-Google-Smtp-Source: ABdhPJyqCR7D5/odh4ouFQT5iXg7jswTv5MMl65YGWcRHy65MBuAgKtCob4+S4ePPn9YL9WlX0TwmQ==
X-Received: by 2002:a05:6830:1dea:b0:5b2:3db5:1494 with SMTP id b10-20020a0568301dea00b005b23db51494mr6277005otj.169.1648757928806;
        Thu, 31 Mar 2022 13:18:48 -0700 (PDT)
Received: from eze-laptop ([190.194.87.200])
        by smtp.gmail.com with ESMTPSA id x18-20020a056830245200b005ce01c28c77sm270635otr.1.2022.03.31.13.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:18:48 -0700 (PDT)
Date:   Thu, 31 Mar 2022 17:18:43 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] media: hantro: Implement support for encoder commands
Message-ID: <YkYMo3cU2lqeDBu1@eze-laptop>
References: <20220331091628.641915-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331091628.641915-1-wenst@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 05:16:28PM +0800, Chen-Yu Tsai wrote:
> The V4L2 stateful encoder uAPI specification requires that drivers
> support the ENCODER_CMD ioctl to allow draining of buffers. This
> however was not implemented, and causes issues for some userspace
> applications.
> 
> Implement support for the ENCODER_CMD ioctl using v4l2-mem2mem helpers.
> This is entirely based on existing code found in the vicodec test
> driver.
> 
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

I believe Nicolas tested the patch before the splitting,
so this is probably Tested-by as well.

Thanks!
Ezequiel

> ---
> 
> This version was tested on RK3399 on mainline with fluster and gstreamer.
> Fluster test scores for VP8 decoding remain the same. Gstreamer jpeg
> encoding works without stalling or outputing extra frames.
> 
> For stress testing, fluster by itself already runs six jobs concurrently.
> At the same time, I also spawn a half-dozen gstreamer encoding jobs:
> 
>     gst-launch-1.0 videotestsrc num-buffers=2000 ! v4l2jpegenc ! fakesink
> 
> It was also backported onto ChromeOS 5.10, and tested on kevin.
> 
> Everything seems to work ok, without anything stalling.
> 
> Changes since v3:
> - Split out unrelated change into separate patch [1]
> - Dropped invalid .has_stopped check after v4l2_m2m_ioctl_encoder_cmd()
>   was called. Issue raised by Ezequiel.
> - Dropped reviewed-by from Benjamin due to code changes
> 
> [1] https://lore.kernel.org/linux-media/20220331084907.628349-1-wenst@chromium.org/
> 
> Changes since v2:
> - Dropped RFC tag
> - Added Reviewed-by from Benjamin
> - Replace direct access to vb->planes[i].bytesused with
>   vb2_set_plane_payload()
> 
> Changes since v1:
> - Correctly handle last buffers that are empty
> - Correctly handle last buffers that just got queued
> - Disable (TRY_)ENCODER_CMD ioctls for hantro decoder
> 
> This is based on linux-next-20220208, and was tested on RK3399 with
> Gstreamer running the JPEG encoder. It was also tested on ChromeOS
> 5.10 on Kevin with the video encoder used in ChromeOS ARC, which
> requires this. For ChromeOS, both encoder and decoder tests were run
> to check for regressions.
> 
> Everything really works OK now, but since I'm not very familiar with
> the mem2mem framework, I might be missing something, causing resource
> leaks. Hence this patch is labeled RFC.
> 
> Last, I suppose we could also add support for (TRY_)DECODER_CMD now?
> 
>  drivers/staging/media/hantro/hantro_drv.c  | 17 ++++++-
>  drivers/staging/media/hantro/hantro_v4l2.c | 59 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index dc768884cb79..bd7d11032c94 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -56,6 +56,10 @@ dma_addr_t hantro_get_ref(struct hantro_ctx *ctx, u64 ts)
>  	return hantro_get_dec_buf_addr(ctx, buf);
>  }
>  
> +static const struct v4l2_event hantro_eos_event = {
> +	.type = V4L2_EVENT_EOS
> +};
> +
>  static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
>  				    struct hantro_ctx *ctx,
>  				    enum vb2_buffer_state result)
> @@ -73,6 +77,12 @@ static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
>  	src->sequence = ctx->sequence_out++;
>  	dst->sequence = ctx->sequence_cap++;
>  
> +	if (v4l2_m2m_is_last_draining_src_buf(ctx->fh.m2m_ctx, src)) {
> +		dst->flags |= V4L2_BUF_FLAG_LAST;
> +		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +		v4l2_m2m_mark_stopped(ctx->fh.m2m_ctx);
> +	}
> +
>  	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
>  					 result);
>  }
> @@ -809,10 +819,13 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
>  	snprintf(vfd->name, sizeof(vfd->name), "%s-%s", match->compatible,
>  		 funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ? "enc" : "dec");
>  
> -	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER)
> +	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>  		vpu->encoder = func;
> -	else
> +	} else {
>  		vpu->decoder = func;
> +		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
> +		v4l2_disable_ioctl(vfd, VIDIOC_ENCODER_CMD);
> +	}
>  
>  	video_set_drvdata(vfd, vpu);
>  
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index 261beb0c40f6..71a6279750bf 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -628,6 +628,38 @@ static int vidioc_s_selection(struct file *file, void *priv,
>  	return 0;
>  }
>  
> +static const struct v4l2_event hantro_eos_event = {
> +	.type = V4L2_EVENT_EOS
> +};
> +
> +static int vidioc_encoder_cmd(struct file *file, void *priv,
> +			      struct v4l2_encoder_cmd *ec)
> +{
> +	struct hantro_ctx *ctx = fh_to_ctx(priv);
> +	int ret;
> +
> +	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, priv, ec);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)) ||
> +	    !vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
> +		return 0;
> +
> +	ret = v4l2_m2m_ioctl_encoder_cmd(file, priv, ec);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ec->cmd == V4L2_ENC_CMD_STOP &&
> +	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> +		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +
> +	if (ec->cmd == V4L2_ENC_CMD_START)
> +		vb2_clear_last_buffer_dequeued(&ctx->fh.m2m_ctx->cap_q_ctx.q);
> +
> +	return 0;
> +}
> +
>  const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>  	.vidioc_querycap = vidioc_querycap,
>  	.vidioc_enum_framesizes = vidioc_enum_framesizes,
> @@ -657,6 +689,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>  
>  	.vidioc_g_selection = vidioc_g_selection,
>  	.vidioc_s_selection = vidioc_s_selection,
> +
> +	.vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
> +	.vidioc_encoder_cmd = vidioc_encoder_cmd,
>  };
>  
>  static int
> @@ -748,6 +783,22 @@ static void hantro_buf_queue(struct vb2_buffer *vb)
>  	struct hantro_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>  
> +	if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
> +	    vb2_is_streaming(vb->vb2_queue) &&
> +	    v4l2_m2m_dst_buf_is_last(ctx->fh.m2m_ctx)) {
> +		unsigned int i;
> +
> +		for (i = 0; i < vb->num_planes; i++)
> +			vb2_set_plane_payload(vb, i, 0);
> +
> +		vbuf->field = V4L2_FIELD_NONE;
> +		vbuf->sequence = ctx->sequence_cap++;
> +
> +		v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, vbuf);
> +		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +		return;
> +	}
> +
>  	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
>  }
>  
> @@ -763,6 +814,8 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
>  	struct hantro_ctx *ctx = vb2_get_drv_priv(q);
>  	int ret = 0;
>  
> +	v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
> +
>  	if (V4L2_TYPE_IS_OUTPUT(q->type))
>  		ctx->sequence_out = 0;
>  	else
> @@ -835,6 +888,12 @@ static void hantro_stop_streaming(struct vb2_queue *q)
>  		hantro_return_bufs(q, v4l2_m2m_src_buf_remove);
>  	else
>  		hantro_return_bufs(q, v4l2_m2m_dst_buf_remove);
> +
> +	v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
> +
> +	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
> +	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> +		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
>  }
>  
>  static void hantro_buf_request_complete(struct vb2_buffer *vb)
> -- 
> 2.35.1.1021.g381101b075-goog
> 
