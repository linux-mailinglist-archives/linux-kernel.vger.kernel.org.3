Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D5E58794C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiHBIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiHBIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:46:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C24D4D3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:46:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oInXi-0008Vq-3H; Tue, 02 Aug 2022 10:46:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oInXg-001HUQ-3t; Tue, 02 Aug 2022 10:46:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oInXf-0095jc-ET; Tue, 02 Aug 2022 10:46:19 +0200
Date:   Tue, 2 Aug 2022 10:46:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, thierry.reding@gmail.com
Subject: Re: [PATCH v7 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220802084619.wunl3nglcpgo6j5i@pengutronix.de>
References: <20220721172109.941900-1-mail@conchuod.ie>
 <20220721172109.941900-4-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="alyi4teih5urcnmb"
Content-Disposition: inline
In-Reply-To: <20220721172109.941900-4-mail@conchuod.ie>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--alyi4teih5urcnmb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jul 21, 2022 at 06:21:09PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 371 +++++++++++++++++++++++++++++++
>  3 files changed, 382 insertions(+)
>  create mode 100644 drivers/pwm/pwm-microchip-core.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 904de8d61828..007ea5750e73 100644
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
> index 5c08bdb817b4..43feb7cfc66a 100644
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
> index 000000000000..2d12248f86b8
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * corePWM driver for Microchip "soft" FPGA IP cores.
> + *
> + * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
> + * Author: Conor Dooley <conor.dooley@microchip.com>
> + * Documentation:
> + * https://www.microsemi.com/document-portal/doc_download/1245275-corepw=
m-hb
> + *
> + * Limitations:
> + * - If the IP block is configured without "shadow registers", all regis=
ter
> + *   writes will take effect immediately, causing glitches on the output.
> + *   If shadow registers *are* enabled, a write to the "SYNC_UPDATE" reg=
ister
> + *   notifies the core that it needs to update the registers defining the
> + *   waveform from the contents of the "shadow registers".
> + * - The IP block has no concept of a duty cycle, only rising/falling ed=
ges of
> + *   the waveform. Unfortunately, if the rising & falling edges register=
s have
> + *   the same value written to them the IP block will do whichever of a =
rising
> + *   or a falling edge is possible. I.E. a 50% waveform at twice the req=
uested
> + *   period. Therefore to get a 0% waveform, the output is set the max h=
igh/low
> + *   time depending on polarity.
> + * - The PWM period is set for the whole IP block not per channel. The d=
river
> + *   will only change the period if no other PWM output is enabled.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define PREG_TO_VAL(PREG) ((PREG) + 1)
> +
> +#define MCHPCOREPWM_PRESCALE_MAX	0x100
> +#define MCHPCOREPWM_PERIOD_STEPS_MAX	0xff
> +#define MCHPCOREPWM_PERIOD_MAX		0xff00
> +
> +#define MCHPCOREPWM_PRESCALE	0x00
> +#define MCHPCOREPWM_PERIOD	0x04
> +#define MCHPCOREPWM_EN(i)	(0x08 + 0x04 * (i)) /* 0x08, 0x0c */
> +#define MCHPCOREPWM_POSEDGE(i)	(0x10 + 0x08 * (i)) /* 0x10, 0x18, ..., 0=
x88 */
> +#define MCHPCOREPWM_NEGEDGE(i)	(0x14 + 0x08 * (i)) /* 0x14, 0x1c, ..., 0=
x8c */
> +#define MCHPCOREPWM_SYNC_UPD	0xe4
> +
> +struct mchp_core_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct mutex lock; /* protect the shared period */
> +	void __iomem *base;
> +	u32 sync_update_mask;
> +	u16 channel_enabled;
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
> +				 bool enable, u64 period)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 channel_enable, reg_offset, shift;
> +
> +	/*
> +	 * There are two adjacent 8 bit control regs, the lower reg controls
> +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> +	 * and if so, offset by the bus width.
> +	 */
> +	reg_offset =3D MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> +	shift =3D pwm->hwpwm & 7;
> +
> +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> +	channel_enable &=3D ~(1 << shift);
> +	channel_enable |=3D (enable << shift);
> +
> +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> +	mchp_core_pwm->channel_enabled &=3D ~BIT(pwm->hwpwm);
> +	mchp_core_pwm->channel_enabled |=3D enable << pwm->hwpwm;
> +
> +	/*
> +	 * Notify the block to update the waveform from the shadow registers.
> +	 * The updated values will not appear on the bus until they have been
> +	 * applied to the waveform at the beginning of the next period. We must
> +	 * write these registers and wait for them to be applied before calling
> +	 * enable().

What does "calling enable()" mean? There is no such function or callback
with that name?!

> +	 */
> +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> +		usleep_range(period, period * 2);

So if period =3D 5000 *ns* you sleep between 5000 and 10000 *us* here?

> +	}
> +}
> +
> +static u64 mchp_core_pwm_calc_duty(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   const struct pwm_state *state, u8 prescale, u8 period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 duty_steps, period, tmp;
> +	u16 prescale_val =3D PREG_TO_VAL(prescale);
> +	u8 period_steps_val =3D PREG_TO_VAL(period_steps);

Can it happen that period_steps is 0xff? Then period_steps_val ends up
being 0.

> +
> +	period =3D period_steps_val * prescale_val * NSEC_PER_SEC;
> +	period =3D DIV64_U64_ROUND_UP(period, clk_get_rate(mchp_core_pwm->clk));

The value you are calculating for period isn't used?!

> +
> +	/*
> +	 * Calculate the duty cycle in multiples of the prescaled period:
> +	 * duty_steps =3D duty_in_ns / step_in_ns
> +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> +	 * The code below is rearranged slightly to only divide once.
> +	 */
> +	duty_steps =3D state->duty_cycle * clk_get_rate(mchp_core_pwm->clk);
> +	tmp =3D prescale_val * NSEC_PER_SEC;
> +	return div64_u64(duty_steps, tmp);
> +}
> +
> +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +				     const struct pwm_state *state, u64 duty_steps, u8 period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 posedge, negedge;
> +	u8 period_steps_val =3D PREG_TO_VAL(period_steps);
> +
> +	/*
> +	 * Turn the output on unless posedge =3D=3D negedge, in which case the
> +	 * duty is intended to be 0, but limitations of the IP block don't
> +	 * allow a zero length duty cycle - so just set the max high/low time
> +	 * respectively.
> +	 */

I don't understand that comment. Maybe you mean?:

	/*
	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
	 * so that's an unsuitable setting to model duty_steps =3D 0.
	 * In that case set the unwanted edge to a value that never
	 * triggers.
	 */

> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> +		negedge =3D !duty_steps ? period_steps_val : 0u;
> +		posedge =3D duty_steps;
> +	} else {
> +		posedge =3D !duty_steps ? period_steps_val : 0u;
> +		negedge =3D duty_steps;
> +	}
> +
> +	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->=
hwpwm));
> +	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->=
hwpwm));
> +}
> +
> +static int mchp_core_pwm_calc_period(struct pwm_chip *chip, const struct=
 pwm_state *state,
> +				     u8 *prescale, u8 *period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 tmp, clk_rate;
> +
> +	/*
> +	 * Calculate the period cycles and prescale values.
> +	 * The registers are each 8 bits wide & multiplied to compute the period
> +	 * using the formula:
> +	 * (clock_period) * (prescale + 1) * (period_steps + 1)
> +	 * so the maximum period that can be generated is 0x10000 times the
> +	 * period of the input clock.
> +	 * However, due to the design of the "hardware", it is not possible to
> +	 * attain a 100% duty cycle if the full range of period_steps is used.
> +	 * Therefore period_steps is restricted to 0xFE and the maximum multiple
> +	 * of the clock period attainable is 0xFF00.
> +	 */
> +	clk_rate =3D clk_get_rate(mchp_core_pwm->clk);
> +
> +	/*
> +	 * If clk_rate is too big, the following multiplication might overflow.
> +	 * However this is implausible, as the fabric of current FPGAs cannot
> +	 * provide clocks at a rate high enough.
> +	 */
> +	if (clk_rate >=3D NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> +
> +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;

why -1 here?

> +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> +		return 0;
> +	}
> +
> +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> +	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */

That should explain the cast to u32? If this were really necessary
(hint: it isn't) it would IMHO be better to hide that cast in the macro.

> +	*period_steps =3D div_u64(tmp, PREG_TO_VAL((u32)*prescale)) - 1;
> +
> +	return 0;
> +}
> +
> +static inline void mchp_core_pwm_apply_period(struct mchp_core_pwm_chip =
*mchp_core_pwm,
> +					      u8 prescale, u8 period_steps)
> +{
> +	writel_relaxed(prescale, mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> +	writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
> +}
> +
> +static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       const struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	struct pwm_state current_state =3D pwm->state;
> +	bool period_locked;
> +	u64 duty_steps;
> +	u8 prescale, period_steps, hw_prescale, hw_period_steps;
> +	int ret;
> +
> +	ret =3D mutex_lock_interruptible(&mchp_core_pwm->lock);
> +	if (ret)
> +		return ret;

I would have used mutex_lock() here. Why should a signal prevent
reconfiguration of the PWM?

> +
> +	if (!state->enabled) {
> +		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
> +		mutex_unlock(&mchp_core_pwm->lock);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If the only thing that has changed is the duty cycle or the polarity,
> +	 * we can shortcut the calculations and just compute/apply the new duty
> +	 * cycle pos & neg edges
> +	 * As all the channels share the same period, do not allow it to be
> +	 * changed if any other channels are enabled.
> +	 * If the period is locked, it may not be possible to use a period
> +	 * less than that requested. In that case, we just abort.
> +	 */
> +	period_locked =3D mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
> +
> +	if (period_locked) {
> +		mchp_core_pwm_calc_period(chip, state, &prescale, &period_steps);
> +		hw_prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCA=
LE);
> +		hw_period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PE=
RIOD);
> +
> +		if ((period_steps * prescale) < (hw_period_steps * hw_prescale)) {

You need

	if ((period_steps + 1) * (prescale + 1) < (hw_period_steps + 1) * (hw_pres=
cale + 1))

here, don't you?

> +			mutex_unlock(&mchp_core_pwm->lock);
> +			return -EINVAL;
> +		}
> +
> +		prescale =3D hw_prescale;
> +		period_steps =3D hw_period_steps;

The two hw_* variables are only used in this branch. So their
declaration can move into here.

> +	} else if (!current_state.enabled || current_state.period !=3D state->p=
eriod) {
> +		ret =3D mchp_core_pwm_calc_period(chip, state, &prescale, &period_step=
s);
> +		if (ret) {
> +			mutex_unlock(&mchp_core_pwm->lock);
> +			return ret;
> +		}
> +		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> +	} else {
> +		prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> +		period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIO=
D);
> +	}
> +
> +	duty_steps =3D mchp_core_pwm_calc_duty(chip, pwm, state, prescale, peri=
od_steps);
> +
> +	/*
> +	 * Because the period is per channel, it is possible that the requested
> +	 * duty cycle is longer than the period, in which case cap it to the
> +	 * period, IOW a 100% duty cycle.
> +	 */
> +	if (duty_steps > period_steps)
> +		duty_steps =3D period_steps + 1;
> +
> +	mchp_core_pwm_apply_duty(chip, pwm, state, duty_steps, period_steps);
> +
> +	mchp_core_pwm_enable(chip, pwm, true, state->period);
> +
> +	mutex_unlock(&mchp_core_pwm->lock);
> +
> +	return 0;
> +}
> +
> +static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> +				    struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u16 prescale;
> +	u8 period_steps, duty_steps, posedge, negedge;
> +	int ret;
> +
> +	ret =3D mutex_lock_interruptible(&mchp_core_pwm->lock);
> +	if (ret)
> +		return;
> +
> +	if (mchp_core_pwm->channel_enabled & (1 << pwm->hwpwm))

channel_enabled is initialized to 0 in .probe(), so a PWM is never
diagnosed to be running when the core initially wants to determine the
current state.

> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	prescale =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPW=
M_PRESCALE));
> +
> +	period_steps =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCO=
REPWM_PERIOD));
> +	state->period =3D period_steps * prescale * NSEC_PER_SEC;
> +	state->period =3D DIV64_U64_ROUND_UP(state->period, clk_get_rate(mchp_c=
ore_pwm->clk));
> +
> +	posedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm=
->hwpwm));
> +	negedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm=
->hwpwm));
> +
> +	if (negedge =3D=3D posedge) {
> +		state->duty_cycle =3D state->period / 2;

I thought that's:

		state->duty_cycle =3D state->period;
		state->period *=3D 2;

?

> +	} else {
> +		duty_steps =3D abs((s16)posedge - (s16)negedge);
> +		state->duty_cycle =3D duty_steps * prescale * NSEC_PER_SEC;
> +		state->duty_cycle =3D DIV64_U64_ROUND_UP(state->duty_cycle,
> +						       clk_get_rate(mchp_core_pwm->clk));
> +	}
> +
> +	state->polarity =3D negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POL=
ARITY_NORMAL;
> +
> +	mutex_unlock(&mchp_core_pwm->lock);
> +}
> +
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
> +	mchp_pwm->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &reg=
s);
> +	if (IS_ERR(mchp_pwm->base))
> +		return PTR_ERR(mchp_pwm->base);
> +
> +	mchp_pwm->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(mchp_pwm->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(mchp_pwm->clk),
> +				     "failed to get PWM clock\n");
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask=
",
> +				 &mchp_pwm->sync_update_mask))
> +		mchp_pwm->sync_update_mask =3D 0u;
> +
> +	mutex_init(&mchp_pwm->lock);
> +
> +	mchp_pwm->chip.dev =3D &pdev->dev;
> +	mchp_pwm->chip.ops =3D &mchp_core_pwm_ops;
> +	mchp_pwm->chip.npwm =3D 16;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &mchp_pwm->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mchp_core_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "mchp-core-pwm",
> +		.of_match_table =3D mchp_core_of_match,
> +	},
> +	.probe =3D mchp_core_pwm_probe,
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

--alyi4teih5urcnmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLo5FgACgkQwfwUeK3K
7Amn0wgAgli64gzW9J12Pzdqv2EhouTJBleAYewyrg8wPET92EoaqHpfUvn4PQPR
kqRdgo1CxUA0aOEqx7WmMJVPYG1G0XaDRv0G6jkeimwlvZFN2o7ynbCUq62yAicE
J3PPSKBhorAS/MF1RBpNZTPkj5dJPrpAtaZfNzB+dRzVe/jlARjElzbKRclexcMM
jugmMQi3WX4T1XOfHdDFeEqRmj+SdY/Wdl/7ciZe+6ovD7EEf4cXCaFM3Mpeejkt
95jmbtyWdpycDyK+EXfMlAFVeZPgBK9iPMrhMI6vpLCNmb4R1fjnxnEiYC9rF03S
LO380nnenzdyhU/7hcw8ht5Pw4sX8w==
=CQry
-----END PGP SIGNATURE-----

--alyi4teih5urcnmb--
