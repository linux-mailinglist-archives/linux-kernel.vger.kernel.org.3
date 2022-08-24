Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282CB59F602
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiHXJM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiHXJMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:12:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB644D4EE;
        Wed, 24 Aug 2022 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661332364; x=1692868364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YDED4ZgtBFO+A6B9PQfEorSn7nRbubgGCC6f+X2h7P4=;
  b=fxuQspcH18lPtFw50WJq1N6zG1OqORGHMAIpQvzkNDceUM0pjI7SWn3f
   xsYoyjferdkIV7VCeLRffCDfiGS0eiz2e/rEuvBhP4f+9CNj3VA91sboW
   DGriUaOccUfoE1kYokEtxa9MPRUSfMiSkzhV2shjg2PmkijhmWDiQkPTL
   OMVCw+rcoKntJeLhrwNUwPgrYanS1dcdJlMF584XMm6VxFZYxpmF4r6I/
   AtbWbJB7UQipuDi7W9pk3PhpUI6s0FJswAt8hv95HqllLSfYjm6AJikJO
   7WMR8GnopHZydzoauc5fT07yk7ord62Gp4v0J34WVu4DS4CfmxW5q+dJP
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="173885243"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 02:12:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 02:12:43 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 02:12:41 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 3/4] pwm: add microchip soft ip corePWM driver
Date:   Wed, 24 Aug 2022 10:12:14 +0100
Message-ID: <20220824091215.141577-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824091215.141577-1-conor.dooley@microchip.com>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver that supports the Microchip FPGA "soft" PWM IP core.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pwm/Kconfig              |  10 +
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-microchip-core.c | 402 +++++++++++++++++++++++++++++++
 3 files changed, 413 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..e4de8c02c3c0 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -393,6 +393,16 @@ config PWM_MEDIATEK
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mediatek.
 
+config PWM_MICROCHIP_CORE
+	tristate "Microchip corePWM PWM support"
+	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	help
+	  PWM driver for Microchip FPGA soft IP core.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-microchip-core.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..a65625359ece 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
+obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
new file mode 100644
index 000000000000..4ec2f1fce600
--- /dev/null
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * corePWM driver for Microchip "soft" FPGA IP cores.
+ *
+ * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ * Documentation:
+ * https://www.microsemi.com/document-portal/doc_download/1245275-corepwm-hb
+ *
+ * Limitations:
+ * - If the IP block is configured without "shadow registers", all register
+ *   writes will take effect immediately, causing glitches on the output.
+ *   If shadow registers *are* enabled, a write to the "SYNC_UPDATE" register
+ *   notifies the core that it needs to update the registers defining the
+ *   waveform from the contents of the "shadow registers".
+ * - The IP block has no concept of a duty cycle, only rising/falling edges of
+ *   the waveform. Unfortunately, if the rising & falling edges registers have
+ *   the same value written to them the IP block will do whichever of a rising
+ *   or a falling edge is possible. I.E. a 50% waveform at twice the requested
+ *   period. Therefore to get a 0% waveform, the output is set the max high/low
+ *   time depending on polarity.
+ * - The PWM period is set for the whole IP block not per channel. The driver
+ *   will only change the period if no other PWM output is enabled.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define PREG_TO_VAL(PREG) ((PREG) + 1)
+
+#define MCHPCOREPWM_PRESCALE_MAX	0x100
+#define MCHPCOREPWM_PERIOD_STEPS_MAX	0xff
+#define MCHPCOREPWM_PERIOD_MAX		0xff00
+
+#define MCHPCOREPWM_PRESCALE	0x00
+#define MCHPCOREPWM_PERIOD	0x04
+#define MCHPCOREPWM_EN(i)	(0x08 + 0x04 * (i)) /* 0x08, 0x0c */
+#define MCHPCOREPWM_POSEDGE(i)	(0x10 + 0x08 * (i)) /* 0x10, 0x18, ..., 0x88 */
+#define MCHPCOREPWM_NEGEDGE(i)	(0x14 + 0x08 * (i)) /* 0x14, 0x1c, ..., 0x8c */
+#define MCHPCOREPWM_SYNC_UPD	0xe4
+
+struct mchp_core_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct mutex lock; /* protect the shared period */
+	void __iomem *base;
+	u32 sync_update_mask;
+	u16 channel_enabled;
+};
+
+static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mchp_core_pwm_chip, chip);
+}
+
+static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+				 bool enable, u64 period)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u8 channel_enable, reg_offset, shift;
+
+	/*
+	 * There are two adjacent 8 bit control regs, the lower reg controls
+	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
+	 * and if so, offset by the bus width.
+	 */
+	reg_offset = MCHPCOREPWM_EN(pwm->hwpwm >> 3);
+	shift = pwm->hwpwm & 7;
+
+	channel_enable = readb_relaxed(mchp_core_pwm->base + reg_offset);
+	channel_enable &= ~(1 << shift);
+	channel_enable |= (enable << shift);
+
+	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
+	mchp_core_pwm->channel_enabled &= ~BIT(pwm->hwpwm);
+	mchp_core_pwm->channel_enabled |= enable << pwm->hwpwm;
+
+	/*
+	 * Notify the block to update the waveform from the shadow registers.
+	 * The updated values will not appear on the bus until they have been
+	 * applied to the waveform at the beginning of the next period. We must
+	 * write these registers and wait for them to be applied before
+	 * considering the channel enabled.
+	 * If the delay is under 1 us, sleep for at least 1 us anyway.
+	 */
+	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
+		u64 delay;
+
+		delay = div_u64(period, 1000u) ? : 1u;
+		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
+		usleep_range(delay, delay * 2);
+	}
+}
+
+static u64 mchp_core_pwm_calc_duty(struct pwm_chip *chip, struct pwm_device *pwm,
+				   const struct pwm_state *state, u8 prescale, u8 period_steps)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u64 duty_steps, tmp;
+	u16 prescale_val = PREG_TO_VAL(prescale);
+
+	/*
+	 * Calculate the duty cycle in multiples of the prescaled period:
+	 * duty_steps = duty_in_ns / step_in_ns
+	 * step_in_ns = (prescale * NSEC_PER_SEC) / clk_rate
+	 * The code below is rearranged slightly to only divide once.
+	 */
+	duty_steps = state->duty_cycle * clk_get_rate(mchp_core_pwm->clk);
+	tmp = prescale_val * NSEC_PER_SEC;
+	return div64_u64(duty_steps, tmp);
+}
+
+static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_device *pwm,
+				     const struct pwm_state *state, u64 duty_steps, u8 period_steps)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u8 posedge, negedge;
+	u8 period_steps_val = PREG_TO_VAL(period_steps);
+
+	/*
+	 * Setting posedge == negedge doesn't yield a constant output,
+	 * so that's an unsuitable setting to model duty_steps = 0.
+	 * In that case set the unwanted edge to a value that never
+	 * triggers.
+	 */
+	if (state->polarity == PWM_POLARITY_INVERSED) {
+		negedge = !duty_steps ? period_steps_val : 0u;
+		posedge = duty_steps;
+	} else {
+		posedge = !duty_steps ? period_steps_val : 0u;
+		negedge = duty_steps;
+	}
+
+	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
+	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
+}
+
+static int mchp_core_pwm_calc_period(struct pwm_chip *chip, const struct pwm_state *state,
+				     u8 *prescale, u8 *period_steps)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u64 tmp, clk_rate;
+
+	/*
+	 * Calculate the period cycles and prescale values.
+	 * The registers are each 8 bits wide & multiplied to compute the period
+	 * using the formula:
+	 * (clock_period) * (prescale + 1) * (period_steps + 1)
+	 * so the maximum period that can be generated is 0x10000 times the
+	 * period of the input clock.
+	 * However, due to the design of the "hardware", it is not possible to
+	 * attain a 100% duty cycle if the full range of period_steps is used.
+	 * Therefore period_steps is restricted to 0xFE and the maximum multiple
+	 * of the clock period attainable is 0xFF00.
+	 */
+	clk_rate = clk_get_rate(mchp_core_pwm->clk);
+
+	/*
+	 * If clk_rate is too big, the following multiplication might overflow.
+	 * However this is implausible, as the fabric of current FPGAs cannot
+	 * provide clocks at a rate high enough.
+	 */
+	if (clk_rate >= NSEC_PER_SEC)
+		return -EINVAL;
+
+	tmp = mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
+
+	/*
+	 * The hardware adds one to the register value, so decrement by one to
+	 * account for the offset
+	 */
+	if (tmp >= MCHPCOREPWM_PERIOD_MAX) {
+		*prescale = MCHPCOREPWM_PRESCALE_MAX - 1;
+		*period_steps = MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
+		return 0;
+	}
+
+	*prescale = div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
+	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
+	*period_steps = div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
+
+	return 0;
+}
+
+static inline void mchp_core_pwm_apply_period(struct mchp_core_pwm_chip *mchp_core_pwm,
+					      u8 prescale, u8 period_steps)
+{
+	writel_relaxed(prescale, mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+	writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
+}
+
+static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	struct pwm_state current_state = pwm->state;
+	bool period_locked;
+	u64 duty_steps;
+	u16 prescale;
+	u8 period_steps;
+	int ret;
+
+	mutex_lock(&mchp_core_pwm->lock);
+
+	if (!state->enabled) {
+		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
+		mutex_unlock(&mchp_core_pwm->lock);
+		return 0;
+	}
+
+	/*
+	 * If the only thing that has changed is the duty cycle or the polarity,
+	 * we can shortcut the calculations and just compute/apply the new duty
+	 * cycle pos & neg edges
+	 * As all the channels share the same period, do not allow it to be
+	 * changed if any other channels are enabled.
+	 * If the period is locked, it may not be possible to use a period
+	 * less than that requested. In that case, we just abort.
+	 */
+	period_locked = mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
+
+	if (period_locked) {
+		u16 hw_prescale;
+		u8 hw_period_steps;
+
+		mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_steps);
+		hw_prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+		hw_period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
+
+		if ((period_steps + 1) * (prescale + 1) <
+		    (hw_period_steps + 1) * (hw_prescale + 1)) {
+			mutex_unlock(&mchp_core_pwm->lock);
+			return -EINVAL;
+		}
+
+		/*
+		 * It is possible that something could have set the period_steps
+		 * register to 0xff, which would prevent us from setting a 100%
+		 * duty cycle, as explained in the mchp_core_pwm_calc_period()
+		 * above.
+		 * The period is locked and we cannot change this, so we abort.
+		 */
+		if (period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX) {
+			mutex_unlock(&mchp_core_pwm->lock);
+			return -EINVAL;
+		}
+
+		prescale = hw_prescale;
+		period_steps = hw_period_steps;
+	} else if (!current_state.enabled || current_state.period != state->period) {
+		ret = mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_steps);
+		if (ret) {
+			mutex_unlock(&mchp_core_pwm->lock);
+			return ret;
+		}
+		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
+	} else {
+		prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+		period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
+
+		/*
+		 * As above, it is possible that something could have set the
+		 * period_steps register to 0xff, which would prevent us from
+		 * setting a 100% duty cycle, as explained above.
+		 * As the period is not locked, we are free to fix this.
+		 */
+		if (period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX) {
+			period_steps -= 1;
+			mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
+		}
+	}
+
+	duty_steps = mchp_core_pwm_calc_duty(chip, pwm, state, prescale, period_steps);
+
+	/*
+	 * Because the period is per channel, it is possible that the requested
+	 * duty cycle is longer than the period, in which case cap it to the
+	 * period, IOW a 100% duty cycle.
+	 */
+	if (duty_steps > period_steps)
+		duty_steps = period_steps + 1;
+
+	mchp_core_pwm_apply_duty(chip, pwm, state, duty_steps, period_steps);
+
+	mchp_core_pwm_enable(chip, pwm, true, state->period);
+
+	mutex_unlock(&mchp_core_pwm->lock);
+
+	return 0;
+}
+
+static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u16 prescale;
+	u8 period_steps, duty_steps, posedge, negedge;
+
+	mutex_lock(&mchp_core_pwm->lock);
+
+	if (mchp_core_pwm->channel_enabled & (1 << pwm->hwpwm))
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	prescale = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE));
+
+	period_steps = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD));
+	state->period = period_steps * prescale * NSEC_PER_SEC;
+	state->period = DIV64_U64_ROUND_UP(state->period, clk_get_rate(mchp_core_pwm->clk));
+
+	posedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
+	negedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
+
+	if ((negedge == posedge) && state->enabled) {
+		state->duty_cycle = state->period;
+		state->period *= 2;
+	} else {
+		duty_steps = abs((s16)posedge - (s16)negedge);
+		state->duty_cycle = duty_steps * prescale * NSEC_PER_SEC;
+		state->duty_cycle = DIV64_U64_ROUND_UP(state->duty_cycle,
+						       clk_get_rate(mchp_core_pwm->clk));
+	}
+
+	state->polarity = negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	mutex_unlock(&mchp_core_pwm->lock);
+}
+
+static const struct pwm_ops mchp_core_pwm_ops = {
+	.apply = mchp_core_pwm_apply,
+	.get_state = mchp_core_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id mchp_core_of_match[] = {
+	{
+		.compatible = "microchip,corepwm-rtl-v4",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mchp_core_of_match);
+
+static int mchp_core_pwm_probe(struct platform_device *pdev)
+{
+	struct mchp_core_pwm_chip *mchp_pwm;
+	struct resource *regs;
+	int ret;
+
+	mchp_pwm = devm_kzalloc(&pdev->dev, sizeof(*mchp_pwm), GFP_KERNEL);
+	if (!mchp_pwm)
+		return -ENOMEM;
+
+	mchp_pwm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
+	if (IS_ERR(mchp_pwm->base))
+		return PTR_ERR(mchp_pwm->base);
+
+	mchp_pwm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(mchp_pwm->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(mchp_pwm->clk),
+				     "failed to get PWM clock\n");
+
+	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask",
+				 &mchp_pwm->sync_update_mask))
+		mchp_pwm->sync_update_mask = 0u;
+
+	mutex_init(&mchp_pwm->lock);
+
+	mchp_pwm->chip.dev = &pdev->dev;
+	mchp_pwm->chip.ops = &mchp_core_pwm_ops;
+	mchp_pwm->chip.npwm = 16;
+
+	mchp_pwm->channel_enabled = readb_relaxed(mchp_pwm->base + MCHPCOREPWM_EN(0));
+	mchp_pwm->channel_enabled |= readb_relaxed(mchp_pwm->base + MCHPCOREPWM_EN(1)) << 8;
+
+	ret = devm_pwmchip_add(&pdev->dev, &mchp_pwm->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+
+	return 0;
+}
+
+static struct platform_driver mchp_core_pwm_driver = {
+	.driver = {
+		.name = "mchp-core-pwm",
+		.of_match_table = mchp_core_of_match,
+	},
+	.probe = mchp_core_pwm_probe,
+};
+module_platform_driver(mchp_core_pwm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("corePWM driver for Microchip FPGAs");
-- 
2.36.1

