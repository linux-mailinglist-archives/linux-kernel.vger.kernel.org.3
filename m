Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5505182C8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiECLAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiECLAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:00:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D409B33374;
        Tue,  3 May 2022 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651575404; x=1683111404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PMOy70RBNnBmgt8xSvufyb66sxT3XFCpnTYpkreXFjM=;
  b=moQ/4bz49L+DRDwRlPY/aU6VmgfgfcoHdBVzoyYC4ufHSuA9IzmLkyJW
   7znKrylz4+EUxfUbGSyPUIDkeOW1qvCGLUulb83p0nlzwgzBugFR9yjPZ
   iCMU8iVrDGEhxvvRkxZmvppD8AMKGKmNLxXVdsQwUnp5gW6SmbYkIpzwt
   u/bN/A3gf1APOGUCuXlhq9mMWsiKEj+7ZFD8W2OZLlsK5JaMlJlc3LfKf
   RxjEUtOt5fJivA7KzqDpwa4DM81xGQgfOziNHR9AciQK9VV3b95TW6jOG
   W1gvrKK9RqOC4oFGhiR6j+XJnYqRl44Oo7aQydu+OH6NgPwJupy8LMuCj
   w==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="171751051"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 03:56:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 03:56:44 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 03:56:39 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH 4/4] mux: lan966: Add support for flexcom mux controller
Date:   Tue, 3 May 2022 16:25:28 +0530
Message-ID: <20220503105528.12824-5-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966 SoC have 5 flexcoms. Each flexcom has 2 chip-selects.
For each chip select of each flexcom there is a configuration
register FLEXCOM_SHARED[0-4]:SS_MASK[0-1]. The width of
configuration register is 21 because there are 21 shared pins
on each of which the chip select can be mapped. Each bit of the
register represents a different FLEXCOM_SHARED pin.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 arch/arm/mach-at91/Kconfig  |   2 +
 drivers/mfd/atmel-flexcom.c |  55 ++++++++++++++++-
 drivers/mux/Kconfig         |  12 ++++
 drivers/mux/Makefile        |   2 +
 drivers/mux/lan966-flx.c    | 116 ++++++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mux/lan966-flx.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 279810381256..26fb0f4e1b79 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -74,6 +74,8 @@ config SOC_LAN966
 	select DW_APB_TIMER_OF
 	select ARM_GIC
 	select MEMORY
+	select MULTIPLEXER
+	select MUX_LAN966
 	help
 	  This enables support for ARMv7 based Microchip LAN966 SoC family.
 
diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 33caa4fba6af..cf3dac383f30 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
+#include <linux/mux/consumer.h>
 
 /* I/O register offsets */
 #define FLEX_MR		0x0	/* Mode Register */
@@ -28,6 +29,10 @@
 #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
 				 FLEX_MR_OPMODE_MASK)
 
+struct atmel_flex_caps {
+	bool has_flx_mux;
+};
+
 struct atmel_flexcom {
 	void __iomem *base;
 	u32 opmode;
@@ -37,6 +42,7 @@ struct atmel_flexcom {
 static int atmel_flexcom_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct atmel_flex_caps *caps;
 	struct resource *res;
 	struct atmel_flexcom *ddata;
 	int err;
@@ -76,13 +82,60 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
 	 */
 	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
 
+	caps = of_device_get_match_data(&pdev->dev);
+	if (!caps) {
+		dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
+		return -EINVAL;
+	}
+
+	/* Flexcom Mux */
+	if (caps->has_flx_mux && of_property_read_bool(np, "mux-controls")) {
+		struct mux_control *flx_mux;
+		struct of_phandle_args args;
+		int i, count;
+
+		flx_mux = devm_mux_control_get(&pdev->dev, NULL);
+		if (IS_ERR(flx_mux))
+			return PTR_ERR(flx_mux);
+
+		count = of_property_count_strings(np, "mux-control-names");
+		for (i = 0; i < count; i++) {
+			err = of_parse_phandle_with_fixed_args(np, "mux-controls", 1, i, &args);
+			if (err)
+				break;
+
+			err = mux_control_select(flx_mux, args.args[0]);
+			if (!err) {
+				mux_control_deselect(flx_mux);
+			} else {
+				dev_err(&pdev->dev, "Failed to select FLEXCOM mux\n");
+				return err;
+			}
+		}
+	}
+
 	clk_disable_unprepare(ddata->clk);
 
 	return devm_of_platform_populate(&pdev->dev);
 }
 
+static const struct atmel_flex_caps atmel_flexcom_caps = {};
+
+static const struct atmel_flex_caps lan966x_flexcom_caps = {
+	.has_flx_mux = true,
+};
+
 static const struct of_device_id atmel_flexcom_of_match[] = {
-	{ .compatible = "atmel,sama5d2-flexcom" },
+	{
+		.compatible = "atmel,sama5d2-flexcom",
+		.data = &atmel_flexcom_caps,
+	},
+
+	{
+		.compatible = "microchip,lan966-flexcom",
+		.data = &lan966x_flexcom_caps,
+	},
+
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index e5c571fd232c..ea09f474bc2f 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -45,6 +45,18 @@ config MUX_GPIO
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-gpio.
 
+config MUX_LAN966
+	tristate "LAN966 Flexcom multiplexer"
+	depends on OF || COMPILE_TEST
+	help
+	Lan966 Flexcom Multiplexer controller.
+
+	The driver supports mapping 2 chip-selects of each of the lan966
+	flexcoms to 21 flexcom shared pins.
+
+	To compile the driver as a module, choose M here: the module will
+	be called mux-lan966.
+
 config MUX_MMIO
 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
 	depends on OF || COMPILE_TEST
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index 6e9fa47daf56..53a9840d96fa 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -7,10 +7,12 @@ mux-core-objs			:= core.o
 mux-adg792a-objs		:= adg792a.o
 mux-adgs1408-objs		:= adgs1408.o
 mux-gpio-objs			:= gpio.o
+mux-lan966-objs			:= lan966-flx.o
 mux-mmio-objs			:= mmio.o
 
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
 obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
 obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
+obj-$(CONFIG_MUX_LAN966)	+= mux-lan966.o
 obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
diff --git a/drivers/mux/lan966-flx.c b/drivers/mux/lan966-flx.c
new file mode 100644
index 000000000000..5d078a159fcd
--- /dev/null
+++ b/drivers/mux/lan966-flx.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LAN966 Flexcom MUX driver
+ *
+ * Copyright (c) Microchip Inc.
+ *
+ * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/mux/driver.h>
+#include <linux/io.h>
+
+#define FLEX_SHRD_MASK		0x1FFFFF
+#define LAN966_MAX_CS		21
+
+static void __iomem *flx_shared_base;
+struct mux_lan966x {
+	u32 offset;
+	u32 ss_pin;
+};
+
+static int mux_lan966x_set(struct mux_control *mux, int state)
+{
+	struct mux_lan966x *mux_lan966x = mux_chip_priv(mux->chip);
+	u32 val;
+
+	val = ~(1 << mux_lan966x[state].ss_pin) & FLEX_SHRD_MASK;
+	writel(val, flx_shared_base + mux_lan966x[state].offset);
+
+	return 0;
+}
+
+static const struct mux_control_ops mux_lan966x_ops = {
+	.set = mux_lan966x_set,
+};
+
+static const struct of_device_id mux_lan966x_dt_ids[] = {
+	{ .compatible = "microchip,lan966-flx-mux", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mux_lan966x_dt_ids);
+
+static int mux_lan966x_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct mux_lan966x *mux_lan966x;
+	struct mux_chip *mux_chip;
+	int ret, num_fields, i;
+
+	ret = of_property_count_u32_elems(np, "mux-offset-pin");
+	if (ret == 0 || ret % 2)
+		ret = -EINVAL;
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "mux-offset-pin property missing or invalid");
+	num_fields = ret / 2;
+
+	mux_chip = devm_mux_chip_alloc(dev, num_fields, sizeof(*mux_lan966x));
+	if (IS_ERR(mux_chip))
+		return dev_err_probe(dev, PTR_ERR(mux_chip),
+				     "failed to allocate mux_chips\n");
+
+	mux_lan966x = mux_chip_priv(mux_chip);
+
+	flx_shared_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(flx_shared_base))
+		return dev_err_probe(dev, PTR_ERR(flx_shared_base),
+				     "failed to get flexcom shared base address\n");
+
+	for (i = 0; i < num_fields; i++) {
+		struct mux_control *mux = &mux_chip->mux[i];
+		u32 offset, shared_pin;
+
+		ret = of_property_read_u32_index(np, "mux-offset-pin",
+						 2 * i, &offset);
+		if (ret == 0)
+			ret = of_property_read_u32_index(np, "mux-offset-pin",
+							 2 * i + 1,
+							 &shared_pin);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "failed to read mux-offset-pin property: %d", i);
+
+		if (shared_pin >= LAN966_MAX_CS)
+			return -EINVAL;
+
+		mux_lan966x[i].offset = offset;
+		mux_lan966x[i].ss_pin = shared_pin;
+
+		mux->states = LAN966_MAX_CS;
+	}
+
+	mux_chip->ops = &mux_lan966x_ops;
+
+	ret = devm_mux_chip_register(dev, mux_chip);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver mux_lan966x_driver = {
+	.driver = {
+		.name = "lan966-mux",
+		.of_match_table	= of_match_ptr(mux_lan966x_dt_ids),
+	},
+	.probe = mux_lan966x_probe,
+};
+
+module_platform_driver(mux_lan966x_driver);
-- 
2.17.1

