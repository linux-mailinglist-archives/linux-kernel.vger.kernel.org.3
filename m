Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0030955EF01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiF1UOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiF1UNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:13:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD4D3D1C6;
        Tue, 28 Jun 2022 13:06:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E028266015D7;
        Tue, 28 Jun 2022 21:06:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656446783;
        bh=TdZlXY7G4aJxyYrkgVpZR/A2OrB/GZvyCVaGoq3crDM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IwQoFKE+jbvGYpioi2//05gMO6BMaZNEfQDrNZ8X6vsCp6LjC5N8EpyeVkLvYyOLI
         Q3IXefbiND18EkYGch4mJzZLPSh+nm0Cf5rF0ueeR5AjkTY1+XPRRyMYao1fiB/CRN
         aHw6asS1dphbfqTS2e8a6o3B+BSTX+T53IFI9HiG8pNRcsgSVjimn1R+iu+lxRK8vz
         sIpbesj5Ya4xlWpy5ARluGflBN85x3I6i5jsiJli31r/37WVfXgalS62Za8s2E4FVm
         75O+vVuVeU1+x8BfhWXmb2cdhj+9CWRKjRxCu5bUcQ4k0QN0sr+RcVMtac1LWn930K
         +E42L2hbAGobw==
Message-ID: <5af02115c95f96116b161464d3be8a210dad9d97.camel@collabora.com>
Subject: Re: [PATCH v2 3/7] media: hantro: postproc: Fix buffer size
 calculation
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Date:   Tue, 28 Jun 2022 16:06:13 -0400
In-Reply-To: <3180111.44csPzL39Z@jernej-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
         <20220616202513.351039-4-jernej.skrabec@gmail.com>
         <YrskKxCDwSulaGJ5@eze-laptop> <3180111.44csPzL39Z@jernej-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 28 juin 2022 =C3=A0 18:13 +0200, Jernej =C5=A0krabec a =C3=A9crit=
=C2=A0:
> Dne torek, 28. junij 2022 ob 17:54:19 CEST je Ezequiel Garcia napisal(a):
> > Hi Jernej,
> >=20
> > On Thu, Jun 16, 2022 at 10:25:09PM +0200, Jernej Skrabec wrote:
> > > When allocating aux buffers for postprocessing, it's assumed that bas=
e
> > > buffer size is the same as that of output. Coincidentally, that's tru=
e
> > > most of the time, but not always. 10-bit source also needs aux buffer
> > > size which is appropriate for 10-bit native format, even if the outpu=
t
> > > format is 8-bit. Similarly, mv sizes and other extra buffer size also
> > > depends on source width/height, not destination.
> > >=20
> > > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> >=20
> > I took a new look at this patch.
> >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >=20
> > >  .../staging/media/hantro/hantro_postproc.c    | 24 +++++++++++++----=
--
> > >  drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
> > >  drivers/staging/media/hantro/hantro_v4l2.h    |  2 ++
> > >  3 files changed, 20 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/drivers/staging/media/hantro/hantro_postproc.c
> > > b/drivers/staging/media/hantro/hantro_postproc.c index
> > > ab168c1c0d28..b77cc55e43ea 100644
> > > --- a/drivers/staging/media/hantro/hantro_postproc.c
> > > +++ b/drivers/staging/media/hantro/hantro_postproc.c
> > > @@ -12,6 +12,7 @@
> > >=20
> > >  #include "hantro_hw.h"
> > >  #include "hantro_g1_regs.h"
> > >  #include "hantro_g2_regs.h"
> > >=20
> > > +#include "hantro_v4l2.h"
> > >=20
> > >  #define HANTRO_PP_REG_WRITE(vpu, reg_name, val) \
> > >  { \
> > >=20
> > > @@ -174,18 +175,27 @@ int hantro_postproc_alloc(struct hantro_ctx *ct=
x)
> > >=20
> > >  	struct v4l2_m2m_ctx *m2m_ctx =3D ctx->fh.m2m_ctx;
> > >  	struct vb2_queue *cap_queue =3D &m2m_ctx->cap_q_ctx.q;
> > >  	unsigned int num_buffers =3D cap_queue->num_buffers;
> > >=20
> > > +	struct v4l2_pix_format_mplane pix_mp;
> > > +	const struct hantro_fmt *fmt;
> > >=20
> > >  	unsigned int i, buf_size;
> > >=20
> > > -	buf_size =3D ctx->dst_fmt.plane_fmt[0].sizeimage;
> > > +	/* this should always pick native format */
> > > +	fmt =3D hantro_get_default_fmt(ctx, false);
> >=20
> > Clearly this is correct.
> >=20
> > When the driver enables the post-processor it decodes a coded format (H=
264,
> > etc.) to a native format (NV12_4L4 or P010_4L4) and feeds this into the
> > postprocessor engine to produce some other format (YUYV, NV12, etc.).
> >=20
> > The buffers allocated here should be taken from the native format,
> > so it's correct to use hantro_get_default_fmt().
> >=20
> > > +	if (!fmt)
> > > +		return -EINVAL;
> > > +	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> > > +			    ctx->src_fmt.height);
> >=20
> > The issue comes at this point, where we negotiate the buffer size based=
 on
> > the source size (OUTPUT queue size), instead of negotiating based
> > on the Native size.
> >=20
> >   Coded -> [ Decoder ] -> Native -> [ Post-processor ] -> Decoded
>=20
> I'm not sure what is the difference between source and native size? You m=
ean=20
> one coded in controls and one set via output format? IMO they should alwa=
ys be=20
> the same, otherwise it can be considered a bug in userspace application.

Indeed the src_fmt should use coded width/height (as per spec). The driver =
will
then adapt to its own requirement resulting into the "native" width height =
being
returned. Notice that s_ctrl() should fail in case of miss-match (this is C=
ODEC
specific), or streamon() should fail if the codec specific control have nev=
er
been set (as we always initialise this, it will fail due to default being a=
n
invalid value anyway).

As a side effect, when userland read the default format (G_FMT(CAPTURE), th=
e
width/height should match the src_dst for this driver. This is the native s=
ize.
The optional path that this driver enables is enumeration of CAPTURE format=
 and
frame sizes, combined with to select from these. The driver will create a
secondary set of buffers in the case.

Nicolas

>=20
> Best regards,
> Jernej
>=20
> >=20
> > So, while the patch is surely improving things, I wonder if it won't
> > cause other issues.
> >=20
> > This reminds me we are still lacking a more complete test-suite for thi=
s
> > driver, so that we can validate changes and ensure there are no
> > regressions.
> >=20
> > Perhaps we could hack Fluster to not only test the conformance,
> > but also test the post-processor?
> >=20
> > Thanks,
> > Ezequiel
> >=20
> > > +
> > > +	buf_size =3D pix_mp.plane_fmt[0].sizeimage;
> > >=20
> > >  	if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_H264_SLICE)
> > >=20
> > > -		buf_size +=3D hantro_h264_mv_size(ctx->dst_fmt.width,
> > > -						ctx-
> > dst_fmt.height);
> > > +		buf_size +=3D hantro_h264_mv_size(pix_mp.width,
> > > +					=09
> pix_mp.height);
> > >=20
> > >  	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_VP9_FRAME)
> > >=20
> > > -		buf_size +=3D hantro_vp9_mv_size(ctx->dst_fmt.width,
> > > -					       ctx-
> > dst_fmt.height);
> > > +		buf_size +=3D hantro_vp9_mv_size(pix_mp.width,
> > > +					       pix_mp.height);
> > >=20
> > >  	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_HEVC_SLICE)
> > >=20
> > > -		buf_size +=3D hantro_hevc_mv_size(ctx->dst_fmt.width,
> > > -						ctx-
> > dst_fmt.height);
> > > +		buf_size +=3D hantro_hevc_mv_size(pix_mp.width,
> > > +					=09
> pix_mp.height);
> > >=20
> > >  	for (i =3D 0; i < num_buffers; ++i) {
> > >  =09
> > >  		struct hantro_aux_buf *priv =3D &ctx->postproc.dec_q[i];
> > >=20
> > > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c
> > > b/drivers/staging/media/hantro/hantro_v4l2.c index
> > > 334f18a4120d..2c7a805289e7 100644
> > > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > > @@ -118,7 +118,7 @@ hantro_find_format(const struct hantro_ctx *ctx, =
u32
> > > fourcc)>=20
> > >  	return NULL;
> > > =20
> > >  }
> > >=20
> > > -static const struct hantro_fmt *
> > > +const struct hantro_fmt *
> > >=20
> > >  hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
> > >  {
> > > =20
> > >  	const struct hantro_fmt *formats;
> > >=20
> > > diff --git a/drivers/staging/media/hantro/hantro_v4l2.h
> > > b/drivers/staging/media/hantro/hantro_v4l2.h index
> > > b17e84c82582..64f6f57e9d7a 100644
> > > --- a/drivers/staging/media/hantro/hantro_v4l2.h
> > > +++ b/drivers/staging/media/hantro/hantro_v4l2.h
> > > @@ -23,5 +23,7 @@ extern const struct vb2_ops hantro_queue_ops;
> > >=20
> > >  void hantro_reset_fmts(struct hantro_ctx *ctx);
> > >  int hantro_get_format_depth(u32 fourcc);
> > >=20
> > > +const struct hantro_fmt *
> > > +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)=
;
> > >=20
> > >  #endif /* HANTRO_V4L2_H_ */
>=20
>=20
>=20
>=20

