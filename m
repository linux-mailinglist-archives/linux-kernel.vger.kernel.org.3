Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302DA4E3CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiCVKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiCVKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:44:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B96814A6;
        Tue, 22 Mar 2022 03:42:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4so15303475pjh.2;
        Tue, 22 Mar 2022 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jn8vvTcvEaPJgb/dZUiCvSJerjvDs1/Ppc/tD6RRPSM=;
        b=RyKKkj2oWEIii5oKt1VC+7CwAmuFRMiwlDl7fIrAeQvZINImoi+09uZUteq/BP+Q8Z
         Qr9EJt7i4j7DbN8oVFh8Qng5DalfvW1Ta0i9ZePymgku1WcGzFcxKohZ+1n7XxZC2HXl
         54RdsZwAQFHmlgbq1PXL0PSUGYwfuZfpTpjW9Q8zhu2DIHTAPszuFU3bsItBq5XEWxid
         3mLv/mRP0lzJqsvIMxYKQQL/QHEXtxDSunbbrlvCdd27WC2tzgEf5Q6uUfKG1gdMH1fD
         PFOLHuabYpF3ucsxmsBjILRudlLcpQPabRPiq3cePw8Ou6tpQz7TN//MB0oX5b51krA0
         upOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jn8vvTcvEaPJgb/dZUiCvSJerjvDs1/Ppc/tD6RRPSM=;
        b=dZOv4ViKPt7+dnKHEtStrwfLEvFaabs96Waaj3y4ERzHuWu5361nWVfzvt1dbehdO0
         EJDk2fFufFp/nfNWNSf0ZTP0AL0X1YP5nGrLu/WODFlttCobhH25xF7SjIxeLl5L0LQE
         /VoHzF8lyZHyOjBcdpKALSZe5tAo3LbTzpYWQZXox/MAMZLY6nyHFeSx9Q0lRyB9vP1l
         Y6Tdw8F4w5Q9bh/q2zu6JVM1jcJx2209cRiLNYlUHenx51EHPSgM9G3IVJT/TJ+Dc1t4
         qzh0skrVoz2L0NsqXTlRAIl8BE1Owd7bHLqCh8bkrqvaAHEPRj7xV4fh81fjG3trYCC5
         W4xg==
X-Gm-Message-State: AOAM533spJG+PNPklweNA5/tMz5efdVa+8zEkG++8zmCGRYT4pEHdFQL
        u5UKFTf+34tkr6iCYHCrA9Y=
X-Google-Smtp-Source: ABdhPJzKV5gDfvgVP0yrcyn0C7ALoiL8NnPAsNwFcf4bzqkKaAWfuqM0sp7+bSBLotpWUK4voQnvsg==
X-Received: by 2002:a17:90a:1704:b0:1c6:691b:17f3 with SMTP id z4-20020a17090a170400b001c6691b17f3mr4156953pjd.187.1647945767839;
        Tue, 22 Mar 2022 03:42:47 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id r26-20020a63a01a000000b00385fe08c264sm78113pge.1.2022.03.22.03.42.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Mar 2022 03:42:47 -0700 (PDT)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v4 2/2] pwm: sunplus-pwm: Add Sunplus SoC SP7021 PWM Driver
Date:   Tue, 22 Mar 2022 18:43:01 +0800
Message-Id: <1647945781-10191-3-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
References: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add Sunplus SoC SP7021 PWM Driver

Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v4:
 - Addressed all comments from Uwe Kleine-König.
   1. define name change based on datasheet.
   2. apply() period calculation modified by Uwe Kleine-König recommanded.
   3. use FIELD_GET / FIELD_PREP for simplify code.
 - Addressed all comments from Rob Herring.
   git-send-email asking encoding and press y casued message corrupted issue.
   just press enter to keep UTF-8 default setting.

 MAINTAINERS               |   1 +
 drivers/pwm/Kconfig       |  11 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-sunplus.c | 232 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/pwm/pwm-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e1cb7eb..6644bae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18535,6 +18535,7 @@ SUNPLUS PWM DRIVER
 M:	Hammer Hsieh <hammerh0314@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
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
index 0000000..e776fd1
--- /dev/null
+++ b/drivers/pwm/pwm-sunplus.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM device driver for SUNPLUS SP7021 SoC
+ *
+ * Links:
+ *   Reference Manual:
+ *   https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
+ *
+ *   Reference Manual(PWM module):
+ *   https://sunplus.atlassian.net/wiki/spaces/doc/pages/461144198/12.+Pulse+Width+Modulation+PWM
+ *
+ * Limitations:
+ * - Only supports normal polarity.
+ * - It output low when PWM channel disabled.
+ * - When the parameters change, current running period will not be completed
+ *     and run new settings immediately.
+ * - In .apply() PWM output need to write register FREQ and DUTY. When first write FREQ
+ *     done and not yet write DUTY, it has short timing gap use new FREQ and old DUTY.
+ *
+ * Author: Hammer Hsieh <hammerh0314@gmail.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define SP7021_PWM_MODE0		0x000
+#define SP7021_PWM_MODE0_PWMEN(ch)	BIT(ch)
+#define SP7021_PWM_MODE0_BYPASS(ch)	BIT(8 + (ch))
+#define SP7021_PWM_MODE1		0x004
+#define SP7021_PWM_MODE1_CNT_EN(ch)	BIT(ch)
+#define SP7021_PWM_FREQ(ch)		(0x008 + 4 * (ch))
+#define SP7021_PWM_FREQ_MAX		GENMASK(15, 0)
+#define SP7021_PWM_DUTY(ch)		(0x018 + 4 * (ch))
+#define SP7021_PWM_DUTY_DD_SEL(ch)	FIELD_PREP(GENMASK(9, 8), ch)
+#define SP7021_PWM_DUTY_MAX		GENMASK(7, 0)
+#define SP7021_PWM_DUTY_MASK		SP7021_PWM_DUTY_MAX
+#define SP7021_PWM_FREQ_SCALER		256
+#define SP7021_PWM_NUM			4
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
+static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct sunplus_pwm *priv = to_sunplus_pwm(chip);
+	u32 dd_freq, duty, mode0, mode1;
+	u64 clk_rate;
+
+	if (state->polarity != pwm->state.polarity)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		/* disable pwm channel output */
+		mode0 = readl(priv->base + SP7021_PWM_MODE0);
+		mode0 &= ~SP7021_PWM_MODE0_PWMEN(pwm->hwpwm);
+		writel(mode0, priv->base + SP7021_PWM_MODE0);
+		/* disable pwm channel clk source */
+		mode1 = readl(priv->base + SP7021_PWM_MODE1);
+		mode1 &= ~SP7021_PWM_MODE1_CNT_EN(pwm->hwpwm);
+		writel(mode1, priv->base + SP7021_PWM_MODE1);
+		return 0;
+	}
+
+	clk_rate = clk_get_rate(priv->clk);
+
+	/*
+	 * The following calculations might overflow if clk is bigger
+	 * than 256 GHz. In practise it's 202.5MHz, so this limitation
+	 * is only theoretic.
+	 */
+	if (clk_rate > (u64)SP7021_PWM_FREQ_SCALER * NSEC_PER_SEC)
+		return -EINVAL;
+
+	/*
+	 * With clk_rate limited above we have dd_freq <= state->period,
+	 * so this cannot overflow.
+	 */
+	dd_freq = mul_u64_u64_div_u64(clk_rate, state->period, (u64)SP7021_PWM_FREQ_SCALER
+				* NSEC_PER_SEC);
+
+	if (dd_freq == 0)
+		return -EINVAL;
+
+	if (dd_freq > SP7021_PWM_FREQ_MAX)
+		dd_freq = SP7021_PWM_FREQ_MAX;
+
+	writel(dd_freq, priv->base + SP7021_PWM_FREQ(pwm->hwpwm));
+
+	/* cal and set pwm duty */
+	mode0 = readl(priv->base + SP7021_PWM_MODE0);
+	mode0 |= SP7021_PWM_MODE0_PWMEN(pwm->hwpwm);
+	mode1 = readl(priv->base + SP7021_PWM_MODE1);
+	mode1 |= SP7021_PWM_MODE1_CNT_EN(pwm->hwpwm);
+	if (state->duty_cycle == state->period) {
+		/* PWM channel output = high */
+		mode0 |= SP7021_PWM_MODE0_BYPASS(pwm->hwpwm);
+		duty = SP7021_PWM_DUTY_DD_SEL(pwm->hwpwm) | SP7021_PWM_DUTY_MAX;
+	} else {
+		mode0 &= ~SP7021_PWM_MODE0_BYPASS(pwm->hwpwm);
+		/*
+		 * duty_ns <= period_ns 27 bits, clk_rate 28 bits, won't overflow.
+		 */
+		duty = mul_u64_u64_div_u64(state->duty_cycle, clk_rate,
+					   (u64)dd_freq * NSEC_PER_SEC);
+		duty = SP7021_PWM_DUTY_DD_SEL(pwm->hwpwm) | duty;
+	}
+	writel(duty, priv->base + SP7021_PWM_DUTY(pwm->hwpwm));
+	writel(mode1, priv->base + SP7021_PWM_MODE1);
+	writel(mode0, priv->base + SP7021_PWM_MODE0);
+
+	return 0;
+}
+
+static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct sunplus_pwm *priv = to_sunplus_pwm(chip);
+	u32 mode0, dd_freq, duty;
+	u64 clk_rate;
+
+	mode0 = readl(priv->base + SP7021_PWM_MODE0);
+
+	if (mode0 & BIT(pwm->hwpwm)) {
+		clk_rate = clk_get_rate(priv->clk);
+		dd_freq = readl(priv->base + SP7021_PWM_FREQ(pwm->hwpwm));
+		duty = readl(priv->base + SP7021_PWM_DUTY(pwm->hwpwm));
+		duty = FIELD_GET(SP7021_PWM_DUTY_MASK, duty);
+		/*
+		 * dd_freq 16 bits, SP7021_PWM_FREQ_SCALER 8 bits
+		 * NSEC_PER_SEC 30 bits, won't overflow.
+		 */
+		state->period = DIV64_U64_ROUND_UP((u64)dd_freq * (u64)SP7021_PWM_FREQ_SCALER
+						* NSEC_PER_SEC, clk_rate);
+		/*
+		 * dd_freq 16 bits, duty 8 bits, NSEC_PER_SEC 30 bits, won't overflow.
+		 */
+		state->duty_cycle = DIV64_U64_ROUND_UP((u64)dd_freq * (u64)duty * NSEC_PER_SEC,
+						       clk_rate);
+		state->enabled = true;
+	} else {
+		state->enabled = false;
+	}
+
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static const struct pwm_ops sunplus_pwm_ops = {
+	.apply = sunplus_pwm_apply,
+	.get_state = sunplus_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static void sunplus_pwm_clk_release(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
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
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "get pwm clock failed\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, sunplus_pwm_clk_release, priv->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to release clock: %d\n", ret);
+		return ret;
+	}
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &sunplus_pwm_ops;
+	priv->chip.npwm = SP7021_PWM_NUM;
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

