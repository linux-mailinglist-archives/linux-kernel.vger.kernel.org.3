Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A274EC834
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348174AbiC3P2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348186AbiC3P1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:27:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1401A9CB8;
        Wed, 30 Mar 2022 08:26:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id D0C5C1F422A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648653964;
        bh=BG8siRAN82v+w8F/ZIVjguEaZ9A/MnFMwINvZvy6sDw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hR3Bzqvbqrhf5B/MPfTULES4Qqe6nLiJdtWkNlmolsaCaOdSgnraPfFFE5RSHhDb/
         9AyZJNx80mvOysTf8IAomlcegAU7ypLiIQsfDnMrqM6JwpNPCy+SIxMICZ6Uz5GgZX
         5SYPaBeKLkRZ+sfFYXL0PBOu2pacUhNTL7TphrjzLS1uTSuZwboJAbOhrkmHp1HjKc
         DPzwpfwGIjMG3UON8ktdyx8P58Owby9DEha/qMHvNHsPg+AdyzSZjNqJmPtyPmPHFu
         ZGnv1zsqrYf2FVjfVwv1Yg67JtIZbWulOKTdM67xI4Gd+mmEEvzZospY50BEmPI7Lr
         GYXB0cAug7uuA==
Message-ID: <5ccf5e2924ff9609ee37a4eed73705380e8cce94.camel@collabora.com>
Subject: Re: [PATCH v1 23/24] media: hantro: Add H.264 field decoding support
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 11:25:53 -0400
In-Reply-To: <20220330090345.pxx54emtalz6vgqt@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-24-nicolas.dufresne@collabora.com>
         <20220330090345.pxx54emtalz6vgqt@basti-XPS-13-9310>
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

Le mercredi 30 mars 2022 =C3=A0 11:03 +0200, Sebastian Fricke a =C3=A9crit=
=C2=A0:
> Hey Nicolas,
>=20
> On 28.03.2022 15:59, Nicolas Dufresne wrote:
> > This adds the required code to support field decoding. While most of
> > the code is derived from Rockchip and VSI reference code, the
> > reduction of the reference list to 16 entries has been found by
>=20
> s/has been/was/
>=20
> > trial and errors. The list consist of all the references with the
>=20
> s/consist/consists/
>=20
> > opposite field parity.
> >=20
> > The strategy being to deduplicate the reference picture that points
>=20
> s/strategy being to/strategy is to/
>=20
> > to the same storage (same index). The choice of opposite parity has
> > been made to keep the other field or a field pair to be kept in the
>=20
> Do you mean?
>=20
> s/keep the other field or a field pair to be kept/
>    keep the other field of a field pair/
>=20
> > list. This method may not be robust if a field was lost.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> > drivers/staging/media/hantro/hantro_h264.c | 107 ++++++++++++++++++---
> > drivers/staging/media/hantro/hantro_hw.h   |   1 +
> > 2 files changed, 94 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/stagi=
ng/media/hantro/hantro_h264.c
> > index 7377fc26f780..f6fc939aa726 100644
> > --- a/drivers/staging/media/hantro/hantro_h264.c
> > +++ b/drivers/staging/media/hantro/hantro_h264.c
> > @@ -22,6 +22,11 @@
> > #define POC_BUFFER_SIZE			34
> > #define SCALING_LIST_SIZE		(6 * 16 + 2 * 64)
> >=20
> > +/* For valid and long term reference marking, index are reversed, so b=
it 31
>=20
> s/index/indeces/
>=20
> > + * indicates the status of the picture 0.
> > + */
> > +#define REF_BIT(i)			BIT(32 - 1 - (i))
> > +
> > /* Data structure describing auxiliary buffer format. */
> > struct hantro_h264_dec_priv_tbl {
> > 	u32 cabac_table[CABAC_INIT_BUFFER_SIZE];
> > @@ -227,6 +232,7 @@ static void prepare_table(struct hantro_ctx *ctx)
> > {
> > 	const struct hantro_h264_dec_ctrls *ctrls =3D &ctx->h264_dec.ctrls;
> > 	const struct v4l2_ctrl_h264_decode_params *dec_param =3D ctrls->decode=
;
> > +	const struct v4l2_ctrl_h264_sps *sps =3D ctrls->sps;
> > 	struct hantro_h264_dec_priv_tbl *tbl =3D ctx->h264_dec.priv.cpu;
> > 	const struct v4l2_h264_dpb_entry *dpb =3D ctx->h264_dec.dpb;
> > 	u32 dpb_longterm =3D 0;
> > @@ -237,20 +243,45 @@ static void prepare_table(struct hantro_ctx *ctx)
> > 		tbl->poc[i * 2] =3D dpb[i].top_field_order_cnt;
> > 		tbl->poc[i * 2 + 1] =3D dpb[i].bottom_field_order_cnt;
> >=20
> > +		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> > +			continue;
> > +
> > 		/*
> > 		 * Set up bit maps of valid and long term DPBs.
> > -		 * NOTE: The bits are reversed, i.e. MSb is DPB 0.
> > +		 * NOTE: The bits are reversed, i.e. MSb is DPB 0. For frame
> > +		 * decoding, bit 31 to 15 are used, while for field decoding,
>=20
> s/bit 31/bits 31/
>=20
> > +		 * all bits are used, with bit 31 being a top field, 30 a bottom
> > +		 * field and so on.
> > 		 */
> > -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > -			dpb_valid |=3D BIT(HANTRO_H264_DPB_SIZE - 1 - i);
> > -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
> > -			dpb_longterm |=3D BIT(HANTRO_H264_DPB_SIZE - 1 - i);
> > +		if (dec_param->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) {
> > +			if (dpb[i].fields & V4L2_H264_TOP_FIELD_REF)
> > +				dpb_valid |=3D REF_BIT(i * 2);
> > +
> > +			if (dpb[i].fields & V4L2_H264_BOTTOM_FIELD_REF)
> > +				dpb_valid |=3D REF_BIT(i * 2 + 1);
> > +
> > +			if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM) {
> > +				dpb_longterm |=3D REF_BIT(i * 2);
> > +				dpb_longterm |=3D REF_BIT(i * 2 + 1);
> > +			}
> > +		} else {
> > +			dpb_valid |=3D REF_BIT(i);
> > +
> > +			if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
> > +				dpb_longterm |=3D REF_BIT(i);
> > +		}
> > +	}
> > +	ctx->h264_dec.dpb_valid =3D dpb_valid;
> > +	ctx->h264_dec.dpb_longterm =3D dpb_longterm;
> > +
> > +	if ((dec_param->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) ||
> > +	    !(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)) {
> > +		tbl->poc[32] =3D ctx->h264_dec.cur_poc;
> > +		tbl->poc[33] =3D 0;
> > +	} else {
> > +		tbl->poc[32] =3D dec_param->top_field_order_cnt;
> > +		tbl->poc[33] =3D dec_param->bottom_field_order_cnt;
> > 	}
> > -	ctx->h264_dec.dpb_valid =3D dpb_valid << 16;
> > -	ctx->h264_dec.dpb_longterm =3D dpb_longterm << 16;
> > -
> > -	tbl->poc[32] =3D dec_param->top_field_order_cnt;
> > -	tbl->poc[33] =3D dec_param->bottom_field_order_cnt;
> >=20
> > 	assemble_scaling_list(ctx);
> > }
> > @@ -326,6 +357,8 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_ct=
x *ctx,
> > {
> > 	struct v4l2_h264_dpb_entry *dpb =3D ctx->h264_dec.dpb;
> > 	dma_addr_t dma_addr =3D 0;
> > +	s32 cur_poc =3D ctx->h264_dec.cur_poc;
> > +	u32 flags;
> >=20
> > 	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > 		dma_addr =3D hantro_get_ref(ctx, dpb[dpb_idx].reference_ts);
> > @@ -343,7 +376,12 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_c=
tx *ctx,
> > 		dma_addr =3D hantro_get_dec_buf_addr(ctx, buf);
> > 	}
> >=20
> > -	return dma_addr;
> > +	flags =3D dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_FIELD ? 0x2 :=
 0;
>=20
> > +	flags |=3D abs(dpb[dpb_idx].top_field_order_cnt - cur_poc) <
> > +		 abs(dpb[dpb_idx].bottom_field_order_cnt - cur_poc) ?
> > +		 0x1 : 0;
>=20
> You use the magic values `0x1` & `0x2` here, can you replace those with
> macros?
>=20
> It looks 0x2 indicates that we have a field and 0x1 indicates the
> distance of the current picture to the bottom field is greater than
> the distance of the current picture to the top field. (inidicating that
> the order is correct?)
>=20
> So maybe:
> ```
> #define HANTRO_H264_FIELD_DMA_ADDR              0x1
> #define HANTRO_H264_CORRECT_FIELD_ORDER         0x2
> ```

Will do, I need to check again in the ref code for the appropriate wording =
for
the meaning of these bits. I don't like much FIELD_DMA_ADDR, as its not an
address, or an offset to an address. Here the address must be aligned, whic=
h
results in these bits always being 0, so they reuse it to pass per-referenc=
e
information.

>=20
>=20
> > +
> > +	return dma_addr | flags;
> > }
> >=20
> > u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_id=
x)
> > @@ -355,6 +393,34 @@ u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx=
, unsigned int dpb_idx)
> > 	return dpb->frame_num;
> > }
> >=20
> > +static void deduplicate_reflist(struct v4l2_h264_reflist_builder *b,
> > +				struct v4l2_h264_reference *reflist)
>=20
> Can you add a comment describing why we need to deduplicate the
> reference list? And maybe also why we get duplications in the first
> place? Why must we limit the size to 16?
> This would increase the readability of the code a lot.

For readers that did understand the H.264 specification, that a field refli=
st
has 32 entry should be obvious. That hantro uses 16 entry only is an
undocumented trickery, I'll write something to the best of my knowledge, bu=
t
this has been reversed, so don't expect the highest rationale. I will thoug=
h
document here what I say in the commit, e.g. why this method might not be
robust, so someone can give it a try and make it more robust in the future.

>=20
> > +{
> > +	int write_idx =3D 0;
> > +	int i;
> > +
> > +	if (b->cur_pic_fields =3D=3D V4L2_H264_FRAME_REF) {
> > +		write_idx =3D b->num_valid;
> > +		goto done;
> > +	}
> > +
> > +	for (i =3D 0; i < b->num_valid; i++) {
> > +		if (!(b->cur_pic_fields =3D=3D reflist[i].fields)) {
> > +			reflist[write_idx++] =3D reflist[i];
> > +			continue;
> > +		}
> > +	}
> > +
> > +done:
> > +	/* Should not happen unless we have a bug in the reflist builder. */
> > +	if (WARN_ON(write_idx > 16))
> > +		write_idx =3D 16;
> > +
> > +	/* Clear the remaining, some streams fails otherwise */
>=20
> s/the remaining/the remaining entries/
> s/fails/fail/
>=20
> > +	for (; write_idx < 16; write_idx++)
> > +		reflist[write_idx].index =3D 15;
> > +}
> > +
> > int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
> > {
> > 	struct hantro_h264_dec_hw_ctx *h264_ctx =3D &ctx->h264_dec;
> > @@ -386,15 +452,28 @@ int hantro_h264_dec_prepare_run(struct hantro_ctx=
 *ctx)
> > 	/* Update the DPB with new refs. */
> > 	update_dpb(ctx);
> >=20
> > -	/* Prepare data in memory. */
> > -	prepare_table(ctx);
> > -
> > 	/* Build the P/B{0,1} ref lists. */
> > 	v4l2_h264_init_reflist_builder(&reflist_builder, ctrls->decode,
> > 				       ctrls->sps, ctx->h264_dec.dpb);
> > +	h264_ctx->cur_poc =3D reflist_builder.cur_pic_order_count;
> > +
> > +	/* Prepare data in memory. */
> > +	prepare_table(ctx);
> > +
> > 	v4l2_h264_build_p_ref_list(&reflist_builder, h264_ctx->reflists.p);
> > 	v4l2_h264_build_b_ref_lists(&reflist_builder, h264_ctx->reflists.b0,
> > 				    h264_ctx->reflists.b1);
> > +
> > +	/* Reduce ref lists to at most 16 entries, Hantro hardware will deduc=
e
> > +	 * the actual picture lists in field through the dpb_valid,
>=20
> s/in field/in a field/
>=20
> > +	 * dpb_longterm bitmap along with the current frame parity.
>=20
> s/bitmap/bitmaps/
>=20
> Greetings,
> Sebastian
>=20
> > +	 */
> > +	if (reflist_builder.cur_pic_fields !=3D V4L2_H264_FRAME_REF) {
> > +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.p);
> > +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b0);
> > +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b1);
> > +	}
> > +
> > 	return 0;
> > }
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging=
/media/hantro/hantro_hw.h
> > index 292aaaabaf24..fd869369fb97 100644
> > --- a/drivers/staging/media/hantro/hantro_hw.h
> > +++ b/drivers/staging/media/hantro/hantro_hw.h
> > @@ -91,6 +91,7 @@ struct hantro_h264_dec_hw_ctx {
> > 	struct hantro_h264_dec_ctrls ctrls;
> > 	u32 dpb_longterm;
> > 	u32 dpb_valid;
> > +	s32 cur_poc;
> > };
> >=20
> > /**
> > --=20
> > 2.34.1
> >=20

