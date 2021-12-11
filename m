Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA154714C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 17:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhLKQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 11:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhLKQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 11:33:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A9C061751
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 08:33:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mw5JK-00055E-J5; Sat, 11 Dec 2021 17:33:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mw5JG-003zLa-LX; Sat, 11 Dec 2021 17:33:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mw5JF-0007nU-Kr; Sat, 11 Dec 2021 17:33:17 +0100
Date:   Sat, 11 Dec 2021 17:33:14 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        kernel@pengutronix.de, pza@pengutronix.de, lee.jones@linaro.org,
        masneyb@onstation.org
Subject: Re: [PATCH 2/2] pwm: Add clock based PWM output driver
Message-ID: <20211211163314.azn562syhybmjk6q@pengutronix.de>
References: <20211209162020.105255-1-nikita@trvn.ru>
 <20211209162020.105255-3-nikita@trvn.ru>
 <20211209220521.ho54edpxedzffdl4@pengutronix.de>
 <2d88f192dfbf1fdc1c5bbb23cf85857e@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wc64e6udmdaf433d"
Content-Disposition: inline
In-Reply-To: <2d88f192dfbf1fdc1c5bbb23cf85857e@trvn.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wc64e6udmdaf433d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 10, 2021 at 06:13:34PM +0500, Nikita Travkin wrote:
> Uwe Kleine-K=C3=B6nig =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 10.12.2021 0=
3:05:
> > Hello,
> >=20
> > On Thu, Dec 09, 2021 at 09:20:20PM +0500, Nikita Travkin wrote:
> >> +#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chi=
p, chip)
> >> +
> >> +static int pwm_clk_apply(struct pwm_chip *pwm_chip, struct pwm_device=
 *pwm,
> >> +			 const struct pwm_state *state)
> >> +{
> >> +	struct pwm_clk_chip *chip =3D to_pwm_clk_chip(pwm_chip);
> >> +	int ret;
> >> +	u32 rate;
> >> +
> >> +	if (!state->enabled && !pwm->state.enabled)
> >> +		return 0;
> >> +
> >> +	if (state->enabled && !pwm->state.enabled) {
> >> +		ret =3D clk_enable(chip->clk);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >> +	if (!state->enabled && pwm->state.enabled) {
> >> +		clk_disable(chip->clk);
> >> +		return 0;
> >> +	}
> >=20
> > This can be written a bit more compact as:
> >=20
> > 	if (!state->enabled) {
> > 		if (pwm->state.enabled)
> > 			clk_disable(chip->clk);
> > 		return 0;
> > 	} else if (!pwm->state.enabled) {
> > 		ret =3D clk_enable(chip->clk);
> > 		if (ret)
> > 			return ret;
> > 	}
> >=20
> > personally I find my version also easier to read, but that might be
> > subjective.
>=20
> Having three discrete checks for three possible outcomes is a bit
> easier for me to understand, but I have no preference and can change
> it to your version.=20
>=20
> > Missing handling for polarity. Either refuse inverted polarity, or set
> > the duty_cycle to state->period - state->duty_cycle in the inverted
> > case.
>=20
> Will add the latter.
>=20
> >=20
> >> +	rate =3D div64_u64(NSEC_PER_SEC, state->period);
> >=20
> > Please round up here, as .apply() should never implement a period bigger
> > than requested. This also automatically improves the behaviour if
> > state->period > NSEC_PER_SEC.
>=20
> Will do. I'm not sure if the underlying clock drivers guarantee the
> chosen rate to be rounded in line with that however, e.g. qcom SoC

This is a problem that most drivers have. Very few use clk_set_rate, but
also clk_get_rate is subject to (much smaller) rounding issues.
There doesn't seem to be an agreement that this is important enough to
address.

> clocks that I target use lookup tables to find the closest rate
> with known M/N config values and set that. (So unless one makes sure
> the table has all the required rates, period is not guaranteed.)
>=20
> This is not an issue for my use cases though: Don't think any
> of the led or haptic motor controllers I've seen in my devices
> need a perfect rate.
>=20
> I think this is another line into the "Limitations" description
> that was suggested later.
>=20
> >=20
> >> +	ret =3D clk_set_rate(chip->clk, rate);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return clk_set_duty_cycle(chip->clk, state->duty_cycle, state->perio=
d);
> >=20
> > Is it possible to enable only after the duty cycle is set? This way we
> > could prevent in some cases that a wrong setting makes it to the output.
> >=20
>=20
> Will move clk_enable() as the last action. After that it makes more
> sense to "squash" two leftover checks for disabled state so will do
> that as well.
>=20
> ... Except moving it caused a nice big WARNING from my clock controller...
>=20
> [   76.353557] gcc_camss_gp1_clk status stuck at 'off'
> [   76.353593] WARNING: CPU: 2 PID: 97 at drivers/clk/qcom/clk-branch.c:9=
1 clk_branch_wait+0x144/0x160
> (...)
> [   76.571531] Call trace:
> [   76.578644]  clk_branch_wait+0x144/0x160
> [   76.580903]  clk_branch2_enable+0x34/0x44
> [   76.585069]  clk_core_enable+0x6c/0xc0
> [   76.588974]  clk_enable+0x30/0x50
> [   76.592620]  pwm_clk_apply+0xb0/0xe4
> [   76.596007]  pwm_apply_state+0x6c/0x1ec
> [   76.599651]  sgm3140_brightness_set+0xb4/0x190 [leds_sgm3140]
>=20
> (Which doesn't stop it from working afaict, but very much undesirable
> for me.)
> Unsure if this is something common or just a quirk of this specific
> driver but I'd rather take a little glitch on the output than
> make clock driver unhappy knowing how picky this hardware sometimes is...

I think clk_set_rate for a disabled clk isn't well defined.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wc64e6udmdaf433d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmG00sYACgkQwfwUeK3K
7Alwagf/TNj+NPSBwOGmiIUsxBSdyPzfOA2mg/3/P/jOq+i2zG1Kes9jPVbGWXVL
W8fIh8M2kvkSGy6ubbmHb6jE2Kj/5ya78BNAMALrmOWP08SFDy1ZwsSOQgCPfNpj
reFmScHzSG90EKRIeurKzL0xCifQt+Ht9sUtyyJq9c6m7LlC8OTq9Yu6HZS4mU2Z
E9AuEQSvxXMovsrN9NDc+L3AnkE8S1vbT3Mw9j6iqnaQmLkie2CK4JOlOv9GfUIG
/QOLKDztqTX7MyY4PknBEKG4ARIZZIDko20GcRP2IRQiVnCk4+HW/sZmnl4stzHK
OiCRMPbudUyTSx7tDscINAMiYFOGqQ==
=b9KV
-----END PGP SIGNATURE-----

--wc64e6udmdaf433d--
