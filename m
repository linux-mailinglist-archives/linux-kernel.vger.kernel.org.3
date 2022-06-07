Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA45422EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442624AbiFHAzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443323AbiFGXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:00:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C6612FB0C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:08:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyfUe-00024K-VX; Tue, 07 Jun 2022 22:08:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyfUf-0073Ae-5A; Tue, 07 Jun 2022 22:07:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyfUc-00EpcZ-RR; Tue, 07 Jun 2022 22:07:58 +0200
Date:   Tue, 7 Jun 2022 22:07:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20220607200755.tgsrwe4ten5inw27@pengutronix.de>
References: <20220607084551.2735922-1-conor.dooley@microchip.com>
 <20220607084551.2735922-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j5yzesthqmglzibd"
Content-Disposition: inline
In-Reply-To: <20220607084551.2735922-2-conor.dooley@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j5yzesthqmglzibd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 07, 2022 at 09:45:51AM +0100, Conor Dooley wrote:
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 ++
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 289 +++++++++++++++++++++++++++++++
>  3 files changed, 300 insertions(+)
>  create mode 100644 drivers/pwm/pwm-microchip-core.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..a651848e444b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -383,6 +383,16 @@ config PWM_MEDIATEK
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-mediatek.
> =20
> +config PWM_MICROCHIP_CORE
> +	tristate "Microchip corePWM PWM support"
> +	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
> +	depends on HAS_IOMEM && OF
> +	help
> +	  PWM driver for Microchip FPGA soft IP core.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-microchip-core.
> +
>  config PWM_MXS
>  	tristate "Freescale MXS PWM support"
>  	depends on ARCH_MXS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..d29754c20f91 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
> +obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
> diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip=
-core.c
> new file mode 100644
> index 000000000000..2cc1de163bcc
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * corePWM driver for Microchip FPGAs
> + *
> + * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
> + * Author: Conor Dooley <conor.dooley@microchip.com>
> + *

Is there a public datasheet for that hardware? If yes, please add a link
here.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/math.h>
> +
> +#define PREG_TO_VAL(PREG) ((PREG) + 1)
> +
> +#define PRESCALE_REG	0x00u
> +#define PERIOD_REG	0x04u
> +#define PWM_EN_LOW_REG	0x08u
> +#define PWM_EN_HIGH_REG	0x0Cu
> +#define SYNC_UPD_REG	0xE4u
> +#define POSEDGE_OFFSET	0x10u
> +#define NEGEDGE_OFFSET	0x14u
> +#define CHANNEL_OFFSET	0x08u

Can you please prefix these register symbols with a driver prefix?
Unique register names are good for tools like ctags and then it's
obvious to the reader, that the defines are driver specific.

> +struct mchp_core_pwm_registers {
> +	u8 posedge;
> +	u8 negedge;
> +	u8 period_steps;
> +	u8 prescale;

these are the four registers for each channel, right? Can you add a
short overview how these registers define the resulting output wave.

> +};
> +
> +struct mchp_core_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	struct mchp_core_pwm_registers *regs;
> +};
> +
> +static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chi=
p *chip)
> +{
> +	return container_of(chip, struct mchp_core_pwm_chip, chip);
> +}
> +
> +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 bool enable)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 channel_enable, reg_offset, shift;
> +
> +	/*
> +	 * There are two adjacent 8 bit control regs, the lower reg controls
> +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> +	 * and if so, offset by the bus width.
> +	 */
> +	reg_offset =3D PWM_EN_LOW_REG + (pwm->hwpwm >> 3) * sizeof(u32);
> +	shift =3D pwm->hwpwm > 7 ? pwm->hwpwm - 8 : pwm->hwpwm;
> +
> +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> +	channel_enable &=3D ~(1 << shift);
> +	channel_enable |=3D (enable << shift);
> +
> +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> +}
> +
> +static void mchp_core_pwm_calculate_duty(struct pwm_chip *chip,
> +					 const struct pwm_state *desired_state,
> +					 struct mchp_core_pwm_registers *regs)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 clk_period =3D NSEC_PER_SEC;
> +	u64 duty_steps;
> +
> +	/* Calculate the clk period and then the duty cycle edges */
> +	do_div(clk_period, clk_get_rate(mchp_core_pwm->clk));
> +
> +	duty_steps =3D desired_state->duty_cycle * PREG_TO_VAL(regs->period_ste=
ps);
> +	do_div(duty_steps, (clk_period * PREG_TO_VAL(regs->period_steps)));

Don't divide by a result of a division.

> +	if (desired_state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> +		regs->negedge =3D 0u;
> +		regs->posedge =3D duty_steps;
> +	} else {
> +		regs->posedge =3D 0u;
> +		regs->negedge =3D duty_steps;
> +	}
> +}
> +
> +static void mchp_core_pwm_apply_duty(const u8 channel,
> +				     struct mchp_core_pwm_chip *pwm_chip,
> +				     struct mchp_core_pwm_registers *regs)
> +{
> +	void __iomem *channel_base =3D pwm_chip->base + channel * CHANNEL_OFFSE=
T;
> +
> +	writel_relaxed(regs->posedge, channel_base + POSEDGE_OFFSET);
> +	writel_relaxed(regs->negedge, channel_base + NEGEDGE_OFFSET);
> +}
> +
> +static void mchp_core_pwm_apply_period(struct mchp_core_pwm_chip *pwm_ch=
ip,
> +				       struct mchp_core_pwm_registers *regs)
> +{
> +	writel_relaxed(regs->prescale, pwm_chip->base + PRESCALE_REG);
> +	writel_relaxed(regs->period_steps, pwm_chip->base + PERIOD_REG);
> +}
> +
> +static int mchp_core_pwm_calculate_base(struct pwm_chip *chip,
> +					const struct pwm_state *desired_state,
> +					u8 *period_steps_r, u8 *prescale_r)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 tmp =3D desired_state->period;
> +
> +	/* Calculate the period cycles and prescale value */
> +	tmp *=3D clk_get_rate(mchp_core_pwm->clk);
> +	do_div(tmp, NSEC_PER_SEC);
> +
> +	if (tmp > 65535) {

If a too long period is requested, please configure the biggest possible
period.

> +		dev_err(chip->dev,
> +			"requested prescale exceeds the maximum possible\n");

No error message in .apply() please.

> +		return -EINVAL;
> +	} else if (tmp <=3D 256) {
> +		*prescale_r =3D 0;
> +		*period_steps_r =3D tmp - 1;
> +	} else {
> +		*prescale_r =3D fls(tmp) - 8;
> +		*period_steps_r =3D (tmp >> *prescale_r) - 1;
> +	}

*prescale_r =3D fls(tmp >> 8);
*period_steps_r =3D (tmp >> *prescale_r) - 1;

can be used in both branches with the same result.

> +
> +	return 0;
> +}
> +
> +static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       const struct pwm_state *desired_state)

please s/desired_state/state/ for consistency with other drivers.

> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	struct pwm_state current_state;
> +	u8 period_steps_r, prescale_r;
> +	int ret;
> +	u8 channel =3D pwm->hwpwm;
> +
> +	pwm_get_state(pwm, &current_state);

Please don't call pwm API functions in a PWM driver. Simply use
pwm->state for the previously applied state.

> +	if (desired_state->enabled) {
> +		if (current_state.enabled &&
> +		    current_state.period =3D=3D desired_state->period &&
> +		    current_state.polarity =3D=3D desired_state->polarity) {

If everything is as before, why are you doing something at all?

> +			mchp_core_pwm_calculate_duty(chip, desired_state, mchp_core_pwm->regs=
);
> +			mchp_core_pwm_apply_duty(channel, mchp_core_pwm, mchp_core_pwm->regs);
> +		} else {
> +			ret =3D mchp_core_pwm_calculate_base(chip, desired_state, &period_ste=
ps_r,
> +							   &prescale_r);
> +			if (ret) {
> +				dev_err(chip->dev, "failed to calculate base\n");

mchp_core_pwm_calculate_base might already emit an error message. Apply
shouldn't emit an error message at all.

> +				return ret;
> +			}
> +
> +			mchp_core_pwm->regs->period_steps =3D period_steps_r;
> +			mchp_core_pwm->regs->prescale =3D prescale_r;
> +
> +			mchp_core_pwm_calculate_duty(chip, desired_state, mchp_core_pwm->regs=
);
> +			mchp_core_pwm_apply_duty(channel, mchp_core_pwm, mchp_core_pwm->regs);
> +			mchp_core_pwm_apply_period(mchp_core_pwm, mchp_core_pwm->regs);

Is there a race where e.g. the output is defined by the previous period
and the new duty_cycle?

> +		}
> +
> +		if (mchp_core_pwm->regs->posedge =3D=3D mchp_core_pwm->regs->negedge)
> +			mchp_core_pwm_enable(chip, pwm, false);
> +		else
> +			mchp_core_pwm_enable(chip, pwm, true);

Here is a race: If the PWM is running and it configured to be disabled
with a different duty_cycle/period the duty_cycle/period might be
(shortly) visible on the output with is undesirable.

> +	} else if (!desired_state->enabled) {

This can be simplified to just "} else {"

> +		mchp_core_pwm_enable(chip, pwm, false);
> +	}
> +
> +	return 0;

I think this can be considerably simplified by unrolling the helper
functions.

> +}
> +
> +static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> +				    struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	void __iomem *channel_base =3D mchp_core_pwm->base + pwm->hwpwm * CHANN=
EL_OFFSET;
> +	u64 clk_period =3D NSEC_PER_SEC;
> +	u8 prescale, period_steps, duty_steps;
> +	u8 posedge, negedge;
> +	u16 channel_enabled;
> +
> +	channel_enabled =3D (((u16)readb_relaxed(mchp_core_pwm->base + PWM_EN_H=
IGH_REG) << 8) |
> +		readb_relaxed(mchp_core_pwm->base + PWM_EN_LOW_REG));
> +
> +	posedge =3D readb_relaxed(channel_base + POSEDGE_OFFSET);
> +	negedge =3D readb_relaxed(channel_base + NEGEDGE_OFFSET);
> +
> +	duty_steps =3D abs((s8)posedge - (s8)negedge);
> +	state->polarity =3D negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POL=
ARITY_NORMAL;
> +
> +	prescale =3D readb_relaxed(mchp_core_pwm->base + PRESCALE_REG);
> +	period_steps =3D readb_relaxed(mchp_core_pwm->base + PERIOD_REG);
> +
> +	do_div(clk_period, clk_get_rate(mchp_core_pwm->clk));
> +	state->duty_cycle =3D PREG_TO_VAL(prescale) * clk_period * duty_steps;

Dividing early results in rounding errors.

> +	state->period =3D PREG_TO_VAL(prescale) * clk_period * PREG_TO_VAL(peri=
od_steps);
> +
> +	if (channel_enabled & 1 << pwm->hwpwm)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +}

Have you tested your driver with PWM_DEBUG enabled? The rounding is
wrong here. (The supposed rounding behaviour is that .apply rounds down
and to make .apply(.getstate()) a noop, .get_state() must round up.

If you do something like:

        echo 0 > duty_cycle

        for i in $(seq 10000 -1 1); do
                echo $i > period
        done

        for i in $(seq 1 10000); do
                echo $i > period
        done

        for i in $(seq 10000 -1 1); do
                echo $i > duty_cycle
        done

        for i in $(seq 1 10000); do
                echo $i > duty_cycle
        done

with PWM_DEBUG enabled, you should catch most rounding errors. (Maybe
adapt the boundaries according to your driver's capabilities.)

> +static const struct pwm_ops mchp_core_pwm_ops =3D {
> +	.apply =3D mchp_core_pwm_apply,
> +	.get_state =3D mchp_core_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id mchp_core_of_match[] =3D {
> +	{
> +		.compatible =3D "microchip,corepwm-rtl-v4",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mchp_core_of_match);
> +
> +static int mchp_core_pwm_probe(struct platform_device *pdev)
> +{
> +	struct mchp_core_pwm_chip *mchp_pwm;
> +	struct resource *regs;
> +	int ret;
> +
> +	mchp_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*mchp_pwm), GFP_KERNEL);
> +	if (!mchp_pwm)
> +		return -ENOMEM;
> +
> +	mchp_pwm->regs =3D devm_kzalloc(&pdev->dev, sizeof(*regs), GFP_KERNEL);
> +	if (!mchp_pwm->regs)
> +		return -ENOMEM;

If you make regs not a pointer but embed the structure directly in
struct mchp_core_pwm_chip, you only need a single allocation. Having
said that I wonder if you need to store this in driver data at all.

> +	mchp_pwm->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &reg=
s);
> +	if (IS_ERR(mchp_pwm->base))
> +		return PTR_ERR(mchp_pwm->base);
> +
> +	mchp_pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(mchp_pwm->clk))
> +		return PTR_ERR(mchp_pwm->clk);
> +
> +	ret =3D clk_prepare(mchp_pwm->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to prepare PWM clock\n");
> +
> +	mchp_pwm->chip.dev =3D &pdev->dev;
> +	mchp_pwm->chip.ops =3D &mchp_core_pwm_ops;
> +	mchp_pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	mchp_pwm->chip.of_pwm_n_cells =3D 3;
> +	mchp_pwm->chip.base =3D -1;

Please drop the assignment to base.

> +	mchp_pwm->chip.npwm =3D 16;
> +
> +	ret =3D pwmchip_add(&mchp_pwm->chip);
> +	if (ret < 0)

clk_unprepare missing here.

> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	writel_relaxed(0u, mchp_pwm->base + PWM_EN_LOW_REG);
> +	writel_relaxed(0u, mchp_pwm->base + PWM_EN_HIGH_REG);

What is the effect here? Don't modify the hardware after pwmchip_add().
When that function returns a consumer might already have configured the
hardware.

> +	platform_set_drvdata(pdev, mchp_pwm);

This is unused, please drop.

> +	dev_info(&pdev->dev, "Successfully registered Microchip corePWM\n");
> +
> +	return 0;
> +}
> +
> +static int mchp_core_pwm_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Here you're missing to undo pwmchip_add and clk_prepare.

> +static struct platform_driver mchp_core_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "mchp-core-pwm",
> +		.of_match_table =3D mchp_core_of_match,
> +	},
> +	.probe =3D mchp_core_pwm_probe,
> +	.remove =3D mchp_core_pwm_remove,
> +};
> +module_platform_driver(mchp_core_pwm_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> +MODULE_DESCRIPTION("corePWM driver for Microchip FPGAs");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j5yzesthqmglzibd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKfsBgACgkQwfwUeK3K
7AnKwQf+PqMXxxqh32Clm2cxrlycu/TV8jq2zhtWAqjgY9PAH4Hts7nH7DwRyoai
pzQ3sCRFHWAX6KZ0YpX/h0AS5yEFXsTg0SjoXrTSULFmGuiT8FVla23yG8LGNm5y
OfbGGmY4KsfDJiXkmMy0rNpuuddIKQfIcyXoNfNGWZSAHKEGo0FqwaOkV/OyVIoD
Sh+sEEgIHsIg3KKQ7DOAmU98mvWYufrFke4zL05EBUXyt74Szy6p1CbFOv5KQlCC
mybpGjRwyUS79RsNyTIcxvVhwwkst3rY+baWxLsmovlsbHYIcml8dyl003VItbjh
+ckSyqf9bybAC2rcj1v6dJdeSAYCEg==
=2UJm
-----END PGP SIGNATURE-----

--j5yzesthqmglzibd--
