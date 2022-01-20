Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6549522A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376985AbiATQPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:15:17 -0500
Received: from box.trvn.ru ([194.87.146.52]:50075 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376908AbiATQPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:15:05 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BAFD241A43;
        Thu, 20 Jan 2022 21:15:01 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1642695302; bh=R0jpJBls5JmCwVCLpVXHSI9u3DEEXSFznMNecQ1yAeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dr1dxvmkC6HCPiVCj4aPzEORcXkQGtiSX+Cb5/FNV/ETtkyk5HiR4e05H1x/7NCDv
         arTYTO5sA2UGv9CbNccDPDHmumCDFMynNSnzrlQcNzYmSUH0q5HXEkp1I/6IVYmWoF
         Ix2kIKexv/xHrsi1XaAIZk9gL134uft0Kv+yiPCOiyBnLV7q8acZUNKY/A1KpIt+Ys
         euNmd0SFH2YtTX/XlLhWOYQd5ispMJkO2BBvWR6vReWjx5eBefVlRXtnxpxwUoYiFK
         08NBw0XSfme4x5rygnBiPqDRhMA47+G0f7AizYX8ljsRkdlyO1qZA6La+TWKr86zzW
         Qws06OrEMA3SA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 3/3] pwm: Add clock based PWM output driver
Date:   Thu, 20 Jan 2022 21:14:42 +0500
Message-Id: <20220120161442.140800-4-nikita@trvn.ru>
In-Reply-To: <20220120161442.140800-1-nikita@trvn.ru>
References: <20220120161442.140800-1-nikita@trvn.ru>
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
Changes in v3:
 - Use 64bit version of div round up
 - Address Uwe's review comments:
   - Reword the limitations to avoid incorrect claims
   - Move the clk_enabled flag assignment
   - Drop unnecessary statements
---
 drivers/pwm/Kconfig   |  10 +++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-clk.c | 139 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)
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
index 000000000000..b3bfa12a0e73
--- /dev/null
+++ b/drivers/pwm/pwm-clk.c
@@ -0,0 +1,139 @@
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
+ * - Glitches are possible when new pwm state is applied.
+ * - Due to the fact that exact behavior depends on the underlying
+ *   clock driver, various limitations are possible.
+ * - Period depends on the clock and, in general, not guaranteed.
+ * - Underlying clock may not be able to give 0% or 100% duty cycle
+ *   (constant off or on), exact behavior will depend on the clock.
+ * - When the PWM is disabled, the clock will be disabled as well,
+ *   line state will depend on the clock.
+ */
+
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
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
+		if (ret)
+			return ret;
+		chip->clk_enabled = true;
+	}
+
+	rate = DIV64_U64_ROUND_UP(NSEC_PER_SEC, period);
+	ret = clk_set_rate(chip->clk, rate);
+	if (ret)
+		return ret;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		duty_cycle = period - duty_cycle;
+
+	return clk_set_duty_cycle(chip->clk, duty_cycle, period);
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
+		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk),
+				     "Failed to get clock\n");
+
+	chip->chip.dev = &pdev->dev;
+	chip->chip.ops = &pwm_clk_ops;
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

