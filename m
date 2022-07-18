Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B74578B10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiGRTiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiGRTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:38:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A666231933;
        Mon, 18 Jul 2022 12:37:43 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA4466601795;
        Mon, 18 Jul 2022 20:37:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658173061;
        bh=LCf/s3bJotpGmDKE8E4oSQh+ckkgVVV5vCvcjXblB0s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X/JVOBEF1Lzc6xx7hoh2Tlhlv12AOKBhCOIIdQDwSRRd8IlVq8A/8r8er7fuuVoGt
         pUw7fqL4Jqp4kJb1cjDo5S47jrvXiXEin8QhdU0FkRu4Q0MB4GZyA8lhe8JdfasVfL
         0sGNUqN4AoGC1RP8LkSjliFCqaLrR7zrQmKCW57qf3flYxKQYJBlf+VNynaUbh1GNL
         UG+efbtZ3drunHD6aR3Xonm9YPMl0Q+6RQK55+MQm38DOXp5svriHAn6CN8TmLcB1Q
         2y6x+HBsFtQ0zV80fk9LbjiRXrtcAktPRHPCiJgm0A+x56J5oN1lSx/aQ8MQalrVhU
         C2jqQDdLsFtig==
Message-ID: <b588b53fcfe539692a0a55b9fd0e97528def1d96.camel@collabora.com>
Subject: Re: Re: [PATCH] media: cedrus: hevc: Add check for invalid timestamp
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jul 2022 15:37:31 -0400
In-Reply-To: <4725382.GXAFRqVoOG@kista>
References: <20220718165649.16407-1-jernej.skrabec@gmail.com>
         <d58e8624e9703e5dbbc54908aa142d10ef7f5a22.camel@collabora.com>
         <4725382.GXAFRqVoOG@kista>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 18 juillet 2022 =C3=A0 19:57 +0200, Jernej =C5=A0krabec a =C3=A9cr=
it=C2=A0:
> Dne ponedeljek, 18. julij 2022 ob 19:41:48 CEST je Nicolas Dufresne=20
> napisal(a):
> > Le lundi 18 juillet 2022 =C3=A0 18:56 +0200, Jernej Skrabec a =C3=A9cri=
t :
> > > Not all DPB entries will be used most of the time. Unused entries wil=
l
> > > thus have invalid timestamps. They will produce negative buffer index
> > > which is not specifically handled. This works just by chance in curre=
nt
> > > code. It will even produce bogus pointer, but since it's not used, it
> > > won't do any harm.
> > >=20
> > > Let's fix that brittle design by skipping writing DPB entry altogethe=
r
> > > if timestamp is invalid.
> > >=20
> > > Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support"=
)
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >=20
> > >  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > > 1afc6797d806..687f87598f78 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > @@ -147,6 +147,9 @@ static void cedrus_h265_frame_info_write_dpb(stru=
ct
> > > cedrus_ctx *ctx,>=20
> > >  			dpb[i].pic_order_cnt_val
> > >  	=09
> > >  		};
> > >=20
> > > +		if (buffer_index < 0)
> > > +			continue;
> >=20
> > When I compare to other codecs, when the buffer_index does not exist, t=
he
> > addr 0 is being programmed into the HW. With this implementation is is =
left
> > to whatever it was set for the previous decode operation. I think its i=
s
> > nicer done the other way.
>=20
> It's done the same way as it's done in vendor lib. As I stated in commit=
=20
> message, actual values don't matter for unused entries. If it is used by=
=20
> accident, HW reaction on all zero pointers can only be worse than using o=
ld,=20
> but valid entry.
>=20
> Due to no real documentation and Allwinner unwillingness to share details=
,=20
> we'll probably never know what's best response for each error. Some thing=
s can=20
> be deduced from vendor code, but not all.
>=20
> I would rather not complicate this fix, especially since it's candidate f=
or=20
> backporting.

I am simply trying to highlight that this is not consistant with how the H2=
64
part is done. Why do we reset the register for one codec and not the other =
?=C2=A0

Perhaps you should sync to your preference the driver as a whole. It also s=
eems
that before your patch, some bits would be 0 and some other would be very l=
arge
values. Between this and leaving random value, I don't really see any gain =
or
reason for a backport. It neither break or fix anything as far as I underst=
and.=C2=A0

My general opinion, is that we fixe the unused address (like to 0) then whe=
n
something goes wrong, as least it will go wrong consistently.

>=20
> Best regards,
> Jernej
>=20
> >=20
> > > +
> > >=20
> > >  		cedrus_h265_frame_info_write_single(ctx, i,=20
> dpb[i].field_pic,
> > >  	=09
> > >  						   =20
> pic_order_cnt,
> > >  						   =20
> buffer_index);
>=20
>=20

