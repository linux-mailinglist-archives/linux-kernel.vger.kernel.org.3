Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347BE57D25B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiGURVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGURV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:21:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C01F2B611
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:21:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a5so3191247wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKFlMNoRZNMbimi2EeV/cgP8CxzqyNd0gTC1i+1Q0p8=;
        b=NuG5LtZsrE2y2A2GHZ2TmuQPJSmxlwbrG+2zxN/GuT9QJrf/5B9dCPAEYzfAMvkQ/d
         +KTELN1uQgvJ0H6dZHI3zcoCvC2Y3p8JZZM4mYQyxouFvPM2jSpyfwjylflL8+TGnVkd
         hQTtJPF5v4zZduBRo67prW8oFjCJi0m5RyEmIXytCqfQIW0OeKaO6+hbcACsle7iQdyr
         Sy7h3b1oA+jlhHraI3BAn5lYDpQ90xCShwGEl3wTy4tVqfgMdn2RXN7yiI8g3C8YjqTC
         nk+Z+TsZOE9ZVvI15OxptB5yvRXPA9DmivDyjY7f1G8gcMyoQcaATmj+Hggu85jCkjlZ
         RMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKFlMNoRZNMbimi2EeV/cgP8CxzqyNd0gTC1i+1Q0p8=;
        b=iwc/Q4R8xqcaVeQEdNnqpHGHDAyIFLcHohX81tiV/OkfTgFi1XO9BwW0joL4YRlosL
         VRC+fzzRETQb6fqzc+QFrlX7Grkg6kQXJnq4e6RvkOVEtpMoB6xABTNqemIseq6Er2Zk
         Pl4tSR7hiH0rTxFXoIzI0PjDVwYBISdNM+AYdKu1rSkQccaDrx6lLaOmM6kYBBGN6hQl
         IxjKfgdFM9ZqbfzUFjHOWx46ckZIkH1tpv0lRZ7wRWnnABm2REr8ojgmcLZqXNUOPdj0
         mQXwxtzHTtfCfpPKpqyIKdQjKbAHa2CSrD1yMMTM8+kww2xhT8lPKS/Kn1kiAYHiKa76
         +N3Q==
X-Gm-Message-State: AJIora93tERutCYzjKgsODY3FDdTSFksfCrj9n7+WFcT+l/3esMdWPZg
        W/lOWUmaHstGKAUd9g0t8MmDTw==
X-Google-Smtp-Source: AGRyM1sNWeQliiCvTj3Nyh2PceHU2MN/Ch0q7YlErtvxjeyO/+YzH1WqBfejVKJOhLQ/0vDKJRk6Yw==
X-Received: by 2002:a5d:5311:0:b0:21d:656b:807e with SMTP id e17-20020a5d5311000000b0021d656b807emr34478737wrv.521.1658424085611;
        Thu, 21 Jul 2022 10:21:25 -0700 (PDT)
Received: from henark71.. ([109.76.125.251])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003a2cf1535aasm2455697wme.17.2022.07.21.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:21:25 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     u.kleine-koenig@pengutronix.de
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, thierry.reding@gmail.com
Subject: [PATCH v7 3/4] pwm: add microchip soft ip corePWM driver
Date:   Thu, 21 Jul 2022 18:21:09 +0100
Message-Id: <20220721172109.941900-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721172109.941900-1-mail@conchuod.ie>
References: <20220721172109.941900-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add a driver that supports the Microchip FPGA "soft" PWM IP core.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pwm/Kconfig              |  10 +
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-microchip-core.c | 371 +++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 904de8d61828..007ea5750e73 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -383,6 +383,16 @@ config PWM_MEDIATEK
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
index 5c08bdb817b4..43feb7cfc66a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
+obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
new file mode 100644
index 000000000000..2d12248f86b8
--- /dev/null
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -0,0 +1,371 @@
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
+	 * write these registers and wait for them to be applied before calling
+	 * enable().
+	 */
+	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
+		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
+		usleep_range(period, period * 2);
+	}
+}
+
+static u64 mchp_core_pwm_calc_duty(struct pwm_chip *chip, struct pwm_device *pwm,
+				   const struct pwm_state *state, u8 prescale, u8 period_steps)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u64 duty_steps, period, tmp;
+	u16 prescale_val = PREG_TO_VAL(prescale);
+	u8 period_steps_val = PREG_TO_VAL(period_steps);
+
+	period = period_steps_val * prescale_val * NSEC_PER_SEC;
+	period = DIV64_U64_ROUND_UP(period, clk_get_rate(mchp_core_pwm->clk));
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
+	 * Turn the output on unless posedge == negedge, in which case the
+	 * duty is intended to be 0, but limitations of the IP block don't
+	 * allow a zero length duty cycle - so just set the max high/low time
+	 * respectively.
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
+	if (tmp >= MCHPCOREPWM_PERIOD_MAX) {
+		*prescale = MCHPCOREPWM_PRESCALE_MAX - 1;
+		*period_steps = MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
+		return 0;
+	}
+
+	*prescale = div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
+	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
+	*period_steps = div_u64(tmp, PREG_TO_VAL((u32)*prescale)) - 1;
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
+	u8 prescale, period_steps, hw_prescale, hw_period_steps;
+	int ret;
+
+	ret = mutex_lock_interruptible(&mchp_core_pwm->lock);
+	if (ret)
+		return ret;
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
+		mchp_core_pwm_calc_period(chip, state, &prescale, &period_steps);
+		hw_prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+		hw_period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
+
+		if ((period_steps * prescale) < (hw_period_steps * hw_prescale)) {
+			mutex_unlock(&mchp_core_pwm->lock);
+			return -EINVAL;
+		}
+
+		prescale = hw_prescale;
+		period_steps = hw_period_steps;
+	} else if (!current_state.enabled || current_state.period != state->period) {
+		ret = mchp_core_pwm_calc_period(chip, state, &prescale, &period_steps);
+		if (ret) {
+			mutex_unlock(&mchp_core_pwm->lock);
+			return ret;
+		}
+		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
+	} else {
+		prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+		period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
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
+	int ret;
+
+	ret = mutex_lock_interruptible(&mchp_core_pwm->lock);
+	if (ret)
+		return;
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
+	if (negedge == posedge) {
+		state->duty_cycle = state->period / 2;
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
2.37.1

