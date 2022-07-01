Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B755630BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiGAJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGAJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:51:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CE976959
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:51:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7DJG-0000M7-7x; Fri, 01 Jul 2022 11:51:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7DJB-003l4S-HK; Fri, 01 Jul 2022 11:51:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7DJE-002ILY-9u; Fri, 01 Jul 2022 11:51:32 +0200
Date:   Fri, 1 Jul 2022 11:51:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20220701095132.j3rvfv6kyo534kew@pengutronix.de>
References: <20220617114442.998357-1-conor.dooley@microchip.com>
 <20220617114442.998357-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cluayngwnlfk7pcx"
Content-Disposition: inline
In-Reply-To: <20220617114442.998357-2-conor.dooley@microchip.com>
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


--cluayngwnlfk7pcx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Fri, Jun 17, 2022 at 12:44:42PM +0100, Conor Dooley wrote:
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 325 +++++++++++++++++++++++++++++++
>  3 files changed, 336 insertions(+)
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
> index 000000000000..abbfc1cd23c4
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,325 @@
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

Ah, that behaviour explains how the hardware works. The logic is:

	if $currently_high:
	    if $clkcnt =3D $negedge:
	        set(low)
	else:
	    if $clkcnt =3D $posedge:
	        set(high)

The same problem exists for 100% relative duty cycle, doesn't it?

How does the PWM behave with:

	PERIOD =3D 0xfe
	POSEDGE =3D 0xff
	NEGEDGE =3D 0

I assume this yields constant low output. How does that change if you set
PERIOD =3D 0xff? If the output isn't constant low then, maybe that's a
reason to not permit PERIOD =3D 0xff.

Below you configure for duty_cycle =3D 0:

	POSEDGE =3D PERIOD
	NEGEDGE =3D 0

In my understanding this doesn't result in a constant output?!

> + * - The PWM period is set for the whole IP block not per channel. The d=
river
> + *   will only change the period if no other PWM output is enabled.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
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
> +#define COREPWM_PRESCALE_REG	0x00u
> +#define COREPWM_PERIOD_REG	0x04u
> +#define COREPWM_EN_LOW_REG	0x08u
> +#define COREPWM_EN_HIGH_REG	0x0Cu
> +#define COREPWM_SYNC_UPD_REG	0xE4u
> +#define COREPWM_POSEDGE_OFFSET	0x10u
> +#define COREPWM_NEGEDGE_OFFSET	0x14u
> +#define COREPWM_CHANNEL_OFFSET	0x08u

I'd define the registers as follows:

	#define MCHPCOREPWM_PRESCALE		0x00
	#define MCHPCOREPWM_PERIOD		0x04
	#define MCHPCOREPWM_EN(i)		(0x08 + 0x04 * (i)) /* 0x08, 0x0c */
	#define MCHPCOREPWM_POSEDGE(i)		(0x10 + 0x08 * (i)) /* 0x10, 0x18, ..., 0x=
88 */
	#define MCHPCOREPWM_NEGEDGE(i)		(0x14 + 0x08 * (i)) /* 0x14, 0x1c, ..., 0x=
8c */
	#define MCHPCOREPWM_SYNC_UPD		0xe4

This is IMHO a bit better to understand and simplifies usage.

> +
> +struct mchp_core_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	u32 sync_update_mask;
> +};
> +
> +static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chi=
p *chip)
> +{
> +	return container_of(chip, struct mchp_core_pwm_chip, chip);
> +}
> +
> +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm, bool enable)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 channel_enable, reg_offset, shift;
> +
> +	/*
> +	 * There are two adjacent 8 bit control regs, the lower reg controls
> +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> +	 * and if so, offset by the bus width.
> +	 */
> +	reg_offset =3D COREPWM_EN_LOW_REG + (pwm->hwpwm >> 3) * sizeof(u32);
> +	shift =3D pwm->hwpwm > 7 ? pwm->hwpwm - 8 : pwm->hwpwm;
> +
> +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> +	channel_enable &=3D ~(1 << shift);
> +	channel_enable |=3D (enable << shift);
> +
> +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> +
> +	/*
> +	 * Write to the sync update registers so that channels with shadow
> +	 * registers will also get their enable update. This operation is a NOP
> +	 * for channels without shadow registers.
> +	 */
> +	writel_relaxed(1U, mchp_core_pwm->base + COREPWM_SYNC_UPD_REG);

Hmmmmm, this is racy. Consider there are two PWMs in use and two
pwm_apply calls are run in parallel. Then the sync update in the first
execution thread triggers an update for the second which might just be
in the middle of updating registers and so there is a glitch for the 2nd
PWM. So this needs locking to behave correctly.

> +}
> +
> +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +				     const struct pwm_state *state, u8 prescale, u8 period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	void __iomem *channel_base =3D mchp_core_pwm->base + pwm->hwpwm * COREP=
WM_CHANNEL_OFFSET;
> +	u64 duty_steps, period, tmp;
> +	u8 posedge, negedge;
> +	u8 prescale_val =3D PREG_TO_VAL(prescale);

If prescale is 0xff we get prescale_val =3D 0 which is bogus.

> +	u8 period_steps_val =3D PREG_TO_VAL(period_steps);
> +
> +	period =3D period_steps_val * prescale_val * NSEC_PER_SEC;
> +	period =3D div64_u64(period, clk_get_rate(mchp_core_pwm->clk));

You need to round up here.

> +	/*
> +	 * Calculate the duty cycle in multiples of the prescaled period:
> +	 * duty_steps =3D duty_in_ns / step_in_ns
> +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> +	 * The code below is rearranged slightly to only divide once.
> +	 *
> +	 * Because the period is per channel, it is possible that the requested
> +	 * duty cycle is longer than the period, in which case cap it to the
> +	 * period.
> +	 */
> +	if (state->duty_cycle > period) {
> +		duty_steps =3D period_steps;
> +	} else {
> +		duty_steps =3D state->duty_cycle * clk_get_rate(mchp_core_pwm->clk);
> +		tmp =3D prescale_val * NSEC_PER_SEC;
> +		duty_steps =3D div64_u64(duty_steps, tmp);
> +	}
> +
> +	/*
> +	 * Turn the output on unless posedge =3D=3D negedge, in which case the
> +	 * duty is intended to be 0, but limitations of the IP block don't
> +	 * allow a zero length duty cycle - so just set the max high/low time
> +	 * respectively.
> +	 */
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> +		negedge =3D !duty_steps ? period_steps : 0u;
> +		posedge =3D duty_steps;
> +	} else {
> +		posedge =3D !duty_steps ? period_steps : 0u;
> +		negedge =3D duty_steps;
> +	}
> +
> +	writel_relaxed(posedge, channel_base + COREPWM_POSEDGE_OFFSET);
> +	writel_relaxed(negedge, channel_base + COREPWM_NEGEDGE_OFFSET);
> +}
> +
> +static void mchp_core_pwm_apply_period(struct pwm_chip *chip, const stru=
ct pwm_state *state,
> +				       u8 *prescale, u8 *period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 tmp =3D state->period;
> +
> +	/*
> +	 * Calculate the period cycles and prescale values.
> +	 * The registers are each 8 bits wide & multiplied to compute the period
> +	 * so the maximum period that can be generated is 0xFFFF times the peri=
od

0xff * 0xff !=3D 0xffff

> +	 * of the input clock.
> +	 */
> +	tmp *=3D clk_get_rate(mchp_core_pwm->clk);

This might overflow. Better use mul_u64_u64_div_u64 and require
clk_get_rate(mchp_core_pwm->clk) < NSEC_PER_SEC.

> +	do_div(tmp, NSEC_PER_SEC);
> +
> +	if (tmp > 0xFFFFu) {
> +		*prescale =3D 0xFFu;
> +		*period_steps =3D 0xFFu;
> +	} else {
> +		*prescale =3D tmp >> 8;
> +		do_div(tmp, PREG_TO_VAL(*prescale));
> +		*period_steps =3D tmp - 1;
> +	}

The goal here is to determine prescale and period_steps such that (in
order of importance):

 a) Both are in [0, 255]
 b) (prescale + 1) * (period_steps + 1) <=3D tmp
 c) (prescale + 1) * (period_steps + 1) should be big
 d) period_steps should be big[1]

(If it simplifies the implementation you can also put d) above c))

So there are a few things to improve here. For example with tmp =3D 0xfffe
you get prescale =3D 0xff + period_steps =3D 0xfe which violates d)

[1] In most cases this is beneficial as a big period_steps value allows
    a more finegrained selection for duty_cycle.

> +	writel_relaxed(*prescale, mchp_core_pwm->base + COREPWM_PRESCALE_REG);
> +	writel_relaxed(*period_steps, mchp_core_pwm->base + COREPWM_PERIOD_REG);
> +}
> +
> +static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       const struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	struct pwm_state current_state =3D pwm->state;
> +	bool period_locked;
> +	u16 channel_enabled;
> +	u8 prescale, period_steps;
> +
> +	if (!state->enabled) {
> +		mchp_core_pwm_enable(chip, pwm, false);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If the only thing that has changed is the duty cycle or the polarity,
> +	 * we can shortcut the calculations and just compute/apply the new duty
> +	 * cycle pos & neg edges
> +	 * As all the channels share the same period, do not allow it to be
> +	 * changed if any other channels are enabled.
> +	 */
> +	channel_enabled =3D (((u16)readb_relaxed(mchp_core_pwm->base + COREPWM_=
EN_HIGH_REG) << 8) |
> +		readb_relaxed(mchp_core_pwm->base + COREPWM_EN_LOW_REG));

The bits 15:8 of COREPWM_EN_LOW_REG are always zero I assume?

> +	period_locked =3D channel_enabled & ~(1 << pwm->hwpwm);

This is racy, too.

> +	if ((!current_state.enabled || current_state.period !=3D state->period)=
 && !period_locked) {
> +		mchp_core_pwm_apply_period(chip, state, &prescale, &period_steps);
> +	} else {
> +		prescale =3D readb_relaxed(mchp_core_pwm->base + COREPWM_PRESCALE_REG);
> +		period_steps =3D readb_relaxed(mchp_core_pwm->base + COREPWM_PERIOD_RE=
G);
> +	}

If the configured period is bigger than the requested one, you should
return -EINVAL.

> +	mchp_core_pwm_apply_duty(chip, pwm, state, prescale, period_steps);
> +
> +	/*
> +	 * Notify the block to update the waveform from the shadow registers.
> +	 * The updated values will not appear on the bus until they have been
> +	 * applied to the waveform at the beginning of the next period.
> +	 */
> +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> +		writel_relaxed(1U, mchp_core_pwm->base + COREPWM_SYNC_UPD_REG);
> +		usleep_range(state->period, state->period * 2);
> +	}
> +
> +	mchp_core_pwm_enable(chip, pwm, true);

mchp_core_pwm_enable writes the COREPWM_SYNC_UPD_REG register, too. Do
you really need to write it twice?

> +	return 0;
> +}
> +
> +static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> +				    struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	void __iomem *channel_base =3D mchp_core_pwm->base + pwm->hwpwm * COREP=
WM_CHANNEL_OFFSET;
> +	u8 prescale, period_steps, duty_steps;
> +	u8 posedge, negedge;
> +	u16 channel_enabled;
> +
> +	channel_enabled =3D (((u16)readb_relaxed(mchp_core_pwm->base + COREPWM_=
EN_HIGH_REG) << 8) |
> +		readb_relaxed(mchp_core_pwm->base + COREPWM_EN_LOW_REG));
> +
> +	if (channel_enabled & 1 << pwm->hwpwm)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	prescale =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + COREPWM_PR=
ESCALE_REG));
> +
> +	posedge =3D readb_relaxed(channel_base + COREPWM_POSEDGE_OFFSET);
> +	negedge =3D readb_relaxed(channel_base + COREPWM_NEGEDGE_OFFSET);
> +
> +	duty_steps =3D abs((s16)posedge - (s16)negedge);
> +	state->duty_cycle =3D duty_steps * prescale * NSEC_PER_SEC;
> +	do_div(state->duty_cycle, clk_get_rate(mchp_core_pwm->clk));
> +
> +	state->polarity =3D negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POL=
ARITY_NORMAL;
> +
> +	period_steps =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + COREPW=
M_PERIOD_REG));
> +	state->period =3D period_steps * prescale * NSEC_PER_SEC;
> +	do_div(state->period, clk_get_rate(mchp_core_pwm->clk));
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
> +	mchp_pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(mchp_pwm->clk))
> +		return PTR_ERR(mchp_pwm->clk);
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask=
",
> +				 &mchp_pwm->sync_update_mask))
> +		mchp_pwm->sync_update_mask =3D 0u;
> +
> +	ret =3D clk_prepare_enable(mchp_pwm->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to prepare PWM clock\n");
> +
> +	mchp_pwm->chip.dev =3D &pdev->dev;
> +	mchp_pwm->chip.ops =3D &mchp_core_pwm_ops;
> +	mchp_pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	mchp_pwm->chip.of_pwm_n_cells =3D 3;

You can drop these two, assuming you have #pwm-cells =3D <3> in the dtb,
they are also assigned by the core like that. (And if you don't it's
ugly to assign these and you're better of the the stuff that the pwm
core does.)

> +	mchp_pwm->chip.npwm =3D 16;
> +
> +	ret =3D pwmchip_add(&mchp_pwm->chip);
> +	if (ret < 0) {
> +		clk_disable_unprepare(mchp_pwm->clk);
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +	}
> +
> +	platform_set_drvdata(pdev, mchp_pwm);
> +	dev_info(&pdev->dev, "Successfully registered Microchip corePWM\n");

I recommend to drop this message. If every driver does that, you get
quite a lot of messages that are not very helpful (once development of
the driver is done) and delay the boot up time.

> +	return 0;
> +}
> +
> +static int mchp_core_pwm_remove(struct platform_device *pdev)
> +{
> +	struct mchp_core_pwm_chip *mchp_pwm =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&mchp_pwm->chip);
> +	clk_disable_unprepare(mchp_pwm->clk);

If you use devm_clk_get_enabled() and devm_pwmchip_add() in .probe(),
you can drop .remove()

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
> +	.remove =3D mchp_core_pwm_remove,
> +};
> +module_platform_driver(mchp_core_pwm_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> +MODULE_DESCRIPTION("corePWM driver for Microchip FPGAs");

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cluayngwnlfk7pcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK+w6EACgkQwfwUeK3K
7AnQMAf/SpGegXHrOd2XKGuMPhiCOUEb77hhGX7yNDma8MZSVWx2lpdIgytuldvx
X4Y9lrQuRoo4uOqTniLYKa8Wk9OBlgfjeoaQWdZfSOj409rDGz8WExVN/xMHWSJk
HcqvhN+H/j4b4qQ7L/vvD/fjjFVAmUXyyEwAbPbiUrAItUTlKR6SxIe1hc0lJXHZ
tGh+Tcp64c66r4Ak7r3enjKPlXyAXd1hXvpKZV2kRDqeI7hZ/6f5j+S7DrLaq9l9
qvVXmWniuWwOdK67Bk5rjwVlVAvOgqJCvz4hSqQTFEkxIBI/36JkCggjegy3LFnS
s4S0spCtX36aMIFEdVi6Sl07f7dqxQ==
=I9mF
-----END PGP SIGNATURE-----

--cluayngwnlfk7pcx--
