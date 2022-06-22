Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C895546C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiFVKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiFVKCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:02:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A443A5FF;
        Wed, 22 Jun 2022 03:01:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f65so15659585pgc.7;
        Wed, 22 Jun 2022 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2/GoM1jfi/UIwE4ZS/NfUxugSLpF5Je+ue1UXnm4wFk=;
        b=IGZ2ET/aTc2vM1uq1jhcww1JndKobN32QQ/AQrMz4E1cl7j6VZb4JKRlM3nvH0NKke
         TTaE/FcgbWvc23DdJByF2TlwosZnapfEtUe2aNc+WtLwOTKjrxf7uEodo/0Fi612C6KC
         2ecO0i9oDsMaAeQNtr0wsue+alehNQSXjaeZ422OwJyHeBegUx/beI/KoDBcXkBPoS9J
         j8GLGh3YWVJZII6d2HfIeaY4FhnmJZWOR04kho9JvP9Y9FYStBHVMa3p6nZGGP0qdXCP
         d1ZQGehfIYLGKkGBTIsVPOYx6I4AvA7Ndrz3wm3YTn0iPGVPHZTVXeFnJlNrKrXyS7pv
         D2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2/GoM1jfi/UIwE4ZS/NfUxugSLpF5Je+ue1UXnm4wFk=;
        b=Wv/wdrc3vN6Js64kIF9tv/1wpVW7Lzq+3QUa/1blCe4v2WXAWcAPFo4jYh5pqsBLZs
         PvyBXE3nXfcguIrfJ/CNvev8goNS5g1Jm9AWxxFafT0mFHwSvx3NOP/H77LdwYjfWcsY
         zFFT+lp2UGh0AP3lfoIRQl+riqwwAGgBFDUh+7QI0QBzxgcYDt0nDV3b8V20ls2i3TIv
         3jxQ+YL3envNkIkOXTYabb1zbP4Iz7udcN/ZhQZ+JdG1djndGx0EdSlCXVTAYTkhm3EO
         h8eP/ZpUYLFqeMtH9WsXTtmWDvA1g80gTJCIIFmHp6SG1gMEdmBBFedQG6TQ39D2BliN
         jPOA==
X-Gm-Message-State: AJIora9XPZg3dOki2GSuutKhNgBZt1p7uWfmndaj/H7wUv9G1/m7H+dp
        2M5Jzab31AxEdRyNtKLDZKw=
X-Google-Smtp-Source: AGRyM1tNVyyMLkQGjy96t7G71LN6xBJ73TCjf+BW4Xe/47kVoWdV10mJxzl/PHaem4pwbWUf/sqSUw==
X-Received: by 2002:a63:368f:0:b0:40c:50f1:a9a0 with SMTP id d137-20020a63368f000000b0040c50f1a9a0mr2285093pga.312.1655892119273;
        Wed, 22 Jun 2022 03:01:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:d40b:4089:31a8:340d:2f29])
        by smtp.gmail.com with ESMTPSA id w9-20020a639349000000b003fc5fd21752sm12790433pgm.50.2022.06.22.03.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:01:59 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 2/4] mfd: rt5120: Add Richtek PMIC support
Date:   Wed, 22 Jun 2022 18:01:42 +0800
Message-Id: <1655892104-10874-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
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
 drivers/mfd/Kconfig  |  12 +++++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/rt5120.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
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
index 00000000..e7c5f3c
--- /dev/null
+++ b/drivers/mfd/rt5120.c
@@ -0,0 +1,125 @@
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
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &rt5120_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c->dev, "Failed to init regmap (%d)\n", ret);
+		return ret;
+	}
+
+	ret = devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
+				       IRQF_ONESHOT, 0, &rt5120_irq_chip,
+				       &irq_data);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to add irq chip (%d)\n", ret);
+		return ret;
+	}
+
+	return devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, rt5120_devs,
+				    ARRAY_SIZE(rt5120_devs), NULL, 0,
+				    regmap_irq_get_domain(irq_data));
+}
+
+static const struct of_device_id rt5120_device_match_table[] = {
+	{ .compatible = "richtek,rt5120", },
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

