Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24B5786D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiGRP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:56:48 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF82A2A25C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:56:46 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id v5so9059957qvq.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=dbxzwLlppXZ4/h0FdNUOMoKRxsoCMBDUDWzVIjMuhOw=;
        b=lCm3Cp7adzdBInkAwLZWKmJlzybjzXRMI6UUAZcDqjy4/WfrZf8DzWTzB/0WN6blWs
         tdZqay0KZzVxJzx4vr+ZTLJPji+LR984ULNQDDdmC9qy4eX1XZd8mPHwZe7U5JsCme/7
         1PRnZG4+HmBtp5lZvPTAP3KbUDt5Q9S9i62BeikF13aC3/b2Duoyb4pRgPk938k4Lw2g
         2BDnrKsn1m4adKyEiOO/4Q3Tfeay4wf+nOtLaNwqlXCFRNJZv9FXdg2xD4Btye7oktcS
         0xL41olkUI9smB7UXsSFQieBuDCU3CTGnnmX4919L0KBjiVlW5EO5bVUqcT7avm3U4Qr
         Xclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=dbxzwLlppXZ4/h0FdNUOMoKRxsoCMBDUDWzVIjMuhOw=;
        b=yGcWHONcFOqhfSIp4bLj051VdxmQgQmfL94stETEMvQPwVZ4Gu4dZu7Q925XPtD50I
         uKKkbQFhq1r167HX7Y9S6Cn22p6n4XjG0YbKdbIatRnlcjnNlKUyH77j4W4iJEYmJeZ2
         95P4GdY92g43KXY1Hrji3Lo/uzSyvS6hcpzlcWPBq15bKAjT6KDYE3pFoNPwhlY8Dtp/
         BE69AfMFeIHD6OCXl9P2C705Dtk93NtWagGmicV+H3WzL2BlvSBdt/zR+TcW7G/0Vzul
         scQu60u88BGCDxAZj3CF9XQl1ok84NlUn0ynJPhLLQsspnhw8XJRYZg+3Vn2sPSpoSGn
         woxw==
X-Gm-Message-State: AJIora+BbHxcc01yzAZGVcncUFkaAVDXEVHt37oIPjccZD9wYxwEfV38
        z/71j8xuY2FfZes2QOexdMHaiQ==
X-Google-Smtp-Source: AGRyM1vI4ZsQpTiYUrzt4T5T7YcdRBiuuxu+Tdcw0ViDOI7ah2LfpukygkPax0Ph0N5TbwVFzgA+kQ==
X-Received: by 2002:a05:6214:19ee:b0:472:f5d9:ef with SMTP id q14-20020a05621419ee00b00472f5d900efmr21691127qvc.77.1658159806045;
        Mon, 18 Jul 2022 08:56:46 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id z4-20020a05622a124400b0031ea9aa916bsm9016340qtx.95.2022.07.18.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:56:45 -0700 (PDT)
Message-ID: <d3b80d20426092430e235f0a45f7e2568f571dcd.camel@ndufresne.ca>
Subject: Re: [PATCH v2 7/8] cedrus: Use vb2_find_buffer
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Date:   Mon, 18 Jul 2022 11:56:44 -0400
In-Reply-To: <CAAEAJfBPCBJf_oZ9kAjRgFVb5cu57MUKHGpcizg0fsUBPK_8Jw@mail.gmail.com>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
         <5da2b3547f86e74c86a95300df82609a0cf7406e.camel@ndufresne.ca>
         <CAAEAJfDuX9Dq6QCtZhO_yoBZh6mgtePx5SwjeQgzZjkUiG8-zw@mail.gmail.com>
         <2188083.iZASKD2KPV@jernej-laptop>
         <CAAEAJfBPCBJf_oZ9kAjRgFVb5cu57MUKHGpcizg0fsUBPK_8Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 16 juillet 2022 =C3=A0 11:55 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> Hi Jernej,
>=20
> On Sat, Jul 16, 2022 at 9:36 AM Jernej =C5=A0krabec <jernej.skrabec@gmail=
.com> wrote:
> >=20
> > Dne petek, 15. julij 2022 ob 13:48:34 CEST je Ezequiel Garcia napisal(a=
):
> > > Hi Nicolas,
> > >=20
> > > Thanks a lot for the test and the bug report.
> > >=20
> > > On Thu, Jul 14, 2022 at 4:26 PM Nicolas Dufresne <nicolas@ndufresne.c=
a>
> > wrote:
> > > > Hi Ezequiel,
> > > >=20
> > > > I started testing with these patches and found some NULL dreference=
s, see
> > > > my comment inline...
> > > >=20
> > > > Le lundi 11 juillet 2022 =C3=A0 18:11 -0300, Ezequiel Garcia a =C3=
=A9crit :
> > > > > Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> > > > > given a buffer timestamp.
> > > > >=20
> > > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > > > Acked-by: Tomasz Figa <tfiga@chromium.org>
> > > > > ---
> > > > >=20
> > > > >  drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
> > > > >  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
> > > > >  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++----
> > > > >  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
> > > > >  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++---------=
------
> > > > >  5 files changed, 46 insertions(+), 81 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > > b/drivers/staging/media/sunxi/cedrus/cedrus.h index
> > > > > 3bc094eb497f..c054dbe3d3bc 100644
> > > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > > @@ -233,19 +233,23 @@ static inline dma_addr_t cedrus_buf_addr(st=
ruct
> > > > > vb2_buffer *buf,> >
> > > > >  }
> > > > >=20
> > > > >  static inline dma_addr_t cedrus_dst_buf_addr(struct cedrus_ctx *=
ctx,
> > > > >=20
> > > > > -                                          int index, unsigned in=
t
> > > > > plane)
> > > > > +                                          struct vb2_buffer *buf=
,
> > > > > +                                          unsigned int plane)
> > > > >=20
> > > > >  {
> > > > >=20
> > > > > -     struct vb2_buffer *buf =3D NULL;
> > > > > -     struct vb2_queue *vq;
> > > > > -
> > > > > -     if (index < 0)
> > > > > -             return 0;
> > > > > +     return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0=
;
> > > > > +}
> > > > >=20
> > > > > -     vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > > > > V4L2_BUF_TYPE_VIDEO_CAPTURE);
> > > > > -     if (vq)
> > > > > -             buf =3D vb2_get_buffer(vq, index);
> > > > > +static inline void cedrus_write_ref_buf_addr(struct cedrus_ctx *=
ctx,
> > > > > +                                          struct vb2_queue *q,
> > > > > +                                          u64 timestamp,
> > > > > +                                          u32 luma_reg,
> > > > > +                                          u32 chroma_reg)
> > > > > +{
> > > > > +       struct cedrus_dev *dev =3D ctx->dev;
> > > > > +       struct vb2_buffer *buf =3D vb2_find_buffer(q, timestamp);
> > > > >=20
> > > > > -     return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0=
;
> > > > > +       cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf,=
 0));
> > > > > +       cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, bu=
f, 1));
> > > > >=20
> > > > >  }
> > > > >=20
> > > > >  static inline struct cedrus_buffer *
> > > > >=20
> > > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > > > b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c index
> > > > > d8fb93035470..0559efeac125 100644
> > > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > > > @@ -111,16 +111,16 @@ static void cedrus_write_frame_list(struct
> > > > > cedrus_ctx *ctx,> >
> > > > >       for (i =3D 0; i < ARRAY_SIZE(decode->dpb); i++) {
> > > > >=20
> > > > >               const struct v4l2_h264_dpb_entry *dpb =3D &decode->=
dpb[i];
> > > > >               struct cedrus_buffer *cedrus_buf;
> > > > >=20
> > > > > -             int buf_idx;
> > > > > +             struct vb2_buffer *buf;
> > > > >=20
> > > > >               if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> > > > >=20
> > > > >                       continue;
> > > > >=20
> > > > > -             buf_idx =3D vb2_find_timestamp(cap_q, dpb->referenc=
e_ts, 0);
> > > > > -             if (buf_idx < 0)
> > > > > +             buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> > > > > +             if (!buf)
> > > > >=20
> > > > >                       continue;
> > > > >=20
> > > > > -             cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf=
_idx]);
> > > > > +             cedrus_buf =3D vb2_to_cedrus_buffer(buf);
> > > > >=20
> > > > >               position =3D cedrus_buf->codec.h264.position;
> > > > >               used_dpbs |=3D BIT(position);
> > > > >=20
> > > > > @@ -186,7 +186,7 @@ static void _cedrus_write_ref_list(struct ced=
rus_ctx
> > > > > *ctx,> >
> > > > >               const struct v4l2_h264_dpb_entry *dpb;
> > > > >               const struct cedrus_buffer *cedrus_buf;
> > > > >               unsigned int position;
> > > > >=20
> > > > > -             int buf_idx;
> > > > > +             struct vb2_buffer *buf;
> > > > >=20
> > > > >               u8 dpb_idx;
> > > > >=20
> > > > >               dpb_idx =3D ref_list[i].index;
> > > > >=20
> > > > > @@ -195,11 +195,11 @@ static void _cedrus_write_ref_list(struct
> > > > > cedrus_ctx *ctx,> >
> > > > >               if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)=
)
> > > > >=20
> > > > >                       continue;
> > > > >=20
> > > > > -             buf_idx =3D vb2_find_timestamp(cap_q, dpb->referenc=
e_ts, 0);
> > > > > -             if (buf_idx < 0)
> > > > > +             buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> > > > > +             if (!buf)
> > > > >=20
> > > > >                       continue;
> > > > >=20
> > > > > -             cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf=
_idx]);
> > > > > +             cedrus_buf =3D vb2_to_cedrus_buffer(buf);
> > > > >=20
> > > > >               position =3D cedrus_buf->codec.h264.position;
> > > > >=20
> > > > >               sram_array[i] |=3D position << 1;
> > > > >=20
> > > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > > > > 44f385be9f6c..60cc13e4d0a9 100644
> > > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > @@ -102,14 +102,14 @@ static void
> > > > > cedrus_h265_frame_info_write_single(struct cedrus_ctx *ctx,> >
> > > > >                                               unsigned int index,
> > > > >                                               bool field_pic,
> > > > >                                               u32 pic_order_cnt[]=
,
> > > > >=20
> > > > > -                                             int buffer_index)
> > > > > +                                             struct vb2_buffer *=
buf)
> > > > >=20
> > > > >  {
> > > > >=20
> > > > >       struct cedrus_dev *dev =3D ctx->dev;
> > > > >=20
> > > > > -     dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buffe=
r_index,
> > > > > 0);
> > > > > -     dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx,
> > > > > buffer_index, 1); +     dma_addr_t dst_luma_addr =3D
> > > > > cedrus_dst_buf_addr(ctx, buf, 0); +     dma_addr_t dst_chroma_add=
r =3D
> > > > > cedrus_dst_buf_addr(ctx, buf, 1);> >
> > > > >       dma_addr_t mv_col_buf_addr[2] =3D {
> > > > >=20
> > > > > -             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_=
index,
> > > > > 0),
> > > > > -             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_=
index,
> > > > > +             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->in=
dex,
> > > > > 0),
> > > > > +             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->in=
dex,
> > > > >=20
> > > > >                                                      field_pic ? =
1 : 0)
> > > >=20
> > > > Previously, -1 would be passed to
> > > > cedrus_h265_frame_info_mv_col_buf_addr(),
> > > > which would not find a buffer at that index, and would return 0. No=
w the
> > > > code will crash with a NULL pointer deref.
> > >=20
> > > Is it really correct to pass -1 to cedrus_h265_frame_info_mv_col_buf_=
addr?
> > > It seems it get casted into an unsigned type and then used to calcula=
te
> > > an address for DMA.
> >=20
> > I totally agree that this is a latent bug and it should be fixed. H264 =
checks
> > for negative value, but not HEVC. Current code just makes out of bounds=
 read,
> > which is tolerated, but yours causes NULL pointer dereference, which is=
 not.
> >=20
> > I suggest that following check is added in cedrus_h265_frame_info_write=
_dpb():
> >=20
> > if (buffer_index < 0)
> >  continue;
> >=20
>=20
> Seems reasonable.
>=20
> > I can send it as a fix so it gets backported and you update this patch =
so above
> > if is changed to NULL pointer check.
> >=20
>=20
> Yes, I like this approach.
>=20
> > Do you all agree? Nicolas, do you prefer to send such patch, since you'=
re first
> > who noticed something odd with the code?
> >=20
>=20
> Hans' last PR dropped the cedrus patch, and left vb2_find_timestamp
> for the time being (for 5.20). I like the proposal of sending a fix that =
can
> be backported. I can re-work the rest of this series on top.

Oops, I was to send a fix for that on top of the orignal, feel free to squa=
sh
that:

https://gitlab.collabora.com/nicolas/linux/-/commit/1093321ddb8d3fb06833f47=
1a60d07ce94e78d88

From 1093321ddb8d3fb06833f471a60d07ce94e78d88 Mon Sep 17 00:00:00 2001
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Date: Fri, 15 Jul 2022 15:28:44 -0400
Subject: [PATCH] media: cedrus: Fix NULL buf dereference

This is a regression introduced after porting to vb2_find_buffer.
The function returnis NULL when the buffer isn't found. The HEVC
decoder would call a helper to get the motion vector buffer address
by passing the index. This is fixed by passing the buffer
pointer instead of the index.

Fixes: 7f3614514ab0 ("cedrus: Use vb2_find_buffer")
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 28d90fec9aea..d359726b4966 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -91,16 +91,13 @@ static void cedrus_h265_sram_write_data(struct cedrus_d=
ev
*dev, void *data,
=20
 static inline dma_addr_t
 cedrus_h265_frame_info_mv_col_buf_addr(struct cedrus_ctx *ctx,
-				       unsigned int index,
+				       struct vb2_buffer *buf,
 				       const struct v4l2_ctrl_hevc_sps *sps)
 {
 	struct cedrus_buffer *cedrus_buf =3D NULL;
-	struct vb2_buffer *buf =3D NULL;
 	struct vb2_queue *vq;
=20
 	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
-	if (vq)
-		buf =3D vb2_get_buffer(vq, index);
=20
 	if (buf)
 		cedrus_buf =3D vb2_to_cedrus_buffer(buf);
@@ -148,8 +145,8 @@ static void cedrus_h265_frame_info_write_single(struct
cedrus_ctx *ctx,
 	dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buf, 0);
 	dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, buf, 1);
 	dma_addr_t mv_col_buf_addr[2] =3D {
-		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index, sps),
-		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index, sps)
+		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf, sps),
+		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf, sps)
 	};
 	u32 offset =3D VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
 		     VE_DEC_H265_SRAM_OFFSET_FRAME_INFO_UNIT * index;
--=20
GitLab

>=20
> Thanks,
> Ezequiel
>=20
> > Best regards,
> > Jernej
> >=20
> > >=20
> > > static inline dma_addr_t
> > > cedrus_h265_frame_info_mv_col_buf_addr(struct cedrus_ctx *ctx,
> > >                                        unsigned int index, unsigned i=
nt
> > > field) {
> > >         return ctx->codec.h265.mv_col_buf_addr + index *
> > >                ctx->codec.h265.mv_col_buf_unit_size +
> > >                field * ctx->codec.h265.mv_col_buf_unit_size / 2;
> > > }
> > >=20
> > > Fixing the driver to go back to the previous behavior is trivial,
> > > but this looks odd.
> > >=20
> > > Jernej, Paul, any thoughts?
> > >=20
> > > Thanks,
> > > Ezequiel
> > >=20
> > > > >       };
> > > > >       u32 offset =3D VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
> > > > >=20
> > > > > @@ -141,7 +141,7 @@ static void cedrus_h265_frame_info_write_dpb(=
struct
> > > > > cedrus_ctx *ctx,> >
> > > > >       unsigned int i;
> > > > >=20
> > > > >       for (i =3D 0; i < num_active_dpb_entries; i++) {
> > > > >=20
> > > > > -             int buffer_index =3D vb2_find_timestamp(vq,
> > > > > dpb[i].timestamp, 0); +             struct vb2_buffer *buf =3D
> > > > > vb2_find_buffer(vq, dpb[i].timestamp);> >
> > > > >               u32 pic_order_cnt[2] =3D {
> > > > >=20
> > > > >                       dpb[i].pic_order_cnt[0],
> > > > >                       dpb[i].pic_order_cnt[1]
> > > > >=20
> > > > > @@ -149,7 +149,7 @@ static void cedrus_h265_frame_info_write_dpb(=
struct
> > > > > cedrus_ctx *ctx,> >
> > > > >               cedrus_h265_frame_info_write_single(ctx, i,
> > > > >               dpb[i].field_pic,
> > > > >=20
> > > > >                                                   pic_order_cnt,
> > > > >=20
> > > > > -                                                 buffer_index);
> > > > > +                                                 buf);
> > > > >=20
> > > > >       }
> > > > >=20
> > > > >  }
> > > > >=20
> > > > > @@ -616,7 +616,7 @@ static void cedrus_h265_setup(struct cedrus_c=
tx
> > > > > *ctx,
> > > > >=20
> > > > >       cedrus_h265_frame_info_write_single(ctx, output_pic_list_in=
dex,
> > > > >=20
> > > > >                                           slice_params->pic_struc=
t !=3D 0,
> > > > >                                           pic_order_cnt,
> > > > >=20
> > > > > -                                         run->dst->vb2_buf.index=
);
> > > > > +                                         &run->dst->vb2_buf);
> > > > >=20
> > > > >       cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX,
> > > > >       output_pic_list_index);
> > > > >=20
> > > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > > > b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c index
> > > > > 5dad2f296c6d..22d6cae9a710 100644
> > > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > > > @@ -54,13 +54,9 @@ static void cedrus_mpeg2_setup(struct cedrus_c=
tx
> > > > > *ctx, struct cedrus_run *run)> >
> > > > >       const struct v4l2_ctrl_mpeg2_picture *pic;
> > > > >       const struct v4l2_ctrl_mpeg2_quantisation *quantisation;
> > > > >       dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
> > > > >=20
> > > > > -     dma_addr_t fwd_luma_addr, fwd_chroma_addr;
> > > > > -     dma_addr_t bwd_luma_addr, bwd_chroma_addr;
> > > > >=20
> > > > >       struct cedrus_dev *dev =3D ctx->dev;
> > > > >       struct vb2_queue *vq;
> > > > >       const u8 *matrix;
> > > > >=20
> > > > > -     int forward_idx;
> > > > > -     int backward_idx;
> > > > >=20
> > > > >       unsigned int i;
> > > > >       u32 reg;
> > > > >=20
> > > > > @@ -123,27 +119,19 @@ static void cedrus_mpeg2_setup(struct cedru=
s_ctx
> > > > > *ctx, struct cedrus_run *run)> >
> > > > >       cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> > > > >=20
> > > > >       /* Forward and backward prediction reference buffers. */
> > > > >=20
> > > > > -
> > > > >=20
> > > > >       vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > > > >       V4L2_BUF_TYPE_VIDEO_CAPTURE);
> > > > >=20
> > > > > -     forward_idx =3D vb2_find_timestamp(vq, pic->forward_ref_ts,=
 0);
> > > > > -     fwd_luma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 0);
> > > > > -     fwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 1=
);
> > > > > -
> > > > > -     cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_a=
ddr);
> > > > > -     cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR,
> > > > > fwd_chroma_addr);
> > > > > -
> > > > > -     backward_idx =3D vb2_find_timestamp(vq, pic->backward_ref_t=
s, 0);
> > > > > -     bwd_luma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 0)=
;
> > > > > -     bwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, =
1);
> > > > > -
> > > > > -     cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_a=
ddr);
> > > > > -     cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR,
> > > > > bwd_chroma_addr);
> > > > > +     cedrus_write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
> > > > > +                               VE_DEC_MPEG_FWD_REF_LUMA_ADDR,
> > > > > +                               VE_DEC_MPEG_FWD_REF_CHROMA_ADDR);
> > > > > +     cedrus_write_ref_buf_addr(ctx, vq, pic->backward_ref_ts,
> > > > > +                               VE_DEC_MPEG_BWD_REF_LUMA_ADDR,
> > > > > +                               VE_DEC_MPEG_BWD_REF_CHROMA_ADDR);
> > > > >=20
> > > > >       /* Destination luma and chroma buffers. */
> > > > >=20
> > > > > -     dst_luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_bu=
f.index,
> > > > > 0);
> > > > > -     dst_chroma_addr =3D cedrus_dst_buf_addr(ctx,
> > > > > run->dst->vb2_buf.index, 1); +     dst_luma_addr =3D
> > > > > cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0); +     dst_chroma=
_addr
> > > > > =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);> >
> > > > >       cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
> > > > >       cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
> > > > >=20
> > > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > > > b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c index
> > > > > f4016684b32d..196cf692186d 100644
> > > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > > > @@ -661,7 +661,6 @@ static void cedrus_vp8_setup(struct cedrus_ct=
x *ctx,
> > > > >=20
> > > > >       dma_addr_t luma_addr, chroma_addr;
> > > > >       dma_addr_t src_buf_addr;
> > > > >       int header_size;
> > > > >=20
> > > > > -     int qindex;
> > > > >=20
> > > > >       u32 reg;
> > > > >=20
> > > > >       cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
> > > > >=20
> > > > > @@ -805,43 +804,17 @@ static void cedrus_vp8_setup(struct cedrus_=
ctx
> > > > > *ctx,
> > > > >=20
> > > > >       reg |=3D VE_VP8_LF_DELTA0(slice->lf.mb_mode_delta[0]);
> > > > >       cedrus_write(dev, VE_VP8_MODE_LF_DELTA, reg);
> > > > >=20
> > > > > -     luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.in=
dex, 0);
> > > > > -     chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.=
index,
> > > > > 1);
> > > > > +     luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, =
0);
> > > > > +     chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf=
, 1);
> > > > >=20
> > > > >       cedrus_write(dev, VE_VP8_REC_LUMA, luma_addr);
> > > > >       cedrus_write(dev, VE_VP8_REC_CHROMA, chroma_addr);
> > > > >=20
> > > > > -     qindex =3D vb2_find_timestamp(cap_q, slice->last_frame_ts, =
0);
> > > > > -     if (qindex >=3D 0) {
> > > > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1)=
;
> > > > > -             cedrus_write(dev, VE_VP8_FWD_LUMA, luma_addr);
> > > > > -             cedrus_write(dev, VE_VP8_FWD_CHROMA, chroma_addr);
> > > > > -     } else {
> > > > > -             cedrus_write(dev, VE_VP8_FWD_LUMA, 0);
> > > > > -             cedrus_write(dev, VE_VP8_FWD_CHROMA, 0);
> > > > > -     }
> > > > > -
> > > > > -     qindex =3D vb2_find_timestamp(cap_q, slice->golden_frame_ts=
, 0);
> > > > > -     if (qindex >=3D 0) {
> > > > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1)=
;
> > > > > -             cedrus_write(dev, VE_VP8_BWD_LUMA, luma_addr);
> > > > > -             cedrus_write(dev, VE_VP8_BWD_CHROMA, chroma_addr);
> > > > > -     } else {
> > > > > -             cedrus_write(dev, VE_VP8_BWD_LUMA, 0);
> > > > > -             cedrus_write(dev, VE_VP8_BWD_CHROMA, 0);
> > > > > -     }
> > > > > -
> > > > > -     qindex =3D vb2_find_timestamp(cap_q, slice->alt_frame_ts, 0=
);
> > > > > -     if (qindex >=3D 0) {
> > > > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1)=
;
> > > > > -             cedrus_write(dev, VE_VP8_ALT_LUMA, luma_addr);
> > > > > -             cedrus_write(dev, VE_VP8_ALT_CHROMA, chroma_addr);
> > > > > -     } else {
> > > > > -             cedrus_write(dev, VE_VP8_ALT_LUMA, 0);
> > > > > -             cedrus_write(dev, VE_VP8_ALT_CHROMA, 0);
> > > > > -     }
> > > > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->last_frame_ts,
> > > > > +                               VE_VP8_FWD_LUMA, VE_VP8_FWD_CHROM=
A);
> > > > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->golden_frame_t=
s,
> > > > > +                               VE_VP8_BWD_LUMA, VE_VP8_BWD_CHROM=
A);
> > > > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->alt_frame_ts,
> > > > > +                               VE_VP8_ALT_LUMA, VE_VP8_ALT_CHROM=
A);
> > > > >=20
> > > > >       cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8 |
> > > > >=20
> > > > >                    VE_H264_CTRL_DECODE_ERR_INT |
> >=20
> >=20
> >=20
> >=20

