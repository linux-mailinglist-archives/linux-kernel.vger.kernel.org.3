Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5120B5B04E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiIGNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIGNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:12:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AEF7F247;
        Wed,  7 Sep 2022 06:12:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so9474395wmb.4;
        Wed, 07 Sep 2022 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QgQzrH/5u6O4v9L6yKc0YnpRc+Pdf5VnE9vcckt75yk=;
        b=W4kDYvSWcWVYU846PJOgv2OoteQcSTm4QUKlIaSCMjq5dcqWzh7hWWPtrHuK1zcUNr
         caTvBBbLAL4FpbU3QHD+OcVi9GWzwq/Dy7TEaBSSu0UlXSAiDLg990u0/cwV+p/bln3r
         tBuHcqzdY48mmbunNRgOkC6q8cM21otf5/TALhvJFr2ZJ1XLBAWUwJsgqCZQJOsOf8J2
         mZRVtJZ3670h5XYaM7iVCNGHX24tbP0W3I9YQ6Aly68KJI+CNPzBhKd70KdiPwDd46a8
         A6+HcFQtf0aNHFXhRxJh37W52Np85p728nevElpNPCQOkgLkSFL4aRpYqPbz+8c/I9Zv
         u68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QgQzrH/5u6O4v9L6yKc0YnpRc+Pdf5VnE9vcckt75yk=;
        b=M1XaJcJSyu1hQgiGDPrPArJDaREkETqF6nHVv9T4b2/1ZsBVvgNxxbY6/BwqfHHGKi
         TgcgSICRNFe4ooWKTxrfGsJLVxR+5yfo9FvhLx45nBqz25BNYc1JCPL0j3/fGjUslmjk
         iBM167pC2d523CGQSfme7G7aMXt22foSUa2wmHuMzX59Ltucmby64L2L6582XKA4+IF/
         BwwC7TxrOOrR3QpUaukDtdliGi1CkzNvR+qYJFToJAbpeoZRRXdWrpMbT83UNqVrV8H7
         suUMU5Hi+ZvXRx9NIeaNT452nGpu1bA+BEltMOonSgoPmcS2bVRGifvlbJstgjdRB9GN
         vufQ==
X-Gm-Message-State: ACgBeo3ADphEg+0O5xLxGsNnqNaFO+f0ts1irCRfap2ba841uOToKb5t
        YB6F3kMDfH5R7oXfCzOlh6ha354fd74=
X-Google-Smtp-Source: AA6agR451FJk9pwztH7RtTiFRro2EoTxpghDJ12xgov2F7TD2BIRO6eN2TJisuk6uvmCSczE+3dZvw==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr1998543wmq.188.1662556368121;
        Wed, 07 Sep 2022 06:12:48 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id w14-20020adfd4ce000000b00228de351fc0sm5150512wrk.38.2022.09.07.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:12:47 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] pwm: Add support for the MSTAR MSC313 PWM
Date:   Wed,  7 Sep 2022 15:12:38 +0200
Message-Id: <20220907131241.31941-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907131241.31941-1-romain.perier@gmail.com>
References: <20220907131241.31941-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

This adds support for the PWM block on the Mstar MSC313e SoCs and newer.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Co-developed-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 MAINTAINERS               |   1 +
 drivers/pwm/Kconfig       |   9 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-msc313e.c | 269 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 drivers/pwm/pwm-msc313e.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..c3b39b09097c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2439,6 +2439,7 @@ F:	arch/arm/mach-mstar/
 F:	drivers/clk/mstar/
 F:	drivers/clocksource/timer-msc313e.c
 F:	drivers/gpio/gpio-msc313.c
+F:	drivers/pwm/pwm-msc313e.c
 F:	drivers/rtc/rtc-msc313.c
 F:	drivers/watchdog/msc313e_wdt.c
 F:	include/dt-bindings/clock/mstar-*
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..8049fd03a821 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -372,6 +372,15 @@ config PWM_MESON
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-meson.
 
+config PWM_MSC313E
+	tristate "MStar MSC313e PWM support"
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	help
+	  Generic PWM framework driver for MSTAR MSC313e.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-msc313e.
+
 config PWM_MTK_DISP
 	tristate "MediaTek display PWM driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..bc285c054f2a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -62,4 +62,5 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
+obj-$(CONFIG_PWM_MSC313E)	+= pwm-msc313e.o
 obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
diff --git a/drivers/pwm/pwm-msc313e.c b/drivers/pwm/pwm-msc313e.c
new file mode 100644
index 000000000000..a71f39ba66c3
--- /dev/null
+++ b/drivers/pwm/pwm-msc313e.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Daniel Palmer <daniel@thingy.jp>
+ * Copyright (C) 2022 Romain Perier <romain.perier@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define DRIVER_NAME "msc313e-pwm"
+
+#define CHANNEL_OFFSET	0x80
+#define REG_DUTY	0x8
+#define REG_PERIOD	0x10
+#define REG_DIV		0x18
+#define REG_CTRL	0x1c
+#define REG_SWRST	0x1fc
+
+struct msc313e_pwm_channel {
+	struct regmap_field *clkdiv;
+	struct regmap_field *polarity;
+	struct regmap_field *dutyl;
+	struct regmap_field *dutyh;
+	struct regmap_field *periodl;
+	struct regmap_field *periodh;
+	struct regmap_field *swrst;
+};
+
+struct msc313e_pwm {
+	struct regmap *regmap;
+	struct pwm_chip pwmchip;
+	struct clk *clk;
+	struct msc313e_pwm_channel channels[];
+};
+
+struct msc313e_pwm_info {
+	unsigned int channels;
+};
+
+#define to_msc313e_pwm(ptr) container_of(ptr, struct msc313e_pwm, pwmchip)
+
+static const struct regmap_config msc313e_pwm_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_stride = 4,
+};
+
+static const struct msc313e_pwm_info msc313e_data = {
+	.channels = 8,
+};
+
+static const struct msc313e_pwm_info ssd20xd_data = {
+	.channels = 4,
+};
+
+static void msc313e_pwm_writecounter(struct regmap_field *low, struct regmap_field *high, u32 value)
+{
+	/* The bus that connects the CPU to the peripheral registers splits 32 bit registers into
+	 * two 16bit registers placed 4 bytes apart. It's the hardware design they used. The counter
+	 * we are about to write has this contrainst.
+	 */
+	regmap_field_write(low, value & 0xffff);
+	regmap_field_write(high, value >> 16);
+}
+
+static void msc313e_pwm_readcounter(struct regmap_field *low, struct regmap_field *high, u32 *value)
+{
+	unsigned int val = 0;
+
+	regmap_field_read(low, &val);
+	*value = val;
+	regmap_field_read(high, &val);
+	*value = (val << 16) | *value;
+}
+
+static int msc313e_pwm_config(struct pwm_chip *chip, struct pwm_device *device,
+			      int duty_ns, int period_ns)
+{
+	struct msc313e_pwm *pwm = to_msc313e_pwm(chip);
+	unsigned long long nspertick = DIV_ROUND_DOWN_ULL(NSEC_PER_SEC, clk_get_rate(pwm->clk));
+	struct msc313e_pwm_channel *channel = &pwm->channels[device->hwpwm];
+	unsigned long long div = 1;
+
+	/* Fit the period into the period register by prescaling the clk */
+	while (DIV_ROUND_DOWN_ULL(period_ns, nspertick) > 0x3ffff) {
+		div++;
+		if (div > (0xffff + 1)) {
+			/* Force clk div to the maximum allowed value */
+			div = 0xffff;
+			break;
+		}
+		nspertick = DIV_ROUND_DOWN_ULL(nspertick, div);
+	}
+
+	regmap_field_write(channel->clkdiv, div - 1);
+	msc313e_pwm_writecounter(channel->dutyl, channel->dutyh,
+				 DIV_ROUND_DOWN_ULL(duty_ns, nspertick));
+	msc313e_pwm_writecounter(channel->periodl, channel->periodh,
+				 DIV_ROUND_DOWN_ULL(period_ns, nspertick));
+	return 0;
+};
+
+static int msc313e_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *device,
+				    enum pwm_polarity polarity)
+{
+	struct msc313e_pwm *pwm = to_msc313e_pwm(chip);
+	struct msc313e_pwm_channel *channel = &pwm->channels[device->hwpwm];
+	unsigned int pol = 0;
+
+	if (polarity == PWM_POLARITY_INVERSED)
+		pol = 1;
+	regmap_field_update_bits(channel->polarity, 1, pol);
+
+	return 0;
+}
+
+static int msc313e_pwm_enable(struct pwm_chip *chip, struct pwm_device *device)
+{
+	struct msc313e_pwm *pwm = to_msc313e_pwm(chip);
+	struct msc313e_pwm_channel *channel = &pwm->channels[device->hwpwm];
+	int ret;
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret)
+		return ret;
+	return regmap_field_write(channel->swrst, 0);
+}
+
+static int msc313e_pwm_disable(struct pwm_chip *chip, struct pwm_device *device)
+{
+	struct msc313e_pwm *pwm = to_msc313e_pwm(chip);
+	struct msc313e_pwm_channel *channel = &pwm->channels[device->hwpwm];
+	int ret;
+
+	ret = regmap_field_write(channel->swrst, 1);
+	clk_disable_unprepare(pwm->clk);
+	return ret;
+}
+
+static int msc313e_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	int ret;
+
+	if (state->enabled) {
+		if (!pwm->state.enabled) {
+			ret = msc313e_pwm_enable(chip, pwm);
+			if (ret)
+				return ret;
+		}
+		msc313e_pwm_set_polarity(chip, pwm, state->polarity);
+		msc313e_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	} else if (pwm->state.enabled) {
+		ret = msc313e_pwm_disable(chip, pwm);
+	}
+	return 0;
+}
+
+static void msc313e_get_state(struct pwm_chip *chip, struct pwm_device *device,
+			      struct pwm_state *state)
+{
+	struct msc313e_pwm *pwm = to_msc313e_pwm(chip);
+	struct msc313e_pwm_channel *channel = &pwm->channels[device->hwpwm];
+	unsigned long long nspertick = DIV_ROUND_DOWN_ULL(NSEC_PER_SEC, clk_get_rate(pwm->clk));
+	unsigned int val = 0;
+
+	regmap_field_read(channel->polarity, &val);
+	state->polarity = val ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	regmap_field_read(channel->swrst, &val);
+	state->enabled = val == 0 ? true : false;
+
+	msc313e_pwm_readcounter(channel->dutyl, channel->dutyh, &val);
+	state->duty_cycle = val * nspertick;
+
+	msc313e_pwm_readcounter(channel->periodl, channel->periodh, &val);
+	state->period = val * nspertick;
+}
+
+static const struct pwm_ops msc313e_pwm_ops = {
+	.apply = msc313e_apply,
+	.get_state = msc313e_get_state,
+	.owner = THIS_MODULE
+};
+
+static int msc313e_pwm_probe(struct platform_device *pdev)
+{
+	const struct msc313e_pwm_info *match_data;
+	struct device *dev = &pdev->dev;
+	struct msc313e_pwm *pwm;
+	__iomem void *base;
+	int i;
+
+	match_data = of_device_get_match_data(dev);
+	if (!match_data)
+		return -EINVAL;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pwm = devm_kzalloc(dev, struct_size(pwm, channels, match_data->channels), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(dev, PTR_ERR(pwm->clk), "Cannot get clk\n");
+
+	pwm->regmap = devm_regmap_init_mmio(dev, base, &msc313e_pwm_regmap_config);
+	if (IS_ERR(pwm->regmap))
+		return dev_err_probe(dev, PTR_ERR(pwm->regmap), "Cannot get regmap\n");
+
+	for (i = 0; i < match_data->channels; i++) {
+		unsigned int offset = CHANNEL_OFFSET * i;
+		struct reg_field div_clkdiv_field = REG_FIELD(offset + REG_DIV, 0, 7);
+		struct reg_field ctrl_polarity_field = REG_FIELD(offset + REG_CTRL, 4, 4);
+		struct reg_field dutyl_field = REG_FIELD(offset + REG_DUTY, 0, 15);
+		struct reg_field dutyh_field = REG_FIELD(offset + REG_DUTY + 4, 0, 2);
+		struct reg_field periodl_field = REG_FIELD(offset + REG_PERIOD, 0, 15);
+		struct reg_field periodh_field = REG_FIELD(offset + REG_PERIOD + 4, 0, 2);
+		struct reg_field swrst_field = REG_FIELD(REG_SWRST, i, i);
+
+		pwm->channels[i].clkdiv = devm_regmap_field_alloc(dev, pwm->regmap,
+								  div_clkdiv_field);
+		pwm->channels[i].polarity = devm_regmap_field_alloc(dev, pwm->regmap,
+								    ctrl_polarity_field);
+		pwm->channels[i].dutyl = devm_regmap_field_alloc(dev, pwm->regmap, dutyl_field);
+		pwm->channels[i].dutyh = devm_regmap_field_alloc(dev, pwm->regmap, dutyh_field);
+		pwm->channels[i].periodl = devm_regmap_field_alloc(dev, pwm->regmap, periodl_field);
+		pwm->channels[i].periodh = devm_regmap_field_alloc(dev, pwm->regmap, periodh_field);
+		pwm->channels[i].swrst = devm_regmap_field_alloc(dev, pwm->regmap, swrst_field);
+
+		/* Channels are enabled on boot, disable it until the pwm subsystem re-enable it
+		 * explicitly
+		 */
+		regmap_field_write(pwm->channels[i].swrst, 1);
+	}
+
+	pwm->pwmchip.dev = dev;
+	pwm->pwmchip.ops = &msc313e_pwm_ops;
+	pwm->pwmchip.npwm = match_data->channels;
+
+	platform_set_drvdata(pdev, pwm);
+
+	return devm_pwmchip_add(dev, &pwm->pwmchip);
+}
+
+static const struct of_device_id msc313e_pwm_dt_ids[] = {
+	{ .compatible = "mstar,msc313e-pwm", .data = &msc313e_data },
+	{ .compatible = "mstar,ssd20xd-pwm", .data = &ssd20xd_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, msc313e_pwm_dt_ids);
+
+static struct platform_driver msc313e_pwm_driver = {
+	.probe = msc313e_pwm_probe,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = msc313e_pwm_dt_ids,
+	},
+};
+module_platform_driver(msc313e_pwm_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mstar MSC313e PWM driver");
+MODULE_AUTHOR("Daniel Palmer <daniel@thingy.jp>");
-- 
2.35.1

