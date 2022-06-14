Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A254AC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355690AbiFNIpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242341AbiFNIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:44:26 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A04A1080
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:44:02 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(29251:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 14 Jun 2022 16:31:19 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     sboyd@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v18 03/10] reset: Add Sunplus SP7021 reset driver
Date:   Tue, 14 Jun 2022 16:31:02 +0800
Message-Id: <06ac69143ce8c98b4f95e38238e1880953dc9040.1655194858.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1655194858.git.qinjian@cqplus1.com>
References: <cover.1655194858.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset driver for Sunplus SP7021 SoC.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                   |   1 +
 drivers/reset/Kconfig         |   9 ++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-sunplus.c | 212 ++++++++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 drivers/reset/reset-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c13a89373..5e352bb97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2812,6 +2812,7 @@ S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/reset/sunplus,sp7021-reset.h
 
 ARM/Synaptics SoC support
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index b496028b6..e6540036b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -231,6 +231,15 @@ config RESET_STARFIVE_JH7100
 	help
 	  This enables the reset controller driver for the StarFive JH7100 SoC.
 
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
index a80a9c400..3ff378f43 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
+obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
diff --git a/drivers/reset/reset-sunplus.c b/drivers/reset/reset-sunplus.c
new file mode 100644
index 000000000..2f23ecaa7
--- /dev/null
+++ b/drivers/reset/reset-sunplus.c
@@ -0,0 +1,212 @@
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
+/* resets HW info: reg_index_shift */
+static const u32 sp_resets[] = {
+/* SP7021: mo_reset0 ~ mo_reset9 */
+	0x00,
+	0x02,
+	0x03,
+	0x04,
+	0x05,
+	0x06,
+	0x07,
+	0x08,
+	0x09,
+	0x0a,
+	0x0b,
+	0x0d,
+	0x0e,
+	0x0f,
+	0x10,
+	0x12,
+	0x14,
+	0x15,
+	0x16,
+	0x17,
+	0x18,
+	0x19,
+	0x1a,
+	0x1b,
+	0x1c,
+	0x1d,
+	0x1e,
+	0x1f,
+	0x20,
+	0x21,
+	0x22,
+	0x23,
+	0x24,
+	0x25,
+	0x26,
+	0x2a,
+	0x2b,
+	0x2d,
+	0x2e,
+	0x30,
+	0x31,
+	0x32,
+	0x33,
+	0x3d,
+	0x3e,
+	0x3f,
+	0x42,
+	0x44,
+	0x4b,
+	0x4c,
+	0x4d,
+	0x4e,
+	0x4f,
+	0x50,
+	0x55,
+	0x60,
+	0x61,
+	0x6a,
+	0x6f,
+	0x70,
+	0x73,
+	0x74,
+	0x86,
+	0x8a,
+	0x8b,
+	0x8d,
+	0x8e,
+	0x8f,
+	0x90,
+	0x92,
+	0x93,
+	0x94,
+	0x95,
+	0x96,
+	0x97,
+	0x98,
+	0x99,
+};
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
+	int index = sp_resets[id] / BITS_PER_HWM_REG;
+	int shift = sp_resets[id] % BITS_PER_HWM_REG;
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
+	int index = sp_resets[id] / BITS_PER_HWM_REG;
+	int shift = sp_resets[id] % BITS_PER_HWM_REG;
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

