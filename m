Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B833F5A88A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiHaV4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiHaVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:55:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AD35FB8;
        Wed, 31 Aug 2022 14:54:54 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-057-024.ewe-ip-backbone.de [91.96.57.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4CBF66601E49;
        Wed, 31 Aug 2022 22:54:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661982887;
        bh=x+Uza6I9B5kavGGUosXheKImAYb7dZX04NpiUsI+gWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJbmL8Fz703lXLGVcrL0b04WP0mdWpu+A50lkmGqNurehLk//l1Qz9+aCUGKal+6g
         MJRK03oGG+nLp1v8qnZ5TOX/Frxv798nLYr1oJ7NhULSbizgfRETmKCa0KzS2Pn16p
         fQp77fyFtpQTjE7xZYXyaM0kMYWDTzK3PZBlW9GWQPU/asUJeXIaJ1IvnD2fuUDBh9
         A9iIkgteCOUSWqGGy16ig9TK/PgpQ/zbC2ZFTROUwIpTT9kmbD3+lTaxu0YZPSc5Y/
         QcWFcjTD717GKI2gopL/goQV/zzF6snL+/BkUg1s1zjDyIlGkPMSGZiAMKn8x6CCsh
         xwY0TB2enxQlw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 3D819481221; Wed, 31 Aug 2022 23:54:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 07/13] mfd: rk808: split into core and i2c
Date:   Wed, 31 Aug 2022 23:54:31 +0200
Message-Id: <20220831215437.117880-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831215437.117880-1-sebastian.reichel@collabora.com>
References: <20220831215437.117880-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split rk808 into a core and an i2c part in preperation for
SPI support.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/Kconfig                   |   5 +
 drivers/mfd/Makefile                  |   3 +-
 drivers/mfd/{rk808.c => rk8xx-core.c} | 202 +++++--------------------
 drivers/mfd/rk8xx-i2c.c               | 205 ++++++++++++++++++++++++++
 include/linux/mfd/rk808.h             |   6 +
 5 files changed, 251 insertions(+), 170 deletions(-)
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (75%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a1a4..acb7133d6db6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1143,11 +1143,16 @@ config MFD_RC5T583
 	  different functionality of the device.
 
 config MFD_RK808
+	bool
+	select MFD_CORE
+
+config MFD_RK8XX_I2C
 	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power Management Chip"
 	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
+	select MFD_RK808
 	help
 	  If you say yes here you get support for the RK805, RK808, RK809,
 	  RK817 and RK818 Power Management chips.
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..25ac617a5e6b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -215,7 +215,8 @@ obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
-obj-$(CONFIG_MFD_RK808)		+= rk808.o
+obj-$(CONFIG_MFD_RK808)		+= rk8xx-core.o
+obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
 obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
 obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
 obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk8xx-core.c
similarity index 75%
rename from drivers/mfd/rk808.c
rename to drivers/mfd/rk8xx-core.c
index 7baa0e484ac0..d0ce17d98fdc 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -12,7 +12,6 @@
  * Author: Wadim Egorov <w.egorov@phytec.de>
  */
 
-#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/rk808.h>
 #include <linux/mfd/core.h>
@@ -27,88 +26,6 @@ struct rk808_reg_data {
 	int value;
 };
 
-static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	/*
-	 * Notes:
-	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
-	 *   we don't use that feature.  It's better to cache.
-	 * - It's unlikely we care that RK808_DEVCTRL_REG is volatile since
-	 *   bits are cleared in case when we shutoff anyway, but better safe.
-	 */
-
-	switch (reg) {
-	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
-	case RK808_RTC_STATUS_REG:
-	case RK808_VB_MON_REG:
-	case RK808_THERMAL_REG:
-	case RK808_DCDC_UV_STS_REG:
-	case RK808_LDO_UV_STS_REG:
-	case RK808_DCDC_PG_REG:
-	case RK808_LDO_PG_REG:
-	case RK808_DEVCTRL_REG:
-	case RK808_INT_STS_REG1:
-	case RK808_INT_STS_REG2:
-		return true;
-	}
-
-	return false;
-}
-
-static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	/*
-	 * Notes:
-	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
-	 *   we don't use that feature.  It's better to cache.
-	 */
-
-	switch (reg) {
-	case RK817_SECONDS_REG ... RK817_WEEKS_REG:
-	case RK817_RTC_STATUS_REG:
-	case RK817_CODEC_DTOP_LPT_SRST:
-	case RK817_INT_STS_REG0:
-	case RK817_INT_STS_REG1:
-	case RK817_INT_STS_REG2:
-	case RK817_SYS_STS:
-		return true;
-	}
-
-	return true;
-}
-
-static const struct regmap_config rk818_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = RK818_USB_CTRL_REG,
-	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = rk808_is_volatile_reg,
-};
-
-static const struct regmap_config rk805_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = RK805_OFF_SOURCE_REG,
-	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = rk808_is_volatile_reg,
-};
-
-static const struct regmap_config rk808_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = RK808_IO_POL_REG,
-	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = rk808_is_volatile_reg,
-};
-
-static const struct regmap_config rk817_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = RK817_GPIO_INT_CFG,
-	.cache_type = REGCACHE_NONE,
-	.volatile_reg = rk817_is_volatile_reg,
-};
-
 static const struct resource rtc_resources[] = {
 	DEFINE_RES_IRQ(RK808_IRQ_RTC_ALARM),
 };
@@ -584,9 +501,9 @@ static int rk808_restart(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
-static void rk8xx_shutdown(struct i2c_client *client)
+void rk8xx_shutdown(struct device *dev)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(client);
+	struct rk808 *rk808 = dev_get_drvdata(dev);
 	int ret;
 
 	switch (rk808->variant) {
@@ -607,64 +524,31 @@ static void rk8xx_shutdown(struct i2c_client *client)
 		return;
 	}
 	if (ret)
-		dev_warn(&client->dev,
+		dev_warn(dev,
 			 "Cannot switch to power down function\n");
 }
+EXPORT_SYMBOL_GPL(rk8xx_shutdown);
 
-static const struct of_device_id rk808_of_match[] = {
-	{ .compatible = "rockchip,rk805" },
-	{ .compatible = "rockchip,rk808" },
-	{ .compatible = "rockchip,rk809" },
-	{ .compatible = "rockchip,rk817" },
-	{ .compatible = "rockchip,rk818" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, rk808_of_match);
-
-static int rk808_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id)
+int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap)
 {
-	struct device_node *np = client->dev.of_node;
 	struct rk808 *rk808;
 	const struct rk808_reg_data *pre_init_reg;
 	const struct mfd_cell *cells;
 	int nr_pre_init_regs;
 	int nr_cells;
-	int msb, lsb;
-	unsigned char pmic_id_msb, pmic_id_lsb;
 	int ret;
 	int i;
 
-	rk808 = devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNEL);
+	rk808 = devm_kzalloc(dev, sizeof(*rk808), GFP_KERNEL);
 	if (!rk808)
 		return -ENOMEM;
-
-	if (of_device_is_compatible(np, "rockchip,rk817") ||
-	    of_device_is_compatible(np, "rockchip,rk809")) {
-		pmic_id_msb = RK817_ID_MSB;
-		pmic_id_lsb = RK817_ID_LSB;
-	} else {
-		pmic_id_msb = RK808_ID_MSB;
-		pmic_id_lsb = RK808_ID_LSB;
-	}
-
-	/* Read chip variant */
-	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
-	if (msb < 0)
-		return dev_err_probe(&client->dev, msb, "failed to read the chip id at 0x%x\n",
-				     RK808_ID_MSB);
-
-	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
-	if (lsb < 0)
-		return dev_err_probe(&client->dev, lsb, "failed to read the chip id at 0x%x\n",
-				     RK808_ID_LSB);
-
-	rk808->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
-	dev_info(&client->dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
+	rk808->dev = dev;
+	rk808->variant = variant;
+	rk808->regmap = regmap;
+	dev_set_drvdata(dev, rk808);
 
 	switch (rk808->variant) {
 	case RK805_ID:
-		rk808->regmap_cfg = &rk805_regmap_config;
 		rk808->regmap_irq_chip = &rk805_irq_chip;
 		pre_init_reg = rk805_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
@@ -672,7 +556,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_cells = ARRAY_SIZE(rk805s);
 		break;
 	case RK808_ID:
-		rk808->regmap_cfg = &rk808_regmap_config;
 		rk808->regmap_irq_chip = &rk808_irq_chip;
 		pre_init_reg = rk808_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
@@ -680,7 +563,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_cells = ARRAY_SIZE(rk808s);
 		break;
 	case RK818_ID:
-		rk808->regmap_cfg = &rk818_regmap_config;
 		rk808->regmap_irq_chip = &rk818_irq_chip;
 		pre_init_reg = rk818_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
@@ -689,7 +571,6 @@ static int rk808_probe(struct i2c_client *client,
 		break;
 	case RK809_ID:
 	case RK817_ID:
-		rk808->regmap_cfg = &rk817_regmap_config;
 		rk808->regmap_irq_chip = &rk817_irq_chip;
 		pre_init_reg = rk817_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
@@ -697,27 +578,20 @@ static int rk808_probe(struct i2c_client *client,
 		nr_cells = ARRAY_SIZE(rk817s);
 		break;
 	default:
-		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
-			rk808->variant);
+		dev_err(dev, "Unsupported RK8XX ID %lu\n", rk808->variant);
 		return -EINVAL;
 	}
 
-	rk808->dev = &client->dev;
-	i2c_set_clientdata(client, rk808);
+	dev_info(dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
 
-	rk808->regmap = devm_regmap_init_i2c(client, rk808->regmap_cfg);
-	if (IS_ERR(rk808->regmap))
-		return dev_err_probe(&client->dev, PTR_ERR(rk808->regmap),
-				     "regmap initialization failed\n");
+	if (!irq)
+		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
 
-	if (!client->irq)
-		return dev_err_probe(&client->dev, -EINVAL, "No interrupt support, no core IRQ\n");
-
-	ret = devm_regmap_add_irq_chip(&client->dev, rk808->regmap, client->irq,
+	ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
 				       IRQF_ONESHOT, -1,
 				       rk808->regmap_irq_chip, &rk808->irq_data);
 	if (ret)
-		return dev_err_probe(&client->dev, ret, "Failed to add irq_chip\n");
+		return dev_err_probe(dev, ret, "Failed to add irq_chip\n");
 
 	for (i = 0; i < nr_pre_init_regs; i++) {
 		ret = regmap_update_bits(rk808->regmap,
@@ -725,45 +599,46 @@ static int rk808_probe(struct i2c_client *client,
 					pre_init_reg[i].mask,
 					pre_init_reg[i].value);
 		if (ret)
-			return dev_err_probe(&client->dev, ret, "0x%x write err\n",
+			return dev_err_probe(dev, ret, "0x%x write err\n",
 					     pre_init_reg[i].addr);
 	}
 
-	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 			      cells, nr_cells, NULL, 0,
 			      regmap_irq_get_domain(rk808->irq_data));
 	if (ret)
-		return dev_err_probe(&client->dev, ret, "failed to add MFD devices\n");
+		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
 
-	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
-		ret = devm_register_sys_off_handler(&client->dev,
+	if (device_property_read_bool(dev, "rockchip,system-power-controller")) {
+		ret = devm_register_sys_off_handler(dev,
 				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
 				    &rk808_power_off, rk808);
 		if (ret)
-			return dev_err_probe(&client->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "failed to register poweroff handler\n");
 
 		switch (rk808->variant) {
 		case RK809_ID:
 		case RK817_ID:
-			ret = devm_register_sys_off_handler(&client->dev,
+			ret = devm_register_sys_off_handler(dev,
 							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
 							    &rk808_restart, rk808);
 			if (ret)
-				dev_warn(&client->dev, "failed to register rst handler, %d\n", ret);
+				dev_warn(dev, "failed to register rst handler, %d\n", ret);
 			break;
 		default:
-			dev_dbg(&client->dev, "pmic controlled board reset not supported\n");
+			dev_dbg(dev, "pmic controlled board reset not supported\n");
 			break;
 		}
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rk8xx_probe);
 
-static int __maybe_unused rk8xx_suspend(struct device *dev)
+int rk8xx_suspend(struct device *dev)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(to_i2c_client(dev));
+	struct rk808 *rk808 = dev_get_drvdata(dev);
 	int ret = 0;
 
 	switch (rk808->variant) {
@@ -786,10 +661,11 @@ static int __maybe_unused rk8xx_suspend(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(rk8xx_suspend);
 
-static int __maybe_unused rk8xx_resume(struct device *dev)
+int rk8xx_resume(struct device *dev)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(to_i2c_client(dev));
+	struct rk808 *rk808 = dev_get_drvdata(dev);
 	int ret = 0;
 
 	switch (rk808->variant) {
@@ -806,22 +682,10 @@ static int __maybe_unused rk8xx_resume(struct device *dev)
 
 	return ret;
 }
-static SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
-
-static struct i2c_driver rk808_i2c_driver = {
-	.driver = {
-		.name = "rk808",
-		.of_match_table = rk808_of_match,
-		.pm = &rk8xx_pm_ops,
-	},
-	.probe    = rk808_probe,
-	.shutdown = rk8xx_shutdown,
-};
-
-module_i2c_driver(rk808_i2c_driver);
+EXPORT_SYMBOL_GPL(rk8xx_resume);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
 MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
-MODULE_DESCRIPTION("RK808/RK818 PMIC driver");
+MODULE_DESCRIPTION("RK8xx PMIC core");
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
new file mode 100644
index 000000000000..aeb27afaad88
--- /dev/null
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MFD i2c driver for Rockchip RK808/RK818
+ *
+ * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Author: Chris Zhong <zyw@rock-chips.com>
+ * Author: Zhang Qing <zhangqing@rock-chips.com>
+ *
+ * Copyright (C) 2016 PHYTEC Messtechnik GmbH
+ *
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+#include <linux/i2c.h>
+#include <linux/mfd/rk808.h>
+
+static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Notes:
+	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
+	 *   we don't use that feature.  It's better to cache.
+	 * - It's unlikely we care that RK808_DEVCTRL_REG is volatile since
+	 *   bits are cleared in case when we shutoff anyway, but better safe.
+	 */
+
+	switch (reg) {
+	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
+	case RK808_RTC_STATUS_REG:
+	case RK808_VB_MON_REG:
+	case RK808_THERMAL_REG:
+	case RK808_DCDC_UV_STS_REG:
+	case RK808_LDO_UV_STS_REG:
+	case RK808_DCDC_PG_REG:
+	case RK808_LDO_PG_REG:
+	case RK808_DEVCTRL_REG:
+	case RK808_INT_STS_REG1:
+	case RK808_INT_STS_REG2:
+		return true;
+	}
+
+	return false;
+}
+
+static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Notes:
+	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
+	 *   we don't use that feature.  It's better to cache.
+	 */
+
+	switch (reg) {
+	case RK817_SECONDS_REG ... RK817_WEEKS_REG:
+	case RK817_RTC_STATUS_REG:
+	case RK817_CODEC_DTOP_LPT_SRST:
+	case RK817_INT_STS_REG0:
+	case RK817_INT_STS_REG1:
+	case RK817_INT_STS_REG2:
+	case RK817_SYS_STS:
+		return true;
+	}
+
+	return true;
+}
+
+static const struct regmap_config rk818_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK818_USB_CTRL_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = rk808_is_volatile_reg,
+};
+
+static const struct regmap_config rk805_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK805_OFF_SOURCE_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = rk808_is_volatile_reg,
+};
+
+static const struct regmap_config rk808_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK808_IO_POL_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = rk808_is_volatile_reg,
+};
+
+static const struct regmap_config rk817_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK817_GPIO_INT_CFG,
+	.cache_type = REGCACHE_NONE,
+	.volatile_reg = rk817_is_volatile_reg,
+};
+
+static int rk8xx_i2c_get_variant(struct i2c_client *client)
+{
+	u8 pmic_id_msb, pmic_id_lsb;
+	int msb, lsb;
+
+	if (of_device_is_compatible(client->dev.of_node, "rockchip,rk817") ||
+	    of_device_is_compatible(client->dev.of_node, "rockchip,rk809")) {
+		pmic_id_msb = RK817_ID_MSB;
+		pmic_id_lsb = RK817_ID_LSB;
+	} else {
+		pmic_id_msb = RK808_ID_MSB;
+		pmic_id_lsb = RK808_ID_LSB;
+	}
+
+	/* Read chip variant */
+	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
+	if (msb < 0)
+		return dev_err_probe(&client->dev, msb, "failed to read the chip id at 0x%x\n",
+				     pmic_id_msb);
+
+	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
+	if (lsb < 0)
+		return dev_err_probe(&client->dev, lsb, "failed to read the chip id at 0x%x\n",
+				     pmic_id_lsb);
+
+	return ((msb << 8) | lsb) & RK8XX_ID_MSK;
+}
+
+static int rk8xx_i2c_probe(struct i2c_client *client)
+{
+	const struct regmap_config *regmap_cfg;
+	struct regmap *regmap;
+	int variant;
+
+	variant = rk8xx_i2c_get_variant(client);
+	if (variant < 0)
+		return variant;
+
+	switch (variant) {
+	case RK805_ID:
+		regmap_cfg = &rk805_regmap_config;
+		break;
+	case RK808_ID:
+		regmap_cfg = &rk808_regmap_config;
+		break;
+	case RK818_ID:
+		regmap_cfg = &rk818_regmap_config;
+		break;
+	case RK809_ID:
+	case RK817_ID:
+		regmap_cfg = &rk817_regmap_config;
+		break;
+	default:
+		return dev_err_probe(&client->dev, -EINVAL, "Unsupported RK8XX ID %x\n", variant);
+	}
+
+	regmap = devm_regmap_init_i2c(client, regmap_cfg);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "regmap initialization failed\n");
+
+	return rk8xx_probe(&client->dev, variant, client->irq, regmap);
+}
+
+static void rk8xx_i2c_shutdown(struct i2c_client *client)
+{
+	rk8xx_shutdown(&client->dev);
+}
+
+static int __maybe_unused rk8xx_i2c_suspend(struct device *dev)
+{
+	return rk8xx_suspend(dev);
+}
+
+static int __maybe_unused rk8xx_i2c_resume(struct device *dev)
+{
+	return rk8xx_resume(dev);
+}
+static SIMPLE_DEV_PM_OPS(rk8xx_i2c_pm_ops, rk8xx_i2c_suspend, rk8xx_i2c_resume);
+
+static const struct of_device_id rk8xx_i2c_of_match[] = {
+	{ .compatible = "rockchip,rk805" },
+	{ .compatible = "rockchip,rk808" },
+	{ .compatible = "rockchip,rk809" },
+	{ .compatible = "rockchip,rk817" },
+	{ .compatible = "rockchip,rk818" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rk8xx_i2c_of_match);
+
+static struct i2c_driver rk8xx_i2c_driver = {
+	.driver = {
+		.name = "rk8xx-i2c",
+		.of_match_table = rk8xx_i2c_of_match,
+		.pm = &rk8xx_i2c_pm_ops,
+	},
+	.probe_new = rk8xx_i2c_probe,
+	.shutdown  = rk8xx_i2c_shutdown,
+};
+module_i2c_driver(rk8xx_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
+MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
+MODULE_DESCRIPTION("RK8xx I2C PMIC driver");
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 9937b068fa82..c5ddfb0e5353 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -703,4 +703,10 @@ struct rk808 {
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
 };
+
+void rk8xx_shutdown(struct device *dev);
+int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap);
+int rk8xx_suspend(struct device *dev);
+int rk8xx_resume(struct device *dev);
+
 #endif /* __LINUX_REGULATOR_RK808_H */
-- 
2.35.1

