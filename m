Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32398462753
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhK2XCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhK2XAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A160AC043AF3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 12:52:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrndF-0001H9-9a; Mon, 29 Nov 2021 21:52:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrnd1-001nbP-Cy; Mon, 29 Nov 2021 21:51:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrnd0-0003gn-Bn; Mon, 29 Nov 2021 21:51:58 +0100
Date:   Mon, 29 Nov 2021 21:51:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, lee.jones@linaro.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20211129205154.jtm4ehvvfo52toth@pengutronix.de>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
 <20211129064329.27006-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltrr7wjbtue7nf5u"
Content-Disposition: inline
In-Reply-To: <20211129064329.27006-3-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ltrr7wjbtue7nf5u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

just two minor thing left to criticise:

On Mon, Nov 29, 2021 at 02:43:29PM +0800, Billy Tsai wrote:
> +	if (clk_en && duty_pt) {
> +		dividend =3D (u64)NSEC_PER_SEC * (div_l + 1) * duty_pt
> +				 << div_h;
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(dividend, rate);
> +	} else
> +		state->duty_cycle =3D clk_en ? state->period : 0;

I wonder about checkpatch not criticising this construct. See
Documentation/process/coding-style.rst:

	Do not unnecessarily use braces where a single statement will
	do. [...] This does not apply if only one branch of a
	conditional statement is a single statement; in the latter case
	use braces in both branches

> [...]
> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 hwpwm =3D pwm->hwpwm, duty_pt;
> +	unsigned long rate;
> +	u64 div_h, div_l, divisor, expect_period;
> +	bool clk_en;
> +
> +	expect_period =3D state->period;
> +	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", expect_period,
> +		state->duty_cycle);
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	if (expect_period > div64_u64(ULLONG_MAX, (u64)rate))
> +		expect_period =3D div64_u64(ULLONG_MAX, (u64)rate);

If you write that as

	expect_period =3D min(div64_u64(ULLONG_MAX, (u64)rate), expect_period);

you make sure that the division is only calculated once.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ltrr7wjbtue7nf5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGlPWcACgkQwfwUeK3K
7Ak8pwf/f38P/ANk72PoQ6XaxGN4JtL+YI2d3Fnkk/akQZog/rZXoqAqA+vpeUZN
ZCP6kfvy1afZmpmJZ5/A7IcEVbx63vryrJDubwJBpEjW+XQ7zUEIkWviTmmfgtbf
d4alL1S8iU6oPpM4ijAZi+AUbwOkzu0mLEW6Cvx/EPJaahmLxWTUjip+WVgEN3XW
CbrXaQCNLjX2E+OE/ddOC2kCwGJjM8eOjoMl7xZ6gL0mEMyyQpReIxDKuUUK3PSA
RhTGOVEP0CVoksgQaMf8X5aKQvbQqzlS0/Tpinpb2sPTeefRouahOsqb5aieNsbH
qrCFLTc6x3uQByyGnIUj9364lD8/5A==
=/Kh7
-----END PGP SIGNATURE-----

--ltrr7wjbtue7nf5u--
