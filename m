Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9D58E4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiHJC4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiHJCz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:55:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B46FA22;
        Tue,  9 Aug 2022 19:55:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso787465pjd.3;
        Tue, 09 Aug 2022 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=i4QcEvTUJvP0g/7PaAMpMWTIqDgUsdWeK1PIkklhA/I=;
        b=m6Tj5U2yYUxeIAZRv8lmgIGr6NNdu6Mf080sXV6xL4Qa7iNz0mNlLgN/PWdbyIrX6O
         MzVkRRpyIUzxtc5Tb7p4QQXO/9m2ID/uG+43KkV+SJUcBTpI8S9wrh44GIEqZ8xNhDHc
         kUwK5BrzBTyb9mUqUHpBcLImtBAz+k6oamxWsURqLHvO5MYeLUbKQ9JCdt5NOhK1gq0j
         a7adHMgY0cfDhwoMITOh0Ktm7jbeRlxXyiTYBh7l/SF0y+hY015HpxEOY3vqKbSQpwTh
         fohegxIT0TSqG4hHTW0MUYzHIIvjZEEKlnvZsnbEapuOOYoKpMXLHp6DXsUTe4CzjK5M
         PV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=i4QcEvTUJvP0g/7PaAMpMWTIqDgUsdWeK1PIkklhA/I=;
        b=OU7R2K0fWuIZdAyCS1ocgCPAIkl35G5cmTm2R1TLo788+RQUAvSEZ4eQaOnPl1XQ7Q
         XxQ89jw7n20uZLyC6OLm5YfB2hNCwgXQ+SyaajHuTISBK7oFsdIOl4i5zvLciaR9mU6m
         QTzsUuSt2i6mk2o9cKKc2Kcy9OUkU51/hi/vym1phWAI1A3/r1k9EyebGIoTQAwNfQNF
         Nr3XeTWb/BrR+QQtq/gqz5RsDmZ0Q8NH+Xk0h5i5KY7lH16M9RZIZ3ibxZAdxx4Aq7Fk
         5TiGatajq9kjnISS/j+5V+s7g+mWyBCCwsRgdKcADM7Kxv3FENV6NfmBtGB1lzzYfUbQ
         /pMw==
X-Gm-Message-State: ACgBeo2MpK/52jpeCXABqFYZiMV+UtWwtofiQBLL2bBC57hQU1ib/NS7
        vzYYQowszBFa22E4y+c1PJc=
X-Google-Smtp-Source: AA6agR5BQsdmxV+r6TsHuW78pLZ7lHG/W9hzF0Xr2E7+FLTb9Ao4wv5JMrSyG/cKDKnh+MrQ2MfEVQ==
X-Received: by 2002:a17:90b:4c8c:b0:1f5:2214:a02f with SMTP id my12-20020a17090b4c8c00b001f52214a02fmr1509389pjb.66.1660100155732;
        Tue, 09 Aug 2022 19:55:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:d15f:416a:c0:aecd:5d6e])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c94500b0016d1f474653sm11785654pla.52.2022.08.09.19.55.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 19:55:55 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, dmitry.torokhov@gmail.com
Cc:     cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v4 2/3] mfd: rt5120: Add Richtek PMIC support
Date:   Wed, 10 Aug 2022 10:55:41 +0800
Message-Id: <1660100142-32493-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add Richtek RT5120 PMIC I2C driver.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v4:
- Add "Copyright" string and refine for GPL version string.
- For the last uncertain terminated element in struct arrays, put the comma
  for it to keep the extensibility.

Since v3:
- Use a 'dev' variable and dev_err_probe to decrease the LOC in mfd.

---
 drivers/mfd/Kconfig  |  12 +++++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/rt5120.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/mfd/rt5120.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab..bfceece 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1128,6 +1128,18 @@ config MFD_RT5033
 	  sub-devices like charger, fuel gauge, flash LED, current source,
 	  LDO and Buck.
 
+config MFD_RT5120
+	tristate "Richtek RT5120 Power Management IC"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  The enables support for Richtek RT5120 PMIC. It includes four high
+	  efficiency buck converters and one LDO voltage regulator. The device
+	  is targeted at providing the CPU voltage, memory, I/O and peripheral
+	  power rails in home entertainment devices.
+
 config MFD_RC5T583
 	bool "Ricoh RC5T583 Power Management system device"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf..27e8add 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -234,6 +234,7 @@ obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT4831)	+= rt4831.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
+obj-$(CONFIG_MFD_RT5120)	+= rt5120.o
 obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
 
 intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
diff --git a/drivers/mfd/rt5120.c b/drivers/mfd/rt5120.c
new file mode 100644
index 00000000..8046e38
--- /dev/null
+++ b/drivers/mfd/rt5120.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+#define RT5120_REG_INTENABLE	0x1D
+#define RT5120_REG_INTSTAT	0x1E
+#define RT5120_REG_FZCMODE	0x44
+
+#define RT5120_INT_HOTDIE	0
+#define RT5120_INT_PWRKEY_REL	5
+#define RT5120_INT_PWRKEY_PRESS	6
+
+static const struct regmap_range rt5120_rd_yes_ranges[] = {
+	regmap_reg_range(0x03, 0x13),
+	regmap_reg_range(0x1c, 0x20),
+	regmap_reg_range(0x44, 0x44),
+};
+
+static const struct regmap_range rt5120_wr_yes_ranges[] = {
+	regmap_reg_range(0x06, 0x13),
+	regmap_reg_range(0x1c, 0x20),
+	regmap_reg_range(0x44, 0x44),
+};
+
+static const struct regmap_access_table rt5120_rd_table = {
+	.yes_ranges = rt5120_rd_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(rt5120_rd_yes_ranges),
+};
+
+static const struct regmap_access_table rt5120_wr_table = {
+	.yes_ranges = rt5120_wr_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(rt5120_wr_yes_ranges),
+};
+
+static const struct regmap_config rt5120_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT5120_REG_FZCMODE,
+
+	.wr_table = &rt5120_wr_table,
+	.rd_table = &rt5120_rd_table,
+};
+
+static const struct regmap_irq rt5120_irqs[] = {
+	REGMAP_IRQ_REG_LINE(RT5120_INT_HOTDIE, 8),
+	REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_REL, 8),
+	REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_PRESS, 8),
+};
+
+static const struct regmap_irq_chip rt5120_irq_chip = {
+	.name = "rt5120-pmic",
+	.status_base = RT5120_REG_INTSTAT,
+	.mask_base = RT5120_REG_INTENABLE,
+	.ack_base = RT5120_REG_INTSTAT,
+	.mask_invert = true,
+	.use_ack = true,
+	.num_regs = 1,
+	.irqs = rt5120_irqs,
+	.num_irqs = ARRAY_SIZE(rt5120_irqs),
+};
+
+static const struct resource rt5120_regulator_resources[] = {
+	DEFINE_RES_IRQ(RT5120_INT_HOTDIE),
+};
+
+static const struct resource rt5120_pwrkey_resources[] = {
+	DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_PRESS, "pwrkey-press"),
+	DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_REL, "pwrkey-release"),
+};
+
+static const struct mfd_cell rt5120_devs[] = {
+	MFD_CELL_RES("rt5120-regulator", rt5120_regulator_resources),
+	MFD_CELL_OF("rt5120-pwrkey", rt5120_pwrkey_resources, NULL, 0, 0, "richtek,rt5120-pwrkey"),
+};
+
+static int rt5120_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &rt5120_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to init regmap\n");
+
+	ret = devm_regmap_add_irq_chip(dev, regmap, i2c->irq, IRQF_ONESHOT, 0,
+				       &rt5120_irq_chip, &irq_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add IRQ chip\n");
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, rt5120_devs,
+				    ARRAY_SIZE(rt5120_devs), NULL, 0,
+				    regmap_irq_get_domain(irq_data));
+}
+
+static const struct of_device_id rt5120_device_match_table[] = {
+	{ .compatible = "richtek,rt5120" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt5120_device_match_table);
+
+static struct i2c_driver rt5120_driver = {
+	.driver = {
+		.name = "rt5120",
+		.of_match_table = rt5120_device_match_table,
+	},
+	.probe_new = rt5120_probe,
+};
+module_i2c_driver(rt5120_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RT5120 I2C driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

