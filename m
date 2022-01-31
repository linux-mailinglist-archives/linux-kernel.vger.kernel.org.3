Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27864A4907
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378271AbiAaOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351340AbiAaOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:10:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D73FC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:10:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nEXNy-0003P3-Sj; Mon, 31 Jan 2022 15:10:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nEXNx-00Ddmm-HI; Mon, 31 Jan 2022 15:10:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nEXNw-002atb-1e; Mon, 31 Jan 2022 15:10:24 +0100
Date:   Mon, 31 Jan 2022 15:10:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        michal.simek@xilinx.com, Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <20220131141023.higpnrseko2wzyeo@pengutronix.de>
References: <20211217233015.67664-1-sean.anderson@seco.com>
 <20211217233015.67664-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fzz4kv5hky26tqn3"
Content-Disposition: inline
In-Reply-To: <20211217233015.67664-2-sean.anderson@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fzz4kv5hky26tqn3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

first of all: Sorry for taking so long for the next review round.

> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/time=
r.c
> index f8832cf49384..26c385582c3b 100644
> --- a/arch/microblaze/kernel/timer.c
> +++ b/arch/microblaze/kernel/timer.c
> @@ -251,6 +251,10 @@ static int __init xilinx_timer_init(struct device_no=
de *timer)
>  	u32 timer_num =3D 1;
>  	int ret;
> =20
> +	/* If this property is present, the device is a PWM and not a timer */
> +	if (of_property_read_bool(timer, "#pwm-cells"))
> +		return 0;
> +
>  	if (initialized)
>  		return -EINVAL;
> =20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..cefbf00b4c7e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -640,4 +640,18 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
> =20
> +config PWM_XILINX
> +	tristate "Xilinx AXI Timer PWM support"
> +	depends on OF_ADDRESS
> +	depends on COMMON_CLK
> +	select REGMAP_MMIO
> +	help
> +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
> +	  typically a soft core which may be present in Xilinx FPGAs.
> +	  This device may also be present in Microblaze soft processors.
> +	  If you don't have this IP in your design, choose N.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-xilinx.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..ea785480359b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX)	+=3D pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..b4d93e8812c6
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we may end up with one cy=
cle
> + *   with the old duty cycle and the new period. This is because the cou=
nters
> + *   may only be reloaded by first stopping them, or by letting them be
> + *   automatically reloaded at the end of a cycle. If this automatic rel=
oad
> + *   happens after we set TLR0 but before we set TLR1 then we will have a
> + *   bad cycle. This could probably be fixed by reading TCR0 just before
> + *   reprogramming, but I think it would add complexity for little gain.
> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might =
be
> + *   possible by stopping the counters at an appropriate point in the cy=
cle,
> + *   but this is not (yet) implemented.
> + * - Only produces "normal" output.
> + * - Always produces low output if disabled.
> + */
> +
> +#include <clocksource/timer-xilinx.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * The following functions are "common" to drivers for this device, and =
may be
> + * exported at a future date.
> + */
> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
> +			    u64 cycles)
> +{
> +	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
> +
> +	if (tcsr & TCSR_UDT)
> +		return cycles - 2;
> +	return priv->max - cycles + 2;
> +}
> +
> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +				     u32 tlr, u32 tcsr)
> +{
> +	u64 cycles;
> +
> +	if (tcsr & TCSR_UDT)
> +		cycles =3D tlr + 2;
> +	else
> +		cycles =3D (u64)priv->max - tlr + 2;
> +
> +	/* cycles has a max of 2^32 + 2 */

If you add "... so the multiplication doesn't overflow." it becomes more
obvious why this comment is there.

> +	return DIV64_U64_ROUND_UP(cycles * NSEC_PER_SEC,
> +				  clk_get_rate(priv->clk));
> +}
> +
> +/*
> + * The idea here is to capture whether the PWM is actually running (e.g.
> + * because we or the bootloader set it up) and we need to be careful to =
ensure
> + * we don't cause a glitch. According to the data sheet, to enable the P=
WM we
> + * need to
> + *
> + * - Set both timers to generate mode (MDT=3D1)
> + * - Set both timers to PWM mode (PWMA=3D1)
> + * - Enable the generate out signals (GENT=3D1)
> + *
> + * In addition,
> + *
> + * - The timer must be running (ENT=3D1)
> + * - The timer must auto-reload TLR into TCR (ARHT=3D1)
> + * - We must not be in the process of loading TLR into TCR (LOAD=3D0)
> + * - Cascade mode must be disabled (CASC=3D0)
> + *
> + * If any of these differ from usual, then the PWM is either disabled, o=
r is
> + * running in a mode that this driver does not support.
> + */
> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
> +
> +struct xilinx_pwm_device {
> +	struct pwm_chip chip;
> +	struct xilinx_timer_priv priv;
> +};
> +
> +static inline struct xilinx_timer_priv
> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
> +{
> +	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
> +}
> +
> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
> +{
> +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) =3D=3D TCSR_PWM_SET &&
> +		(TCSR_PWM_MASK & tcsr1) =3D=3D TCSR_PWM_SET;
> +}
> +
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *un=
used,
> +			    const struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +	u64 period_cycles, duty_cycles;
> +	unsigned long rate;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/*
> +	 * To be representable by TLR, cycles must be between 2 and
> +	 * priv->max + 2. To enforce this we can reduce the cycles, but we may
> +	 * not increase them. Caveat emptor: while this does result in more
> +	 * predictable rounding, it may also result in a completely different
> +	 * duty cycle (% high time) than what was requested.
> +	 */
> +	rate =3D clk_get_rate(priv->clk);
> +	/* Avoid overflow */
> +	period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);

on a 64 bit platform ULONG_MAX * NSEC_PER_SEC doesn't fit into an u64
=2E.. I think if you replace ULONG_MAX by U32_MAX it works as intended.

> +	period_cycles =3D mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
> +	period_cycles =3D min_t(u64, period_cycles, priv->max + 2);
> +	if (period_cycles < 2)
> +		return -ERANGE;
> +
> +[...]
> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *unused,
> +				 struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +
> +	regmap_read(priv->map, TLR0, &tlr0);
> +	regmap_read(priv->map, TLR1, &tlr1);
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	state->period =3D xilinx_timer_get_period(priv, tlr0, tcsr0);
> +	state->duty_cycle =3D xilinx_timer_get_period(priv, tlr1, tcsr1);
> +	state->enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	/* 100% duty cycle results in constant low output */
> +	if (state->period =3D=3D state->duty_cycle)

There is a corner case: It can happen that
xilinx_timer_get_period(priv, tlr0, tcsr0) =3D=3D
xilinx_timer_get_period(priv, tlr1, tcsr1) but not tlr0 =3D=3D tlr1.

This only happens for clkrate > 1000000000, but given that the fix is
cheap (i.e. check tlr0 =3D=3D tlr1 instead of state->period =3D=3D
state->duty_cycle) I'd suggest to do that.

> +		state->duty_cycle =3D 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fzz4kv5hky26tqn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmH37cwACgkQwfwUeK3K
7AkyGAf/czu3xPTY1ToME154XhaEhmSNieuaYTY7kwP13sI75F/glmV0FGUeOYVC
ovi/zZx9Xy+9/+lODE7uqWLCG78bi54WxapRxuV3IBCTB0NY0RYdhDvhYs/m/4Cd
Yj34jyz7LR8jyBGWq5Tw0QwwwQ6+n/2ykMkq5XQMuhYtUwwHgvb29F5cWXo3RBhR
k0rQu0L6zHaCmF0fJJNCVTg37Ba+TcvjBT/3Xl6yLMNf2Bm/Wxk2+awiXPFA70ab
SNtFB8ws4gw1eINf5JmIkjQNuZho6GXNSMFJAlLZ56Hx+tBVPwg+SGxqY9DvP8e3
p3yD+tpmp739nadHZVBqqGElP9M1Zg==
=bMnM
-----END PGP SIGNATURE-----

--fzz4kv5hky26tqn3--
