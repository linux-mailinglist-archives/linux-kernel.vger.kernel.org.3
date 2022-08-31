Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774935A88A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiHaV4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiHaVy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:54:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7A25FAD;
        Wed, 31 Aug 2022 14:54:54 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-057-024.ewe-ip-backbone.de [91.96.57.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A0406601E58;
        Wed, 31 Aug 2022 22:54:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661982887;
        bh=8stJgy1VPCfU5DVw17GhITOy/49LFnJuLhhIki2x9VQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+GunE7vgHdB8O9flcRAfMfetuOHnIrrVnmRlx9S05rw+Fpz7VxCe6g8bY+zoYsPs
         Fj5g8PEpEdUZuOpDm1WUAHHbBmpAkLYrAsutyZe3s4JVagOZQHyoMgYMSZLjSv0j4t
         jQn82mb4LPuQtmCzux9HsvZH3rwUJ8nTsCDEgbfE+JjWaR4/lwkih3AE+DubEdL8VF
         8MnIS3XfEQ1IsCg4SLI6B/S41drd+t/CaI3EPxG62WJsIgO0WIQ5ZZZb/1ibIde72o
         atZrdKlbLPTvsYsK12/GjmdhPu4Sry+g6zmM+SWwzR50N2xQJfNViyxJa0/asY99ra
         1qCUKlKwCNglQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 423FE481223; Wed, 31 Aug 2022 23:54:43 +0200 (CEST)
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
Subject: [PATCH 09/13] mfd: rk8xx: add rk806 support
Date:   Wed, 31 Aug 2022 23:54:33 +0200
Message-Id: <20220831215437.117880-10-sebastian.reichel@collabora.com>
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

Add support for SPI connected rk806, which is used by the RK3588
evaluation boards. The PMIC is advertised to support I2C and SPI,
but the evaluation boards all use SPI. Thus only SPI support is
added here.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/Kconfig       |  14 ++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/rk8xx-core.c  |  67 ++++++-
 drivers/mfd/rk8xx-spi.c   | 128 ++++++++++++
 include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 617 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mfd/rk8xx-spi.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index acb7133d6db6..e300727b4006 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1160,6 +1160,20 @@ config MFD_RK8XX_I2C
 	  through I2C interface. The device supports multiple sub-devices
 	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
 
+config MFD_RK8XX_SPI
+	tristate "Rockchip RK806 Power Management Chip"
+	depends on SPI && OF
+	select MFD_CORE
+	select REGMAP_SPI
+	select REGMAP_IRQ
+	select MFD_RK808
+	help
+	  If you say yes here you get support for the RK806 Power Management
+	  chips.
+	  This driver provides common support for accessing the device
+	  through SPI interface. The device supports multiple sub-devices
+	  including interrupts, LDO & DCDC regulators, and onkey.
+
 config MFD_RN5T618
 	tristate "Ricoh RN5T567/618 PMIC"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 25ac617a5e6b..e67d8d36d8a0 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -217,6 +217,7 @@ obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
 obj-$(CONFIG_MFD_RK808)		+= rk8xx-core.o
 obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
+obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
 obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
 obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
 obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index d0ce17d98fdc..8ba2416178a9 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -39,6 +39,11 @@ static const struct resource rk805_key_resources[] = {
 	DEFINE_RES_IRQ(RK805_IRQ_PWRON_FALL),
 };
 
+static struct resource rk806_pwrkey_resources[] = {
+	DEFINE_RES_IRQ(RK806_IRQ_PWRON_FALL),
+	DEFINE_RES_IRQ(RK806_IRQ_PWRON_RISE),
+};
+
 static const struct resource rk817_pwrkey_resources[] = {
 	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
 	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
@@ -59,6 +64,16 @@ static const struct mfd_cell rk805s[] = {
 	},
 };
 
+static const struct mfd_cell rk806s[] = {
+	{ .name = "rk805-pinctrl", },
+	{
+		.name = "rk805-pwrkey",
+		.num_resources = ARRAY_SIZE(rk806_pwrkey_resources),
+		.resources = &rk806_pwrkey_resources[0],
+	},
+	{ .name = "rk808-regulator", },
+};
+
 static const struct mfd_cell rk808s[] = {
 	{ .name = "rk808-clkout", },
 	{ .name = "rk808-regulator", },
@@ -108,6 +123,12 @@ static const struct rk808_reg_data rk805_pre_init_reg[] = {
 	{RK805_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP115C},
 };
 
+static const struct rk808_reg_data rk806_pre_init_reg[] = {
+	{RK806_GPIO_INT_CONFIG, RK806_INT_POL_MSK, RK806_INT_POL_L},
+	{RK806_SYS_CFG3, RK806_SLAVE_RESTART_FUN_MSK, RK806_SLAVE_RESTART_FUN_EN},
+	{RK806_SYS_OPTION, RK806_SYS_ENB2_2M_MSK, RK806_SYS_ENB2_2M_EN},
+};
+
 static const struct rk808_reg_data rk808_pre_init_reg[] = {
 	{ RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA },
 	{ RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA },
@@ -258,6 +279,27 @@ static const struct regmap_irq rk805_irqs[] = {
 	},
 };
 
+static const struct regmap_irq rk806_irqs[] = {
+	/* INT_STS0 IRQs */
+	REGMAP_IRQ_REG(RK806_IRQ_PWRON_FALL, 0, RK806_INT_STS_PWRON_FALL),
+	REGMAP_IRQ_REG(RK806_IRQ_PWRON_RISE, 0, RK806_INT_STS_PWRON_RISE),
+	REGMAP_IRQ_REG(RK806_IRQ_PWRON, 0, RK806_INT_STS_PWRON),
+	REGMAP_IRQ_REG(RK806_IRQ_PWRON_LP, 0, RK806_INT_STS_PWRON_LP),
+	REGMAP_IRQ_REG(RK806_IRQ_HOTDIE, 0, RK806_INT_STS_HOTDIE),
+	REGMAP_IRQ_REG(RK806_IRQ_VDC_RISE, 0, RK806_INT_STS_VDC_RISE),
+	REGMAP_IRQ_REG(RK806_IRQ_VDC_FALL, 0, RK806_INT_STS_VDC_FALL),
+	REGMAP_IRQ_REG(RK806_IRQ_VB_LO, 0, RK806_INT_STS_VB_LO),
+	/* INT_STS1 IRQs */
+	REGMAP_IRQ_REG(RK806_IRQ_REV0, 1, RK806_INT_STS_REV0),
+	REGMAP_IRQ_REG(RK806_IRQ_REV1, 1, RK806_INT_STS_REV1),
+	REGMAP_IRQ_REG(RK806_IRQ_REV2, 1, RK806_INT_STS_REV2),
+	REGMAP_IRQ_REG(RK806_IRQ_CRC_ERROR, 1, RK806_INT_STS_CRC_ERROR),
+	REGMAP_IRQ_REG(RK806_IRQ_SLP3_GPIO, 1, RK806_INT_STS_SLP3_GPIO),
+	REGMAP_IRQ_REG(RK806_IRQ_SLP2_GPIO, 1, RK806_INT_STS_SLP2_GPIO),
+	REGMAP_IRQ_REG(RK806_IRQ_SLP1_GPIO, 1, RK806_INT_STS_SLP1_GPIO),
+	REGMAP_IRQ_REG(RK806_IRQ_WDT, 1, RK806_INT_STS_WDT),
+};
+
 static const struct regmap_irq rk808_irqs[] = {
 	/* INT_STS */
 	[RK808_IRQ_VOUT_LO] = {
@@ -408,6 +450,18 @@ static struct regmap_irq_chip rk805_irq_chip = {
 	.init_ack_masked = true,
 };
 
+static struct regmap_irq_chip rk806_irq_chip = {
+	.name = "rk806",
+	.irqs = rk806_irqs,
+	.num_irqs = ARRAY_SIZE(rk806_irqs),
+	.num_regs = 2,
+	.irq_reg_stride = 2,
+	.mask_base = RK806_INT_MSK0,
+	.status_base = RK806_INT_STS0,
+	.ack_base = RK806_INT_STS0,
+	.init_ack_masked = true,
+};
+
 static const struct regmap_irq_chip rk808_irq_chip = {
 	.name = "rk808",
 	.irqs = rk808_irqs,
@@ -534,6 +588,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 	struct rk808 *rk808;
 	const struct rk808_reg_data *pre_init_reg;
 	const struct mfd_cell *cells;
+	bool dual_support = false;
 	int nr_pre_init_regs;
 	int nr_cells;
 	int ret;
@@ -555,6 +610,14 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 		cells = rk805s;
 		nr_cells = ARRAY_SIZE(rk805s);
 		break;
+	case RK806_ID:
+		rk808->regmap_irq_chip = &rk806_irq_chip;
+		pre_init_reg = rk806_pre_init_reg;
+		nr_pre_init_regs = ARRAY_SIZE(rk806_pre_init_reg);
+		cells = rk806s;
+		nr_cells = ARRAY_SIZE(rk806s);
+		dual_support = true;
+		break;
 	case RK808_ID:
 		rk808->regmap_irq_chip = &rk808_irq_chip;
 		pre_init_reg = rk808_pre_init_reg;
@@ -588,7 +651,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
 
 	ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
-				       IRQF_ONESHOT, -1,
+				       IRQF_ONESHOT | (dual_support ? IRQF_SHARED : 0), -1,
 				       rk808->regmap_irq_chip, &rk808->irq_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add irq_chip\n");
@@ -603,7 +666,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 					     pre_init_reg[i].addr);
 	}
 
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+	ret = devm_mfd_add_devices(dev, dual_support ? PLATFORM_DEVID_AUTO : PLATFORM_DEVID_NONE,
 			      cells, nr_cells, NULL, 0,
 			      regmap_irq_get_domain(rk808->irq_data));
 	if (ret)
diff --git a/drivers/mfd/rk8xx-spi.c b/drivers/mfd/rk8xx-spi.c
new file mode 100644
index 000000000000..82f150afb9fe
--- /dev/null
+++ b/drivers/mfd/rk8xx-spi.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MFD spi driver for Rockchip RK806
+ *
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ *
+ * Author: Xu Shengfei <xsf@rock-chips.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/rk808.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+static const struct regmap_range rk806_volatile_ranges[] = {
+	/* regmap_reg_range(RK806_INT_STS0, RK806_GPIO_INT_CONFIG), */
+	regmap_reg_range(RK806_POWER_EN0, RK806_POWER_EN5),
+	regmap_reg_range(0x70, 0x7a),
+};
+
+static const struct regmap_access_table rk806_volatile_table = {
+	.yes_ranges = rk806_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(rk806_volatile_ranges),
+};
+
+static const struct regmap_config rk806_regmap_config_spi = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_table = &rk806_volatile_table,
+};
+
+static int rk806_spi_bus_write(void *context, const void *data, size_t count)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+	const char *val = ((const char*) data) + 1;
+	char addr;
+	char buffer[4] = { 0 };
+
+	// TODO: support writing multiple values at once
+	if (count != 2) {
+		dev_err(&spi->dev, "regmap write err!\n");
+		return -EINVAL;
+	}
+
+	/* Copy address to read from into first element of SPI buffer. */
+	memcpy(&addr, data, sizeof(char));
+
+	buffer[0] = RK806_CMD_WRITE | (count - 2);
+	buffer[1] = addr;
+	buffer[2] = RK806_REG_H;
+	buffer[3] = val[0];
+
+	return spi_write(spi, &buffer, sizeof(buffer));
+}
+
+static int rk806_spi_bus_read(void *context,
+			      const void *reg,
+			      size_t reg_size,
+			      void *val,
+			      size_t val_size)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+	char addr;
+	char txbuf[3] = { 0 };
+
+	if (reg_size != sizeof(char) || val_size < 1)
+		return -EINVAL;
+
+	/* Copy address to read from into first element of SPI buffer. */
+	memcpy(&addr, reg, sizeof(char));
+
+	txbuf[0] = RK806_CMD_READ | (val_size - 1);
+	txbuf[1] = addr;
+	txbuf[2] = RK806_REG_H;
+
+	return spi_write_then_read(spi, txbuf, 3, val, val_size);
+}
+
+static const struct regmap_bus rk806_regmap_bus_spi = {
+	.write = rk806_spi_bus_write,
+	.read = rk806_spi_bus_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+static int rk8xx_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init(&spi->dev, &rk806_regmap_bus_spi,
+				  &spi->dev, &rk806_regmap_config_spi);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to initialize register map\n");
+
+	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap);
+}
+
+static const struct of_device_id rk8xx_spi_of_match[] = {
+	{ .compatible = "rockchip,rk806", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rk8xx_spi_of_match);
+
+static const struct spi_device_id rk8xx_spi_id_table[] = {
+	{ "rk806", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, rk8xx_spi_id_table);
+
+static struct spi_driver rk8xx_spi_driver = {
+	.driver		= {
+		.name	= "rk8xx-spi",
+		.of_match_table = rk8xx_spi_of_match,
+	},
+	.probe		= rk8xx_spi_probe,
+	.id_table	= rk8xx_spi_id_table,
+};
+module_spi_driver(rk8xx_spi_driver);
+
+MODULE_AUTHOR("Xu Shengfei <xsf@rock-chips.com>");
+MODULE_DESCRIPTION("RK8xx SPI PMIC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index c5ddfb0e5353..70f2ca745244 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -289,6 +289,414 @@ enum rk805_reg {
 #define RK805_INT_ALARM_EN		(1 << 3)
 #define RK805_INT_TIMER_EN		(1 << 2)
 
+/* RK806 */
+#define RK806_POWER_EN0			0x0
+#define RK806_POWER_EN1			0x1
+#define RK806_POWER_EN2			0x2
+#define RK806_POWER_EN3			0x3
+#define RK806_POWER_EN4			0x4
+#define RK806_POWER_EN5			0x5
+#define RK806_POWER_SLP_EN0		0x6
+#define RK806_POWER_SLP_EN1		0x7
+#define RK806_POWER_SLP_EN2		0x8
+#define RK806_POWER_DISCHRG_EN0		0x9
+#define RK806_POWER_DISCHRG_EN1		0xA
+#define RK806_POWER_DISCHRG_EN2		0xB
+#define RK806_BUCK_FB_CONFIG		0xC
+#define RK806_SLP_LP_CONFIG		0xD
+#define RK806_POWER_FPWM_EN0		0xE
+#define RK806_POWER_FPWM_EN1		0xF
+#define RK806_BUCK1_CONFIG		0x10
+#define RK806_BUCK2_CONFIG		0x11
+#define RK806_BUCK3_CONFIG		0x12
+#define RK806_BUCK4_CONFIG		0x13
+#define RK806_BUCK5_CONFIG		0x14
+#define RK806_BUCK6_CONFIG		0x15
+#define RK806_BUCK7_CONFIG		0x16
+#define RK806_BUCK8_CONFIG		0x17
+#define RK806_BUCK9_CONFIG		0x18
+#define RK806_BUCK10_CONFIG		0x19
+#define RK806_BUCK1_ON_VSEL		0x1A
+#define RK806_BUCK2_ON_VSEL		0x1B
+#define RK806_BUCK3_ON_VSEL		0x1C
+#define RK806_BUCK4_ON_VSEL		0x1D
+#define RK806_BUCK5_ON_VSEL		0x1E
+#define RK806_BUCK6_ON_VSEL		0x1F
+#define RK806_BUCK7_ON_VSEL		0x20
+#define RK806_BUCK8_ON_VSEL		0x21
+#define RK806_BUCK9_ON_VSEL		0x22
+#define RK806_BUCK10_ON_VSEL		0x23
+#define RK806_BUCK1_SLP_VSEL		0x24
+#define RK806_BUCK2_SLP_VSEL		0x25
+#define RK806_BUCK3_SLP_VSEL		0x26
+#define RK806_BUCK4_SLP_VSEL		0x27
+#define RK806_BUCK5_SLP_VSEL		0x28
+#define RK806_BUCK6_SLP_VSEL		0x29
+#define RK806_BUCK7_SLP_VSEL		0x2A
+#define RK806_BUCK8_SLP_VSEL		0x2B
+#define RK806_BUCK9_SLP_VSEL		0x2D
+#define RK806_BUCK10_SLP_VSEL		0x2E
+#define RK806_BUCK_DEBUG1		0x30
+#define RK806_BUCK_DEBUG2		0x31
+#define RK806_BUCK_DEBUG3		0x32
+#define RK806_BUCK_DEBUG4		0x33
+#define RK806_BUCK_DEBUG5		0x34
+#define RK806_BUCK_DEBUG6		0x35
+#define RK806_BUCK_DEBUG7		0x36
+#define RK806_BUCK_DEBUG8		0x37
+#define RK806_BUCK_DEBUG9		0x38
+#define RK806_BUCK_DEBUG10		0x39
+#define RK806_BUCK_DEBUG11		0x3A
+#define RK806_BUCK_DEBUG12		0x3B
+#define RK806_BUCK_DEBUG13		0x3C
+#define RK806_BUCK_DEBUG14		0x3D
+#define RK806_BUCK_DEBUG15		0x3E
+#define RK806_BUCK_DEBUG16		0x3F
+#define RK806_BUCK_DEBUG17		0x40
+#define RK806_BUCK_DEBUG18		0x41
+#define RK806_NLDO_IMAX			0x42
+#define RK806_NLDO1_ON_VSEL		0x43
+#define RK806_NLDO2_ON_VSEL		0x44
+#define RK806_NLDO3_ON_VSEL		0x45
+#define RK806_NLDO4_ON_VSEL		0x46
+#define RK806_NLDO5_ON_VSEL		0x47
+#define RK806_NLDO1_SLP_VSEL		0x48
+#define RK806_NLDO2_SLP_VSEL		0x49
+#define RK806_NLDO3_SLP_VSEL		0x4A
+#define RK806_NLDO4_SLP_VSEL		0x4B
+#define RK806_NLDO5_SLP_VSEL		0x4C
+#define RK806_PLDO_IMAX			0x4D
+#define RK806_PLDO1_ON_VSEL		0x4E
+#define RK806_PLDO2_ON_VSEL		0x4F
+#define RK806_PLDO3_ON_VSEL		0x50
+#define RK806_PLDO4_ON_VSEL		0x51
+#define RK806_PLDO5_ON_VSEL		0x52
+#define RK806_PLDO6_ON_VSEL		0x53
+#define RK806_PLDO1_SLP_VSEL		0x54
+#define RK806_PLDO2_SLP_VSEL		0x55
+#define RK806_PLDO3_SLP_VSEL		0x56
+#define RK806_PLDO4_SLP_VSEL		0x57
+#define RK806_PLDO5_SLP_VSEL		0x58
+#define RK806_PLDO6_SLP_VSEL		0x59
+#define RK806_CHIP_NAME			0x5A
+#define RK806_CHIP_VER			0x5B
+#define RK806_OTP_VER			0x5C
+#define RK806_SYS_STS			0x5D
+#define RK806_SYS_CFG0			0x5E
+#define RK806_SYS_CFG1			0x5F
+#define RK806_SYS_OPTION		0x61
+#define RK806_SLEEP_CONFIG0		0x62
+#define RK806_SLEEP_CONFIG1		0x63
+#define RK806_SLEEP_CTR_SEL0		0x64
+#define RK806_SLEEP_CTR_SEL1		0x65
+#define RK806_SLEEP_CTR_SEL2		0x66
+#define RK806_SLEEP_CTR_SEL3		0x67
+#define RK806_SLEEP_CTR_SEL4		0x68
+#define RK806_SLEEP_CTR_SEL5		0x69
+#define RK806_DVS_CTRL_SEL0		0x6A
+#define RK806_DVS_CTRL_SEL1		0x6B
+#define RK806_DVS_CTRL_SEL2		0x6C
+#define RK806_DVS_CTRL_SEL3		0x6D
+#define RK806_DVS_CTRL_SEL4		0x6E
+#define RK806_DVS_CTRL_SEL5		0x6F
+#define RK806_DVS_START_CTRL		0x70
+#define RK806_SLEEP_GPIO		0x71
+#define RK806_SYS_CFG3			0x72
+#define RK806_ON_SOURCE			0x74
+#define RK806_OFF_SOURCE		0x75
+#define RK806_PWRON_KEY			0x76
+#define RK806_INT_STS0			0x77
+#define RK806_INT_MSK0			0x78
+#define RK806_INT_STS1			0x79
+#define RK806_INT_MSK1			0x7A
+#define RK806_GPIO_INT_CONFIG		0x7B
+#define RK806_DATA_REG0			0x7C
+#define RK806_DATA_REG1			0x7D
+#define RK806_DATA_REG2			0x7E
+#define RK806_DATA_REG3			0x7F
+#define RK806_DATA_REG4			0x80
+#define RK806_DATA_REG5			0x81
+#define RK806_DATA_REG6			0x82
+#define RK806_DATA_REG7			0x83
+#define RK806_DATA_REG8			0x84
+#define RK806_DATA_REG9			0x85
+#define RK806_DATA_REG10		0x86
+#define RK806_DATA_REG11		0x87
+#define RK806_DATA_REG12		0x88
+#define RK806_DATA_REG13		0x89
+#define RK806_DATA_REG14		0x8A
+#define RK806_DATA_REG15		0x8B
+#define RK806_TM_REG			0x8C
+#define RK806_OTP_EN_REG		0x8D
+#define RK806_FUNC_OTP_EN_REG		0x8E
+#define RK806_TEST_REG1			0x8F
+#define RK806_TEST_REG2			0x90
+#define RK806_TEST_REG3			0x91
+#define RK806_TEST_REG4			0x92
+#define RK806_TEST_REG5			0x93
+#define RK806_BUCK_VSEL_OTP_REG0	0x94
+#define RK806_BUCK_VSEL_OTP_REG1	0x95
+#define RK806_BUCK_VSEL_OTP_REG2	0x96
+#define RK806_BUCK_VSEL_OTP_REG3	0x97
+#define RK806_BUCK_VSEL_OTP_REG4	0x98
+#define RK806_BUCK_VSEL_OTP_REG5	0x99
+#define RK806_BUCK_VSEL_OTP_REG6	0x9A
+#define RK806_BUCK_VSEL_OTP_REG7	0x9B
+#define RK806_BUCK_VSEL_OTP_REG8	0x9C
+#define RK806_BUCK_VSEL_OTP_REG9	0x9D
+#define RK806_NLDO1_VSEL_OTP_REG0	0x9E
+#define RK806_NLDO1_VSEL_OTP_REG1	0x9F
+#define RK806_NLDO1_VSEL_OTP_REG2	0xA0
+#define RK806_NLDO1_VSEL_OTP_REG3	0xA1
+#define RK806_NLDO1_VSEL_OTP_REG4	0xA2
+#define RK806_PLDO_VSEL_OTP_REG0	0xA3
+#define RK806_PLDO_VSEL_OTP_REG1	0xA4
+#define RK806_PLDO_VSEL_OTP_REG2	0xA5
+#define RK806_PLDO_VSEL_OTP_REG3	0xA6
+#define RK806_PLDO_VSEL_OTP_REG4	0xA7
+#define RK806_PLDO_VSEL_OTP_REG5	0xA8
+#define RK806_BUCK_EN_OTP_REG1		0xA9
+#define RK806_NLDO_EN_OTP_REG1		0xAA
+#define RK806_PLDO_EN_OTP_REG1		0xAB
+#define RK806_BUCK_FB_RES_OTP_REG1	0xAC
+#define RK806_OTP_RESEV_REG0		0xAD
+#define RK806_OTP_RESEV_REG1		0xAE
+#define RK806_OTP_RESEV_REG2		0xAF
+#define RK806_OTP_RESEV_REG3		0xB0
+#define RK806_OTP_RESEV_REG4		0xB1
+#define RK806_BUCK_SEQ_REG0		0xB2
+#define RK806_BUCK_SEQ_REG1		0xB3
+#define RK806_BUCK_SEQ_REG2		0xB4
+#define RK806_BUCK_SEQ_REG3		0xB5
+#define RK806_BUCK_SEQ_REG4		0xB6
+#define RK806_BUCK_SEQ_REG5		0xB7
+#define RK806_BUCK_SEQ_REG6		0xB8
+#define RK806_BUCK_SEQ_REG7		0xB9
+#define RK806_BUCK_SEQ_REG8		0xBA
+#define RK806_BUCK_SEQ_REG9		0xBB
+#define RK806_BUCK_SEQ_REG10		0xBC
+#define RK806_BUCK_SEQ_REG11		0xBD
+#define RK806_BUCK_SEQ_REG12		0xBE
+#define RK806_BUCK_SEQ_REG13		0xBF
+#define RK806_BUCK_SEQ_REG14		0xC0
+#define RK806_BUCK_SEQ_REG15		0xC1
+#define RK806_BUCK_SEQ_REG16		0xC2
+#define RK806_BUCK_SEQ_REG17		0xC3
+#define RK806_HK_TRIM_REG1		0xC4
+#define RK806_HK_TRIM_REG2		0xC5
+#define RK806_BUCK_REF_TRIM_REG1	0xC6
+#define RK806_BUCK_REF_TRIM_REG2	0xC7
+#define RK806_BUCK_REF_TRIM_REG3	0xC8
+#define RK806_BUCK_REF_TRIM_REG4	0xC9
+#define RK806_BUCK_REF_TRIM_REG5	0xCA
+#define RK806_BUCK_OSC_TRIM_REG1	0xCB
+#define RK806_BUCK_OSC_TRIM_REG2	0xCC
+#define RK806_BUCK_OSC_TRIM_REG3	0xCD
+#define RK806_BUCK_OSC_TRIM_REG4	0xCE
+#define RK806_BUCK_OSC_TRIM_REG5	0xCF
+#define RK806_BUCK_TRIM_ZCDIOS_REG1	0xD0
+#define RK806_BUCK_TRIM_ZCDIOS_REG2	0xD1
+#define RK806_NLDO_TRIM_REG1		0xD2
+#define RK806_NLDO_TRIM_REG2		0xD3
+#define RK806_NLDO_TRIM_REG3		0xD4
+#define RK806_PLDO_TRIM_REG1		0xD5
+#define RK806_PLDO_TRIM_REG2		0xD6
+#define RK806_PLDO_TRIM_REG3		0xD7
+#define RK806_TRIM_ICOMP_REG1		0xD8
+#define RK806_TRIM_ICOMP_REG2		0xD9
+#define RK806_EFUSE_CONTROL_REGH	0xDA
+#define RK806_FUSE_PROG_REG		0xDB
+#define RK806_MAIN_FSM_STS_REG		0xDD
+#define RK806_FSM_REG			0xDE
+#define RK806_TOP_RESEV_OFFR		0xEC
+#define RK806_TOP_RESEV_POR		0xED
+#define RK806_BUCK_VRSN_REG1		0xEE
+#define RK806_BUCK_VRSN_REG2		0xEF
+#define RK806_NLDO_RLOAD_SEL_REG1	0xF0
+#define RK806_PLDO_RLOAD_SEL_REG1	0xF1
+#define RK806_PLDO_RLOAD_SEL_REG2	0xF2
+#define RK806_BUCK_CMIN_MX_REG1		0xF3
+#define RK806_BUCK_CMIN_MX_REG2		0xF4
+#define RK806_BUCK_FREQ_SET_REG1	0xF5
+#define RK806_BUCK_FREQ_SET_REG2	0xF6
+#define RK806_BUCK_RS_MEABS_REG1	0xF7
+#define RK806_BUCK_RS_MEABS_REG2	0xF8
+#define RK806_BUCK_RS_ZDLEB_REG1	0xF9
+#define RK806_BUCK_RS_ZDLEB_REG2	0xFA
+#define RK806_BUCK_RSERVE_REG1		0xFB
+#define RK806_BUCK_RSERVE_REG2		0xFC
+#define RK806_BUCK_RSERVE_REG3		0xFD
+#define RK806_BUCK_RSERVE_REG4		0xFE
+#define RK806_BUCK_RSERVE_REG5		0xFF
+
+/* INT_STS Register field definitions */
+#define RK806_INT_STS_PWRON_FALL	BIT(0)
+#define RK806_INT_STS_PWRON_RISE	BIT(1)
+#define RK806_INT_STS_PWRON		BIT(2)
+#define RK806_INT_STS_PWRON_LP		BIT(3)
+#define RK806_INT_STS_HOTDIE		BIT(4)
+#define RK806_INT_STS_VDC_RISE		BIT(5)
+#define RK806_INT_STS_VDC_FALL		BIT(6)
+#define RK806_INT_STS_VB_LO		BIT(7)
+#define RK806_INT_STS_REV0		BIT(0)
+#define RK806_INT_STS_REV1		BIT(1)
+#define RK806_INT_STS_REV2		BIT(2)
+#define RK806_INT_STS_CRC_ERROR		BIT(3)
+#define RK806_INT_STS_SLP3_GPIO		BIT(4)
+#define RK806_INT_STS_SLP2_GPIO		BIT(5)
+#define RK806_INT_STS_SLP1_GPIO		BIT(6)
+#define RK806_INT_STS_WDT		BIT(7)
+
+/* spi command */
+#define RK806_CMD_READ			0
+#define RK806_CMD_WRITE			BIT(7)
+#define RK806_CMD_CRC_EN		BIT(6)
+#define RK806_CMD_CRC_DIS		0
+#define RK806_CMD_LEN_MSK		0x0f
+#define RK806_REG_H			0x00
+
+#define VERSION_AB		0x01
+
+enum rk806_reg_id {
+	RK806_ID_DCDC1 = 0,
+	RK806_ID_DCDC2,
+	RK806_ID_DCDC3,
+	RK806_ID_DCDC4,
+	RK806_ID_DCDC5,
+	RK806_ID_DCDC6,
+	RK806_ID_DCDC7,
+	RK806_ID_DCDC8,
+	RK806_ID_DCDC9,
+	RK806_ID_DCDC10,
+
+	RK806_ID_NLDO1,
+	RK806_ID_NLDO2,
+	RK806_ID_NLDO3,
+	RK806_ID_NLDO4,
+	RK806_ID_NLDO5,
+
+	RK806_ID_PLDO1,
+	RK806_ID_PLDO2,
+	RK806_ID_PLDO3,
+	RK806_ID_PLDO4,
+	RK806_ID_PLDO5,
+	RK806_ID_PLDO6,
+	RK806_ID_END,
+};
+
+/* Define the rk806 IRQ numbers */
+enum rk806_irqs {
+	/* INT_STS0 registers */
+	RK806_IRQ_PWRON_FALL,
+	RK806_IRQ_PWRON_RISE,
+	RK806_IRQ_PWRON,
+	RK806_IRQ_PWRON_LP,
+	RK806_IRQ_HOTDIE,
+	RK806_IRQ_VDC_RISE,
+	RK806_IRQ_VDC_FALL,
+	RK806_IRQ_VB_LO,
+
+	/* INT_STS0 registers */
+	RK806_IRQ_REV0,
+	RK806_IRQ_REV1,
+	RK806_IRQ_REV2,
+	RK806_IRQ_CRC_ERROR,
+	RK806_IRQ_SLP3_GPIO,
+	RK806_IRQ_SLP2_GPIO,
+	RK806_IRQ_SLP1_GPIO,
+	RK806_IRQ_WDT,
+};
+
+/* VCC1 low voltage threshold */
+enum rk806_lv_sel {
+	VB_LO_SEL_2800,
+	VB_LO_SEL_2900,
+	VB_LO_SEL_3000,
+	VB_LO_SEL_3100,
+	VB_LO_SEL_3200,
+	VB_LO_SEL_3300,
+	VB_LO_SEL_3400,
+	VB_LO_SEL_3500,
+};
+
+/* system shut down voltage select */
+enum rk806_uv_sel {
+	VB_UV_SEL_2700,
+	VB_UV_SEL_2800,
+	VB_UV_SEL_2900,
+	VB_UV_SEL_3000,
+	VB_UV_SEL_3100,
+	VB_UV_SEL_3200,
+	VB_UV_SEL_3300,
+	VB_UV_SEL_3400,
+};
+
+/* pin function */
+enum rk806_pwrctrl_fun {
+	PWRCTRL_NULL_FUN,
+	PWRCTRL_SLP_FUN,
+	PWRCTRL_POWOFF_FUN,
+	PWRCTRL_RST_FUN,
+	PWRCTRL_DVS_FUN,
+	PWRCTRL_GPIO_FUN,
+};
+
+/* pin pol */
+enum rk806_pin_level {
+	POL_LOW,
+	POL_HIGH,
+};
+
+enum rk806_vsel_ctr_sel {
+	CTR_BY_NO_EFFECT,
+	CTR_BY_PWRCTRL1,
+	CTR_BY_PWRCTRL2,
+	CTR_BY_PWRCTRL3,
+};
+
+enum rk806_dvs_ctr_sel {
+	CTR_SEL_NO_EFFECT,
+	CTR_SEL_DVS_START1,
+	CTR_SEL_DVS_START2,
+	CTR_SEL_DVS_START3,
+};
+
+enum rk806_pin_dr_sel {
+	RK806_PIN_INPUT,
+	RK806_PIN_OUTPUT,
+};
+
+#define RK806_INT_POL_MSK		BIT(1)
+#define RK806_INT_POL_H			BIT(1)
+#define RK806_INT_POL_L			0
+
+#define RK806_SLAVE_RESTART_FUN_MSK	BIT(1)
+#define RK806_SLAVE_RESTART_FUN_EN	BIT(1)
+#define RK806_SLAVE_RESTART_FUN_OFF	0
+
+#define RK806_SYS_ENB2_2M_MSK		BIT(1)
+#define RK806_SYS_ENB2_2M_EN		BIT(1)
+#define RK806_SYS_ENB2_2M_OFF		0
+
+enum rk806_int_fun {
+	RK806_INT_ONLY,
+	RK806_INT_ADN_WKUP,
+};
+
+enum rk806_dvs_mode {
+	RK806_DVS_NOT_SUPPORT,
+	RK806_DVS_START1,
+	RK806_DVS_START2,
+	RK806_DVS_START3,
+	RK806_DVS_PWRCTRL1,
+	RK806_DVS_PWRCTRL2,
+	RK806_DVS_PWRCTRL3,
+	RK806_DVS_START_PWRCTR1,
+	RK806_DVS_START_PWRCTR2,
+	RK806_DVS_START_PWRCTR3,
+	RK806_DVS_END,
+};
+
 /* RK808 IRQ Definitions */
 #define RK808_IRQ_VOUT_LO	0
 #define RK808_IRQ_VB_LO		1
@@ -689,6 +1097,7 @@ enum {
 
 enum {
 	RK805_ID = 0x8050,
+	RK806_ID = 0x8060,
 	RK808_ID = 0x0000,
 	RK809_ID = 0x8090,
 	RK817_ID = 0x8170,
-- 
2.35.1

