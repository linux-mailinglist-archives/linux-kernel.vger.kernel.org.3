Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C08247300A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbhLMPEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:04:00 -0500
Received: from box.trvn.ru ([194.87.146.52]:45911 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239886AbhLMPDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:03:51 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 5A8AE41F68;
        Mon, 13 Dec 2021 20:03:48 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639407828; bh=ZgSQjXZNem6OjBkl6vH8CUb7nfbue4TPoMnZ4gPvHMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D093Fb4GwFo0O0/RCcTmqq745CelSYoxLR85Fuijcondtwgkg6llyR2haOdTxik+Y
         gywlkkrIIX5ZKt0PMorRe9PZpQbzRLk/fixAdGw80KYkuplVIOnU8gZ2Ppj+GIwtbg
         UFzA1oIWq4GL0IXVWt6PQ4ykGLHfi4/T+t8A64jDzC0WjAwBdOUZ3jNp0uJou7+jYr
         cARcctXOJSfvKl5H8Y6ab0AnBmP5SG6kfLJdSCxeWLH214A5LUecYo4ya5GMUP8bTW
         wjtpy3EUQBtgn8MPo863AYdfosekeyElcF2JHBULLin4/uAil7C3QdbhlbamGDudc9
         diis3E763ww4g==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 2/2] pwm: Add clock based PWM output driver
Date:   Mon, 13 Dec 2021 20:03:35 +0500
Message-Id: <20211213150335.51888-3-nikita@trvn.ru>
In-Reply-To: <20211213150335.51888-1-nikita@trvn.ru>
References: <20211213150335.51888-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems have clocks exposed to external devices. If the clock
controller supports duty-cycle configuration, such clocks can be used as
pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
similar way and an "opposite" driver already exists (clk-pwm). Add a
driver that would enable pwm devices to be used via clk subsystem.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
--

Changes in v2:
 - Address Uwe's review comments:
   - Round set clk rate up
   - Add a description with limitations of the driver
   - Disable and unprepare clock before removing pwmchip
---
 drivers/pwm/Kconfig   |  10 +++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-clk.c | 143 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/pwm/pwm-clk.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 21e3b05a5153..daa2491a4054 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -140,6 +140,16 @@ config PWM_BRCMSTB
 	  To compile this driver as a module, choose M Here: the module
 	  will be called pwm-brcmstb.c.
 
+config PWM_CLK
+	tristate "Clock based PWM support"
+	depends on HAVE_CLK || COMPILE_TEST
+	help
+	  Generic PWM framework driver for outputs that can be
+	  muxed to clocks.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-clk.
+
 config PWM_CLPS711X
 	tristate "CLPS711X PWM support"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 708840b7fba8..4a860103c470 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
+obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
new file mode 100644
index 000000000000..55fd320b9c19
--- /dev/null
+++ b/drivers/pwm/pwm-clk.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock based PWM controller
+ *
+ * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
+ *
+ * This is an "adapter" driver that allows PWM consumers to use
+ * system clocks with duty cycle control as PWM outputs.
+ *
+ * Limitations:
+ * - There is no way to atomically set both clock rate and
+ *   duty-cycle so glitches are possible when new pwm state
+ *   is applied.
+ * - Period depends on the underlying clock driver and,
+ *   in general, not guaranteed.
+ * - Underlying clock may not be able to give 100%
+ *   duty cycle (constant on) and only set the closest
+ *   possible duty cycle. (e.g. 99.9%)
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+struct pwm_clk_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	bool clk_enabled;
+};
+
+#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
+
+static int pwm_clk_apply(struct pwm_chip *pwm_chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct pwm_clk_chip *chip = to_pwm_clk_chip(pwm_chip);
+	int ret;
+	u32 rate;
+	u64 period = state->period;
+	u64 duty_cycle = state->duty_cycle;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled) {
+			clk_disable(chip->clk);
+			chip->clk_enabled = false;
+		}
+		return 0;
+	} else if (!pwm->state.enabled) {
+		ret = clk_enable(chip->clk);
+		chip->clk_enabled = true;
+		if (ret)
+			return ret;
+	}
+
+	rate = DIV_ROUND_UP(NSEC_PER_SEC, period);
+	ret = clk_set_rate(chip->clk, rate);
+	if (ret)
+		return ret;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		duty_cycle = period - duty_cycle;
+
+	ret = clk_set_duty_cycle(chip->clk, duty_cycle, period);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static const struct pwm_ops pwm_clk_ops = {
+	.apply = pwm_clk_apply,
+	.owner = THIS_MODULE,
+};
+
+static int pwm_clk_probe(struct platform_device *pdev)
+{
+	struct pwm_clk_chip *chip;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(chip->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk), "Failed to get clock\n");
+
+	chip->chip.dev = &pdev->dev;
+	chip->chip.ops = &pwm_clk_ops;
+	chip->chip.of_xlate = of_pwm_xlate_with_flags;
+	chip->chip.of_pwm_n_cells = 2;
+	chip->chip.npwm = 1;
+
+	ret = clk_prepare(chip->clk);
+	if (ret < 0)
+		dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
+
+	ret = pwmchip_add(&chip->chip);
+	if (ret < 0)
+		dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
+
+	platform_set_drvdata(pdev, chip);
+	return 0;
+}
+
+static int pwm_clk_remove(struct platform_device *pdev)
+{
+	struct pwm_clk_chip *chip = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&chip->chip);
+
+	if (chip->clk_enabled)
+		clk_disable(chip->clk);
+
+	clk_unprepare(chip->clk);
+
+	return 0;
+}
+
+static const struct of_device_id pwm_clk_dt_ids[] = {
+	{ .compatible = "clk-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pwm_clk_dt_ids);
+
+static struct platform_driver pwm_clk_driver = {
+	.driver = {
+		.name = "pwm-clk",
+		.of_match_table = pwm_clk_dt_ids,
+	},
+	.probe = pwm_clk_probe,
+	.remove = pwm_clk_remove,
+};
+module_platform_driver(pwm_clk_driver);
+
+MODULE_ALIAS("platform:pwm-clk");
+MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
+MODULE_DESCRIPTION("Clock based PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

