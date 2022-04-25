Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692C050E8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbiDYS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiDYS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:58:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5722641E;
        Mon, 25 Apr 2022 11:55:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 328231F42FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650912919;
        bh=UeDlmqQj8a7ajqfg6WiA/qN0a19sf47WMImO06/MAHQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bfRYX0DKAOr83SgdDu+dNiIGZNolkLDWunS2dPJPcoNGKDvOBzhMm9e5czLmV8KRW
         EcAmqFXa16zRv57Ue0x/rPB/sPH1BJtCdNNf3oEeUcK/0jTfpMsrXMjquR+pVECaM7
         H55o0X7+E8wwXqq3KNC/C08+cUSBPgNJbh4baJ/GdFh3bCdT53eQuYaYIY3J10EyTH
         QdBiDm/xxABXYxKgd6wphCB1MvrEoGORZiGkgUGzmvBhvXwi56pPlx7CFisBa1lITs
         wo6l1tmHjA/LSK/di44KHjdQLPIMsaoO2KrmTh8qS/KuKP8OfXLJLue1RKa3obJm3+
         iBJqo/Lt647qw==
Message-ID: <0780cc3ddd985f580a5513e5222cdde852e6aaab.camel@collabora.com>
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
Date:   Mon, 25 Apr 2022 14:55:04 -0400
In-Reply-To: <8f6c8a5c-200d-fbbd-0b8a-966d94467aad@xs4all.nl>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
         <20220405204426.259074-18-nicolas.dufresne@collabora.com>
         <8f6c8a5c-200d-fbbd-0b8a-966d94467aad@xs4all.nl>
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

Le vendredi 22 avril 2022 =C3=A0 09:43 +0200, Hans Verkuil a =C3=A9crit=C2=
=A0:
> On 05/04/2022 22:44, Nicolas Dufresne wrote:
> > From: Jonas Karlman <jonas@kwiboo.se>
> >=20
> > When decoding the second field in a complementary field pair the second
> > field is sharing the same frame_num with the first field.
> >=20
> > Currently the frame_num for the first field is wrapped when it matches =
the
> > field being decoded, this cause issues to decode the second field in a
>=20
> cause issues to decode -> caused issues decoding
>=20
> > complementary field pair.
> >=20
> > Fix this by using inclusive comparison, less than or equal.
>=20
> I would change this last sentence to:
>=20
> 	Fix this by using inclusive comparison: 'less than or equal'.
>=20
> It makes it a bit easier to parse.
>=20
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
> > Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > ---
> >  drivers/staging/media/rkvdec/rkvdec-h264.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/stagi=
ng/media/rkvdec/rkvdec-h264.c
> > index f081b476340f..60eaf06b6e25 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > @@ -781,7 +781,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> >  			continue;
> > =20
> >  		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
> > -		    dpb[i].frame_num < dec_params->frame_num) {
> > +		    dpb[i].frame_num <=3D dec_params->frame_num) {
>=20
> I wonder if a comment should be added here, explaining the reason for '<=
=3D'.
>=20
> It doesn't seem obvious to me. Up to you, though.

I guess I could, the algo for wrapping in the spec is (formula 8-27):

    if( FrameNum > frame_num )
        FrameNumWrap =3D FrameNum =E2=88=92 MaxFrameNum
    else
        FrameNumWrap =3D FrameNum

Our implementation has the branch condition flip over, and the flipped vers=
ion of that is:

    if( FrameNum <=3D frame_num )
        FrameNumWrap =3D FrameNum
    else
        FrameNumWrap =3D FrameNum =E2=88=92 MaxFrameNum

There is no deeper rationale since we simply follow the recipe described in=
 the
spec. This is done so that we can share that condition with that long term
reference handling.

>=20
> >  			p[i] =3D dpb[i].frame_num;
> >  			continue;
> >  		}
>=20
> Regards,
>=20
> 	Hans

