Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D783158AAB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbiHEMTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbiHEMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:19:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A274785BB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:19:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m4so4743236ejr.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=VSxre6cBwjNqPPecgPAEhm/+TXo/mwZa3w41YBkjY/A=;
        b=f2jemr3iMPp3HJ3mxIStrf4ScIvA9+09jzfW/BAMvjBo2C7auyWSNjQdL9VlmiUvUh
         ZUp2AT4yqdDQ/u0d7fi3lMi2+7IF41ePf7umOeQrpHKLQwSBDn/xoCY7XQunPuwgCNtr
         e+d3ajYnkxC2JpZgJPyDl2DOgrQOXTIwtc6SB7HcNNiEa4TKCfy1eA9yW/q4XiWgYAl8
         f1sfZ25YAW5yTC0UnEHeHEuYS+lwBNb8wTCFB6XJi6+lCqg3TnOihllrbzb7vm60CAEf
         ZeqnC0yQVHx+3FnrzQCNzvJMaJQwc3nWpGElEndBR3VTMt7A0x2JIuMbOEXLEZb0wQ4l
         zzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=VSxre6cBwjNqPPecgPAEhm/+TXo/mwZa3w41YBkjY/A=;
        b=ZwFMrWOvmFdwvxnYFRflg6uDxa2S/+DpN7lRF6L/KOraYsTJeixQsgFXTrOXJB2yx0
         5B8VFxyp5tm2FapHO5Px4V0jHQNCeNtD2iu3lNLTA1GVv3PwdDX1TEjyAA1q+53cL+Dc
         uVG9mRSUISxgZtNQyohzUoPsryW08ci7c5zUEG2XYHFv59PofOuZOD01TRdDDco0zrQr
         6oA6H5I6LKmzSXS60D1KIReMHr8kYZXols7I2wwnGveVN7Vc5rgp28UH60fFAbIYb0u9
         wHfQAFQAGixH0nA/SWrfWb6VW9kFXMtp0RZENQ0R5mwaugOIz5dWiRbqJhWcyleLp1fO
         2MSA==
X-Gm-Message-State: ACgBeo2Kx2SqJ/rLnrzm1dlKO9EPQE6xY/AWXo1hnhTvFW0lcITJjfii
        PIaPFMhzrv6Bnx90bh4Z56fPbg==
X-Google-Smtp-Source: AA6agR63U4PVs5yAIypIGzvAaYbphEFTkkEjAsR4FjBvFt2US08Ww66SH7QNXT9482CLVqnuQm1bPA==
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id 22-20020a170906021600b00711f6238bb0mr5229558ejd.174.1659701957550;
        Fri, 05 Aug 2022 05:19:17 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-5241-be09-b892-f882-607f-7a79.rev.sfr.net. [2a02:8440:5241:be09:b892:f882:607f:7a79])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0072b3464c043sm1506111ejc.116.2022.08.05.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:19:17 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: [PATCH v3 05/10] mfd: drivers: Add TI TPS65219 PMIC support
Date:   Fri,  5 Aug 2022 14:18:47 +0200
Message-Id: <20220805121852.21254-6-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220805121852.21254-1-jneanne@baylibre.com>
References: <20220805121852.21254-1-jneanne@baylibre.com>
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

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 MAINTAINERS                  |   1 +
 drivers/mfd/Kconfig          |  15 +++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/tps65219.c       | 214 +++++++++++++++++++++++++++++
 include/linux/mfd/tps65219.h | 251 +++++++++++++++++++++++++++++++++++
 5 files changed, 482 insertions(+)
 create mode 100644 drivers/mfd/tps65219.c
 create mode 100644 include/linux/mfd/tps65219.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fee3ecc2d6ca..ffd533b8debc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14840,6 +14840,7 @@ F:	drivers/mfd/menelaus.c
 F:	drivers/mfd/palmas.c
 F:	drivers/mfd/tps65217.c
 F:	drivers/mfd/tps65218.c
+F:	drivers/mfd/tps65219.c
 F:	drivers/mfd/tps65910.c
 F:	drivers/mfd/twl-core.[ch]
 F:	drivers/mfd/twl4030*.c
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..c66e56374a9a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1574,6 +1574,21 @@ config MFD_TPS65218
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
+	  This driver can also be built as a module. If so, the module
+	  will be called tps65219.
+
 config MFD_TPS6586X
 	bool "TI TPS6586x Power Management chips"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..a8ff3d6ea3ab 100644
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
index 000000000000..c3bf975ea6c7
--- /dev/null
+++ b/drivers/mfd/tps65219.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for TPS65219 Integrated power management chipsets
+//
+// Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+//
+// This implementation derived from tps65218 authored by
+// "J Keerthy <j-keerthy@ti.com>"
+//
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/reboot.h>
+
+#include <linux/mfd/core.h>
+#include <linux/mfd/tps65219.h>
+
+static struct i2c_client *tps65219_i2c_client;
+
+/**
+ * tps65219_warm_reset: issue warm reset to SOC.
+ *
+ * @tps: Device to write to.
+ */
+static int tps65219_warm_reset(struct tps65219 *tps)
+{
+	dev_dbg(tps->dev, "warm reset");
+	pr_flush(1000, true);
+	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
+				  TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK,
+				  TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK);
+}
+
+/**
+ * tps65219_cold_reset: issue cold reset to SOC.
+ *
+ * @tps: Device to write to.
+ */
+static int tps65219_cold_reset(struct tps65219 *tps)
+{
+	dev_dbg(tps->dev, "cold reset");
+	pr_flush(1000, true);
+	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
+				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK,
+				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
+}
+
+/**
+ * tps65219_soft_shutdown: issue cold reset to SOC.
+ *
+ * @tps: Device to write to.
+ */
+static int tps65219_soft_shutdown(struct tps65219 *tps)
+{
+	dev_dbg(tps->dev, "software shutdown");
+	pr_flush(1000, true);
+	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
+				  TPS65219_MFP_I2C_OFF_REQ_MASK,
+				  TPS65219_MFP_I2C_OFF_REQ_MASK);
+}
+
+/**
+ * pmic_rst_restart: trig tps65219 reset to SOC.
+ *
+ * Trigged via notifier
+ */
+static int pmic_rst_restart(struct notifier_block *this,
+			    unsigned long reboot_mode, void *cmd)
+{
+	struct tps65219 *tps;
+
+	tps = container_of(this, struct tps65219, nb);
+	if (!tps) {
+		pr_err("%s: pointer to tps65219 is invalid\n", __func__);
+		return -ENODEV;
+	}
+	if (reboot_mode == REBOOT_WARM)
+		tps65219_warm_reset(tps);
+	else
+		tps65219_cold_reset(tps);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pmic_rst_restart_nb = {
+	.notifier_call = pmic_rst_restart,
+	.priority = 200,
+};
+
+/**
+ * pmic_do_poweroff: trig tps65219 regulators power OFF sequence.
+ */
+static void pmic_do_poweroff(void)
+{
+	struct tps65219 *tps;
+
+	tps = dev_get_drvdata(&tps65219_i2c_client->dev);
+	tps65219_soft_shutdown(tps);
+}
+
+static const struct mfd_cell tps65219_cells[] = {
+	{ .name = "tps65219-regulator", },
+};
+
+static const struct regmap_config tps65219_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = TPS65219_REG_FACTORY_CONFIG_2,
+};
+
+static const struct of_device_id of_tps65219_match_table[] = {
+	{ .compatible = "ti,tps65219", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_tps65219_match_table);
+
+static int tps65219_probe(struct i2c_client *client,
+			  const struct i2c_device_id *ids)
+{
+	struct tps65219 *tps;
+	int ret;
+	unsigned int chipid;
+	bool sys_pwr;
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
+	ret = regmap_read(tps->regmap, TPS65219_REG_TI_DEV_ID, &chipid);
+	if (ret) {
+		dev_err(tps->dev, "Failed to read device ID: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65219_cells,
+				   ARRAY_SIZE(tps65219_cells), NULL, 0,
+				   NULL);
+	if (ret) {
+		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
+		return ret;
+	}
+
+	tps->nb = pmic_rst_restart_nb;
+	ret = register_restart_handler(&tps->nb);
+	if (ret) {
+		dev_err(tps->dev, "%s: cannot register restart handler, %d\n",
+			__func__, ret);
+		return -ENODEV;
+	}
+
+	sys_pwr = of_property_read_bool(tps->dev->of_node,
+					"system-power-controller");
+
+	if (sys_pwr) {
+		if (pm_power_off)
+			dev_warn(tps->dev, "Setup as system-power-controller but pm_power_off function already registered, overwriting\n");
+		tps65219_i2c_client = client;
+		pm_power_off = &pmic_do_poweroff;
+	}
+	return ret;
+}
+
+static int tps65219_remove(struct i2c_client *client)
+{
+	struct tps65219 *tps = i2c_get_clientdata(client);
+
+	if (tps65219_i2c_client == client) {
+		pm_power_off = NULL;
+		tps65219_i2c_client = NULL;
+	}
+
+	return unregister_restart_handler(&tps->nb);
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
+	.remove		= tps65219_remove,
+};
+
+module_i2c_driver(tps65219_driver);
+
+MODULE_AUTHOR("Jerome Neanne <jneanne@baylibre.com>");
+MODULE_DESCRIPTION("TPS65219 chip family multi-function driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
new file mode 100644
index 000000000000..e9197ab8bc75
--- /dev/null
+++ b/include/linux/mfd/tps65219.h
@@ -0,0 +1,251 @@
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
+#include <linux/regmap.h>
+
+#define TPS65219_1V35					1350000
+#define TPS65219_1V8					1800000
+
+/* TPS chip id list */
+#define TPS65219					0xF0
+
+/* I2C ID for TPS65219 part */
+#define TPS65219_I2C_ID					0x24
+
+/* All register addresses */
+#define TPS65219_REG_TI_DEV_ID				0x00
+#define TPS65219_REG_NVM_ID				0x01
+#define TPS65219_REG_ENABLE_CTRL			0x02
+#define TPS65219_REG_BUCKS_CONFIG			0x03
+#define TPS65219_REG_LDO4_VOUT				0x04
+#define TPS65219_REG_LDO3_VOUT				0x05
+#define TPS65219_REG_LDO2_VOUT				0x06
+#define TPS65219_REG_LDO1_VOUT				0x07
+#define TPS65219_REG_BUCK3_VOUT				0x8
+#define TPS65219_REG_BUCK2_VOUT				0x9
+#define TPS65219_REG_BUCK1_VOUT				0xA
+#define TPS65219_REG_LDO4_SEQUENCE_SLOT			0xB
+#define TPS65219_REG_LDO3_SEQUENCE_SLOT			0xC
+#define TPS65219_REG_LDO2_SEQUENCE_SLOT			0xD
+#define TPS65219_REG_LDO1_SEQUENCE_SLOT			0xE
+#define TPS65219_REG_BUCK3_SEQUENCE_SLOT		0xF
+#define TPS65219_REG_BUCK2_SEQUENCE_SLOT		0x10
+#define TPS65219_REG_BUCK1_SEQUENCE_SLOT		0x11
+#define TPS65219_REG_nRST_SEQUENCE_SLOT			0x12
+#define TPS65219_REG_GPIO_SEQUENCE_SLOT			0x13
+#define TPS65219_REG_GPO2_SEQUENCE_SLOT			0x14
+#define TPS65219_REG_GPO1_SEQUENCE_SLOT			0x15
+#define TPS65219_REG_POWER_UP_SLOT_DURATION_1		0x16
+#define TPS65219_REG_POWER_UP_SLOT_DURATION_2		0x17
+#define TPS65219_REG_POWER_UP_SLOT_DURATION_3		0x18
+#define TPS65219_REG_POWER_UP_SLOT_DURATION_4		0x19
+#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_1		0x1A
+#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_2		0x1B
+#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_3		0x1C
+#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_4		0x1D
+#define TPS65219_REG_GENERAL_CONFIG			0x1E
+#define TPS65219_REG_MFP_1_CONFIG			0x1F
+#define TPS65219_REG_MFP_2_CONFIG			0x20
+#define TPS65219_REG_STBY_1_CONFIG			0x21
+#define TPS65219_REG_STBY_2_CONFIG			0x22
+#define TPS65219_REG_OC_DEGL_CONFIG			0x23
+/* 'sub irq' MASK registers */
+#define TPS65219_REG_INT_MASK_UV			0x24
+#define TPS65219_REG_MASK_CONFIG			0x25
+
+#define TPS65219_REG_I2C_ADDRESS_REG			0x26
+#define TPS65219_REG_USER_GENERAL_NVM_STORAGE		0x27
+#define TPS65219_REG_MANUFACTURING_VER			0x28
+#define TPS65219_REG_MFP_CTRL				0x29
+#define TPS65219_REG_DISCHARGE_CONFIG			0x2A
+/* main irq registers */
+#define TPS65219_REG_INT_SOURCE				0x2B
+/* 'sub irq' registers */
+#define TPS65219_REG_INT_LDO_3_4			0x2C
+#define TPS65219_REG_INT_LDO_1_2			0x2D
+#define TPS65219_REG_INT_BUCK_3				0x2E
+#define TPS65219_REG_INT_BUCK_1_2			0x2F
+#define TPS65219_REG_INT_SYSTEM				0x30
+#define TPS65219_REG_INT_RV				0x31
+#define TPS65219_REG_INT_TIMEOUT_RV_SD			0x32
+#define TPS65219_REG_INT_PB				0x33
+
+#define TPS65219_REG_USER_NVM_CMD			0x34
+#define TPS65219_REG_POWER_UP_STATUS			0x35
+#define TPS65219_REG_SPARE_2				0x36
+#define TPS65219_REG_SPARE_3				0x37
+#define TPS65219_REG_FACTORY_CONFIG_2			0x41
+
+/* Register field definitions */
+#define TPS65219_DEVID_REV_MASK				GENMASK(7, 0)
+#define TPS65219_BUCKS_LDOS_VOUT_VSET_MASK		GENMASK(5, 0)
+#define TPS65219_BUCKS_UV_THR_SEL_MASK			BIT(6)
+#define TPS65219_BUCKS_BW_SEL_MASK			BIT(7)
+#define LDO_BYP_SHIFT					6
+#define TPS65219_LDOS_BYP_CONFIG_MASK			BIT(LDO_BYP_SHIFT)
+#define TPS65219_LDOS_LSW_CONFIG_MASK			BIT(7)
+/* Regulators enable control */
+#define TPS65219_ENABLE_BUCK1_EN_MASK			BIT(0)
+#define TPS65219_ENABLE_BUCK2_EN_MASK			BIT(1)
+#define TPS65219_ENABLE_BUCK3_EN_MASK			BIT(2)
+#define TPS65219_ENABLE_LDO1_EN_MASK			BIT(3)
+#define TPS65219_ENABLE_LDO2_EN_MASK			BIT(4)
+#define TPS65219_ENABLE_LDO3_EN_MASK			BIT(5)
+#define TPS65219_ENABLE_LDO4_EN_MASK			BIT(6)
+/* power ON-OFF sequence slot */
+#define TPS65219_BUCKS_LDOS_SEQUENCE_OFF_SLOT_MASK	GENMASK(3, 0)
+#define TPS65219_BUCKS_LDOS_SEQUENCE_ON_SLOT_MASK	GENMASK(7, 4)
+/* TODO: Not needed, same mapping as TPS65219_ENABLE_REGNAME_EN, factorize */
+#define TPS65219_STBY1_BUCK1_STBY_EN_MASK		BIT(0)
+#define TPS65219_STBY1_BUCK2_STBY_EN_MASK		BIT(1)
+#define TPS65219_STBY1_BUCK3_STBY_EN_MASK		BIT(2)
+#define TPS65219_STBY1_LDO1_STBY_EN_MASK		BIT(3)
+#define TPS65219_STBY1_LDO2_STBY_EN_MASK		BIT(4)
+#define TPS65219_STBY1_LDO3_STBY_EN_MASK		BIT(5)
+#define TPS65219_STBY1_LDO4_STBY_EN_MASK		BIT(6)
+/* STBY_2 config */
+#define TPS65219_STBY2_GPO1_STBY_EN_MASK		BIT(0)
+#define TPS65219_STBY2_GPO2_STBY_EN_MASK		BIT(1)
+#define TPS65219_STBY2_GPIO_STBY_EN_MASK		BIT(2)
+/* MFP Control */
+#define TPS65219_MFP_I2C_OFF_REQ_MASK			BIT(0)
+#define TPS65219_MFP_STBY_I2C_CTRL_MASK			BIT(1)
+#define TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK		BIT(2)
+#define TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK		BIT(3)
+#define TPS65219_MFP_GPIO_STATUS_MASK			BIT(4)
+/* MFP_1 Config */
+#define TPS65219_MFP_1_VSEL_DDR_SEL_MASK		BIT(0)
+#define TPS65219_MFP_1_VSEL_SD_POL_MASK			BIT(1)
+#define TPS65219_MFP_1_VSEL_RAIL_MASK			BIT(2)
+/* MFP_2 Config */
+#define TPS65219_MFP_2_MODE_STBY_MASK			GENMASK(1, 0)
+#define TPS65219_MFP_2_MODE_RESET_MASK			BIT(2)
+#define TPS65219_MFP_2_EN_PB_VSENSE_DEGL_MASK		BIT(3)
+#define TPS65219_MFP_2_EN_PB_VSENSE_MASK		GENMASK(5, 4)
+#define TPS65219_MFP_2_WARM_COLD_RESET_MASK		BIT(6)
+#define TPS65219_MFP_2_PU_ON_FSD_MASK			BIT(7)
+#define TPS65219_MFP_2_EN				0
+#define TPS65219_MFP_2_PB				BIT(4)
+#define TPS65219_MFP_2_VSENSE				BIT(5)
+/* MASK_UV Config */
+#define TPS65219_REG_MASK_UV_LDO1_UV_MASK		BIT(0)
+#define TPS65219_REG_MASK_UV_LDO2_UV_MASK		BIT(1)
+#define TPS65219_REG_MASK_UV_LDO3_UV_MASK		BIT(2)
+#define TPS65219_REG_MASK_UV_LDO4_UV_MASK		BIT(3)
+#define TPS65219_REG_MASK_UV_BUCK1_UV_MASK		BIT(4)
+#define TPS65219_REG_MASK_UV_BUCK2_UV_MASK		BIT(5)
+#define TPS65219_REG_MASK_UV_BUCK3_UV_MASK		BIT(6)
+#define TPS65219_REG_MASK_UV_RETRY_MASK			BIT(7)
+/* MASK Config */
+// SENSOR_N_WARM_MASK already defined in Thermal
+#define TPS65219_REG_MASK_INT_FOR_RV_MASK		BIT(4)
+#define TPS65219_REG_MASK_EFFECT_MASK			GENMASK(2, 1)
+#define TPS65219_REG_MASK_INT_FOR_PB_MASK		BIT(7)
+/* UnderVoltage - Short to GND - OverCurrent*/
+/* LDO3-4 */
+#define TPS65219_INT_LDO3_SCG_MASK			BIT(0)
+#define TPS65219_INT_LDO3_OC_MASK			BIT(1)
+#define TPS65219_INT_LDO3_UV_MASK			BIT(2)
+#define TPS65219_INT_LDO4_SCG_MASK			BIT(3)
+#define TPS65219_INT_LDO4_OC_MASK			BIT(4)
+#define TPS65219_INT_LDO4_UV_MASK			BIT(5)
+/* LDO1-2 */
+#define TPS65219_INT_LDO1_SCG_MASK			BIT(0)
+#define TPS65219_INT_LDO1_OC_MASK			BIT(1)
+#define TPS65219_INT_LDO1_UV_MASK			BIT(2)
+#define TPS65219_INT_LDO2_SCG_MASK			BIT(3)
+#define TPS65219_INT_LDO2_OC_MASK			BIT(4)
+#define TPS65219_INT_LDO2_UV_MASK			BIT(5)
+/* BUCK3 */
+#define TPS65219_INT_BUCK3_SCG_MASK			BIT(0)
+#define TPS65219_INT_BUCK3_OC_MASK			BIT(1)
+#define TPS65219_INT_BUCK3_NEG_OC_MASK			BIT(2)
+#define TPS65219_INT_BUCK3_UV_MASK			BIT(3)
+/* BUCK1-2 */
+#define TPS65219_INT_BUCK1_SCG_MASK			BIT(0)
+#define TPS65219_INT_BUCK1_OC_MASK			BIT(1)
+#define TPS65219_INT_BUCK1_NEG_OC_MASK			BIT(2)
+#define TPS65219_INT_BUCK1_UV_MASK			BIT(3)
+#define TPS65219_INT_BUCK2_SCG_MASK			BIT(4)
+#define TPS65219_INT_BUCK2_OC_MASK			BIT(5)
+#define TPS65219_INT_BUCK2_NEG_OC_MASK			BIT(6)
+#define TPS65219_INT_BUCK2_UV_MASK			BIT(7)
+/* Thermal Sensor  */
+#define TPS65219_INT_SENSOR_3_WARM_MASK			BIT(0)
+#define TPS65219_INT_SENSOR_2_WARM_MASK			BIT(1)
+#define TPS65219_INT_SENSOR_1_WARM_MASK			BIT(2)
+#define TPS65219_INT_SENSOR_0_WARM_MASK			BIT(3)
+#define TPS65219_INT_SENSOR_3_HOT_MASK			BIT(4)
+#define TPS65219_INT_SENSOR_2_HOT_MASK			BIT(5)
+#define TPS65219_INT_SENSOR_1_HOT_MASK			BIT(6)
+#define TPS65219_INT_SENSOR_0_HOT_MASK			BIT(7)
+/* Residual Voltage */
+#define TPS65219_INT_BUCK1_RV_MASK			BIT(0)
+#define TPS65219_INT_BUCK2_RV_MASK			BIT(1)
+#define TPS65219_INT_BUCK3_RV_MASK			BIT(2)
+#define TPS65219_INT_LDO1_RV_MASK			BIT(3)
+#define TPS65219_INT_LDO2_RV_MASK			BIT(4)
+#define TPS65219_INT_LDO3_RV_MASK			BIT(5)
+#define TPS65219_INT_LDO4_RV_MASK			BIT(6)
+/* Residual Voltage ShutDown */
+#define TPS65219_INT_BUCK1_RV_SD_MASK			BIT(0)
+#define TPS65219_INT_BUCK2_RV_SD_MASK			BIT(1)
+#define TPS65219_INT_BUCK3_RV_SD_MASK			BIT(2)
+#define TPS65219_INT_LDO1_RV_SD_MASK			BIT(3)
+#define TPS65219_INT_LDO2_RV_SD_MASK			BIT(4)
+#define TPS65219_INT_LDO3_RV_SD_MASK			BIT(5)
+#define TPS65219_INT_LDO4_RV_SD_MASK			BIT(6)
+#define TPS65219_INT_TIMEOUT_MASK			BIT(7)
+/* Power Button */
+#define TPS65219_INT_PB_FALLING_EDGE_DET_MASK		BIT(0)
+#define TPS65219_INT_PB_RISING_EDGE_DET_MASK		BIT(1)
+#define TPS65219_INT_PB_REAL_TIME_STATUS_MASK		BIT(2)
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
+	struct regulator_desc desc[TPS65219_NUM_REGULATOR];
+	struct regmap *regmap;
+	struct notifier_block nb;
+};
+
+#endif /*  __LINUX_MFD_TPS65219_H */
-- 
2.17.1

