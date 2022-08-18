Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBF597EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiHRGom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243713AbiHRGoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:44:39 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561C51A09
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:44:38 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 798283F12E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660805075;
        bh=DlhFnIdUMBOYUKK8lBE6v5auDBKzAT3PWLok7Bl69AQ=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=uG3DQZHoedbQQZf+hoDyE2hDkQYNAP17EpN7e+wTeappdjx96S+9DJgGloJKFFBvG
         l4dS3uNoPXe6XXc2DjlUslSl0k+Gc6SJIAWjmF8DlF4Co7UMrCyCQJ+jzqhDPv0ju1
         bePd9INPcLoc2/b2e5vjzKfsiTHtKoPbMklRzy/0bGl9S3Cm+1E0TKhBNi2mayMMob
         mUfa08QD3Ml9uuGX7CewD55AO3RMFO4uLB5M4NN/MTCusUXP/m/iSmCToom2iLNcSe
         Yh7I23KTSViOxG8JPGigbPuftlUfRLRdjdd9MWKlYdU3gMVnwFVnphwckRJ1RR0WkW
         pYT8Ferz6kj6Q==
Received: by mail-ed1-f70.google.com with SMTP id g8-20020a056402424800b0043e81c582a4so380900edb.17
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DlhFnIdUMBOYUKK8lBE6v5auDBKzAT3PWLok7Bl69AQ=;
        b=YIRUwkXmTgiKBZ97fQxNbHJQlLYnnnOw/4Ap8wKeg1WQH+mrryDc9M1a5eLMlCZV2R
         v+0Ii/xq7/tGA/Z/0pZ02nDppgBnImsAx86VY0YIASUcXAlB8y8aOWEGpnfmgSFfJhe+
         y2NlQmhihqZMz76Yb2B/VE04zz6gjmIqgyWTpOaKZOnIGPeBp48G/S9RvvJHNEgdNgZz
         1t3KSlBhjmHSCGzV0L5o0wq05IxMofS+OH/l0nYwe3Vx04H2uDKFYgf5txBlgSLWngsM
         na9S7SpqQeXgSeTHlCSy0MpgjqZA/1hQqs081B6xNXJZCYZLNaxrR61X4DW4PkxuuBl7
         b2oA==
X-Gm-Message-State: ACgBeo2+I202qAjh2cOmDIIdipe1RyxxTOhuLADMdREbcFJ+Dp5dkt/D
        YKOSrF5J+djZCSUoiNohZRR/PIvUac6iH2uQ0xRa3vTslxYMG8/k5wSe4/v6ivaa4Afa9+LschP
        iMVojBEShtD7y+x4Cli69syTEF1T6D0xW+ZvNriTn5g==
X-Received: by 2002:aa7:d508:0:b0:445:dd73:4f6f with SMTP id y8-20020aa7d508000000b00445dd734f6fmr1100781edq.231.1660805075103;
        Wed, 17 Aug 2022 23:44:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ZAU7Kf5zJnIs7zdYVrqU4dSuauM0GuoeE5k0wyJ9b5fwFVy3N4F7Qic0fUtdAg9Mt31Q0pA==
X-Received: by 2002:aa7:d508:0:b0:445:dd73:4f6f with SMTP id y8-20020aa7d508000000b00445dd734f6fmr1100767edq.231.1660805074928;
        Wed, 17 Aug 2022 23:44:34 -0700 (PDT)
Received: from smeagol ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906300200b00721d8e5bf0bsm399793ejz.6.2022.08.17.23.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:44:33 -0700 (PDT)
Date:   Thu, 18 Aug 2022 08:44:30 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: meson: vdec: Add MODULE_FIRMWARE macro
Message-ID: <20220818084430.0ca10b30@smeagol>
In-Reply-To: <04115bee-5ddb-701f-ad18-d2c846155816@baylibre.com>
References: <20220817140539.150013-1-juerg.haefliger@canonical.com>
        <04115bee-5ddb-701f-ad18-d2c846155816@baylibre.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NRjcrFgnzwojt7mVFj1UxFl";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NRjcrFgnzwojt7mVFj1UxFl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Aug 2022 18:08:19 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 17/08/2022 16:05, Juerg Haefliger wrote:
> > The meson-vdec module loads firmware so add MODULE_FIRMWARE macros to
> > provide that information via modinfo.
> >=20
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > ---
> >   .../staging/media/meson/vdec/vdec_platform.c  | 20 +++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >=20
> > diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers=
/staging/media/meson/vdec/vdec_platform.c
> > index 88c9d72e1c83..c7750d4be848 100644
> > --- a/drivers/staging/media/meson/vdec/vdec_platform.c
> > +++ b/drivers/staging/media/meson/vdec/vdec_platform.c
> > @@ -280,3 +280,23 @@ const struct vdec_platform vdec_platform_sm1 =3D {
> >   	.num_formats =3D ARRAY_SIZE(vdec_formats_sm1),
> >   	.revision =3D VDEC_REVISION_SM1,
> >   };
> > +
> > +MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");
> > +MODULE_FIRMWARE("meson/vdec/g12a_h264.bin"); =20
>=20
> Duplicate

Oh this is embarrassing :-(


> > +MODULE_FIRMWARE("meson/vdec/g12a_vp9.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxbb_h264.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_h264.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin"); =20
>=20
> DDDDDDDuplicate
>=20
> > +MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");
> > +MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin"); =20
>=20
> Duplicate
>=20
> > +MODULE_FIRMWARE("meson/vdec/gxm_h264.bin");
> > +MODULE_FIRMWARE("meson/vdec/sm1_vp9_mmu.bin"); =20
>=20
> With the duplicate entries removed, please add my:
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Will do. Thanks for the review.

...Juerg


--Sig_/NRjcrFgnzwojt7mVFj1UxFl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmL9388ACgkQD9OLCQum
QrdG7Q/9FwPE/3/kGYBq248tkz8znw0beqrk7fc04SQdThTNb+Nm8x+4ozI/vs7r
ybj+Pysjebw37NTrhjZCXGisHt02zs9D0yZmN2bkoHOvP/2ADhrlfI2x6Bmb7VZo
Tmd1EXUHSBI9mJEA3Po0grFqq/I4Pz9ntVHMKrxUdCd/0iEKHHnSb8l4Zo6upq1s
cBYpAvHi393MGpgI91gqHv3QowE/IpNFLhxt3/hgFUxi8BiUsOJBetO7c+kBIBHi
YqqUvTd4seKYzctWYGdbB94EW15mMALypsQMsR28UKwCcd1aC0dmV4r/o99sCajP
Xxyb0Ud9t/j6wXdR1hnU//bkOvOtOjDEgRKHVunfKALOFq8XleCW+2ZSEQGWqZXG
kDJeLs6RyKBZPWWn/IvY9tmVv79iPcODEYXSdW7BKzj9p5Syqaf+3cAB/Td4wlNV
O+/NFPbS4FrsMV3r+0OgR9+N9IfyFUutlZosW56uzHKbaq2pOvcLUBLdYY73jsn2
r8M+chwvKhdL2fG4nZR/a18/Vot5c3CaUQ0arMLEZBxzI4joAHYcgzId0ICztk75
zmZB+rrpvOsUgseQhcQV5xcJ5zmS2sV/EAfWROXnl1OWU1tW3OXAcn8gOgz4KBsY
v5WXJcCjdolJhr/7p67181WQavdvxW/4B8lOq1xFp3l+FKHbnU4=
=3reT
-----END PGP SIGNATURE-----

--Sig_/NRjcrFgnzwojt7mVFj1UxFl--
