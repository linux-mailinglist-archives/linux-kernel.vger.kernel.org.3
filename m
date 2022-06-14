Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B687354AEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356230AbiFNKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiFNKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:43:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402E369CE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:43:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a15so10693203wrh.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58My0mpinLHyTuDa/H86KpBx1dzYAXeM2EITtFo9zMM=;
        b=fuh/hwSnlr8FXhNJBcZOrijMZ4RxGYyviL1vzq0OQsIj0fQEFhr1HuoCiFf8CRrkB0
         c2WArCkmltPMIk7sGPPuCBYigdhXeGLHpNF9e5GZW5VsbVmddxv1+4te4BXNeBAek+cX
         tJu6pO1FORL5CH3W9/yjL2IUSIILz/iFyQuoaC5gt1VvIeE1K2ycg94mFFVU0LjHKGCL
         j2cCWUN/XUliblsn8GnQ1jhMeLHN8db5Dx/Kqn11TK2Q8X5bTj86uFRPCl/X3KfwDDAv
         qp22BUckyAu4MDeOHWb/h0Eh+JkkGEiXqLaiJYDV9gqrc9Vo6OA7WMCIfEWziwZmsraX
         +9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58My0mpinLHyTuDa/H86KpBx1dzYAXeM2EITtFo9zMM=;
        b=yf8r16ErV4RRBKAubE9HN5D1oBgtSpYR0mOywplj6mlO2iFgIr1FDujhh1hzYyRAtt
         oAHT3mJpvUZiW9YxWkBfgkOh/3+LejipfD1Rnnp4r3UKtQKGRkkfreHJx+EDtK9ZMUrw
         x/VhsHhFWT9wv2QKeqLnBKJx1vpK11RPHU3sdIQPEwNvWtN6+P2rd8/RFvSsTSxluAYK
         czbg2EGLT7kanScZt51HePb9f80dor9mQlVgCIYoLBEV0ZRZGiPOtGqGUQuu3YP+xfcq
         19Rh4z55xjJhfzpOgK45Eb4JfF1k5FdG/2h69AQnUhyeCPFTpFgCnmKOJBxuR1dRJUSz
         dvYQ==
X-Gm-Message-State: AJIora+0TG3OUjF4UpXy12JQ6FCVqpI5a4j6Uw1oO/IZYSdxmcXovAy0
        G0wLxQRumKUwPwDzmr9pg5SFzwuBPSo=
X-Google-Smtp-Source: AGRyM1vifZNk7UNCd0fbSo6GfAzc1DWqTpviOn5j20ZquC99csaXOxr92vBy0F9G1mnLmVJ4Bm8G/g==
X-Received: by 2002:a5d:4c49:0:b0:210:353c:1c91 with SMTP id n9-20020a5d4c49000000b00210353c1c91mr4418062wrt.159.1655203399325;
        Tue, 14 Jun 2022 03:43:19 -0700 (PDT)
Received: from opensuse.localnet (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id f2-20020adfb602000000b002185c6dc5b1sm12959912wre.108.2022.06.14.03.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:43:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com,
        naveenkumar.sunkari@in.bosch.com,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] ALSA: pcm: Test for "silence" field in struct "pcm_format_data"
Date:   Tue, 14 Jun 2022 12:43:16 +0200
Message-ID: <2245197.ElGaqSPkdT@opensuse>
In-Reply-To: <20220614095851.GA4199@lxhi-065>
References: <20220409012655.9399-1-fmdefrancesco@gmail.com> <20220614095851.GA4199@lxhi-065>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 14 giugno 2022 11:58:51 CEST Eugeniu Rosca wrote:
> Hello Fabio, hello All,
>=20
> On Sa, Apr 09, 2022 at 03:26:55 +0200, Fabio M. De Francesco wrote:
> > Syzbot reports "KASAN: null-ptr-deref Write in
> > snd_pcm_format_set_silence".[1]
> >=20
> > It is due to missing validation of the "silence" field of struct
> > "pcm_format_data" in "pcm_formats" array.
> >=20
> > Add a test for valid "pat" and, if it is not so, return -EINVAL.
> >=20
> > [1] https://lore.kernel.org/lkml/
000000000000d188ef05dc2c7279@google.com/
> >=20
> > Reported-and-tested-by:=20
syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >=20
> > I wasn't able to figure out the commit for the "Fixes:" tag. If this=20
patch
> > is good, can someone please help with providing this missing=20
information?
> >=20
> >  sound/core/pcm_misc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
> > index 4866aed97aac..5588b6a1ee8b 100644
> > --- a/sound/core/pcm_misc.c
> > +++ b/sound/core/pcm_misc.c
> > @@ -433,7 +433,7 @@ int snd_pcm_format_set_silence(snd_pcm_format_t=20
format, void *data, unsigned int
> >  		return 0;
> >  	width =3D pcm_formats[(INT)format].phys; /* physical width */
> >  	pat =3D pcm_formats[(INT)format].silence;
> > -	if (! width)
> > +	if (!width || !pat)
> >  		return -EINVAL;
> >  	/* signed or 1 byte data */
> >  	if (pcm_formats[(INT)format].signd =3D=3D 1 || width <=3D 8) {
>=20
> JFYI, PVS-Studio 7.19 reports:
>=20
> sound/core/pcm_misc.c	409	warn	V560 A part of=20
conditional expression is always false: !pat.

Sorry, I assumed (wrongly!) that when we have

static const struct pcm_format_data=20
pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] =3D {
	[SNDRV_PCM_FORMAT_S8] =3D {
		.width =3D 8, .phys =3D 8, .le =3D -1, .signd =3D 1,
		.silence =3D {},
	},
	[snip]
	/* FIXME: the following two formats are not defined properly yet=20
*/
	[SNDRV_PCM_FORMAT_MPEG] =3D {
		.le =3D -1, .signd =3D -1,
	},
	[SNDRV_PCM_FORMAT_GSM] =3D {
		.le =3D -1, .signd =3D -1,
	},

pointer "silence", and then "pat", must be NULL.

I'd better read again how fields of global struct variables are initialized=
=20
:-(

Thanks for this finding,

=46abio

>=20
> I haven't fully validated the finding, but it appears to be legit,
> since the pointer variable (as opposed to the contents behind the
> pointer) is always non-null, hence !pat always evaluating to false.
>=20
> If the above is true, then the patch likely hasn't introduced any
> regression, but also likely hasn't fixed the original KASAN problem.
>=20
> Or are there alternative views?
>=20
> BR, Eugeniu.
>=20



