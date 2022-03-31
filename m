Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE8D4EE05A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiCaS1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiCaS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:27:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762913DFC;
        Thu, 31 Mar 2022 11:25:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 117421F46814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648751149;
        bh=ErKTvh7tRRQkBTG8doKmHes8bgpQTZV4rTW/0ZXc+Yw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NBRHXXKVZxAl+xaiCWCRR4+w6p1ZJDeTI4ZeOzRiWPAHaDeHJlxIzvg2G3oVR1nIr
         9y5ve8cmXkGg+VcG5WZRbB2zHe2c4qfX5Ou4AuMilBElxuWV+X2XBCvT+v9rNbJVhB
         A1A1EFFfJBCTjnNtTmgVSXDzDJLgcgApWdXvm5gqLjxXhFTvu9wYNOkU/AeLh9ZMhp
         TtmMN8dxLtX/hTBnWMQoqschGT2p/kgqKYuy4fY57T3kugYB/W3HZ4kWzTAoqtRrtV
         2LeLHPZuvnt7lt9bKognP9FhxVsYSR7Aaj98g2hPZTV2cg70Z6+O8jjSmKq0g8g7za
         GANHAbMwZ161A==
Message-ID: <8a59875f62ac1a60aec91c9170c1471234e1b4db.camel@collabora.com>
Subject: Re: [PATCH v1 20/24] media: hantro: Enable HOLD_CAPTURE_BUF for
 H.264
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Mar 2022 14:25:37 -0400
In-Reply-To: <20220330073600.crbi5wqlp4rimx2a@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-21-nicolas.dufresne@collabora.com>
         <20220330073600.crbi5wqlp4rimx2a@basti-XPS-13-9310>
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

Le mercredi 30 mars 2022 =C3=A0 09:36 +0200, Sebastian Fricke a =C3=A9crit=
=C2=A0:
> Hey Nicolas,
>=20
> On 28.03.2022 15:59, Nicolas Dufresne wrote:
> > This is needed to optimizing field decoding. Each field will be
>=20
> s/is needed to optimizing/is needed to optimize/
>=20
> > decoded in the same capture buffer, so to make use of the queues
>=20
> s/in the same/into the same/
>=20
> > we need to be able to ask the driver to keep the capture buffer.
>=20
> How about:
> """
> During field decoding each field will be decoded into the same capture
> buffer. Optimise this mode by asking the driver to hold the buffer until
> all fields are written into it.
> """
>=20
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Perhaps avoid giving a reviewed by if you are to comment around modifying t=
he
code ? I will though keep the code as is, I believe there is more good then=
 bad
around the form.

>=20
> > ---
> > drivers/staging/media/hantro/hantro_v4l2.c | 25 ++++++++++++++++++++++
> > 1 file changed, 25 insertions(+)
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/stagi=
ng/media/hantro/hantro_v4l2.c
> > index 67148ba346f5..50d636678ff3 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > @@ -409,6 +409,30 @@ hantro_update_requires_request(struct hantro_ctx *=
ctx, u32 fourcc)
> > 	}
> > }
> >=20
> > +static void
> > +hantro_update_requires_hold_capture_buf(struct hantro_ctx *ctx, u32 fo=
urcc)
> > +{
> > +	struct vb2_queue *vq;
> > +
> > +	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > +			     V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
> > +
> > +	switch (fourcc) {
> > +	case V4L2_PIX_FMT_JPEG:
> > +	case V4L2_PIX_FMT_MPEG2_SLICE:
> > +	case V4L2_PIX_FMT_VP8_FRAME:
> > +	case V4L2_PIX_FMT_HEVC_SLICE:
> > +	case V4L2_PIX_FMT_VP9_FRAME:
> > +		vq->subsystem_flags &=3D ~(VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF=
);
> > +		break;
>=20
> Out of curiosity, why would it be bad for the other codecs to have
> support for that feature activated? As this doesn't actually hold the
> buffers but only makes sure that they could be held.
>=20
> > +	case V4L2_PIX_FMT_H264_SLICE:
> > +		vq->subsystem_flags |=3D VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
>=20
> I think it is worth it to highlight with a comment why only this one
> receives support for holding the buffer. As it is quite confusing
> without background info and just the code.

As this code is quite separate from the actual codec code, I believe it wil=
l be
more robust this way. It could happen in the future that code get modified
without taking into account that a buffer may be held. This also mimic how =
this
was implemented in Cedrus fwiw.

Note that it needs to be added for MPEG2 field decoding too, but I believe =
this
is unrelated to this patchset, the form is nice for adding more in the futu=
re.

>=20
> How about:
> ```
> /*
>   * During field decoding in H264, all fields are written into the
>   * same capture buffer, thus we need to be able to hold the buffer
>   * until all fields are written to it
>   */
> ```
>=20
> > +		break;
> > +	default:
>=20
> The only other decoding formats remaining are:
> - V4L2_PIX_FMT_NV12_4L4
> - V4L2_PIX_FMT_NV12

You'll never get raw formats in that switch. The cases are exhaustive for t=
he
context, yet the compiler does not understand that context.

>=20
> Both have codec mode HANTRO_MODE_NONE.
>=20
> My thought is:
> If we don't care for these two, the we might as well disable buffer holdi=
ng
> support for them as well. So, we could make this simplier
> (but a bit less descriptive):
>=20
> ```
> /*
>   * During field decoding in H264, all fields are written into the
>   * same capture buffer, thus we need to be able to hold the buffer
>   * until all fields are written to it
>   */
> if (fourcc =3D=3D V4L2_PIX_FMT_H264_SLICE)
>      vq->subsystem_flags |=3D VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
> else=20
> 		vq->subsystem_flags &=3D ~(VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF);
> ```
>=20
> Greetings,
> Sebastian
>=20
> > +		break;
> > +	}
> > +}
> > +
> > static int hantro_set_fmt_out(struct hantro_ctx *ctx,
> > 			      struct v4l2_pix_format_mplane *pix_mp)
> > {
> > @@ -472,6 +496,7 @@ static int hantro_set_fmt_out(struct hantro_ctx *ct=
x,
> > 	ctx->dst_fmt.quantization =3D pix_mp->quantization;
> >=20
> > 	hantro_update_requires_request(ctx, pix_mp->pixelformat);
> > +	hantro_update_requires_hold_capture_buf(ctx, pix_mp->pixelformat);
> >=20
> > 	vpu_debug(0, "OUTPUT codec mode: %d\n", ctx->vpu_src_fmt->codec_mode);
> > 	vpu_debug(0, "fmt - w: %d, h: %d\n",
> > --=20
> > 2.34.1
> >=20

