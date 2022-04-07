Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9EA4F890D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiDGVKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiDGVKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:10:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0D17E35D;
        Thu,  7 Apr 2022 14:08:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id D95B61F4684B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649365713;
        bh=+Q9tzF5zrewPPQUetcYP2NwCnZ0F1sUYBWrvcIXKjdI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZYqA6jwNGkRb407zynQi+lH+uUBljFjQ9q4URjZir+aA1kGgsH/0jQzVvRQTW2sEv
         SUPx4yUIQJNWgou8H4IpgO4velWdf77zxiX+pW4GYqjOC4hkG+V/lE59XVZ30H6GyO
         6TP183Nyhgl3hURtGfu8gv6iiPUYX/CHiwE9lR6mzqB0LXBXzyy+D8ENortk7PCSP/
         zCsyCzAW4XGfrJS7mBpX1ty6EiGxokY3f90ZDuX7TdUE2hK0g9k3qIxaoe177fUdT5
         mqRiZF/R6qv9jnOY21wYRNGl2y0H5xt5U90vkKsgwNKLe3DBzpNIyWuC4Sh0Oyq5Cr
         DOMl2yH0mxD0w==
Message-ID: <3297d1a4804b20d5d8d32013e5776109fa10c96f.camel@collabora.com>
Subject: Re: [PATCH v5 06/17] media: uapi: HEVC: Change pic_order_cnt
 definition in v4l2_hevc_dpb_entry
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        sebastian.fricke@collabora.com
Date:   Thu, 07 Apr 2022 17:08:22 -0400
In-Reply-To: <b137de92ea0a6ecc3aa8ff39f6a1fc96b071b3e4.camel@collabora.com>
References: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
         <20220407152940.738159-7-benjamin.gaignard@collabora.com>
         <b137de92ea0a6ecc3aa8ff39f6a1fc96b071b3e4.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 07 avril 2022 =C3=A0 16:51 -0400, Nicolas Dufresne a =C3=A9crit=C2=
=A0:
> Le jeudi 07 avril 2022 =C3=A0 17:29 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> > HEVC specifications say that:
> > "PicOrderCntVal is derived as follows:
> > PicOrderCntVal =3D PicOrderCntMsb + slice_pic_order_cnt_lsb
> > The value of PicOrderCntVal shall be in the range of =E2=88=92231 to 23=
1 =E2=88=92 1, inclusive."
>=20
> Did you mean 2^31 ?
>=20
> >=20
> > To match with these definitions change __u16 pic_order_cnt[2]
> > into __s32 pic_order_cnt_val.
> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> > version 5:
> > - change __u16 pic_order_cnt[2] into __s32 pic_order_cnt_val
> >  drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 4 ++--
> >  drivers/staging/media/hantro/hantro_hevc.c        | 2 +-
> >  drivers/staging/media/hantro/hantro_hw.h          | 4 ++--
> >  drivers/staging/media/sunxi/cedrus/cedrus_h265.c  | 4 ++--
> >  include/media/hevc-ctrls.h                        | 2 +-
> >  5 files changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/driver=
s/staging/media/hantro/hantro_g2_hevc_dec.c
> > index c524af41baf5..6f3c774aa3d9 100644
> > --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> > +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> > @@ -386,7 +386,7 @@ static int set_ref(struct hantro_ctx *ctx)
> >  	 * pic_order_cnt[0] and ignore pic_order_cnt[1] used in field-coding.
> >  	 */
> >  	for (i =3D 0; i < decode_params->num_active_dpb_entries && i < ARRAY_=
SIZE(cur_poc); i++) {
> > -		char poc_diff =3D decode_params->pic_order_cnt_val - dpb[i].pic_orde=
r_cnt[0];
> > +		char poc_diff =3D decode_params->pic_order_cnt_val - dpb[i].pic_orde=
r_cnt_val;
> > =20
> >  		hantro_reg_write(vpu, &cur_poc[i], poc_diff);
> >  	}
> > @@ -413,7 +413,7 @@ static int set_ref(struct hantro_ctx *ctx)
> >  	dpb_longterm_e =3D 0;
> >  	for (i =3D 0; i < decode_params->num_active_dpb_entries &&
> >  	     i < (V4L2_HEVC_DPB_ENTRIES_NUM_MAX - 1); i++) {
> > -		luma_addr =3D hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt[0]);
> > +		luma_addr =3D hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt_val)=
;
> >  		if (!luma_addr)
> >  			return -ENOMEM;
> > =20
> > diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/stagi=
ng/media/hantro/hantro_hevc.c
> > index b6ec86d03d91..fadd40768579 100644
> > --- a/drivers/staging/media/hantro/hantro_hevc.c
> > +++ b/drivers/staging/media/hantro/hantro_hevc.c
> > @@ -54,7 +54,7 @@ static void hantro_hevc_ref_init(struct hantro_ctx *c=
tx)
> >  }
> > =20
> >  dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx,
> > -				   int poc)
> > +				   s32 poc)
> >  {
> >  	struct hantro_hevc_dec_hw_ctx *hevc_dec =3D &ctx->hevc_dec;
> >  	int i;
> > diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging=
/media/hantro/hantro_hw.h
> > index ed018e293ba0..a648c529662b 100644
> > --- a/drivers/staging/media/hantro/hantro_hw.h
> > +++ b/drivers/staging/media/hantro/hantro_hw.h
> > @@ -131,7 +131,7 @@ struct hantro_hevc_dec_hw_ctx {
> >  	struct hantro_aux_buf tile_bsd;
> >  	struct hantro_aux_buf ref_bufs[NUM_REF_PICTURES];
> >  	struct hantro_aux_buf scaling_lists;
> > -	int ref_bufs_poc[NUM_REF_PICTURES];
> > +	s32 ref_bufs_poc[NUM_REF_PICTURES];
>=20
> Was this strictly needed ? Isn't int always same as s32 ?
>=20
> >  	u32 ref_bufs_used;
> >  	struct hantro_hevc_dec_ctrls ctrls;
> >  	unsigned int num_tile_cols_allocated;
> > @@ -337,7 +337,7 @@ int hantro_hevc_dec_init(struct hantro_ctx *ctx);
> >  void hantro_hevc_dec_exit(struct hantro_ctx *ctx);
> >  int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx);
> >  int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
> > -dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
> > +dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
> >  int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_=
t addr);
> >  void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx);
> >  size_t hantro_hevc_chroma_offset(const struct v4l2_ctrl_hevc_sps *sps)=
;
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers=
/staging/media/sunxi/cedrus/cedrus_h265.c
> > index 44f385be9f6c..d04521ffd920 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > @@ -143,8 +143,8 @@ static void cedrus_h265_frame_info_write_dpb(struct=
 cedrus_ctx *ctx,
> >  	for (i =3D 0; i < num_active_dpb_entries; i++) {
> >  		int buffer_index =3D vb2_find_timestamp(vq, dpb[i].timestamp, 0);
> >  		u32 pic_order_cnt[2] =3D {
> > -			dpb[i].pic_order_cnt[0],
> > -			dpb[i].pic_order_cnt[1]
> > +			dpb[i].pic_order_cnt_val & 0xffff,
> > +			(dpb[i].pic_order_cnt_val >> 16) & 0xffff
>=20
> This is confusing, it gives the impression that pic_order_cnt_val contain=
s TOP
> and BOTTOM field pic_order_cnt, which isn't the case. This is just the fu=
ll pic
> order count value for this reference.
>=20
> This is confusing me, most HEVC decoder don't really know about fields. T=
hey
> will instead happily produce half height frames, and we should support th=
is in
> the form of ALTERNATE or SEQ interlacing output.
>=20
> While it seems like Allwinner HW maybe support interleaved output, there =
I would
> not find any userland that would implement this, hence proving that it wo=
rks.
> Overall, interlaced HEVC (a very niche use case) should be studied, and w=
e
> should ensure that alternate/seq interlacing is possible, since a lot of =
HW will
> only offer this.

I looked a bit more at the reverse-engineering data for that chip, and what
should happen is that the pic_order_cnt_val should be set into pic_order_cn=
t[0].
The code handling this later on does:

	struct cedrus_h265_sram_frame_info frame_info =3D {
		.top_pic_order_cnt =3D cpu_to_le32(pic_order_cnt[0]),
		.bottom_pic_order_cnt =3D cpu_to_le32(field_pic ?
						    pic_order_cnt[1] :
						    pic_order_cnt[0]),

Now, the pic_oder_cnt[1] is the other field. Things is that the two field w=
on't
endup in the same frame buffer magically. In fact we'll need some tinkering=
 on
how this could possibly be supported. In GStreamer we only have the DXVA ba=
sed
decoder that supports field decoding, and each field endups in their own su=
rface
(our buffers). This looks more natural for Hantro here at least. Though per=
haps
there exist stride trick to interleave them, but then we need special care =
for
the extra buffers. I think we need to think through what we want to offer h=
ere,
anything from SEQ or interleaved buffer will require some more thinking, wh=
ile
alternate interlacing would be rather simple (handle by userland mostly) an=
d
will be more portable. Even Cedrus should be usable in that mode by ignorin=
g its
interleaving capability.=20

>=20
> >  		};
> > =20
> >  		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
> > diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> > index b3540167df9e..2812778b41f4 100644
> > --- a/include/media/hevc-ctrls.h
> > +++ b/include/media/hevc-ctrls.h
> > @@ -138,7 +138,7 @@ struct v4l2_hevc_dpb_entry {
> >  	__u64	timestamp;
> >  	__u8	flags;
> >  	__u8	field_pic;
> > -	__u16	pic_order_cnt[2];
> > +	__s32	pic_order_cnt_val;
> >  	__u8	padding[2];
> >  };
> > =20
>=20

