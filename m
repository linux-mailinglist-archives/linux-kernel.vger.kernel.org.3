Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB4513ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbiD1R13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346922AbiD1R1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:27:24 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131E5BD2C;
        Thu, 28 Apr 2022 10:24:06 -0700 (PDT)
Received: from g550jk.localnet (84-115-212-237.cable.dynamic.surfer.at [84.115.212.237])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4B0BEC013B;
        Thu, 28 Apr 2022 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1651166644; bh=KAVz8SnDUPaU0etUhWhaplyqRQnuBmbBVO/6b6Agy20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=m0fB+hoYlIgLBpEx/29QGqE9t5pIf7er1Q14Vlpj0KQ1knzRbM4iNCralwvKY1Szs
         Qa1+N57jqrOFceimiiHQ3c7kEn9H0KqLzJBxh7kKsRsUtbHsMPNLxHtYG5Nbo/NDsc
         3M5nA3AghHc630UkMKplT51CV5cG1CuJ9XwWbnPM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
Date:   Thu, 28 Apr 2022 19:23:33 +0200
Message-ID: <11966469.O9o76ZdvQC@g550jk>
In-Reply-To: <20220303214300.59468-2-bjorn.andersson@linaro.org>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org> <20220303214300.59468-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Donnerstag, 3. M=E4rz 2022 22:43:00 CEST Bjorn Andersson wrote:
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
> smartphones etc, for which the driver supports multiple channels to be
> ganged up to a MULTICOLOR LED. In this configuration the pattern
> generators will be synchronized, to allow for multi-color patterns.
>=20
> The idea of modelling this as a LED driver ontop of a PWM driver was
> considered, but setting the properties related to patterns does not fit
> in the PWM API. Similarly the idea of just duplicating the lower bits in
> a PWM and LED driver separately was considered, but this would not allow
> the PWM channels and LEDs to be configured on a per-board basis. The
> driver implements the more complex LED interface, and provides a PWM
> interface on the side of that, in the same driver.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Works fine on qcom-msm8974-fairphone-fp2 which uses the pm8941 PMIC.
Thanks a lot!

Tested-by: Luca Weiss <luca@z3ntu.xyz>

Regards
Luca


> ---
>=20
> Changes since v13:
> - Fixed mixed space/tab indentation in documentation
> - Added 0 as to lpg_clk_rates[] to match the hardware state, to avoid + 1=
 in
> lpg_apply_freq() and - 1 in lpg_pwm_get_state()
> - Don't divide with 0 if current clock is 0 in lpg_pwm_get_state(), just
> return period =3D duty =3D 0 in this case
> - Renamed "clk" in struct lpg_channel to clk_sel
> - Renamed "pre_div" in struct lpg_channel to pre_div_sel
>=20
> Changes since v12:
> - Initialize ret in lpg_pwm_apply()
>=20
> Changes since v11:
> - Extended commit message to cover decision to put pwm_chip in the LED
> driver - Added Documentation, in particular for the hw_pattern format
> - Added a lock to synchronize requests from LED and PWM frameworks
> - Turned out that the 9bit selector differs per channel in some PMICs, so
>   replaced bitmask in lpg_data with lookup based on QPNP SUBTYPE
> - Fixed kerneldoc for the struct device pointer in struct lpg
> - Rewrote conditional in lut_free() to make it easier to read
> - Corrected and deduplicated max_period expression in lpg_calc_freq()
> - Extended nom/dom to numerator/denominator in lpg_calc_freq()
> - Replaced 1 << 9 with LPG_RESOLUTION in one more place in lpg_calc_freq()
> - Use FIELD_PREP() in lpg_apply_freq() as masks was introduced for reading
> the same in get_state()
> - Cleaned up the pattern format, to allow specifying both low and high pa=
use
> with and without pingpong mode.
> - Only update frequency and pwm_value if PWM channel is enabled in
> lpg_pwm_apply - Make lpg_pwm_get_state() read the hardware state, in order
> to pick up e.g. bootloader backlight configuration
> - Use devm_bitmap_zalloc() to allocate the lut_bitmap
> - Use dev_err_probe() in lpg_probe()
> - Extended Kconfig help text to mention module name and satisfy checkpatch
>=20
>  Documentation/leds/leds-qcom-lpg.rst |   76 ++
>  drivers/leds/Kconfig                 |    3 +
>  drivers/leds/Makefile                |    3 +
>  drivers/leds/rgb/Kconfig             |   18 +
>  drivers/leds/rgb/Makefile            |    3 +
>  drivers/leds/rgb/leds-qcom-lpg.c     | 1405 ++++++++++++++++++++++++++
>  6 files changed, 1508 insertions(+)
>  create mode 100644 Documentation/leds/leds-qcom-lpg.rst
>  create mode 100644 drivers/leds/rgb/Kconfig
>  create mode 100644 drivers/leds/rgb/Makefile
>  create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c
>=20
> diff --git a/Documentation/leds/leds-qcom-lpg.rst
> b/Documentation/leds/leds-qcom-lpg.rst new file mode 100644
> index 000000000000..f12416f02dd8
> --- /dev/null
> +++ b/Documentation/leds/leds-qcom-lpg.rst
> @@ -0,0 +1,76 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +Kernel driver for Qualcomm LPG
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Description
> +-----------
> +
> +The Qualcomm LPG can be found in a variety of Qualcomm PMICs and consists
> of a +number of PWM channels, a programmable pattern lookup table and a R=
GB
> LED +current sink.
> +
> +To facilitate the various use cases, the LPG channels can be exposed as
> +individual LEDs, grouped together as RGB LEDs or otherwise be accessed as
> PWM +channels. The output of each PWM channel is routed to other hardware
> +blocks, such as the RGB current sink, GPIO pins etc.
> +
> +The each PWM channel can operate with a period between 27us and 384 seco=
nds
> and +has a 9 bit resolution of the duty cycle.
> +
> +In order to provide support for status notifications with the CPU subsys=
tem
> in +deeper idle states the LPG provides pattern support. This consists of=
 a
> shared +lookup table of brightness values and per channel properties to
> select the +range within the table to use, the rate and if the pattern
> should repeat. +
> +The pattern for a channel can be programmed using the "pattern" trigger,
> using +the hw_pattern attribute.
> +
> +/sys/class/leds/<led>/hw_pattern
> +--------------------------------
> +
> +Specify a hardware pattern for a Qualcomm LPG LED.
> +
> +The pattern is a series of brightness and hold-time pairs, with the
> hold-time +expressed in milliseconds. The hold time is a property of the
> pattern and must +therefor be identical for each element in the pattern
> (except for the pauses +described below).
> +
> +Simple pattern::
> +
> +    "255 500 0 500"
> +
> +        ^
> +        |
> +    255 +----+    +----+
> +        |    |    |    |      ...
> +      0 |    +----+    +----
> +        +---------------------->
> +        0    5   10   15     time (100ms)
> +
> +The LPG supports specifying a longer hold-time for the first and last
> element +in the pattern, the so called "low pause" and "high pause".
> +
> +Low-pause pattern::
> +
> +    "255 1000 0 500 255 500 0 500"
> +
> +        ^
> +        |
> +    255 +--------+    +----+    +----+    +--------+
> +        |        |    |    |    |    |    |        |      ...
> +      0 |        +----+    +----+    +----+        +----
> +        +----------------------------->
> +        0    5   10   15  20   25   time (100ms)
> +
> +Similarily, the last entry can be stretched by using a higher hold-time =
on
> the +last entry.
> +
> +In order to save space in the shared lookup table the LPG supports
> "ping-pong" +mode, in which case each run through the pattern is performed
> by first running +the pattern forward, then backwards. This mode is
> automatically used by the +driver when the given pattern is a palindrome.
> In this case the "high pause" +denotes the wait time before the pattern is
> run in reverse and as such the +specified hold-time of the middle item in
> the pattern is allowed to have a +different hold-time.
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6090e647daee..a49979f41eee 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -869,6 +869,9 @@ source "drivers/leds/blink/Kconfig"
>  comment "Flash and Torch LED drivers"
>  source "drivers/leds/flash/Kconfig"
>=20
> +comment "RGB LED drivers"
> +source "drivers/leds/rgb/Kconfig"
> +
>  comment "LED Triggers"
>  source "drivers/leds/trigger/Kconfig"
>=20
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index e58ecb36360f..4fd2f92cd198 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -99,6 +99,9 @@ obj-$(CONFIG_LEDS_USER)			+=3D uleds.o
>  # Flash and Torch LED Drivers
>  obj-$(CONFIG_LEDS_CLASS_FLASH)		+=3D flash/
>=20
> +# RGB LED Drivers
> +obj-$(CONFIG_LEDS_CLASS_MULTICOLOR)	+=3D rgb/
> +
>  # LED Triggers
>  obj-$(CONFIG_LEDS_TRIGGERS)		+=3D trigger/
>=20
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> new file mode 100644
> index 000000000000..5dd27ad80856
> --- /dev/null
> +++ b/drivers/leds/rgb/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if LEDS_CLASS_MULTICOLOR
> +
> +config LEDS_QCOM_LPG
> +	tristate "LED support for Qualcomm LPG"
> +	depends on OF
> +	depends on SPMI
> +	help
> +	  This option enables support for the Light Pulse Generator found=20
in a
> +	  wide variety of Qualcomm PMICs. The LPG consists of a number of=20
PWM
> +	  channels and typically a shared pattern lookup table and a=20
current
> +	  sink, intended to drive RGB LEDs. Each channel can either be used=20
as
> +	  a LED, grouped to represent a RGB LED or exposed as PWM channels.
> +
> +	  If compiled as a module, the module will be named leds-qcom-lpg.
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
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c
> b/drivers/leds/rgb/leds-qcom-lpg.c new file mode 100644
> index 000000000000..17576f77c423
> --- /dev/null
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -0,0 +1,1405 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2017-2022 Linaro Ltd
> + * Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.
> + */
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define LPG_SUBTYPE_REG		0x05
> +#define  LPG_SUBTYPE_LPG	0x2
> +#define  LPG_SUBTYPE_PWM	0xb
> +#define  LPG_SUBTYPE_LPG_LITE	0x11
> +#define LPG_PATTERN_CONFIG_REG	0x40
> +#define LPG_SIZE_CLK_REG	0x41
> +#define  PWM_CLK_SELECT_MASK	GENMASK(1, 0)
> +#define LPG_PREDIV_CLK_REG	0x42
> +#define  PWM_FREQ_PRE_DIV_MASK	GENMASK(6, 5)
> +#define  PWM_FREQ_EXP_MASK	GENMASK(2, 0)
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
> + * @dev:	pointer to LPG device
> + * @map:	regmap for register access
> + * @lock:	used to synchronize LED and pwm callback requests
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
> +	struct mutex lock;
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
> + * @lut_mask:	mask in LUT to start pattern generator for this=20
channel
> + * @subtype:	PMIC hardware block subtype
> + * @in_use:	channel is exposed to LED framework
> + * @color:	color of the LED attached to this channel
> + * @dtest_line:	DTEST line for output, or 0 if disabled
> + * @dtest_value: DTEST line configuration
> + * @pwm_value:	duty (in microseconds) of the generated pulses,=20
overridden
> by LUT + * @enabled:	output enabled?
> + * @period:	period (in nanoseconds) of the generated pulses
> + * @clk_sel:	reference clock frequency selector
> + * @pre_div_sel: divider selector of the reference clock
> + * @pre_div_exp: exponential divider of the reference clock
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
> +	unsigned int subtype;
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
> +	unsigned int clk_sel;
> +	unsigned int pre_div_sel;
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
> + * @num_channels:	number of channels in LPG
> + * @channels:		list of channel initialization data
> + */
> +struct lpg_data {
> +	unsigned int lut_base;
> +	unsigned int lut_size;
> +	unsigned int triled_base;
> +	bool triled_has_atc_ctl;
> +	bool triled_has_src_sel;
> +	int num_channels;
> +	const struct lpg_channel_data *channels;
> +};
> +
> +static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int
> enable) +{
> +	/* Skip if we don't have a triled block */
> +	if (!lpg->triled_base)
> +		return 0;
> +
> +	return regmap_update_bits(lpg->map, lpg->triled_base +=20
TRI_LED_EN_CTL,
> +				  mask, enable);
> +}
> +
> +static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
> +			 size_t len, unsigned int *lo_idx, unsigned=20
int *hi_idx)
> +{
> +	unsigned int idx;
> +	u16 val;
> +	int i;
> +
> +	idx =3D bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
> +					 0, len, 0);
> +	if (idx >=3D lpg->lut_size)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < len; i++) {
> +		val =3D pattern[i].brightness;
> +
> +		regmap_bulk_write(lpg->map, lpg->lut_base +=20
LPG_LUT_REG(idx + i),
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
int
> hi_idx) +{
> +	int len;
> +
> +	len =3D hi_idx - lo_idx + 1;
> +	if (len =3D=3D 1)
> +		return;
> +
> +	bitmap_clear(lpg->lut_bitmap, lo_idx, len);
> +}
> +
> +static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
> +{
> +	return regmap_write(lpg->map, lpg->lut_base + RAMP_CONTROL_REG,=20
mask);
> +}
> +
> +static const unsigned int lpg_clk_rates[] =3D {0, 1024, 32768, 19200000};
> +static const unsigned int lpg_pre_divs[] =3D {1, 3, 5, 6};
> +
> +static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> +{
> +	unsigned int clk_sel, best_clk =3D 0;
> +	unsigned int div, best_div =3D 0;
> +	unsigned int m, best_m =3D 0;
> +	unsigned int error;
> +	unsigned int best_err =3D UINT_MAX;
> +	u64 best_period =3D 0;
> +	u64 max_period;
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
> +	 * This allows for periods between 27uS and 384s, as the PWM=20
framework
> +	 * wants a period of equal or lower length than requested, reject
> +	 * anything below 27uS.
> +	 */
> +	if (period <=3D (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
> +		return -EINVAL;
> +
> +	/* Limit period to largest possible value, to avoid overflows */
> +	max_period =3D (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 <<=20
LPG_MAX_M) /
> 1024; +	if (period > max_period)
> +		period =3D max_period;
> +
> +	/*
> +	 * Search for the pre_div, refclk and M by solving the rewritten=20
formula
> +	 * for each refclk and pre_div value:
> +	 *
> +	 *                     period * refclk
> +	 * M =3D log2 -------------------------------------
> +	 *           NSEC_PER_SEC * pre_div * resolution
> +	 */
> +	for (clk_sel =3D 1; clk_sel < ARRAY_SIZE(lpg_clk_rates); clk_sel++) {
> +		u64 numerator =3D period * lpg_clk_rates[clk_sel];
> +
> +		for (div =3D 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
> +			u64 denominator =3D (u64)NSEC_PER_SEC *=20
lpg_pre_divs[div] *
> LPG_RESOLUTION; +			u64 actual;
> +			u64 ratio;
> +
> +			if (numerator < denominator)
> +				continue;
> +
> +			ratio =3D div64_u64(numerator, denominator);
> +			m =3D ilog2(ratio);
> +			if (m > LPG_MAX_M)
> +				m =3D LPG_MAX_M;
> +
> +			actual =3D DIV_ROUND_UP_ULL(denominator * (1 <<=20
m),
> lpg_clk_rates[clk_sel]); +
> +			error =3D period - actual;
> +			if (error < best_err) {
> +				best_err =3D error;
> +
> +				best_div =3D div;
> +				best_m =3D m;
> +				best_clk =3D clk_sel;
> +				best_period =3D actual;
> +			}
> +		}
> +	}
> +
> +	chan->clk_sel =3D best_clk;
> +	chan->pre_div_sel =3D best_div;
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
> +	val =3D div64_u64(duty * lpg_clk_rates[chan->clk_sel],
> +			(u64)NSEC_PER_SEC * lpg_pre_divs[chan-
>pre_div_sel] * (1 <<
> chan->pre_div_exp)); +
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
> +	val =3D chan->clk_sel;
> +
> +	/* Specify 9bit resolution, based on the subtype of the channel */
> +	switch (chan->subtype) {
> +	case LPG_SUBTYPE_LPG:
> +		val |=3D GENMASK(5, 4);
> +		break;
> +	case LPG_SUBTYPE_PWM:
> +		val |=3D BIT(2);
> +		break;
> +	case LPG_SUBTYPE_LPG_LITE:
> +	default:
> +		val |=3D BIT(4);
> +		break;
> +	}
> +
> +	regmap_write(lpg->map, chan->base + LPG_SIZE_CLK_REG, val);
> +
> +	val =3D FIELD_PREP(PWM_FREQ_PRE_DIV_MASK, chan->pre_div_sel) |
> +	      FIELD_PREP(PWM_FREQ_EXP_MASK, chan->pre_div_exp);
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
> +	regmap_bulk_write(lpg->map, chan->base + PWM_VALUE_REG, &val,
> sizeof(val)); +}
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
> +	if (!chan->ramp_enabled || chan->pattern_lo_idx =3D=3D chan-
>pattern_hi_idx)
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
> +	regmap_bulk_write(lpg->map, chan->base + LPG_RAMP_DURATION_REG,=20
&step,
> sizeof(step)); +	regmap_write(lpg->map, chan->base +=20
LPG_HI_PAUSE_REG,
> hi_pause); +	regmap_write(lpg->map, chan->base + LPG_LO_PAUSE_REG,
> lo_pause); +}
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
> +		ret =3D of_property_read_u32_index(np, "qcom,dtest", i *=20
2,
> +						 &chan-
>dtest_line);
> +		if (ret)
> +			goto err_malformed;
> +
> +		ret =3D of_property_read_u32_index(np, "qcom,dtest", i * 2=20
+ 1,
> +						 &chan-
>dtest_value);
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
> +	regmap_write(lpg->map, chan->base + PWM_DTEST_REG(chan-
>dtest_line),
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
> +static void lpg_brightness_set(struct lpg_led *led, struct led_classdev
> *cdev, +			       struct mc_subled *subleds)
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
> +		} else if (chan->pattern_lo_idx !=3D chan->pattern_hi_idx)=20
{
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
> +			duty =3D div_u64(brightness * chan->period,=20
cdev->max_brightness);
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
> +	mutex_lock(&led->lpg->lock);
> +
> +	info.brightness =3D value;
> +	lpg_brightness_set(led, cdev, &info);
> +
> +	mutex_unlock(&led->lpg->lock);
> +}
> +
> +static void lpg_brightness_mc_set(struct led_classdev *cdev,
> +				  enum led_brightness value)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lpg_led *led =3D container_of(mc, struct lpg_led, mcdev);
> +
> +	mutex_lock(&led->lpg->lock);
> +
> +	led_mc_calc_color_components(mc, value);
> +	lpg_brightness_set(led, cdev, mc->subled_info);
> +
> +	mutex_unlock(&led->lpg->lock);
> +}
> +
> +static int lpg_blink_set(struct lpg_led *led,
> +			 unsigned long *delay_on, unsigned long=20
*delay_off)
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
> +				unsigned long *delay_on, unsigned=20
long *delay_off)
> +{
> +	struct lpg_led *led =3D container_of(cdev, struct lpg_led, cdev);
> +	int ret;
> +
> +	mutex_lock(&led->lpg->lock);
> +
> +	ret =3D lpg_blink_set(led, delay_on, delay_off);
> +
> +	mutex_unlock(&led->lpg->lock);
> +
> +	return ret;
> +}
> +
> +static int lpg_blink_mc_set(struct led_classdev *cdev,
> +			    unsigned long *delay_on, unsigned long=20
*delay_off)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lpg_led *led =3D container_of(mc, struct lpg_led, mcdev);
> +	int ret;
> +
> +	mutex_lock(&led->lpg->lock);
> +
> +	ret =3D lpg_blink_set(led, delay_on, delay_off);
> +
> +	mutex_unlock(&led->lpg->lock);
> +
> +	return ret;
> +}
> +
> +static int lpg_pattern_set(struct lpg_led *led, struct led_pattern
> *pattern, +			   u32 len, int repeat)
> +{
> +	struct lpg_channel *chan;
> +	struct lpg *lpg =3D led->lpg;
> +	unsigned int brightness_a;
> +	unsigned int brightness_b;
> +	unsigned int actual_len;
> +	unsigned int hi_pause;
> +	unsigned int lo_pause;
> +	unsigned int delta_t;
> +	unsigned int lo_idx;
> +	unsigned int hi_idx;
> +	unsigned int i;
> +	bool ping_pong =3D true;
> +	int ret;
> +
> +	/* Hardware only support oneshot or indefinite loops */
> +	if (repeat !=3D -1 && repeat !=3D 1)
> +		return -EINVAL;
> +
> +	/*
> +	 * Specifying a pattern of length 1 causes the hardware to iterate
> +	 * through the entire LUT, so prohibit this.
> +	 */
> +	if (len < 2)
> +		return -EINVAL;
> +
> +	/*
> +	 * The LPG plays patterns with at a fixed pace, a "low pause" can be
> +	 * used to stretch the first delay of the pattern and a "high pause"
> +	 * the last one.
> +	 *
> +	 * In order to save space the pattern can be played in "ping pong"
> +	 * mode, in which the pattern is first played forward, then "high
> +	 * pause" is applied, then the pattern is played backwards and=20
finally
> +	 * the "low pause" is applied.
> +	 *
> +	 * The middle elements of the pattern are used to determine delta_t=20
and
> +	 * the "low pause" and "high pause" multipliers are derrived from=20
this.
> +	 *
> +	 * The first element in the pattern is used to determine "low=20
pause".
> +	 *
> +	 * If the specified pattern is a palindrome the ping pong mode is
> +	 * enabled. In this scenario the delta_t of the middle entry (i.e.=20
the
> +	 * last in the programmed pattern) determines the "high pause".
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
> +	/* The pattern length to be written to the LUT */
> +	if (ping_pong)
> +		actual_len =3D (len + 1) / 2;
> +	else
> +		actual_len =3D len;
> +
> +	/*
> +	 * Validate that all delta_t in the pattern are the same, with the
> +	 * exception of the middle element in case of ping_pong.
> +	 */
> +	delta_t =3D pattern[1].delta_t;
> +	for (i =3D 2; i < len; i++) {
> +		if (pattern[i].delta_t !=3D delta_t) {
> +			/*
> +			 * Allow last entry in the full or shortened=20
pattern to
> +			 * specify hi pause. Reject other variations.
> +			 */
> +			if (i !=3D actual_len - 1)
> +				return -EINVAL;
> +		}
> +	}
> +
> +	/* LPG_RAMP_DURATION_REG is a 9bit */
> +	if (delta_t >=3D BIT(9))
> +		return -EINVAL;
> +
> +	/* Find "low pause" and "high pause" in the pattern */
> +	lo_pause =3D pattern[0].delta_t;
> +	hi_pause =3D pattern[actual_len - 1].delta_t;
> +
> +	mutex_lock(&lpg->lock);
> +	ret =3D lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	for (i =3D 0; i < led->num_channels; i++) {
> +		chan =3D led->channels[i];
> +
> +		chan->ramp_tick_ms =3D delta_t;
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
> +out_unlock:
> +	mutex_unlock(&lpg->lock);
> +
> +	return ret;
> +}
> +
> +static int lpg_pattern_single_set(struct led_classdev *cdev,
> +				  struct led_pattern *pattern, u32=20
len,
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
> +	mutex_lock(&lpg->lock);
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
> +	mutex_unlock(&lpg->lock);
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
> + * - Updating both duty and period is not done atomically, so the output
> signal + *   will momentarily be a mix of the settings.
> + * - Changed parameters takes effect immediately.
> + * - A disabled channel outputs a logical 0.
> + */
> +static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> +	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> +	int ret =3D 0;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	mutex_lock(&lpg->lock);
> +
> +	if (state->enabled) {
> +		ret =3D lpg_calc_freq(chan, state->period);
> +		if (ret < 0)
> +			goto out_unlock;
> +
> +		lpg_calc_duty(chan, state->duty_cycle);
> +	}
> +	chan->enabled =3D state->enabled;
> +
> +	lpg_apply(chan);
> +
> +	triled_set(lpg, chan->triled_mask, chan->enabled ? chan-
>triled_mask : 0);
> +
> +out_unlock:
> +	mutex_unlock(&lpg->lock);
> +
> +	return ret;
> +}
> +
> +static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device
> *pwm, +			      struct pwm_state *state)
> +{
> +	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> +	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> +	unsigned int pre_div;
> +	unsigned int refclk;
> +	unsigned int val;
> +	unsigned int m;
> +	u16 pwm_value;
> +	int ret;
> +
> +	ret =3D regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
> +	if (ret)
> +		return;
> +
> +	refclk =3D lpg_clk_rates[val & PWM_CLK_SELECT_MASK];
> +	if (refclk) {
> +		ret =3D regmap_read(lpg->map, chan->base +=20
LPG_PREDIV_CLK_REG, &val);
> +		if (ret)
> +			return;
> +
> +		pre_div =3D lpg_pre_divs[FIELD_GET(PWM_FREQ_PRE_DIV_MASK,=20
val)];
> +		m =3D FIELD_GET(PWM_FREQ_EXP_MASK, val);
> +
> +		ret =3D regmap_bulk_read(lpg->map, chan->base +=20
PWM_VALUE_REG, &pwm_value,
> sizeof(pwm_value)); +		if (ret)
> +			return;
> +
> +		state->period =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC *=20
LPG_RESOLUTION *
> pre_div * (1 << m), refclk); +		state->duty_cycle =3D
> DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m),
> refclk); +	} else {
> +		state->period =3D 0;
> +		state->duty_cycle =3D 0;
> +	}
> +
> +	ret =3D regmap_read(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG,=20
&val);
> +	if (ret)
> +		return;
> +
> +	state->enabled =3D FIELD_GET(LPG_ENABLE_CONTROL_OUTPUT, val);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	if (state->duty_cycle > state->period)
> +		state->duty_cycle =3D state->period;
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
> +	lpg->pwm.dev =3D lpg->dev;
> +	lpg->pwm.npwm =3D lpg->num_channels;
> +	lpg->pwm.ops =3D &lpg_pwm_ops;
> +
> +	ret =3D pwmchip_add(&lpg->pwm);
> +	if (ret)
> +		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n",=20
ret);
> +
> +	return ret;
> +}
> +
> +static int lpg_parse_channel(struct lpg *lpg, struct device_node *np,
> +			     struct lpg_channel **channel)
> +{
> +	struct lpg_channel *chan;
> +	u32 color =3D LED_COLOR_ID_GREEN;
> +	u32 reg;
> +	int ret;
> +
> +	ret =3D of_property_read_u32(np, "reg", &reg);
> +	if (ret || !reg || reg > lpg->num_channels) {
> +		dev_err(lpg->dev, "invalid \"reg\" of %pOFn\n", np);
> +		return -EINVAL;
> +	}
> +
> +	chan =3D &lpg->channels[reg - 1];
> +	chan->in_use =3D true;
> +
> +	ret =3D of_property_read_u32(np, "color", &color);
> +	if (ret < 0 && ret !=3D -EINVAL) {
> +		dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n",=20
np);
> +		return ret;
> +	}
> +
> +	chan->color =3D color;
> +
> +	*channel =3D chan;
> +
> +	return 0;
> +}
> +
> +static int lpg_add_led(struct lpg *lpg, struct device_node *np)
> +{
> +	struct led_init_data init_data =3D {};
> +	struct led_classdev *cdev;
> +	struct device_node *child;
> +	struct mc_subled *info;
> +	struct lpg_led *led;
> +	const char *state;
> +	int num_channels;
> +	u32 color =3D 0;
> +	int ret;
> +	int i;
> +
> +	ret =3D of_property_read_u32(np, "color", &color);
> +	if (ret < 0 && ret !=3D -EINVAL) {
> +		dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n",=20
np);
> +		return ret;
> +	}
> +
> +	if (color =3D=3D LED_COLOR_ID_RGB)
> +		num_channels =3D of_get_available_child_count(np);
> +	else
> +		num_channels =3D 1;
> +
> +	led =3D devm_kzalloc(lpg->dev, struct_size(led, channels,=20
num_channels),
> GFP_KERNEL); +	if (!led)
> +		return -ENOMEM;
> +
> +	led->lpg =3D lpg;
> +	led->num_channels =3D num_channels;
> +
> +	if (color =3D=3D LED_COLOR_ID_RGB) {
> +		info =3D devm_kcalloc(lpg->dev, num_channels,=20
sizeof(*info), GFP_KERNEL);
> +		if (!info)
> +			return -ENOMEM;
> +		i =3D 0;
> +		for_each_available_child_of_node(np, child) {
> +			ret =3D lpg_parse_channel(lpg, child, &led-
>channels[i]);
> +			if (ret < 0)
> +				return ret;
> +
> +			info[i].color_index =3D led->channels[i]-
>color;
> +			info[i].intensity =3D 0;
> +			i++;
> +		}
> +
> +		led->mcdev.subled_info =3D info;
> +		led->mcdev.num_colors =3D num_channels;
> +
> +		cdev =3D &led->mcdev.led_cdev;
> +		cdev->brightness_set =3D lpg_brightness_mc_set;
> +		cdev->blink_set =3D lpg_blink_mc_set;
> +
> +		/* Register pattern accessors only if we have a LUT=20
block */
> +		if (lpg->lut_base) {
> +			cdev->pattern_set =3D lpg_pattern_mc_set;
> +			cdev->pattern_clear =3D lpg_pattern_mc_clear;
> +		}
> +	} else {
> +		ret =3D lpg_parse_channel(lpg, np, &led->channels[0]);
> +		if (ret < 0)
> +			return ret;
> +
> +		cdev =3D &led->cdev;
> +		cdev->brightness_set =3D lpg_brightness_single_set;
> +		cdev->blink_set =3D lpg_blink_single_set;
> +
> +		/* Register pattern accessors only if we have a LUT=20
block */
> +		if (lpg->lut_base) {
> +			cdev->pattern_set =3D lpg_pattern_single_set;
> +			cdev->pattern_clear =3D=20
lpg_pattern_single_clear;
> +		}
> +	}
> +
> +	cdev->default_trigger =3D of_get_property(np, "linux,default-
trigger",
> NULL); +	cdev->max_brightness =3D LPG_RESOLUTION - 1;
> +
> +	if (!of_property_read_string(np, "default-state", &state) &&
> +	    !strcmp(state, "on"))
> +		cdev->brightness =3D cdev->max_brightness;
> +	else
> +		cdev->brightness =3D LED_OFF;
> +
> +	cdev->brightness_set(cdev, cdev->brightness);
> +
> +	init_data.fwnode =3D of_fwnode_handle(np);
> +
> +	if (color =3D=3D LED_COLOR_ID_RGB)
> +		ret =3D devm_led_classdev_multicolor_register_ext(lpg-
>dev, &led->mcdev,
> &init_data); +	else
> +		ret =3D devm_led_classdev_register_ext(lpg->dev, &led-
>cdev, &init_data);
> +	if (ret)
> +		dev_err(lpg->dev, "unable to register %s\n", cdev-
>name);
> +
> +	return ret;
> +}
> +
> +static int lpg_init_channels(struct lpg *lpg)
> +{
> +	const struct lpg_data *data =3D lpg->data;
> +	struct lpg_channel *chan;
> +	int i;
> +
> +	lpg->num_channels =3D data->num_channels;
> +	lpg->channels =3D devm_kcalloc(lpg->dev, data->num_channels,
> +				     sizeof(struct lpg_channel),=20
GFP_KERNEL);
> +	if (!lpg->channels)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < data->num_channels; i++) {
> +		chan =3D &lpg->channels[i];
> +
> +		chan->lpg =3D lpg;
> +		chan->base =3D data->channels[i].base;
> +		chan->triled_mask =3D data->channels[i].triled_mask;
> +		chan->lut_mask =3D BIT(i);
> +
> +		regmap_read(lpg->map, chan->base + LPG_SUBTYPE_REG,=20
&chan->subtype);
> +	}
> +
> +	return 0;
> +}
> +
> +static int lpg_init_triled(struct lpg *lpg)
> +{
> +	struct device_node *np =3D lpg->dev->of_node;
> +	int ret;
> +
> +	/* Skip initialization if we don't have a triled block */
> +	if (!lpg->data->triled_base)
> +		return 0;
> +
> +	lpg->triled_base =3D lpg->data->triled_base;
> +	lpg->triled_has_atc_ctl =3D lpg->data->triled_has_atc_ctl;
> +	lpg->triled_has_src_sel =3D lpg->data->triled_has_src_sel;
> +
> +	if (lpg->triled_has_src_sel) {
> +		ret =3D of_property_read_u32(np, "qcom,power-source",=20
&lpg->triled_src);
> +		if (ret || lpg->triled_src =3D=3D 2 || lpg->triled_src > 3)=20
{
> +			dev_err(lpg->dev, "invalid power source\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Disable automatic trickle charge LED */
> +	if (lpg->triled_has_atc_ctl)
> +		regmap_write(lpg->map, lpg->triled_base +=20
TRI_LED_ATC_CTL, 0);
> +
> +	/* Configure power source */
> +	if (lpg->triled_has_src_sel)
> +		regmap_write(lpg->map, lpg->triled_base +=20
TRI_LED_SRC_SEL,
> lpg->triled_src); +
> +	/* Default all outputs to off */
> +	regmap_write(lpg->map, lpg->triled_base + TRI_LED_EN_CTL, 0);
> +
> +	return 0;
> +}
> +
> +static int lpg_init_lut(struct lpg *lpg)
> +{
> +	const struct lpg_data *data =3D lpg->data;
> +
> +	if (!data->lut_base)
> +		return 0;
> +
> +	lpg->lut_base =3D data->lut_base;
> +	lpg->lut_size =3D data->lut_size;
> +
> +	lpg->lut_bitmap =3D devm_bitmap_zalloc(lpg->dev, lpg->lut_size,=20
GFP_KERNEL);
> +	if (!lpg->lut_bitmap)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int lpg_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct lpg *lpg;
> +	int ret;
> +	int i;
> +
> +	lpg =3D devm_kzalloc(&pdev->dev, sizeof(*lpg), GFP_KERNEL);
> +	if (!lpg)
> +		return -ENOMEM;
> +
> +	lpg->data =3D of_device_get_match_data(&pdev->dev);
> +	if (!lpg->data)
> +		return -EINVAL;
> +
> +	platform_set_drvdata(pdev, lpg);
> +
> +	lpg->dev =3D &pdev->dev;
> +	mutex_init(&lpg->lock);
> +
> +	lpg->map =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!lpg->map)
> +		return dev_err_probe(&pdev->dev, -ENXIO, "parent regmap=20
unavailable\n");
> +
> +	ret =3D lpg_init_channels(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D lpg_parse_dtest(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D lpg_init_triled(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D lpg_init_lut(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		ret =3D lpg_add_led(lpg, np);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < lpg->num_channels; i++)
> +		lpg_apply_dtest(&lpg->channels[i]);
> +
> +	return lpg_add_pwm(lpg);
> +}
> +
> +static int lpg_remove(struct platform_device *pdev)
> +{
> +	struct lpg *lpg =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&lpg->pwm);
> +
> +	return 0;
> +}
> +
> +static const struct lpg_data pm8916_pwm_data =3D {
> +	.num_channels =3D 1,
> +	.channels =3D (const struct lpg_channel_data[]) {
> +		{ .base =3D 0xbc00 },
> +	},
> +};
> +
> +static const struct lpg_data pm8941_lpg_data =3D {
> +	.lut_base =3D 0xb000,
> +	.lut_size =3D 64,
> +
> +	.triled_base =3D 0xd000,
> +	.triled_has_atc_ctl =3D true,
> +	.triled_has_src_sel =3D true,
> +
> +	.num_channels =3D 8,
> +	.channels =3D (const struct lpg_channel_data[]) {
> +		{ .base =3D 0xb100 },
> +		{ .base =3D 0xb200 },
> +		{ .base =3D 0xb300 },
> +		{ .base =3D 0xb400 },
> +		{ .base =3D 0xb500, .triled_mask =3D BIT(5) },
> +		{ .base =3D 0xb600, .triled_mask =3D BIT(6) },
> +		{ .base =3D 0xb700, .triled_mask =3D BIT(7) },
> +		{ .base =3D 0xb800 },
> +	},
> +};
> +
> +static const struct lpg_data pm8994_lpg_data =3D {
> +	.lut_base =3D 0xb000,
> +	.lut_size =3D 64,
> +
> +	.num_channels =3D 6,
> +	.channels =3D (const struct lpg_channel_data[]) {
> +		{ .base =3D 0xb100 },
> +		{ .base =3D 0xb200 },
> +		{ .base =3D 0xb300 },
> +		{ .base =3D 0xb400 },
> +		{ .base =3D 0xb500 },
> +		{ .base =3D 0xb600 },
> +	},
> +};
> +
> +static const struct lpg_data pmi8994_lpg_data =3D {
> +	.lut_base =3D 0xb000,
> +	.lut_size =3D 24,
> +
> +	.triled_base =3D 0xd000,
> +	.triled_has_atc_ctl =3D true,
> +	.triled_has_src_sel =3D true,
> +
> +	.num_channels =3D 4,
> +	.channels =3D (const struct lpg_channel_data[]) {
> +		{ .base =3D 0xb100, .triled_mask =3D BIT(5) },
> +		{ .base =3D 0xb200, .triled_mask =3D BIT(6) },
> +		{ .base =3D 0xb300, .triled_mask =3D BIT(7) },
> +		{ .base =3D 0xb400 },
> +	},
> +};
> +
> +static const struct lpg_data pmi8998_lpg_data =3D {
> +	.lut_base =3D 0xb000,
> +	.lut_size =3D 49,
> +
> +	.triled_base =3D 0xd000,
> +
> +	.num_channels =3D 6,
> +	.channels =3D (const struct lpg_channel_data[]) {
> +		{ .base =3D 0xb100 },
> +		{ .base =3D 0xb200 },
> +		{ .base =3D 0xb300, .triled_mask =3D BIT(5) },
> +		{ .base =3D 0xb400, .triled_mask =3D BIT(6) },
> +		{ .base =3D 0xb500, .triled_mask =3D BIT(7) },
> +		{ .base =3D 0xb600 },
> +	},
> +};
> +
> +static const struct lpg_data pm8150b_lpg_data =3D {
> +	.lut_base =3D 0xb000,
> +	.lut_size =3D 24,
> +
> +	.triled_base =3D 0xd000,
> +
> +	.num_channels =3D 2,
> +	.channels =3D (const struct lpg_channel_data[]) {
> +		{ .base =3D 0xb100, .triled_mask =3D BIT(7) },
> +		{ .base =3D 0xb200, .triled_mask =3D BIT(6) },
> +	},
> +};
> +
> +static const struct lpg_data pm8150l_lpg_data =3D {
> +	.lut_base =3D 0xb000,
> +	.lut_size =3D 48,
> +
> +	.triled_base =3D 0xd000,
> +
> +	.num_channels =3D 5,
> +	.channels =3D (const struct lpg_channel_data[]) {
> +		{ .base =3D 0xb100, .triled_mask =3D BIT(7) },
> +		{ .base =3D 0xb200, .triled_mask =3D BIT(6) },
> +		{ .base =3D 0xb300, .triled_mask =3D BIT(5) },
> +		{ .base =3D 0xbc00 },
> +		{ .base =3D 0xbd00 },
> +
> +	},
> +};
> +
> +static const struct of_device_id lpg_of_table[] =3D {
> +	{ .compatible =3D "qcom,pm8150b-lpg", .data =3D &pm8150b_lpg_data },
> +	{ .compatible =3D "qcom,pm8150l-lpg", .data =3D &pm8150l_lpg_data },
> +	{ .compatible =3D "qcom,pm8916-pwm", .data =3D &pm8916_pwm_data },
> +	{ .compatible =3D "qcom,pm8941-lpg", .data =3D &pm8941_lpg_data },
> +	{ .compatible =3D "qcom,pm8994-lpg", .data =3D &pm8994_lpg_data },
> +	{ .compatible =3D "qcom,pmi8994-lpg", .data =3D &pmi8994_lpg_data },
> +	{ .compatible =3D "qcom,pmi8998-lpg", .data =3D &pmi8998_lpg_data },
> +	{ .compatible =3D "qcom,pmc8180c-lpg", .data =3D &pm8150l_lpg_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, lpg_of_table);
> +
> +static struct platform_driver lpg_driver =3D {
> +	.probe =3D lpg_probe,
> +	.remove =3D lpg_remove,
> +	.driver =3D {
> +		.name =3D "qcom-spmi-lpg",
> +		.of_match_table =3D lpg_of_table,
> +	},
> +};
> +module_platform_driver(lpg_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm LPG LED driver");
> +MODULE_LICENSE("GPL v2");




