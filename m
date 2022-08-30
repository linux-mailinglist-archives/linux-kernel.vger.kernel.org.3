Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170365A6409
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiH3Mx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiH3Mxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:53:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C48FCA2E;
        Tue, 30 Aug 2022 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661864011; x=1693400011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Af5JAEyadJZYsDa26MITcZUUd/oFSC8ZRLQM82MN5E=;
  b=CkXXCVqOHc/4sNhdN1DZ5qOoBNUb7QNgqwjK4FHRJ5cWOfvmxaAVe6LL
   j7+9lVt9KdVnogwYjDPWYnTyFKT/NeHInITjC/Sv3QOBG6N4rzMJfnSuD
   iE1C/77dKHnZm2W4VghedeEtHCPKuLTFMhFYtEr4pl9t3xkTSYKbx9xRB
   mnbxIotzsXQ3cte0ipZHO3QD9j3gJakxN3VcQr0GF/IpQtbQo8Fz6jYju
   TvKEqX8mT5QirVoyyraxlqKfBg/yc/6QMwkM0XOefFdfUZSve7EKQgtch
   ACfOr/FMHq50lhC1etok4eX3r3ywQ8Fc2WARIRNLX2yLlcI17JhETsJd1
   A==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="178301674"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:53:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:53:27 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 05:53:24 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Subject: [PATCH v4 04/13] reset: add polarfire soc reset support
Date:   Tue, 30 Aug 2022 13:52:41 +0100
Message-ID: <20220830125249.2373416-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220830125110.2372514-1-conor.dooley@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the resets on Microchip's PolarFire SoC (MPFS).
Reset control is a single register, wedged in between registers for
clock control. To fit with existed DT etc, the reset controller is
created using the aux device framework & set up in the clock driver.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/reset/Kconfig      |   7 ++
 drivers/reset/Makefile     |   2 +-
 drivers/reset/reset-mpfs.c | 157 +++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/reset/reset-mpfs.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 806773e88832..85f7abde3766 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -152,6 +152,13 @@ config RESET_PISTACHIO
 	help
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
+config RESET_POLARFIRE_SOC
+	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
+	depends on AUXILIARY_BUS && MCHP_CLK_MPFS
+	default MCHP_CLK_MPFS
+	help
+	  This driver supports peripheral reset for the Microchip PolarFire SoC
+
 config RESET_QCOM_AOSS
 	tristate "Qcom AOSS Reset Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index cd5cf8e7c6a7..3e7e5fd633a8 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o
 obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
 obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
@@ -40,4 +41,3 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
-
diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
new file mode 100644
index 000000000000..1580d1b68d61
--- /dev/null
+++ b/drivers/reset/reset-mpfs.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PolarFire SoC (MPFS) Peripheral Clock Reset Controller
+ *
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries.
+ *
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <dt-bindings/clock/microchip,mpfs-clock.h>
+#include <soc/microchip/mpfs.h>
+
+/*
+ * The ENVM reset is the lowest bit in the register & I am using the CLK_FOO
+ * defines in the dt to make things easier to configure - so this is accounting
+ * for the offset of 3 there.
+ */
+#define MPFS_PERIPH_OFFSET	CLK_ENVM
+#define MPFS_NUM_RESETS		30u
+#define MPFS_SLEEP_MIN_US	100
+#define MPFS_SLEEP_MAX_US	200
+
+/* block concurrent access to the soft reset register */
+static DEFINE_SPINLOCK(mpfs_reset_lock);
+
+/*
+ * Peripheral clock resets
+ */
+
+static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&mpfs_reset_lock, flags);
+
+	reg = mpfs_reset_read(rcdev->dev);
+	reg |= BIT(id);
+	mpfs_reset_write(rcdev->dev, reg);
+
+	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
+
+	return 0;
+}
+
+static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	unsigned long flags;
+	u32 reg, val;
+
+	spin_lock_irqsave(&mpfs_reset_lock, flags);
+
+	reg = mpfs_reset_read(rcdev->dev);
+	val = reg & ~BIT(id);
+	mpfs_reset_write(rcdev->dev, val);
+
+	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
+
+	return 0;
+}
+
+static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	u32 reg = mpfs_reset_read(rcdev->dev);
+
+	/*
+	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
+	 * is never hit.
+	 */
+	return (reg & BIT(id));
+}
+
+static int mpfs_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	mpfs_assert(rcdev, id);
+
+	usleep_range(MPFS_SLEEP_MIN_US, MPFS_SLEEP_MAX_US);
+
+	mpfs_deassert(rcdev, id);
+
+	return 0;
+}
+
+static const struct reset_control_ops mpfs_reset_ops = {
+	.reset = mpfs_reset,
+	.assert = mpfs_assert,
+	.deassert = mpfs_deassert,
+	.status = mpfs_status,
+};
+
+static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
+			    const struct of_phandle_args *reset_spec)
+{
+	unsigned int index = reset_spec->args[0];
+
+	/*
+	 * CLK_RESERVED does not map to a clock, but it does map to a reset,
+	 * so it has to be accounted for here. It is the reset for the fabric,
+	 * so if this reset gets called - do not reset it.
+	 */
+	if (index == CLK_RESERVED) {
+		dev_err(rcdev->dev, "Resetting the fabric is not supported\n");
+		return -EINVAL;
+	}
+
+	if (index < MPFS_PERIPH_OFFSET || index >= (MPFS_PERIPH_OFFSET + rcdev->nr_resets)) {
+		dev_err(rcdev->dev, "Invalid reset index %u\n", index);
+		return -EINVAL;
+	}
+
+	return index - MPFS_PERIPH_OFFSET;
+}
+
+static int mpfs_reset_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct reset_controller_dev *rcdev;
+
+	rcdev = devm_kzalloc(dev, sizeof(*rcdev), GFP_KERNEL);
+	if (!rcdev)
+		return -ENOMEM;
+
+	rcdev->dev = dev;
+	rcdev->dev->parent = dev->parent;
+	rcdev->ops = &mpfs_reset_ops;
+	rcdev->of_node = dev->parent->of_node;
+	rcdev->of_reset_n_cells = 1;
+	rcdev->of_xlate = mpfs_reset_xlate;
+	rcdev->nr_resets = MPFS_NUM_RESETS;
+
+	return devm_reset_controller_register(dev, rcdev);
+}
+
+static const struct auxiliary_device_id mpfs_reset_ids[] = {
+	{
+		.name = "clk_mpfs.reset-mpfs",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, mpfs_reset_ids);
+
+static struct auxiliary_driver mpfs_reset_driver = {
+	.probe		= mpfs_reset_probe,
+	.id_table	= mpfs_reset_ids,
+};
+
+module_auxiliary_driver(mpfs_reset_driver);
+
+MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(MCHP_CLK_MPFS);
-- 
2.36.1

