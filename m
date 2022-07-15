Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1808E5760DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiGOLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiGOLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:48:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C1211A2D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:48:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz17so8522512ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cdH5B1vSB1L8HwoPaLd5k9y/wu8/TUxAVecCz+RBuus=;
        b=pBzYJSxI7FZyGMkxN9p15LAeEH3XMycglCRDwWhHjBg876H4zxr8kFH0rMXw2CHTaS
         hU1f0yEKJb8Et4gQlmL9oIHBcnKqw2GUfwfnnC+pKGt0GXldMObpdEIxPlYnMqPY79kw
         88vFebYDMT1wvIWvMt0NnRWmVnX/8bYklM5lwg7KcxvnehpDskQLkZk/l0+PybYe7Nax
         WqLNLMhjR4tIjSGXI0LcLYNiT8PlTz9q+PEQUgNLVS24fASj0rlNfNncl5OEKrQk/UeO
         II1vU8utodxosolleWrFPBRdkUDzzi+TBQl2DYZvNpny1+SXykEq6Ilma7uE+alpI1Sv
         2Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cdH5B1vSB1L8HwoPaLd5k9y/wu8/TUxAVecCz+RBuus=;
        b=TFNm409+vNAf3VuX2uygk0GLkfLg49wAj8tvNkd9F6NQeqkbchqWmvoIJYj3WTJM1w
         huNk0sGbHFh7R0DtTw2MKDSsAmwACLFnpxBvisaJC4z9R9rsn7KtmtFLKYTO+82ztMIa
         8qcZTbrREKJcXtrPSMXjFu2FLLOhhf0ERPYHT3/IkaqgHsZWizQBNTMI7XBj3UHYOK34
         TBZPAwhdpDf3nJRApb5rByPIt78oyXldzuqBWC52JBHTF6lr9h6m2+JBfkG3BtM/jB0U
         6aXiHP3W/aiU/GVMgCn9Rb77m0kufI1SU3Tb0hbeFBgIwLXijm58qMKSej7YA9Li1JTp
         TMIQ==
X-Gm-Message-State: AJIora96iiSWQqpGDNsIS6hRXSr+eEwquot1FO7nvhR8mJfN2Y3z2/bJ
        7gWb4EmBxMCBjkvt2go170tmx9X4XpJ19I4O54ryAQ==
X-Google-Smtp-Source: AGRyM1v2YuDKjAYPRpfv9msxqP4Lr3c4dt07SND13Cld9U1s+ur5tZmLU3eyXIf/RO/6SNnau6LIRZgPLqKjdvyRVc4=
X-Received: by 2002:a17:907:7394:b0:72b:44ff:5cec with SMTP id
 er20-20020a170907739400b0072b44ff5cecmr13945351ejc.670.1657885725624; Fri, 15
 Jul 2022 04:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
 <20220711211141.349902-8-ezequiel@vanguardiasur.com.ar> <5da2b3547f86e74c86a95300df82609a0cf7406e.camel@ndufresne.ca>
In-Reply-To: <5da2b3547f86e74c86a95300df82609a0cf7406e.camel@ndufresne.ca>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 15 Jul 2022 08:48:34 -0300
Message-ID: <CAAEAJfDuX9Dq6QCtZhO_yoBZh6mgtePx5SwjeQgzZjkUiG8-zw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cedrus: Use vb2_find_buffer
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks a lot for the test and the bug report.

On Thu, Jul 14, 2022 at 4:26 PM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Hi Ezequiel,
>
> I started testing with these patches and found some NULL dreferences, see=
 my
> comment inline...
>
> Le lundi 11 juillet 2022 =C3=A0 18:11 -0300, Ezequiel Garcia a =C3=A9crit=
 :
> > Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> > given a buffer timestamp.
> >
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > Acked-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >  drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
> >  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
> >  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++----
> >  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
> >  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++---------------
> >  5 files changed, 46 insertions(+), 81 deletions(-)
> >
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/stag=
ing/media/sunxi/cedrus/cedrus.h
> > index 3bc094eb497f..c054dbe3d3bc 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> > @@ -233,19 +233,23 @@ static inline dma_addr_t cedrus_buf_addr(struct v=
b2_buffer *buf,
> >  }
> >
> >  static inline dma_addr_t cedrus_dst_buf_addr(struct cedrus_ctx *ctx,
> > -                                          int index, unsigned int plan=
e)
> > +                                          struct vb2_buffer *buf,
> > +                                          unsigned int plane)
> >  {
> > -     struct vb2_buffer *buf =3D NULL;
> > -     struct vb2_queue *vq;
> > -
> > -     if (index < 0)
> > -             return 0;
> > +     return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> > +}
> >
> > -     vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTU=
RE);
> > -     if (vq)
> > -             buf =3D vb2_get_buffer(vq, index);
> > +static inline void cedrus_write_ref_buf_addr(struct cedrus_ctx *ctx,
> > +                                          struct vb2_queue *q,
> > +                                          u64 timestamp,
> > +                                          u32 luma_reg,
> > +                                          u32 chroma_reg)
> > +{
> > +       struct cedrus_dev *dev =3D ctx->dev;
> > +       struct vb2_buffer *buf =3D vb2_find_buffer(q, timestamp);
> >
> > -     return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> > +       cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf, 0));
> > +       cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, buf, 1))=
;
> >  }
> >
> >  static inline struct cedrus_buffer *
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers=
/staging/media/sunxi/cedrus/cedrus_h264.c
> > index d8fb93035470..0559efeac125 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > @@ -111,16 +111,16 @@ static void cedrus_write_frame_list(struct cedrus=
_ctx *ctx,
> >       for (i =3D 0; i < ARRAY_SIZE(decode->dpb); i++) {
> >               const struct v4l2_h264_dpb_entry *dpb =3D &decode->dpb[i]=
;
> >               struct cedrus_buffer *cedrus_buf;
> > -             int buf_idx;
> > +             struct vb2_buffer *buf;
> >
> >               if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> >                       continue;
> >
> > -             buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_ts, =
0);
> > -             if (buf_idx < 0)
> > +             buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> > +             if (!buf)
> >                       continue;
> >
> > -             cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_idx])=
;
> > +             cedrus_buf =3D vb2_to_cedrus_buffer(buf);
> >               position =3D cedrus_buf->codec.h264.position;
> >               used_dpbs |=3D BIT(position);
> >
> > @@ -186,7 +186,7 @@ static void _cedrus_write_ref_list(struct cedrus_ct=
x *ctx,
> >               const struct v4l2_h264_dpb_entry *dpb;
> >               const struct cedrus_buffer *cedrus_buf;
> >               unsigned int position;
> > -             int buf_idx;
> > +             struct vb2_buffer *buf;
> >               u8 dpb_idx;
> >
> >               dpb_idx =3D ref_list[i].index;
> > @@ -195,11 +195,11 @@ static void _cedrus_write_ref_list(struct cedrus_=
ctx *ctx,
> >               if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> >                       continue;
> >
> > -             buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_ts, =
0);
> > -             if (buf_idx < 0)
> > +             buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> > +             if (!buf)
> >                       continue;
> >
> > -             cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_idx])=
;
> > +             cedrus_buf =3D vb2_to_cedrus_buffer(buf);
> >               position =3D cedrus_buf->codec.h264.position;
> >
> >               sram_array[i] |=3D position << 1;
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers=
/staging/media/sunxi/cedrus/cedrus_h265.c
> > index 44f385be9f6c..60cc13e4d0a9 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > @@ -102,14 +102,14 @@ static void cedrus_h265_frame_info_write_single(s=
truct cedrus_ctx *ctx,
> >                                               unsigned int index,
> >                                               bool field_pic,
> >                                               u32 pic_order_cnt[],
> > -                                             int buffer_index)
> > +                                             struct vb2_buffer *buf)
> >  {
> >       struct cedrus_dev *dev =3D ctx->dev;
> > -     dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buffer_inde=
x, 0);
> > -     dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, buffer_in=
dex, 1);
> > +     dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buf, 0);
> > +     dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, buf, 1);
> >       dma_addr_t mv_col_buf_addr[2] =3D {
> > -             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_index,=
 0),
> > -             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_index,
> > +             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index, 0=
),
> > +             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index,
> >                                                      field_pic ? 1 : 0)
>
> Previously, -1 would be passed to cedrus_h265_frame_info_mv_col_buf_addr(=
),
> which would not find a buffer at that index, and would return 0. Now the =
code
> will crash with a NULL pointer deref.
>

Is it really correct to pass -1 to cedrus_h265_frame_info_mv_col_buf_addr?
It seems it get casted into an unsigned type and then used to calculate
an address for DMA.

static inline dma_addr_t
cedrus_h265_frame_info_mv_col_buf_addr(struct cedrus_ctx *ctx,
                                       unsigned int index, unsigned int fie=
ld)
{
        return ctx->codec.h265.mv_col_buf_addr + index *
               ctx->codec.h265.mv_col_buf_unit_size +
               field * ctx->codec.h265.mv_col_buf_unit_size / 2;
}

Fixing the driver to go back to the previous behavior is trivial,
but this looks odd.

Jernej, Paul, any thoughts?

Thanks,
Ezequiel

> >       };
> >       u32 offset =3D VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
> > @@ -141,7 +141,7 @@ static void cedrus_h265_frame_info_write_dpb(struct=
 cedrus_ctx *ctx,
> >       unsigned int i;
> >
> >       for (i =3D 0; i < num_active_dpb_entries; i++) {
> > -             int buffer_index =3D vb2_find_timestamp(vq, dpb[i].timest=
amp, 0);
> > +             struct vb2_buffer *buf =3D vb2_find_buffer(vq, dpb[i].tim=
estamp);
> >               u32 pic_order_cnt[2] =3D {
> >                       dpb[i].pic_order_cnt[0],
> >                       dpb[i].pic_order_cnt[1]
> > @@ -149,7 +149,7 @@ static void cedrus_h265_frame_info_write_dpb(struct=
 cedrus_ctx *ctx,
> >
> >               cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_=
pic,
> >                                                   pic_order_cnt,
> > -                                                 buffer_index);
> > +                                                 buf);
> >       }
> >  }
> >
> > @@ -616,7 +616,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ct=
x,
> >       cedrus_h265_frame_info_write_single(ctx, output_pic_list_index,
> >                                           slice_params->pic_struct !=3D=
 0,
> >                                           pic_order_cnt,
> > -                                         run->dst->vb2_buf.index);
> > +                                         &run->dst->vb2_buf);
> >
> >       cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX, output_pic_list_i=
ndex);
> >
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/driver=
s/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > index 5dad2f296c6d..22d6cae9a710 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > @@ -54,13 +54,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ct=
x, struct cedrus_run *run)
> >       const struct v4l2_ctrl_mpeg2_picture *pic;
> >       const struct v4l2_ctrl_mpeg2_quantisation *quantisation;
> >       dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
> > -     dma_addr_t fwd_luma_addr, fwd_chroma_addr;
> > -     dma_addr_t bwd_luma_addr, bwd_chroma_addr;
> >       struct cedrus_dev *dev =3D ctx->dev;
> >       struct vb2_queue *vq;
> >       const u8 *matrix;
> > -     int forward_idx;
> > -     int backward_idx;
> >       unsigned int i;
> >       u32 reg;
> >
> > @@ -123,27 +119,19 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx =
*ctx, struct cedrus_run *run)
> >       cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> >
> >       /* Forward and backward prediction reference buffers. */
> > -
> >       vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTU=
RE);
> >
> > -     forward_idx =3D vb2_find_timestamp(vq, pic->forward_ref_ts, 0);
> > -     fwd_luma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 0);
> > -     fwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 1);
> > -
> > -     cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
> > -     cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_add=
r);
> > -
> > -     backward_idx =3D vb2_find_timestamp(vq, pic->backward_ref_ts, 0);
> > -     bwd_luma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 0);
> > -     bwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 1);
> > -
> > -     cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_addr);
> > -     cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR, bwd_chroma_add=
r);
> > +     cedrus_write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
> > +                               VE_DEC_MPEG_FWD_REF_LUMA_ADDR,
> > +                               VE_DEC_MPEG_FWD_REF_CHROMA_ADDR);
> > +     cedrus_write_ref_buf_addr(ctx, vq, pic->backward_ref_ts,
> > +                               VE_DEC_MPEG_BWD_REF_LUMA_ADDR,
> > +                               VE_DEC_MPEG_BWD_REF_CHROMA_ADDR);
> >
> >       /* Destination luma and chroma buffers. */
> >
> > -     dst_luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.inde=
x, 0);
> > -     dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.in=
dex, 1);
> > +     dst_luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0)=
;
> > +     dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, =
1);
> >
> >       cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
> >       cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_vp8.c
> > index f4016684b32d..196cf692186d 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > @@ -661,7 +661,6 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx=
,
> >       dma_addr_t luma_addr, chroma_addr;
> >       dma_addr_t src_buf_addr;
> >       int header_size;
> > -     int qindex;
> >       u32 reg;
> >
> >       cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
> > @@ -805,43 +804,17 @@ static void cedrus_vp8_setup(struct cedrus_ctx *c=
tx,
> >       reg |=3D VE_VP8_LF_DELTA0(slice->lf.mb_mode_delta[0]);
> >       cedrus_write(dev, VE_VP8_MODE_LF_DELTA, reg);
> >
> > -     luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0=
);
> > -     chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index,=
 1);
> > +     luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
> > +     chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
> >       cedrus_write(dev, VE_VP8_REC_LUMA, luma_addr);
> >       cedrus_write(dev, VE_VP8_REC_CHROMA, chroma_addr);
> >
> > -     qindex =3D vb2_find_timestamp(cap_q, slice->last_frame_ts, 0);
> > -     if (qindex >=3D 0) {
> > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > -             cedrus_write(dev, VE_VP8_FWD_LUMA, luma_addr);
> > -             cedrus_write(dev, VE_VP8_FWD_CHROMA, chroma_addr);
> > -     } else {
> > -             cedrus_write(dev, VE_VP8_FWD_LUMA, 0);
> > -             cedrus_write(dev, VE_VP8_FWD_CHROMA, 0);
> > -     }
> > -
> > -     qindex =3D vb2_find_timestamp(cap_q, slice->golden_frame_ts, 0);
> > -     if (qindex >=3D 0) {
> > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > -             cedrus_write(dev, VE_VP8_BWD_LUMA, luma_addr);
> > -             cedrus_write(dev, VE_VP8_BWD_CHROMA, chroma_addr);
> > -     } else {
> > -             cedrus_write(dev, VE_VP8_BWD_LUMA, 0);
> > -             cedrus_write(dev, VE_VP8_BWD_CHROMA, 0);
> > -     }
> > -
> > -     qindex =3D vb2_find_timestamp(cap_q, slice->alt_frame_ts, 0);
> > -     if (qindex >=3D 0) {
> > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > -             cedrus_write(dev, VE_VP8_ALT_LUMA, luma_addr);
> > -             cedrus_write(dev, VE_VP8_ALT_CHROMA, chroma_addr);
> > -     } else {
> > -             cedrus_write(dev, VE_VP8_ALT_LUMA, 0);
> > -             cedrus_write(dev, VE_VP8_ALT_CHROMA, 0);
> > -     }
> > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->last_frame_ts,
> > +                               VE_VP8_FWD_LUMA, VE_VP8_FWD_CHROMA);
> > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->golden_frame_ts,
> > +                               VE_VP8_BWD_LUMA, VE_VP8_BWD_CHROMA);
> > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->alt_frame_ts,
> > +                               VE_VP8_ALT_LUMA, VE_VP8_ALT_CHROMA);
> >
> >       cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8 |
> >                    VE_H264_CTRL_DECODE_ERR_INT |
>
