Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AAE54B161
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiFNMji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356775AbiFNMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:38:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B63465F5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:35:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o15kk-000059-HM; Tue, 14 Jun 2022 14:34:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o15ki-000UYD-0u; Tue, 14 Jun 2022 14:34:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o15ki-00GFFx-Ld; Tue, 14 Jun 2022 14:34:36 +0200
Date:   Tue, 14 Jun 2022 14:34:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20220614123436.ahimxsfkwmfdjqdw@pengutronix.de>
References: <20220613111759.1550578-1-conor.dooley@microchip.com>
 <20220613111759.1550578-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gs7enp76v6o65krd"
Content-Disposition: inline
In-Reply-To: <20220613111759.1550578-2-conor.dooley@microchip.com>
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


--gs7enp76v6o65krd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 13, 2022 at 12:17:59PM +0100, Conor Dooley wrote:
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 310 +++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+)
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
> index 000000000000..d2abc46deec4
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,310 @@
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
> +
> +struct mchp_core_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
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
> +}
> +
> +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip,  struct pwm_=
device *pwm,
> +				     const struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	void __iomem *channel_base =3D mchp_core_pwm->base + pwm->hwpwm * COREP=
WM_CHANNEL_OFFSET;
> +	u64 duty_steps, period, tmp;
> +	u8 prescale, period_steps, posedge, negedge;
> +
> +	prescale =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + COREPWM_PR=
ESCALE_REG));
> +	period_steps =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + COREPW=
M_PERIOD_REG));
> +	period =3D period_steps * prescale * NSEC_PER_SEC;
> +	period =3D div64_u64(period, clk_get_rate(mchp_core_pwm->clk));
> +
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
> +		tmp =3D prescale * NSEC_PER_SEC;
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
ct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 tmp =3D state->period;
> +	u8 prescale, period_steps;
> +
> +	/*
> +	 * Calculate the period cycles and prescale values.
> +	 * The registers are each 8 bits wide & multiplied to compute the period
> +	 * so the maximum period that can be generated is 0xFFFF times the peri=
od
> +	 * of the input clock.
> +	 */
> +	tmp *=3D clk_get_rate(mchp_core_pwm->clk);
> +	do_div(tmp, NSEC_PER_SEC);
> +
> +	if (tmp > 0xFFFFu) {
> +		prescale =3D 0xFFu;
> +		period_steps =3D 0xFFu;
> +	} else {
> +		prescale =3D tmp >> 8;
> +		period_steps =3D tmp / PREG_TO_VAL(prescale) - 1;

Here is the 64bit division.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gs7enp76v6o65krd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKogFkACgkQwfwUeK3K
7AkIJgf/T69DInAPl8mPJHsehA8CjpDHNPdV+J+xoo7wQ6sZlHc7ixkpIoLgyTxA
1+IjBmKpWY4vERoAHPHdG1lorTyHQ3iyj8YQn2LDOt04tJjm8PFEPrJ6cRXwvABP
VZX0RtABTKM6Vz8c77cRnk26kmYOqNeLkHMs5PQb+IlvNdJQdMyYd2fpn3NItPkk
ApBIL0t+3+x0EU1qyHnYGjKpDF4rwAKc6N7JJnzpzt77P3W9OGiFhKVAnsnPEAU5
d67iL0y8/si3DpJe9Cf8fQzud2d6XOvdmE3ApnRiWpRdPKCN9N9EleoBvw7cqzky
B68Inwo0uDIP5HoyB3cjJY5hpMNo9A==
=moey
-----END PGP SIGNATURE-----

--gs7enp76v6o65krd--
