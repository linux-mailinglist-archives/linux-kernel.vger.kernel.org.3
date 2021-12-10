Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1647146FFB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhLJLWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:22:22 -0500
Received: from www.zeus03.de ([194.117.254.33]:35490 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237712AbhLJLWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=2Aqud306rFs88j3dyky/UfXf59yS
        uJqUHmSVrmdZR2I=; b=qIH3Fs+dCthxL+4Gddomzfhgdc23TO3TG2lYe/tVdsVl
        OP6Xc4DtvXViVi4xZ0UmoPOkAaZONHbfcW8Q5kpnu+Mz5JPxHoshq8xxvRV5WPSc
        cfXtfqffh0UyXRfQuFT8O2WV2J5lMk/Msz9xvML9563C8Bq7hdn6BtMcWq9rAU8=
Received: (qmail 1443055 invoked from network); 10 Dec 2021 12:18:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Dec 2021 12:18:43 +0100
X-UD-Smtp-Session: l3s3148p1@wUnA4sjSopEgAQnoAEPjAJzPXF1eIEK3
Date:   Fri, 10 Dec 2021 12:18:41 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YbM3kcEW7m9Ado1e@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-doc@vger.kernel.org
References: <20211123164902.35370-1-wsa+renesas@sang-engineering.com>
 <20211123164902.35370-2-wsa+renesas@sang-engineering.com>
 <CACRpkdYJqP7WJuhS9G65abCZHK1_LX9hkXU6o+k10t2LXw100w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZbgJohPepknqqfKx"
Content-Disposition: inline
In-Reply-To: <CACRpkdYJqP7WJuhS9G65abCZHK1_LX9hkXU6o+k10t2LXw100w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZbgJohPepknqqfKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

> I like this patch.

I am glad!

>=20
> Maybe a small paragraph first saying what this is, the usecase (feel
> free to steal, rewrite etc):
>=20
> The sloppy logic analyzer will utilize a few GPIO lines in input mode
> on a system to rapidly sample these digital lines, which will, if the
> Nyquist criteria is met, result in a time series log with approximate
> waveforms as they appeared on these lines.
>=20
> One way to use it is to analyze external traffic connected to these
> GPIO lines with wires (i.e. digital probes), acting as a common logic
> analyzer.

Well, frankly, with the driver depending on EXPERT, this paragraph seems
a tad superfluous to me. But as it came for free and won't hurt, I took
the liberty to add this to the beginning of the documentation.

> Another thing it can do is to snoop on on-chip peripherals if the I/O
> cells of these peripherals can be used in GPIO input mode at the same
> time as they are being used as inputs or outputs for the peripheral,
> for example it would be possible to scale down the speed of a certain
> MMC controller and snoop the traffic between the MMC controller and
> the SD card by the sloppy logic analyzer. In the pin control subsystem
> such pin controllers are called "non-strict": a certain pin can be
> used with a certain peripheral and as a GPIO input line at the same
> time.

Thanks for pointing out the 'strict' mode. I actually did snoop pins
muxed to I2C but I had to use a gpiolib hack for it assuming this was
not supported otherwise. Now, I have a one-liner for the Renesas pinctrl
driver which makes things work as well. I will work this out with Geert
hopefully. Would be really great to have this feature without my hack!

That being said, the paragraph above is a bit too long for my taste,
I'll see if I can make it more concise. But it should be there, yes.

Thanks for your support!

Happy hacking,

   Wolfram


--ZbgJohPepknqqfKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmGzN40ACgkQFA3kzBSg
KbYDoA//YzZ1PQZYp3ZV9klerZNz8r6wkg4w72xBlW+3z5JUsxVuJLH+JikBgwpF
t2LiKCBX0MvHX4a9m1q10bhw6p9qGUFSJFT6Q5stfIycnS3r/U9JmMIEyqp09Yd7
Z4IUUjA40wIkMbJI+YZ70iHYTX1StffmIJQBhMgXcXgk8rwhaY8yafBMFTr/aljU
A3SvpD3b+pdIvGomXbOpLfknA4k3+e5U8qQYjdgHfvg4qM6V6DTRUgRjrWVVrcli
PqHNMoj3+g7vtlDjDNaeGYM1Ly+dGP6L/qw0gCb4M2+puRwpfYH2BfIGKQ+mx1Q5
dUZA+pJ/GWZSY29BrATGlMcjTb0NdnFYY3fqudyY3JDJP1oKIxNeaKkKwKodzu/5
32VVChWjVCHXy9qvYleY3GSfbSuq7CfSfWqAatm9gXVyxlGOhSACAsjosibaJqUc
0XoX98DM2Ax2fgShuFwSr+j9MiAmp+/GSeS16W4hk5ZNdlghB1yq26r68pi6oZMN
tml8Jn7ObbwNrfiAeDiT2BaMwxTVgkvyByWY5CZ3iYKNnhFoG06hhnPqPE65yVoZ
dqsRe5II/HI2o0PDQmMfZgmtfpH4zAUZFQjzIoG5JNrGdiGzsed6Fnf+CLNZZBB0
VvgnF15DOm7Js2dVKbkwKG7WpvhekL6JmNuzK/PzIJxUI/+tFlA=
=uTq2
-----END PGP SIGNATURE-----

--ZbgJohPepknqqfKx--
