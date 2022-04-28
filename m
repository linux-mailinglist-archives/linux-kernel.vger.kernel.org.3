Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19551349B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346446AbiD1NNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbiD1NNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:13:46 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730251AF32
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:10:23 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id k12so3152437qvc.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=2TRrUwuxYePyCI3WXghga60BzOAcIaDjgJpPfXkF+MY=;
        b=a2UsnP0tEGjVv5vDoh+2KICnjlE1cHILNpfrjSpLO+mcCP2kVAOGe54xwb6OY8jnqd
         mFNuClZqmHN4USYrhRMvY+ES4R99OaGevo9Lg5FHkykLNuO9C5P8cxJdJXe39y+FEmfQ
         OGV89R4UQqT4p9bRwgdS2w4R5b7zNkjai04rEhLOZ3Cnj+TmZ9+RVhrKXSZxeVp2joBH
         e+RAZ7XyGNHH1eTIvR1vjDv2Az7Hf+zPU+r6UC2X0E7rkZ0hQux7xkaEg68N13mscXJ/
         XK/Z4Z61SDw7M5HInJUmnIzOtQSc8fekjJaXCsGjHgW2Q/HqxbBYTbiQZc1Jxxz942Tt
         ubWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=2TRrUwuxYePyCI3WXghga60BzOAcIaDjgJpPfXkF+MY=;
        b=aNKwumVcSZFX6l0tkl7KLBmCRbUtRPkyC1v34ouuWCYWsDyLq8bVaMNsauovyvkRQc
         CWlDfwavD920EdM73kfRj2V9Jf0HU8MHb5YzAH751KuMHVfiYXo0fsh7tUxUcjgv3DDg
         a8DlcLCR/1b6V4eBlW7FtgMYHDu/oqiYKdiZ/gWybxNDaxdjsIPneBqE3qp84iNIQwqw
         bDYKAv/snfKg0TdFu68WMIj4AnDJ0GB2xLoZV5TSVfeS4pMeJd0LLH/YLmOlcuFg8hz6
         BCwf+ni0sbT0AgfC7yG+rEBKvQDQOXvDjPFPNzdVKbJkSQgGYCrghFWB/rM3nafahoT8
         xV6Q==
X-Gm-Message-State: AOAM531RRdo0wHezuN9hY5cCH385j7vgCToLjl+qLMy6evxC3bvkUmbU
        lyXyRw2c5AxbOJSNxhofQpsD3g==
X-Google-Smtp-Source: ABdhPJzyj6H4QGA1ydzFr7H+emnJ0ts6G9Rv/pqz78Z5Xf0TW0wtyqn2iGK4oxGCAkwIMXG6u+/HJg==
X-Received: by 2002:a05:6214:1d09:b0:456:47c5:1db with SMTP id e9-20020a0562141d0900b0045647c501dbmr9214691qvd.73.1651151422600;
        Thu, 28 Apr 2022 06:10:22 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm13158696qtw.64.2022.04.28.06.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:10:22 -0700 (PDT)
Message-ID: <cf05c8031345341caf641d37aeeb58bd506b624a.camel@ndufresne.ca>
Subject: Re: [PATCH v4 23/24] media: hantro: Add H.264 field decoding support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Apr 2022 09:10:20 -0400
In-Reply-To: <5daa1dcd-a3a7-f508-e731-3a013ebc82ea@xs4all.nl>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
         <20220426125751.108293-24-nicolas.dufresne@collabora.com>
         <5daa1dcd-a3a7-f508-e731-3a013ebc82ea@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 28 avril 2022 =C3=A0 10:50 +0200, Hans Verkuil a =C3=A9crit=C2=A0:
> On 26/04/2022 14:57, Nicolas Dufresne wrote:
> > This adds the required code to support field decoding. While most of
> > the code is derived from Rockchip and VSI reference code, the
> > reduction of the reference list to 16 entries was found by
> > trial and errors. The list consists of all the references with the
> > opposite field parity.
> >=20
> > The strategy is to deduplicate the reference picture that points
> > to the same storage (same index). The choice of opposite parity has
> > been made to keep the other field of the current field pair in the
> > list. This method may not be robust if a field was lost.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >  drivers/staging/media/hantro/hantro_h264.c | 122 ++++++++++++++++++---
> >  drivers/staging/media/hantro/hantro_hw.h   |   1 +
> >  2 files changed, 109 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/stagi=
ng/media/hantro/hantro_h264.c
> > index 7377fc26f780..7502dddb324c 100644
> > --- a/drivers/staging/media/hantro/hantro_h264.c
> > +++ b/drivers/staging/media/hantro/hantro_h264.c
> > @@ -22,6 +22,12 @@
> >  #define POC_BUFFER_SIZE			34
> >  #define SCALING_LIST_SIZE		(6 * 16 + 2 * 64)
> > =20
> > +/*
> > + * For valid and long term reference marking, index are reversed, so b=
it 31
> > + * indicates the status of the picture 0.
> > + */
> > +#define REF_BIT(i)			BIT(32 - 1 - (i))
> > +
> >  /* Data structure describing auxiliary buffer format. */
> >  struct hantro_h264_dec_priv_tbl {
> >  	u32 cabac_table[CABAC_INIT_BUFFER_SIZE];
> > @@ -227,6 +233,7 @@ static void prepare_table(struct hantro_ctx *ctx)
> >  {
> >  	const struct hantro_h264_dec_ctrls *ctrls =3D &ctx->h264_dec.ctrls;
> >  	const struct v4l2_ctrl_h264_decode_params *dec_param =3D ctrls->decod=
e;
> > +	const struct v4l2_ctrl_h264_sps *sps =3D ctrls->sps;
> >  	struct hantro_h264_dec_priv_tbl *tbl =3D ctx->h264_dec.priv.cpu;
> >  	const struct v4l2_h264_dpb_entry *dpb =3D ctx->h264_dec.dpb;
> >  	u32 dpb_longterm =3D 0;
> > @@ -237,20 +244,45 @@ static void prepare_table(struct hantro_ctx *ctx)
> >  		tbl->poc[i * 2] =3D dpb[i].top_field_order_cnt;
> >  		tbl->poc[i * 2 + 1] =3D dpb[i].bottom_field_order_cnt;
> > =20
> > +		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> > +			continue;
> > +
> >  		/*
> >  		 * Set up bit maps of valid and long term DPBs.
> > -		 * NOTE: The bits are reversed, i.e. MSb is DPB 0.
> > +		 * NOTE: The bits are reversed, i.e. MSb is DPB 0. For frame
> > +		 * decoding, bit 31 to 15 are used, while for field decoding,
> > +		 * all bits are used, with bit 31 being a top field, 30 a bottom
> > +		 * field and so on.
> >  		 */
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
> >  	}
> > -	ctx->h264_dec.dpb_valid =3D dpb_valid << 16;
> > -	ctx->h264_dec.dpb_longterm =3D dpb_longterm << 16;
> > -
> > -	tbl->poc[32] =3D dec_param->top_field_order_cnt;
> > -	tbl->poc[33] =3D dec_param->bottom_field_order_cnt;
> > =20
> >  	assemble_scaling_list(ctx);
> >  }
> > @@ -326,6 +358,8 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_ct=
x *ctx,
> >  {
> >  	struct v4l2_h264_dpb_entry *dpb =3D ctx->h264_dec.dpb;
> >  	dma_addr_t dma_addr =3D 0;
> > +	s32 cur_poc =3D ctx->h264_dec.cur_poc;
> > +	u32 flags;
> > =20
> >  	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> >  		dma_addr =3D hantro_get_ref(ctx, dpb[dpb_idx].reference_ts);
> > @@ -343,7 +377,12 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_c=
tx *ctx,
> >  		dma_addr =3D hantro_get_dec_buf_addr(ctx, buf);
> >  	}
> > =20
> > -	return dma_addr;
> > +	flags =3D dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_FIELD ? 0x2 :=
 0;
> > +	flags |=3D abs(dpb[dpb_idx].top_field_order_cnt - cur_poc) <
> > +		 abs(dpb[dpb_idx].bottom_field_order_cnt - cur_poc) ?
> > +		 0x1 : 0;
> > +
> > +	return dma_addr | flags;
> >  }
> > =20
> >  u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_i=
dx)
> > @@ -355,6 +394,47 @@ u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx=
, unsigned int dpb_idx)
> >  	return dpb->frame_num;
> >  }
> > =20
> > +/*
> > + * Removes all references with he same parity as current picture from =
the
> > + * reference list. The remaining list will have references with the op=
posite
> > + * parity. This is effectively a deduplication of references since eac=
h buffer
> > + * stores two fields. For this eason, each buffer are found twice in t=
he
> > + * reference list.
> > + *
> > + * This technique has been chosen through trial and error. This simple=
 approach
> > + * resulted in the highest conformance score. Note that this method ma=
y suffer
> > + * worse quality in the case an opposite reference frame has been lost=
. If this
> > + * becomes a problem in the future, it should be possible to add a pre=
processing
> > + * to identify un-paired fields and avoid removing them.
> > + */
> > +static void deduplicate_reflist(struct v4l2_h264_reflist_builder *b,
> > +				struct v4l2_h264_reference *reflist)
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
> > +	for (; write_idx < 16; write_idx++)
> > +		reflist[write_idx].index =3D 15;
> > +}
> > +
> >  int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
> >  {
> >  	struct hantro_h264_dec_hw_ctx *h264_ctx =3D &ctx->h264_dec;
> > @@ -386,15 +466,29 @@ int hantro_h264_dec_prepare_run(struct hantro_ctx=
 *ctx)
> >  	/* Update the DPB with new refs. */
> >  	update_dpb(ctx);
> > =20
> > -	/* Prepare data in memory. */
> > -	prepare_table(ctx);
> > -
> >  	/* Build the P/B{0,1} ref lists. */
> >  	v4l2_h264_init_reflist_builder(&reflist_builder, ctrls->decode,
> >  				       ctrls->sps, ctx->h264_dec.dpb);
> > +	h264_ctx->cur_poc =3D reflist_builder.cur_pic_order_count;
> > +
> > +	/* Prepare data in memory. */
> > +	prepare_table(ctx);
> > +
> >  	v4l2_h264_build_p_ref_list(&reflist_builder, h264_ctx->reflists.p);
> >  	v4l2_h264_build_b_ref_lists(&reflist_builder, h264_ctx->reflists.b0,
> >  				    h264_ctx->reflists.b1);
> > +
> > +	/*
> > +	 * Reduce ref lists to at most 16 entries, Hantro hardware will deduc=
e
> > +	 * the actual picture lists in field through the dpb_valid,
> > +	 * dpb_longterm bitmap along with the current frame parity.
> > +	 */
> > +	if (reflist_builder.cur_pic_fields !=3D V4L2_H264_FRAME_REF) {
> > +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.p);
> > +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b0);
> > +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b1);
> > +	}
> > +
> >  	return 0;
> >  }
> > =20
> > diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging=
/media/hantro/hantro_hw.h
> > index 292aaaabaf24..fd869369fb97 100644
> > --- a/drivers/staging/media/hantro/hantro_hw.h
> > +++ b/drivers/staging/media/hantro/hantro_hw.h
> > @@ -91,6 +91,7 @@ struct hantro_h264_dec_hw_ctx {
> >  	struct hantro_h264_dec_ctrls ctrls;
> >  	u32 dpb_longterm;
> >  	u32 dpb_valid;
> > +	s32 cur_poc;
>=20
> This field isn't documented in kerneldoc.
>=20
> I've added this:
>=20
> + * @cur_poc:   Current picture order count
>=20
> Is that a correct description? If not, let me know what it should be.
>=20
> I'll update the patch manually, no need to repost.

Yes, this is entirely correct, thanks for catching this.

>=20
> Regards,
>=20
> 	Hans
>=20
> >  };
> > =20
> >  /**
>=20

