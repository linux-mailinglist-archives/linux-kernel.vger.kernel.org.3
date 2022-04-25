Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3601550E8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiDYTD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiDYTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:03:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4AB1C2;
        Mon, 25 Apr 2022 12:00:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 1E5471F43028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650913214;
        bh=bg3UhcnZlvv3RfrkW9O8KrBoXkIZozgniP3zQSLLpV8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d5YlbhJaQYcd9qYuNgr2Vyn2VsGsbRYC+8jKl1De+8+TUvzBWleYXbUZ1AG9OitPd
         pvSYmNX2z65O2svMCx6vRTO2M3XGqYWk9d12Dm2rR1vuzt9nWfxnUeJ52SMO5WAxcq
         DBLxwG/cdHjqnCEdgXPehtCkD82vJFeJJBnOZ9ObNg7IKsw29i+lFh5pcLiK72Uowj
         mwUbQMLl3JxPvmfppZHKAQoXmOt6vmduM9KXDgV0TOte/RjBDdzt4+5inUiymAi3CZ
         IXCCeNZsVUEwvI6kuZjy/9sEaHiZ1uqj4K90d6rwWCs8OoRCFzRPCO1MA9JwgrSwHG
         aSK8R5YCKraVg==
Message-ID: <bd0b59212d16af5b54c1ad5d89de5ba7b8794fac.camel@collabora.com>
Subject: Re: [PATCH v3 17/24] media: rkvdec: h264: Fix reference frame_num
 wrap for second field
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Date:   Mon, 25 Apr 2022 15:00:02 -0400
In-Reply-To: <0780cc3ddd985f580a5513e5222cdde852e6aaab.camel@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
         <20220405204426.259074-18-nicolas.dufresne@collabora.com>
         <8f6c8a5c-200d-fbbd-0b8a-966d94467aad@xs4all.nl>
         <0780cc3ddd985f580a5513e5222cdde852e6aaab.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 25 avril 2022 =C3=A0 14:55 -0400, Nicolas Dufresne a =C3=A9crit=C2=
=A0:
> Le vendredi 22 avril 2022 =C3=A0 09:43 +0200, Hans Verkuil a =C3=A9crit=
=C2=A0:
> > On 05/04/2022 22:44, Nicolas Dufresne wrote:
> > > From: Jonas Karlman <jonas@kwiboo.se>
> > >=20
> > > When decoding the second field in a complementary field pair the seco=
nd
> > > field is sharing the same frame_num with the first field.
> > >=20
> > > Currently the frame_num for the first field is wrapped when it matche=
s the
> > > field being decoded, this cause issues to decode the second field in =
a
> >=20
> > cause issues to decode -> caused issues decoding
> >=20
> > > complementary field pair.
> > >=20
> > > Fix this by using inclusive comparison, less than or equal.
> >=20
> > I would change this last sentence to:
> >=20
> > 	Fix this by using inclusive comparison: 'less than or equal'.
> >=20
> > It makes it a bit easier to parse.
> >=20
> > >=20
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > > ---
> > >  drivers/staging/media/rkvdec/rkvdec-h264.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/sta=
ging/media/rkvdec/rkvdec-h264.c
> > > index f081b476340f..60eaf06b6e25 100644
> > > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > > @@ -781,7 +781,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ct=
x,
> > >  			continue;
> > > =20
> > >  		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
> > > -		    dpb[i].frame_num < dec_params->frame_num) {
> > > +		    dpb[i].frame_num <=3D dec_params->frame_num) {
> >=20
> > I wonder if a comment should be added here, explaining the reason for '=
<=3D'.
> >=20
> > It doesn't seem obvious to me. Up to you, though.
>=20
> I guess I could, the algo for wrapping in the spec is (formula 8-27):
>=20
>     if( FrameNum > frame_num )
>         FrameNumWrap =3D FrameNum =E2=88=92 MaxFrameNum
>     else
>         FrameNumWrap =3D FrameNum
>=20
> Our implementation has the branch condition flip over, and the flipped ve=
rsion of that is:
>=20
>     if( FrameNum <=3D frame_num )
>         FrameNumWrap =3D FrameNum
>     else
>         FrameNumWrap =3D FrameNum =E2=88=92 MaxFrameNum
>=20
> There is no deeper rationale since we simply follow the recipe described =
in the
> spec. This is done so that we can share that condition with that long ter=
m
> reference handling.

Now I come to realize that in patch "[v3,19/24] media: rkvdec-h264: Add fie=
ld
decoding support" all this code is removed. This is because the wrapping is
already done by the ref-builder, so while enabling field decoding, I now us=
e the
wrapped value from the ref builder. I'm mostly keeping the patch so that th=
is
fix is well documented. I will leave it like this then.

>=20
> >=20
> > >  			p[i] =3D dpb[i].frame_num;
> > >  			continue;
> > >  		}
> >=20
> > Regards,
> >=20
> > 	Hans
>=20

