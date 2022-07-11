Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B656D4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiGKGYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGKGYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:24:06 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4870647E;
        Sun, 10 Jul 2022 23:24:01 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 1E3D841A6F;
        Mon, 11 Jul 2022 11:23:59 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1657520639; bh=Uan2rxuWIYoyp2E+T74/Z4/1U8ihO7HhCKFSPFJ8fpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auN/fE6ro3Q0aMIKo81keSnWcSxatiWRKw5/4CVIYBvmO/W3U8ZL7grT6AlVc9qA4
         +pfGsm2ZHlIcv8FotoszJueL40Xv3NITxc/w6kdBTAOctBiJivZ+l/MZZwXrQsYlMK
         PV3nHbTH1VrD8GQvmEyAlJ0RuFdzbiV5ddHekHYG+BlSBRCOxOFgy4qQ+7IO9yG0Kv
         1hGHaTdRNOiR03CcWGcN0T1zZ50Bh0H7tG4Tk/AZk51UnRE6k2a4KClOaL1ss8QCvF
         D3DlwjAOVHf1avynXlmh1wHnH0Sj8dQjLx+VU8dOjMSk40so63aeDS8gkIbgDX9Un6
         Mb48XuQjGUiCA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v8 2/2] pwm: Add clock based PWM output driver
Date:   Mon, 11 Jul 2022 11:23:30 +0500
Message-Id: <20220711062330.4923-3-nikita@trvn.ru>
In-Reply-To: <20220711062330.4923-1-nikita@trvn.ru>
References: <20220711062330.4923-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v5:
 - add missed returns
Changes in v6:
 - Unprepare the clock on error
 - Drop redundant limitations points
Changes in v7:
 - Rename some variables to be in line with common naming
Changes in v8:
 - Document the glitch that happens inbetween multiple clock operations
---
 drivers/pwm/Kconfig   |  10 +++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-clk.c | 148 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/pwm/pwm-clk.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 904de8d61828..60d13a949bc5 100644
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
index 5c08bdb817b4..7bf1a29f02b8 100644
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
index 000000000000..c2a503d684a7
--- /dev/null
+++ b/drivers/pwm/pwm-clk.c
@@ -0,0 +1,148 @@
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
+ * - Due to the fact that exact behavior depends on the underlying
+ *   clock driver, various limitations are possible.
+ * - Underlying clock may not be able to give 0% or 100% duty cycle
+ *   (constant off or on), exact behavior will depend on the clock.
+ * - When the PWM is disabled, the clock will be disabled as well,
+ *   line state will depend on the clock.
+ * - The clk API doesn't expose the necessary calls to implement
+ *   .get_state().
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
+static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct pwm_clk_chip *pcchip = to_pwm_clk_chip(chip);
+	int ret;
+	u32 rate;
+	u64 period = state->period;
+	u64 duty_cycle = state->duty_cycle;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled) {
+			clk_disable(pcchip->clk);
+			pcchip->clk_enabled = false;
+		}
+		return 0;
+	} else if (!pwm->state.enabled) {
+		ret = clk_enable(pcchip->clk);
+		if (ret)
+			return ret;
+		pcchip->clk_enabled = true;
+	}
+
+	/*
+	 * We have to enable the clk before setting the rate and duty_cycle,
+	 * that however results in a window where the clk is on with a
+	 * (potentially) different setting. Also setting period and duty_cycle
+	 * are two separate calls, so that probably isn't atomic either.
+	 */
+
+	rate = DIV64_U64_ROUND_UP(NSEC_PER_SEC, period);
+	ret = clk_set_rate(pcchip->clk, rate);
+	if (ret)
+		return ret;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		duty_cycle = period - duty_cycle;
+
+	return clk_set_duty_cycle(pcchip->clk, duty_cycle, period);
+}
+
+static const struct pwm_ops pwm_clk_ops = {
+	.apply = pwm_clk_apply,
+	.owner = THIS_MODULE,
+};
+
+static int pwm_clk_probe(struct platform_device *pdev)
+{
+	struct pwm_clk_chip *pcchip;
+	int ret;
+
+	pcchip = devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
+	if (!pcchip)
+		return -ENOMEM;
+
+	pcchip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pcchip->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
+				     "Failed to get clock\n");
+
+	pcchip->chip.dev = &pdev->dev;
+	pcchip->chip.ops = &pwm_clk_ops;
+	pcchip->chip.npwm = 1;
+
+	ret = clk_prepare(pcchip->clk);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
+
+	ret = pwmchip_add(&pcchip->chip);
+	if (ret < 0) {
+		clk_unprepare(pcchip->clk);
+		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
+	}
+
+	platform_set_drvdata(pdev, pcchip);
+	return 0;
+}
+
+static int pwm_clk_remove(struct platform_device *pdev)
+{
+	struct pwm_clk_chip *pcchip = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&pcchip->chip);
+
+	if (pcchip->clk_enabled)
+		clk_disable(pcchip->clk);
+
+	clk_unprepare(pcchip->clk);
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
2.35.3

