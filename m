Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6125055C6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbiF1LIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbiF1LIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:08:50 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74F2B1BF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=fnN1d4Dq8Eak6DfJZbGGF+U86n3u
        0SFngUX3XdYVtTo=; b=nr7U4POmIS0EoP/sKwkDHFnvTOb24VLFEhEtcz5CA0+q
        tHfaTXud7aravkiVOFc7KloRqru1fEMjJUemarsNOCiF+dB+3x92dbA4vunqVCpH
        48eZC6TBSXhIQizsgx8AshxBmHIoCwxjnbpHiBULM19y+jOsFt7UOM3CnvrFuok=
Received: (qmail 2835320 invoked from network); 28 Jun 2022 13:08:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Jun 2022 13:08:44 +0200
X-UD-Smtp-Session: l3s3148p1@tWtRD4Di/1tZD+zG
Date:   Tue, 28 Jun 2022 13:08:43 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: renesas: rcar-gen4: implement SDSRC properly
Message-ID: <YrrhO+kb5d2rtTNA@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220615101227.13463-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdVX9_qO2Ydi=_57NC2fFRy=YAzuSV7xH=huAamXKOKwCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qfk1NNd/R1nDqBr5"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVX9_qO2Ydi=_57NC2fFRy=YAzuSV7xH=huAamXKOKwCA@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qfk1NNd/R1nDqBr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> > Tested on my Spider board (r8a779f0). Only build tested for r8a779g0 but
> > the docs for the registers are the same.
>=20
> While the SDSRCSEL bits are the same, the register at offset 0x8a4 is
> called SD0CKCR1 on R-Car S4-8, and CKSRCSELCR on R-Car V4H.
> I guess that is why you removed the definition of SD0CKCR1, and stored
> the register offset in DEF_GEN4_SDSRC(), despite both being the same?

TBH, no :) I did that to be future proof in case the register gets moved
somewhere else. Also, this is consistent how we did it with DEF_GEN3_SD.

> >         case CLK_TYPE_GEN4_SDSRC:
> > -               div =3D ((readl(base + SD0CKCR1) >> 29) & 0x03) + 4;
> > +               value =3D (readl(base + core->offset) >> 29) & 3;
> > +               if (value) {
> > +                       div =3D value + 4;
> > +               } else {
> > +                       parent =3D clks[core->parent >> 16];
> > +                       if (IS_ERR(parent))
> > +                               return ERR_CAST(parent);
> > +                       div =3D 2;
> > +               }
>=20
> So this gives the exact same divider of PLL5 before.
>=20
> The clock diagram indeed shows different paths for value 0
> (PLL5 -> 1/2 -> 1/2) and values 1 and 2 (PLL5 -> {1/5 or 1/6}).
> But the textual description for SDSRC says "The SDSRC divider divides
> PLL5 output clock", matching the original code.
>=20
> Do we have to complicate the code? ;-)
> I guess the clock diagram was based on the diagram for R-Car H3
> (which has two daisy-chained fixed 1/2 dividers), with the new 1/5
> and 1/6 dividers added.

We don't have to complicate the code unnecessarily. If you think the
diagram is flawed, then we can keep the current code. I changed the code
because I was confused when checking 'clk_summary' with the diagram and
wanted to make it proper to reduce my confusion.

My patches to enable eMMC on Spider have a significantly lower
throughput than the BSP, so this was the first step of trying to verify
things and get the clocks in shape.

If you call it superfluous, then we can drop it. No hard feelings here.

All the best,

   Wolfram


--Qfk1NNd/R1nDqBr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmK64TgACgkQFA3kzBSg
KbZ9FQ/+MrsommjVLbJc4WToCH5kc03TkVY1LirYpMT4lEyo6kO5FEF3Ca6vE9VQ
PjsAq+B0xTPTV0+uOK1X7f+lc2dcJg6X77Zm/atVoa6X3ySyCNMssW+8PTQzNGrY
jlgdNT6wChWRDhRnQItPKE8/curwc0NFdI5eYwayY+B8eaMUlGBuECdR6AmY96/3
CEMWJhDAUJruWWJEDh1qz74V25Z593Em5O+m0jG0xR4d4JrrKs+cUc9yszYJZHko
nDseuN3m8rp1dh4GXoD3Od5jdGzOA6YyTMHJTxf8+sVQF9d7ciuH5dBpJ7KsdbKg
SdJ5Gt/gbL1trwQOEN2zP61jjb+iaa1MtW8d3OpgpAvD/OIfMxd+CXIWcNv8rQjH
Zjc5vbaaXGwRr5v02+zVV+hTv+y03RxzzhdIIOPNKpoi/tH61plKMTgowjRd7gSw
aHefwrvRd3ySKpphQH+8YGK3aC4NW0/fY804UYKdc0fCYxsdKQEUWFvTGf3dpsPs
ui58LGZIjfuVqU5y9JFwI86UCgN2jEhJL9a/dQhmc0aRgT3Gtu+s+uJ3uh+pdqKe
1j3dmgsnOAfC3KFeC8dM+1ETW3QDJy0kPnevPulLdw91qUkp45mGrI400bs+hHj6
d4j2cY74V9co/gxYEfSp1r7ZXDm964Ixqmt4EqQ8Bf9lEidIjsk=
=3yCg
-----END PGP SIGNATURE-----

--Qfk1NNd/R1nDqBr5--
