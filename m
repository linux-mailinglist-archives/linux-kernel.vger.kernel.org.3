Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8697598BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbiHRSrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbiHRSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:46:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C38BBA4A;
        Thu, 18 Aug 2022 11:46:55 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 826596601BCA;
        Thu, 18 Aug 2022 19:46:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660848413;
        bh=kgiJErTBNmtrZKKCku7bEzXoVYgMa+E1N+vhYhNibJE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aCzaEAkzVh/6pFFmtrU7cBKkKIp7UMr5O3G9f4cl2dliwZy1SUZE3571LmMx5bH7g
         yu7GesaQmB4ZhqQEBK/+zLEysvTDWurjnqYiAfZ9xlskW1uUNlD4DdBpY9x/yW+aiQ
         A5FjXnRvpr67OpkVXAeF3x4ofENvKoeYFxwj4afWIFKWhQHNRNckwdeNbMldD9j/9L
         J/muEWibR2CFK537pS43L7auCUS9aNOoBJm/EWFG2gvewyhPZIx4LaVzAG+DgGAeDc
         T2VHx6xeLvjJL0HNnDHziq9PNAED9Qefvr3ljn5gl1Tzm1vIt5PzI+YtD/IUN+O83M
         m9/KdkRzZCCPQ==
Message-ID: <1629aa7de48594dee81df707ca595386697bfc02.camel@collabora.com>
Subject: Re: [PATCH] media: cedrus: hevc: Add check for invalid timestamp
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Aug 2022 14:46:42 -0400
In-Reply-To: <YtXVeAChyKlfqD8O@eze-laptop>
References: <20220718165649.16407-1-jernej.skrabec@gmail.com>
         <4725382.GXAFRqVoOG@kista>
         <b588b53fcfe539692a0a55b9fd0e97528def1d96.camel@collabora.com>
         <1795344.atdPhlSkOF@jernej-laptop> <YtXVeAChyKlfqD8O@eze-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 18 juillet 2022 =C3=A0 18:49 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> Hi Jernej,
>=20
> On Mon, Jul 18, 2022 at 10:34:37PM +0200, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 18. julij 2022 ob 21:37:31 CEST je Nicolas Dufresne=20
> > napisal(a):
> > > Le lundi 18 juillet 2022 =C3=A0 19:57 +0200, Jernej =C5=A0krabec a =
=C3=A9crit :
> > > > Dne ponedeljek, 18. julij 2022 ob 19:41:48 CEST je Nicolas Dufresne
> > > >=20
> > > > napisal(a):
> > > > > Le lundi 18 juillet 2022 =C3=A0 18:56 +0200, Jernej Skrabec a =C3=
=A9crit :
> > > > > > Not all DPB entries will be used most of the time. Unused entri=
es will
> > > > > > thus have invalid timestamps. They will produce negative buffer=
 index
> > > > > > which is not specifically handled. This works just by chance in
> > > > > > current
> > > > > > code. It will even produce bogus pointer, but since it's not us=
ed, it
> > > > > > won't do any harm.
> > > > > >=20
> > > > > > Let's fix that brittle design by skipping writing DPB entry alt=
ogether
> > > > > > if timestamp is invalid.
> > > > > >=20
> > > > > > Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding su=
pport")
> > > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > > > ---
> > > > > >=20
> > > > > >  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > > > > > 1afc6797d806..687f87598f78 100644
> > > > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > > @@ -147,6 +147,9 @@ static void
> > > > > > cedrus_h265_frame_info_write_dpb(struct
> > > > > > cedrus_ctx *ctx,>
> > > > > >=20
> > > > > >  			dpb[i].pic_order_cnt_val
> > > > > >  	=09
> > > > > >  		};
> > > > > >=20
> > > > > > +		if (buffer_index < 0)
> > > > > > +			continue;
> > > > >=20
> > > > > When I compare to other codecs, when the buffer_index does not ex=
ist,
> > > > > the
> > > > > addr 0 is being programmed into the HW. With this implementation =
is is
> > > > > left
> > > > > to whatever it was set for the previous decode operation. I think=
 its is
> > > > > nicer done the other way.
> > > >=20
> > > > It's done the same way as it's done in vendor lib. As I stated in c=
ommit
> > > > message, actual values don't matter for unused entries. If it is us=
ed by
> > > > accident, HW reaction on all zero pointers can only be worse than u=
sing
> > > > old, but valid entry.
> > > >=20
> > > > Due to no real documentation and Allwinner unwillingness to share d=
etails,
> > > > we'll probably never know what's best response for each error. Some=
 things
> > > > can be deduced from vendor code, but not all.
> > > >=20
> > > > I would rather not complicate this fix, especially since it's candi=
date
> > > > for
> > > > backporting.
>=20
> I think this makes sense, since it allows to fix the bug for the time
> being.
>=20
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Ack.

>=20
> Thanks!
> Ezequiel
>=20
> > >=20
> > > I am simply trying to highlight that this is not consistant with how =
the
> > > H264 part is done. Why do we reset the register for one codec and not=
 the
> > > other ?
> >=20
> > While H264 and HEVC are similar in many ways, Cedrus uses two different=
 cores=20
> > or in Cedrus slang, engines, for them. They have their own quirks. One =
of the=20
> > most apparent is handling of DPB array. H264 requires that same entry i=
s=20
> > always at the same position in HW DPB. That's not required by HEVC.
> >=20
> > Additional reasons for differences come from the fact that it's from tw=
o=20
> > different authors (Maxime and Paul). Those differences were created at =
the=20
> > beginning and it is what it is.
> >=20
> > >=20
> > > Perhaps you should sync to your preference the driver as a whole. It =
also
> > > seems that before your patch, some bits would be 0 and some other wou=
ld be
> > > very large values. Between this and leaving random value, I don't rea=
lly
> > > see any gain or reason for a backport. It neither break or fix anythi=
ng as
> > > far as I understand.
> >=20
> > Maybe there is no need to backport, but the change is nevertheless usef=
ul. As=20
> > I explained, current code works only by chance, as we noticed with Ezeq=
uiel's=20
> > rework. It's certainly worthwhile to make code less brittle. As far as =
I'm=20
> > concerned, fixes tag can be dropped or even Ezequiel can squash this ch=
ange=20
> > into his commit, with appropriate adjustments, of course.
> >=20
> > I'm not completely sure what do you mean by syncing driver preference. =
Code=20
> > changes always need a good reason to be accepted. Moving code around an=
d=20
> > renaming things just to be similar with something else is not.
> >=20
> > Best regards,
> > Jernej
> >=20
> > >=20
> > > My general opinion, is that we fixe the unused address (like to 0) th=
en when
> > > something goes wrong, as least it will go wrong consistently.
> > >=20
> > > > Best regards,
> > > > Jernej
> > > >=20
> > > > > > +
> > > > > >=20
> > > > > >  		cedrus_h265_frame_info_write_single(ctx, i,
> > > >=20
> > > > dpb[i].field_pic,
> > > >=20
> > > >=20
> > > > pic_order_cnt,
> > > >=20
> > > > buffer_index);
> >=20
> >=20
> >=20
> >=20

