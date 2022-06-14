Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6C54B500
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344390AbiFNPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbiFNPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:44:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E604092D;
        Tue, 14 Jun 2022 08:44:06 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F6946601657;
        Tue, 14 Jun 2022 16:44:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655221445;
        bh=cd0P/gWG7CcRBJFoMG/n68S7b9z3ygl1jWiCWja+9eQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UT+OQ+lRbt6Sug2lOMBT71NnVAZhJwJtE1hsk40iXeAs31eIqwqiUuGbnHIKw5vsE
         6h1yYiCiFREYlaVfSTN+H6uqTiW9OF8Wd1KQ2kJMadiSDsRSHJ/WQT5nBnpVrZ8bl0
         UihAlmplblU02uuSvNI2UImSHFlfnQ1ss32thKXGCe36wRIeXVgpgUWPF0yQp1VZuM
         TcyENZG3MtydbsklkIoM/ntPrjngNzhPghiqJ8R73oXL/ISASFTM+lbicncy+B86Hv
         mFmMjml8Nxau++xzoFad8+65edvjHm2qL+14tcbQ9JAmbFUzbGar0eit70x/ww/Khh
         FN5ol4l6kKq8g==
Message-ID: <958ab30f9cfbb14e4a7ea55826064e6a20d5ffd2.camel@collabora.com>
Subject: Re: [PATCH v8 14/17] media: hantro: Stop using Hantro dedicated
 control
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Date:   Tue, 14 Jun 2022 11:43:54 -0400
In-Reply-To: <b244e86d-06de-7423-d0df-e77485ce4c87@xs4all.nl>
References: <20220614083614.240641-1-benjamin.gaignard@collabora.com>
         <20220614083614.240641-15-benjamin.gaignard@collabora.com>
         <b244e86d-06de-7423-d0df-e77485ce4c87@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 14 juin 2022 =C3=A0 15:58 +0200, Hans Verkuil a =C3=A9crit=C2=A0:
> On 6/14/22 10:36, Benjamin Gaignard wrote:
> > The number of bits to skip in the slice header can be computed
> > in the driver by using sps, pps and decode_params information.
> > This allow to remove Hantro dedicated control.
>=20
> allow -> makes it possible
>=20
> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> >  drivers/staging/media/hantro/hantro_drv.c     | 36 -----------
> >  .../staging/media/hantro/hantro_g2_hevc_dec.c | 62 ++++++++++++++++++-
> >  include/media/hevc-ctrls.h                    | 13 ----
> >  3 files changed, 61 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/stagin=
g/media/hantro/hantro_drv.c
> > index 536c8c374952..5aac3a090480 100644
> > --- a/drivers/staging/media/hantro/hantro_drv.c
> > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > @@ -304,26 +304,6 @@ static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ct=
rl)
> >  	return 0;
> >  }
> > =20
> > -static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
> > -{
> > -	struct hantro_ctx *ctx;
> > -
> > -	ctx =3D container_of(ctrl->handler,
> > -			   struct hantro_ctx, ctrl_handler);
> > -
> > -	vpu_debug(1, "s_ctrl: id =3D %d, val =3D %d\n", ctrl->id, ctrl->val);
> > -
> > -	switch (ctrl->id) {
> > -	case V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP:
> > -		ctx->hevc_dec.ctrls.hevc_hdr_skip_length =3D ctrl->val;
> > -		break;
> > -	default:
> > -		return -EINVAL;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct v4l2_ctrl_ops hantro_ctrl_ops =3D {
> >  	.try_ctrl =3D hantro_try_ctrl,
> >  };
> > @@ -332,10 +312,6 @@ static const struct v4l2_ctrl_ops hantro_jpeg_ctrl=
_ops =3D {
> >  	.s_ctrl =3D hantro_jpeg_s_ctrl,
> >  };
> > =20
> > -static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops =3D {
> > -	.s_ctrl =3D hantro_hevc_s_ctrl,
> > -};
> > -
> >  #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
> >  					 V4L2_JPEG_ACTIVE_MARKER_COM | \
> >  					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
> > @@ -487,18 +463,6 @@ static const struct hantro_ctrl controls[] =3D {
> >  		.cfg =3D {
> >  			.id =3D V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
> >  		},
> > -	}, {
> > -		.codec =3D HANTRO_HEVC_DECODER,
> > -		.cfg =3D {
> > -			.id =3D V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP,
> > -			.name =3D "Hantro HEVC slice header skip bytes",
> > -			.type =3D V4L2_CTRL_TYPE_INTEGER,
> > -			.min =3D 0,
> > -			.def =3D 0,
> > -			.max =3D 0x100,
> > -			.step =3D 1,
> > -			.ops =3D &hantro_hevc_ctrl_ops,
> > -		},
> >  	}, {
> >  		.codec =3D HANTRO_VP9_DECODER,
> >  		.cfg =3D {
> > diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/driver=
s/staging/media/hantro/hantro_g2_hevc_dec.c
> > index d28653d04d20..3be8d6e60bf0 100644
> > --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> > +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> > @@ -117,6 +117,66 @@ static void prepare_tile_info_buffer(struct hantro=
_ctx *ctx)
> >  		vpu_debug(1, "%s: no chroma!\n", __func__);
> >  }
> > =20
> > +static unsigned int ceil_log2(unsigned int v)
> > +{
> > +	/* Compute Ceil(Log2(v))
> > +	 * Derived from branchless code for integer log2(v) from:
> > +	 * <http://graphics.stanford.edu/~seander/bithacks.html#IntegerLog>
> > +	 */
> > +	unsigned int r, shift;
> > +
> > +	v--;
> > +	r =3D (v > 0xFFFF) << 4;
> > +	v >>=3D r;
> > +	shift =3D (v > 0xFF) << 3;
> > +	v >>=3D shift;
> > +	r |=3D shift;
> > +	shift =3D (v > 0xF) << 2;
> > +	v >>=3D shift;
> > +	r |=3D shift;
> > +	shift =3D (v > 0x3) << 1;
> > +	v >>=3D shift;
> > +	r |=3D shift;
> > +	r |=3D (v >> 1);
> > +
> > +	return r + 1;
> > +}
>=20
> Isn't this identical to fls(v - 1)? See also lib/math/reciprocal_div.c
> where this is used.

Thanks for pointing this out, I was wondering if there was an equivalent, a=
nd
never knew there was a relation between log2() and the "last set bit". Not =
sure
about the -1 here though, can you extend ?

>=20
> Regards,
>=20
> 	Hans
>=20
> > +
> > +static int compute_header_skip_lenght(struct hantro_ctx *ctx)
> > +{
> > +	const struct hantro_hevc_dec_ctrls *ctrls =3D &ctx->hevc_dec.ctrls;
> > +	const struct v4l2_ctrl_hevc_decode_params *decode_params =3D ctrls->d=
ecode_params;
> > +	const struct v4l2_ctrl_hevc_sps *sps =3D ctrls->sps;
> > +	const struct v4l2_ctrl_hevc_pps *pps =3D ctrls->pps;
> > +	int skip =3D 0;
> > +
> > +	if (pps->flags & V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT)
> > +		/* size of pic_output_flag */
> > +		skip++;
> > +
> > +	if (sps->flags & V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE)
> > +		/* size of pic_order_cnt_lsb */
> > +		skip +=3D 2;
> > +
> > +	if (!(decode_params->flags & V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC)) {
> > +		/* size of pic_order_cnt_lsb */
> > +		skip +=3D sps->log2_max_pic_order_cnt_lsb_minus4 + 4;
> > +
> > +		/* size of short_term_ref_pic_set_sps_flag */
> > +		skip++;
> > +
> > +		if (decode_params->short_term_ref_pic_set_size)
> > +			/* size of st_ref_pic_set( num_short_term_ref_pic_sets ) */
> > +			skip +=3D decode_params->short_term_ref_pic_set_size;
> > +		else if (sps->num_short_term_ref_pic_sets > 1)
> > +			skip +=3D ceil_log2(sps->num_short_term_ref_pic_sets);
> > +
> > +		skip +=3D decode_params->long_term_ref_pic_set_size;
> > +	}
> > +
> > +	return skip;
> > +}
> > +
> >  static void set_params(struct hantro_ctx *ctx)
> >  {
> >  	const struct hantro_hevc_dec_ctrls *ctrls =3D &ctx->hevc_dec.ctrls;
> > @@ -134,7 +194,7 @@ static void set_params(struct hantro_ctx *ctx)
> > =20
> >  	hantro_reg_write(vpu, &g2_output_8_bits, 0);
> > =20
> > -	hantro_reg_write(vpu, &g2_hdr_skip_length, ctrls->hevc_hdr_skip_lengt=
h);
> > +	hantro_reg_write(vpu, &g2_hdr_skip_length, compute_header_skip_lenght=
(ctx));
> > =20
> >  	min_log2_cb_size =3D sps->log2_min_luma_coding_block_size_minus3 + 3;
> >  	max_log2_ctb_size =3D min_log2_cb_size + sps->log2_diff_max_min_luma_=
coding_block_size;
> > diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> > index d6cb3779d190..efc0412ac41e 100644
> > --- a/include/media/hevc-ctrls.h
> > +++ b/include/media/hevc-ctrls.h
> > @@ -467,17 +467,4 @@ struct v4l2_ctrl_hevc_scaling_matrix {
> >  	__u8	scaling_list_dc_coef_32x32[2];
> >  };
> > =20
> > -/*  MPEG-class control IDs specific to the Hantro driver as defined by=
 V4L2 */
> > -#define V4L2_CID_CODEC_HANTRO_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1200)
> > -/*
> > - * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
> > - * the number of data (in bits) to skip in the
> > - * slice segment header.
> > - * If non-IDR, the bits to be skipped go from syntax element "pic_outp=
ut_flag"
> > - * to before syntax element "slice_temporal_mvp_enabled_flag".
> > - * If IDR, the skipped bits are just "pic_output_flag"
> > - * (separate_colour_plane_flag is not supported).
> > - */
> > -#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	(V4L2_CID_CODEC_HANTRO_=
BASE + 0)
> > -
> >  #endif
>=20

