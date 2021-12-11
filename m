Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D25947153D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhLKSBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:01:09 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60343 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhLKSAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:00:47 -0500
Received: from [77.244.183.192] (port=64660 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mw6fu-0009HU-6N; Sat, 11 Dec 2021 19:00:46 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 5/9] mfd: max77714: Add driver for Maxim MAX77714 PMIC
Date:   Sat, 11 Dec 2021 18:59:47 +0100
Message-Id: <20211211175951.30763-6-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211211175951.30763-1-luca@lucaceresoli.net>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple driver for the Maxim MAX77714 PMIC, supporting RTC and
watchdog only.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes in v5: none

Changes in v4: none

Changes in v3:
 - Suggested by Lee Jones:
   - move struct mfd_cell to top of file
   - remove struct max77714 and its kmalloc, not used after probe
   - reword error messages
   - add "/* pF */" onto the end of the load_cap line

Changes in v2:
 - fix "watchdog" word in heading comment (Guenter Roeck)
 - move struct max77714 to .c file (Krzysztof Kozlowski)
 - change include guard format (Krzysztof Kozlowski)
 - allow building as a module (Krzysztof Kozlowski)
 - remove of_match_ptr usage (Krzysztof Kozlowski / lkp)
   (Reported-by: kernel test robot <lkp@intel.com>)
---
 MAINTAINERS                  |   2 +
 drivers/mfd/Kconfig          |  14 ++++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/max77714.c       | 152 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77714.h |  60 ++++++++++++++
 5 files changed, 229 insertions(+)
 create mode 100644 drivers/mfd/max77714.c
 create mode 100644 include/linux/mfd/max77714.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a08f5167dfe0..ef3ffba828af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11586,6 +11586,8 @@ MAXIM MAX77714 PMIC MFD DRIVER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
+F:	drivers/mfd/max77714.c
+F:	include/linux/mfd/max77714.h
 
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3fb480818599..1b9d772bdae6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -855,6 +855,20 @@ config MFD_MAX77693
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_MAX77714
+	tristate "Maxim Semiconductor MAX77714 PMIC Support"
+	depends on I2C
+	depends on OF || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Say yes here to add support for Maxim Semiconductor MAX77714.
+	  This is a Power Management IC with 4 buck regulators, 9
+	  low-dropout regulators, 8 GPIOs, RTC, watchdog etc. This driver
+	  provides common support for accessing the device; additional
+	  drivers must be enabled in order to use each functionality of the
+	  device.
+
 config MFD_MAX77843
 	bool "Maxim Semiconductor MAX77843 PMIC Support"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 0b1b629aef3e..03115cf1336b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -162,6 +162,7 @@ obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
 obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
 obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
 obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
+obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
 obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
 obj-$(CONFIG_MFD_MAX8907)	+= max8907.o
 max8925-objs			:= max8925-core.o max8925-i2c.o
diff --git a/drivers/mfd/max77714.c b/drivers/mfd/max77714.c
new file mode 100644
index 000000000000..08dfb69bc6e8
--- /dev/null
+++ b/drivers/mfd/max77714.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Maxim MAX77714 MFD Driver
+ *
+ * Copyright (C) 2021 Luca Ceresoli
+ * Author: Luca Ceresoli <luca@lucaceresoli.net>
+ */
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max77714.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+static const struct mfd_cell max77714_cells[] = {
+	{ .name = "max77714-watchdog" },
+	{ .name = "max77714-rtc" },
+};
+
+static const struct regmap_range max77714_readable_ranges[] = {
+	regmap_reg_range(MAX77714_INT_TOP,     MAX77714_INT_TOP),
+	regmap_reg_range(MAX77714_INT_TOPM,    MAX77714_INT_TOPM),
+	regmap_reg_range(MAX77714_32K_STATUS,  MAX77714_32K_CONFIG),
+	regmap_reg_range(MAX77714_CNFG_GLBL2,  MAX77714_CNFG2_ONOFF),
+};
+
+static const struct regmap_range max77714_writable_ranges[] = {
+	regmap_reg_range(MAX77714_INT_TOPM,    MAX77714_INT_TOPM),
+	regmap_reg_range(MAX77714_32K_CONFIG,  MAX77714_32K_CONFIG),
+	regmap_reg_range(MAX77714_CNFG_GLBL2,  MAX77714_CNFG2_ONOFF),
+};
+
+static const struct regmap_access_table max77714_readable_table = {
+	.yes_ranges = max77714_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(max77714_readable_ranges),
+};
+
+static const struct regmap_access_table max77714_writable_table = {
+	.yes_ranges = max77714_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(max77714_writable_ranges),
+};
+
+static const struct regmap_config max77714_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77714_CNFG2_ONOFF,
+	.rd_table = &max77714_readable_table,
+	.wr_table = &max77714_writable_table,
+};
+
+static const struct regmap_irq max77714_top_irqs[] = {
+	REGMAP_IRQ_REG(MAX77714_IRQ_TOP_ONOFF,   0, MAX77714_INT_TOP_ONOFF),
+	REGMAP_IRQ_REG(MAX77714_IRQ_TOP_RTC,     0, MAX77714_INT_TOP_RTC),
+	REGMAP_IRQ_REG(MAX77714_IRQ_TOP_GPIO,    0, MAX77714_INT_TOP_GPIO),
+	REGMAP_IRQ_REG(MAX77714_IRQ_TOP_LDO,     0, MAX77714_INT_TOP_LDO),
+	REGMAP_IRQ_REG(MAX77714_IRQ_TOP_SD,      0, MAX77714_INT_TOP_SD),
+	REGMAP_IRQ_REG(MAX77714_IRQ_TOP_GLBL,    0, MAX77714_INT_TOP_GLBL),
+};
+
+static const struct regmap_irq_chip max77714_irq_chip = {
+	.name			= "max77714-pmic",
+	.status_base		= MAX77714_INT_TOP,
+	.mask_base		= MAX77714_INT_TOPM,
+	.num_regs		= 1,
+	.irqs			= max77714_top_irqs,
+	.num_irqs		= ARRAY_SIZE(max77714_top_irqs),
+};
+
+/*
+ * MAX77714 initially uses the internal, low precision oscillator. Enable
+ * the external oscillator by setting the XOSC_RETRY bit. If the external
+ * oscillator is not OK (probably not installed) this has no effect.
+ */
+static int max77714_setup_xosc(struct device *dev, struct regmap *regmap)
+{
+	/* Internal Crystal Load Capacitance, indexed by value of 32KLOAD bits */
+	static const unsigned int load_cap[4] = {0, 10, 12, 22}; /* pF */
+	unsigned int load_cap_idx;
+	unsigned int status;
+	int err;
+
+	err = regmap_update_bits(regmap, MAX77714_32K_CONFIG,
+				 MAX77714_32K_CONFIG_XOSC_RETRY,
+				 MAX77714_32K_CONFIG_XOSC_RETRY);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to configure the external oscillator\n");
+
+	err = regmap_read(regmap, MAX77714_32K_STATUS, &status);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to read external oscillator status\n");
+
+	load_cap_idx = (status >> MAX77714_32K_STATUS_32KLOAD_SHF)
+		& MAX77714_32K_STATUS_32KLOAD_MSK;
+
+	dev_info(dev, "Using %s oscillator, %d pF load cap\n",
+		 status & MAX77714_32K_STATUS_32KSOURCE ? "internal" : "external",
+		 load_cap[load_cap_idx]);
+
+	return 0;
+}
+
+static int max77714_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data;
+	int err;
+
+	regmap = devm_regmap_init_i2c(client, &max77714_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialise regmap\n");
+
+	err = max77714_setup_xosc(dev, regmap);
+	if (err)
+		return err;
+
+	err = devm_regmap_add_irq_chip(dev, regmap, client->irq,
+				       IRQF_ONESHOT | IRQF_SHARED, 0,
+				       &max77714_irq_chip, &irq_data);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to add PMIC IRQ chip\n");
+
+	err =  devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				    max77714_cells, ARRAY_SIZE(max77714_cells),
+				    NULL, 0, NULL);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register child devices\n");
+
+	return 0;
+}
+
+static const struct of_device_id max77714_dt_match[] = {
+	{ .compatible = "maxim,max77714" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, max77714_dt_match);
+
+static struct i2c_driver max77714_driver = {
+	.driver = {
+		.name = "max77714",
+		.of_match_table = max77714_dt_match,
+	},
+	.probe_new = max77714_probe,
+};
+module_i2c_driver(max77714_driver);
+
+MODULE_DESCRIPTION("Maxim MAX77714 MFD core driver");
+MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max77714.h b/include/linux/mfd/max77714.h
new file mode 100644
index 000000000000..4a274592d4f2
--- /dev/null
+++ b/include/linux/mfd/max77714.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Maxim MAX77714 Register and data structures definition.
+ *
+ * Copyright (C) 2021 Luca Ceresoli
+ * Author: Luca Ceresoli <luca@lucaceresoli.net>
+ */
+
+#ifndef __LINUX_MFD_MAX77714_H_
+#define __LINUX_MFD_MAX77714_H_
+
+#include <linux/bits.h>
+
+#define MAX77714_INT_TOP	0x00
+#define MAX77714_INT_TOPM	0x07 /* Datasheet says "read only", but it is RW */
+
+#define MAX77714_INT_TOP_ONOFF		BIT(1)
+#define MAX77714_INT_TOP_RTC		BIT(3)
+#define MAX77714_INT_TOP_GPIO		BIT(4)
+#define MAX77714_INT_TOP_LDO		BIT(5)
+#define MAX77714_INT_TOP_SD		BIT(6)
+#define MAX77714_INT_TOP_GLBL		BIT(7)
+
+#define MAX77714_32K_STATUS	0x30
+#define MAX77714_32K_STATUS_SIOSCOK	BIT(5)
+#define MAX77714_32K_STATUS_XOSCOK	BIT(4)
+#define MAX77714_32K_STATUS_32KSOURCE	BIT(3)
+#define MAX77714_32K_STATUS_32KLOAD_MSK	0x3
+#define MAX77714_32K_STATUS_32KLOAD_SHF	1
+#define MAX77714_32K_STATUS_CRYSTAL_CFG	BIT(0)
+
+#define MAX77714_32K_CONFIG	0x31
+#define MAX77714_32K_CONFIG_XOSC_RETRY	BIT(4)
+
+#define MAX77714_CNFG_GLBL2	0x91
+#define MAX77714_WDTEN			BIT(2)
+#define MAX77714_WDTSLPC		BIT(3)
+#define MAX77714_TWD_MASK		0x3
+#define MAX77714_TWD_2s			0x0
+#define MAX77714_TWD_16s		0x1
+#define MAX77714_TWD_64s		0x2
+#define MAX77714_TWD_128s		0x3
+
+#define MAX77714_CNFG_GLBL3	0x92
+#define MAX77714_WDTC			BIT(0)
+
+#define MAX77714_CNFG2_ONOFF	0x94
+#define MAX77714_WD_RST_WK		BIT(5)
+
+/* Interrupts */
+enum {
+	MAX77714_IRQ_TOP_ONOFF,
+	MAX77714_IRQ_TOP_RTC,		/* Real-time clock */
+	MAX77714_IRQ_TOP_GPIO,		/* GPIOs */
+	MAX77714_IRQ_TOP_LDO,		/* Low-dropout regulators */
+	MAX77714_IRQ_TOP_SD,		/* Step-down regulators */
+	MAX77714_IRQ_TOP_GLBL,		/* "Global resources": Low-Battery, overtemp... */
+};
+
+#endif /* __LINUX_MFD_MAX77714_H_ */
-- 
2.25.1

