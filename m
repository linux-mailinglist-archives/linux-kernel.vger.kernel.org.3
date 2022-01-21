Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0FC495B42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379217AbiAUH4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:56:08 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:55554 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379189AbiAUH4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:56:01 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24938:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 21 Jan 2022 15:53:24 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v8 04/10] reset: Add Sunplus SP7021 reset driver
Date:   Fri, 21 Jan 2022 15:53:12 +0800
Message-Id: <d962524ec4379482740caa45fc7605747de3b4b1.1642751015.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1642751015.git.qinjian@cqplus1.com>
References: <cover.1642751015.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset driver for Sunplus SP7021 SoC.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                   |   1 +
 drivers/reset/Kconfig         |   9 +++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-sunplus.c | 130 ++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 drivers/reset/reset-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 652f42cab..6caffd6d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2662,6 +2662,7 @@ S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/reset/sp-sp7021.h
 
 ARM/Synaptics SoC support
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index be799a5ab..fb14456a8 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -224,6 +224,15 @@ config RESET_SOCFPGA
 	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
 	  driver gets initialized early during platform init calls.
 
+config RESET_SUNPLUS
+	bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
+	default ARCH_SUNPLUS
+	help
+	  This enables the reset driver support for Sunplus SoCs.
+	  The reset lines that can be asserted and deasserted by toggling bits
+	  in a contiguous, exclusive register space. The register is HIWORD_MASKED,
+	  which means each register hold 16 reset lines.
+
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
 	default ARCH_SUNXI
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 21d46d886..f03403e97 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
+obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
diff --git a/drivers/reset/reset-sunplus.c b/drivers/reset/reset-sunplus.c
new file mode 100644
index 000000000..113b36b57
--- /dev/null
+++ b/drivers/reset/reset-sunplus.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * SP7021 reset driver
+ *
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/reboot.h>
+
+/* HIWORD_MASK_REG BITS */
+#define BITS_PER_HWM_REG	16
+
+struct sp_reset {
+	struct reset_controller_dev rcdev;
+	struct notifier_block notifier;
+	void __iomem *base;
+};
+
+static inline struct sp_reset *to_sp_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct sp_reset, rcdev);
+}
+
+static int sp_reset_update(struct reset_controller_dev *rcdev,
+			   unsigned long id, bool assert)
+{
+	struct sp_reset *reset = to_sp_reset(rcdev);
+	int index = id / BITS_PER_HWM_REG;
+	int shift = id % BITS_PER_HWM_REG;
+	u32 val;
+
+	val = (1 << (16 + shift)) | (assert << shift);
+	writel(val, reset->base + (index * 4));
+
+	return 0;
+}
+
+static int sp_reset_assert(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	return sp_reset_update(rcdev, id, true);
+}
+
+static int sp_reset_deassert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	return sp_reset_update(rcdev, id, false);
+}
+
+static int sp_reset_status(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	struct sp_reset *reset = to_sp_reset(rcdev);
+	int index = id / BITS_PER_HWM_REG;
+	int shift = id % BITS_PER_HWM_REG;
+	u32 reg;
+
+	reg = readl(reset->base + (index * 4));
+
+	return !!(reg & BIT(shift));
+}
+
+static const struct reset_control_ops sp_reset_ops = {
+	.assert   = sp_reset_assert,
+	.deassert = sp_reset_deassert,
+	.status   = sp_reset_status,
+};
+
+static int sp_restart(struct notifier_block *nb, unsigned long mode,
+		      void *cmd)
+{
+	struct sp_reset *reset = container_of(nb, struct sp_reset, notifier);
+
+	sp_reset_assert(&reset->rcdev, 0);
+	sp_reset_deassert(&reset->rcdev, 0);
+
+	return NOTIFY_DONE;
+}
+
+static int sp_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sp_reset *reset;
+	struct resource *res;
+	int ret;
+
+	reset = devm_kzalloc(dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reset->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reset->base))
+		return PTR_ERR(reset->base);
+
+	reset->rcdev.ops = &sp_reset_ops;
+	reset->rcdev.owner = THIS_MODULE;
+	reset->rcdev.of_node = dev->of_node;
+	reset->rcdev.nr_resets = resource_size(res) / 4 * BITS_PER_HWM_REG;
+
+	ret = devm_reset_controller_register(dev, &reset->rcdev);
+	if (ret)
+		return ret;
+
+	reset->notifier.notifier_call = sp_restart;
+	reset->notifier.priority = 192;
+
+	return register_restart_handler(&reset->notifier);
+}
+
+static const struct of_device_id sp_reset_dt_ids[] = {
+	{.compatible = "sunplus,sp7021-reset",},
+	{ /* sentinel */ },
+};
+
+static struct platform_driver sp_reset_driver = {
+	.probe = sp_reset_probe,
+	.driver = {
+		.name			= "sunplus-reset",
+		.of_match_table		= sp_reset_dt_ids,
+		.suppress_bind_attrs	= true,
+	},
+};
+builtin_platform_driver(sp_reset_driver);
-- 
2.33.1

