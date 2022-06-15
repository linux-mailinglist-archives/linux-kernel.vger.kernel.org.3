Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814B54C26A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbiFOHJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345826AbiFOHIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:08:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417F286D2;
        Wed, 15 Jun 2022 00:08:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w17so6540713wrg.7;
        Wed, 15 Jun 2022 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1JEyMw9//6WaRTsGHLxDJ16bO40ZkIq+CAqfAPgOBs=;
        b=LcmSyFxRL1x5dkrrPS9mqDn4YSZOSAuYFfX+t/Bvsbzqx0rSGdnPI/UaAOwHHU8hj1
         aN2D0pili4usxNogYd8qWsAJp15z6uHTsDaVt0e5rkZxm65VrKKD7FC9CdrFWMqbet0V
         QxwZZXBH+l3BslD+clW5X0f+OyP6rM+syhFsxS7JWLSAOfElJ8oRSFnzeEzRiFe7V4GN
         r/NonVO7rNapzHRgnuvHZTx6GHLc941p2NDp2l29aFYS7B56zTa2KTBH4h/MgXhzINap
         a9o9b+BiG266NGMSunIVj3Eiek9NR+HJo5vvZ/8GLonuoyNOiLdjVvO8EbAkoiSZWlDg
         nbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1JEyMw9//6WaRTsGHLxDJ16bO40ZkIq+CAqfAPgOBs=;
        b=Goybmv3ZvNgqnaiiMFZURfRXE+58BZsrxe/rUmmeM+NO5/kFPm6ixSquZyiR+onZFS
         P5bbGh1CQxY2lYfjZauCRTu3LpG/V9vlLkszqk9EMh51g4UBzeSeL7hvvwXvDUNfiJ9v
         ji9S/cDhWLFe/bRDaiZTXre1KbDFOcsknrlXnvJ3+QrSZN3f3SQBx+Qwtk3B4UgNdcKJ
         lEJiJEnM0lkteixj0DCWifjmuX13wjUQWrzNUxbo0wVT/S7Ujony47m8bAXR44sBJFP9
         1I4AYUhk+I317qvpNSDyhWKngSffgUL7EexyD0pN6iLVpD3LUyF7AiSsMZxlCbtxSJL3
         YqiA==
X-Gm-Message-State: AJIora/KQ4vf7MnO+9X3UIL1AIc2Q6zblG8yqctci53mtyyMtqwhrAw0
        XFM7qzVr7MmhPblRvdzyVjPB2pe9MZk=
X-Google-Smtp-Source: AGRyM1u95w+pcsKEaV4PwxZT/Ixx+GSWE/3S6tT9Z1mAUZqmGQMCxfU51wCfe7Mq6Lnrqnb64uB1Pg==
X-Received: by 2002:a05:6000:2c8:b0:218:4982:7f90 with SMTP id o8-20020a05600002c800b0021849827f90mr8470230wry.64.1655276912275;
        Wed, 15 Jun 2022 00:08:32 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d4352000000b002102af52a2csm16343132wrr.9.2022.06.15.00.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:08:31 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pwm: Add support for the MSTAR MSC313 PWM
Date:   Wed, 15 Jun 2022 09:08:10 +0200
Message-Id: <20220615070813.7720-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615070813.7720-1-romain.perier@gmail.com>
References: <20220615070813.7720-1-romain.perier@gmail.com>
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
 drivers/pwm/Kconfig       |  10 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-msc313e.c | 242 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 254 insertions(+)
 create mode 100644 drivers/pwm/pwm-msc313e.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2316278d9db9..45d001643b93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2389,6 +2389,7 @@ F:	arch/arm/mach-mstar/
 F:	drivers/clk/mstar/
 F:	drivers/clocksource/timer-msc313e.c
 F:	drivers/gpio/gpio-msc313.c
+F:	drivers/pwm/pwm-msc313e.c
 F:	drivers/rtc/rtc-msc313.c
 F:	drivers/watchdog/msc313e_wdt.c
 F:	include/dt-bindings/clock/mstar-*
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 904de8d61828..802573122b25 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -651,6 +651,16 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_MSC313E
+	tristate "MStar MSC313e PWM support"
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	help
+	  Generic PWM framework driver for MSTAR MSC313e.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-msc313e.
+
+
 config PWM_XILINX
 	tristate "Xilinx AXI Timer PWM support"
 	depends on OF_ADDRESS
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5c08bdb817b4..e24a48c78335 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -61,4 +61,5 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
+obj-$(CONFIG_PWM_MSC313E)	+= pwm-msc313e.o
 obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
diff --git a/drivers/pwm/pwm-msc313e.c b/drivers/pwm/pwm-msc313e.c
new file mode 100644
index 000000000000..f20419c6b9be
--- /dev/null
+++ b/drivers/pwm/pwm-msc313e.c
@@ -0,0 +1,242 @@
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
+	regmap_field_write(low, value);
+	regmap_field_write(high, value >> 16);
+}
+
+static int msc313e_pwm_config(struct pwm_chip *chip, struct pwm_device *device,
+			      int duty_ns, int period_ns)
+{
+	struct msc313e_pwm *pwm = to_msc313e_pwm(chip);
+	struct msc313e_pwm_channel *channel = &pwm->channels[device->hwpwm];
+	unsigned long long nspertick = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, clk_get_rate(pwm->clk));
+	unsigned long long div = 1;
+
+	/* fit the period into the period register by prescaling the clk */
+	while (DIV_ROUND_CLOSEST_ULL(period_ns, (nspertick = DIV_ROUND_CLOSEST_ULL(nspertick, div)))
+	      > 0x3ffff){
+		div++;
+		if (div > (0xffff + 1)) {
+			dev_err(chip->dev, "Can't fit period into period register\n");
+			return -EINVAL;
+		}
+	}
+
+	regmap_field_write(channel->clkdiv, div - 1);
+	msc313e_pwm_writecounter(channel->dutyl, channel->dutyh,
+				 DIV_ROUND_CLOSEST_ULL(duty_ns, nspertick));
+	msc313e_pwm_writecounter(channel->periodl, channel->periodh,
+				 DIV_ROUND_CLOSEST_ULL(period_ns, nspertick));
+
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
+
+	regmap_field_write(channel->swrst, 0);
+
+	return 0;
+}
+
+static void msc313e_pwm_disable(struct pwm_chip *chip, struct pwm_device *device)
+{
+	struct msc313e_pwm *pwm = to_msc313e_pwm(chip);
+	struct msc313e_pwm_channel *channel = &pwm->channels[device->hwpwm];
+
+	regmap_field_write(channel->swrst, 1);
+	clk_disable(pwm->clk);
+}
+
+static int msc313e_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	if (state->enabled) {
+		msc313e_pwm_enable(chip, pwm);
+		msc313e_pwm_set_polarity(chip, pwm, state->polarity);
+		msc313e_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	} else {
+		msc313e_pwm_disable(chip, pwm);
+	}
+	return 0;
+}
+
+static void msc313e_get_state(struct pwm_chip *chip, struct pwm_device *device,
+			      struct pwm_state *state)
+{
+	struct msc313e_pwm *pwm = to_msc313e_pwm(chip);
+	struct msc313e_pwm_channel *channel = &pwm->channels[device->hwpwm];
+	unsigned int pol = 0;
+
+	regmap_field_read(channel->polarity, &pol);
+	state->polarity = pol;
+}
+
+static const struct pwm_ops msc313e_pwm_ops = {
+	.config = msc313e_pwm_config,
+	.set_polarity = msc313e_pwm_set_polarity,
+	.enable = msc313e_pwm_enable,
+	.disable = msc313e_pwm_disable,
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
+	}
+
+	pwm->pwmchip.dev = dev;
+	pwm->pwmchip.ops = &msc313e_pwm_ops;
+	pwm->pwmchip.base = -1;
+	pwm->pwmchip.npwm = match_data->channels;
+	pwm->pwmchip.of_xlate = of_pwm_xlate_with_flags;
+	pwm->pwmchip.of_pwm_n_cells = 3;
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

