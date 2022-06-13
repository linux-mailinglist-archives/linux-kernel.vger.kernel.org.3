Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB15482C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiFMJGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiFMJGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:06:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44073E0AE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:06:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k19so6241488wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZ4achm3u4fCd/7uM3C5uYugDxH72pvgJTJJjUoQeRI=;
        b=PKM+CPjh3XKGI4HSiNfUjG9G1V7hEZokSpyGqa3JtxvKna3JAgXwyDFg6xdJ7UsuQm
         B0mqQTDii/QQtG/FMYQLjyvLO1AJ+PbWyVD0oF8p3NWTM4/RSCKA/v5XceSDIirR9E3A
         yPr6isZpWDyc4caJdMM0xkulbJxhWNOtSDkf0/9g4wfvyqZQuh4meXjlBhypWhnaNnJm
         E1GjFLvQROqNXJxOoBgEGn7IqMB/ymSxbRie+uf1zU5DFPxmpKJ0VvzJiHZrDUibr0yb
         Ae6qSNhiUbtVxQy4zVa0dJebn9bZtIydgJAc68MLM5Gb+bJhYeZSTh9s9WyRAvFK+/TX
         V6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yZ4achm3u4fCd/7uM3C5uYugDxH72pvgJTJJjUoQeRI=;
        b=T2Og7cBvl/hZv8uqPdtFMK3iki5yH3sHCKgQByhyLvqtPL0iUZmLLiEEzAV2mmGhcc
         0nUDDEh4zCozE+6ylIna81iuPAJnpjNplQ350+/ef8s3TkrX028/QnyVD7jmymV2O9H0
         ishc06Re4hv5BljE+vnAKz5Gtlt5gmLVNSvNeeIL0jwLBj4e1y60YyUQzaHrZfbz5Jm7
         o0NLjr0N1QAOwwJHeNbbDZme4D7gnDLvPrbROTik5zb4I9R98p5Kf6RVtx4C3h1ZSVZ9
         AJr7n6eRRE8hlrF+gD5xFI27XBfwkJBe1Q0zsaxHpy6QJOtQU49jCSpGVzZWMv35x9wU
         GQmw==
X-Gm-Message-State: AOAM531hAGhVwlqWa5/drRoQVWfFV8xVhOHcjMlCarSh9SW3ZF3Nc9Fr
        rQOOGpkTxKLjwhUfS3w5xd9mVg==
X-Google-Smtp-Source: ABdhPJwB2ZQipbMRaIVoXP6filejAzhSCA7YQAqFzUYJYbKmWuSOwc8o5vEMKQZCtTtROgZQaEJ41A==
X-Received: by 2002:a5d:6d08:0:b0:217:1292:ddb8 with SMTP id e8-20020a5d6d08000000b002171292ddb8mr42380098wrq.693.1655111171725;
        Mon, 13 Jun 2022 02:06:11 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id d9-20020adffd89000000b002102d4ed579sm7806465wrr.39.2022.06.13.02.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:06:11 -0700 (PDT)
From:   Jerome NEANNE <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, will@kernel.org,
        lee.jones@linaro.org, jneanne@baylibre.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 2/5] mfd: drivers: Add TI TPS65219 PMIC support
Date:   Mon, 13 Jun 2022 11:06:01 +0200
Message-Id: <20220613090604.9975-3-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613090604.9975-1-jneanne@baylibre.com>
References: <20220613090604.9975-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPS65219 is a power management IC PMIC designed
to supply a wide range of SoCs
in both portable and stationary applications.
Any SoC can control TPS65219 over a standard I2C interface.

It contains the following components:
- Regulators.
- Over Temperature warning and Shut down.
- GPIOs
- Multi Function Pins (MFP)

This patch adds support for tps65219 mfd device. At this time only
the functionalities listed below are made available:

- Regulators probe and functionalities
- warm and cold reset support
- SW shutdown support

Signed-off-by: Jerome NEANNE <jneanne@baylibre.com>
---
 drivers/mfd/Kconfig          |  15 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/tps65219.c       | 296 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/tps65219.h | 245 +++++++++++++++++++++++++++++
 4 files changed, 557 insertions(+)
 create mode 100644 drivers/mfd/tps65219.c
 create mode 100644 include/linux/mfd/tps65219.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..f8639b7b034b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1555,6 +1555,21 @@ config MFD_TPS65218
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65218.
 
+config MFD_TPS65219
+	tristate "TI TPS65219 Power Management chips"
+	depends on I2C && OF
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  If you say yes here you get support for the TPS65219 series of
+	  Power Management chips.
+	  These include voltage regulators, gpio and other features
+	  that are often used in portable devices.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tps65219.
+
 config MFD_TPS6586X
 	bool "TI TPS6586x Power Management chips"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8116c19d5fd4..11bce3e134f4 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_TPS6507X)		+= tps6507x.o
 obj-$(CONFIG_MFD_TPS65086)	+= tps65086.o
 obj-$(CONFIG_MFD_TPS65217)	+= tps65217.o
 obj-$(CONFIG_MFD_TPS65218)	+= tps65218.o
+obj-$(CONFIG_MFD_TPS65219)	+= tps65219.o
 obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
 obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
 obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
new file mode 100644
index 000000000000..b8e8115da555
--- /dev/null
+++ b/drivers/mfd/tps65219.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for TPS65219 Integrated power management chipsets
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+/* This implementation derived from tps65218 authored by "J Keerthy <j-keerthy@ti.com>" */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/reboot.h>
+
+#include <linux/mfd/core.h>
+#include <linux/mfd/tps65219.h>
+
+
+/**
+ * pmic_rst_restart: trig tps65219 reset to SOC.
+ *
+ * Trigged via notifier
+ */
+static int pmic_rst_restart(struct notifier_block *this,
+			  unsigned long mode, void *cmd)
+{
+	struct tps65219 *tps;
+
+	tps = container_of(this, struct tps65219, nb);
+	if (tps != NULL) {
+		if (WARMNCOLD)
+			tps65219_warm_reset(tps);
+		else
+			tps65219_cold_reset(tps);
+	} else {
+		pr_err("%s: pointer to tps65219 is invalid\n", __func__);
+		return -ENODEV;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct i2c_client *tps65219_i2c_client;
+/**
+ * pmic_poweroff: trig tps65219 regulators power OFF sequence.
+ */
+static void pmic_poweroff_do_poweroff(void)
+{
+	struct tps65219 *tps;
+
+	tps = dev_get_drvdata(&tps65219_i2c_client->dev);
+	tps65219_soft_shutdown(tps);
+
+}
+
+static struct notifier_block pmic_rst_restart_nb = {
+	.notifier_call = pmic_rst_restart,
+};
+
+static const struct mfd_cell tps65219_cells[] = {
+	{ .name = "tps65219-regulator", },
+};
+
+/**
+ * tps65219_reg_read: Read a single tps65219 register.
+ *
+ * @tps: Device to read from.
+ * @reg: Register to read.
+ * @val: Contians the value
+ */
+int tps65219_reg_read(struct tps65219 *tps, unsigned int reg,
+			unsigned int *val)
+{
+	return regmap_read(tps->regmap, reg, val);
+}
+EXPORT_SYMBOL_GPL(tps65219_reg_read);
+
+/**
+ * tps65219_reg_write: Write a single tps65219 register.
+ *
+ * @tps: Device to write to.
+ * @reg: Register to write to.
+ * @val: Value to write.
+ */
+int tps65219_reg_write(struct tps65219 *tps, unsigned int reg,
+			unsigned int val)
+{
+	return regmap_write(tps->regmap, reg, val);
+}
+EXPORT_SYMBOL_GPL(tps65219_reg_write);
+
+/**
+ * tps65219_update_bits: Modify bits w.r.t mask, val and level.
+ *
+ * @tps: Device to write to.
+ * @reg: Register to read-write to.
+ * @mask: Mask.
+ * @val: Value to write.
+ */
+static int tps65219_update_bits(struct tps65219 *tps, unsigned int reg,
+		unsigned int mask, unsigned int val)
+{
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(tps->regmap, reg, &data);
+	if (ret) {
+		dev_err(tps->dev, "Read from reg 0x%x failed\n", reg);
+		return ret;
+	}
+
+	data &= ~mask;
+	data |= val & mask;
+
+	mutex_lock(&tps->tps_lock);
+	ret = tps65219_reg_write(tps, reg, data);
+	if (ret)
+		dev_err(tps->dev, "Write for reg 0x%x failed\n", reg);
+	mutex_unlock(&tps->tps_lock);
+
+	return ret;
+}
+
+int tps65219_set_bits(struct tps65219 *tps, unsigned int reg,
+		unsigned int mask, unsigned int val)
+{
+	return tps65219_update_bits(tps, reg, mask, val);
+}
+EXPORT_SYMBOL_GPL(tps65219_set_bits);
+
+int tps65219_clear_bits(struct tps65219 *tps, unsigned int reg,
+		unsigned int mask)
+{
+	return tps65219_update_bits(tps, reg, mask, 0);
+}
+EXPORT_SYMBOL_GPL(tps65219_clear_bits);
+
+/**
+ * tps65219_warm_reset: issue warm reset to SOC.
+ *
+ * @tps: Device to write to.
+ */
+int tps65219_warm_reset(struct tps65219 *tps)
+{
+	int ret;
+
+	dev_dbg(tps->dev, "warm reset");
+	ret =  tps65219_set_bits(tps, TPS65219_REG_MFP_CTRL, TPS65219_MFP_WARM_RESET_I2C_CTRL,
+				 TPS65219_MFP_WARM_RESET_I2C_CTRL);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tps65219_warm_reset);
+
+/**
+ * tps65219_cold_reset: issue cold reset to SOC.
+ *
+ * @tps: Device to write to.
+ */
+int tps65219_cold_reset(struct tps65219 *tps)
+{
+	int ret;
+
+	dev_dbg(tps->dev, "cold reset generation");
+	ret =  tps65219_set_bits(tps, TPS65219_REG_MFP_CTRL, TPS65219_MFP_COLD_RESET_I2C_CTRL,
+				 TPS65219_MFP_COLD_RESET_I2C_CTRL);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tps65219_cold_reset);
+
+/**
+ * tps65219_soft_shutdown: issue cold reset to SOC.
+ *
+ * @tps: Device to write to.
+ */
+int tps65219_soft_shutdown(struct tps65219 *tps)
+{
+	int ret;
+
+	dev_dbg(tps->dev, "software shutdown");
+	ret =  tps65219_set_bits(tps, TPS65219_REG_MFP_CTRL, TPS65219_MFP_I2C_OFF_REQ,
+				 TPS65219_MFP_I2C_OFF_REQ);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tps65219_soft_shutdown);
+
+static const struct regmap_range tps65219_yes_ranges[] = {
+	regmap_reg_range(TPS65219_REG_INT_SOURCE, TPS65219_REG_POWER_UP_STATUS),
+};
+
+static const struct regmap_access_table tps65219_volatile_table = {
+	.yes_ranges = tps65219_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tps65219_yes_ranges),
+};
+
+static const struct regmap_config tps65219_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_table = &tps65219_volatile_table,
+};
+
+static const struct of_device_id of_tps65219_match_table[] = {
+	{ .compatible = "ti,tps65219", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_tps65219_match_table);
+
+static int tps65219_probe(struct i2c_client *client,
+				const struct i2c_device_id *ids)
+{
+	struct tps65219 *tps;
+	int ret;
+	unsigned int chipid;
+
+	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
+	if (!tps)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, tps);
+	tps->dev = &client->dev;
+	tps->regmap = devm_regmap_init_i2c(client, &tps65219_regmap_config);
+	if (IS_ERR(tps->regmap)) {
+		ret = PTR_ERR(tps->regmap);
+		dev_err(tps->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	mutex_init(&tps->tps_lock);
+
+	ret = regmap_read(tps->regmap, TPS65219_REG_TI_DEV_ID, &chipid);
+	if (ret) {
+		dev_err(tps->dev, "Failed to read device ID: %d\n", ret);
+		return ret;
+	}
+
+	tps->rev = chipid & TPS65219_DEVID_REV_MASK;
+
+	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65219_cells,
+			      ARRAY_SIZE(tps65219_cells), NULL, 0,
+			      NULL);
+
+	tps->nb = pmic_rst_restart_nb;
+	ret = register_restart_handler(&pmic_rst_restart_nb);
+
+	if (ret) {
+		dev_err(tps->dev, "%s: cannot register restart handler, %d\n",
+				__func__, ret);
+		return -ENODEV;
+	}
+
+	/* If a pm_power_off function has already been added, leave it alone */
+	if (pm_power_off != NULL) {
+		dev_warn(tps->dev,
+			"%s: pm_power_off function already registered\n",
+		       __func__);
+	} else {
+		tps65219_i2c_client = client;
+		pm_power_off = &pmic_poweroff_do_poweroff;
+	}
+	return ret;
+}
+
+static const struct i2c_device_id tps65219_id_table[] = {
+	{ "tps65219", TPS65219 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, tps65219_id_table);
+
+static struct i2c_driver tps65219_driver = {
+	.driver		= {
+		.name	= "tps65219",
+		.of_match_table = of_tps65219_match_table,
+	},
+	.probe		= tps65219_probe,
+	.id_table       = tps65219_id_table,
+};
+
+module_i2c_driver(tps65219_driver);
+
+MODULE_AUTHOR("Jerome NEANNE <jneanne@baylibre.com>");
+MODULE_DESCRIPTION("TPS65219 chip family multi-function driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
new file mode 100644
index 000000000000..c55efed2d130
--- /dev/null
+++ b/include/linux/mfd/tps65219.h
@@ -0,0 +1,245 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/mfd/tps65219.h
+ *
+ * Functions to access TPS65219 power management chip.
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#ifndef __LINUX_MFD_TPS65219_H
+#define __LINUX_MFD_TPS65219_H
+
+#include <linux/i2c.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/bitops.h>
+
+#define WARMNCOLD				1
+#define TPS65219_1V35				1350000
+#define TPS65219_1V8				1800000
+
+/* TPS chip id list */
+#define TPS65219				0xF0
+
+/* I2C ID for TPS65219 part */
+#define TPS65219_I2C_ID				0x24
+
+/* All register addresses */
+#define TPS65219_REG_TI_DEV_ID			0x00
+#define TPS65219_REG_NVM_ID			0x01
+#define TPS65219_REG_ENABLE_CTRL		0x02
+#define TPS65219_REG_BUCKS_CONFIG		0x03
+#define TPS65219_REG_LDO4_VOUT			0x04
+#define TPS65219_REG_LDO3_VOUT			0x05
+#define TPS65219_REG_LDO2_VOUT			0x06
+#define TPS65219_REG_LDO1_VOUT			0x07
+#define TPS65219_REG_BUCK3_VOUT			0x8
+#define TPS65219_REG_BUCK2_VOUT			0x9
+#define TPS65219_REG_BUCK1_VOUT			0xA
+#define TPS65219_REG_LDO4_SEQUENCE_SLOT		0xB
+#define TPS65219_REG_LDO3_SEQUENCE_SLOT		0xC
+#define TPS65219_REG_LDO2_SEQUENCE_SLOT		0xD
+#define TPS65219_REG_LDO1_SEQUENCE_SLOT		0xE
+#define TPS65219_REG_BUCK3_SEQUENCE_SLOT	0xF
+#define TPS65219_REG_BUCK2_SEQUENCE_SLOT	0x10
+#define TPS65219_REG_BUCK1_SEQUENCE_SLOT	0x11
+#define TPS65219_REG_nRST_SEQUENCE_SLOT		0x12
+#define TPS65219_REG_GPIO_SEQUENCE_SLOT		0x13
+#define TPS65219_REG_GPO2_SEQUENCE_SLOT		0x14
+#define TPS65219_REG_GPO1_SEQUENCE_SLOT		0x15
+#define TPS65219_REG_POWER_UP_SLOT_DURATION_1	0x16
+#define TPS65219_REG_POWER_UP_SLOT_DURATION_2	0x17
+#define TPS65219_REG_POWER_UP_SLOT_DURATION_3	0x18
+#define TPS65219_REG_POWER_UP_SLOT_DURATION_4	0x19
+#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_1	0x1A
+#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_2	0x1B
+#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_3	0x1C
+#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_4	0x1D
+#define TPS65219_REG_GENERAL_CONFIG		0x1E
+#define TPS65219_REG_MFP_1_CONFIG		0x1F
+#define TPS65219_REG_MFP_2_CONFIG		0x20
+#define TPS65219_REG_STBY_1_CONFIG		0x21
+#define TPS65219_REG_STBY_2_CONFIG		0x22
+#define TPS65219_REG_OC_DEGL_CONFIG		0x23
+#define TPS65219_REG_INT_MASK_UV		0x24
+#define TPS65219_REG_MASK_CONFIG		0x25
+#define TPS65219_REG_I2C_ADDRESS_REG		0x26
+#define TPS65219_REG_USER_GENERAL_NVM_STORAGE	0x27
+#define TPS65219_REG_MANUFACTURING_VER		0x28
+#define TPS65219_REG_MFP_CTRL			0x29
+#define TPS65219_REG_DISCHARGE_CONFIG		0x2A
+#define TPS65219_REG_INT_SOURCE			0x2B
+#define TPS65219_REG_INT_LDO_3_4		0x2C
+#define TPS65219_REG_INT_LDO_1_2		0x2D
+#define TPS65219_REG_INT_BUCK_3			0x2E
+#define TPS65219_REG_INT_BUCK_1_2		0x2F
+#define TPS65219_REG_INT_SYSTEM			0x30
+#define TPS65219_REG_INT_RV			0x31
+#define TPS65219_REG_INT_TIMEOUT_RV_SD		0x32
+#define TPS65219_REG_INT_PB			0x33
+#define TPS65219_REG_USER_NVM_CMD		0x34
+#define TPS65219_REG_POWER_UP_STATUS		0x35
+#define TPS65219_REG_SPARE_2			0x36
+#define TPS65219_REG_SPARE_3			0x37
+#define TPS65219_REG_FACTORY_CONFIG_2		0x41
+
+/* Register field definitions */
+#define TPS65219_DEVID_REV_MASK			0xFF
+#define TPS65219_BUCKS_LDOS_VOUT_VSET_MASK	0x3F
+#define TPS65219_BUCKS_UV_THR_SEL		BIT(6)
+#define TPS65219_BUCKS_BW_SEL			BIT(7)
+#define TPS65219_LDOS_BYP_CONFIG_SHIFT		6
+#define TPS65219_LDOS_BYP_CONFIG_MASK		BIT(TPS65219_LDOS_BYP_CONFIG_SHIFT)
+#define TPS65219_LDOS_LSW_CONFIG_MASK		BIT(7)
+/* Regulators enable control */
+#define TPS65219_ENABLE_BUCK1_EN		BIT(0)
+#define TPS65219_ENABLE_BUCK2_EN		BIT(1)
+#define TPS65219_ENABLE_BUCK3_EN		BIT(2)
+#define TPS65219_ENABLE_LDO1_EN			BIT(3)
+#define TPS65219_ENABLE_LDO2_EN			BIT(4)
+#define TPS65219_ENABLE_LDO3_EN			BIT(5)
+#define TPS65219_ENABLE_LDO4_EN			BIT(6)
+/* power ON-OFF sequence slot */
+#define TPS65219_BUCKS_LDOS_SEQUENCE_OFF_SLOT_MASK	0x0F
+#define TPS65219_BUCKS_LDOS_SEQUENCE_ON_SLOT_MASK	0xF0
+/* TODO: Not needed, same mapping as TPS65219_ENABLE_REGNAME_EN, factorize */
+#define TPS65219_STBY1_BUCK1_STBY_EN		BIT(0)
+#define TPS65219_STBY1_BUCK2_STBY_EN		BIT(1)
+#define TPS65219_STBY1_BUCK3_STBY_EN		BIT(2)
+#define TPS65219_STBY1_LDO1_STBY_EN		BIT(3)
+#define TPS65219_STBY1_LDO2_STBY_EN		BIT(4)
+#define TPS65219_STBY1_LDO3_STBY_EN		BIT(5)
+#define TPS65219_STBY1_LDO4_STBY_EN		BIT(6)
+/* STBY_2 config */
+#define TPS65219_STBY2_GPO1_STBY_EN		BIT(0)
+#define TPS65219_STBY2_GPO2_STBY_EN		BIT(1)
+#define TPS65219_STBY2_GPIO_STBY_EN		BIT(2)
+/* MFP Control */
+#define TPS65219_MFP_I2C_OFF_REQ		BIT(0)
+#define TPS65219_MFP_STBY_I2C_CTRL		BIT(1)
+#define TPS65219_MFP_COLD_RESET_I2C_CTRL	BIT(2)
+#define TPS65219_MFP_WARM_RESET_I2C_CTRL	BIT(3)
+#define TPS65219_MFP_GPIO_STATUS		BIT(4)
+#define BUCKS_LDOS_STBY_ON_BIT			0x1
+/* MFP_1 Config */
+#define TPS65219_MFP_1_VSEL_DDR_SEL		BIT(0)
+#define TPS65219_MFP_1_VSEL_SD_POL		BIT(1)
+#define TPS65219_MFP_1_VSEL_RAIL		BIT(2)
+/* interrupts source status*/
+#define TPS65219_INT_SRC_TIMEOUT_RV_SD_IS_SET	BIT(0)
+#define TPS65219_INT_SRC_RV_IS_SET		BIT(1)
+#define TPS65219_INT_SRC_SYSTEM_IS_SET		BIT(2)
+#define TPS65219_INT_SRC_BUCK_1_2_IS_SET	BIT(3)
+#define TPS65219_INT_SRC_BUCK_3_IS_SET		BIT(4)
+#define TPS65219_INT_SRC_LDO_1_2_IS_SET		BIT(5)
+#define TPS65219_INT_SRC_LDO_3_4_IS_SET		BIT(6)
+#define TPS65219_INT_SRC_PB_IS_SET		BIT(7)
+/* UnderVoltage - Short to GND - OverCurrent*/
+/* LDO3-4 */
+#define TPS65219_INT_LDO3_SCG			BIT(0)
+#define TPS65219_INT_LDO3_OC			BIT(1)
+#define TPS65219_INT_LDO3_UV			BIT(2)
+#define TPS65219_INT_LDO4_SCG			BIT(3)
+#define TPS65219_INT_LDO4_OC			BIT(4)
+#define TPS65219_INT_LDO4_UV			BIT(5)
+/* LDO1-2 */
+#define TPS65219_INT_LDO1_SCG			BIT(0)
+#define TPS65219_INT_LDO1_OC			BIT(1)
+#define TPS65219_INT_LDO1_UV			BIT(2)
+#define TPS65219_INT_LDO2_SCG			BIT(3)
+#define TPS65219_INT_LDO2_OC			BIT(4)
+#define TPS65219_INT_LDO2_UV			BIT(5)
+/* BUCK3 */
+#define TPS65219_INT_BUCK3_SCG			BIT(0)
+#define TPS65219_INT_BUCK3_OC			BIT(1)
+#define TPS65219_INT_BUCK3_NEG_OC		BIT(2)
+#define TPS65219_INT_BUCK3_UV			BIT(3)
+/* BUCK1-2 */
+#define TPS65219_INT_BUCK1_SCG			BIT(0)
+#define TPS65219_INT_BUCK1_OC			BIT(1)
+#define TPS65219_INT_BUCK1_NEG_OC		BIT(2)
+#define TPS65219_INT_BUCK1_UV			BIT(3)
+#define TPS65219_INT_BUCK2_SCG			BIT(4)
+#define TPS65219_INT_BUCK2_OC			BIT(5)
+#define TPS65219_INT_BUCK2_NEG_OC		BIT(6)
+#define TPS65219_INT_BUCK2_UV			BIT(7)
+/* Thermal Sensor  */
+#define TPS65219_INT_SENSOR_3_WARM		BIT(0)
+#define TPS65219_INT_SENSOR_2_WARM		BIT(1)
+#define TPS65219_INT_SENSOR_1_WARM		BIT(2)
+#define TPS65219_INT_SENSOR_0_WARM		BIT(3)
+#define TPS65219_INT_SENSOR_3_HOT		BIT(4)
+#define TPS65219_INT_SENSOR_2_HOT		BIT(5)
+#define TPS65219_INT_SENSOR_1_HOT		BIT(6)
+#define TPS65219_INT_SENSOR_0_HOT		BIT(7)
+/* Residual Voltage */
+#define TPS65219_INT_BUCK1_RV			BIT(0)
+#define TPS65219_INT_BUCK2_RV			BIT(1)
+#define TPS65219_INT_BUCK3_RV			BIT(2)
+#define TPS65219_INT_LDO1_RV			BIT(3)
+#define TPS65219_INT_LDO2_RV			BIT(4)
+#define TPS65219_INT_LDO3_RV			BIT(5)
+#define TPS65219_INT_LDO4_RV			BIT(6)
+/* Residual Voltage ShutDown */
+#define TPS65219_INT_BUCK1_RV_SD		BIT(0)
+#define TPS65219_INT_BUCK2_RV_SD		BIT(1)
+#define TPS65219_INT_BUCK3_RV_SD		BIT(2)
+#define TPS65219_INT_LDO1_RV_SD			BIT(3)
+#define TPS65219_INT_LDO2_RV_SD			BIT(4)
+#define TPS65219_INT_LDO3_RV_SD			BIT(5)
+#define TPS65219_INT_LDO4_RV_SD			BIT(6)
+#define TPS65219_INT_TIMEOUT			BIT(7)
+/* Power Button */
+#define TPS65219_INT_PB_FALLING_EDGE_DET	BIT(0)
+#define TPS65219_INT_PB_RISING_EDGE_DETECT	BIT(1)
+#define TPS65219_INT_PB_REAL_TIME_STATUS	BIT(2)
+
+enum tps65219_regulator_id {
+	/* DCDC's */
+	TPS65219_BUCK_1,
+	TPS65219_BUCK_2,
+	TPS65219_BUCK_3,
+	/* LDOs */
+	TPS65219_LDO_1,
+	TPS65219_LDO_2,
+	TPS65219_LDO_3,
+	TPS65219_LDO_4,
+};
+
+#define TPS65219_MAX_REG_ID		TPS65219_LDO_4
+
+/* Number of step-down converters available */
+#define TPS65219_NUM_DCDC		3
+/* Number of LDO voltage regulators available */
+#define TPS65219_NUM_LDO		4
+/* Number of total regulators available */
+#define TPS65219_NUM_REGULATOR		(TPS65219_NUM_DCDC + TPS65219_NUM_LDO)
+
+/**
+ * struct tps65219 - tps65219 sub-driver chip access routines
+ *
+ * Device data may be used to access the TPS65219 chip
+ */
+struct tps65219 {
+	struct device *dev;
+	unsigned int id;
+	u8 rev;
+	struct mutex tps_lock;		/* lock guarding the data structure */
+	struct regulator_desc desc[TPS65219_NUM_REGULATOR];
+	struct regmap *regmap;
+	u8 *strobes;
+	struct notifier_block nb;
+};
+int tps65219_reg_read(struct tps65219 *tps, unsigned int reg,
+			unsigned int *val);
+int tps65219_reg_write(struct tps65219 *tps, unsigned int reg,
+			unsigned int val);
+int tps65219_set_bits(struct tps65219 *tps, unsigned int reg,
+		unsigned int mask, unsigned int val);
+int tps65219_clear_bits(struct tps65219 *tps, unsigned int reg,
+		unsigned int mask);
+int tps65219_warm_reset(struct tps65219 *tps);
+int tps65219_cold_reset(struct tps65219 *tps);
+int tps65219_soft_shutdown(struct tps65219 *tps);
+#endif /*  __LINUX_MFD_TPS65219_H */
-- 
2.17.1

