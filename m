Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CA64663F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358080AbhLBMwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358067AbhLBMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:52:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE38C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:49:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so115524208edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 04:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5MNnBU9MaxTxI9cqqWw0moWpmBRi54BQ1Dk1y9djiZc=;
        b=UQw5AbVL39Ov8XpAWVDXVDfhjCTIk4FO4terydMAp+6phr8T3Qjdw8r5m4k4l+d7p6
         wZs40KQjG3FrilbRsgt85cpMh47EfurM1kr5Z0cX0b1bu5J3XvVjT/JAg0vIw9Zzq5sW
         t3e6t2ZLJ228GK2cVqj7lXZArwsCwRW6rzzP6qiP2eGbv5raP64cO9a55viaYMaP4p+Y
         gDLFcqC+l5aaooY506OmNb9ZyOzDgcO4fkx8yQaATPAbKJtbkTonq5GirRzWjkxBhRzc
         H+M7tLyn1xMQjDXY4JilLGKHQULgTWyLuIc2eCuJPxyCjbkx8pIdHRWMHnbiE0B/bPuP
         NkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5MNnBU9MaxTxI9cqqWw0moWpmBRi54BQ1Dk1y9djiZc=;
        b=JN4kYC67KfUu9NKZHT/LLb2AvNutLsvVTP3jddLIAe4HtOx6RwKTjmhav5wr1fFYtP
         1mTmm3QXXP73Px0h3hVyt6SujoKQLZdeEnI2eVN5EkQXZCd6DYCuFee+oB/+SPdwuXBg
         uPLlIClhZ91BlmKIYRP4/KfzsGCQu/kLKN89z+3UCdPWE1sf1ua5Lo801yrN1yPqZQP+
         I58UElx1MjvG09bDzdKJvYyBqqItnBVWfjttJdpmG+tcobBSyrvw2320F0vCZUW/MwEP
         P96Ky2EUr2ZNe7bFu6MAv9IOWmtWs5k73hq89cFImcxrkdqjCq94m8Q1CdX7NPkaujH+
         rNWA==
X-Gm-Message-State: AOAM530BjD4e4DuAZwnwGBGzxcSJOQ31O0gKVkSiJomPpLvZl/qsTpcS
        /g6RCc93eV2jV9yDLvQTxT5DQgpLnTDA2JXgBTezDw==
X-Google-Smtp-Source: ABdhPJxhdIpGhxx9AJHA4G6fftMfrsNC1J1pr7Qz9GrBf4SVRcZzMFwPQHap+z6qbEf47ucNF9Rs7OjANjbbG1vzrd0=
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr17636616edd.347.1638449349598;
 Thu, 02 Dec 2021 04:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20211202105549.276572-1-benjamin.gaignard@collabora.com>
 <CAAEAJfDQ7TnFwxhWDp3JAHg67MrCoOZm=D4V5o2sJ_9vT6K0sA@mail.gmail.com> <b3e3ef14-2e61-15cb-eb75-69b00bb90902@collabora.com>
In-Reply-To: <b3e3ef14-2e61-15cb-eb75-69b00bb90902@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 2 Dec 2021 09:48:57 -0300
Message-ID: <CAAEAJfA2d2yxVpL=cqkMMLHZHf-M57kNuMuNAMLO+R_GWVQjFg@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: Make G2/HEVC use hantro_postproc_ops
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, 2 Dec 2021 at 09:08, Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 02/12/2021 =C3=A0 12:11, Ezequiel Garcia a =C3=A9crit :
> > Hi Benjamin,
> >
> > Almost there :-)
> >
> > On Thu, 2 Dec 2021 at 07:55, Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> >> Use the postprocessor functions introduced by Hantro G2/VP9 codec seri=
es
> >> and remove duplicated buffer management.
> >> This allow Hantro G12/HEVC to produce NV12_4L4 and NV12.
> >>
> > s/G12/G2
> >
> >> fluster score is 77/147 which equal to previous score.
> > s/fluster/Fluster
> >
> > Can you clarify if this is the HEVC score? While here, can you run VP9
> > to confirm there are no regressions?
>
> I haven't VP9 GStreamer decoder element ready so I can't do that now.
> That said the patch doesn't touch any VP9 code.
>

VP9 GStreamer is merged, and building with the monorepo is really
really easy now.

The VP9 driver changes have been sent for merge,
see https://www.spinics.net/lists/linux-media/msg202448.html
which includes the git repository and tag you can merge/rebase to test
it.

Please rebase on that and make sure we don't have VP9 regressions
and update the commit description. This might sound annoying, but it is
what it is until we have CI in place.

Thanks!
Ezequiel


> Benjamin
>
> >> Note that since NV12_4L2 is the first pixel format enumerated by the
> >> driver fluster pipeline and it is well converted into I420 by
> >> GStreamer's videoconvert.
> >>
> >> Beauty, Jockey and ShakeNDry bitstreams from UVG set have also been
> >> tested.
> >>
> > Can you add a link to the UVG test suite, so it's clearer?
> >
> > Also, this patch is v2, so don't forget to prefix the next one as v3,
> > and add a changelog to it.
> >
> > Thanks a lot,
> > Ezequiel
> >
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> ---
> >>   .../staging/media/hantro/hantro_g2_hevc_dec.c | 25 +++---
> >>   drivers/staging/media/hantro/hantro_hevc.c    | 79 +++--------------=
--
> >>   drivers/staging/media/hantro/hantro_hw.h      | 11 +++
> >>   .../staging/media/hantro/hantro_postproc.c    |  3 +
> >>   drivers/staging/media/hantro/hantro_v4l2.c    | 19 ++---
> >>   5 files changed, 41 insertions(+), 96 deletions(-)
> >>
> >> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drive=
rs/staging/media/hantro/hantro_g2_hevc_dec.c
> >> index b35f36109a6f..6ef5430b18eb 100644
> >> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> >> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> >> @@ -341,6 +341,8 @@ static int set_ref(struct hantro_ctx *ctx)
> >>          const struct v4l2_hevc_dpb_entry *dpb =3D decode_params->dpb;
> >>          dma_addr_t luma_addr, chroma_addr, mv_addr =3D 0;
> >>          struct hantro_dev *vpu =3D ctx->dev;
> >> +       struct vb2_v4l2_buffer *vb2_dst;
> >> +       struct hantro_decoded_buffer *dst;
> >>          size_t cr_offset =3D hantro_hevc_chroma_offset(sps);
> >>          size_t mv_offset =3D hantro_hevc_motion_vectors_offset(sps);
> >>          u32 max_ref_frames;
> >> @@ -426,10 +428,15 @@ static int set_ref(struct hantro_ctx *ctx)
> >>                  hantro_write_addr(vpu, G2_REF_MV_ADDR(i), mv_addr);
> >>          }
> >>
> >> -       luma_addr =3D hantro_hevc_get_ref_buf(ctx, decode_params->pic_=
order_cnt_val);
> >> +       vb2_dst =3D hantro_get_dst_buf(ctx);
> >> +       dst =3D vb2_to_hantro_decoded_buf(&vb2_dst->vb2_buf);
> >> +       luma_addr =3D hantro_get_dec_buf_addr(ctx, &dst->base.vb.vb2_b=
uf);
> >>          if (!luma_addr)
> >>                  return -ENOMEM;
> >>
> >> +       if (hantro_hevc_add_ref_buf(ctx, decode_params->pic_order_cnt_=
val, luma_addr))
> >> +               return -EINVAL;
> >> +
> >>          chroma_addr =3D luma_addr + cr_offset;
> >>          mv_addr =3D luma_addr + mv_offset;
> >>
> >> @@ -456,16 +463,12 @@ static int set_ref(struct hantro_ctx *ctx)
> >>
> >>   static void set_buffers(struct hantro_ctx *ctx)
> >>   {
> >> -       struct vb2_v4l2_buffer *src_buf, *dst_buf;
> >> +       struct vb2_v4l2_buffer *src_buf;
> >>          struct hantro_dev *vpu =3D ctx->dev;
> >> -       const struct hantro_hevc_dec_ctrls *ctrls =3D &ctx->hevc_dec.c=
trls;
> >> -       const struct v4l2_ctrl_hevc_sps *sps =3D ctrls->sps;
> >> -       size_t cr_offset =3D hantro_hevc_chroma_offset(sps);
> >> -       dma_addr_t src_dma, dst_dma;
> >> +       dma_addr_t src_dma;
> >>          u32 src_len, src_buf_len;
> >>
> >>          src_buf =3D hantro_get_src_buf(ctx);
> >> -       dst_buf =3D hantro_get_dst_buf(ctx);
> >>
> >>          /* Source (stream) buffer. */
> >>          src_dma =3D vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, =
0);
> >> @@ -478,11 +481,6 @@ static void set_buffers(struct hantro_ctx *ctx)
> >>          hantro_reg_write(vpu, &g2_strm_start_offset, 0);
> >>          hantro_reg_write(vpu, &g2_write_mvs_e, 1);
> >>
> >> -       /* Destination (decoded frame) buffer. */
> >> -       dst_dma =3D hantro_get_dec_buf_addr(ctx, &dst_buf->vb2_buf);
> >> -
> >> -       hantro_write_addr(vpu, G2_RS_OUT_LUMA_ADDR, dst_dma);
> >> -       hantro_write_addr(vpu, G2_RS_OUT_CHROMA_ADDR, dst_dma + cr_off=
set);
> >>          hantro_write_addr(vpu, G2_TILE_SIZES_ADDR, ctx->hevc_dec.tile=
_sizes.dma);
> >>          hantro_write_addr(vpu, G2_TILE_FILTER_ADDR, ctx->hevc_dec.til=
e_filter.dma);
> >>          hantro_write_addr(vpu, G2_TILE_SAO_ADDR, ctx->hevc_dec.tile_s=
ao.dma);
> >> @@ -575,9 +573,6 @@ int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx)
> >>          /* Don't compress buffers */
> >>          hantro_reg_write(vpu, &g2_ref_compress_bypass, 1);
> >>
> >> -       /* use NV12 as output format */
> >> -       hantro_reg_write(vpu, &g2_out_rs_e, 1);
> >> -
> >>          /* Bus width and max burst */
> >>          hantro_reg_write(vpu, &g2_buswidth, BUS_WIDTH_128);
> >>          hantro_reg_write(vpu, &g2_max_burst, 16);
> >> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/stag=
ing/media/hantro/hantro_hevc.c
> >> index ee03123e7704..b49a41d7ae91 100644
> >> --- a/drivers/staging/media/hantro/hantro_hevc.c
> >> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> >> @@ -44,47 +44,6 @@ size_t hantro_hevc_motion_vectors_offset(const stru=
ct v4l2_ctrl_hevc_sps *sps)
> >>          return ALIGN((cr_offset * 3) / 2, G2_ALIGN);
> >>   }
> >>
> >> -static size_t hantro_hevc_mv_size(const struct v4l2_ctrl_hevc_sps *sp=
s)
> >> -{
> >> -       u32 min_cb_log2_size_y =3D sps->log2_min_luma_coding_block_siz=
e_minus3 + 3;
> >> -       u32 ctb_log2_size_y =3D min_cb_log2_size_y + sps->log2_diff_ma=
x_min_luma_coding_block_size;
> >> -       u32 pic_width_in_ctbs_y =3D (sps->pic_width_in_luma_samples + =
(1 << ctb_log2_size_y) - 1)
> >> -                                 >> ctb_log2_size_y;
> >> -       u32 pic_height_in_ctbs_y =3D (sps->pic_height_in_luma_samples =
+ (1 << ctb_log2_size_y) - 1)
> >> -                                  >> ctb_log2_size_y;
> >> -       size_t mv_size;
> >> -
> >> -       mv_size =3D pic_width_in_ctbs_y * pic_height_in_ctbs_y *
> >> -                 (1 << (2 * (ctb_log2_size_y - 4))) * 16;
> >> -
> >> -       vpu_debug(4, "%dx%d (CTBs) %zu MV bytes\n",
> >> -                 pic_width_in_ctbs_y, pic_height_in_ctbs_y, mv_size);
> >> -
> >> -       return mv_size;
> >> -}
> >> -
> >> -static size_t hantro_hevc_ref_size(struct hantro_ctx *ctx)
> >> -{
> >> -       const struct hantro_hevc_dec_ctrls *ctrls =3D &ctx->hevc_dec.c=
trls;
> >> -       const struct v4l2_ctrl_hevc_sps *sps =3D ctrls->sps;
> >> -
> >> -       return hantro_hevc_motion_vectors_offset(sps) + hantro_hevc_mv=
_size(sps);
> >> -}
> >> -
> >> -static void hantro_hevc_ref_free(struct hantro_ctx *ctx)
> >> -{
> >> -       struct hantro_hevc_dec_hw_ctx *hevc_dec =3D &ctx->hevc_dec;
> >> -       struct hantro_dev *vpu =3D ctx->dev;
> >> -       int i;
> >> -
> >> -       for (i =3D 0;  i < NUM_REF_PICTURES; i++) {
> >> -               if (hevc_dec->ref_bufs[i].cpu)
> >> -                       dma_free_coherent(vpu->dev, hevc_dec->ref_bufs=
[i].size,
> >> -                                         hevc_dec->ref_bufs[i].cpu,
> >> -                                         hevc_dec->ref_bufs[i].dma);
> >> -       }
> >> -}
> >> -
> >>   static void hantro_hevc_ref_init(struct hantro_ctx *ctx)
> >>   {
> >>          struct hantro_hevc_dec_hw_ctx *hevc_dec =3D &ctx->hevc_dec;
> >> @@ -108,37 +67,25 @@ dma_addr_t hantro_hevc_get_ref_buf(struct hantro_=
ctx *ctx,
> >>                  }
> >>          }
> >>
> >> -       /* Allocate a new reference buffer */
> >> +       return 0;
> >> +}
> >> +
> >> +int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr=
_t addr)
> >> +{
> >> +       struct hantro_hevc_dec_hw_ctx *hevc_dec =3D &ctx->hevc_dec;
> >> +       int i;
> >> +
> >> +       /* Add a new reference buffer */
> >>          for (i =3D 0; i < NUM_REF_PICTURES; i++) {
> >>                  if (hevc_dec->ref_bufs_poc[i] =3D=3D UNUSED_REF) {
> >> -                       if (!hevc_dec->ref_bufs[i].cpu) {
> >> -                               struct hantro_dev *vpu =3D ctx->dev;
> >> -
> >> -                               /*
> >> -                                * Allocate the space needed for the r=
aw data +
> >> -                                * motion vector data. Optimizations c=
ould be to
> >> -                                * allocate raw data in non coherent m=
emory and only
> >> -                                * clear the motion vector data.
> >> -                                */
> >> -                               hevc_dec->ref_bufs[i].cpu =3D
> >> -                                       dma_alloc_coherent(vpu->dev,
> >> -                                                          hantro_hevc=
_ref_size(ctx),
> >> -                                                          &hevc_dec->=
ref_bufs[i].dma,
> >> -                                                          GFP_KERNEL)=
;
> >> -                               if (!hevc_dec->ref_bufs[i].cpu)
> >> -                                       return 0;
> >> -
> >> -                               hevc_dec->ref_bufs[i].size =3D hantro_=
hevc_ref_size(ctx);
> >> -                       }
> >>                          hevc_dec->ref_bufs_used |=3D 1 << i;
> >> -                       memset(hevc_dec->ref_bufs[i].cpu, 0, hantro_he=
vc_ref_size(ctx));
> >>                          hevc_dec->ref_bufs_poc[i] =3D poc;
> >> -
> >> -                       return hevc_dec->ref_bufs[i].dma;
> >> +                       hevc_dec->ref_bufs[i].dma =3D addr;
> >> +                       return 0;
> >>                  }
> >>          }
> >>
> >> -       return 0;
> >> +       return -EINVAL;
> >>   }
> >>
> >>   void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx)
> >> @@ -314,8 +261,6 @@ void hantro_hevc_dec_exit(struct hantro_ctx *ctx)
> >>                                    hevc_dec->tile_bsd.cpu,
> >>                                    hevc_dec->tile_bsd.dma);
> >>          hevc_dec->tile_bsd.cpu =3D NULL;
> >> -
> >> -       hantro_hevc_ref_free(ctx);
> >>   }
> >>
> >>   int hantro_hevc_dec_init(struct hantro_ctx *ctx)
> >> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/stagin=
g/media/hantro/hantro_hw.h
> >> index dbe51303724b..7286404c32ab 100644
> >> --- a/drivers/staging/media/hantro/hantro_hw.h
> >> +++ b/drivers/staging/media/hantro/hantro_hw.h
> >> @@ -345,6 +345,7 @@ void hantro_hevc_dec_exit(struct hantro_ctx *ctx);
> >>   int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx);
> >>   int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
> >>   dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
> >> +int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr=
_t addr);
> >>   void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx);
> >>   size_t hantro_hevc_chroma_offset(const struct v4l2_ctrl_hevc_sps *sp=
s);
> >>   size_t hantro_hevc_motion_vectors_offset(const struct v4l2_ctrl_hevc=
_sps *sps);
> >> @@ -394,6 +395,16 @@ hantro_h264_mv_size(unsigned int width, unsigned =
int height)
> >>          return 64 * MB_WIDTH(width) * MB_WIDTH(height) + 32;
> >>   }
> >>
> >> +static inline size_t
> >> +hantro_hevc_mv_size(unsigned int width, unsigned int height)
> >> +{
> >> +       /*
> >> +        * A CTB can be 64x64, 32x32 or 16x16.
> >> +        * Allocated memory for the "worse" case: 16x16
> >> +        */
> >> +       return width * height / 16;
> >> +}
> >> +
> >>   int hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx);
> >>   int rockchip_vpu2_mpeg2_dec_run(struct hantro_ctx *ctx);
> >>   void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
> >> diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/=
staging/media/hantro/hantro_postproc.c
> >> index a7774ad4c445..248abe5423f0 100644
> >> --- a/drivers/staging/media/hantro/hantro_postproc.c
> >> +++ b/drivers/staging/media/hantro/hantro_postproc.c
> >> @@ -146,6 +146,9 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
> >>          else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_VP9_FRA=
ME)
> >>                  buf_size +=3D hantro_vp9_mv_size(ctx->dst_fmt.width,
> >>                                                 ctx->dst_fmt.height);
> >> +       else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_HEVC_SLI=
CE)
> >> +               buf_size +=3D hantro_hevc_mv_size(ctx->dst_fmt.width,
> >> +                                               ctx->dst_fmt.height);
> >>
> >>          for (i =3D 0; i < num_buffers; ++i) {
> >>                  struct hantro_aux_buf *priv =3D &ctx->postproc.dec_q[=
i];
> >> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/stag=
ing/media/hantro/hantro_v4l2.c
> >> index e4b0645ba6fc..e1fe37afe576 100644
> >> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> >> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> >> @@ -150,20 +150,6 @@ static int vidioc_enum_fmt(struct file *file, voi=
d *priv,
> >>          unsigned int num_fmts, i, j =3D 0;
> >>          bool skip_mode_none;
> >>
> >> -       /*
> >> -        * The HEVC decoder on the G2 core needs a little quirk to off=
er NV12
> >> -        * only on the capture side. Once the post-processor logic is =
used,
> >> -        * we will be able to expose NV12_4L4 and NV12 as the other ca=
ses,
> >> -        * and therefore remove this quirk.
> >> -        */
> >> -       if (capture && ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_HE=
VC_SLICE) {
> >> -               if (f->index =3D=3D 0) {
> >> -                       f->pixelformat =3D V4L2_PIX_FMT_NV12;
> >> -                       return 0;
> >> -               }
> >> -               return -EINVAL;
> >> -       }
> >> -
> >>          /*
> >>           * When dealing with an encoder:
> >>           *  - on the capture side we want to filter out all MODE_NONE=
 formats.
> >> @@ -304,6 +290,11 @@ static int hantro_try_fmt(const struct hantro_ctx=
 *ctx,
> >>                          pix_mp->plane_fmt[0].sizeimage +=3D
> >>                                  hantro_vp9_mv_size(pix_mp->width,
> >>                                                     pix_mp->height);
> >> +               else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_=
HEVC_SLICE &&
> >> +                        !hantro_needs_postproc(ctx, fmt))
> >> +                       pix_mp->plane_fmt[0].sizeimage +=3D
> >> +                               hantro_hevc_mv_size(pix_mp->width,
> >> +                                                   pix_mp->height);
> >>          } else if (!pix_mp->plane_fmt[0].sizeimage) {
> >>                  /*
> >>                   * For coded formats the application can specify
> >> --
> >> 2.30.2
> >>
