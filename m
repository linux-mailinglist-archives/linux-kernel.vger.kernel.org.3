Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07054AF51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiFNLaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiFNLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:30:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820A33ED34
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:30:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w17so3351853wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fDkQC8ZKVocu1dwyc/psG+b89yWGBNWOILFDwfgnUw=;
        b=MtIL12FTuJLbgfojZkdiHK2wuuXZukt1C8rtMBGRtkseg9nG3Dl2xlSUSmBKiGHiHW
         KrDSL0uDk0ugVeO/B/S3mFMfpN3TQqMrq+ZxAmF8h9OpeoVU06DBJ8C0IAdo3mm1uhP2
         HMJgbIsqRADUfnNYNC6p1e+v2kR/Jd/E3b9Kbt2ked5zeQaYXcquj5bEZdCDBYXmlFwz
         IQvPcqIXnDQwYyvoShiDS5RQbXpmfAvMIX5HZiqo3MfYq3n42B2aw4Oqy4ED03baNz+J
         geycRa52J5H6Rf4W5rmzI+NEOP7TEqP1rwYXTfPwZpu9FJ+QjbJ+17H6/HhAHLuM7K3m
         wZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fDkQC8ZKVocu1dwyc/psG+b89yWGBNWOILFDwfgnUw=;
        b=CPF0amsAxWUHYyDeJkJNXf1G0U+KG+r8GfiWQbCs2dEFK2KpjQP98QMxw6ABv7e59o
         lO1GdaADTctGgJKtL9mGXTujpwvRqk/t15CAi40XHpc5qT+4GMJ83haIEIdSNPxcS3rS
         X7psjfbOaWp+vtlH3kDfNuuObvZkubnvcRqfYaDSr+gltB8gJGKQYrebxvZH98kC3zs4
         9+T568q4uXvJXll2K8Zd58JWr//bHrHxQfjsTkdZyBzbBYDwXxDbMletWUaQSQ/BpLqP
         iP5jn+TwgoBrhNl1F51iupvygtHFGs22zGDk0yvJmCOIiEVCDQl2Mmjn4mxwTveHKPZH
         1N9A==
X-Gm-Message-State: AJIora/d83cSiEA+qhFy34gatkN7u4tQxgGyjN/jlxnUfl8aREzu6++5
        ENS74EF7nXxdcPX1A1SZGoY=
X-Google-Smtp-Source: AGRyM1tIevNzKqQswlssBhpM+Qg3bjIy5LYWxiEf8JjfuqQgiwc3BcJ8GkK4jB1BXhhGtLPilyTKBA==
X-Received: by 2002:a05:6000:a10:b0:21a:14e2:794 with SMTP id co16-20020a0560000a1000b0021a14e20794mr4573888wrb.428.1655206216031;
        Tue, 14 Jun 2022 04:30:16 -0700 (PDT)
Received: from opensuse.localnet (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id i8-20020adffc08000000b0020c5253d8d0sm11365134wrr.28.2022.06.14.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:30:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com,
        naveenkumar.sunkari@in.bosch.com,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] ALSA: pcm: Test for "silence" field in struct "pcm_format_data"
Date:   Tue, 14 Jun 2022 13:30:13 +0200
Message-ID: <8079585.T7Z3S40VBb@opensuse>
In-Reply-To: <87y1xzplj1.wl-tiwai@suse.de>
References: <20220409012655.9399-1-fmdefrancesco@gmail.com> <2245197.ElGaqSPkdT@opensuse> <87y1xzplj1.wl-tiwai@suse.de>
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

On marted=C3=AC 14 giugno 2022 12:49:38 CEST Takashi Iwai wrote:
> On Tue, 14 Jun 2022 12:43:16 +0200,
> Fabio M. De Francesco wrote:
> >=20
> > On marted=C3=AC 14 giugno 2022 11:58:51 CEST Eugeniu Rosca wrote:
> > > Hello Fabio, hello All,
> > >=20
> > > On Sa, Apr 09, 2022 at 03:26:55 +0200, Fabio M. De Francesco wrote:
> > > > Syzbot reports "KASAN: null-ptr-deref Write in
> > > > snd_pcm_format_set_silence".[1]
> > > >=20
> > > > It is due to missing validation of the "silence" field of struct
> > > > "pcm_format_data" in "pcm_formats" array.
> > > >=20
> > > > Add a test for valid "pat" and, if it is not so, return -EINVAL.
> > > >=20
> > > > [1] https://lore.kernel.org/lkml/
> > 000000000000d188ef05dc2c7279@google.com/
> > > >=20
> > > > Reported-and-tested-by:=20
> > syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > >=20
> > > > I wasn't able to figure out the commit for the "Fixes:" tag. If=20
this=20
> > patch
> > > > is good, can someone please help with providing this missing=20
> > information?
> > > >=20
> > > >  sound/core/pcm_misc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
> > > > index 4866aed97aac..5588b6a1ee8b 100644
> > > > --- a/sound/core/pcm_misc.c
> > > > +++ b/sound/core/pcm_misc.c
> > > > @@ -433,7 +433,7 @@ int snd_pcm_format_set_silence(snd_pcm_format_t=
=20
> > format, void *data, unsigned int
> > > >  		return 0;
> > > >  	width =3D pcm_formats[(INT)format].phys; /* physical width */
> > > >  	pat =3D pcm_formats[(INT)format].silence;
> > > > -	if (! width)
> > > > +	if (!width || !pat)
> > > >  		return -EINVAL;
> > > >  	/* signed or 1 byte data */
> > > >  	if (pcm_formats[(INT)format].signd =3D=3D 1 || width <=3D 8) {
> > >=20
> > > JFYI, PVS-Studio 7.19 reports:
> > >=20
> > > sound/core/pcm_misc.c	409	warn	V560 A part of=20
> > conditional expression is always false: !pat.
> >=20
> > Sorry, I assumed (wrongly!) that when we have
> >=20
> > static const struct pcm_format_data=20
> > pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] =3D {
> > 	[SNDRV_PCM_FORMAT_S8] =3D {
> > 		.width =3D 8, .phys =3D 8, .le =3D -1, .signd =3D 1,
> > 		.silence =3D {},
> > 	},
> > 	[snip]
> > 	/* FIXME: the following two formats are not defined properly yet=20
> > */
> > 	[SNDRV_PCM_FORMAT_MPEG] =3D {
> > 		.le =3D -1, .signd =3D -1,
> > 	},
> > 	[SNDRV_PCM_FORMAT_GSM] =3D {
> > 		.le =3D -1, .signd =3D -1,
> > 	},
> >=20
> > pointer "silence", and then "pat", must be NULL.
>=20
> Oh right, those are missing ones.  I haven't realized that those
> formats are allowed by PCM OSS layer.
>=20
> Practically seen, those formats have never been used in reality, and
> we may consider dropping them completely to plug such holes...
>=20
Does it imply that my argument is correct or my "fix" can't yet catch those=
=20
missing ones?

Besides the question above, I want to notice that we have one more /* FIXME=
=20
*/ entry...

/* FIXME: the following format is not defined properly yet */
	[SNDRV_PCM_FORMAT_SPECIAL] =3D {
		.le =3D -1, .signd =3D -1,
	},

If you want I can get rid of those three entries if you confirm they can=20
safely be deleted. In a second patch I can also remove that unnecessary=20
check for valid "pat".

Please let me know.

Thanks,

=46abio



