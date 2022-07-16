Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A3576F8C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiGPO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGPO4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:56:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A91BEA8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:56:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l23so13699078ejr.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bb9VOrwPtNPizR31Hqae1M6mx+PpG+81ziOzpJD5yiw=;
        b=DiLWAA4WtcSqCNG13MXEo3tP0VsHjfe+w6JZBpo/QMrfClQGa1YlRkucA/7tGpjjcJ
         VimMVS7CqF3PuaDQ/8bylHEYXuE14DBOF+U0sUoQEw6vt0T0QuEGXCas1QQDwXP84aBj
         k3lpHBML7Z7z8MAUW+l9YTdFWkHIoAf5YmTHGfEleCK9wGMb4RZ3k/zme7ApJb05h2z5
         okz5lWykh458sPQp/2rz2Y06ZcNyCdYijZrI93t/rKzuvGbtOaRySgaRPGxeHyAD2iVN
         QEbEQ1KKxMRnjvDO23w87uX+pAp7nZFbdZG0JyPPCgxsO0ht7mrzsgYuOe3rTo/no/UP
         uYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bb9VOrwPtNPizR31Hqae1M6mx+PpG+81ziOzpJD5yiw=;
        b=5gZwG3K69tsiRJ4PyvBHnA+YrrpzSeCO824WKTsFN66R4MmjG9dxmz7k+iQkSbFy1W
         jepulMKpdlLeQVuoN8dEwKeZr1gIhVVsIyO4VUM559pqOEGAlUlFbAaPKd8vbhSRL5jG
         f830za8r4Rgojc6PURuJR17FDttKcOeJuRMsQkzG/kOWFPmnyjv3ksmnD6gpnffOIS8a
         ++uBir7oDxpDOeHVosrAlNAjt9vP2Cwdo9LIPTiwYmdc7CHmkRzdqHA8qE9SVC8uxuDC
         pU1AxYwIXJ94uyToIs6bDj+JkH1YiI7W78cADbT+Brz8J5GsgArvPUPsT0LDY3HjkBdQ
         +Mmg==
X-Gm-Message-State: AJIora/Ex3yLGIPxRYabfmTMvg1TRk9xUf55w8T6rY7z95J6is7Y/aGb
        Q657fL16L9bVKkkJ9b9QbkssAdeIZanduxWh5OEqJg==
X-Google-Smtp-Source: AGRyM1sZHgu6KzKQNwxkLNZqo5oi/eckz37QF5oKhHu06RfuU9T5/wuMb4Iy+9ofG7XQ0Q/XNZ8mH9Etv0LNeyZsVRs=
X-Received: by 2002:a17:906:2086:b0:717:4e91:f1db with SMTP id
 6-20020a170906208600b007174e91f1dbmr18325081ejq.345.1657983371120; Sat, 16
 Jul 2022 07:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
 <5da2b3547f86e74c86a95300df82609a0cf7406e.camel@ndufresne.ca>
 <CAAEAJfDuX9Dq6QCtZhO_yoBZh6mgtePx5SwjeQgzZjkUiG8-zw@mail.gmail.com> <2188083.iZASKD2KPV@jernej-laptop>
In-Reply-To: <2188083.iZASKD2KPV@jernej-laptop>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 16 Jul 2022 11:55:59 -0300
Message-ID: <CAAEAJfBPCBJf_oZ9kAjRgFVb5cu57MUKHGpcizg0fsUBPK_8Jw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cedrus: Use vb2_find_buffer
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
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

Hi Jernej,

On Sat, Jul 16, 2022 at 9:36 AM Jernej =C5=A0krabec <jernej.skrabec@gmail.c=
om> wrote:
>
> Dne petek, 15. julij 2022 ob 13:48:34 CEST je Ezequiel Garcia napisal(a):
> > Hi Nicolas,
> >
> > Thanks a lot for the test and the bug report.
> >
> > On Thu, Jul 14, 2022 at 4:26 PM Nicolas Dufresne <nicolas@ndufresne.ca>
> wrote:
> > > Hi Ezequiel,
> > >
> > > I started testing with these patches and found some NULL dreferences,=
 see
> > > my comment inline...
> > >
> > > Le lundi 11 juillet 2022 =C3=A0 18:11 -0300, Ezequiel Garcia a =C3=A9=
crit :
> > > > Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> > > > given a buffer timestamp.
> > > >
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > > Acked-by: Tomasz Figa <tfiga@chromium.org>
> > > > ---
> > > >
> > > >  drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
> > > >  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
> > > >  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++----
> > > >  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
> > > >  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++-----------=
----
> > > >  5 files changed, 46 insertions(+), 81 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus.h index
> > > > 3bc094eb497f..c054dbe3d3bc 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > @@ -233,19 +233,23 @@ static inline dma_addr_t cedrus_buf_addr(stru=
ct
> > > > vb2_buffer *buf,> >
> > > >  }
> > > >
> > > >  static inline dma_addr_t cedrus_dst_buf_addr(struct cedrus_ctx *ct=
x,
> > > >
> > > > -                                          int index, unsigned int
> > > > plane)
> > > > +                                          struct vb2_buffer *buf,
> > > > +                                          unsigned int plane)
> > > >
> > > >  {
> > > >
> > > > -     struct vb2_buffer *buf =3D NULL;
> > > > -     struct vb2_queue *vq;
> > > > -
> > > > -     if (index < 0)
> > > > -             return 0;
> > > > +     return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> > > > +}
> > > >
> > > > -     vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > > > V4L2_BUF_TYPE_VIDEO_CAPTURE);
> > > > -     if (vq)
> > > > -             buf =3D vb2_get_buffer(vq, index);
> > > > +static inline void cedrus_write_ref_buf_addr(struct cedrus_ctx *ct=
x,
> > > > +                                          struct vb2_queue *q,
> > > > +                                          u64 timestamp,
> > > > +                                          u32 luma_reg,
> > > > +                                          u32 chroma_reg)
> > > > +{
> > > > +       struct cedrus_dev *dev =3D ctx->dev;
> > > > +       struct vb2_buffer *buf =3D vb2_find_buffer(q, timestamp);
> > > >
> > > > -     return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> > > > +       cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf, 0=
));
> > > > +       cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, buf,=
 1));
> > > >
> > > >  }
> > > >
> > > >  static inline struct cedrus_buffer *
> > > >
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c index
> > > > d8fb93035470..0559efeac125 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > > > @@ -111,16 +111,16 @@ static void cedrus_write_frame_list(struct
> > > > cedrus_ctx *ctx,> >
> > > >       for (i =3D 0; i < ARRAY_SIZE(decode->dpb); i++) {
> > > >
> > > >               const struct v4l2_h264_dpb_entry *dpb =3D &decode->dp=
b[i];
> > > >               struct cedrus_buffer *cedrus_buf;
> > > >
> > > > -             int buf_idx;
> > > > +             struct vb2_buffer *buf;
> > > >
> > > >               if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> > > >
> > > >                       continue;
> > > >
> > > > -             buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_=
ts, 0);
> > > > -             if (buf_idx < 0)
> > > > +             buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> > > > +             if (!buf)
> > > >
> > > >                       continue;
> > > >
> > > > -             cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_i=
dx]);
> > > > +             cedrus_buf =3D vb2_to_cedrus_buffer(buf);
> > > >
> > > >               position =3D cedrus_buf->codec.h264.position;
> > > >               used_dpbs |=3D BIT(position);
> > > >
> > > > @@ -186,7 +186,7 @@ static void _cedrus_write_ref_list(struct cedru=
s_ctx
> > > > *ctx,> >
> > > >               const struct v4l2_h264_dpb_entry *dpb;
> > > >               const struct cedrus_buffer *cedrus_buf;
> > > >               unsigned int position;
> > > >
> > > > -             int buf_idx;
> > > > +             struct vb2_buffer *buf;
> > > >
> > > >               u8 dpb_idx;
> > > >
> > > >               dpb_idx =3D ref_list[i].index;
> > > >
> > > > @@ -195,11 +195,11 @@ static void _cedrus_write_ref_list(struct
> > > > cedrus_ctx *ctx,> >
> > > >               if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> > > >
> > > >                       continue;
> > > >
> > > > -             buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_=
ts, 0);
> > > > -             if (buf_idx < 0)
> > > > +             buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> > > > +             if (!buf)
> > > >
> > > >                       continue;
> > > >
> > > > -             cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_i=
dx]);
> > > > +             cedrus_buf =3D vb2_to_cedrus_buffer(buf);
> > > >
> > > >               position =3D cedrus_buf->codec.h264.position;
> > > >
> > > >               sram_array[i] |=3D position << 1;
> > > >
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > > > 44f385be9f6c..60cc13e4d0a9 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > @@ -102,14 +102,14 @@ static void
> > > > cedrus_h265_frame_info_write_single(struct cedrus_ctx *ctx,> >
> > > >                                               unsigned int index,
> > > >                                               bool field_pic,
> > > >                                               u32 pic_order_cnt[],
> > > >
> > > > -                                             int buffer_index)
> > > > +                                             struct vb2_buffer *bu=
f)
> > > >
> > > >  {
> > > >
> > > >       struct cedrus_dev *dev =3D ctx->dev;
> > > >
> > > > -     dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buffer_=
index,
> > > > 0);
> > > > -     dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx,
> > > > buffer_index, 1); +     dma_addr_t dst_luma_addr =3D
> > > > cedrus_dst_buf_addr(ctx, buf, 0); +     dma_addr_t dst_chroma_addr =
=3D
> > > > cedrus_dst_buf_addr(ctx, buf, 1);> >
> > > >       dma_addr_t mv_col_buf_addr[2] =3D {
> > > >
> > > > -             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_in=
dex,
> > > > 0),
> > > > -             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_in=
dex,
> > > > +             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->inde=
x,
> > > > 0),
> > > > +             cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->inde=
x,
> > > >
> > > >                                                      field_pic ? 1 =
: 0)
> > >
> > > Previously, -1 would be passed to
> > > cedrus_h265_frame_info_mv_col_buf_addr(),
> > > which would not find a buffer at that index, and would return 0. Now =
the
> > > code will crash with a NULL pointer deref.
> >
> > Is it really correct to pass -1 to cedrus_h265_frame_info_mv_col_buf_ad=
dr?
> > It seems it get casted into an unsigned type and then used to calculate
> > an address for DMA.
>
> I totally agree that this is a latent bug and it should be fixed. H264 ch=
ecks
> for negative value, but not HEVC. Current code just makes out of bounds r=
ead,
> which is tolerated, but yours causes NULL pointer dereference, which is n=
ot.
>
> I suggest that following check is added in cedrus_h265_frame_info_write_d=
pb():
>
> if (buffer_index < 0)
>  continue;
>

Seems reasonable.

> I can send it as a fix so it gets backported and you update this patch so=
 above
> if is changed to NULL pointer check.
>

Yes, I like this approach.

> Do you all agree? Nicolas, do you prefer to send such patch, since you're=
 first
> who noticed something odd with the code?
>

Hans' last PR dropped the cedrus patch, and left vb2_find_timestamp
for the time being (for 5.20). I like the proposal of sending a fix that ca=
n
be backported. I can re-work the rest of this series on top.

Thanks,
Ezequiel

> Best regards,
> Jernej
>
> >
> > static inline dma_addr_t
> > cedrus_h265_frame_info_mv_col_buf_addr(struct cedrus_ctx *ctx,
> >                                        unsigned int index, unsigned int
> > field) {
> >         return ctx->codec.h265.mv_col_buf_addr + index *
> >                ctx->codec.h265.mv_col_buf_unit_size +
> >                field * ctx->codec.h265.mv_col_buf_unit_size / 2;
> > }
> >
> > Fixing the driver to go back to the previous behavior is trivial,
> > but this looks odd.
> >
> > Jernej, Paul, any thoughts?
> >
> > Thanks,
> > Ezequiel
> >
> > > >       };
> > > >       u32 offset =3D VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
> > > >
> > > > @@ -141,7 +141,7 @@ static void cedrus_h265_frame_info_write_dpb(st=
ruct
> > > > cedrus_ctx *ctx,> >
> > > >       unsigned int i;
> > > >
> > > >       for (i =3D 0; i < num_active_dpb_entries; i++) {
> > > >
> > > > -             int buffer_index =3D vb2_find_timestamp(vq,
> > > > dpb[i].timestamp, 0); +             struct vb2_buffer *buf =3D
> > > > vb2_find_buffer(vq, dpb[i].timestamp);> >
> > > >               u32 pic_order_cnt[2] =3D {
> > > >
> > > >                       dpb[i].pic_order_cnt[0],
> > > >                       dpb[i].pic_order_cnt[1]
> > > >
> > > > @@ -149,7 +149,7 @@ static void cedrus_h265_frame_info_write_dpb(st=
ruct
> > > > cedrus_ctx *ctx,> >
> > > >               cedrus_h265_frame_info_write_single(ctx, i,
> > > >               dpb[i].field_pic,
> > > >
> > > >                                                   pic_order_cnt,
> > > >
> > > > -                                                 buffer_index);
> > > > +                                                 buf);
> > > >
> > > >       }
> > > >
> > > >  }
> > > >
> > > > @@ -616,7 +616,7 @@ static void cedrus_h265_setup(struct cedrus_ctx
> > > > *ctx,
> > > >
> > > >       cedrus_h265_frame_info_write_single(ctx, output_pic_list_inde=
x,
> > > >
> > > >                                           slice_params->pic_struct =
!=3D 0,
> > > >                                           pic_order_cnt,
> > > >
> > > > -                                         run->dst->vb2_buf.index);
> > > > +                                         &run->dst->vb2_buf);
> > > >
> > > >       cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX,
> > > >       output_pic_list_index);
> > > >
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c index
> > > > 5dad2f296c6d..22d6cae9a710 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > > > @@ -54,13 +54,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx
> > > > *ctx, struct cedrus_run *run)> >
> > > >       const struct v4l2_ctrl_mpeg2_picture *pic;
> > > >       const struct v4l2_ctrl_mpeg2_quantisation *quantisation;
> > > >       dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
> > > >
> > > > -     dma_addr_t fwd_luma_addr, fwd_chroma_addr;
> > > > -     dma_addr_t bwd_luma_addr, bwd_chroma_addr;
> > > >
> > > >       struct cedrus_dev *dev =3D ctx->dev;
> > > >       struct vb2_queue *vq;
> > > >       const u8 *matrix;
> > > >
> > > > -     int forward_idx;
> > > > -     int backward_idx;
> > > >
> > > >       unsigned int i;
> > > >       u32 reg;
> > > >
> > > > @@ -123,27 +119,19 @@ static void cedrus_mpeg2_setup(struct cedrus_=
ctx
> > > > *ctx, struct cedrus_run *run)> >
> > > >       cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> > > >
> > > >       /* Forward and backward prediction reference buffers. */
> > > >
> > > > -
> > > >
> > > >       vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > > >       V4L2_BUF_TYPE_VIDEO_CAPTURE);
> > > >
> > > > -     forward_idx =3D vb2_find_timestamp(vq, pic->forward_ref_ts, 0=
);
> > > > -     fwd_luma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 0);
> > > > -     fwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 1);
> > > > -
> > > > -     cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_add=
r);
> > > > -     cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR,
> > > > fwd_chroma_addr);
> > > > -
> > > > -     backward_idx =3D vb2_find_timestamp(vq, pic->backward_ref_ts,=
 0);
> > > > -     bwd_luma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 0);
> > > > -     bwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 1)=
;
> > > > -
> > > > -     cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_add=
r);
> > > > -     cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR,
> > > > bwd_chroma_addr);
> > > > +     cedrus_write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
> > > > +                               VE_DEC_MPEG_FWD_REF_LUMA_ADDR,
> > > > +                               VE_DEC_MPEG_FWD_REF_CHROMA_ADDR);
> > > > +     cedrus_write_ref_buf_addr(ctx, vq, pic->backward_ref_ts,
> > > > +                               VE_DEC_MPEG_BWD_REF_LUMA_ADDR,
> > > > +                               VE_DEC_MPEG_BWD_REF_CHROMA_ADDR);
> > > >
> > > >       /* Destination luma and chroma buffers. */
> > > >
> > > > -     dst_luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.=
index,
> > > > 0);
> > > > -     dst_chroma_addr =3D cedrus_dst_buf_addr(ctx,
> > > > run->dst->vb2_buf.index, 1); +     dst_luma_addr =3D
> > > > cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0); +     dst_chroma_a=
ddr
> > > > =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);> >
> > > >       cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
> > > >       cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
> > > >
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c index
> > > > f4016684b32d..196cf692186d 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> > > > @@ -661,7 +661,6 @@ static void cedrus_vp8_setup(struct cedrus_ctx =
*ctx,
> > > >
> > > >       dma_addr_t luma_addr, chroma_addr;
> > > >       dma_addr_t src_buf_addr;
> > > >       int header_size;
> > > >
> > > > -     int qindex;
> > > >
> > > >       u32 reg;
> > > >
> > > >       cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
> > > >
> > > > @@ -805,43 +804,17 @@ static void cedrus_vp8_setup(struct cedrus_ct=
x
> > > > *ctx,
> > > >
> > > >       reg |=3D VE_VP8_LF_DELTA0(slice->lf.mb_mode_delta[0]);
> > > >       cedrus_write(dev, VE_VP8_MODE_LF_DELTA, reg);
> > > >
> > > > -     luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.inde=
x, 0);
> > > > -     chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.in=
dex,
> > > > 1);
> > > > +     luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0)=
;
> > > > +     chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, =
1);
> > > >
> > > >       cedrus_write(dev, VE_VP8_REC_LUMA, luma_addr);
> > > >       cedrus_write(dev, VE_VP8_REC_CHROMA, chroma_addr);
> > > >
> > > > -     qindex =3D vb2_find_timestamp(cap_q, slice->last_frame_ts, 0)=
;
> > > > -     if (qindex >=3D 0) {
> > > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > > > -             cedrus_write(dev, VE_VP8_FWD_LUMA, luma_addr);
> > > > -             cedrus_write(dev, VE_VP8_FWD_CHROMA, chroma_addr);
> > > > -     } else {
> > > > -             cedrus_write(dev, VE_VP8_FWD_LUMA, 0);
> > > > -             cedrus_write(dev, VE_VP8_FWD_CHROMA, 0);
> > > > -     }
> > > > -
> > > > -     qindex =3D vb2_find_timestamp(cap_q, slice->golden_frame_ts, =
0);
> > > > -     if (qindex >=3D 0) {
> > > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > > > -             cedrus_write(dev, VE_VP8_BWD_LUMA, luma_addr);
> > > > -             cedrus_write(dev, VE_VP8_BWD_CHROMA, chroma_addr);
> > > > -     } else {
> > > > -             cedrus_write(dev, VE_VP8_BWD_LUMA, 0);
> > > > -             cedrus_write(dev, VE_VP8_BWD_CHROMA, 0);
> > > > -     }
> > > > -
> > > > -     qindex =3D vb2_find_timestamp(cap_q, slice->alt_frame_ts, 0);
> > > > -     if (qindex >=3D 0) {
> > > > -             luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> > > > -             chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> > > > -             cedrus_write(dev, VE_VP8_ALT_LUMA, luma_addr);
> > > > -             cedrus_write(dev, VE_VP8_ALT_CHROMA, chroma_addr);
> > > > -     } else {
> > > > -             cedrus_write(dev, VE_VP8_ALT_LUMA, 0);
> > > > -             cedrus_write(dev, VE_VP8_ALT_CHROMA, 0);
> > > > -     }
> > > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->last_frame_ts,
> > > > +                               VE_VP8_FWD_LUMA, VE_VP8_FWD_CHROMA)=
;
> > > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->golden_frame_ts,
> > > > +                               VE_VP8_BWD_LUMA, VE_VP8_BWD_CHROMA)=
;
> > > > +     cedrus_write_ref_buf_addr(ctx, cap_q, slice->alt_frame_ts,
> > > > +                               VE_VP8_ALT_LUMA, VE_VP8_ALT_CHROMA)=
;
> > > >
> > > >       cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8 |
> > > >
> > > >                    VE_H264_CTRL_DECODE_ERR_INT |
>
>
>
>
