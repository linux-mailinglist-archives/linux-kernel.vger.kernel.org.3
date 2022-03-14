Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87584D7A86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiCNFwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiCNFwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:52:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA33FD94;
        Sun, 13 Mar 2022 22:51:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c11so12810538pgu.11;
        Sun, 13 Mar 2022 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bir1Dlo5JNV/W4IehP3WTDRi2pM/LORLl8IPN0b5ZE0=;
        b=TPBSKcuqjBWUTsTyNsAy+QY5dAf7lO+uiZEjkY7ao9Mn6MX51VMvvYsj2Ab02VCacs
         cpAhiedEC2+1lKhT1UT5LIRSZEOmrBHj5Bf2yXL9qqIc+LxgdWFO9NqXdfNRMGd08TVl
         aaQ8UIBODIdCBm6rHCzEogeR0DCTv4WvvFh4BjdUnv+FzVPTK47ZMVc8WGMIH1pz5MIe
         mPBu5itp2/txPRKJbBRczij6Rp6pj6xGwBHzHHlQMF9eZ4mZUF/HDr2Iuwe+1hqIDjk8
         EMNZ+zotbtMQfDCC83AU97SCHzXx9II0SX6FxcRFTj+NLhyfIhYpflclb31bKBQ8d3oo
         0wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bir1Dlo5JNV/W4IehP3WTDRi2pM/LORLl8IPN0b5ZE0=;
        b=yVbHV8BqoVc/kUYdLODVo0P0VQk2muEzL7Anie/LUKXgeqYa/RV44a4nymQ/yJsZfW
         F8tlnQIHP0f55NW5aI3bZ8f7PuJbINwKGId4IDJFLm1tiSzlcMP7dEXYC8lD9ouZiJFf
         ovcWN8POIqa/MnJdMN3fnov1q7723CJqdO0NMpj3667pxu+h3y4Rxk5UhCTMWOKCYOGb
         JjjI4j+8FmMMX39kPizFgXzp5xSjHWIuAyHJFQIfXf4vACpTtFwAlXLta92f2XoJbwFx
         vC5T+v7xiMqbv3SuuRiPHNJB5KGVm5CrZWsK4VnQa2dngCYBKe1TqQP2/xWwywYHF6bc
         Ao0A==
X-Gm-Message-State: AOAM533cvNkUIjKas9p8LROa/wka6Y3yAkQqFU6KuToI7gkrqHO73vRi
        mJzksYvH7+bIUMce5u35LKg=
X-Google-Smtp-Source: ABdhPJypSIbGY6StBeFPG8SnnllxCXTmdh59AfSQsUbSh3AMOmshXrhjs8WhMaa+C7c5+Jpz8N12kg==
X-Received: by 2002:a05:6a00:2352:b0:4f7:752d:dd09 with SMTP id j18-20020a056a00235200b004f7752ddd09mr20231086pfj.22.1647237084512;
        Sun, 13 Mar 2022 22:51:24 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h17-20020a63df51000000b0036b9776ae5bsm15238115pgj.85.2022.03.13.22.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2022 22:51:24 -0700 (PDT)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v3 2/2] pwm: sunplus-pwm: Add Sunplus SoC SP7021 PWM Driver
Date:   Mon, 14 Mar 2022 13:51:37 +0800
Message-Id: <1647237097-29172-3-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com>
References: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com>
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

Add Sunplus SoC SP7021 PWM Driver

Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v3:
 - Addressed all comments from Uwe Kleine-König.

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
index 0000000..b6ab077
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
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define SP7021_PWM_CONTROL0		0x000
+#define SP7021_PWM_CONTROL1		0x004
+#define SP7021_PWM_FREQ(ch)		(0x008 + 4 * (ch))
+#define SP7021_PWM_DUTY(ch)		(0x018 + 4 * (ch))
+#define SP7021_PWM_FREQ_MAX		GENMASK(15, 0)
+#define SP7021_PWM_DUTY_MAX		GENMASK(7, 0)
+#define SP7021_PWM_CONTROL_EN(ch)	BIT(ch)
+
+#define SP7021_PWM_NUM			4
+#define SP7021_PWM_BYPASS_BIT_SHIFT	8
+#define SP7021_PWM_DD_SEL_BIT_SHIFT	8
+#define SP7021_PWM_FREQ_SCALER		256
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
+	u32 dd_freq, duty, control0, control1;
+	u64 max_period, period_ns, duty_ns, clk_rate;
+
+	if (state->polarity != pwm->state.polarity)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		/* disable pwm channel output */
+		control0 = readl(priv->base + SP7021_PWM_CONTROL0);
+		control0 &= ~SP7021_PWM_CONTROL_EN(pwm->hwpwm);
+		writel(control0, priv->base + SP7021_PWM_CONTROL0);
+		/* disable pwm channel clk source */
+		control1 = readl(priv->base + SP7021_PWM_CONTROL1);
+		control1 &= ~SP7021_PWM_CONTROL_EN(pwm->hwpwm);
+		writel(control1, priv->base + SP7021_PWM_CONTROL1);
+		return 0;
+	}
+
+	clk_rate = clk_get_rate(priv->clk);
+	/*
+	 * SP7021_PWM_FREQ_MAX 16 bits, SP7021_PWM_FREQ_SCALER 8 bits
+	 * NSEC_PER_SEC 30 bits, won't overflow.
+	 */
+	max_period = mul_u64_u64_div_u64(SP7021_PWM_FREQ_MAX, (u64)SP7021_PWM_FREQ_SCALER
+				* NSEC_PER_SEC, clk_rate);
+
+	period_ns = min(state->period, max_period);
+	duty_ns = state->duty_cycle;
+
+	/*
+	 * cal pwm freq and check value under range
+	 * clk_rate 202.5MHz 28 bits, period_ns max 82849185 27 bits, won't overflow.
+	 */
+	dd_freq = mul_u64_u64_div_u64(clk_rate, period_ns, (u64)SP7021_PWM_FREQ_SCALER
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
+	control0 = readl(priv->base + SP7021_PWM_CONTROL0);
+	control0 |= SP7021_PWM_CONTROL_EN(pwm->hwpwm);
+	control1 = readl(priv->base + SP7021_PWM_CONTROL1);
+	control1 |= SP7021_PWM_CONTROL_EN(pwm->hwpwm);
+	if (duty_ns == period_ns) {
+		/* PWM channel output = high */
+		control0 |= SP7021_PWM_CONTROL_EN(pwm->hwpwm + SP7021_PWM_BYPASS_BIT_SHIFT);
+		duty = SP7021_PWM_DUTY_MAX;
+	} else {
+		control0 &= ~SP7021_PWM_CONTROL_EN(pwm->hwpwm + SP7021_PWM_BYPASS_BIT_SHIFT);
+		/*
+		 * duty_ns <= period_ns 27 bits, SP7021_PWM_FREQ_SCALER 8 bits
+		 * won't overflow.
+		 */
+		duty = mul_u64_u64_div_u64(duty_ns, (u64)SP7021_PWM_FREQ_SCALER,
+					   period_ns);
+		duty |= (pwm->hwpwm << SP7021_PWM_DD_SEL_BIT_SHIFT);
+	}
+	writel(duty, priv->base + SP7021_PWM_DUTY(pwm->hwpwm));
+	writel(control1, priv->base + SP7021_PWM_CONTROL1);
+	writel(control0, priv->base + SP7021_PWM_CONTROL0);
+
+	return 0;
+}
+
+static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct sunplus_pwm *priv = to_sunplus_pwm(chip);
+	u32 control0, freq, duty;
+	u64 clk_rate;
+
+	control0 = readl(priv->base + SP7021_PWM_CONTROL0);
+
+	if (control0 & BIT(pwm->hwpwm)) {
+		clk_rate = clk_get_rate(priv->clk);
+		freq = readl(priv->base + SP7021_PWM_FREQ(pwm->hwpwm));
+		duty = readl(priv->base + SP7021_PWM_DUTY(pwm->hwpwm));
+		duty &= ~GENMASK(9, 8);
+		/*
+		 * freq 16 bits, SP7021_PWM_FREQ_SCALER 8 bits
+		 * NSEC_PER_SEC 30 bits, won't overflow.
+		 */
+		state->period = DIV64_U64_ROUND_UP((u64)freq * (u64)SP7021_PWM_FREQ_SCALER
+						* NSEC_PER_SEC, clk_rate);
+		/*
+		 * freq 16 bits, duty 8 bits, NSEC_PER_SEC 30 bits, won't overflow.
+		 */
+		state->duty_cycle = DIV64_U64_ROUND_UP((u64)freq * (u64)duty * NSEC_PER_SEC,
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

