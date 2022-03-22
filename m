Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33C04E38FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiCVG0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiCVGZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:25:34 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6699B2E9FE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:23:57 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7841:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 22 Mar 2022 14:16:34 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     krzysztof.kozlowski@canonical.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v11 3/9] reset: Add Sunplus SP7021 reset driver
Date:   Tue, 22 Mar 2022 14:16:54 +0800
Message-Id: <2169c1374170a7eb1a8176f5d158326436aa1293.1647928316.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1647928315.git.qinjian@cqplus1.com>
References: <cover.1647928315.git.qinjian@cqplus1.com>
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
 drivers/reset/Kconfig         |   9 +++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-sunplus.c | 130 ++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 drivers/reset/reset-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a8be86b25..26066f199 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2745,6 +2745,7 @@ S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/reset/sp-sp7021.h
 
 ARM/Synaptics SoC support
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 6f8ba0ddc..36825787e 100644
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
index bd0a97be1..cadc46d3e 100644
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

