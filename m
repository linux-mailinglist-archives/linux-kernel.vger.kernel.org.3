Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E854C21FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiBXDIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiBXDIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:08:42 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B61B192C98
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:08:13 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g6so1180602ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/q6Deaa5uqZuGAWoUP6lea3xGvCdALyWAfkFdodfDos=;
        b=cRO+oLUbuMcoFQFDRxl+dVhXOKmKqDBMvmPCdgQuT9dsoWb7IrsglYQuSlh3X8FGkD
         v1N87TBaS54hqubuz95YT6J18JcxOsF0cTlV/tWJEsbT4OL/kYcOTafKu25nGC935hZK
         FQ1Bc59c+GAnC95piAy7qcja8E+uZzpz+lsJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/q6Deaa5uqZuGAWoUP6lea3xGvCdALyWAfkFdodfDos=;
        b=I3rqd2SXrHyxylq/rTZ2WJXoh4uaaarCkAR4ApI7Qw3KkmX6260cu2RLJo9jLtTpkh
         eQ/TMcEP8pNJ/L9+VKkz2X4NUOwTWi7AG2wVk2mTDexvmjqhKkAiAJqvo4LQK5OzEZto
         T3cFaCbOAUMMheUfDsNfMF9Rjjx3VMdIc0FWrEltYQQOIo6VZp+T5hkF383kgVr7WKZS
         EZ8WVAx2Lk+wBVquqnIcIBrBgtZ9AAxt/r/87zbkDtIDcWoSIJb49sBlty1nb1mx+Bhh
         JIZFKRDNbUNh5mTZe8zmmtWwm6rwlUPm7Z9roEAcOnx70vUUT4BRTaVfayrTK8uSfPcx
         Wmrw==
X-Gm-Message-State: AOAM531ckFeVwbEAbHTc6YCWr3DAZnYvasSEWa3XecnQ+TMMEC/W+9um
        YFfkDmLVngPHoAMPEqoBAgag+ZKSIg//+27DxyguRg==
X-Google-Smtp-Source: ABdhPJwfo+xTG3B4wQ1YRHZ1K6lChEnGUdnDsbfMdGY87BoSQaXWFXbrihuGh318BbM0NxlRgLRFyzonQxSZhzFdjrs=
X-Received: by 2002:a25:d314:0:b0:624:6c1a:6f2d with SMTP id
 e20-20020a25d314000000b006246c1a6f2dmr693752ybf.189.1645672092353; Wed, 23
 Feb 2022 19:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20220211110617.2202714-1-wenst@chromium.org>
In-Reply-To: <20220211110617.2202714-1-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 24 Feb 2022 11:08:01 +0800
Message-ID: <CAGXv+5H+NC-Co2bkc4TH5Kc7qQjYz98wH5WFFNXjbnLA_J50fg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] media: hantro: Implement support for encoder commands
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 11, 2022 at 7:06 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
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
> ---
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

Gentle ping on this patch?

ChenYu

> ---
>  drivers/staging/media/hantro/hantro_drv.c  | 17 +++++-
>  drivers/staging/media/hantro/hantro_v4l2.c | 68 +++++++++++++++++++++-
>  2 files changed, 81 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index bc9bcb4eaf46..99bc650a5a93 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -56,6 +56,10 @@ dma_addr_t hantro_get_ref(struct hantro_ctx *ctx, u64 ts)
>         return hantro_get_dec_buf_addr(ctx, buf);
>  }
>
> +static const struct v4l2_event hantro_eos_event = {
> +       .type = V4L2_EVENT_EOS
> +};
> +
>  static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
>                                     struct hantro_ctx *ctx,
>                                     enum vb2_buffer_state result)
> @@ -73,6 +77,12 @@ static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
>         src->sequence = ctx->sequence_out++;
>         dst->sequence = ctx->sequence_cap++;
>
> +       if (v4l2_m2m_is_last_draining_src_buf(ctx->fh.m2m_ctx, src)) {
> +               dst->flags |= V4L2_BUF_FLAG_LAST;
> +               v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +               v4l2_m2m_mark_stopped(ctx->fh.m2m_ctx);
> +       }
> +
>         v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
>                                          result);
>  }
> @@ -807,10 +817,13 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
>         snprintf(vfd->name, sizeof(vfd->name), "%s-%s", match->compatible,
>                  funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ? "enc" : "dec");
>
> -       if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER)
> +       if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>                 vpu->encoder = func;
> -       else
> +       } else {
>                 vpu->decoder = func;
> +               v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
> +               v4l2_disable_ioctl(vfd, VIDIOC_ENCODER_CMD);
> +       }
>
>         video_set_drvdata(vfd, vpu);
>
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index 67148ba346f5..777bd3dbd875 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -628,6 +628,39 @@ static int vidioc_s_selection(struct file *file, void *priv,
>         return 0;
>  }
>
> +static const struct v4l2_event hantro_eos_event = {
> +       .type = V4L2_EVENT_EOS
> +};
> +
> +static int vidioc_encoder_cmd(struct file *file, void *priv,
> +                             struct v4l2_encoder_cmd *ec)
> +{
> +       struct hantro_ctx *ctx = fh_to_ctx(priv);
> +       int ret;
> +
> +       ret = v4l2_m2m_ioctl_try_encoder_cmd(file, priv, ec);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)) ||
> +           !vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
> +               return 0;
> +
> +       ret = v4l2_m2m_ioctl_encoder_cmd(file, priv, ec);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (ec->cmd == V4L2_ENC_CMD_STOP &&
> +           v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> +               v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +
> +       if (ec->cmd == V4L2_ENC_CMD_START &&
> +           v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> +               vb2_clear_last_buffer_dequeued(&ctx->fh.m2m_ctx->cap_q_ctx.q);
> +
> +       return 0;
> +}
> +
>  const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>         .vidioc_querycap = vidioc_querycap,
>         .vidioc_enum_framesizes = vidioc_enum_framesizes,
> @@ -657,6 +690,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>
>         .vidioc_g_selection = vidioc_g_selection,
>         .vidioc_s_selection = vidioc_s_selection,
> +
> +       .vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
> +       .vidioc_encoder_cmd = vidioc_encoder_cmd,
>  };
>
>  static int
> @@ -733,8 +769,12 @@ static int hantro_buf_prepare(struct vb2_buffer *vb)
>          * (for OUTPUT buffers, if userspace passes 0 bytesused, v4l2-core sets
>          * it to buffer length).
>          */
> -       if (V4L2_TYPE_IS_CAPTURE(vq->type))
> -               vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
> +       if (V4L2_TYPE_IS_CAPTURE(vq->type)) {
> +               if (ctx->is_encoder)
> +                       vb2_set_plane_payload(vb, 0, 0);
> +               else
> +                       vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
> +       }
>
>         return 0;
>  }
> @@ -744,6 +784,22 @@ static void hantro_buf_queue(struct vb2_buffer *vb)
>         struct hantro_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
>         struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>
> +       if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
> +           vb2_is_streaming(vb->vb2_queue) &&
> +           v4l2_m2m_dst_buf_is_last(ctx->fh.m2m_ctx)) {
> +               unsigned int i;
> +
> +               for (i = 0; i < vb->num_planes; i++)
> +                       vb->planes[i].bytesused = 0;
> +
> +               vbuf->field = V4L2_FIELD_NONE;
> +               vbuf->sequence = ctx->sequence_cap++;
> +
> +               v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, vbuf);
> +               v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +               return;
> +       }
> +
>         v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
>  }
>
> @@ -759,6 +815,8 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
>         struct hantro_ctx *ctx = vb2_get_drv_priv(q);
>         int ret = 0;
>
> +       v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
> +
>         if (V4L2_TYPE_IS_OUTPUT(q->type))
>                 ctx->sequence_out = 0;
>         else
> @@ -831,6 +889,12 @@ static void hantro_stop_streaming(struct vb2_queue *q)
>                 hantro_return_bufs(q, v4l2_m2m_src_buf_remove);
>         else
>                 hantro_return_bufs(q, v4l2_m2m_dst_buf_remove);
> +
> +       v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
> +
> +       if (V4L2_TYPE_IS_OUTPUT(q->type) &&
> +           v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> +               v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
>  }
>
>  static void hantro_buf_request_complete(struct vb2_buffer *vb)
> --
> 2.35.1.265.g69c8d7142f-goog
>
