Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0149CEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbiAZPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiAZPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:36:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB232C06176A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:35:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nCkKk-0004Py-Ra; Wed, 26 Jan 2022 16:35:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nCkKi-00CZVO-Bj; Wed, 26 Jan 2022 16:35:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nCkKg-001Xem-PU; Wed, 26 Jan 2022 16:35:38 +0100
Date:   Wed, 26 Jan 2022 16:35:35 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, thierry.reding@gmail.com,
        lee.jones@linaro.org, robh+dt@kernel.org, sboyd@kernel.org,
        linus.walleij@linaro.org, masneyb@onstation.org,
        sean.anderson@seco.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 2/2] pwm: Add clock based PWM output driver
Message-ID: <20220126153535.jg4kidtvlfb6aplt@pengutronix.de>
References: <20220126125849.75572-1-nikita@trvn.ru>
 <20220126125849.75572-3-nikita@trvn.ru>
 <2c65c342-5c04-bcf4-fd75-5c11d26f0b33@kernel.org>
 <72e076e7d0612667d503cb1196abb3c7@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qpmcfclpfl3al6m5"
Content-Disposition: inline
In-Reply-To: <72e076e7d0612667d503cb1196abb3c7@trvn.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qpmcfclpfl3al6m5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 26, 2022 at 06:35:15PM +0500, Nikita Travkin wrote:
> Krzysztof Kozlowski =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 26.01.2022 18:=
18:
> > On 26/01/2022 13:58, Nikita Travkin wrote:
> >> Some systems have clocks exposed to external devices. If the clock
> >> controller supports duty-cycle configuration, such clocks can be used =
as
> >> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> >> similar way and an "opposite" driver already exists (clk-pwm). Add a
> >> driver that would enable pwm devices to be used via clk subsystem.
> >>
> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> >> --
> >>
> >> Changes in v2:
> >>  - Address Uwe's review comments:
> >>    - Round set clk rate up
> >>    - Add a description with limitations of the driver
> >>    - Disable and unprepare clock before removing pwmchip
> >> Changes in v3:
> >>  - Use 64bit version of div round up
> >>  - Address Uwe's review comments:
> >>    - Reword the limitations to avoid incorrect claims
> >>    - Move the clk_enabled flag assignment
> >>    - Drop unnecessary statements
> >> ---
> >>  drivers/pwm/Kconfig   |  10 +++
> >>  drivers/pwm/Makefile  |   1 +
> >>  drivers/pwm/pwm-clk.c | 139 ++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 150 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-clk.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 21e3b05a5153..daa2491a4054 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -140,6 +140,16 @@ config PWM_BRCMSTB
> >>  	  To compile this driver as a module, choose M Here: the module
> >>  	  will be called pwm-brcmstb.c.
> >>
> >> +config PWM_CLK
> >> +	tristate "Clock based PWM support"
> >> +	depends on HAVE_CLK || COMPILE_TEST
> >> +	help
> >> +	  Generic PWM framework driver for outputs that can be
> >> +	  muxed to clocks.
> >> +
> >> +	  To compile this driver as a module, choose M here: the module
> >> +	  will be called pwm-clk.
> >> +
> >>  config PWM_CLPS711X
> >>  	tristate "CLPS711X PWM support"
> >>  	depends on ARCH_CLPS711X || COMPILE_TEST
> >> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >> index 708840b7fba8..4a860103c470 100644
> >> --- a/drivers/pwm/Makefile
> >> +++ b/drivers/pwm/Makefile
> >> @@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
> >>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> >>  obj-$(CONFIG_PWM_BERLIN)	+=3D pwm-berlin.o
> >>  obj-$(CONFIG_PWM_BRCMSTB)	+=3D pwm-brcmstb.o
> >> +obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
> >>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
> >>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
> >>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> >> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
> >> new file mode 100644
> >> index 000000000000..b3bfa12a0e73
> >> --- /dev/null
> >> +++ b/drivers/pwm/pwm-clk.c
> >> @@ -0,0 +1,139 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Clock based PWM controller
> >> + *
> >> + * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
> >> + *
> >> + * This is an "adapter" driver that allows PWM consumers to use
> >> + * system clocks with duty cycle control as PWM outputs.
> >> + *
> >> + * Limitations:
> >> + * - Glitches are possible when new pwm state is applied.
> >> + * - Due to the fact that exact behavior depends on the underlying
> >> + *   clock driver, various limitations are possible.
> >> + * - Period depends on the clock and, in general, not guaranteed.
> >> + * - Underlying clock may not be able to give 0% or 100% duty cycle
> >> + *   (constant off or on), exact behavior will depend on the clock.
> >> + * - When the PWM is disabled, the clock will be disabled as well,
> >> + *   line state will depend on the clock.
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/math64.h>
> >> +#include <linux/err.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/pwm.h>
> >> +
> >> +struct pwm_clk_chip {
> >> +	struct pwm_chip chip;
> >> +	struct clk *clk;
> >> +	bool clk_enabled;
> >> +};
> >> +
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
> >> +	u64 period =3D state->period;
> >> +	u64 duty_cycle =3D state->duty_cycle;
> >> +
> >> +	if (!state->enabled) {
> >> +		if (pwm->state.enabled) {
> >> +			clk_disable(chip->clk);
> >> +			chip->clk_enabled =3D false;
> >> +		}
> >> +		return 0;
> >> +	} else if (!pwm->state.enabled) {
> >> +		ret =3D clk_enable(chip->clk);
> >> +		if (ret)
> >> +			return ret;
> >> +		chip->clk_enabled =3D true;
> >> +	}
> >> +
> >> +	rate =3D DIV64_U64_ROUND_UP(NSEC_PER_SEC, period);
> >> +	ret =3D clk_set_rate(chip->clk, rate);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> >> +		duty_cycle =3D period - duty_cycle;
> >> +
> >> +	return clk_set_duty_cycle(chip->clk, duty_cycle, period);
> >> +}
> >> +
> >> +static const struct pwm_ops pwm_clk_ops =3D {
> >> +	.apply =3D pwm_clk_apply,
> >> +	.owner =3D THIS_MODULE,
> >> +};
> >> +
> >> +static int pwm_clk_probe(struct platform_device *pdev)
> >> +{
> >> +	struct pwm_clk_chip *chip;
> >> +	int ret;
> >> +
> >> +	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> >> +	if (!chip)
> >> +		return -ENOMEM;
> >> +
> >> +	chip->clk =3D devm_clk_get(&pdev->dev, NULL);
> >> +	if (IS_ERR(chip->clk))
> >> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk),
> >> +				     "Failed to get clock\n");
> >> +
> >> +	chip->chip.dev =3D &pdev->dev;
> >> +	chip->chip.ops =3D &pwm_clk_ops;
> >> +	chip->chip.npwm =3D 1;
> >> +
> >> +	ret =3D clk_prepare(chip->clk);
> >> +	if (ret < 0)
> >> +		dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
> >> +
> >> +	ret =3D pwmchip_add(&chip->chip);
> >> +	if (ret < 0)
> >> +		dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
> >> +
> >=20
> > What is the point of probing the driver if pwmchip_add() fails? This
> > should be rather fatal error.
> >=20
> > The same with clock. If preparing clock fails, there is little point in
> > enabling/disabling it later.
> >=20
>=20
> Uh oh... Seems like I forgot a return in both cases... For some reason
> I had an incorrect assumption in my mind that dev_err_probe is a macro
> that does the return on it's own, yet I used it correctly just a couple
> of lines earlier...

dev_err_probe returns the error code, so

	return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");

is the right magic.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qpmcfclpfl3al6m5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHxakMACgkQwfwUeK3K
7AnoSAf/fYgJgvnhcdVWyXSTQ8GlwZjujkSall8gDPV51etgdPSsiC1391ovJeeV
lxI5YnwiZMg23WVrzzuGfnRbRaJimMDKOvgeX+BD6OUlvlyfhimI04kZKBmRMT6P
3CwYHuD141Vm9LyutZWKMhhA8Thb2sOy7RLXeUaVWvfOGZzUZUE6IqTX0cNrHxxC
dB8Hb6/9i24pOQd/MutvIaHzRro67ED94iDeK1n7lvqyw2E9VDutWINMG03YuNXV
O4NvK0PWp1NZ1cH3YSjcmaeh2sdHDdNp59NGgcKY8DewvXHP7xnAJrKLZNVzE/m6
fxkylRcWnT50HGGryAhcuf+wyMw9hQ==
=An41
-----END PGP SIGNATURE-----

--qpmcfclpfl3al6m5--
