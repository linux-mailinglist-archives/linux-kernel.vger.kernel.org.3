Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B478A4A75CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345849AbiBBQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345835AbiBBQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:29:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457DC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:29:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFIVj-0008Nn-Of; Wed, 02 Feb 2022 17:29:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFIVh-00E57C-Dd; Wed, 02 Feb 2022 17:29:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFIVf-004Lll-RJ; Wed, 02 Feb 2022 17:29:31 +0100
Date:   Wed, 2 Feb 2022 17:29:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v11 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220202162930.24zcediw44t2jzqf@pengutronix.de>
References: <20220129005429.754727-1-bjorn.andersson@linaro.org>
 <20220129005429.754727-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ildntntw4xt2zq7v"
Content-Disposition: inline
In-Reply-To: <20220129005429.754727-2-bjorn.andersson@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ildntntw4xt2zq7v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

did you consider my earlier feedback "It would also be good if the PWM
code could live in drivers/pwm"?
(https://lore.kernel.org/r/20210505051958.e5lvwfxuo2skdu2q@pengutronix.de)

At least splitting in two patches would be good IMHO.

On Fri, Jan 28, 2022 at 04:54:29PM -0800, Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> with their output being routed to various other components, such as
> current sinks or GPIOs.
>=20
> Each LPG instance can operate on fixed parameters or based on a shared
> lookup-table, altering the duty cycle over time. This provides the means
> for hardware assisted transitions of LED brightness.
>=20
> A typical use case for the fixed parameter mode is to drive a PWM
> backlight control signal, the driver therefor allows each LPG instance
> to be exposed to the kernel either through the LED framework or the PWM
> framework.
>=20
> A typical use case for the LED configuration is to drive RGB LEDs in
> smartphones etc, for which the driver support multiple channels to be
> ganged up to a MULTICOLOR LED. In this configuration the pattern
> generators will be synchronized, to allow for multi-color patterns.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>=20
> Changes since v10:
> - Check for and reject pattern.delta_t greater than 9 bits
> - Write all 9 bits of LPG_RAMP_DURATION_REG
>=20
>  drivers/leds/Kconfig             |    3 +
>  drivers/leds/Makefile            |    3 +
>  drivers/leds/rgb/Kconfig         |   13 +
>  drivers/leds/rgb/Makefile        |    3 +
>  drivers/leds/rgb/leds-qcom-lpg.c | 1306 ++++++++++++++++++++++++++++++
>  5 files changed, 1328 insertions(+)
>  create mode 100644 drivers/leds/rgb/Kconfig
>  create mode 100644 drivers/leds/rgb/Makefile
>  create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c
>=20
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6090e647daee..a49979f41eee 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -869,6 +869,9 @@ source "drivers/leds/blink/Kconfig"
>  comment "Flash and Torch LED drivers"
>  source "drivers/leds/flash/Kconfig"
> =20
> +comment "RGB LED drivers"
> +source "drivers/leds/rgb/Kconfig"
> +
>  comment "LED Triggers"
>  source "drivers/leds/trigger/Kconfig"
> =20
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index e58ecb36360f..4fd2f92cd198 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -99,6 +99,9 @@ obj-$(CONFIG_LEDS_USER)			+=3D uleds.o
>  # Flash and Torch LED Drivers
>  obj-$(CONFIG_LEDS_CLASS_FLASH)		+=3D flash/
> =20
> +# RGB LED Drivers
> +obj-$(CONFIG_LEDS_CLASS_MULTICOLOR)	+=3D rgb/
> +
>  # LED Triggers
>  obj-$(CONFIG_LEDS_TRIGGERS)		+=3D trigger/
> =20
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> new file mode 100644
> index 000000000000..20be3e11fe4a
> --- /dev/null
> +++ b/drivers/leds/rgb/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if LEDS_CLASS_MULTICOLOR
> +
> +config LEDS_QCOM_LPG
> +	tristate "LED support for Qualcomm LPG"
> +	depends on OF
> +	depends on SPMI
> +	help
> +	  This option enables support for the Light Pulse Generator found in a
> +	  wide variety of Qualcomm PMICs.
> +
> +endif # LEDS_CLASS_MULTICOLOR
> diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
> new file mode 100644
> index 000000000000..83114f44c4ea
> --- /dev/null
> +++ b/drivers/leds/rgb/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_LEDS_QCOM_LPG)	+=3D leds-qcom-lpg.o
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> new file mode 100644
> index 000000000000..06d5fca1d4b5
> --- /dev/null
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -0,0 +1,1306 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2017-2022 Linaro Ltd
> + * Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.
> + */
> +#include <linux/bits.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define LPG_PATTERN_CONFIG_REG	0x40
> +#define LPG_SIZE_CLK_REG	0x41
> +#define LPG_PREDIV_CLK_REG	0x42
> +#define PWM_TYPE_CONFIG_REG	0x43
> +#define PWM_VALUE_REG		0x44
> +#define PWM_ENABLE_CONTROL_REG	0x46
> +#define PWM_SYNC_REG		0x47
> +#define LPG_RAMP_DURATION_REG	0x50
> +#define LPG_HI_PAUSE_REG	0x52
> +#define LPG_LO_PAUSE_REG	0x54
> +#define LPG_HI_IDX_REG		0x56
> +#define LPG_LO_IDX_REG		0x57
> +#define PWM_SEC_ACCESS_REG	0xd0
> +#define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
> +
> +#define TRI_LED_SRC_SEL		0x45
> +#define TRI_LED_EN_CTL		0x46
> +#define TRI_LED_ATC_CTL		0x47
> +
> +#define LPG_LUT_REG(x)		(0x40 + (x) * 2)
> +#define RAMP_CONTROL_REG	0xc8
> +
> +#define LPG_RESOLUTION		512
> +#define LPG_MAX_M		7
> +
> +struct lpg_channel;
> +struct lpg_data;
> +
> +/**
> + * struct lpg - LPG device context
> + * @dev:	struct device for LPG device
> + * @map:	regmap for register access
> + * @pwm:	PWM-chip object, if operating in PWM mode
> + * @data:	reference to version specific data
> + * @lut_base:	base address of the LUT block (optional)
> + * @lut_size:	number of entries in the LUT block
> + * @lut_bitmap:	allocation bitmap for LUT entries
> + * @triled_base: base address of the TRILED block (optional)
> + * @triled_src:	power-source for the TRILED
> + * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
> + * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
> + * @channels:	list of PWM channels
> + * @num_channels: number of @channels
> + */
> +struct lpg {
> +	struct device *dev;
> +	struct regmap *map;
> +
> +	struct pwm_chip pwm;
> +
> +	const struct lpg_data *data;
> +
> +	u32 lut_base;
> +	u32 lut_size;
> +	unsigned long *lut_bitmap;
> +
> +	u32 triled_base;
> +	u32 triled_src;
> +	bool triled_has_atc_ctl;
> +	bool triled_has_src_sel;
> +
> +	struct lpg_channel *channels;
> +	unsigned int num_channels;
> +};
> +
> +/**
> + * struct lpg_channel - per channel data
> + * @lpg:	reference to parent lpg
> + * @base:	base address of the PWM channel
> + * @triled_mask: mask in TRILED to enable this channel
> + * @lut_mask:	mask in LUT to start pattern generator for this channel
> + * @in_use:	channel is exposed to LED framework
> + * @color:	color of the LED attached to this channel
> + * @dtest_line:	DTEST line for output, or 0 if disabled
> + * @dtest_value: DTEST line configuration
> + * @pwm_value:	duty (in microseconds) of the generated pulses, overridde=
n by LUT
> + * @enabled:	output enabled?
> + * @period:	period (in nanoseconds) of the generated pulses
> + * @clk:	base frequency of the clock generator
> + * @pre_div:	divider of @clk
> + * @pre_div_exp: exponential divider of @clk
> + * @ramp_enabled: duty cycle is driven by iterating over lookup table
> + * @ramp_ping_pong: reverse through pattern, rather than wrapping to sta=
rt
> + * @ramp_oneshot: perform only a single pass over the pattern
> + * @ramp_reverse: iterate over pattern backwards
> + * @ramp_tick_ms: length (in milliseconds) of one step in the pattern
> + * @ramp_lo_pause_ms: pause (in milliseconds) before iterating over patt=
ern
> + * @ramp_hi_pause_ms: pause (in milliseconds) after iterating over patte=
rn
> + * @pattern_lo_idx: start index of associated pattern
> + * @pattern_hi_idx: last index of associated pattern
> + */
> +struct lpg_channel {
> +	struct lpg *lpg;
> +
> +	u32 base;
> +	unsigned int triled_mask;
> +	unsigned int lut_mask;
> +
> +	bool in_use;
> +
> +	int color;
> +
> +	u32 dtest_line;
> +	u32 dtest_value;
> +
> +	u16 pwm_value;
> +	bool enabled;
> +
> +	u64 period;
> +	unsigned int clk;
> +	unsigned int pre_div;
> +	unsigned int pre_div_exp;
> +
> +	bool ramp_enabled;
> +	bool ramp_ping_pong;
> +	bool ramp_oneshot;
> +	bool ramp_reverse;
> +	unsigned short ramp_tick_ms;
> +	unsigned long ramp_lo_pause_ms;
> +	unsigned long ramp_hi_pause_ms;
> +
> +	unsigned int pattern_lo_idx;
> +	unsigned int pattern_hi_idx;
> +};
> +
> +/**
> + * struct lpg_led - logical LED object
> + * @lpg:		lpg context reference
> + * @cdev:		LED class device
> + * @mcdev:		Multicolor LED class device
> + * @num_channels:	number of @channels
> + * @channels:		list of channels associated with the LED
> + */
> +struct lpg_led {
> +	struct lpg *lpg;
> +
> +	struct led_classdev cdev;
> +	struct led_classdev_mc mcdev;
> +
> +	unsigned int num_channels;
> +	struct lpg_channel *channels[];
> +};
> +
> +/**
> + * struct lpg_channel_data - per channel initialization data
> + * @base:		base address for PWM channel registers
> + * @triled_mask:	bitmask for controlling this channel in TRILED
> + */
> +struct lpg_channel_data {
> +	unsigned int base;
> +	u8 triled_mask;
> +};
> +
> +/**
> + * struct lpg_data - initialization data
> + * @lut_base:		base address of LUT block
> + * @lut_size:		number of entries in LUT
> + * @triled_base:	base address of TRILED
> + * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
> + * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
> + * @pwm_9bit_mask:	bitmask for switching from 6bit to 9bit pwm
> + * @num_channels:	number of channels in LPG
> + * @channels:		list of channel initialization data
> + */
> +struct lpg_data {
> +	unsigned int lut_base;
> +	unsigned int lut_size;
> +	unsigned int triled_base;
> +	bool triled_has_atc_ctl;
> +	bool triled_has_src_sel;
> +	unsigned int pwm_9bit_mask;
> +	int num_channels;
> +	const struct lpg_channel_data *channels;
> +};
> +
> +static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int e=
nable)
> +{
> +	/* Skip if we don't have a triled block */
> +	if (!lpg->triled_base)
> +		return 0;
> +
> +	return regmap_update_bits(lpg->map, lpg->triled_base + TRI_LED_EN_CTL,
> +				  mask, enable);
> +}
> +
> +static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
> +			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> +{
> +	unsigned int idx;
> +	u16 val;
> +	int i;
> +
> +	/* Hardware does not behave when LO_IDX =3D=3D HI_IDX */
> +	if (len =3D=3D 1)
> +		return -EINVAL;
> +
> +	idx =3D bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
> +					 0, len, 0);
> +	if (idx >=3D lpg->lut_size)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < len; i++) {
> +		val =3D pattern[i].brightness;
> +
> +		regmap_bulk_write(lpg->map, lpg->lut_base + LPG_LUT_REG(idx + i),
> +				  &val, sizeof(val));
> +	}
> +
> +	bitmap_set(lpg->lut_bitmap, idx, len);
> +
> +	*lo_idx =3D idx;
> +	*hi_idx =3D idx + len - 1;
> +
> +	return 0;
> +}
> +
> +static void lpg_lut_free(struct lpg *lpg, unsigned int lo_idx, unsigned =
int hi_idx)
> +{
> +	int len;
> +
> +	if (lo_idx =3D=3D hi_idx)
> +		return;
> +
> +	len =3D hi_idx - lo_idx + 1;
> +	bitmap_clear(lpg->lut_bitmap, lo_idx, len);
> +}
> +
> +static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
> +{
> +	return regmap_write(lpg->map, lpg->lut_base + RAMP_CONTROL_REG, mask);
> +}
> +
> +static const unsigned int lpg_clk_rates[] =3D {1024, 32768, 19200000};
> +static const unsigned int lpg_pre_divs[] =3D {1, 3, 5, 6};
> +
> +static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> +{
> +	unsigned int clk, best_clk =3D 0;
> +	unsigned int div, best_div =3D 0;
> +	unsigned int m, best_m =3D 0;
> +	unsigned int error;
> +	unsigned int best_err =3D UINT_MAX;
> +	u64 best_period =3D 0;
> +
> +	/*
> +	 * The PWM period is determined by:
> +	 *
> +	 *          resolution * pre_div * 2^M
> +	 * period =3D --------------------------
> +	 *                   refclk
> +	 *
> +	 * With resolution fixed at 2^9 bits, pre_div =3D {1, 3, 5, 6} and
> +	 * M =3D [0..7].
> +	 *
> +	 * This allows for periods between 27uS and 384s, as the PWM framework
> +	 * wants a period of equal or lower length than requested, reject
> +	 * anything below 27uS.
> +	 */
> +	if (period <=3D (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)

u64 divisions must not be done by / in the kernel. Also I wonder if the
following would be more correct (though with the same semantic):

	if (period < DIV64_U64_ROUND_UP((u64)NSEC_PER_SEC * LPG_RESOLUTION, 192000=
00))


> +		return -EINVAL;
> +
> +	/* Limit period to largest possible value, to avoid overflows */
> +	if (period > (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) =
/ 1024)
> +		period =3D (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) /=
 2014;
> +
> +	/*
> +	 * Search for the pre_div, clk and M by solving the rewritten formula
> +	 * for each clk and pre_div value:
> +	 *
> +	 *                       period * clk
> +	 * M =3D log2 -------------------------------------
> +	 *           NSEC_PER_SEC * pre_div * resolution
> +	 */
> +	for (clk =3D 0; clk < ARRAY_SIZE(lpg_clk_rates); clk++) {
> +		u64 nom =3D period * lpg_clk_rates[clk];
> +
> +		for (div =3D 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
> +			u64 denom =3D (u64)NSEC_PER_SEC * lpg_pre_divs[div] * (1 << 9);
> +			u64 actual;
> +			u64 ratio;
> +
> +			if (nom < denom)
> +				continue;
> +
> +			ratio =3D div64_u64(nom, denom);
> +			m =3D ilog2(ratio);
> +			if (m > LPG_MAX_M)
> +				m =3D LPG_MAX_M;
> +
> +			actual =3D DIV_ROUND_UP_ULL(denom * (1 << m), lpg_clk_rates[clk]);
> +
> +			error =3D period - actual;

This looks good, though I didn't revalidate the calculation (e.g. to
convince myself that error is always >=3D 0)

> +			if (error < best_err) {
> +				best_err =3D error;
> +
> +				best_div =3D div;
> +				best_m =3D m;
> +				best_clk =3D clk;
> +				best_period =3D actual;
> +			}
> +		}
> +	}
> +
> +	chan->clk =3D best_clk;
> +	chan->pre_div =3D best_div;
> +	chan->pre_div_exp =3D best_m;
> +	chan->period =3D best_period;
> +
> +	return 0;
> +}
> +
> +static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
> +{
> +	unsigned int max =3D LPG_RESOLUTION - 1;
> +	unsigned int val;
> +
> +	val =3D div64_u64(duty * lpg_clk_rates[chan->clk],
> +			(u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div] * (1 << chan->pre_div=
_exp));
> +
> +	chan->pwm_value =3D min(val, max);
> +}
> +
> +static void lpg_apply_freq(struct lpg_channel *chan)
> +{
> +	unsigned long val;
> +	struct lpg *lpg =3D chan->lpg;
> +
> +	if (!chan->enabled)
> +		return;
> +
> +	/* Clock register values are off-by-one from lpg_clk_table */
> +	val =3D chan->clk + 1;
> +
> +	/* Enable 9bit resolution */
> +	val |=3D lpg->data->pwm_9bit_mask;
> +
> +	regmap_write(lpg->map, chan->base + LPG_SIZE_CLK_REG, val);
> +
> +	val =3D chan->pre_div << 5 | chan->pre_div_exp;
> +	regmap_write(lpg->map, chan->base + LPG_PREDIV_CLK_REG, val);
> +}
> +
> +#define LPG_ENABLE_GLITCH_REMOVAL	BIT(5)
> +
> +static void lpg_enable_glitch(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg =3D chan->lpg;
> +
> +	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
> +			   LPG_ENABLE_GLITCH_REMOVAL, 0);
> +}
> +
> +static void lpg_disable_glitch(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg =3D chan->lpg;
> +
> +	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
> +			   LPG_ENABLE_GLITCH_REMOVAL,
> +			   LPG_ENABLE_GLITCH_REMOVAL);
> +}
> +
> +static void lpg_apply_pwm_value(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg =3D chan->lpg;
> +	u16 val =3D chan->pwm_value;
> +
> +	if (!chan->enabled)
> +		return;
> +
> +	regmap_bulk_write(lpg->map, chan->base + PWM_VALUE_REG, &val, sizeof(va=
l));
> +}
> +
> +#define LPG_PATTERN_CONFIG_LO_TO_HI	BIT(4)
> +#define LPG_PATTERN_CONFIG_REPEAT	BIT(3)
> +#define LPG_PATTERN_CONFIG_TOGGLE	BIT(2)
> +#define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
> +#define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
> +
> +static void lpg_apply_lut_control(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg =3D chan->lpg;
> +	unsigned int hi_pause;
> +	unsigned int lo_pause;
> +	unsigned int conf =3D 0;
> +	unsigned int lo_idx =3D chan->pattern_lo_idx;
> +	unsigned int hi_idx =3D chan->pattern_hi_idx;
> +	u16 step =3D chan->ramp_tick_ms;
> +
> +	if (!chan->ramp_enabled || chan->pattern_lo_idx =3D=3D chan->pattern_hi=
_idx)
> +		return;
> +
> +	hi_pause =3D DIV_ROUND_UP(chan->ramp_hi_pause_ms, step);
> +	lo_pause =3D DIV_ROUND_UP(chan->ramp_lo_pause_ms, step);
> +
> +	if (!chan->ramp_reverse)
> +		conf |=3D LPG_PATTERN_CONFIG_LO_TO_HI;
> +	if (!chan->ramp_oneshot)
> +		conf |=3D LPG_PATTERN_CONFIG_REPEAT;
> +	if (chan->ramp_ping_pong)
> +		conf |=3D LPG_PATTERN_CONFIG_TOGGLE;
> +	if (chan->ramp_hi_pause_ms)
> +		conf |=3D LPG_PATTERN_CONFIG_PAUSE_HI;
> +	if (chan->ramp_lo_pause_ms)
> +		conf |=3D LPG_PATTERN_CONFIG_PAUSE_LO;
> +
> +	regmap_write(lpg->map, chan->base + LPG_PATTERN_CONFIG_REG, conf);
> +	regmap_write(lpg->map, chan->base + LPG_HI_IDX_REG, hi_idx);
> +	regmap_write(lpg->map, chan->base + LPG_LO_IDX_REG, lo_idx);
> +
> +	regmap_bulk_write(lpg->map, chan->base + LPG_RAMP_DURATION_REG, &step, =
sizeof(step));
> +	regmap_write(lpg->map, chan->base + LPG_HI_PAUSE_REG, hi_pause);
> +	regmap_write(lpg->map, chan->base + LPG_LO_PAUSE_REG, lo_pause);
> +}
> +
> +#define LPG_ENABLE_CONTROL_OUTPUT		BIT(7)
> +#define LPG_ENABLE_CONTROL_BUFFER_TRISTATE	BIT(5)
> +#define LPG_ENABLE_CONTROL_SRC_PWM		BIT(2)
> +#define LPG_ENABLE_CONTROL_RAMP_GEN		BIT(1)
> +
> +static void lpg_apply_control(struct lpg_channel *chan)
> +{
> +	unsigned int ctrl;
> +	struct lpg *lpg =3D chan->lpg;
> +
> +	ctrl =3D LPG_ENABLE_CONTROL_BUFFER_TRISTATE;
> +
> +	if (chan->enabled)
> +		ctrl |=3D LPG_ENABLE_CONTROL_OUTPUT;
> +
> +	if (chan->pattern_lo_idx !=3D chan->pattern_hi_idx)
> +		ctrl |=3D LPG_ENABLE_CONTROL_RAMP_GEN;
> +	else
> +		ctrl |=3D LPG_ENABLE_CONTROL_SRC_PWM;
> +
> +	regmap_write(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG, ctrl);
> +
> +	/*
> +	 * Due to LPG hardware bug, in the PWM mode, having enabled PWM,
> +	 * We have to write PWM values one more time.
> +	 */
> +	if (chan->enabled)
> +		lpg_apply_pwm_value(chan);
> +}
> +
> +#define LPG_SYNC_PWM	BIT(0)
> +
> +static void lpg_apply_sync(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg =3D chan->lpg;
> +
> +	regmap_write(lpg->map, chan->base + PWM_SYNC_REG, LPG_SYNC_PWM);
> +}
> +
> +static int lpg_parse_dtest(struct lpg *lpg)
> +{
> +	struct lpg_channel *chan;
> +	struct device_node *np =3D lpg->dev->of_node;
> +	int count;
> +	int ret;
> +	int i;
> +
> +	count =3D of_property_count_u32_elems(np, "qcom,dtest");
> +	if (count =3D=3D -EINVAL) {
> +		return 0;
> +	} else if (count < 0) {
> +		ret =3D count;
> +		goto err_malformed;
> +	} else if (count !=3D lpg->data->num_channels * 2) {
> +		dev_err(lpg->dev, "qcom,dtest needs to be %d items\n",
> +			lpg->data->num_channels * 2);
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < lpg->data->num_channels; i++) {
> +		chan =3D &lpg->channels[i];
> +
> +		ret =3D of_property_read_u32_index(np, "qcom,dtest", i * 2,
> +						 &chan->dtest_line);
> +		if (ret)
> +			goto err_malformed;
> +
> +		ret =3D of_property_read_u32_index(np, "qcom,dtest", i * 2 + 1,
> +						 &chan->dtest_value);
> +		if (ret)
> +			goto err_malformed;
> +	}
> +
> +	return 0;
> +
> +err_malformed:
> +	dev_err(lpg->dev, "malformed qcom,dtest\n");
> +	return ret;
> +}
> +
> +static void lpg_apply_dtest(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg =3D chan->lpg;
> +
> +	if (!chan->dtest_line)
> +		return;
> +
> +	regmap_write(lpg->map, chan->base + PWM_SEC_ACCESS_REG, 0xa5);
> +	regmap_write(lpg->map, chan->base + PWM_DTEST_REG(chan->dtest_line),
> +		     chan->dtest_value);
> +}
> +
> +static void lpg_apply(struct lpg_channel *chan)
> +{
> +	lpg_disable_glitch(chan);
> +	lpg_apply_freq(chan);
> +	lpg_apply_pwm_value(chan);
> +	lpg_apply_control(chan);
> +	lpg_apply_sync(chan);
> +	lpg_apply_lut_control(chan);
> +	lpg_enable_glitch(chan);
> +}
> +
> +static void lpg_brightness_set(struct lpg_led *led, struct led_classdev =
*cdev,
> +			       struct mc_subled *subleds)
> +{
> +	enum led_brightness brightness;
> +	struct lpg_channel *chan;
> +	unsigned int triled_enabled =3D 0;
> +	unsigned int triled_mask =3D 0;
> +	unsigned int lut_mask =3D 0;
> +	unsigned int duty;
> +	struct lpg *lpg =3D led->lpg;
> +	int i;
> +
> +	for (i =3D 0; i < led->num_channels; i++) {
> +		chan =3D led->channels[i];
> +		brightness =3D subleds[i].brightness;
> +
> +		if (brightness =3D=3D LED_OFF) {
> +			chan->enabled =3D false;
> +			chan->ramp_enabled =3D false;
> +		} else if (chan->pattern_lo_idx !=3D chan->pattern_hi_idx) {
> +			lpg_calc_freq(chan, NSEC_PER_MSEC);
> +
> +			chan->enabled =3D true;
> +			chan->ramp_enabled =3D true;
> +
> +			lut_mask |=3D chan->lut_mask;
> +			triled_enabled |=3D chan->triled_mask;
> +		} else {
> +			lpg_calc_freq(chan, NSEC_PER_MSEC);
> +
> +			duty =3D div_u64(brightness * chan->period, cdev->max_brightness);
> +			lpg_calc_duty(chan, duty);
> +			chan->enabled =3D true;
> +			chan->ramp_enabled =3D false;
> +
> +			triled_enabled |=3D chan->triled_mask;
> +		}
> +
> +		triled_mask |=3D chan->triled_mask;
> +
> +		lpg_apply(chan);
> +	}
> +
> +	/* Toggle triled lines */
> +	if (triled_mask)
> +		triled_set(lpg, triled_mask, triled_enabled);
> +
> +	/* Trigger start of ramp generator(s) */
> +	if (lut_mask)
> +		lpg_lut_sync(lpg, lut_mask);
> +}
> +
> +static void lpg_brightness_single_set(struct led_classdev *cdev,
> +				      enum led_brightness value)
> +{
> +	struct lpg_led *led =3D container_of(cdev, struct lpg_led, cdev);
> +	struct mc_subled info;
> +
> +	info.brightness =3D value;
> +	lpg_brightness_set(led, cdev, &info);
> +}
> +
> +static void lpg_brightness_mc_set(struct led_classdev *cdev,
> +				  enum led_brightness value)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lpg_led *led =3D container_of(mc, struct lpg_led, mcdev);
> +
> +	led_mc_calc_color_components(mc, value);
> +	lpg_brightness_set(led, cdev, mc->subled_info);
> +}
> +
> +static int lpg_blink_set(struct lpg_led *led,
> +			 unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	struct lpg_channel *chan;
> +	unsigned int period;
> +	unsigned int triled_mask =3D 0;
> +	struct lpg *lpg =3D led->lpg;
> +	u64 duty;
> +	int i;
> +
> +	if (!*delay_on && !*delay_off) {
> +		*delay_on =3D 500;
> +		*delay_off =3D 500;
> +	}
> +
> +	duty =3D *delay_on * NSEC_PER_MSEC;
> +	period =3D (*delay_on + *delay_off) * NSEC_PER_MSEC;
> +
> +	for (i =3D 0; i < led->num_channels; i++) {
> +		chan =3D led->channels[i];
> +
> +		lpg_calc_freq(chan, period);
> +		lpg_calc_duty(chan, duty);
> +
> +		chan->enabled =3D true;
> +		chan->ramp_enabled =3D false;
> +
> +		triled_mask |=3D chan->triled_mask;
> +
> +		lpg_apply(chan);
> +	}
> +
> +	/* Enable triled lines */
> +	triled_set(lpg, triled_mask, triled_mask);
> +
> +	chan =3D led->channels[0];
> +	duty =3D div_u64(chan->pwm_value * chan->period, LPG_RESOLUTION);
> +	*delay_on =3D div_u64(duty, NSEC_PER_MSEC);
> +	*delay_off =3D div_u64(chan->period - duty, NSEC_PER_MSEC);
> +
> +	return 0;
> +}
> +
> +static int lpg_blink_single_set(struct led_classdev *cdev,
> +				unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	struct lpg_led *led =3D container_of(cdev, struct lpg_led, cdev);
> +
> +	return lpg_blink_set(led, delay_on, delay_off);
> +}
> +
> +static int lpg_blink_mc_set(struct led_classdev *cdev,
> +			    unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lpg_led *led =3D container_of(mc, struct lpg_led, mcdev);
> +
> +	return lpg_blink_set(led, delay_on, delay_off);
> +}
> +
> +static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *patt=
ern,
> +			   u32 len, int repeat)
> +{
> +	struct lpg_channel *chan;
> +	struct lpg *lpg =3D led->lpg;
> +	unsigned int hi_pause;
> +	unsigned int lo_pause;
> +	unsigned int lo_idx;
> +	unsigned int hi_idx;
> +	bool ping_pong =3D true;
> +	int brightness_a;
> +	int brightness_b;
> +	int ret;
> +	int i;
> +
> +	/* Only support oneshot or indefinite loops, due to limited pattern spa=
ce */
> +	if (repeat !=3D -1 && repeat !=3D 1)
> +		return -EINVAL;
> +
> +	/* LPG_RAMP_DURATION_REG is 9 bit */
> +	if (pattern[0].delta_t >=3D 512)
> +		return -EINVAL;
> +
> +	/*
> +	 * The LPG plays patterns with at a fixed pace, a "low pause" can be
> +	 * performed before the pattern and a "high pause" after. In order to
> +	 * save space the pattern can be played in "ping pong" mode, in which
> +	 * the pattern is first played forward, then "high pause" is applied,
> +	 * then the pattern is played backwards and finally the "low pause" is
> +	 * applied.
> +	 *
> +	 * The delta_t of the first entry is used to determine the pace of the
> +	 * pattern.
> +	 *
> +	 * If the specified pattern is a palindrome the ping pong mode is
> +	 * enabled. In this scenario the delta_t of the last entry determines
> +	 * the "low pause" time and the delta_t of the middle entry (i.e. the
> +	 * last in the programmed pattern) determines the "high pause". If the
> +	 * pattern consists of an odd number of values, no "high pause" is
> +	 * used.
> +	 *
> +	 * When ping pong mode is not selected, the delta_t of the last entry
> +	 * is used as "high pause". No "low pause" is used.
> +	 *
> +	 * delta_t of any other members of the pattern is ignored.
> +	 */
> +
> +	/* Detect palindromes and use "ping pong" to reduce LUT usage */
> +	for (i =3D 0; i < len / 2; i++) {
> +		brightness_a =3D pattern[i].brightness;
> +		brightness_b =3D pattern[len - i - 1].brightness;
> +
> +		if (brightness_a !=3D brightness_b) {
> +			ping_pong =3D false;
> +			break;
> +		}
> +	}
> +
> +	if (ping_pong) {
> +		if (len % 2)
> +			hi_pause =3D 0;
> +		else
> +			hi_pause =3D pattern[(len + 1) / 2].delta_t;
> +		lo_pause =3D pattern[len - 1].delta_t;
> +
> +		len =3D (len + 1) / 2;
> +	} else {
> +		hi_pause =3D pattern[len - 1].delta_t;
> +		lo_pause =3D 0;
> +	}
> +
> +	ret =3D lpg_lut_store(lpg, pattern, len, &lo_idx, &hi_idx);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 0; i < led->num_channels; i++) {
> +		chan =3D led->channels[i];
> +
> +		chan->ramp_tick_ms =3D pattern[0].delta_t;
> +		chan->ramp_ping_pong =3D ping_pong;
> +		chan->ramp_oneshot =3D repeat !=3D -1;
> +
> +		chan->ramp_lo_pause_ms =3D lo_pause;
> +		chan->ramp_hi_pause_ms =3D hi_pause;
> +
> +		chan->pattern_lo_idx =3D lo_idx;
> +		chan->pattern_hi_idx =3D hi_idx;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lpg_pattern_single_set(struct led_classdev *cdev,
> +				  struct led_pattern *pattern, u32 len,
> +				  int repeat)
> +{
> +	struct lpg_led *led =3D container_of(cdev, struct lpg_led, cdev);
> +	int ret;
> +
> +	ret =3D lpg_pattern_set(led, pattern, len, repeat);
> +	if (ret < 0)
> +		return ret;
> +
> +	lpg_brightness_single_set(cdev, LED_FULL);
> +
> +	return 0;
> +}
> +
> +static int lpg_pattern_mc_set(struct led_classdev *cdev,
> +			      struct led_pattern *pattern, u32 len,
> +			      int repeat)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lpg_led *led =3D container_of(mc, struct lpg_led, mcdev);
> +	int ret;
> +
> +	ret =3D lpg_pattern_set(led, pattern, len, repeat);
> +	if (ret < 0)
> +		return ret;
> +
> +	led_mc_calc_color_components(mc, LED_FULL);
> +	lpg_brightness_set(led, cdev, mc->subled_info);
> +
> +	return 0;
> +}
> +
> +static int lpg_pattern_clear(struct lpg_led *led)
> +{
> +	struct lpg_channel *chan;
> +	struct lpg *lpg =3D led->lpg;
> +	int i;
> +
> +	chan =3D led->channels[0];
> +	lpg_lut_free(lpg, chan->pattern_lo_idx, chan->pattern_hi_idx);
> +
> +	for (i =3D 0; i < led->num_channels; i++) {
> +		chan =3D led->channels[i];
> +		chan->pattern_lo_idx =3D 0;
> +		chan->pattern_hi_idx =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lpg_pattern_single_clear(struct led_classdev *cdev)
> +{
> +	struct lpg_led *led =3D container_of(cdev, struct lpg_led, cdev);
> +
> +	return lpg_pattern_clear(led);
> +}
> +
> +static int lpg_pattern_mc_clear(struct led_classdev *cdev)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lpg_led *led =3D container_of(mc, struct lpg_led, mcdev);
> +
> +	return lpg_pattern_clear(led);
> +}
> +
> +static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> +	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> +
> +	return chan->in_use ? -EBUSY : 0;
> +}
> +
> +/*
> + * Limitations:
> + * - Updating both duty and period is not done atomically, so the output=
 signal
> + *   will momentarily be a mix of the settings.

Is the PWM well-behaved? (i.e. does it emit the inactive level when
disabled?) Does it complete a period before switching to the new
setting?

Did you test with PWM_DEBUG enabled?

> + */
> +static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> +	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	ret =3D lpg_calc_freq(chan, state->period);
> +	if (ret < 0)
> +		return ret;
> +
> +	lpg_calc_duty(chan, state->duty_cycle);
> +	chan->enabled =3D state->enabled;
> +
> +	lpg_apply(chan);
> +
> +	triled_set(lpg, chan->triled_mask, chan->enabled ? chan->triled_mask : =
0);
> +
> +	return 0;

Would it make sense to skip the calculation if state->enabled is false?

> +}
> +
> +static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      struct pwm_state *state)
> +{
> +	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> +	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> +	u64 duty =3D DIV_ROUND_UP_ULL(chan->pwm_value * chan->period, LPG_RESOL=
UTION - 1);
> +
> +	state->period =3D chan->period;
> +	state->duty_cycle =3D duty;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->enabled =3D chan->enabled;

This doesn't work if .get_state() is called before .apply() was called,
does it?

> +}
> +
> +static const struct pwm_ops lpg_pwm_ops =3D {
> +	.request =3D lpg_pwm_request,
> +	.apply =3D lpg_pwm_apply,
> +	.get_state =3D lpg_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int lpg_add_pwm(struct lpg *lpg)
> +{
> +	int ret;
> +
> +	lpg->pwm.base =3D -1;

I already asked in May to drop this ...

> +	lpg->pwm.dev =3D lpg->dev;
> +	lpg->pwm.npwm =3D lpg->num_channels;
> +	lpg->pwm.ops =3D &lpg_pwm_ops;
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ildntntw4xt2zq7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmH6sWcACgkQwfwUeK3K
7AkZsQf/ekSHHPPUe+0XE/zxXrwezddJ5QzyFn1R7wwYvowi7wja5/3lWUtIMyHh
UzwhUXC3ZM4glUnRxg1rNc13OwXjwpXa5EVQm/LuI32vTrQ09WzmfHiDsNCW9u5y
5pB4rdLSEdbS5rDiI4VxD31NHQK70p2Pivje6SIEiPoQYE0I+jiDj6+ajfHjYs1f
0fu0gix3Y1eBfVNDJenhX5AVcod06lKcE8lxiZUjh9SqJCXMhtSF4JbN2UBhXrNl
82AmXSp6/p7tS+kJpnaRBuJrvobU4byHBf9ly744a08Mpy98TAwNgBo0VYdeSd16
VRtIwN+/UpZO2qBD0q7BrHxoG9qG0w==
=lmRT
-----END PGP SIGNATURE-----

--ildntntw4xt2zq7v--
