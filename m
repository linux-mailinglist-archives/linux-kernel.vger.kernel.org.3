Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA21B4CCDAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiCDGUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiCDGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:20:49 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF5D3120C;
        Thu,  3 Mar 2022 22:20:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso6678245pjq.1;
        Thu, 03 Mar 2022 22:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mkb9pczzi33Hx+wSl9dYOwtSdzpP9TyuWf0PH26stkE=;
        b=k9FrvRsBYFQjN5y8NEZFuLbxE5lnO4ozB4UpV0kRqQP/Ynt15o6x32qO/SESnegGaP
         nkNUwJgzbG0tCWab79URBWoxT5TBTUv/KVlr5KAQ7hoHbN/iMJyvAs3R/23HiiLjN4ia
         DybEvilX2g2c3EOiJ7AjCyreA6wIPkSRJ6Nq72N3Ft3VSr6Kzy9XlcfEirLDB+sWyoZg
         2cz3CZI1ZafLlJrVnFRLrCTQNQhBxQu0eeMaROqpg6Up3dUObzAqXLLiEFuGYy0hymib
         ogsB4VnQ8JzgvvYRoB1Dkpj8GoIgIEEezQ+eLFdIMF7bAzD5/OK0Xh9yWVFWPIqegP+i
         NBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mkb9pczzi33Hx+wSl9dYOwtSdzpP9TyuWf0PH26stkE=;
        b=D27V1toNQDZzzkzAEaUuxc064W+25VXh2ONUnDKcS+GvWO258jEU4IJj8PE730OPZf
         jRr1aOJmaAaBjFvLGxU2g5sJ1DlU7hp7wcwfsYi4TMw4NDfwg9Qxggl9PXanfL3rW6vL
         FIPSXC0aUXUx4UW+N462Dbe4QNxCJEU8BC8s9n3dI87fWP0Y6uBleGPAXG87rjCyCWcf
         SHl51XX79c5001/FABnWixpUAQXpu5bt2gBKYJzqFGoL0EYFkGNMzmwlHXEnqIzusiqa
         mlXj+FoCbaDFLfkFatUKr6lrkB7rk4BadnoN8wRE0hybdCwZKPFmwRrjydccwKiD7364
         zF9Q==
X-Gm-Message-State: AOAM533f1N388+72C62facvB6QNcnhfNkjB5ASxZuqlyxvocHTe+jX/P
        Ojr1QNDjrOmwQtT5CGBXiCY=
X-Google-Smtp-Source: ABdhPJyLcNagLwUGcz0STUU3xDa5DfGUb5e7o8NrYHBYgtNPSOxei1I0n9X4CQk5JSUMOxaZGv03iA==
X-Received: by 2002:a17:902:c215:b0:14f:f1c2:9fe3 with SMTP id 21-20020a170902c21500b0014ff1c29fe3mr40112013pll.145.1646374801252;
        Thu, 03 Mar 2022 22:20:01 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id kb6-20020a17090ae7c600b001bee8664d82sm8749471pjb.35.2022.03.03.22.19.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2022 22:20:01 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v2 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
Date:   Fri,  4 Mar 2022 14:20:12 +0800
Message-Id: <1646374812-2988-3-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sunplus SoC PWM Driver

Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v2:
 - Addressed all comments from Uwe Kleine-König.
 - rebase kernel to 5.17 rc5

 MAINTAINERS               |   1 +
 drivers/pwm/Kconfig       |  11 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-sunplus.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 drivers/pwm/pwm-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 825b714..8710c8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18535,6 +18535,7 @@ SUNPLUS PWM DRIVER
 M:	Hammer Hsieh <hammerh0314@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
+F:	drivers/pwm/pwm-sunplus.c
 
 SUNPLUS RTC DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 21e3b05..54cfb50 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -572,6 +572,17 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUNPLUS
+	tristate "Sunplus PWM support"
+	depends on ARCH_SUNPLUS || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	help
+	  Generic PWM framework driver for the PWM controller on
+	  Sunplus SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sunplus.
+
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 708840b..be58616 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
new file mode 100644
index 0000000..170534f
--- /dev/null
+++ b/drivers/pwm/pwm-sunplus.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM device driver for SUNPLUS SoCs
+ *
+ * Limitations:
+ * - Only supports normal polarity.
+ *
+ * Author: Hammer Hsieh <hammerh0314@gmail.com>
+ */
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define PWM_SUP_CONTROL0	0x000
+#define PWM_SUP_CONTROL1	0x004
+#define PWM_SUP_FREQ_BASE	0x008
+#define PWM_SUP_DUTY_BASE	0x018
+#define PWM_SUP_FREQ(ch)	(PWM_SUP_FREQ_BASE + 4 * (ch))
+#define PWM_SUP_DUTY(ch)	(PWM_SUP_DUTY_BASE + 4 * (ch))
+#define PWM_SUP_FREQ_MAX	GENMASK(15, 0)
+#define PWM_SUP_DUTY_MAX	GENMASK(7, 0)
+
+#define PWM_SUP_NUM		4
+#define PWM_BYPASS_BIT_SHIFT	8
+#define PWM_DD_SEL_BIT_SHIFT	8
+#define PWM_SUP_FREQ_SCALER	256
+
+struct sunplus_pwm {
+	struct pwm_chip chip;
+	void __iomem *base;
+	struct clk *clk;
+	u32 approx_period[PWM_SUP_NUM];
+	u32 approx_duty_cycle[PWM_SUP_NUM];
+};
+
+static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sunplus_pwm, chip);
+}
+
+static void sunplus_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sunplus_pwm *priv = to_sunplus_pwm(chip);
+	u32 value;
+
+	/* disable pwm channel output */
+	value = readl(priv->base + PWM_SUP_CONTROL0);
+	value &= ~BIT(pwm->hwpwm);
+	writel(value, priv->base + PWM_SUP_CONTROL0);
+	/* disable pwm channel clk source */
+	value = readl(priv->base + PWM_SUP_CONTROL1);
+	value &= ~BIT(pwm->hwpwm);
+	writel(value, priv->base + PWM_SUP_CONTROL1);
+}
+
+static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct sunplus_pwm *priv = to_sunplus_pwm(chip);
+	u32 dd_freq, duty, value, value1;
+	u32 tmp, rate;
+	u64 max_period, period_ns, duty_ns, clk_rate;
+
+	if (state->polarity != pwm->state.polarity)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		/* disable pwm channel output */
+		value = readl(priv->base + PWM_SUP_CONTROL0);
+		value &= ~BIT(pwm->hwpwm);
+		writel(value, priv->base + PWM_SUP_CONTROL0);
+		/* disable pwm channel clk source */
+		value = readl(priv->base + PWM_SUP_CONTROL1);
+		value &= ~BIT(pwm->hwpwm);
+		writel(value, priv->base + PWM_SUP_CONTROL1);
+		return 0;
+	}
+
+	clk_rate = clk_get_rate(priv->clk);
+	rate = (u32)clk_rate / 100000;
+	max_period = PWM_SUP_FREQ_MAX * (PWM_SUP_FREQ_SCALER * 10000 / rate);
+
+	if (state->period > max_period)
+		return -EINVAL;
+
+	period_ns = state->period;
+	duty_ns = state->duty_cycle;
+
+	priv->approx_period[pwm->hwpwm] = (u32)period_ns / 100;
+	priv->approx_duty_cycle[pwm->hwpwm] = (u32)duty_ns / 100;
+
+	/* cal pwm freq and check value under range */
+	dd_freq = rate * priv->approx_period[pwm->hwpwm] / (PWM_SUP_FREQ_SCALER * 100);
+
+	if (dd_freq == 0)
+		return -EINVAL;
+
+	if (dd_freq > PWM_SUP_FREQ_MAX)
+		dd_freq = PWM_SUP_FREQ_MAX;
+
+	writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));
+
+	/* cal and set pwm duty */
+	value = readl(priv->base + PWM_SUP_CONTROL0);
+	value |= BIT(pwm->hwpwm);
+	value1 = readl(priv->base + PWM_SUP_CONTROL1);
+	value1 |= BIT(pwm->hwpwm);
+	if (duty_ns == period_ns) {
+		value |= BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
+		duty = PWM_SUP_DUTY_MAX;
+	} else {
+		value &= ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
+		tmp = priv->approx_duty_cycle[pwm->hwpwm] * PWM_SUP_FREQ_SCALER;
+		tmp /= priv->approx_period[pwm->hwpwm];
+		duty = (u32)tmp;
+		duty |= (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
+	}
+	writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
+	writel(value1, priv->base + PWM_SUP_CONTROL1);
+	writel(value, priv->base + PWM_SUP_CONTROL0);
+
+	return 0;
+}
+
+static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct sunplus_pwm *priv = to_sunplus_pwm(chip);
+	u32 value, freq, duty, rate, freq_tmp, duty_tmp;
+	u64 tmp, clk_rate;
+
+	value = readl(priv->base + PWM_SUP_CONTROL0);
+
+	if (value & BIT(pwm->hwpwm)) {
+		clk_rate = clk_get_rate(priv->clk);
+		rate = (u32)clk_rate / 100000;
+		freq = readl(priv->base + PWM_SUP_FREQ(pwm->hwpwm));
+		duty = readl(priv->base + PWM_SUP_DUTY(pwm->hwpwm));
+		duty &= ~GENMASK(9, 8);
+
+		freq_tmp = rate * priv->approx_period[pwm->hwpwm] / (PWM_SUP_FREQ_SCALER * 100);
+		duty_tmp = priv->approx_duty_cycle[pwm->hwpwm] * PWM_SUP_FREQ_SCALER /
+				priv->approx_period[pwm->hwpwm];
+
+		if (freq == freq_tmp && duty == duty_tmp) {
+			state->period = priv->approx_period[pwm->hwpwm] * 100;
+			state->duty_cycle = priv->approx_duty_cycle[pwm->hwpwm] * 100;
+		} else {
+			tmp = (u64)freq * PWM_SUP_FREQ_SCALER * 10000;
+			state->period = div64_u64(tmp, rate);
+			tmp = (u64)freq * (u64)duty * 10000;
+			state->duty_cycle = div64_u64(tmp, rate);
+		}
+		state->enabled = true;
+	} else {
+		state->enabled = false;
+	}
+
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static const struct pwm_ops sunplus_pwm_ops = {
+	.free = sunplus_pwm_free,
+	.apply = sunplus_pwm_apply,
+	.get_state = sunplus_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int sunplus_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sunplus_pwm *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "get pwm clock failed\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       priv->clk);
+	if (ret)
+		return ret;
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &sunplus_pwm_ops;
+	priv->chip.npwm = PWM_SUP_NUM;
+
+	ret = devm_pwmchip_add(dev, &priv->chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Cannot register sunplus PWM\n");
+
+	return 0;
+}
+
+static const struct of_device_id sunplus_pwm_of_match[] = {
+	{ .compatible = "sunplus,sp7021-pwm", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sunplus_pwm_of_match);
+
+static struct platform_driver sunplus_pwm_driver = {
+	.probe		= sunplus_pwm_probe,
+	.driver		= {
+		.name	= "sunplus-pwm",
+		.of_match_table = sunplus_pwm_of_match,
+	},
+};
+module_platform_driver(sunplus_pwm_driver);
+
+MODULE_DESCRIPTION("Sunplus SoC PWM Driver");
+MODULE_AUTHOR("Hammer Hsieh <hammerh0314@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4

