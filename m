Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF247A098
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhLSNKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:10:04 -0500
Received: from www.zeus03.de ([194.117.254.33]:60060 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233030AbhLSNKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=n8AmTf0c8HVOwBRmFjSGPcGmnzKn
        O61Flxsv3ZdP32Q=; b=TS9f5Fdl9H5fePoSHNBKcA/m8Qjk6n96xx+G3XLX3dfY
        1N4FY4Yf9Iv0Sdqv5JfuX6O/kykGfPZOI/nz5Y60SUhleVTT4T5dydLYcMETYHqS
        fJ54cj5Z9m6KKr06XQflRccapk4iCpfdqeAXNDY9QaPZUS1X+0LwtajBrEUAcdY=
Received: (qmail 608614 invoked from network); 19 Dec 2021 14:10:01 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Dec 2021 14:10:01 +0100
X-UD-Smtp-Session: l3s3148p1@TIopfX/T9MUgAQnoAHzOAHbG3MPk/2E5
Date:   Sun, 19 Dec 2021 14:09:57 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <Yb8vJRMEbNjtD3R6@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Documentation List <linux-doc@vger.kernel.org>
References: <20211123164902.35370-1-wsa+renesas@sang-engineering.com>
 <20211123164902.35370-2-wsa+renesas@sang-engineering.com>
 <YZ024q/r7Hc3TpMt@smile.fi.intel.com>
 <Yb2skaWF7cx6PHLO@kunai>
 <CAHp75VcV35r_54FXRGS31VT7W0LV6-U+PJOL46L49ro-T_hp4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1olE3+hUhRTydWIJ"
Content-Disposition: inline
In-Reply-To: <CAHp75VcV35r_54FXRGS31VT7W0LV6-U+PJOL46L49ro-T_hp4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1olE3+hUhRTydWIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

> I mean that there are similar functionality in different tools and for
> one purpose you need one, for another another and there is no format
> file convertors available (as far as my shallow googling shows).

Yes, this is a truth I can't change. So, I chose the Free Software
solution, so the format is at least documented. Also, you could just try
sigrok and pulseview, it has a nice set of protocol decoders. GTKWave
should be able to use the binary data inside the .sr IIRC. For other
software, you can at least write a converter because the format is open.

> > In your V1 review, you suggested -ENODATA. I will pick yet another one,
> > but it really matters zero in practice.
>=20
> Ah, okay, then choose the one you think fits most.

I took -EBADR now.

> > What is the difference? Does it matter here?
>=20
> I'm a bit lost in the context here, but the ' > /dev/null 2>&1' means
> to redirect stdout to the /dev/null followed by redirecting stderr to
> stdout (which is redirected to /dev/null). The other construction
> might have side effects IIRC.

Andy, *if* there is a side effect, I will happily fix it. But "it might
have a side effect IIRC" leaves all the detective work to me and I am
not short of other action items. Especially because this is not a
critical path.

> > I read that '-a' and '-o' are deprecated. Dunno where but looking again
> > I found this: https://stackoverflow.com/questions/20449680/boolean-oper=
ators-a-o-in-bash
>=20
> The SO talks about _bash_, your script is a plain Shell one, right?

It talks about being deprecated in POSIX, so quite the opposite of a
bashism, I'd say.

> > > > +   taskset "$1" echo 1 > "$lasysfsdir"/capture || fail "Capture er=
ror! Check kernel log"
> > >
> > > Shouldn't this function setup signal TRAPs?
> >
> > To do what?
>=20
> To clean up the garbage it may leave in case of the interrupted run, no?

I don't see any? Which ones do you have in mind?

> > > $@ is better, actually one should never use $*.
> >
> > What difference does it make when expanding into a string?
>=20
> The difference is on how the  "foo bar" (with double quotes!) will be
> represented. In your case it will be translated as "foo" and "bar", in
> the case I'm saying it will be "foo bar".

I very well know the difference. I was interested in what difference you
see when they get expanded into a string?

Happy hacking,

   Wolfram


--1olE3+hUhRTydWIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmG/LyEACgkQFA3kzBSg
KbYemw//V2ExEiWOROjcNT1F3yk2DGJq4eBiZ/kWGZomHh5cxnP7KpUs+Np4Ymor
7Vp5Sl5rLhDob4bF9jR55QhkPNbohyq507Yjjlr7XCktvgcYgEqJWQyi2NTpnaud
KacEDOe82OxaqODLpQYg6yRy5cZHKJKdJlsk8mjFsWzW83QT/O+IABHtgdsKKJfj
QXRNMheoEmfgNl0LHinUssfUGbbpE64nQhFTKQqadELCHiXSwCwGJu31TsY32Sq0
gHa9vJPVVnGYloVhSoZLuusR8cg1hb+0RLChQLGWCYEz0sKCucQ6McZC4fGKXNAa
j0dCk561j/eBBqKYbiL6MDKvwgqu5AGY0gYsYfYc5R1tiUj+LByP9cNxoj/ziFke
1kF64a35S3PtaqesUts/YEm0vgjUZBR2PoHNtEM9DfdEGpSNBZrFuoCcd9S6wjtC
GwsScumYJk+PSHzt2Iei6s/Y/aVcHZNelb5OMvGeQvUWbv3lqw29WE3Jfe0q4Fn0
PmycL+tu/RT58fiPIo23TFA4Wc24P76jvud8ZbdM/SYddWeLVWLOPE4c7JbKwQa9
ySA9y/iuMUapUm6mr2Uu5Rfa84JFG+Mj9hmDtic4aAiVdiw36SLs75f5I4eqBjOJ
cEGPlkS1BkPr+d25ePWACxKNZmzW7OkKrkkI9IDiKFoqJICQkhU=
=4z74
-----END PGP SIGNATURE-----

--1olE3+hUhRTydWIJ--
