Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416BF574536
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiGNGmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiGNGmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:42:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA01F2F8;
        Wed, 13 Jul 2022 23:42:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j3so1023910pfb.6;
        Wed, 13 Jul 2022 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V08YmIparQ/n84vySMXu3G2yt20mKIem0IYynq0lIhc=;
        b=ENvKkVGWqWVdMTbGzGm2itH79EzeePHb3i9QINFIp8y8yVb57k7fSNw8auLQ2FC1II
         P5q0h4pZu/+m5QarAGiQQhhYAg9jIeHTniT7GnBICJkHgVXMaK8FcAZf+43xFItUZ/Yf
         Kpbz1ksCNWLAWSdmQ7oxKE4PQdRhAxm9q6/T1olC6aQ7PDKylYDZCIJF0jmhhQ8uvHrG
         MeKH9HlFk8v9GSRsPOA5YVaEwCpHnLPxFXf7ghDf1hziFBaRXtxbc48lBnPAyZZzpeLj
         0twaAFRNW6W30Vn6y0WtJdTCtadjJNB/OohiP/9PuOc5S8E6V6EJCK8citgdYxIbxDA7
         kz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V08YmIparQ/n84vySMXu3G2yt20mKIem0IYynq0lIhc=;
        b=BY+njANgcU9vNVZWGYihgJAZDl/kvgXJI6lUCnPR/oZX3cKVzkSSXV8POKMmcEEcM6
         TvScR1SLAduKD1bdhTqa3bvH9P3HgvCjDJ8g1JJJV7sxTL0b+jhQY3nHW3X08BbNGveq
         3yeyRxkGysA2MQGI6F2ELduOKwtp2/4S6s9Sq0Qb4Ramqdw7hzREcunJSzAHOo88Vz67
         jOd2aIN4MHgtDf2RMA8UAsIU6U6INIztu3SScgW9k6u+jO0igDjjR6djohHhr3ZV6K1o
         vO/FVPrsp2O50ElQt9XV0bXK+Cxy6DtDwMEQMuWCbMvN/ApJl/NAZFN8Cfm6cVoMvRAQ
         9wug==
X-Gm-Message-State: AJIora9VzEb1lzzJYiSZutX7amNpMeCtMVrNpWHhWNWmX2tiBZM/sGNf
        K46afztKrqYDDaeONKUDflc=
X-Google-Smtp-Source: AGRyM1tF+/4UqXDvpyKcqOBdc1Qreqpwz8R/g900i5zqHHDOJ2lhXzugzVaASNUexJUlF5mlv3rFHw==
X-Received: by 2002:a63:ee14:0:b0:414:1a88:3b96 with SMTP id e20-20020a63ee14000000b004141a883b96mr6183424pgi.364.1657780965091;
        Wed, 13 Jul 2022 23:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:199:217d:a3c8:f1ea:4115])
        by smtp.gmail.com with ESMTPSA id nt14-20020a17090b248e00b001ef82e5f5aesm616291pjb.47.2022.07.13.23.42.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 23:42:44 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v3 2/3] mfd: rt5120: Add Richtek PMIC support
Date:   Thu, 14 Jul 2022 14:42:16 +0800
Message-Id: <1657780937-20891-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
References: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
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
Since v3:
- Use a 'dev' variable and dev_err_probe to decrease the LOC in mfd.

---
 drivers/mfd/Kconfig  |  12 +++++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/rt5120.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/mfd/rt5120.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456..866619c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1127,6 +1127,18 @@ config MFD_RT5033
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
index 00000000..12372fa
--- /dev/null
+++ b/drivers/mfd/rt5120.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+
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
+	regmap_reg_range(0x44, 0x44)
+};
+
+static const struct regmap_range rt5120_wr_yes_ranges[] = {
+	regmap_reg_range(0x06, 0x13),
+	regmap_reg_range(0x1c, 0x20),
+	regmap_reg_range(0x44, 0x44)
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
+	REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_PRESS, 8)
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
+	DEFINE_RES_IRQ(RT5120_INT_HOTDIE)
+};
+
+static const struct resource rt5120_pwrkey_resources[] = {
+	DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_PRESS, "pwrkey-press"),
+	DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_REL, "pwrkey-release")
+};
+
+static const struct mfd_cell rt5120_devs[] = {
+	MFD_CELL_RES("rt5120-regulator", rt5120_regulator_resources),
+	MFD_CELL_OF("rt5120-pwrkey", rt5120_pwrkey_resources, NULL, 0, 0,
+		    "richtek,rt5120-pwrkey")
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
+		return dev_err_probe(dev, ret, "Failed to add irq chip\n");
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

