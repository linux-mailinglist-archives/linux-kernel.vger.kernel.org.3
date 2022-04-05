Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727754F4ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587657AbiDFAJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455135AbiDEP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA3108741;
        Tue,  5 Apr 2022 08:11:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 14BC11F450DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649171468;
        bh=D+PPyG+d8bSZBQUHvuUVVhH3F9DHPinWPY0RxBOGLSk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fXHyX2PGLz0ROYpReWRUYVsjVnAwYs4vGBfotmSL/S9PIaEyt6ZIvhSApwIsBmKNq
         u5HY49fCocaxlJF+2UNGHXJdHdioG6Tbxdnd7Z/E0SAMQODKgYIzrLsMRI+gghk96s
         5OLzd5Yt6pPZzXW+U8m1u+3hbk6iUTt9PWDaKT195nwD9pJE1GAafVEzuW6OuiCrY6
         d+GKTUpMH3nsIEeGyC2tKIGM8RRuy5Dfm1JgzFP+S7vM7Kjj2slaYaFvlu4NZlXHmd
         Fjlf7E0rFIbcgVx+gQQji44T+NHsmwh6QRGBJXBGuqzo0Q7MQvYKvdexH6nzhfa7wL
         N6TFMwTeJ9ArQ==
Message-ID: <92001085580ac1005596b34f79f1dadcc4b3f3c9.camel@collabora.com>
Subject: Re: [PATCH v2 13/23] media: rkvdec: h264: Fix dpb_valid
 implementation
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 05 Apr 2022 11:10:57 -0400
In-Reply-To: <YkgwmwTMa83RysKB@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
         <20220331193726.289559-14-nicolas.dufresne@collabora.com>
         <YkgwmwTMa83RysKB@eze-laptop>
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

Le samedi 02 avril 2022 =C3=A0 08:16 -0300, Ezequiel Garcia a =C3=A9crit=C2=
=A0:
> On Thu, Mar 31, 2022 at 03:37:15PM -0400, Nicolas Dufresne wrote:
> > The ref builder only provided references that are marked as valid in th=
e
> > dpb. Thus the current implementation of dpb_valid would always set the
> > flag to 1. This is not representing missing frames (this is called
> > 'non-existing' pictures in the spec). In some context, these non-existi=
ng
> > pictures still need to occupy a slot in the reference list according to
> > the spec.
> >=20
>=20
> Good catch! OOC, did you find this because it was failing a test vector?

The effect is complex, so I could not correlate to specific tests. Also, wh=
at I
wanted to fix isn't covered by the ITU conformance, its mostly resiliance
requirement. But this should remove some of the IOMMU fault on broken strea=
ms
and make it less likely to use references that don't exists or aren't set w=
hat
we expect. After this change, the driver was getting more stable, and resul=
ts
was also more reproducible (specially in parallel decode case, which I use =
to
speed up testing).

>=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>=20
> Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks for the review.

>=20
> Thanks,
> Ezequiel
>=20
> > ---
> >  drivers/staging/media/rkvdec/rkvdec-h264.c | 33 ++++++++++++++++------
> >  1 file changed, 24 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/stagi=
ng/media/rkvdec/rkvdec-h264.c
> > index dff89732ddd0..bcde37d72244 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > @@ -112,6 +112,7 @@ struct rkvdec_h264_run {
> >  	const struct v4l2_ctrl_h264_sps *sps;
> >  	const struct v4l2_ctrl_h264_pps *pps;
> >  	const struct v4l2_ctrl_h264_scaling_matrix *scaling_matrix;
> > +	int ref_buf_idx[V4L2_H264_NUM_DPB_ENTRIES];
> >  };
> > =20
> >  struct rkvdec_h264_ctx {
> > @@ -725,6 +726,26 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx=
,
> >  	}
> >  }
> > =20
> > +static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
> > +			       struct rkvdec_h264_run *run)
> > +{
> > +	const struct v4l2_ctrl_h264_decode_params *dec_params =3D run->decode=
_params;
> > +	u32 i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(dec_params->dpb); i++) {
> > +		struct v4l2_m2m_ctx *m2m_ctx =3D ctx->fh.m2m_ctx;
> > +		const struct v4l2_h264_dpb_entry *dpb =3D run->decode_params->dpb;
> > +		struct vb2_queue *cap_q =3D &m2m_ctx->cap_q_ctx.q;
> > +		int buf_idx =3D -1;
> > +
> > +		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > +			buf_idx =3D vb2_find_timestamp(cap_q,
> > +						     dpb[i].reference_ts, 0);
> > +
> > +		run->ref_buf_idx[i] =3D buf_idx;
> > +	}
> > +}
> > +
> >  static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> >  			    struct rkvdec_h264_run *run)
> >  {
> > @@ -762,7 +783,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> > =20
> >  	for (j =3D 0; j < RKVDEC_NUM_REFLIST; j++) {
> >  		for (i =3D 0; i < h264_ctx->reflists.num_valid; i++) {
> > -			u8 dpb_valid =3D 0;
> > +			bool dpb_valid =3D run->ref_buf_idx[i] >=3D 0;
> >  			u8 idx =3D 0;
> > =20
> >  			switch (j) {
> > @@ -779,8 +800,6 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> > =20
> >  			if (idx >=3D ARRAY_SIZE(dec_params->dpb))
> >  				continue;
> > -			dpb_valid =3D !!(dpb[idx].flags &
> > -				       V4L2_H264_DPB_ENTRY_FLAG_ACTIVE);
> > =20
> >  			set_ps_field(hw_rps, DPB_INFO(i, j),
> >  				     idx | dpb_valid << 4);
> > @@ -859,13 +878,8 @@ get_ref_buf(struct rkvdec_ctx *ctx, struct rkvdec_=
h264_run *run,
> >  	    unsigned int dpb_idx)
> >  {
> >  	struct v4l2_m2m_ctx *m2m_ctx =3D ctx->fh.m2m_ctx;
> > -	const struct v4l2_h264_dpb_entry *dpb =3D run->decode_params->dpb;
> >  	struct vb2_queue *cap_q =3D &m2m_ctx->cap_q_ctx.q;
> > -	int buf_idx =3D -1;
> > -
> > -	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > -		buf_idx =3D vb2_find_timestamp(cap_q,
> > -					     dpb[dpb_idx].reference_ts, 0);
> > +	int buf_idx =3D run->ref_buf_idx[dpb_idx];
> > =20
> >  	/*
> >  	 * If a DPB entry is unused or invalid, address of current destinatio=
n
> > @@ -1102,6 +1116,7 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx=
)
> > =20
> >  	assemble_hw_scaling_list(ctx, &run);
> >  	assemble_hw_pps(ctx, &run);
> > +	lookup_ref_buf_idx(ctx, &run);
> >  	assemble_hw_rps(ctx, &run);
> >  	config_registers(ctx, &run);
> > =20
> > --=20
> > 2.34.1
> >=20

