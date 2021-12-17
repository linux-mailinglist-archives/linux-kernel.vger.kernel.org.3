Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA2478A60
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhLQLqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbhLQLqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:46:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5EC06173E;
        Fri, 17 Dec 2021 03:46:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id co15so2026362pjb.2;
        Fri, 17 Dec 2021 03:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VfYvv8CdBWc6RQO1VF2WxtqklqiNs45I0XH86gJfgtU=;
        b=oqM2SRnZMuQjX53B6bAKCtUtrHH9kCw/FVOdUN934xGAWXvOo/aC+PoSOUpLJkxgBb
         qll8OYHqG0N74Gan81uh7uv+njksvD0tlWYBmImET6/WsGCf/KNzntfq5tOyrhr6642d
         iDn5b04x3DhXVWHl0kxNR3q/8gVuCXkBdpZuE3sqewyVBKYkAyxnn8S+xV40D7nmS4oc
         LxsNNJxtI9LlLP0WcHI2ppSLOnhnb3hlQocW842lZjTUYX0mOnzYhwXjAdzd+t2VupUQ
         UzdBbBnTTJbW1BX5ROmRFwoayiDzh1DaXowyvhlH8N3CSAEMfS0P5mjSVz4U2ZcOWq6N
         1Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VfYvv8CdBWc6RQO1VF2WxtqklqiNs45I0XH86gJfgtU=;
        b=I4iyEFQGiPsl/+w8D84NU8/4aS0N4gvermvqbnvSn2I7i4jqoTK4leVQhrJWk041/k
         i4knbb49zAt/k11eoFOpKa1de57kWEKY7p3BwXaykmc2wFoO3ip0NDps72m92W7A8tyy
         iqAkgGucpCMI69nTP3k4TtPvjUyfQv7poiNsreJhX1an+xzPaSui+nVMjDgYk6S49ztn
         1UtSkgcijTi29hHVKWRxJ34WlOE8nBkJ/t0Fl98EkZSwVmsAcu72nEyp8WYiX02PBVkq
         vKrgzufe9wBDmqgYfyTVUIB5ZaYjCDt8yeYCjXC2ZpfpIHrLHka7vQHgPbq/10HcLIZh
         5V0g==
X-Gm-Message-State: AOAM533p/6UdYJHB9itNB+7CuPuHc3lmiPHhDn+T356lFq2uUEvEFied
        77J39kV/a0vSSzyZSkTcmQPPf6ZFVhFSGw==
X-Google-Smtp-Source: ABdhPJwrFm1ODH5bToECJnRe4XshOgVfudwDL3SqHaxkEeCEdpNblTVHxSgbOq6DLrxqX+jU4LH9AA==
X-Received: by 2002:a17:90b:517:: with SMTP id r23mr11916278pjz.152.1639741567818;
        Fri, 17 Dec 2021 03:46:07 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id kb1sm1663225pjb.56.2021.12.17.03.46.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:46:07 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v1 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
Date:   Fri, 17 Dec 2021 19:46:08 +0800
Message-Id: <1639741568-5846-3-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sunplus SoC PWM Driver

Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
 MAINTAINERS               |   1 +
 drivers/pwm/Kconfig       |  11 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-sunplus.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 drivers/pwm/pwm-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 721ed79..1c9e3c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18246,6 +18246,7 @@ SUNPLUS PWM DRIVER
 M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
+F:	drivers/pwm/pwm-sunplus.c
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 21e3b05..9df5d5f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -526,6 +526,17 @@ config PWM_SPRD
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sprd.
 
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
 config PWM_STI
 	tristate "STiH4xx PWM support"
 	depends on ARCH_STI || COMPILE_TEST
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
index 0000000..0ae59fc
--- /dev/null
+++ b/drivers/pwm/pwm-sunplus.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM device driver for SUNPLUS SoCs
+ *
+ * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
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
+};
+
+static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sunplus_pwm, chip);
+}
+
+static void sunplus_reg_init(void __iomem *base)
+{
+	u32 i, value;
+
+	/* turn off all pwm channel output */
+	value = readl(base + PWM_SUP_CONTROL0);
+	value &= ~GENMASK((PWM_SUP_NUM - 1), 0);
+	writel(value, base + PWM_SUP_CONTROL0);
+
+	/* init all pwm channel clock source */
+	value = readl(base + PWM_SUP_CONTROL1);
+	value |= GENMASK((PWM_SUP_NUM - 1), 0);
+	writel(value, base + PWM_SUP_CONTROL1);
+
+	/* init all freq and duty setting */
+	for (i = 0; i < PWM_SUP_NUM; i++) {
+		writel(0, base + PWM_SUP_FREQ(i));
+		writel(0, base + PWM_SUP_DUTY(i));
+	}
+}
+
+static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct sunplus_pwm *priv = to_sunplus_pwm(chip);
+	u32 period_ns, duty_ns, value;
+	u32 dd_freq, duty;
+	u64 tmp;
+
+	if (!state->enabled) {
+		value = readl(priv->base + PWM_SUP_CONTROL0);
+		value &= ~BIT(pwm->hwpwm);
+		writel(value, priv->base + PWM_SUP_CONTROL0);
+		return 0;
+	}
+
+	period_ns = state->period;
+	duty_ns = state->duty_cycle;
+
+	/* cal pwm freq and check value under range */
+	tmp = clk_get_rate(priv->clk) * (u64)period_ns;
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, PWM_SUP_FREQ_SCALER);
+	dd_freq = (u32)tmp;
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
+	if (duty_ns == period_ns) {
+		value |= BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
+		duty = PWM_SUP_DUTY_MAX;
+	} else {
+		value &= ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
+		tmp = (u64)duty_ns * PWM_SUP_FREQ_SCALER + (period_ns >> 1);
+		tmp = DIV_ROUND_CLOSEST_ULL(tmp, (u64)period_ns);
+		duty = (u32)tmp;
+		duty |= (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
+	}
+	writel(value, priv->base + PWM_SUP_CONTROL0);
+	writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
+
+	return 0;
+}
+
+static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct sunplus_pwm *priv = to_sunplus_pwm(chip);
+	u32 value;
+
+	value = readl(priv->base + PWM_SUP_CONTROL0);
+
+	if (value & BIT(pwm->hwpwm))
+		state->enabled = true;
+	else
+		state->enabled = false;
+}
+
+static const struct pwm_ops sunplus_pwm_ops = {
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
+	sunplus_reg_init(priv->base);
+
+	platform_set_drvdata(pdev, priv);
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
+MODULE_AUTHOR("Hammer Hsieh <hammer.hsieh@sunplus.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

