Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1E490C00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbiAQP6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiAQP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:58:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA7DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:58:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9UOz-00082y-3w; Mon, 17 Jan 2022 16:58:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9UOu-00AqhN-Uz; Mon, 17 Jan 2022 16:58:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9UOt-0007Hq-G6; Mon, 17 Jan 2022 16:58:31 +0100
Date:   Mon, 17 Jan 2022 16:58:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] pwm: Add clock based PWM output driver
Message-ID: <20220117155817.4bu2zwpjijtwlfvi@pengutronix.de>
References: <20211213150335.51888-1-nikita@trvn.ru>
 <20211213150335.51888-3-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ja5m322vwhkhunoy"
Content-Disposition: inline
In-Reply-To: <20211213150335.51888-3-nikita@trvn.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ja5m322vwhkhunoy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 13, 2021 at 08:03:35PM +0500, Nikita Travkin wrote:
> Some systems have clocks exposed to external devices. If the clock
> controller supports duty-cycle configuration, such clocks can be used as
> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> similar way and an "opposite" driver already exists (clk-pwm). Add a
> driver that would enable pwm devices to be used via clk subsystem.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
>=20
> Changes in v2:
>  - Address Uwe's review comments:
>    - Round set clk rate up
>    - Add a description with limitations of the driver
>    - Disable and unprepare clock before removing pwmchip
> ---
>  drivers/pwm/Kconfig   |  10 +++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-clk.c | 143 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 drivers/pwm/pwm-clk.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..daa2491a4054 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -140,6 +140,16 @@ config PWM_BRCMSTB
>  	  To compile this driver as a module, choose M Here: the module
>  	  will be called pwm-brcmstb.c.
> =20
> +config PWM_CLK
> +	tristate "Clock based PWM support"
> +	depends on HAVE_CLK || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for outputs that can be
> +	  muxed to clocks.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-clk.
> +
>  config PWM_CLPS711X
>  	tristate "CLPS711X PWM support"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..4a860103c470 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BERLIN)	+=3D pwm-berlin.o
>  obj-$(CONFIG_PWM_BRCMSTB)	+=3D pwm-brcmstb.o
> +obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
> new file mode 100644
> index 000000000000..55fd320b9c19
> --- /dev/null
> +++ b/drivers/pwm/pwm-clk.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock based PWM controller
> + *
> + * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
> + *
> + * This is an "adapter" driver that allows PWM consumers to use
> + * system clocks with duty cycle control as PWM outputs.
> + *
> + * Limitations:
> + * - There is no way to atomically set both clock rate and
> + *   duty-cycle so glitches are possible when new pwm state
> + *   is applied.
> + * - Period depends on the underlying clock driver and,
> + *   in general, not guaranteed.
> + * - Underlying clock may not be able to give 100%
> + *   duty cycle (constant on) and only set the closest
> + *   possible duty cycle. (e.g. 99.9%)

What about 0%?

 - Periods are not completed on changes in general.
 - Behaviour on disable depends on the underlaying clk, don't assume it
   to provide the inactive level.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +struct pwm_clk_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	bool clk_enabled;
> +};
> +
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
> +	u64 period =3D state->period;
> +	u64 duty_cycle =3D state->duty_cycle;
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled) {
> +			clk_disable(chip->clk);
> +			chip->clk_enabled =3D false;
> +		}
> +		return 0;
> +	} else if (!pwm->state.enabled) {
> +		ret =3D clk_enable(chip->clk);
> +		chip->clk_enabled =3D true;
> +		if (ret)
> +			return ret;

if clk_enable() failed better don't set chip->clk_enabled =3D true;

> +	}
> +
> +	rate =3D DIV_ROUND_UP(NSEC_PER_SEC, period);
> +	ret =3D clk_set_rate(chip->clk, rate);
> +	if (ret)
> +		return ret;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		duty_cycle =3D period - duty_cycle;
> +
> +	ret =3D clk_set_duty_cycle(chip->clk, duty_cycle, period);
> +	if (ret)
> +		return ret;
> +
> +	return ret;

This can be simplified to

	return clk_set_duty_cycle(chip->clk, duty_cycle, period);

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
> +	if (IS_ERR(chip->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk), "Failed to get cl=
ock\n");
> +
> +	chip->chip.dev =3D &pdev->dev;
> +	chip->chip.ops =3D &pwm_clk_ops;
> +	chip->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	chip->chip.of_pwm_n_cells =3D 2;

I'd just skip those two assignments. These are the default, anyhow.
(Assuming you have #pwm-cells =3D <2> in the device tree.)

> +	chip->chip.npwm =3D 1;
> +
> +	ret =3D clk_prepare(chip->clk);
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
> +
> +	ret =3D pwmchip_add(&chip->chip);
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
> +
> +	platform_set_drvdata(pdev, chip);
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ja5m322vwhkhunoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHlkhYACgkQwfwUeK3K
7AmFvwf/V2onUpPqmPGzN4xLkicgCoA5Y68pvwsYlMrJMFgMu5TZ/QrzR19wZn9h
ieyMD/btl6I4ohcahjMF443vXCS0jIamf68RPof/CPZzgi34buJwU8it9SxM5Nze
QuLd583Ih1N1W3t3mWri4pvl1X6HlrwJFL7yOVG2nxKNCb1b+WAAIboDBePyfqX9
HCOoU8Q4MxHTqbA7Kfg1jcvm2okLB0j7vRxKrFTIJ8R+T2ZL2s1/Pji5c/yo7nCH
xDwXU21OQRww6uXFUVH6eUR2i11lRsi3qJUhMS1IjwhsYqT9YkyQyfxYwwCu7j9g
BsvJ1nB0jmkOkxF84dJWD/a50WxaeQ==
=qG5i
-----END PGP SIGNATURE-----

--ja5m322vwhkhunoy--
