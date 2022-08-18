Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF57598BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbiHRSq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345571AbiHRSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:46:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31DBD0A2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:46:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i7so1776947qka.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=lzkUZE3SbB6knM+cp4IPevBITr7hUSYqXyu5Jtlx7nk=;
        b=iM3JFG9QyRwmZ3L5tS49u/zNMirhTODOnPF9TGFFWp/obzbfk24c4zaVon2mwil9hj
         vC3AlGPh2E1Nxbkke97QoUqhSt53/7DSkPwvGO0UvbGokYXQgwR7hzU+zkSoFFeiMxaY
         2J1iL5Cwy7ZYy02XJHCWNECBMqxc2e3PNDaI8ygNDuuXfSe7pkKDFtE4gf3cl/MAcKYs
         L7pB3GU13TQMV5p2Xhwt73zZMiyvddOIJLkdosgIkGzJvcjknpbg324d1Gkoy1/i7UqF
         9d26IzW8uRJunlKfus7MIrLCNriZCynegpOjIkwbO6/dlfyFXDiPOGO4LHAmdQQquW3W
         3Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=lzkUZE3SbB6knM+cp4IPevBITr7hUSYqXyu5Jtlx7nk=;
        b=bEa84muTRbMoUUPlSWolDM18jVksuPrdj9WXJikLRYiIl45ZHu+vuaxvKGkSu44ImY
         +DeptIAlT/Hbf/GF2G8MOCQPE7pteTiLDDSL06d5NPIJ2gMnFYhHXcVDa/gMYmbnKSmQ
         W3PZk5JHGseYwgnvC1MNHpTVQWklRvAOyoY5IDU+K8TzQO7rDiZRaqJCQvw+P5TMEwdl
         L5BUwbtA0oCoQzFXUe3WqFegVTsT24OYP9OtqBzD44uBavGuUXKtS3YvzmTnvROnTYt2
         zUivlcQ7oxcp6vhjzxvxhEDTf9EVZI1MkfbpSFFeOzmdRalS2R8CfCg36c33V0xhmMcd
         lkrg==
X-Gm-Message-State: ACgBeo0cWm3xWTKYjuAdImI9/oWXMkKuriqL8WtPrAYSvJ1TRR3qTEiz
        ccOH0cZ6tB/wRNa/IHcmi4DO2A==
X-Google-Smtp-Source: AA6agR5ql+q+3SuNDzHJIIBZfRnaoC3k3Yl+5u+CDpmuhOodqXFFHMjvZhiyGfGRy/VuGqmtWP+fmA==
X-Received: by 2002:a37:5383:0:b0:6b6:48cc:bd55 with SMTP id h125-20020a375383000000b006b648ccbd55mr3092426qkb.136.1660848360497;
        Thu, 18 Aug 2022 11:46:00 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id bj25-20020a05620a191900b006b93ef659c3sm2129457qkb.39.2022.08.18.11.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 11:45:59 -0700 (PDT)
Message-ID: <478504584ebaa8b4d6d3263848ef1d2edc19d20c.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/2] cedrus: Use vb2_find_buffer
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Date:   Thu, 18 Aug 2022 14:45:58 -0400
In-Reply-To: <20220718220211.97995-1-ezequiel@vanguardiasur.com.ar>
References: <20220718220211.97995-1-ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 18 juillet 2022 =C3=A0 19:02 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> given a buffer timestamp.
>=20
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Acked-by: Tomasz Figa <tfiga@chromium.org>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> v3: Rebased on top of https://patchwork.linuxtv.org/project/linux-media/p=
atch/20220718165649.16407-1-jernej.skrabec@gmail.com/
>=20
>  drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
>  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 18 ++++----
>  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
>  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++---------------
>  5 files changed, 47 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.h
> index 084193019350..2aa2961dbf64 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -237,19 +237,23 @@ static inline dma_addr_t cedrus_buf_addr(struct vb2=
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
> index c345e67ba9bc..a8b236cd3800 100644
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
> index 687f87598f78..f703c585d91c 100644
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
>  	};
>  	u32 offset =3D VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
> @@ -141,18 +141,18 @@ static void cedrus_h265_frame_info_write_dpb(struct=
 cedrus_ctx *ctx,
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < num_active_dpb_entries; i++) {
> -		int buffer_index =3D vb2_find_timestamp(vq, dpb[i].timestamp, 0);
> +		struct vb2_buffer *buf =3D vb2_find_buffer(vq, dpb[i].timestamp);
>  		u32 pic_order_cnt[2] =3D {
>  			dpb[i].pic_order_cnt_val,
>  			dpb[i].pic_order_cnt_val
>  		};
> =20
> -		if (buffer_index < 0)
> +		if (!buf)
>  			continue;
> =20
>  		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
>  						    pic_order_cnt,
> -						    buffer_index);
> +						    buf);
>  	}
>  }
> =20
> @@ -751,7 +751,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, =
struct cedrus_run *run)
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
> index 4cfc4a3c8a7f..c1128d2cd555 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> @@ -54,13 +54,9 @@ static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, =
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
> @@ -123,27 +119,19 @@ static int cedrus_mpeg2_setup(struct cedrus_ctx *ct=
x, struct cedrus_run *run)
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
> index 3f750d1795b6..f7714baae37d 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> @@ -660,7 +660,6 @@ static int cedrus_vp8_setup(struct cedrus_ctx *ctx, s=
truct cedrus_run *run)
>  	dma_addr_t luma_addr, chroma_addr;
>  	dma_addr_t src_buf_addr;
>  	int header_size;
> -	int qindex;
>  	u32 reg;
> =20
>  	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
> @@ -804,43 +803,17 @@ static int cedrus_vp8_setup(struct cedrus_ctx *ctx,=
 struct cedrus_run *run)
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

