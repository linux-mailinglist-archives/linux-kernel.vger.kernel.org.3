Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BE5755CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbiGNT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiGNT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:26:23 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3545519C2F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:26:22 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y3so2246257qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=+gYxiGeNwSnxrOHvYL0WF6fKNuyAdJ9/QVdhWkWOvuk=;
        b=cXXqWxTmJ9Z32WDyTnYkOI664Wl/VCwjxAPPf7bx9bcDUAd10vZ1yelsgQGuJ7YekA
         /h2X8+c/KySbSWfGNZC102byNQ3TVlOzB4sCTsvYBzBKsGQfZbATrkUjDkctOgm9DDat
         3B8w+CahBjG0eF7/71Zpy7upOJFqW/44l5o34tIMDLyAL0n1f+RJFmxrqVw90gScqdsP
         9x1wj4+2RnrtIJZoqk384GYV8/A/v3rqJFR/gS2UiowV/bfF2izBzTj4TOgDDoax6p2E
         PHpRW1kBFCrJmpxPHgxoE8JSbs9eiRqxiWtjnnPFVAJ8zl6c59vsIqQu9HWhJbuXbVLM
         y22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=+gYxiGeNwSnxrOHvYL0WF6fKNuyAdJ9/QVdhWkWOvuk=;
        b=BK9r7N15kUWXtXndErE5IrDxXGwuLWhQ7g7SCfHzzBOE1gVFrxVmYR3XMt9BXQPWIS
         C9rNm1Hyi+JDzouKbDmmBEirkjlKcUa7FJxGdqMLhaJGbHV6hnfS528FvJ4rkT+0dlPl
         jRrtDlbkG43qyudET/rAtIZF+NsdOgYkKo9TtzQ2g4TQazdAbj5cs8X8o0pSHZu/MBrU
         ceGKnZXhbmn4w58U0f4WSxQsuv8eNIsbxqu4yMd7RfQBaq0VlbI0NItIhN2eIlsPjxOj
         e4Ktrc20yB1BBwJdZZEJFb9z0HTXoLbuvqbOhveEEa6EFfENMuMOmdMRgIpXOCMNv3iN
         ts+w==
X-Gm-Message-State: AJIora/AJwUV014A8LCsq9IsrwuQrOJEIunt6Uq/A7WUVRauxadU9v74
        xto/iQHOauG+MES5rgL8fO43Q/h51iRjSw==
X-Google-Smtp-Source: AGRyM1sd30FR5aV+vdtUAkG1bMqur8bvVoVIQIodIku12V3zcYrNaSsd7CkEyevXKIosqENIPgTuvg==
X-Received: by 2002:a05:622a:83:b0:31d:3362:7ef4 with SMTP id o3-20020a05622a008300b0031d33627ef4mr9559892qtw.32.1657826781297;
        Thu, 14 Jul 2022 12:26:21 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id n24-20020ac86758000000b0031ed8ef7982sm507985qtp.22.2022.07.14.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:26:20 -0700 (PDT)
Message-ID: <5da2b3547f86e74c86a95300df82609a0cf7406e.camel@ndufresne.ca>
Subject: Re: [PATCH v2 7/8] cedrus: Use vb2_find_buffer
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Date:   Thu, 14 Jul 2022 15:26:18 -0400
In-Reply-To: <20220711211141.349902-8-ezequiel@vanguardiasur.com.ar>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
         <20220711211141.349902-8-ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

I started testing with these patches and found some NULL dreferences, see m=
y
comment inline...

Le lundi 11 juillet 2022 =C3=A0 18:11 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> given a buffer timestamp.
>=20
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Acked-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
>  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++----
>  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
>  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++---------------
>  5 files changed, 46 insertions(+), 81 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.h
> index 3bc094eb497f..c054dbe3d3bc 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -233,19 +233,23 @@ static inline dma_addr_t cedrus_buf_addr(struct vb2=
_buffer *buf,
>  }
> =20
>  static inline dma_addr_t cedrus_dst_buf_addr(struct cedrus_ctx *ctx,
> -					     int index, unsigned int plane)
> +					     struct vb2_buffer *buf,
> +					     unsigned int plane)
>  {
> -	struct vb2_buffer *buf =3D NULL;
> -	struct vb2_queue *vq;
> -
> -	if (index < 0)
> -		return 0;
> +	return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> +}
> =20
> -	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> -	if (vq)
> -		buf =3D vb2_get_buffer(vq, index);
> +static inline void cedrus_write_ref_buf_addr(struct cedrus_ctx *ctx,
> +					     struct vb2_queue *q,
> +					     u64 timestamp,
> +					     u32 luma_reg,
> +					     u32 chroma_reg)
> +{
> +       struct cedrus_dev *dev =3D ctx->dev;
> +       struct vb2_buffer *buf =3D vb2_find_buffer(q, timestamp);
> =20
> -	return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> +       cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf, 0));
> +       cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, buf, 1));
>  }
> =20
>  static inline struct cedrus_buffer *
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
> index d8fb93035470..0559efeac125 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -111,16 +111,16 @@ static void cedrus_write_frame_list(struct cedrus_c=
tx *ctx,
>  	for (i =3D 0; i < ARRAY_SIZE(decode->dpb); i++) {
>  		const struct v4l2_h264_dpb_entry *dpb =3D &decode->dpb[i];
>  		struct cedrus_buffer *cedrus_buf;
> -		int buf_idx;
> +		struct vb2_buffer *buf;
> =20
>  		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
>  			continue;
> =20
> -		buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_ts, 0);
> -		if (buf_idx < 0)
> +		buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> +		if (!buf)
>  			continue;
> =20
> -		cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_idx]);
> +		cedrus_buf =3D vb2_to_cedrus_buffer(buf);
>  		position =3D cedrus_buf->codec.h264.position;
>  		used_dpbs |=3D BIT(position);
> =20
> @@ -186,7 +186,7 @@ static void _cedrus_write_ref_list(struct cedrus_ctx =
*ctx,
>  		const struct v4l2_h264_dpb_entry *dpb;
>  		const struct cedrus_buffer *cedrus_buf;
>  		unsigned int position;
> -		int buf_idx;
> +		struct vb2_buffer *buf;
>  		u8 dpb_idx;
> =20
>  		dpb_idx =3D ref_list[i].index;
> @@ -195,11 +195,11 @@ static void _cedrus_write_ref_list(struct cedrus_ct=
x *ctx,
>  		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
>  			continue;
> =20
> -		buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_ts, 0);
> -		if (buf_idx < 0)
> +		buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> +		if (!buf)
>  			continue;
> =20
> -		cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_idx]);
> +		cedrus_buf =3D vb2_to_cedrus_buffer(buf);
>  		position =3D cedrus_buf->codec.h264.position;
> =20
>  		sram_array[i] |=3D position << 1;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h265.c
> index 44f385be9f6c..60cc13e4d0a9 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -102,14 +102,14 @@ static void cedrus_h265_frame_info_write_single(str=
uct cedrus_ctx *ctx,
>  						unsigned int index,
>  						bool field_pic,
>  						u32 pic_order_cnt[],
> -						int buffer_index)
> +						struct vb2_buffer *buf)
>  {
>  	struct cedrus_dev *dev =3D ctx->dev;
> -	dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buffer_index, 0);
> -	dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, buffer_index, 1=
);
> +	dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buf, 0);
> +	dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, buf, 1);
>  	dma_addr_t mv_col_buf_addr[2] =3D {
> -		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_index, 0),
> -		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_index,
> +		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index, 0),
> +		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index,
>  						       field_pic ? 1 : 0)

Previously, -1 would be passed to cedrus_h265_frame_info_mv_col_buf_addr(),
which would not find a buffer at that index, and would return 0. Now the co=
de
will crash with a NULL pointer deref.

>  	};
>  	u32 offset =3D VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
> @@ -141,7 +141,7 @@ static void cedrus_h265_frame_info_write_dpb(struct c=
edrus_ctx *ctx,
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < num_active_dpb_entries; i++) {
> -		int buffer_index =3D vb2_find_timestamp(vq, dpb[i].timestamp, 0);
> +		struct vb2_buffer *buf =3D vb2_find_buffer(vq, dpb[i].timestamp);
>  		u32 pic_order_cnt[2] =3D {
>  			dpb[i].pic_order_cnt[0],
>  			dpb[i].pic_order_cnt[1]
> @@ -149,7 +149,7 @@ static void cedrus_h265_frame_info_write_dpb(struct c=
edrus_ctx *ctx,
> =20
>  		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
>  						    pic_order_cnt,
> -						    buffer_index);
> +						    buf);
>  	}
>  }
> =20
> @@ -616,7 +616,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>  	cedrus_h265_frame_info_write_single(ctx, output_pic_list_index,
>  					    slice_params->pic_struct !=3D 0,
>  					    pic_order_cnt,
> -					    run->dst->vb2_buf.index);
> +					    &run->dst->vb2_buf);
> =20
>  	cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX, output_pic_list_index);
> =20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_mpeg2.c
> index 5dad2f296c6d..22d6cae9a710 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> @@ -54,13 +54,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx,=
 struct cedrus_run *run)
>  	const struct v4l2_ctrl_mpeg2_picture *pic;
>  	const struct v4l2_ctrl_mpeg2_quantisation *quantisation;
>  	dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
> -	dma_addr_t fwd_luma_addr, fwd_chroma_addr;
> -	dma_addr_t bwd_luma_addr, bwd_chroma_addr;
>  	struct cedrus_dev *dev =3D ctx->dev;
>  	struct vb2_queue *vq;
>  	const u8 *matrix;
> -	int forward_idx;
> -	int backward_idx;
>  	unsigned int i;
>  	u32 reg;
> =20
> @@ -123,27 +119,19 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *c=
tx, struct cedrus_run *run)
>  	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> =20
>  	/* Forward and backward prediction reference buffers. */
> -
>  	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> =20
> -	forward_idx =3D vb2_find_timestamp(vq, pic->forward_ref_ts, 0);
> -	fwd_luma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 0);
> -	fwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 1);
> -
> -	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
> -	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
> -
> -	backward_idx =3D vb2_find_timestamp(vq, pic->backward_ref_ts, 0);
> -	bwd_luma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 0);
> -	bwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 1);
> -
> -	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_addr);
> -	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR, bwd_chroma_addr);
> +	cedrus_write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
> +				  VE_DEC_MPEG_FWD_REF_LUMA_ADDR,
> +				  VE_DEC_MPEG_FWD_REF_CHROMA_ADDR);
> +	cedrus_write_ref_buf_addr(ctx, vq, pic->backward_ref_ts,
> +				  VE_DEC_MPEG_BWD_REF_LUMA_ADDR,
> +				  VE_DEC_MPEG_BWD_REF_CHROMA_ADDR);
> =20
>  	/* Destination luma and chroma buffers. */
> =20
> -	dst_luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
> -	dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1=
);
> +	dst_luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
> +	dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
> =20
>  	cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
>  	cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/st=
aging/media/sunxi/cedrus/cedrus_vp8.c
> index f4016684b32d..196cf692186d 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> @@ -661,7 +661,6 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
>  	dma_addr_t luma_addr, chroma_addr;
>  	dma_addr_t src_buf_addr;
>  	int header_size;
> -	int qindex;
>  	u32 reg;
> =20
>  	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
> @@ -805,43 +804,17 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx=
,
>  	reg |=3D VE_VP8_LF_DELTA0(slice->lf.mb_mode_delta[0]);
>  	cedrus_write(dev, VE_VP8_MODE_LF_DELTA, reg);
> =20
> -	luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
> -	chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1);
> +	luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
> +	chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
>  	cedrus_write(dev, VE_VP8_REC_LUMA, luma_addr);
>  	cedrus_write(dev, VE_VP8_REC_CHROMA, chroma_addr);
> =20
> -	qindex =3D vb2_find_timestamp(cap_q, slice->last_frame_ts, 0);
> -	if (qindex >=3D 0) {
> -		luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> -		chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> -		cedrus_write(dev, VE_VP8_FWD_LUMA, luma_addr);
> -		cedrus_write(dev, VE_VP8_FWD_CHROMA, chroma_addr);
> -	} else {
> -		cedrus_write(dev, VE_VP8_FWD_LUMA, 0);
> -		cedrus_write(dev, VE_VP8_FWD_CHROMA, 0);
> -	}
> -
> -	qindex =3D vb2_find_timestamp(cap_q, slice->golden_frame_ts, 0);
> -	if (qindex >=3D 0) {
> -		luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> -		chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> -		cedrus_write(dev, VE_VP8_BWD_LUMA, luma_addr);
> -		cedrus_write(dev, VE_VP8_BWD_CHROMA, chroma_addr);
> -	} else {
> -		cedrus_write(dev, VE_VP8_BWD_LUMA, 0);
> -		cedrus_write(dev, VE_VP8_BWD_CHROMA, 0);
> -	}
> -
> -	qindex =3D vb2_find_timestamp(cap_q, slice->alt_frame_ts, 0);
> -	if (qindex >=3D 0) {
> -		luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> -		chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> -		cedrus_write(dev, VE_VP8_ALT_LUMA, luma_addr);
> -		cedrus_write(dev, VE_VP8_ALT_CHROMA, chroma_addr);
> -	} else {
> -		cedrus_write(dev, VE_VP8_ALT_LUMA, 0);
> -		cedrus_write(dev, VE_VP8_ALT_CHROMA, 0);
> -	}
> +	cedrus_write_ref_buf_addr(ctx, cap_q, slice->last_frame_ts,
> +				  VE_VP8_FWD_LUMA, VE_VP8_FWD_CHROMA);
> +	cedrus_write_ref_buf_addr(ctx, cap_q, slice->golden_frame_ts,
> +				  VE_VP8_BWD_LUMA, VE_VP8_BWD_CHROMA);
> +	cedrus_write_ref_buf_addr(ctx, cap_q, slice->alt_frame_ts,
> +				  VE_VP8_ALT_LUMA, VE_VP8_ALT_CHROMA);
> =20
>  	cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8 |
>  		     VE_H264_CTRL_DECODE_ERR_INT |

