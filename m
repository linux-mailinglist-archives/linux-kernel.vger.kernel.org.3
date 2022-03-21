Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC54E1F70
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbiCUEN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiCUEN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:13:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205B4101F36
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 21:12:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e5e176e1b6so65164907b3.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 21:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQsN6lSw3r9N+Wo5F8+nkpqY3bZAfZCQQiLUYeHkfEA=;
        b=cmKxq/gn5+z1JzkYkiHfx3dWKJwTFIpkOVm41BDWc9xey8jA0/CXOVq8BW/6N9aKLL
         uR7H3DCwbwr4dHm/UzhjdYnI8M9bkX9hICFR9OFTq7n6Ci4JvfN6D6ovkOCLtgL3w1yz
         oVFncb+0gi4A8IdnjpZtsoun49Ppt9Fl3IqOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQsN6lSw3r9N+Wo5F8+nkpqY3bZAfZCQQiLUYeHkfEA=;
        b=vgwOlVmROIC3s6zClbAY0vZRYcXSJqUl/QcfDPUe0CAew9pzlj7kmb7lnBCdCyK52N
         lanULlf3oJ8Kw9jDh2f20VKlOLI9FGEmIinNYEDgDQwFeNh3Z1SAWOm8fcXHDk1Ih2zU
         o4dWVYvHk6z+vFVxbKk1wziTjrwFvi9SVdMTBLqWmksNzaXjyNTlEiwGyY02SQUfrzB7
         07rFGEiufYC2yIfgthZaaqiHelEQVGhzO+9f9ibwGawAuaKpkhqmZoQbCALJdI/BR10L
         UOHD8ev94PrWApr6nSyuLSLG5X1i43gVCHCSDwrUai7x0ZHIvb9jGyOaLrni0Ql2Pvwm
         2++Q==
X-Gm-Message-State: AOAM530bzGX7V2J2WgjbSqXOUb3alRcpTzw0ldAbCGCMDLGI9xvblVJR
        f5IvbjndkwRZ8LquaFzh9pJROjSLLk3NRAZdUMWU3A==
X-Google-Smtp-Source: ABdhPJzgVWNYOdR//POqQHOr8YAZvGeBgucFc9r+lCwLsBryQwMayTD53/jijq8YQkIDO9GhkMW8OuUgUDagvfkY5G8=
X-Received: by 2002:a0d:cc4f:0:b0:2e5:e8fa:6754 with SMTP id
 o76-20020a0dcc4f000000b002e5e8fa6754mr12086202ywd.295.1647835950140; Sun, 20
 Mar 2022 21:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220301042225.1540019-1-wenst@chromium.org> <YjcbnmTUaWDtkIb/@eze-laptop>
In-Reply-To: <YjcbnmTUaWDtkIb/@eze-laptop>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 21 Mar 2022 12:12:19 +0800
Message-ID: <CAGXv+5Em4CAYYMfg0_9kzYaPHhu3w8fwpfArE5FFkShp8A2DtQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: hantro: Implement support for encoder commands
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 8:18 PM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Hi Chen-Yu, Benjamin, Nicolas,
>
> Sorry for the late review.
>
> On Tue, Mar 01, 2022 at 12:22:25PM +0800, Chen-Yu Tsai wrote:
> > The V4L2 stateful encoder uAPI specification requires that drivers
> > support the ENCODER_CMD ioctl to allow draining of buffers. This
> > however was not implemented, and causes issues for some userspace
> > applications.
> >
> > Implement support for the ENCODER_CMD ioctl using v4l2-mem2mem helpers.
> > This is entirely based on existing code found in the vicodec test
> > driver.
> >
> > Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> >
> > Changes since v2:
> > - Dropped RFC tag
> > - Added Reviewed-by from Benjamin
> > - Replace direct access to vb->planes[i].bytesused with
> >   vb2_set_plane_payload()
> >
> > Changes since v1:
> > - Correctly handle last buffers that are empty
> > - Correctly handle last buffers that just got queued
> > - Disable (TRY_)ENCODER_CMD ioctls for hantro decoder
> >
> > This is based on linux-next-20220208, and was tested on RK3399 with
> > Gstreamer running the JPEG encoder. It was also tested on ChromeOS
> > 5.10 on Kevin with the video encoder used in ChromeOS ARC, which
> > requires this. For ChromeOS, both encoder and decoder tests were run
> > to check for regressions.
> >
>
> Sounds great, thanks for running those tests!
>
> > Everything really works OK now, but since I'm not very familiar with
> > the mem2mem framework, I might be missing something, causing resource
> > leaks. Hence this patch is labeled RFC.
> >
>
> It would be great to apply this to a mainline-ish kernel,
> and run some fluster and some stress-tests to ensure this is not
> regressing decoding in some way.

I can try to get the fluster suite running.

Not sure what stress-tests you had in mind though? Upstream only has the
JPEG encoder. Maybe multiple gstreamer encoding/decoding instances running
in parallel? Or even multiple fluster runs in parallel?

I had just put my RK3399 device away though. Have to dig it out again.

> > Last, I suppose we could also add support for (TRY_)DECODER_CMD now?
> >
> >  drivers/staging/media/hantro/hantro_drv.c  | 17 +++++-
> >  drivers/staging/media/hantro/hantro_v4l2.c | 68 +++++++++++++++++++++-
> >  2 files changed, 81 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> > index bc9bcb4eaf46..99bc650a5a93 100644
> > --- a/drivers/staging/media/hantro/hantro_drv.c
> > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > @@ -56,6 +56,10 @@ dma_addr_t hantro_get_ref(struct hantro_ctx *ctx, u64 ts)
> >       return hantro_get_dec_buf_addr(ctx, buf);
> >  }
> >
> > +static const struct v4l2_event hantro_eos_event = {
> > +     .type = V4L2_EVENT_EOS
> > +};
> > +
> >  static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
> >                                   struct hantro_ctx *ctx,
> >                                   enum vb2_buffer_state result)
> > @@ -73,6 +77,12 @@ static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
> >       src->sequence = ctx->sequence_out++;
> >       dst->sequence = ctx->sequence_cap++;
> >
> > +     if (v4l2_m2m_is_last_draining_src_buf(ctx->fh.m2m_ctx, src)) {
> > +             dst->flags |= V4L2_BUF_FLAG_LAST;
> > +             v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> > +             v4l2_m2m_mark_stopped(ctx->fh.m2m_ctx);
> > +     }
> > +
> >       v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
> >                                        result);
> >  }
> > @@ -807,10 +817,13 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
> >       snprintf(vfd->name, sizeof(vfd->name), "%s-%s", match->compatible,
> >                funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ? "enc" : "dec");
> >
> > -     if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER)
> > +     if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
> >               vpu->encoder = func;
> > -     else
> > +     } else {
> >               vpu->decoder = func;
> > +             v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
> > +             v4l2_disable_ioctl(vfd, VIDIOC_ENCODER_CMD);
> > +     }
> >
> >       video_set_drvdata(vfd, vpu);
> >
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> > index 67148ba346f5..aa10ecd04c9c 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > @@ -628,6 +628,39 @@ static int vidioc_s_selection(struct file *file, void *priv,
> >       return 0;
> >  }
> >
> > +static const struct v4l2_event hantro_eos_event = {
> > +     .type = V4L2_EVENT_EOS
> > +};
> > +
> > +static int vidioc_encoder_cmd(struct file *file, void *priv,
> > +                           struct v4l2_encoder_cmd *ec)
> > +{
> > +     struct hantro_ctx *ctx = fh_to_ctx(priv);
> > +     int ret;
> > +
> > +     ret = v4l2_m2m_ioctl_try_encoder_cmd(file, priv, ec);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (!vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)) ||
> > +         !vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
> > +             return 0;
> > +
> > +     ret = v4l2_m2m_ioctl_encoder_cmd(file, priv, ec);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (ec->cmd == V4L2_ENC_CMD_STOP &&
> > +         v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> > +             v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> > +
> > +     if (ec->cmd == V4L2_ENC_CMD_START &&
> > +         v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
>
> This looks odd. The has_stopped flag is cleared by calling
> v4l2_m2m_ioctl_encoder_cmd so I can't see how it could be set here.
>
> This same pattern is in the vicodec driver, the change was introduced
> in d4d137de5f31d318ed9acdcdf359b9bd3920808b.

Looking at the commit you pointed out, it seems the original intent was to
check the prior state. So it looks like d4d137de5f31d318ed9acdcdf359b9bd3920808b
introduced a bug.

I'll take care of both drivers.

> > +             vb2_clear_last_buffer_dequeued(&ctx->fh.m2m_ctx->cap_q_ctx.q);
> > +
> > +     return 0;
> > +}
> > +
> >  const struct v4l2_ioctl_ops hantro_ioctl_ops = {
> >       .vidioc_querycap = vidioc_querycap,
> >       .vidioc_enum_framesizes = vidioc_enum_framesizes,
> > @@ -657,6 +690,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
> >
> >       .vidioc_g_selection = vidioc_g_selection,
> >       .vidioc_s_selection = vidioc_s_selection,
> > +
> > +     .vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
> > +     .vidioc_encoder_cmd = vidioc_encoder_cmd,
> >  };
> >
> >  static int
> > @@ -733,8 +769,12 @@ static int hantro_buf_prepare(struct vb2_buffer *vb)
> >        * (for OUTPUT buffers, if userspace passes 0 bytesused, v4l2-core sets
> >        * it to buffer length).
> >        */
> > -     if (V4L2_TYPE_IS_CAPTURE(vq->type))
> > -             vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
> > +     if (V4L2_TYPE_IS_CAPTURE(vq->type)) {
> > +             if (ctx->is_encoder)
> > +                     vb2_set_plane_payload(vb, 0, 0);
>
> This looks like some fix, that could be applied independently of this patch?

Yes. I seem to have accidentally squashed that in. Of the top of my head,
I think this was clearing the capture buffers to be empty, so unused
buffers returned to userspace do look "unused".

I'll split this out.


Thanks
ChenYu

> > +             else
> > +                     vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
> > +     }
> >
> >       return 0;
> >  }
> > @@ -744,6 +784,22 @@ static void hantro_buf_queue(struct vb2_buffer *vb)
> >       struct hantro_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> >       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> >
> > +     if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
> > +         vb2_is_streaming(vb->vb2_queue) &&
> > +         v4l2_m2m_dst_buf_is_last(ctx->fh.m2m_ctx)) {
> > +             unsigned int i;
> > +
> > +             for (i = 0; i < vb->num_planes; i++)
> > +                     vb2_set_plane_payload(vb, i, 0);
> > +
> > +             vbuf->field = V4L2_FIELD_NONE;
> > +             vbuf->sequence = ctx->sequence_cap++;
> > +
> > +             v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, vbuf);
> > +             v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> > +             return;
> > +     }
> > +
> >       v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
> >  }
> >
> > @@ -759,6 +815,8 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
> >       struct hantro_ctx *ctx = vb2_get_drv_priv(q);
> >       int ret = 0;
> >
> > +     v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
> > +
> >       if (V4L2_TYPE_IS_OUTPUT(q->type))
> >               ctx->sequence_out = 0;
> >       else
> > @@ -831,6 +889,12 @@ static void hantro_stop_streaming(struct vb2_queue *q)
> >               hantro_return_bufs(q, v4l2_m2m_src_buf_remove);
> >       else
> >               hantro_return_bufs(q, v4l2_m2m_dst_buf_remove);
> > +
> > +     v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
> > +
> > +     if (V4L2_TYPE_IS_OUTPUT(q->type) &&
> > +         v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> > +             v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> >  }
> >
> >  static void hantro_buf_request_complete(struct vb2_buffer *vb)
> > --
> > 2.35.1.574.g5d30c73bfb-goog
> >
>
> Thanks,
> Ezequiel
