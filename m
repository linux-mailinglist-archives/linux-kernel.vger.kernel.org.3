Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E64EB4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiC2U4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiC2U4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:56:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0478B53FA;
        Tue, 29 Mar 2022 13:55:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 5A8251F41D1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648587306;
        bh=RBMQRZSrdkCLhPicdgFkZvgqP1dxXq/zI3/xkKcqf40=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HWMan1B3lqPXMR5oo746sTUY3miO5ui9NGC/zh7vf67Jx+ab/XUzI/+rz61ZLO5KN
         +yL+DMFY7mCb45ZMFQngbGzuh+INeDIEOWb4DSf4eBLXNEOP8jjLOyIkCxm6cKmatC
         YJ0AT+1SAFxcZkWjq4SA3rbjtkexSDS3RDfmvTII+UnAPTFF5Ww5H+hBhFiPQtLj7h
         oYy1aXTl61fV+yDwn73qsfLDRcJzjqQn9lbFyuqF9IBWWd9LQB30/g5vffrC7yc8K2
         RaO4a3Yvr82CVgx26blawQQ1eOInP9bK899P7HG7GGxDqqV9vCFuFLqdV2Eoy6i57B
         3U3yhrxcTBh5Q==
Message-ID: <f7e5b577bc48ba16befbed47ac96c363ce861f48.camel@collabora.com>
Subject: Re: [PATCH v1 19/24] media: rkvdec-h264: Add field decoding support
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Tue, 29 Mar 2022 16:54:55 -0400
In-Reply-To: <20220329081321.GV3293@kadam>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-20-nicolas.dufresne@collabora.com>
         <20220329081321.GV3293@kadam>
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

Le mardi 29 mars 2022 =C3=A0 11:13 +0300, Dan Carpenter a =C3=A9crit=C2=A0:
> On Mon, Mar 28, 2022 at 03:59:31PM -0400, Nicolas Dufresne wrote:
> > @@ -738,23 +735,26 @@ static void lookup_ref_buf_idx(struct rkvdec_ctx =
*ctx,
> >  		struct vb2_queue *cap_q =3D &m2m_ctx->cap_q_ctx.q;
> >  		int buf_idx =3D -1;
> > =20
> > -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > +		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
> >  			buf_idx =3D vb2_find_timestamp(cap_q,
> >  						     dpb[i].reference_ts, 0);
> > +			if (buf_idx < 0)
> > +				pr_debug("No buffer for reference_ts %llu",
> > +					 dpb[i].reference_ts);
>=20
> pr_debug() is too quiet.  Make it pr_err().  Set buf_idx to zero instead
> leaving it as an error code.

Thanks for the suggestion, I'm just a bit uncomfortable using pr_err() for
something that is not a driver error, but userland error. Perhaps you can
educate me on the policy in this regard, but malicous userland being able t=
o
flood the logs very easily is my main concern here.

About the negative idx, it is being used set dpb_valid later on. H.264 erro=
r
resilience requires that these frames should be marked as "unexisting" but =
still
occupy space in the DPB, this is more or less what I'm trying to implement =
here.
Setting it to 0 would basically mean to refer to DPB index 0, which is
relatively random pick. I believe your suggestion is not taking into
consideration what the code is doing, but it would fall in some poor-man
concealment which I would rather leave to the userland.

>=20
> > +		}
> > =20
> >  		run->ref_buf_idx[i] =3D buf_idx;
> >  	}
> >  }
> > =20
> >  static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> > +			    struct v4l2_h264_reflist_builder *builder,
> >  			    struct rkvdec_h264_run *run)
> >  {
> >  	const struct v4l2_ctrl_h264_decode_params *dec_params =3D run->decode=
_params;
> >  	const struct v4l2_h264_dpb_entry *dpb =3D dec_params->dpb;
> >  	struct rkvdec_h264_ctx *h264_ctx =3D ctx->priv;
> > -	const struct v4l2_ctrl_h264_sps *sps =3D run->sps;
> >  	struct rkvdec_h264_priv_tbl *priv_tbl =3D h264_ctx->priv_tbl.cpu;
> > -	u32 max_frame_num =3D 1 << (sps->log2_max_frame_num_minus4 + 4);
> > =20
> >  	u32 *hw_rps =3D priv_tbl->rps;
> >  	u32 i, j;
> > @@ -772,37 +772,36 @@ static void assemble_hw_rps(struct rkvdec_ctx *ct=
x,
> >  		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> >  			continue;
> > =20
> > -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
> > -		    dpb[i].frame_num <=3D dec_params->frame_num) {
> > -			p[i] =3D dpb[i].frame_num;
> > -			continue;
> > -		}
> > -
> > -		p[i] =3D dpb[i].frame_num - max_frame_num;
> > +		p[i] =3D builder->refs[i].frame_num;
> >  	}
> > =20
> >  	for (j =3D 0; j < RKVDEC_NUM_REFLIST; j++) {
> > -		for (i =3D 0; i < h264_ctx->reflists.num_valid; i++) {
> > -			u8 dpb_valid =3D run->ref_buf_idx[i] >=3D 0;
> > -			u8 idx =3D 0;
> > +		for (i =3D 0; i < builder->num_valid; i++) {
> > +			struct v4l2_h264_reference *ref;
> > +			u8 dpb_valid;
> > +			u8 bottom;
>=20
> These would be better as type bool.

I never used a bool for bit operations before, but I guess that can work, t=
hanks
for the suggestion. As this deviates from the original code, I suppose I sh=
ould
make this a separate patch ?

>=20
> regards,
> dan carpenter
>=20
> > =20
> >  			switch (j) {
> >  			case 0:
> > -				idx =3D h264_ctx->reflists.p[i].index;
> > +				ref =3D &h264_ctx->reflists.p[i];
> >  				break;
> >  			case 1:
> > -				idx =3D h264_ctx->reflists.b0[i].index;
> > +				ref =3D &h264_ctx->reflists.b0[i];
> >  				break;
> >  			case 2:
> > -				idx =3D h264_ctx->reflists.b1[i].index;
> > +				ref =3D &h264_ctx->reflists.b1[i];
> >  				break;
> >  			}
> > =20
> > -			if (idx >=3D ARRAY_SIZE(dec_params->dpb))
> > +			if (WARN_ON(ref->index >=3D ARRAY_SIZE(dec_params->dpb)))
> >  				continue;
> > =20
> > +			dpb_valid =3D run->ref_buf_idx[ref->index] >=3D 0;
> > +			bottom =3D ref->fields =3D=3D V4L2_H264_BOTTOM_FIELD_REF;
> > +
> >  			set_ps_field(hw_rps, DPB_INFO(i, j),
> > -				     idx | dpb_valid << 4);
> > +				     ref->index | dpb_valid << 4);
> > +			set_ps_field(hw_rps, BOTTOM_FLAG(i, j), bottom);
> >  		}
> >  	}
> >  }
>=20

