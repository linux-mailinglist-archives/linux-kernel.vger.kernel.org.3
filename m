Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E474EB4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiC2UXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiC2UXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A876012221F;
        Tue, 29 Mar 2022 13:21:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 578E21F44141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648585275;
        bh=vQRrvzKL5iI/HHiaWTl6HApMNvA9VvFUqRsD4LQ0zSU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ieMwLKZPZ3Rf7f95INVu006eAU4UNBwaf5/C0NMS5OZqUsBlLbwkNPuWbp3w0Aqqg
         QhDxX8VNyCHrDQBQKjOCSs3Aa1SWWFqRzoPfp2dTkHWVLcUtl0Gg5ssX7N5rSsz+Ir
         Ho+WXZf4L42uet2C/Z3WYGawTgHnW7g91I9JGmU2HYdQa4f3zeTqLzKy/YjZ1Yv2+v
         U5ZAjFSfqqzcjTdPp+eIE1iSVhvcJ5TFcnvIkfqygYzGxxpYswR5AweOTMPjCt8APS
         vOvRrvoTO3KXbt640zAFddaV35VQtsH/YugAw9VXkTKsezpibJDRCalO0WYXvubqhk
         oDV+7fZUoWU6w==
Message-ID: <4a0c00dae364db30d5d8d6af3557588747e33fb6.camel@collabora.com>
Subject: Re: [PATCH v3] media: hantro: Implement support for encoder commands
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Date:   Tue, 29 Mar 2022 16:21:04 -0400
In-Reply-To: <20220301042225.1540019-1-wenst@chromium.org>
References: <20220301042225.1540019-1-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 01 mars 2022 =C3=A0 12:22 +0800, Chen-Yu Tsai a =C3=A9crit=C2=A0:
> The V4L2 stateful encoder uAPI specification requires that drivers
> support the ENCODER_CMD ioctl to allow draining of buffers. This
> however was not implemented, and causes issues for some userspace
> applications.
>=20
> Implement support for the ENCODER_CMD ioctl using v4l2-mem2mem helpers.
> This is entirely based on existing code found in the vicodec test
> driver.
>=20
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

What I tested:

1. That drain flow now works, with

gst-launch-1.0 videotestsrc num-buffers=3D3 ! v4l2jpegenc ! fakesink silent=
=3D0 -v

2. The Hantro decoders are not affect, running fluster with gst for VP8 and
H.264. Note this is on top of my field decoding series, hence the high H.26=
4
score. Score is unchanged.

H.264: 129/135
VP8:   59/61

> ---
>=20
> Changes since v2:
> - Dropped RFC tag
> - Added Reviewed-by from Benjamin
> - Replace direct access to vb->planes[i].bytesused with
>   vb2_set_plane_payload()
>=20
> Changes since v1:
> - Correctly handle last buffers that are empty
> - Correctly handle last buffers that just got queued
> - Disable (TRY_)ENCODER_CMD ioctls for hantro decoder
>=20
> This is based on linux-next-20220208, and was tested on RK3399 with
> Gstreamer running the JPEG encoder. It was also tested on ChromeOS
> 5.10 on Kevin with the video encoder used in ChromeOS ARC, which
> requires this. For ChromeOS, both encoder and decoder tests were run
> to check for regressions.
>=20
> Everything really works OK now, but since I'm not very familiar with
> the mem2mem framework, I might be missing something, causing resource
> leaks. Hence this patch is labeled RFC.
>=20
> Last, I suppose we could also add support for (TRY_)DECODER_CMD now?
>=20
>  drivers/staging/media/hantro/hantro_drv.c  | 17 +++++-
>  drivers/staging/media/hantro/hantro_v4l2.c | 68 +++++++++++++++++++++-
>  2 files changed, 81 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/=
media/hantro/hantro_drv.c
> index bc9bcb4eaf46..99bc650a5a93 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -56,6 +56,10 @@ dma_addr_t hantro_get_ref(struct hantro_ctx *ctx, u64 =
ts)
>  	return hantro_get_dec_buf_addr(ctx, buf);
>  }
> =20
> +static const struct v4l2_event hantro_eos_event =3D {
> +	.type =3D V4L2_EVENT_EOS
> +};
> +
>  static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
>  				    struct hantro_ctx *ctx,
>  				    enum vb2_buffer_state result)
> @@ -73,6 +77,12 @@ static void hantro_job_finish_no_pm(struct hantro_dev =
*vpu,
>  	src->sequence =3D ctx->sequence_out++;
>  	dst->sequence =3D ctx->sequence_cap++;
> =20
> +	if (v4l2_m2m_is_last_draining_src_buf(ctx->fh.m2m_ctx, src)) {
> +		dst->flags |=3D V4L2_BUF_FLAG_LAST;
> +		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +		v4l2_m2m_mark_stopped(ctx->fh.m2m_ctx);
> +	}
> +
>  	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
>  					 result);
>  }
> @@ -807,10 +817,13 @@ static int hantro_add_func(struct hantro_dev *vpu, =
unsigned int funcid)
>  	snprintf(vfd->name, sizeof(vfd->name), "%s-%s", match->compatible,
>  		 funcid =3D=3D MEDIA_ENT_F_PROC_VIDEO_ENCODER ? "enc" : "dec");
> =20
> -	if (funcid =3D=3D MEDIA_ENT_F_PROC_VIDEO_ENCODER)
> +	if (funcid =3D=3D MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>  		vpu->encoder =3D func;
> -	else
> +	} else {
>  		vpu->decoder =3D func;
> +		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
> +		v4l2_disable_ioctl(vfd, VIDIOC_ENCODER_CMD);
> +	}
> =20
>  	video_set_drvdata(vfd, vpu);
> =20
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging=
/media/hantro/hantro_v4l2.c
> index 67148ba346f5..aa10ecd04c9c 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -628,6 +628,39 @@ static int vidioc_s_selection(struct file *file, voi=
d *priv,
>  	return 0;
>  }
> =20
> +static const struct v4l2_event hantro_eos_event =3D {
> +	.type =3D V4L2_EVENT_EOS
> +};
> +
> +static int vidioc_encoder_cmd(struct file *file, void *priv,
> +			      struct v4l2_encoder_cmd *ec)
> +{
> +	struct hantro_ctx *ctx =3D fh_to_ctx(priv);
> +	int ret;
> +
> +	ret =3D v4l2_m2m_ioctl_try_encoder_cmd(file, priv, ec);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)) ||
> +	    !vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
> +		return 0;
> +
> +	ret =3D v4l2_m2m_ioctl_encoder_cmd(file, priv, ec);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ec->cmd =3D=3D V4L2_ENC_CMD_STOP &&
> +	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> +		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +
> +	if (ec->cmd =3D=3D V4L2_ENC_CMD_START &&
> +	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
> +		vb2_clear_last_buffer_dequeued(&ctx->fh.m2m_ctx->cap_q_ctx.q);
> +
> +	return 0;
> +}
> +
>  const struct v4l2_ioctl_ops hantro_ioctl_ops =3D {
>  	.vidioc_querycap =3D vidioc_querycap,
>  	.vidioc_enum_framesizes =3D vidioc_enum_framesizes,
> @@ -657,6 +690,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops =3D {
> =20
>  	.vidioc_g_selection =3D vidioc_g_selection,
>  	.vidioc_s_selection =3D vidioc_s_selection,
> +
> +	.vidioc_try_encoder_cmd =3D v4l2_m2m_ioctl_try_encoder_cmd,
> +	.vidioc_encoder_cmd =3D vidioc_encoder_cmd,
>  };
> =20
>  static int
> @@ -733,8 +769,12 @@ static int hantro_buf_prepare(struct vb2_buffer *vb)
>  	 * (for OUTPUT buffers, if userspace passes 0 bytesused, v4l2-core sets
>  	 * it to buffer length).
>  	 */
> -	if (V4L2_TYPE_IS_CAPTURE(vq->type))
> -		vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
> +	if (V4L2_TYPE_IS_CAPTURE(vq->type)) {
> +		if (ctx->is_encoder)
> +			vb2_set_plane_payload(vb, 0, 0);
> +		else
> +			vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
> +	}
> =20
>  	return 0;
>  }
> @@ -744,6 +784,22 @@ static void hantro_buf_queue(struct vb2_buffer *vb)
>  	struct hantro_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> =20
> +	if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
> +	    vb2_is_streaming(vb->vb2_queue) &&
> +	    v4l2_m2m_dst_buf_is_last(ctx->fh.m2m_ctx)) {
> +		unsigned int i;
> +
> +		for (i =3D 0; i < vb->num_planes; i++)
> +			vb2_set_plane_payload(vb, i, 0);
> +
> +		vbuf->field =3D V4L2_FIELD_NONE;
> +		vbuf->sequence =3D ctx->sequence_cap++;
> +
> +		v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, vbuf);
> +		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
> +		return;
> +	}
> +
>  	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
>  }
> =20
> @@ -759,6 +815,8 @@ static int hantro_start_streaming(struct vb2_queue *q=
, unsigned int count)
>  	struct hantro_ctx *ctx =3D vb2_get_drv_priv(q);
>  	int ret =3D 0;
> =20
> +	v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
> +
>  	if (V4L2_TYPE_IS_OUTPUT(q->type))
>  		ctx->sequence_out =3D 0;
>  	else
> @@ -831,6 +889,12 @@ static void hantro_stop_streaming(struct vb2_queue *=
q)
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
> =20
>  static void hantro_buf_request_complete(struct vb2_buffer *vb)

