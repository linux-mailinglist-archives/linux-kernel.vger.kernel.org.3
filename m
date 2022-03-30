Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6F4EC801
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbiC3PTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348092AbiC3PR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:17:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC2E1480F2;
        Wed, 30 Mar 2022 08:16:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id C50301F419C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648653370;
        bh=1LatH4mVGhsXTiehBV6dHmUReG5H7FkUjmvKks5cf9s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SxSg4EfBx6gKPVy7ZIt9DphOpUvAZoz6B8WOPzgtmHKGhqoB7TP25Yuw/ju3kplTq
         MIIBnaFed+K96kqbPkZoAywpohv3ZbEzldkz8UVubMOG+fuGL+v+oxRKX7ke9SCCsj
         pwDaxzgfaCA77a6wKRP/MMbparTSOygSwOFnp7nnhFCm7EZlWzGMf7SSEwGlMVJJXa
         9U63ojZVOxDkxyOp9FbpePJ3aPMem3n3GNjcoetmMAJSBR+o4LolX6KuclrglkcD8X
         NMp5VLFTPfsnfyJ2O+yJSKG9ILnl0DkUq2xgu9gbV9rPC+zIK3BRmlM27GlPHT/qxN
         0kW31Emid/daw==
Message-ID: <4740735d92c0dac3708aa922b3d73db7a61fbdda.camel@collabora.com>
Subject: Re: [PATCH v1 22/24] media: hantro: h264: Make dpb entry management
 more robust
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 11:15:58 -0400
In-Reply-To: <20220330075913.wfl3prsyw5fvsv4t@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-23-nicolas.dufresne@collabora.com>
         <20220330075913.wfl3prsyw5fvsv4t@basti-XPS-13-9310>
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

Le mercredi 30 mars 2022 =C3=A0 09:59 +0200, Sebastian Fricke a =C3=A9crit=
=C2=A0:
> Hey Nicolas,
>=20
> On 28.03.2022 15:59, Nicolas Dufresne wrote:
> > From: Jonas Karlman <jonas@kwiboo.se>
> >=20
> > The driver maintains stable slot location for reference pictures. This
>=20
> s/slot location/slot locations/
>=20
> > change makes the code more robust by using the reference_ts as key and
> > by marking all entries invalid right from the start.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> > drivers/staging/media/hantro/hantro_h264.c | 10 ++++------
> > 1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/stagi=
ng/media/hantro/hantro_h264.c
> > index 228629fb3cdf..7377fc26f780 100644
> > --- a/drivers/staging/media/hantro/hantro_h264.c
> > +++ b/drivers/staging/media/hantro/hantro_h264.c
> > @@ -258,8 +258,7 @@ static void prepare_table(struct hantro_ctx *ctx)
> > static bool dpb_entry_match(const struct v4l2_h264_dpb_entry *a,
> > 			    const struct v4l2_h264_dpb_entry *b)
> > {
> > -	return a->top_field_order_cnt =3D=3D b->top_field_order_cnt &&
> > -	       a->bottom_field_order_cnt =3D=3D b->bottom_field_order_cnt;
> > +	return a->reference_ts =3D=3D b->reference_ts;
> > }
> >=20
> > static void update_dpb(struct hantro_ctx *ctx)
> > @@ -273,13 +272,13 @@ static void update_dpb(struct hantro_ctx *ctx)
> >=20
> > 	/* Disable all entries by default. */
> > 	for (i =3D 0; i < ARRAY_SIZE(ctx->h264_dec.dpb); i++)
> > -		ctx->h264_dec.dpb[i].flags &=3D ~V4L2_H264_DPB_ENTRY_FLAG_ACTIVE;
> > +		ctx->h264_dec.dpb[i].flags =3D 0;
>=20
> Ehm ... we just remove all flags? Can't this have any unwanted side
> effects like removing a flag that we actually wanted to keep?
> (Like long term or the field flags?)

This is a local copy of the dpb, the DPB is fully passed for every decode. =
So
these flags will be fully restored lower when we copy the found entry. In f=
act,
holding a state here would not represent well the userland intention and ca=
n
have negative side effect on the decoding. Flags are not immutable between
decode and can change. This simplify the code, and make things less error p=
rone.
This part of the code is already a bit complex, no need for an extra layer.

> If we just want to set the DPB entry inactive, then removing the ACTIVE
> flag seems like the correct approach to me.
> If we want to get rid of the VALID flag as well, then we could just do:
> 		ctx->h264_dec.dpb[i].flags &=3D
>        ~(V4L2_H264_DPB_ENTRY_FLAG_ACTIVE | V4L2_H264_DPB_ENTRY_FLAG_VALID=
);
>=20
> In case we really want to reset all flags, I'd say adjust the comment
> above it:
> ```
> - 	/* Disable all entries by default. */
> + 	/* Reset the flags for all entries by default. */
> ```

This reads the same to me, but I can do that yes. understand that VALID mea=
ns
the reference exist and the TS should point to some existing past reference
(unless there was some decode error, which the userland may not be aware ye=
t as
this is asynchronous). While ACTIVE means that it is used as a reference. F=
FMPEG
is known not to filter inactive references. ACTIVE is just a flag without b=
unch
of other flags that can change for every decode. So none of this make sense
between 2 decodes.

>=20
> Greetings,
> Sebastian
>=20
> >=20
> > 	/* Try to match new DPB entries with existing ones by their POCs. */
> > 	for (i =3D 0; i < ARRAY_SIZE(dec_param->dpb); i++) {
> > 		const struct v4l2_h264_dpb_entry *ndpb =3D &dec_param->dpb[i];
> >=20
> > -		if (!(ndpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> > +		if (!(ndpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> > 			continue;
> >=20
> > 		/*
> > @@ -290,8 +289,7 @@ static void update_dpb(struct hantro_ctx *ctx)
> > 			struct v4l2_h264_dpb_entry *cdpb;
> >=20
> > 			cdpb =3D &ctx->h264_dec.dpb[j];
> > -			if (cdpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE ||
> > -			    !dpb_entry_match(cdpb, ndpb))
> > +			if (!dpb_entry_match(cdpb, ndpb))
> > 				continue;
> >=20
> > 			*cdpb =3D *ndpb;
> > --=20
> > 2.34.1
> >=20

