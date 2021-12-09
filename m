Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F22E46ECF4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbhLIQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:24:30 -0500
Received: from box.trvn.ru ([194.87.146.52]:44155 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241048AbhLIQYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:24:23 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8EC4841F1C;
        Thu,  9 Dec 2021 21:20:45 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639066846; bh=b4kQlwq1QWP/KG4nMrfzm43rDgHCBsWVQiej2DufAxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAg7JCgMSTdzlYSS4aZICGQEKyLW9zI6SgDwmTawLNIE+YrWreZ7ZJ48omCR8kZea
         xRT4MdDmN18wO3asv3NP0oUS/As533LGCgJAP1ho7Ty5BMbpA3O36jWiVnSCXDFm9k
         3FfsU4NzHNZC7fr2hFFssIT9ix08Q4n0Kk1MggWGH9PefadP/NrWF8l8azjFss6YI1
         wRqt1HXGGBh9o+Hsd6tOqHPwpt0Q4XGUHPGvHCi/RJTooN22a+Ux+jBeujzI/JSXlV
         0xGVxv/TaR2w7zFWCYsRubaieEUY7Gv+8y2npiM6k622FyGOqQCI/1BozEjcdSAwO5
         MrAMidFzw3qOA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 2/2] pwm: Add clock based PWM output driver
Date:   Thu,  9 Dec 2021 21:20:20 +0500
Message-Id: <20211209162020.105255-3-nikita@trvn.ru>
In-Reply-To: <20211209162020.105255-1-nikita@trvn.ru>
References: <20211209162020.105255-1-nikita@trvn.ru>
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
---
 drivers/pwm/Kconfig   |  10 ++++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-clk.c | 119 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
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
index 000000000000..11c156529761
--- /dev/null
+++ b/drivers/pwm/pwm-clk.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
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
+
+	if (!state->enabled && !pwm->state.enabled)
+		return 0;
+
+	if (state->enabled && !pwm->state.enabled) {
+		ret = clk_enable(chip->clk);
+		if (ret)
+			return ret;
+	}
+
+	if (!state->enabled && pwm->state.enabled) {
+		clk_disable(chip->clk);
+		return 0;
+	}
+
+	rate = div64_u64(NSEC_PER_SEC, state->period);
+	ret = clk_set_rate(chip->clk, rate);
+	if (ret)
+		return ret;
+
+	return clk_set_duty_cycle(chip->clk, state->duty_cycle, state->period);
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
+	if (IS_ERR(chip->clk)) {
+		dev_err(&pdev->dev, "Failed to get clock: %ld\n", PTR_ERR(chip->clk));
+		return PTR_ERR(chip->clk);
+	}
+
+	chip->chip.dev = &pdev->dev;
+	chip->chip.ops = &pwm_clk_ops;
+	chip->chip.of_xlate = of_pwm_xlate_with_flags;
+	chip->chip.of_pwm_n_cells = 2;
+	chip->chip.base = 0;
+	chip->chip.npwm = 1;
+
+	ret = clk_prepare(chip->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to prepare clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = pwmchip_add(&chip->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to add pwm chip: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, chip);
+	return 0;
+}
+
+static int pwm_clk_remove(struct platform_device *pdev)
+{
+	struct pwm_clk_chip *chip = platform_get_drvdata(pdev);
+
+	clk_unprepare(chip->clk);
+
+	pwmchip_remove(&chip->chip);
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
+		.name = "clk-pwm",
+		.of_match_table = pwm_clk_dt_ids,
+	},
+	.probe = pwm_clk_probe,
+	.remove = pwm_clk_remove,
+};
+module_platform_driver(pwm_clk_driver);
+
+MODULE_ALIAS("platform:clk-pwm");
+MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
+MODULE_DESCRIPTION("Clock based PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

