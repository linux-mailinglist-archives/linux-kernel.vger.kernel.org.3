Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C574CC83D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbiCCVmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiCCVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:42:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75DC6542C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:41:13 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id y7so6067698oih.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 13:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFMV3rsDKVw2n1YUr3j7delB1SYeXO2cmEYputxt9fo=;
        b=pROtTl1j6Ii/Mc2t0i1ldI0D/X0p6/vTdUOo5n5D9DvgxolAvRfBNMqmHbvC4N5Sqn
         rO5ltwONOIgWQHUqtQPgw114nm1D1WFHsV22noC17dFqfVtaPW3AhCmEXUEppcY+X33U
         q953d2ZcalrXwb9imyGPLcu9kO2i1c2KL/SeqKQJgLm1FNyeknIhrxxZejKaNpCgKPwB
         LfVPGa5vmUAXfMQbCaokzQ0H+M0S4au09wZDmFzuuXluwhRpY2Xk3J7Dva3AsPpY3dUa
         7O2ObE+XPShOpfu9sQcQZkZNQd5vhPNwx/s0ywc6hsnsJfehAUJiz1/70GdYgqhoct8R
         Dp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFMV3rsDKVw2n1YUr3j7delB1SYeXO2cmEYputxt9fo=;
        b=ENjWDWERTKhaVWutg7Mz65tC5mNCMGq5kq0A1hL0md6dIpd5/G9NPT186FeL8Aji3A
         aeYLgvRdazJTewxIyjlTJJLe4Z8iNlvV/rD/buntIOEkNpe3Q0NMXj9PX/fIHDZRExkM
         FRaZ6eviOwPWw5sTjiWA8mRIZMhysV/S2ESjCyzo6BXvM/MTTWa0cgWdSXH9iLzz9wx+
         o+KdVwf2/NykCKwx6YULXWp54wZovagF2jXkQFtsbzZgsE7UK3mlhyJN13gfCYaDOZkf
         s/2Yo1Z4mRgLb2z2YOR7FBXcOD3zecC7/og3rQCGS3xHWaiptBAS6oP/cBcL0/luJSZE
         gZ3A==
X-Gm-Message-State: AOAM5329TK6aA+pLngX/WV91QTVyCjuuLPNwew0Ea21J6iqrOuBv5D9K
        VMEpdnwS3j/5BTEq63Q1OTcwqQ==
X-Google-Smtp-Source: ABdhPJy2Pe4I94IimzJQK2yp88puCwcqJl7FhD2+dgEoRqLJDmzdVF29ekGo4GdVNQoZMh917188mQ==
X-Received: by 2002:a54:4085:0:b0:2d4:6f0b:f3b7 with SMTP id i5-20020a544085000000b002d46f0bf3b7mr6325501oii.148.1646343672364;
        Thu, 03 Mar 2022 13:41:12 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 42-20020a9d0d2d000000b005a3c7373d57sm1452955oti.52.2022.03.03.13.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 13:41:11 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
Date:   Thu,  3 Mar 2022 13:43:00 -0800
Message-Id: <20220303214300.59468-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220303214300.59468-1-bjorn.andersson@linaro.org>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
with their output being routed to various other components, such as
current sinks or GPIOs.

Each LPG instance can operate on fixed parameters or based on a shared
lookup-table, altering the duty cycle over time. This provides the means
for hardware assisted transitions of LED brightness.

A typical use case for the fixed parameter mode is to drive a PWM
backlight control signal, the driver therefor allows each LPG instance
to be exposed to the kernel either through the LED framework or the PWM
framework.

A typical use case for the LED configuration is to drive RGB LEDs in
smartphones etc, for which the driver supports multiple channels to be
ganged up to a MULTICOLOR LED. In this configuration the pattern
generators will be synchronized, to allow for multi-color patterns.

The idea of modelling this as a LED driver ontop of a PWM driver was
considered, but setting the properties related to patterns does not fit
in the PWM API. Similarly the idea of just duplicating the lower bits in
a PWM and LED driver separately was considered, but this would not allow
the PWM channels and LEDs to be configured on a per-board basis. The
driver implements the more complex LED interface, and provides a PWM
interface on the side of that, in the same driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v13:
- Fixed mixed space/tab indentation in documentation
- Added 0 as to lpg_clk_rates[] to match the hardware state, to avoid + 1 in
  lpg_apply_freq() and - 1 in lpg_pwm_get_state()
- Don't divide with 0 if current clock is 0 in lpg_pwm_get_state(), just return
  period = duty = 0 in this case
- Renamed "clk" in struct lpg_channel to clk_sel
- Renamed "pre_div" in struct lpg_channel to pre_div_sel

Changes since v12:
- Initialize ret in lpg_pwm_apply()

Changes since v11:
- Extended commit message to cover decision to put pwm_chip in the LED driver
- Added Documentation, in particular for the hw_pattern format
- Added a lock to synchronize requests from LED and PWM frameworks
- Turned out that the 9bit selector differs per channel in some PMICs, so
  replaced bitmask in lpg_data with lookup based on QPNP SUBTYPE
- Fixed kerneldoc for the struct device pointer in struct lpg
- Rewrote conditional in lut_free() to make it easier to read
- Corrected and deduplicated max_period expression in lpg_calc_freq()
- Extended nom/dom to numerator/denominator in lpg_calc_freq()
- Replaced 1 << 9 with LPG_RESOLUTION in one more place in lpg_calc_freq()
- Use FIELD_PREP() in lpg_apply_freq() as masks was introduced for reading the
  same in get_state()
- Cleaned up the pattern format, to allow specifying both low and high pause
  with and without pingpong mode.
- Only update frequency and pwm_value if PWM channel is enabled in lpg_pwm_apply
- Make lpg_pwm_get_state() read the hardware state, in order to pick up e.g.
  bootloader backlight configuration
- Use devm_bitmap_zalloc() to allocate the lut_bitmap
- Use dev_err_probe() in lpg_probe()
- Extended Kconfig help text to mention module name and satisfy checkpatch

 Documentation/leds/leds-qcom-lpg.rst |   76 ++
 drivers/leds/Kconfig                 |    3 +
 drivers/leds/Makefile                |    3 +
 drivers/leds/rgb/Kconfig             |   18 +
 drivers/leds/rgb/Makefile            |    3 +
 drivers/leds/rgb/leds-qcom-lpg.c     | 1405 ++++++++++++++++++++++++++
 6 files changed, 1508 insertions(+)
 create mode 100644 Documentation/leds/leds-qcom-lpg.rst
 create mode 100644 drivers/leds/rgb/Kconfig
 create mode 100644 drivers/leds/rgb/Makefile
 create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c

diff --git a/Documentation/leds/leds-qcom-lpg.rst b/Documentation/leds/leds-qcom-lpg.rst
new file mode 100644
index 000000000000..f12416f02dd8
--- /dev/null
+++ b/Documentation/leds/leds-qcom-lpg.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Kernel driver for Qualcomm LPG
+==============================
+
+Description
+-----------
+
+The Qualcomm LPG can be found in a variety of Qualcomm PMICs and consists of a
+number of PWM channels, a programmable pattern lookup table and a RGB LED
+current sink.
+
+To facilitate the various use cases, the LPG channels can be exposed as
+individual LEDs, grouped together as RGB LEDs or otherwise be accessed as PWM
+channels. The output of each PWM channel is routed to other hardware
+blocks, such as the RGB current sink, GPIO pins etc.
+
+The each PWM channel can operate with a period between 27us and 384 seconds and
+has a 9 bit resolution of the duty cycle.
+
+In order to provide support for status notifications with the CPU subsystem in
+deeper idle states the LPG provides pattern support. This consists of a shared
+lookup table of brightness values and per channel properties to select the
+range within the table to use, the rate and if the pattern should repeat.
+
+The pattern for a channel can be programmed using the "pattern" trigger, using
+the hw_pattern attribute.
+
+/sys/class/leds/<led>/hw_pattern
+--------------------------------
+
+Specify a hardware pattern for a Qualcomm LPG LED.
+
+The pattern is a series of brightness and hold-time pairs, with the hold-time
+expressed in milliseconds. The hold time is a property of the pattern and must
+therefor be identical for each element in the pattern (except for the pauses
+described below).
+
+Simple pattern::
+
+    "255 500 0 500"
+
+        ^
+        |
+    255 +----+    +----+
+        |    |    |    |      ...
+      0 |    +----+    +----
+        +---------------------->
+        0    5   10   15     time (100ms)
+
+The LPG supports specifying a longer hold-time for the first and last element
+in the pattern, the so called "low pause" and "high pause".
+
+Low-pause pattern::
+
+    "255 1000 0 500 255 500 0 500"
+
+        ^
+        |
+    255 +--------+    +----+    +----+    +--------+
+        |        |    |    |    |    |    |        |      ...
+      0 |        +----+    +----+    +----+        +----
+        +----------------------------->
+        0    5   10   15  20   25   time (100ms)
+
+Similarily, the last entry can be stretched by using a higher hold-time on the
+last entry.
+
+In order to save space in the shared lookup table the LPG supports "ping-pong"
+mode, in which case each run through the pattern is performed by first running
+the pattern forward, then backwards. This mode is automatically used by the
+driver when the given pattern is a palindrome. In this case the "high pause"
+denotes the wait time before the pattern is run in reverse and as such the
+specified hold-time of the middle item in the pattern is allowed to have a
+different hold-time.
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6090e647daee..a49979f41eee 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -869,6 +869,9 @@ source "drivers/leds/blink/Kconfig"
 comment "Flash and Torch LED drivers"
 source "drivers/leds/flash/Kconfig"
 
+comment "RGB LED drivers"
+source "drivers/leds/rgb/Kconfig"
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index e58ecb36360f..4fd2f92cd198 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -99,6 +99,9 @@ obj-$(CONFIG_LEDS_USER)			+= uleds.o
 # Flash and Torch LED Drivers
 obj-$(CONFIG_LEDS_CLASS_FLASH)		+= flash/
 
+# RGB LED Drivers
+obj-$(CONFIG_LEDS_CLASS_MULTICOLOR)	+= rgb/
+
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGERS)		+= trigger/
 
diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
new file mode 100644
index 000000000000..5dd27ad80856
--- /dev/null
+++ b/drivers/leds/rgb/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+if LEDS_CLASS_MULTICOLOR
+
+config LEDS_QCOM_LPG
+	tristate "LED support for Qualcomm LPG"
+	depends on OF
+	depends on SPMI
+	help
+	  This option enables support for the Light Pulse Generator found in a
+	  wide variety of Qualcomm PMICs. The LPG consists of a number of PWM
+	  channels and typically a shared pattern lookup table and a current
+	  sink, intended to drive RGB LEDs. Each channel can either be used as
+	  a LED, grouped to represent a RGB LED or exposed as PWM channels.
+
+	  If compiled as a module, the module will be named leds-qcom-lpg.
+
+endif # LEDS_CLASS_MULTICOLOR
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
new file mode 100644
index 000000000000..83114f44c4ea
--- /dev/null
+++ b/drivers/leds/rgb/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_LEDS_QCOM_LPG)	+= leds-qcom-lpg.o
diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
new file mode 100644
index 000000000000..17576f77c423
--- /dev/null
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -0,0 +1,1405 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2022 Linaro Ltd
+ * Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.
+ */
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define LPG_SUBTYPE_REG		0x05
+#define  LPG_SUBTYPE_LPG	0x2
+#define  LPG_SUBTYPE_PWM	0xb
+#define  LPG_SUBTYPE_LPG_LITE	0x11
+#define LPG_PATTERN_CONFIG_REG	0x40
+#define LPG_SIZE_CLK_REG	0x41
+#define  PWM_CLK_SELECT_MASK	GENMASK(1, 0)
+#define LPG_PREDIV_CLK_REG	0x42
+#define  PWM_FREQ_PRE_DIV_MASK	GENMASK(6, 5)
+#define  PWM_FREQ_EXP_MASK	GENMASK(2, 0)
+#define PWM_TYPE_CONFIG_REG	0x43
+#define PWM_VALUE_REG		0x44
+#define PWM_ENABLE_CONTROL_REG	0x46
+#define PWM_SYNC_REG		0x47
+#define LPG_RAMP_DURATION_REG	0x50
+#define LPG_HI_PAUSE_REG	0x52
+#define LPG_LO_PAUSE_REG	0x54
+#define LPG_HI_IDX_REG		0x56
+#define LPG_LO_IDX_REG		0x57
+#define PWM_SEC_ACCESS_REG	0xd0
+#define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
+
+#define TRI_LED_SRC_SEL		0x45
+#define TRI_LED_EN_CTL		0x46
+#define TRI_LED_ATC_CTL		0x47
+
+#define LPG_LUT_REG(x)		(0x40 + (x) * 2)
+#define RAMP_CONTROL_REG	0xc8
+
+#define LPG_RESOLUTION		512
+#define LPG_MAX_M		7
+
+struct lpg_channel;
+struct lpg_data;
+
+/**
+ * struct lpg - LPG device context
+ * @dev:	pointer to LPG device
+ * @map:	regmap for register access
+ * @lock:	used to synchronize LED and pwm callback requests
+ * @pwm:	PWM-chip object, if operating in PWM mode
+ * @data:	reference to version specific data
+ * @lut_base:	base address of the LUT block (optional)
+ * @lut_size:	number of entries in the LUT block
+ * @lut_bitmap:	allocation bitmap for LUT entries
+ * @triled_base: base address of the TRILED block (optional)
+ * @triled_src:	power-source for the TRILED
+ * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
+ * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
+ * @channels:	list of PWM channels
+ * @num_channels: number of @channels
+ */
+struct lpg {
+	struct device *dev;
+	struct regmap *map;
+
+	struct mutex lock;
+
+	struct pwm_chip pwm;
+
+	const struct lpg_data *data;
+
+	u32 lut_base;
+	u32 lut_size;
+	unsigned long *lut_bitmap;
+
+	u32 triled_base;
+	u32 triled_src;
+	bool triled_has_atc_ctl;
+	bool triled_has_src_sel;
+
+	struct lpg_channel *channels;
+	unsigned int num_channels;
+};
+
+/**
+ * struct lpg_channel - per channel data
+ * @lpg:	reference to parent lpg
+ * @base:	base address of the PWM channel
+ * @triled_mask: mask in TRILED to enable this channel
+ * @lut_mask:	mask in LUT to start pattern generator for this channel
+ * @subtype:	PMIC hardware block subtype
+ * @in_use:	channel is exposed to LED framework
+ * @color:	color of the LED attached to this channel
+ * @dtest_line:	DTEST line for output, or 0 if disabled
+ * @dtest_value: DTEST line configuration
+ * @pwm_value:	duty (in microseconds) of the generated pulses, overridden by LUT
+ * @enabled:	output enabled?
+ * @period:	period (in nanoseconds) of the generated pulses
+ * @clk_sel:	reference clock frequency selector
+ * @pre_div_sel: divider selector of the reference clock
+ * @pre_div_exp: exponential divider of the reference clock
+ * @ramp_enabled: duty cycle is driven by iterating over lookup table
+ * @ramp_ping_pong: reverse through pattern, rather than wrapping to start
+ * @ramp_oneshot: perform only a single pass over the pattern
+ * @ramp_reverse: iterate over pattern backwards
+ * @ramp_tick_ms: length (in milliseconds) of one step in the pattern
+ * @ramp_lo_pause_ms: pause (in milliseconds) before iterating over pattern
+ * @ramp_hi_pause_ms: pause (in milliseconds) after iterating over pattern
+ * @pattern_lo_idx: start index of associated pattern
+ * @pattern_hi_idx: last index of associated pattern
+ */
+struct lpg_channel {
+	struct lpg *lpg;
+
+	u32 base;
+	unsigned int triled_mask;
+	unsigned int lut_mask;
+	unsigned int subtype;
+
+	bool in_use;
+
+	int color;
+
+	u32 dtest_line;
+	u32 dtest_value;
+
+	u16 pwm_value;
+	bool enabled;
+
+	u64 period;
+	unsigned int clk_sel;
+	unsigned int pre_div_sel;
+	unsigned int pre_div_exp;
+
+	bool ramp_enabled;
+	bool ramp_ping_pong;
+	bool ramp_oneshot;
+	bool ramp_reverse;
+	unsigned short ramp_tick_ms;
+	unsigned long ramp_lo_pause_ms;
+	unsigned long ramp_hi_pause_ms;
+
+	unsigned int pattern_lo_idx;
+	unsigned int pattern_hi_idx;
+};
+
+/**
+ * struct lpg_led - logical LED object
+ * @lpg:		lpg context reference
+ * @cdev:		LED class device
+ * @mcdev:		Multicolor LED class device
+ * @num_channels:	number of @channels
+ * @channels:		list of channels associated with the LED
+ */
+struct lpg_led {
+	struct lpg *lpg;
+
+	struct led_classdev cdev;
+	struct led_classdev_mc mcdev;
+
+	unsigned int num_channels;
+	struct lpg_channel *channels[];
+};
+
+/**
+ * struct lpg_channel_data - per channel initialization data
+ * @base:		base address for PWM channel registers
+ * @triled_mask:	bitmask for controlling this channel in TRILED
+ */
+struct lpg_channel_data {
+	unsigned int base;
+	u8 triled_mask;
+};
+
+/**
+ * struct lpg_data - initialization data
+ * @lut_base:		base address of LUT block
+ * @lut_size:		number of entries in LUT
+ * @triled_base:	base address of TRILED
+ * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
+ * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
+ * @num_channels:	number of channels in LPG
+ * @channels:		list of channel initialization data
+ */
+struct lpg_data {
+	unsigned int lut_base;
+	unsigned int lut_size;
+	unsigned int triled_base;
+	bool triled_has_atc_ctl;
+	bool triled_has_src_sel;
+	int num_channels;
+	const struct lpg_channel_data *channels;
+};
+
+static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
+{
+	/* Skip if we don't have a triled block */
+	if (!lpg->triled_base)
+		return 0;
+
+	return regmap_update_bits(lpg->map, lpg->triled_base + TRI_LED_EN_CTL,
+				  mask, enable);
+}
+
+static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
+			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
+{
+	unsigned int idx;
+	u16 val;
+	int i;
+
+	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
+					 0, len, 0);
+	if (idx >= lpg->lut_size)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		val = pattern[i].brightness;
+
+		regmap_bulk_write(lpg->map, lpg->lut_base + LPG_LUT_REG(idx + i),
+				  &val, sizeof(val));
+	}
+
+	bitmap_set(lpg->lut_bitmap, idx, len);
+
+	*lo_idx = idx;
+	*hi_idx = idx + len - 1;
+
+	return 0;
+}
+
+static void lpg_lut_free(struct lpg *lpg, unsigned int lo_idx, unsigned int hi_idx)
+{
+	int len;
+
+	len = hi_idx - lo_idx + 1;
+	if (len == 1)
+		return;
+
+	bitmap_clear(lpg->lut_bitmap, lo_idx, len);
+}
+
+static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
+{
+	return regmap_write(lpg->map, lpg->lut_base + RAMP_CONTROL_REG, mask);
+}
+
+static const unsigned int lpg_clk_rates[] = {0, 1024, 32768, 19200000};
+static const unsigned int lpg_pre_divs[] = {1, 3, 5, 6};
+
+static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
+{
+	unsigned int clk_sel, best_clk = 0;
+	unsigned int div, best_div = 0;
+	unsigned int m, best_m = 0;
+	unsigned int error;
+	unsigned int best_err = UINT_MAX;
+	u64 best_period = 0;
+	u64 max_period;
+
+	/*
+	 * The PWM period is determined by:
+	 *
+	 *          resolution * pre_div * 2^M
+	 * period = --------------------------
+	 *                   refclk
+	 *
+	 * With resolution fixed at 2^9 bits, pre_div = {1, 3, 5, 6} and
+	 * M = [0..7].
+	 *
+	 * This allows for periods between 27uS and 384s, as the PWM framework
+	 * wants a period of equal or lower length than requested, reject
+	 * anything below 27uS.
+	 */
+	if (period <= (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
+		return -EINVAL;
+
+	/* Limit period to largest possible value, to avoid overflows */
+	max_period = (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 1024;
+	if (period > max_period)
+		period = max_period;
+
+	/*
+	 * Search for the pre_div, refclk and M by solving the rewritten formula
+	 * for each refclk and pre_div value:
+	 *
+	 *                     period * refclk
+	 * M = log2 -------------------------------------
+	 *           NSEC_PER_SEC * pre_div * resolution
+	 */
+	for (clk_sel = 1; clk_sel < ARRAY_SIZE(lpg_clk_rates); clk_sel++) {
+		u64 numerator = period * lpg_clk_rates[clk_sel];
+
+		for (div = 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
+			u64 denominator = (u64)NSEC_PER_SEC * lpg_pre_divs[div] * LPG_RESOLUTION;
+			u64 actual;
+			u64 ratio;
+
+			if (numerator < denominator)
+				continue;
+
+			ratio = div64_u64(numerator, denominator);
+			m = ilog2(ratio);
+			if (m > LPG_MAX_M)
+				m = LPG_MAX_M;
+
+			actual = DIV_ROUND_UP_ULL(denominator * (1 << m), lpg_clk_rates[clk_sel]);
+
+			error = period - actual;
+			if (error < best_err) {
+				best_err = error;
+
+				best_div = div;
+				best_m = m;
+				best_clk = clk_sel;
+				best_period = actual;
+			}
+		}
+	}
+
+	chan->clk_sel = best_clk;
+	chan->pre_div_sel = best_div;
+	chan->pre_div_exp = best_m;
+	chan->period = best_period;
+
+	return 0;
+}
+
+static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
+{
+	unsigned int max = LPG_RESOLUTION - 1;
+	unsigned int val;
+
+	val = div64_u64(duty * lpg_clk_rates[chan->clk_sel],
+			(u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div_sel] * (1 << chan->pre_div_exp));
+
+	chan->pwm_value = min(val, max);
+}
+
+static void lpg_apply_freq(struct lpg_channel *chan)
+{
+	unsigned long val;
+	struct lpg *lpg = chan->lpg;
+
+	if (!chan->enabled)
+		return;
+
+	val = chan->clk_sel;
+
+	/* Specify 9bit resolution, based on the subtype of the channel */
+	switch (chan->subtype) {
+	case LPG_SUBTYPE_LPG:
+		val |= GENMASK(5, 4);
+		break;
+	case LPG_SUBTYPE_PWM:
+		val |= BIT(2);
+		break;
+	case LPG_SUBTYPE_LPG_LITE:
+	default:
+		val |= BIT(4);
+		break;
+	}
+
+	regmap_write(lpg->map, chan->base + LPG_SIZE_CLK_REG, val);
+
+	val = FIELD_PREP(PWM_FREQ_PRE_DIV_MASK, chan->pre_div_sel) |
+	      FIELD_PREP(PWM_FREQ_EXP_MASK, chan->pre_div_exp);
+	regmap_write(lpg->map, chan->base + LPG_PREDIV_CLK_REG, val);
+}
+
+#define LPG_ENABLE_GLITCH_REMOVAL	BIT(5)
+
+static void lpg_enable_glitch(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+
+	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
+			   LPG_ENABLE_GLITCH_REMOVAL, 0);
+}
+
+static void lpg_disable_glitch(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+
+	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
+			   LPG_ENABLE_GLITCH_REMOVAL,
+			   LPG_ENABLE_GLITCH_REMOVAL);
+}
+
+static void lpg_apply_pwm_value(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+	u16 val = chan->pwm_value;
+
+	if (!chan->enabled)
+		return;
+
+	regmap_bulk_write(lpg->map, chan->base + PWM_VALUE_REG, &val, sizeof(val));
+}
+
+#define LPG_PATTERN_CONFIG_LO_TO_HI	BIT(4)
+#define LPG_PATTERN_CONFIG_REPEAT	BIT(3)
+#define LPG_PATTERN_CONFIG_TOGGLE	BIT(2)
+#define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
+#define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
+
+static void lpg_apply_lut_control(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+	unsigned int hi_pause;
+	unsigned int lo_pause;
+	unsigned int conf = 0;
+	unsigned int lo_idx = chan->pattern_lo_idx;
+	unsigned int hi_idx = chan->pattern_hi_idx;
+	u16 step = chan->ramp_tick_ms;
+
+	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
+		return;
+
+	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, step);
+	lo_pause = DIV_ROUND_UP(chan->ramp_lo_pause_ms, step);
+
+	if (!chan->ramp_reverse)
+		conf |= LPG_PATTERN_CONFIG_LO_TO_HI;
+	if (!chan->ramp_oneshot)
+		conf |= LPG_PATTERN_CONFIG_REPEAT;
+	if (chan->ramp_ping_pong)
+		conf |= LPG_PATTERN_CONFIG_TOGGLE;
+	if (chan->ramp_hi_pause_ms)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_HI;
+	if (chan->ramp_lo_pause_ms)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_LO;
+
+	regmap_write(lpg->map, chan->base + LPG_PATTERN_CONFIG_REG, conf);
+	regmap_write(lpg->map, chan->base + LPG_HI_IDX_REG, hi_idx);
+	regmap_write(lpg->map, chan->base + LPG_LO_IDX_REG, lo_idx);
+
+	regmap_bulk_write(lpg->map, chan->base + LPG_RAMP_DURATION_REG, &step, sizeof(step));
+	regmap_write(lpg->map, chan->base + LPG_HI_PAUSE_REG, hi_pause);
+	regmap_write(lpg->map, chan->base + LPG_LO_PAUSE_REG, lo_pause);
+}
+
+#define LPG_ENABLE_CONTROL_OUTPUT		BIT(7)
+#define LPG_ENABLE_CONTROL_BUFFER_TRISTATE	BIT(5)
+#define LPG_ENABLE_CONTROL_SRC_PWM		BIT(2)
+#define LPG_ENABLE_CONTROL_RAMP_GEN		BIT(1)
+
+static void lpg_apply_control(struct lpg_channel *chan)
+{
+	unsigned int ctrl;
+	struct lpg *lpg = chan->lpg;
+
+	ctrl = LPG_ENABLE_CONTROL_BUFFER_TRISTATE;
+
+	if (chan->enabled)
+		ctrl |= LPG_ENABLE_CONTROL_OUTPUT;
+
+	if (chan->pattern_lo_idx != chan->pattern_hi_idx)
+		ctrl |= LPG_ENABLE_CONTROL_RAMP_GEN;
+	else
+		ctrl |= LPG_ENABLE_CONTROL_SRC_PWM;
+
+	regmap_write(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG, ctrl);
+
+	/*
+	 * Due to LPG hardware bug, in the PWM mode, having enabled PWM,
+	 * We have to write PWM values one more time.
+	 */
+	if (chan->enabled)
+		lpg_apply_pwm_value(chan);
+}
+
+#define LPG_SYNC_PWM	BIT(0)
+
+static void lpg_apply_sync(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+
+	regmap_write(lpg->map, chan->base + PWM_SYNC_REG, LPG_SYNC_PWM);
+}
+
+static int lpg_parse_dtest(struct lpg *lpg)
+{
+	struct lpg_channel *chan;
+	struct device_node *np = lpg->dev->of_node;
+	int count;
+	int ret;
+	int i;
+
+	count = of_property_count_u32_elems(np, "qcom,dtest");
+	if (count == -EINVAL) {
+		return 0;
+	} else if (count < 0) {
+		ret = count;
+		goto err_malformed;
+	} else if (count != lpg->data->num_channels * 2) {
+		dev_err(lpg->dev, "qcom,dtest needs to be %d items\n",
+			lpg->data->num_channels * 2);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < lpg->data->num_channels; i++) {
+		chan = &lpg->channels[i];
+
+		ret = of_property_read_u32_index(np, "qcom,dtest", i * 2,
+						 &chan->dtest_line);
+		if (ret)
+			goto err_malformed;
+
+		ret = of_property_read_u32_index(np, "qcom,dtest", i * 2 + 1,
+						 &chan->dtest_value);
+		if (ret)
+			goto err_malformed;
+	}
+
+	return 0;
+
+err_malformed:
+	dev_err(lpg->dev, "malformed qcom,dtest\n");
+	return ret;
+}
+
+static void lpg_apply_dtest(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+
+	if (!chan->dtest_line)
+		return;
+
+	regmap_write(lpg->map, chan->base + PWM_SEC_ACCESS_REG, 0xa5);
+	regmap_write(lpg->map, chan->base + PWM_DTEST_REG(chan->dtest_line),
+		     chan->dtest_value);
+}
+
+static void lpg_apply(struct lpg_channel *chan)
+{
+	lpg_disable_glitch(chan);
+	lpg_apply_freq(chan);
+	lpg_apply_pwm_value(chan);
+	lpg_apply_control(chan);
+	lpg_apply_sync(chan);
+	lpg_apply_lut_control(chan);
+	lpg_enable_glitch(chan);
+}
+
+static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
+			       struct mc_subled *subleds)
+{
+	enum led_brightness brightness;
+	struct lpg_channel *chan;
+	unsigned int triled_enabled = 0;
+	unsigned int triled_mask = 0;
+	unsigned int lut_mask = 0;
+	unsigned int duty;
+	struct lpg *lpg = led->lpg;
+	int i;
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+		brightness = subleds[i].brightness;
+
+		if (brightness == LED_OFF) {
+			chan->enabled = false;
+			chan->ramp_enabled = false;
+		} else if (chan->pattern_lo_idx != chan->pattern_hi_idx) {
+			lpg_calc_freq(chan, NSEC_PER_MSEC);
+
+			chan->enabled = true;
+			chan->ramp_enabled = true;
+
+			lut_mask |= chan->lut_mask;
+			triled_enabled |= chan->triled_mask;
+		} else {
+			lpg_calc_freq(chan, NSEC_PER_MSEC);
+
+			duty = div_u64(brightness * chan->period, cdev->max_brightness);
+			lpg_calc_duty(chan, duty);
+			chan->enabled = true;
+			chan->ramp_enabled = false;
+
+			triled_enabled |= chan->triled_mask;
+		}
+
+		triled_mask |= chan->triled_mask;
+
+		lpg_apply(chan);
+	}
+
+	/* Toggle triled lines */
+	if (triled_mask)
+		triled_set(lpg, triled_mask, triled_enabled);
+
+	/* Trigger start of ramp generator(s) */
+	if (lut_mask)
+		lpg_lut_sync(lpg, lut_mask);
+}
+
+static void lpg_brightness_single_set(struct led_classdev *cdev,
+				      enum led_brightness value)
+{
+	struct lpg_led *led = container_of(cdev, struct lpg_led, cdev);
+	struct mc_subled info;
+
+	mutex_lock(&led->lpg->lock);
+
+	info.brightness = value;
+	lpg_brightness_set(led, cdev, &info);
+
+	mutex_unlock(&led->lpg->lock);
+}
+
+static void lpg_brightness_mc_set(struct led_classdev *cdev,
+				  enum led_brightness value)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+
+	mutex_lock(&led->lpg->lock);
+
+	led_mc_calc_color_components(mc, value);
+	lpg_brightness_set(led, cdev, mc->subled_info);
+
+	mutex_unlock(&led->lpg->lock);
+}
+
+static int lpg_blink_set(struct lpg_led *led,
+			 unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct lpg_channel *chan;
+	unsigned int period;
+	unsigned int triled_mask = 0;
+	struct lpg *lpg = led->lpg;
+	u64 duty;
+	int i;
+
+	if (!*delay_on && !*delay_off) {
+		*delay_on = 500;
+		*delay_off = 500;
+	}
+
+	duty = *delay_on * NSEC_PER_MSEC;
+	period = (*delay_on + *delay_off) * NSEC_PER_MSEC;
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+
+		lpg_calc_freq(chan, period);
+		lpg_calc_duty(chan, duty);
+
+		chan->enabled = true;
+		chan->ramp_enabled = false;
+
+		triled_mask |= chan->triled_mask;
+
+		lpg_apply(chan);
+	}
+
+	/* Enable triled lines */
+	triled_set(lpg, triled_mask, triled_mask);
+
+	chan = led->channels[0];
+	duty = div_u64(chan->pwm_value * chan->period, LPG_RESOLUTION);
+	*delay_on = div_u64(duty, NSEC_PER_MSEC);
+	*delay_off = div_u64(chan->period - duty, NSEC_PER_MSEC);
+
+	return 0;
+}
+
+static int lpg_blink_single_set(struct led_classdev *cdev,
+				unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct lpg_led *led = container_of(cdev, struct lpg_led, cdev);
+	int ret;
+
+	mutex_lock(&led->lpg->lock);
+
+	ret = lpg_blink_set(led, delay_on, delay_off);
+
+	mutex_unlock(&led->lpg->lock);
+
+	return ret;
+}
+
+static int lpg_blink_mc_set(struct led_classdev *cdev,
+			    unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+	int ret;
+
+	mutex_lock(&led->lpg->lock);
+
+	ret = lpg_blink_set(led, delay_on, delay_off);
+
+	mutex_unlock(&led->lpg->lock);
+
+	return ret;
+}
+
+static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *pattern,
+			   u32 len, int repeat)
+{
+	struct lpg_channel *chan;
+	struct lpg *lpg = led->lpg;
+	unsigned int brightness_a;
+	unsigned int brightness_b;
+	unsigned int actual_len;
+	unsigned int hi_pause;
+	unsigned int lo_pause;
+	unsigned int delta_t;
+	unsigned int lo_idx;
+	unsigned int hi_idx;
+	unsigned int i;
+	bool ping_pong = true;
+	int ret;
+
+	/* Hardware only support oneshot or indefinite loops */
+	if (repeat != -1 && repeat != 1)
+		return -EINVAL;
+
+	/*
+	 * Specifying a pattern of length 1 causes the hardware to iterate
+	 * through the entire LUT, so prohibit this.
+	 */
+	if (len < 2)
+		return -EINVAL;
+
+	/*
+	 * The LPG plays patterns with at a fixed pace, a "low pause" can be
+	 * used to stretch the first delay of the pattern and a "high pause"
+	 * the last one.
+	 *
+	 * In order to save space the pattern can be played in "ping pong"
+	 * mode, in which the pattern is first played forward, then "high
+	 * pause" is applied, then the pattern is played backwards and finally
+	 * the "low pause" is applied.
+	 *
+	 * The middle elements of the pattern are used to determine delta_t and
+	 * the "low pause" and "high pause" multipliers are derrived from this.
+	 *
+	 * The first element in the pattern is used to determine "low pause".
+	 *
+	 * If the specified pattern is a palindrome the ping pong mode is
+	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
+	 * last in the programmed pattern) determines the "high pause".
+	 */
+
+	/* Detect palindromes and use "ping pong" to reduce LUT usage */
+	for (i = 0; i < len / 2; i++) {
+		brightness_a = pattern[i].brightness;
+		brightness_b = pattern[len - i - 1].brightness;
+
+		if (brightness_a != brightness_b) {
+			ping_pong = false;
+			break;
+		}
+	}
+
+	/* The pattern length to be written to the LUT */
+	if (ping_pong)
+		actual_len = (len + 1) / 2;
+	else
+		actual_len = len;
+
+	/*
+	 * Validate that all delta_t in the pattern are the same, with the
+	 * exception of the middle element in case of ping_pong.
+	 */
+	delta_t = pattern[1].delta_t;
+	for (i = 2; i < len; i++) {
+		if (pattern[i].delta_t != delta_t) {
+			/*
+			 * Allow last entry in the full or shortened pattern to
+			 * specify hi pause. Reject other variations.
+			 */
+			if (i != actual_len - 1)
+				return -EINVAL;
+		}
+	}
+
+	/* LPG_RAMP_DURATION_REG is a 9bit */
+	if (delta_t >= BIT(9))
+		return -EINVAL;
+
+	/* Find "low pause" and "high pause" in the pattern */
+	lo_pause = pattern[0].delta_t;
+	hi_pause = pattern[actual_len - 1].delta_t;
+
+	mutex_lock(&lpg->lock);
+	ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+	if (ret < 0)
+		goto out_unlock;
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+
+		chan->ramp_tick_ms = delta_t;
+		chan->ramp_ping_pong = ping_pong;
+		chan->ramp_oneshot = repeat != -1;
+
+		chan->ramp_lo_pause_ms = lo_pause;
+		chan->ramp_hi_pause_ms = hi_pause;
+
+		chan->pattern_lo_idx = lo_idx;
+		chan->pattern_hi_idx = hi_idx;
+	}
+
+out_unlock:
+	mutex_unlock(&lpg->lock);
+
+	return ret;
+}
+
+static int lpg_pattern_single_set(struct led_classdev *cdev,
+				  struct led_pattern *pattern, u32 len,
+				  int repeat)
+{
+	struct lpg_led *led = container_of(cdev, struct lpg_led, cdev);
+	int ret;
+
+	ret = lpg_pattern_set(led, pattern, len, repeat);
+	if (ret < 0)
+		return ret;
+
+	lpg_brightness_single_set(cdev, LED_FULL);
+
+	return 0;
+}
+
+static int lpg_pattern_mc_set(struct led_classdev *cdev,
+			      struct led_pattern *pattern, u32 len,
+			      int repeat)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+	int ret;
+
+	ret = lpg_pattern_set(led, pattern, len, repeat);
+	if (ret < 0)
+		return ret;
+
+	led_mc_calc_color_components(mc, LED_FULL);
+	lpg_brightness_set(led, cdev, mc->subled_info);
+
+	return 0;
+}
+
+static int lpg_pattern_clear(struct lpg_led *led)
+{
+	struct lpg_channel *chan;
+	struct lpg *lpg = led->lpg;
+	int i;
+
+	mutex_lock(&lpg->lock);
+
+	chan = led->channels[0];
+	lpg_lut_free(lpg, chan->pattern_lo_idx, chan->pattern_hi_idx);
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+		chan->pattern_lo_idx = 0;
+		chan->pattern_hi_idx = 0;
+	}
+
+	mutex_unlock(&lpg->lock);
+
+	return 0;
+}
+
+static int lpg_pattern_single_clear(struct led_classdev *cdev)
+{
+	struct lpg_led *led = container_of(cdev, struct lpg_led, cdev);
+
+	return lpg_pattern_clear(led);
+}
+
+static int lpg_pattern_mc_clear(struct led_classdev *cdev)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+
+	return lpg_pattern_clear(led);
+}
+
+static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
+
+	return chan->in_use ? -EBUSY : 0;
+}
+
+/*
+ * Limitations:
+ * - Updating both duty and period is not done atomically, so the output signal
+ *   will momentarily be a mix of the settings.
+ * - Changed parameters takes effect immediately.
+ * - A disabled channel outputs a logical 0.
+ */
+static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
+	int ret = 0;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	mutex_lock(&lpg->lock);
+
+	if (state->enabled) {
+		ret = lpg_calc_freq(chan, state->period);
+		if (ret < 0)
+			goto out_unlock;
+
+		lpg_calc_duty(chan, state->duty_cycle);
+	}
+	chan->enabled = state->enabled;
+
+	lpg_apply(chan);
+
+	triled_set(lpg, chan->triled_mask, chan->enabled ? chan->triled_mask : 0);
+
+out_unlock:
+	mutex_unlock(&lpg->lock);
+
+	return ret;
+}
+
+static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
+	unsigned int pre_div;
+	unsigned int refclk;
+	unsigned int val;
+	unsigned int m;
+	u16 pwm_value;
+	int ret;
+
+	ret = regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
+	if (ret)
+		return;
+
+	refclk = lpg_clk_rates[val & PWM_CLK_SELECT_MASK];
+	if (refclk) {
+		ret = regmap_read(lpg->map, chan->base + LPG_PREDIV_CLK_REG, &val);
+		if (ret)
+			return;
+
+		pre_div = lpg_pre_divs[FIELD_GET(PWM_FREQ_PRE_DIV_MASK, val)];
+		m = FIELD_GET(PWM_FREQ_EXP_MASK, val);
+
+		ret = regmap_bulk_read(lpg->map, chan->base + PWM_VALUE_REG, &pwm_value, sizeof(pwm_value));
+		if (ret)
+			return;
+
+		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * LPG_RESOLUTION * pre_div * (1 << m), refclk);
+		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
+	} else {
+		state->period = 0;
+		state->duty_cycle = 0;
+	}
+
+	ret = regmap_read(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG, &val);
+	if (ret)
+		return;
+
+	state->enabled = FIELD_GET(LPG_ENABLE_CONTROL_OUTPUT, val);
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	if (state->duty_cycle > state->period)
+		state->duty_cycle = state->period;
+}
+
+static const struct pwm_ops lpg_pwm_ops = {
+	.request = lpg_pwm_request,
+	.apply = lpg_pwm_apply,
+	.get_state = lpg_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int lpg_add_pwm(struct lpg *lpg)
+{
+	int ret;
+
+	lpg->pwm.base = -1;
+	lpg->pwm.dev = lpg->dev;
+	lpg->pwm.npwm = lpg->num_channels;
+	lpg->pwm.ops = &lpg_pwm_ops;
+
+	ret = pwmchip_add(&lpg->pwm);
+	if (ret)
+		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n", ret);
+
+	return ret;
+}
+
+static int lpg_parse_channel(struct lpg *lpg, struct device_node *np,
+			     struct lpg_channel **channel)
+{
+	struct lpg_channel *chan;
+	u32 color = LED_COLOR_ID_GREEN;
+	u32 reg;
+	int ret;
+
+	ret = of_property_read_u32(np, "reg", &reg);
+	if (ret || !reg || reg > lpg->num_channels) {
+		dev_err(lpg->dev, "invalid \"reg\" of %pOFn\n", np);
+		return -EINVAL;
+	}
+
+	chan = &lpg->channels[reg - 1];
+	chan->in_use = true;
+
+	ret = of_property_read_u32(np, "color", &color);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n", np);
+		return ret;
+	}
+
+	chan->color = color;
+
+	*channel = chan;
+
+	return 0;
+}
+
+static int lpg_add_led(struct lpg *lpg, struct device_node *np)
+{
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	struct device_node *child;
+	struct mc_subled *info;
+	struct lpg_led *led;
+	const char *state;
+	int num_channels;
+	u32 color = 0;
+	int ret;
+	int i;
+
+	ret = of_property_read_u32(np, "color", &color);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n", np);
+		return ret;
+	}
+
+	if (color == LED_COLOR_ID_RGB)
+		num_channels = of_get_available_child_count(np);
+	else
+		num_channels = 1;
+
+	led = devm_kzalloc(lpg->dev, struct_size(led, channels, num_channels), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	led->lpg = lpg;
+	led->num_channels = num_channels;
+
+	if (color == LED_COLOR_ID_RGB) {
+		info = devm_kcalloc(lpg->dev, num_channels, sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+		i = 0;
+		for_each_available_child_of_node(np, child) {
+			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
+			if (ret < 0)
+				return ret;
+
+			info[i].color_index = led->channels[i]->color;
+			info[i].intensity = 0;
+			i++;
+		}
+
+		led->mcdev.subled_info = info;
+		led->mcdev.num_colors = num_channels;
+
+		cdev = &led->mcdev.led_cdev;
+		cdev->brightness_set = lpg_brightness_mc_set;
+		cdev->blink_set = lpg_blink_mc_set;
+
+		/* Register pattern accessors only if we have a LUT block */
+		if (lpg->lut_base) {
+			cdev->pattern_set = lpg_pattern_mc_set;
+			cdev->pattern_clear = lpg_pattern_mc_clear;
+		}
+	} else {
+		ret = lpg_parse_channel(lpg, np, &led->channels[0]);
+		if (ret < 0)
+			return ret;
+
+		cdev = &led->cdev;
+		cdev->brightness_set = lpg_brightness_single_set;
+		cdev->blink_set = lpg_blink_single_set;
+
+		/* Register pattern accessors only if we have a LUT block */
+		if (lpg->lut_base) {
+			cdev->pattern_set = lpg_pattern_single_set;
+			cdev->pattern_clear = lpg_pattern_single_clear;
+		}
+	}
+
+	cdev->default_trigger = of_get_property(np, "linux,default-trigger", NULL);
+	cdev->max_brightness = LPG_RESOLUTION - 1;
+
+	if (!of_property_read_string(np, "default-state", &state) &&
+	    !strcmp(state, "on"))
+		cdev->brightness = cdev->max_brightness;
+	else
+		cdev->brightness = LED_OFF;
+
+	cdev->brightness_set(cdev, cdev->brightness);
+
+	init_data.fwnode = of_fwnode_handle(np);
+
+	if (color == LED_COLOR_ID_RGB)
+		ret = devm_led_classdev_multicolor_register_ext(lpg->dev, &led->mcdev, &init_data);
+	else
+		ret = devm_led_classdev_register_ext(lpg->dev, &led->cdev, &init_data);
+	if (ret)
+		dev_err(lpg->dev, "unable to register %s\n", cdev->name);
+
+	return ret;
+}
+
+static int lpg_init_channels(struct lpg *lpg)
+{
+	const struct lpg_data *data = lpg->data;
+	struct lpg_channel *chan;
+	int i;
+
+	lpg->num_channels = data->num_channels;
+	lpg->channels = devm_kcalloc(lpg->dev, data->num_channels,
+				     sizeof(struct lpg_channel), GFP_KERNEL);
+	if (!lpg->channels)
+		return -ENOMEM;
+
+	for (i = 0; i < data->num_channels; i++) {
+		chan = &lpg->channels[i];
+
+		chan->lpg = lpg;
+		chan->base = data->channels[i].base;
+		chan->triled_mask = data->channels[i].triled_mask;
+		chan->lut_mask = BIT(i);
+
+		regmap_read(lpg->map, chan->base + LPG_SUBTYPE_REG, &chan->subtype);
+	}
+
+	return 0;
+}
+
+static int lpg_init_triled(struct lpg *lpg)
+{
+	struct device_node *np = lpg->dev->of_node;
+	int ret;
+
+	/* Skip initialization if we don't have a triled block */
+	if (!lpg->data->triled_base)
+		return 0;
+
+	lpg->triled_base = lpg->data->triled_base;
+	lpg->triled_has_atc_ctl = lpg->data->triled_has_atc_ctl;
+	lpg->triled_has_src_sel = lpg->data->triled_has_src_sel;
+
+	if (lpg->triled_has_src_sel) {
+		ret = of_property_read_u32(np, "qcom,power-source", &lpg->triled_src);
+		if (ret || lpg->triled_src == 2 || lpg->triled_src > 3) {
+			dev_err(lpg->dev, "invalid power source\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Disable automatic trickle charge LED */
+	if (lpg->triled_has_atc_ctl)
+		regmap_write(lpg->map, lpg->triled_base + TRI_LED_ATC_CTL, 0);
+
+	/* Configure power source */
+	if (lpg->triled_has_src_sel)
+		regmap_write(lpg->map, lpg->triled_base + TRI_LED_SRC_SEL, lpg->triled_src);
+
+	/* Default all outputs to off */
+	regmap_write(lpg->map, lpg->triled_base + TRI_LED_EN_CTL, 0);
+
+	return 0;
+}
+
+static int lpg_init_lut(struct lpg *lpg)
+{
+	const struct lpg_data *data = lpg->data;
+
+	if (!data->lut_base)
+		return 0;
+
+	lpg->lut_base = data->lut_base;
+	lpg->lut_size = data->lut_size;
+
+	lpg->lut_bitmap = devm_bitmap_zalloc(lpg->dev, lpg->lut_size, GFP_KERNEL);
+	if (!lpg->lut_bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int lpg_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	struct lpg *lpg;
+	int ret;
+	int i;
+
+	lpg = devm_kzalloc(&pdev->dev, sizeof(*lpg), GFP_KERNEL);
+	if (!lpg)
+		return -ENOMEM;
+
+	lpg->data = of_device_get_match_data(&pdev->dev);
+	if (!lpg->data)
+		return -EINVAL;
+
+	platform_set_drvdata(pdev, lpg);
+
+	lpg->dev = &pdev->dev;
+	mutex_init(&lpg->lock);
+
+	lpg->map = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!lpg->map)
+		return dev_err_probe(&pdev->dev, -ENXIO, "parent regmap unavailable\n");
+
+	ret = lpg_init_channels(lpg);
+	if (ret < 0)
+		return ret;
+
+	ret = lpg_parse_dtest(lpg);
+	if (ret < 0)
+		return ret;
+
+	ret = lpg_init_triled(lpg);
+	if (ret < 0)
+		return ret;
+
+	ret = lpg_init_lut(lpg);
+	if (ret < 0)
+		return ret;
+
+	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		ret = lpg_add_led(lpg, np);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < lpg->num_channels; i++)
+		lpg_apply_dtest(&lpg->channels[i]);
+
+	return lpg_add_pwm(lpg);
+}
+
+static int lpg_remove(struct platform_device *pdev)
+{
+	struct lpg *lpg = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&lpg->pwm);
+
+	return 0;
+}
+
+static const struct lpg_data pm8916_pwm_data = {
+	.num_channels = 1,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xbc00 },
+	},
+};
+
+static const struct lpg_data pm8941_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 64,
+
+	.triled_base = 0xd000,
+	.triled_has_atc_ctl = true,
+	.triled_has_src_sel = true,
+
+	.num_channels = 8,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb100 },
+		{ .base = 0xb200 },
+		{ .base = 0xb300 },
+		{ .base = 0xb400 },
+		{ .base = 0xb500, .triled_mask = BIT(5) },
+		{ .base = 0xb600, .triled_mask = BIT(6) },
+		{ .base = 0xb700, .triled_mask = BIT(7) },
+		{ .base = 0xb800 },
+	},
+};
+
+static const struct lpg_data pm8994_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 64,
+
+	.num_channels = 6,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb100 },
+		{ .base = 0xb200 },
+		{ .base = 0xb300 },
+		{ .base = 0xb400 },
+		{ .base = 0xb500 },
+		{ .base = 0xb600 },
+	},
+};
+
+static const struct lpg_data pmi8994_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 24,
+
+	.triled_base = 0xd000,
+	.triled_has_atc_ctl = true,
+	.triled_has_src_sel = true,
+
+	.num_channels = 4,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb100, .triled_mask = BIT(5) },
+		{ .base = 0xb200, .triled_mask = BIT(6) },
+		{ .base = 0xb300, .triled_mask = BIT(7) },
+		{ .base = 0xb400 },
+	},
+};
+
+static const struct lpg_data pmi8998_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 49,
+
+	.triled_base = 0xd000,
+
+	.num_channels = 6,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb100 },
+		{ .base = 0xb200 },
+		{ .base = 0xb300, .triled_mask = BIT(5) },
+		{ .base = 0xb400, .triled_mask = BIT(6) },
+		{ .base = 0xb500, .triled_mask = BIT(7) },
+		{ .base = 0xb600 },
+	},
+};
+
+static const struct lpg_data pm8150b_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 24,
+
+	.triled_base = 0xd000,
+
+	.num_channels = 2,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb100, .triled_mask = BIT(7) },
+		{ .base = 0xb200, .triled_mask = BIT(6) },
+	},
+};
+
+static const struct lpg_data pm8150l_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 48,
+
+	.triled_base = 0xd000,
+
+	.num_channels = 5,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb100, .triled_mask = BIT(7) },
+		{ .base = 0xb200, .triled_mask = BIT(6) },
+		{ .base = 0xb300, .triled_mask = BIT(5) },
+		{ .base = 0xbc00 },
+		{ .base = 0xbd00 },
+
+	},
+};
+
+static const struct of_device_id lpg_of_table[] = {
+	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
+	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
+	{ .compatible = "qcom,pm8916-pwm", .data = &pm8916_pwm_data },
+	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
+	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
+	{ .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
+	{ .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },
+	{ .compatible = "qcom,pmc8180c-lpg", .data = &pm8150l_lpg_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lpg_of_table);
+
+static struct platform_driver lpg_driver = {
+	.probe = lpg_probe,
+	.remove = lpg_remove,
+	.driver = {
+		.name = "qcom-spmi-lpg",
+		.of_match_table = lpg_of_table,
+	},
+};
+module_platform_driver(lpg_driver);
+
+MODULE_DESCRIPTION("Qualcomm LPG LED driver");
+MODULE_LICENSE("GPL v2");
-- 
2.33.1

