Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A237576DF6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiGPMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGPMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:36:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E761EC4A;
        Sat, 16 Jul 2022 05:36:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w12so9362207edd.13;
        Sat, 16 Jul 2022 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RzS75DaySAPPLZ/r3IeLLMoRoANcaKHz+gywFUT12Uo=;
        b=DmMTjVMMMRFSys6f8QAovH+nrKZGVkoFWbn/aM0O7T1JRM9dM3sOYGCbF8m5LWe8CW
         GmCXpXvOrenZSOX1JIQI7ZEpPm9o6fgOB6d++WL5bnRlXg+PBjQ/sT2bs1frdQ0mecmL
         FEJjn4AyLM0rCWVpaug7FK8Vl2/6e1cX3GvgimdxicM9DFW4E4BqZT8pRmzo0iQJ0//H
         RNB5Lz/1rNfZE03J3Z8Vcbfo9+SNObKtUS2tuU7dq+NIOQttHAz2LCrmWFdTGPhMeGxT
         k6ml2eifWr/vQIzdxJoAzgnQeBmxbshGvg/7dflLx3mm1hsVbWDLGvMk/Lzj4FA4nwO1
         YLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzS75DaySAPPLZ/r3IeLLMoRoANcaKHz+gywFUT12Uo=;
        b=6RGJ6f2Vti59ASG9m2+HhiL6BYFhqbrs8o48F/T2gx1HkTbSvIKqJ+j2DvYwmUjQPB
         eyFQhPyNET/oa13/C3Utoaq4+LeijW6XOZ0plw2Spz/CGo3vxiFfjybVB4HrPgdvWEp5
         V6t0G5MNdLoHFDD9SBjtvgT0xwsb9nZNhqdPJgUMOi97Ydj5cLCOTCbkLVoftFhjKrEa
         aaAKD13/pvOdRWZX6yEK/fhbcGtR8ND8JiVMzHvCrqXstpc4WM/wJuAcdpStkp29yb1/
         hHObnHEnxhZsSXCcLrCRoQI0F4Mn2o3xuFmQPjhMDMJEAU6EOZ2zdGUqfziOYK16QJ+z
         g+6A==
X-Gm-Message-State: AJIora+K2F0BbbGw1ot84q48Ygbg+nJKouAxmizN81sLqZMhHWlnJnRP
        +lSQhbcZqM+oCMi/+ICCttc=
X-Google-Smtp-Source: AGRyM1soiC4STnZwNWHjFVdpX55vhasWCInA54iKqr1vSMJZSwa/tTlAsxYsYTtiSZax+YTabI85Iw==
X-Received: by 2002:a05:6402:520c:b0:43a:aba8:84ae with SMTP id s12-20020a056402520c00b0043aaba884aemr26346200edd.198.1657975008433;
        Sat, 16 Jul 2022 05:36:48 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id t17-20020a056402021100b0043a735add09sm4597002edv.21.2022.07.16.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 05:36:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 7/8] cedrus: Use vb2_find_buffer
Date:   Sat, 16 Jul 2022 14:36:46 +0200
Message-ID: <2188083.iZASKD2KPV@jernej-laptop>
In-Reply-To: <CAAEAJfDuX9Dq6QCtZhO_yoBZh6mgtePx5SwjeQgzZjkUiG8-zw@mail.gmail.com>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar> <5da2b3547f86e74c86a95300df82609a0cf7406e.camel@ndufresne.ca> <CAAEAJfDuX9Dq6QCtZhO_yoBZh6mgtePx5SwjeQgzZjkUiG8-zw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 15. julij 2022 ob 13:48:34 CEST je Ezequiel Garcia napisal(a):
> Hi Nicolas,
>=20
> Thanks a lot for the test and the bug report.
>=20
> On Thu, Jul 14, 2022 at 4:26 PM Nicolas Dufresne <nicolas@ndufresne.ca>=20
wrote:
> > Hi Ezequiel,
> >=20
> > I started testing with these patches and found some NULL dreferences, s=
ee
> > my comment inline...
> >=20
> > Le lundi 11 juillet 2022 =E0 18:11 -0300, Ezequiel Garcia a =E9crit :
> > > Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> > > given a buffer timestamp.
> > >=20
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > Acked-by: Tomasz Figa <tfiga@chromium.org>
> > > ---
> > >=20
> > >  drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
> > >  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
> > >  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++----
> > >  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
> > >  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++-------------=
=2D-
> > >  5 files changed, 46 insertions(+), 81 deletions(-)
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > b/drivers/staging/media/sunxi/cedrus/cedrus.h index
> > > 3bc094eb497f..c054dbe3d3bc 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > @@ -233,19 +233,23 @@ static inline dma_addr_t cedrus_buf_addr(struct
> > > vb2_buffer *buf,> >=20
> > >  }
> > > =20
> > >  static inline dma_addr_t cedrus_dst_buf_addr(struct cedrus_ctx *ctx,
> > >=20
> > > -                                          int index, unsigned int
> > > plane)
> > > +                                          struct vb2_buffer *buf,
> > > +                                          unsigned int plane)
> > >=20
> > >  {
> > >=20
> > > -     struct vb2_buffer *buf =3D NULL;
> > > -     struct vb2_queue *vq;
> > > -
> > > -     if (index < 0)
> > > -             return 0;
> > > +     return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> > > +}
> > >=20
> > > -     vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > > V4L2_BUF_TYPE_VIDEO_CAPTURE);
> > > -     if (vq)
> > > -             buf =3D vb2_get_buffer(vq, index);
> > > +static inline void cedrus_write_ref_buf_addr(struct cedrus_ctx *ctx,
> > > +                                          struct vb2_queue *q,
> > > +                                          u64 timestamp,
> > > +                                          u32 luma_reg,
> > > +                                          u32 chroma_reg)
> > > +{
> > > +       struct cedrus_dev *dev =3D ctx->dev;
> > > +       struct vb2_buffer *buf =3D vb2_find_buffer(q, timestamp);
> > >=20
> > > -     return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> > > +       cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf, 0));
> > > +       cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, buf, 1=
));
> > >=20
> > >  }
> > > =20
> > >  static inline struct cedrus_buffer *
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c index
> > > d8fb93035470..0559efeac125 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > @@ -111,16 +111,16 @@ static void cedrus_write_frame_list(struct
> > > cedrus_ctx *ctx,> >=20
> > >       for (i =3D 0; i < ARRAY_SIZE(decode->dpb); i++) {
> > >      =20
> > >               const struct v4l2_h264_dpb_entry *dpb =3D &decode->dpb[=
i];
> > >               struct cedrus_buffer *cedrus_buf;
> > >=20
> > > -             int buf_idx;
> > > +             struct vb2_buffer *buf;
> > >=20
> > >               if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> > >              =20
> > >                       continue;
> > >=20
> > > -             buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_ts=
, 0);
> > > -             if (buf_idx < 0)
> > > +             buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> > > +             if (!buf)
> > >=20
> > >                       continue;
> > >=20
> > > -             cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_idx=
]);
> > > +             cedrus_buf =3D vb2_to_cedrus_buffer(buf);
> > >=20
> > >               position =3D cedrus_buf->codec.h264.position;
> > >               used_dpbs |=3D BIT(position);
> > >=20
> > > @@ -186,7 +186,7 @@ static void _cedrus_write_ref_list(struct cedrus_=
ctx
> > > *ctx,> >=20
> > >               const struct v4l2_h264_dpb_entry *dpb;
> > >               const struct cedrus_buffer *cedrus_buf;
> > >               unsigned int position;
> > >=20
> > > -             int buf_idx;
> > > +             struct vb2_buffer *buf;
> > >=20
> > >               u8 dpb_idx;
> > >              =20
> > >               dpb_idx =3D ref_list[i].index;
> > >=20
> > > @@ -195,11 +195,11 @@ static void _cedrus_write_ref_list(struct
> > > cedrus_ctx *ctx,> >=20
> > >               if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> > >              =20
> > >                       continue;
> > >=20
> > > -             buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_ts=
, 0);
> > > -             if (buf_idx < 0)
> > > +             buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> > > +             if (!buf)
> > >=20
> > >                       continue;
> > >=20
> > > -             cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_idx=
]);
> > > +             cedrus_buf =3D vb2_to_cedrus_buffer(buf);
> > >=20
> > >               position =3D cedrus_buf->codec.h264.position;
> > >              =20
> > >               sram_array[i] |=3D position << 1;
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > > 44f385be9f6c..60cc13e4d0a9 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > @@ -102,14 +102,14 @@ static void
> > > cedrus_h265_frame_info_write_single(struct cedrus_ctx *ctx,> >=20
> > >                                               unsigned int index,
> > >                                               bool field_pic,
> > >                                               u32 pic_order_cnt[],
> > >=20
> > > -                                             int buffer_index)
> > > +                                             struct vb2_buffer *buf)
> > >=20
> > >  {
> > > =20
> > >       struct cedrus_dev *dev =3D ctx->dev;
> > >=20
> > > -     dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buffer_in=
dex,
> > > 0);
> > > -     dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx,
> > > buffer_index, 1); +     dma_addr_t dst_luma_addr =3D
> > > cedrus_dst_buf_addr(ctx, buf, 0); +     dma_addr_t dst_chroma_addr =3D
> > > cedrus_dst_buf_addr(ctx, buf, 1);> >=20
> > >       dma_addr_t mv_col_buf_addr[2] =3D {
> > >=20
> > > -             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_inde=
x,
> > > 0),
> > > -             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_inde=
x,
> > > +             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index,
> > > 0),
> > > +             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index,
> > >=20
> > >                                                      field_pic ? 1 : =
0)
> >=20
> > Previously, -1 would be passed to
> > cedrus_h265_frame_info_mv_col_buf_addr(),
> > which would not find a buffer at that index, and would return 0. Now the
> > code will crash with a NULL pointer deref.
>=20
> Is it really correct to pass -1 to cedrus_h265_frame_info_mv_col_buf_addr?
> It seems it get casted into an unsigned type and then used to calculate
> an address for DMA.

I totally agree that this is a latent bug and it should be fixed. H264 chec=
ks=20
for negative value, but not HEVC. Current code just makes out of bounds rea=
d,=20
which is tolerated, but yours causes NULL pointer dereference, which is not.

I suggest that following check is added in cedrus_h265_frame_info_write_dpb=
():

if (buffer_index < 0)
 continue;

I can send it as a fix so it gets backported and you update this patch so a=
bove=20
if is changed to NULL pointer check.

Do you all agree? Nicolas, do you prefer to send such patch, since you're f=
irst=20
who noticed something odd with the code?

Best regards,
Jernej

>=20
> static inline dma_addr_t
> cedrus_h265_frame_info_mv_col_buf_addr(struct cedrus_ctx *ctx,
>                                        unsigned int index, unsigned int
> field) {
>         return ctx->codec.h265.mv_col_buf_addr + index *
>                ctx->codec.h265.mv_col_buf_unit_size +
>                field * ctx->codec.h265.mv_col_buf_unit_size / 2;
> }
>=20
> Fixing the driver to go back to the previous behavior is trivial,
> but this looks odd.
>=20
> Jernej, Paul, any thoughts?
>=20
> Thanks,
> Ezequiel
>=20
> > >       };
> > >       u32 offset =3D VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
> > >=20
> > > @@ -141,7 +141,7 @@ static void cedrus_h265_frame_info_write_dpb(stru=
ct
> > > cedrus_ctx *ctx,> >=20
> > >       unsigned int i;
> > >      =20
> > >       for (i =3D 0; i < num_active_dpb_entries; i++) {
> > >=20
> > > -             int buffer_index =3D vb2_find_timestamp(vq,
> > > dpb[i].timestamp, 0); +             struct vb2_buffer *buf =3D
> > > vb2_find_buffer(vq, dpb[i].timestamp);> >=20
> > >               u32 pic_order_cnt[2] =3D {
> > >              =20
> > >                       dpb[i].pic_order_cnt[0],
> > >                       dpb[i].pic_order_cnt[1]
> > >=20
> > > @@ -149,7 +149,7 @@ static void cedrus_h265_frame_info_write_dpb(stru=
ct
> > > cedrus_ctx *ctx,> >=20
> > >               cedrus_h265_frame_info_write_single(ctx, i,
> > >               dpb[i].field_pic,
> > >              =20
> > >                                                   pic_order_cnt,
> > >=20
> > > -                                                 buffer_index);
> > > +                                                 buf);
> > >=20
> > >       }
> > > =20
> > >  }
> > >=20
> > > @@ -616,7 +616,7 @@ static void cedrus_h265_setup(struct cedrus_ctx
> > > *ctx,
> > >=20
> > >       cedrus_h265_frame_info_write_single(ctx, output_pic_list_index,
> > >      =20
> > >                                           slice_params->pic_struct !=
=3D 0,
> > >                                           pic_order_cnt,
> > >=20
> > > -                                         run->dst->vb2_buf.index);
> > > +                                         &run->dst->vb2_buf);
> > >=20
> > >       cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX,
> > >       output_pic_list_index);
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c index
> > > 5dad2f296c6d..22d6cae9a710 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > @@ -54,13 +54,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx
> > > *ctx, struct cedrus_run *run)> >=20
> > >       const struct v4l2_ctrl_mpeg2_picture *pic;
> > >       const struct v4l2_ctrl_mpeg2_quantisation *quantisation;
> > >       dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
> > >=20
> > > -     dma_addr_t fwd_luma_addr, fwd_chroma_addr;
> > > -     dma_addr_t bwd_luma_addr, bwd_chroma_addr;
> > >=20
> > >       struct cedrus_dev *dev =3D ctx->dev;
> > >       struct vb2_queue *vq;
> > >       const u8 *matrix;
> > >=20
> > > -     int forward_idx;
> > > -     int backward_idx;
> > >=20
> > >       unsigned int i;
> > >       u32 reg;
> > >=20
> > > @@ -123,27 +119,19 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx
> > > *ctx, struct cedrus_run *run)> >=20
> > >       cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> > >      =20
> > >       /* Forward and backward prediction reference buffers. */
> > >=20
> > > -
> > >=20
> > >       vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > >       V4L2_BUF_TYPE_VIDEO_CAPTURE);
> > >=20
> > > -     forward_idx =3D vb2_find_timestamp(vq, pic->forward_ref_ts, 0);
> > > -     fwd_luma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 0);
> > > -     fwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 1);
> > > -
> > > -     cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
> > > -     cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR,
> > > fwd_chroma_addr);
> > > -
> > > -     backward_idx =3D vb2_find_timestamp(vq, pic->backward_ref_ts, 0=
);
> > > -     bwd_luma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 0);
> > > -     bwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 1);
> > > -
> > > -     cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_addr);
> > > -     cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR,
> > > bwd_chroma_addr);
> > > +     cedrus_write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
> > > +                               VE_DEC_MPEG_FWD_REF_LUMA_ADDR,
> > > +                               VE_DEC_MPEG_FWD_REF_CHROMA_ADDR);
> > > +     cedrus_write_ref_buf_addr(ctx, vq, pic->backward_ref_ts,
> > > +                               VE_DEC_MPEG_BWD_REF_LUMA_ADDR,
> > > +                               VE_DEC_MPEG_BWD_REF_CHROMA_ADDR);
> > >=20
> > >       /* Destination luma and chroma buffers. */
> > >=20
> > > -     dst_luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.in=
dex,
> > > 0);
> > > -     dst_chroma_addr =3D cedrus_dst_buf_addr(ctx,
> > > run->dst->vb2_buf.index, 1); +     dst_luma_addr =3D
> > > cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0); +     dst_chroma_addr
> > > =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);> >=20
> > >       cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
> > >       cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c index
> > > f4016684b32d..196cf692186d 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > @@ -661,7 +661,6 @@ static void cedrus_vp8_setup(struct cedrus_ctx *c=
tx,
> > >=20
> > >       dma_addr_t luma_addr, chroma_addr;
> > >       dma_addr_t src_buf_addr;
> > >       int header_size;
> > >=20
> > > -     int qindex;
> > >=20
> > >       u32 reg;
> > >      =20
> > >       cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
> > >=20
> > > @@ -805,43 +804,17 @@ static void cedrus_vp8_setup(struct cedrus_ctx
> > > *ctx,
> > >=20
> > >       reg |=3D VE_VP8_LF_DELTA0(slice->lf.mb_mode_delta[0]);
> > >       cedrus_write(dev, VE_VP8_MODE_LF_DELTA, reg);
> > >=20
> > > -     luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index,=
 0);
> > > -     chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.inde=
x,
> > > 1);
> > > +     luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
> > > +     chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
> > >=20
> > >       cedrus_write(dev, VE_VP8_REC_LUMA, luma_addr);
> > >       cedrus_write(dev, VE_VP8_REC_CHROMA, chroma_addr);
> > >=20
> > > -     qindex =3D vb2_find_timestamp(cap_q, slice->last_frame_ts, 0);
> > > -     if (qindex >=3D 0) {
> > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > > -             cedrus_write(dev, VE_VP8_FWD_LUMA, luma_addr);
> > > -             cedrus_write(dev, VE_VP8_FWD_CHROMA, chroma_addr);
> > > -     } else {
> > > -             cedrus_write(dev, VE_VP8_FWD_LUMA, 0);
> > > -             cedrus_write(dev, VE_VP8_FWD_CHROMA, 0);
> > > -     }
> > > -
> > > -     qindex =3D vb2_find_timestamp(cap_q, slice->golden_frame_ts, 0);
> > > -     if (qindex >=3D 0) {
> > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > > -             cedrus_write(dev, VE_VP8_BWD_LUMA, luma_addr);
> > > -             cedrus_write(dev, VE_VP8_BWD_CHROMA, chroma_addr);
> > > -     } else {
> > > -             cedrus_write(dev, VE_VP8_BWD_LUMA, 0);
> > > -             cedrus_write(dev, VE_VP8_BWD_CHROMA, 0);
> > > -     }
> > > -
> > > -     qindex =3D vb2_find_timestamp(cap_q, slice->alt_frame_ts, 0);
> > > -     if (qindex >=3D 0) {
> > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > > -             cedrus_write(dev, VE_VP8_ALT_LUMA, luma_addr);
> > > -             cedrus_write(dev, VE_VP8_ALT_CHROMA, chroma_addr);
> > > -     } else {
> > > -             cedrus_write(dev, VE_VP8_ALT_LUMA, 0);
> > > -             cedrus_write(dev, VE_VP8_ALT_CHROMA, 0);
> > > -     }
> > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->last_frame_ts,
> > > +                               VE_VP8_FWD_LUMA, VE_VP8_FWD_CHROMA);
> > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->golden_frame_ts,
> > > +                               VE_VP8_BWD_LUMA, VE_VP8_BWD_CHROMA);
> > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->alt_frame_ts,
> > > +                               VE_VP8_ALT_LUMA, VE_VP8_ALT_CHROMA);
> > >=20
> > >       cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8 |
> > >      =20
> > >                    VE_H264_CTRL_DECODE_ERR_INT |




