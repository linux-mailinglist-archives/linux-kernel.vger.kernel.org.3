Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683B646F670
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhLIWJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhLIWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:09:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B0AC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:05:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvRXa-0002RP-Bg; Thu, 09 Dec 2021 23:05:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvRXX-003f7u-Fl; Thu, 09 Dec 2021 23:05:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvRXW-00051D-0H; Thu, 09 Dec 2021 23:05:22 +0100
Date:   Thu, 9 Dec 2021 23:05:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@pengutronix.de,
        pza@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: Add clock based PWM output driver
Message-ID: <20211209220521.ho54edpxedzffdl4@pengutronix.de>
References: <20211209162020.105255-1-nikita@trvn.ru>
 <20211209162020.105255-3-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ttutiro6uyymh5hx"
Content-Disposition: inline
In-Reply-To: <20211209162020.105255-3-nikita@trvn.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ttutiro6uyymh5hx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Dec 09, 2021 at 09:20:20PM +0500, Nikita Travkin wrote:
> +#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, =
chip)
> +
> +static int pwm_clk_apply(struct pwm_chip *pwm_chip, struct pwm_device *p=
wm,
> +			 const struct pwm_state *state)
> +{
> +	struct pwm_clk_chip *chip =3D to_pwm_clk_chip(pwm_chip);
> +	int ret;
> +	u32 rate;
> +
> +	if (!state->enabled && !pwm->state.enabled)
> +		return 0;
> +
> +	if (state->enabled && !pwm->state.enabled) {
> +		ret =3D clk_enable(chip->clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!state->enabled && pwm->state.enabled) {
> +		clk_disable(chip->clk);
> +		return 0;
> +	}

This can be written a bit more compact as:

	if (!state->enabled) {
		if (pwm->state.enabled)
			clk_disable(chip->clk);
		return 0;
	} else if (!pwm->state.enabled) {
		ret =3D clk_enable(chip->clk);
		if (ret)
			return ret;
	}

personally I find my version also easier to read, but that might be
subjective.

Missing handling for polarity. Either refuse inverted polarity, or set
the duty_cycle to state->period - state->duty_cycle in the inverted
case.

> +	rate =3D div64_u64(NSEC_PER_SEC, state->period);

Please round up here, as .apply() should never implement a period bigger
than requested. This also automatically improves the behaviour if
state->period > NSEC_PER_SEC.

> +	ret =3D clk_set_rate(chip->clk, rate);
> +	if (ret)
> +		return ret;
> +
> +	return clk_set_duty_cycle(chip->clk, state->duty_cycle, state->period);

Is it possible to enable only after the duty cycle is set? This way we
could prevent in some cases that a wrong setting makes it to the output.

As there is not a single function to set rate (i.e. period) and
duty_cycle it's not possible to prevent all glitches.

Can you please note that in a paragraph at the beginning of the driver
as does e.g. drivers/pwm/pwm-sl28cpld.c. (Please stick to the format,
i.e.  "Limitations:" and then all items without an empty line, to make
this greppable.)

> +}
> +
> +static const struct pwm_ops pwm_clk_ops =3D {
> +	.apply =3D pwm_clk_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int pwm_clk_probe(struct platform_device *pdev)
> +{
> +	struct pwm_clk_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(chip->clk)) {
> +		dev_err(&pdev->dev, "Failed to get clock: %ld\n", PTR_ERR(chip->clk));
> +		return PTR_ERR(chip->clk);

Please use dev_err_probe() here and in the other error paths below.

> +	}
> +
> +	chip->chip.dev =3D &pdev->dev;
> +	chip->chip.ops =3D &pwm_clk_ops;
> +	chip->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	chip->chip.of_pwm_n_cells =3D 2;
> +	chip->chip.base =3D 0;

Please drop this line (see commit f9a8ee8c8bcd)

> +	chip->chip.npwm =3D 1;
> +
> +	ret =3D clk_prepare(chip->clk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to prepare clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D pwmchip_add(&chip->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add pwm chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, chip);
> +	return 0;
> +}
> +
> +static int pwm_clk_remove(struct platform_device *pdev)
> +{
> +	struct pwm_clk_chip *chip =3D platform_get_drvdata(pdev);
> +
> +	clk_unprepare(chip->clk);
> +
> +	pwmchip_remove(&chip->chip);

This is bad. clk_unprepare() stops the output which must not happen
before pwmchip_remove() returns. What happens if the PWM (and so the
clk) is still on and you call clk_unprepare? Is this allowed at all if
the enable count might be > 0?

> +	return 0;
> +}
> +
> +static const struct of_device_id pwm_clk_dt_ids[] =3D {
> +	{ .compatible =3D "clk-pwm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_clk_dt_ids);
> +
> +static struct platform_driver pwm_clk_driver =3D {
> +	.driver =3D {
> +		.name =3D "clk-pwm",

Hmm, is this name sane? I would have expected that a driver called
"clk-pwm" exposes a clk using a PWM. OTOH there is a "pwm-clock" driver
that does exactly that. To complete the confusion the function prefix of
said driver is clk_pwm_ and this one used pwm_clk_ ...

> +		.of_match_table =3D pwm_clk_dt_ids,
> +	},
> +	.probe =3D pwm_clk_probe,
> +	.remove =3D pwm_clk_remove,
> +};
> +module_platform_driver(pwm_clk_driver);
> +
> +MODULE_ALIAS("platform:clk-pwm");
> +MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
> +MODULE_DESCRIPTION("Clock based PWM driver");
> +MODULE_LICENSE("GPL v2");

MODULE_LICENSE("GPL");

is the more usual today (and has the same meaning).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ttutiro6uyymh5hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGyfZ4ACgkQwfwUeK3K
7AmmfwgAn/L8nXaCNoA4Va34xDb0ppsFJnItJI/th85XEf/G+FOq4c6MM0AFigGN
TxaLq1l8KKfydDRWBbHdUS3CblNF5wRdQQGfo3hrfeAYW8e2R25M5RzTU8sjKwGZ
RxdgjVg6VcSgPp4bd0Rvr1xy7ZyruHup9Pb/rNWDb9kq0YW7qjqFX0HX2Pm77YjW
0we8MA3rsq1lJ3pdThGZ24nhM/RoiSuakOrzqS1OC7TpBIL0ciZgDp+E1QvuJSJJ
ET4ZZ7O1KNMPQVlgFCvfu8nmZ7LyFevJ9LmwBEJJB+Yc3tuP2QIiMGt7BxX46Kl1
Frjbj/JFKlY2jKTMm40/akjR84Tw9g==
=rTdx
-----END PGP SIGNATURE-----

--ttutiro6uyymh5hx--
