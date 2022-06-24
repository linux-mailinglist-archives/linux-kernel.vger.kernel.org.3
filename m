Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96544559C50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiFXOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiFXOfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:35:16 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2B1D56C1C;
        Fri, 24 Jun 2022 07:34:53 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id EC6B816CF;
        Fri, 24 Jun 2022 17:20:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com EC6B816CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656080423;
        bh=wTcrh45N9/1z73UX6ikNATT6XMA23zgEvAPF8yOkg5Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=UlK9KX+yFRwUPsWWr+juMKyBXK5ZwrLDUM0cZZGEvbt8X/oYOaLd3BqD2XAHzLIbw
         rsW2d1Vag7Xuf1ozMNEiGcxyeqm1zmRjSep9d10sqaORjYCLbKpoqHlcwqdMOfpXmz
         h0c12UtiUUcJdb+m8TPh+XqdRw9pEWRbJdllxyxk=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:19:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 6/8] clk: baikal-t1: Move reset-controls code into a dedicated module
Date:   Fri, 24 Jun 2022 17:18:50 +0300
Message-ID: <20220624141853.7417-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before adding the directly controlled resets support it's reasonable to
move the existing resets control functionality into a dedicated object for
the sake of the CCU dividers clock driver simplification. After the new
functionality was added clk-ccu-div.c would have got to a mixture of the
weakly dependent clocks and resets methods. Splitting the methods up into
the two objects will make the code easier to read and maintain. It shall
also improve the code scalability (though hopefully we won't need this
part that much in the future).

As it was done for the CCU PLLs and Dividers the reset control
functionality in its turn has been split up into two sub-modules:
hw-interface and generic reset device description. This commit doesn't
provide any change in the CCU reset module semantics. As before it
supports the trigger-like CCU resets only, which are responsible for the
AXI-bus, APB-bus and SATA-ref blocks reset. The assert/de-assert-capable
reset controls support will be added in the next commit.

Note the CCU Clock dividers and resets functionality split up was possible
due to not having any side-effects (at least we didn't found ones) of the
regmap-based concurrent access of the common CCU dividers/reset CSRs.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- Completely split CCU Dividers and Resets functionality. (@Stephen)
---
 drivers/clk/baikal-t1/Kconfig       |  12 +-
 drivers/clk/baikal-t1/Makefile      |   1 +
 drivers/clk/baikal-t1/ccu-div.c     |  19 ---
 drivers/clk/baikal-t1/ccu-div.h     |   4 +-
 drivers/clk/baikal-t1/ccu-rst.c     |  43 +++++
 drivers/clk/baikal-t1/ccu-rst.h     |  67 ++++++++
 drivers/clk/baikal-t1/clk-ccu-div.c | 101 +++---------
 drivers/clk/baikal-t1/clk-ccu-rst.c | 236 ++++++++++++++++++++++++++++
 8 files changed, 384 insertions(+), 99 deletions(-)
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
 create mode 100644 drivers/clk/baikal-t1/clk-ccu-rst.c

diff --git a/drivers/clk/baikal-t1/Kconfig b/drivers/clk/baikal-t1/Kconfig
index 03102f1094bc..56a4ff1d8bf0 100644
--- a/drivers/clk/baikal-t1/Kconfig
+++ b/drivers/clk/baikal-t1/Kconfig
@@ -29,7 +29,6 @@ config CLK_BT1_CCU_PLL
 
 config CLK_BT1_CCU_DIV
 	bool "Baikal-T1 CCU Dividers support"
-	select RESET_CONTROLLER
 	select MFD_SYSCON
 	default MIPS_BAIKAL_T1
 	help
@@ -39,4 +38,15 @@ config CLK_BT1_CCU_DIV
 	  either gateable or ungateable. Some of the CCU dividers can be as well
 	  used to reset the domains they're supplying clock to.
 
+config CLK_BT1_CCU_RST
+	bool "Baikal-T1 CCU Resets support"
+	select RESET_CONTROLLER
+	select MFD_SYSCON
+	default MIPS_BAIKAL_T1
+	help
+	  Enable this to support the CCU reset blocks responsible for the
+	  AXI-bus and some subsystems reset. These are mainly the
+	  sef-deasserted reset controls but there are several lines which
+	  can be directly asserted/de-asserted (PCIe and DDR sub-domains).
+
 endif
diff --git a/drivers/clk/baikal-t1/Makefile b/drivers/clk/baikal-t1/Makefile
index b3b9590b95ed..99e97f168417 100644
--- a/drivers/clk/baikal-t1/Makefile
+++ b/drivers/clk/baikal-t1/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CLK_BT1_CCU_PLL) += ccu-pll.o clk-ccu-pll.o
 obj-$(CONFIG_CLK_BT1_CCU_DIV) += ccu-div.o clk-ccu-div.o
+obj-$(CONFIG_CLK_BT1_CCU_RST) += ccu-rst.o clk-ccu-rst.o
diff --git a/drivers/clk/baikal-t1/ccu-div.c b/drivers/clk/baikal-t1/ccu-div.c
index a6642f3d33d4..8d5fc7158f33 100644
--- a/drivers/clk/baikal-t1/ccu-div.c
+++ b/drivers/clk/baikal-t1/ccu-div.c
@@ -37,7 +37,6 @@
 #define CCU_DIV_CTL_GATE_REF_BUF	BIT(28)
 #define CCU_DIV_CTL_LOCK_NORMAL		BIT(31)
 
-#define CCU_DIV_RST_DELAY_US		1
 #define CCU_DIV_LOCK_CHECK_RETRIES	50
 
 #define CCU_DIV_CLKDIV_MIN		0
@@ -323,24 +322,6 @@ static int ccu_div_fixed_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-int ccu_div_reset_domain(struct ccu_div *div)
-{
-	unsigned long flags;
-
-	if (!div || !(div->features & CCU_DIV_RESET_DOMAIN))
-		return -EINVAL;
-
-	spin_lock_irqsave(&div->lock, flags);
-	regmap_update_bits(div->sys_regs, div->reg_ctl,
-			   CCU_DIV_CTL_RST, CCU_DIV_CTL_RST);
-	spin_unlock_irqrestore(&div->lock, flags);
-
-	/* The next delay must be enough to cover all the resets. */
-	udelay(CCU_DIV_RST_DELAY_US);
-
-	return 0;
-}
-
 #ifdef CONFIG_DEBUG_FS
 
 struct ccu_div_dbgfs_bit {
diff --git a/drivers/clk/baikal-t1/ccu-div.h b/drivers/clk/baikal-t1/ccu-div.h
index 4eb49ff4803c..ff97bb30fcc3 100644
--- a/drivers/clk/baikal-t1/ccu-div.h
+++ b/drivers/clk/baikal-t1/ccu-div.h
@@ -28,7 +28,7 @@
  * @CCU_DIV_SKIP_ONE_TO_THREE: For some reason divider can't be within [1,3].
  *			       It can be either 0 or greater than 3.
  * @CCU_DIV_LOCK_SHIFTED: Find lock-bit at non-standard position.
- * @CCU_DIV_RESET_DOMAIN: Provide reset clock domain method.
+ * @CCU_DIV_RESET_DOMAIN: There is a clock domain reset handle.
  */
 #define CCU_DIV_SKIP_ONE		BIT(1)
 #define CCU_DIV_SKIP_ONE_TO_THREE	BIT(2)
@@ -115,6 +115,4 @@ struct ccu_div *ccu_div_hw_register(const struct ccu_div_init_data *init);
 
 void ccu_div_hw_unregister(struct ccu_div *div);
 
-int ccu_div_reset_domain(struct ccu_div *div);
-
 #endif /* __CLK_BT1_CCU_DIV_H__ */
diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
new file mode 100644
index 000000000000..b355bf0b399a
--- /dev/null
+++ b/drivers/clk/baikal-t1/ccu-rst.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ * Baikal-T1 CCU Resets interface driver
+ */
+
+#define pr_fmt(fmt) "bt1-ccu-rst: " fmt
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include "ccu-rst.h"
+
+#define CCU_RST_DELAY_US		1
+
+static int ccu_rst_reset(struct reset_controller_dev *rcdev, unsigned long idx)
+{
+	struct ccu_rst *rst;
+
+	rst = ccu_rst_get_desc(rcdev, idx);
+	if (IS_ERR(rst)) {
+		pr_err("Invalid reset index %lu specified\n", idx);
+		return PTR_ERR(rst);
+	}
+
+	regmap_update_bits(rst->sys_regs, rst->reg_ctl, rst->mask, rst->mask);
+
+	/* The next delay must be enough to cover all the resets. */
+	udelay(CCU_RST_DELAY_US);
+
+	return 0;
+}
+
+const struct reset_control_ops ccu_rst_ops = {
+	.reset = ccu_rst_reset,
+};
diff --git a/drivers/clk/baikal-t1/ccu-rst.h b/drivers/clk/baikal-t1/ccu-rst.h
new file mode 100644
index 000000000000..d03bae4b7a05
--- /dev/null
+++ b/drivers/clk/baikal-t1/ccu-rst.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
+ *
+ * Baikal-T1 CCU Resets interface driver
+ */
+#ifndef __CLK_BT1_CCU_RST_H__
+#define __CLK_BT1_CCU_RST_H__
+
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+struct ccu_rst_data;
+
+/*
+ * struct ccu_rst_init_data - CCU Resets initialization data
+ * @sys_regs: Baikal-T1 System Controller registers map.
+ * @np: Pointer to the node with the System CCU block.
+ */
+struct ccu_rst_init_data {
+	struct regmap *sys_regs;
+	struct device_node *np;
+};
+
+/*
+ * struct ccu_rst - CCU Reset descriptor
+ * @id: Reset identifier.
+ * @reg_ctl: Reset control register base address.
+ * @sys_regs: Baikal-T1 System Controller registers map.
+ * @mask: Reset bitmask (normally it's just a single bit flag).
+ */
+struct ccu_rst {
+	unsigned int id;
+	unsigned int reg_ctl;
+	struct regmap *sys_regs;
+	u32 mask;
+};
+
+#ifdef CONFIG_CLK_BT1_CCU_RST
+
+extern const struct reset_control_ops ccu_rst_ops;
+
+struct ccu_rst *ccu_rst_get_desc(struct reset_controller_dev *rcdev, unsigned long idx);
+
+struct ccu_rst_data *ccu_rst_hw_register(const struct ccu_rst_init_data *init);
+
+void ccu_rst_hw_unregister(struct ccu_rst_data *rcd);
+
+#else
+
+static inline
+struct ccu_rst *ccu_rst_get_desc(struct reset_controller_dev *rcdev, unsigned long idx)
+{
+	return -EINVAL;
+}
+
+static inline
+struct ccu_rst_data *ccu_rst_hw_register(const struct ccu_rst_init_data *init)
+{
+	return NULL;
+}
+
+static inline void ccu_rst_hw_unregister(struct ccu_rst_data *rcd) {}
+
+#endif
+
+#endif /* __CLK_BT1_CCU_RST_H__ */
diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index 90f4fda406ee..71e563e28f86 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -24,9 +24,9 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/bt1-ccu.h>
-#include <dt-bindings/reset/bt1-ccu.h>
 
 #include "ccu-div.h"
+#include "ccu-rst.h"
 
 #define CCU_AXI_MAIN_BASE		0x030
 #define CCU_AXI_DDR_BASE		0x034
@@ -95,6 +95,21 @@
 		.divider = _divider				\
 	}
 
+#define CCU_DIV_REPAR_INFO(_id, _name, _p0name, _p1name, _base, _divider, _features) \
+	{								\
+		.id = _id,						\
+		.name = _name,						\
+		.pnames = {						\
+			[CCU_DIV_PAR_INT] = _p0name,			\
+			[CCU_DIV_PAR_EXT] = _p1name,			\
+		},							\
+		.base = _base,						\
+		.type = CCU_DIV_REPAR,					\
+		.divider = _divider,					\
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, \
+		.features = _features,					\
+	}
+
 #define CCU_DIV_RST_MAP(_rst_id, _clk_id)	\
 	{					\
 		.rst_id = _rst_id,		\
@@ -115,11 +130,6 @@ struct ccu_div_info {
 	unsigned long features;
 };
 
-struct ccu_div_rst_map {
-	unsigned int rst_id;
-	unsigned int clk_id;
-};
-
 struct ccu_div_data {
 	struct device_node *np;
 	struct regmap *sys_regs;
@@ -128,11 +138,8 @@ struct ccu_div_data {
 	const struct ccu_div_info *divs_info;
 	struct ccu_div **divs;
 
-	unsigned int rst_num;
-	const struct ccu_div_rst_map *rst_map;
-	struct reset_controller_dev rcdev;
+	struct ccu_rst_data *crd;
 };
-#define to_ccu_div_data(_rcdev) container_of(_rcdev, struct ccu_div_data, rcdev)
 
 /*
  * AXI Main Interconnect (axi_main_clk) and DDR AXI-bus (axi_ddr_clk) clocks
@@ -179,20 +186,6 @@ static const struct ccu_div_info axi_info[] = {
 			 CLK_SET_RATE_GATE, CCU_DIV_RESET_DOMAIN)
 };
 
-static const struct ccu_div_rst_map axi_rst_map[] = {
-	CCU_DIV_RST_MAP(CCU_AXI_MAIN_RST, CCU_AXI_MAIN_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_DDR_RST, CCU_AXI_DDR_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_SATA_RST, CCU_AXI_SATA_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_GMAC0_RST, CCU_AXI_GMAC0_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_GMAC1_RST, CCU_AXI_GMAC1_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_XGMAC_RST, CCU_AXI_XGMAC_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_PCIE_M_RST, CCU_AXI_PCIE_M_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_PCIE_S_RST, CCU_AXI_PCIE_S_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_USB_RST, CCU_AXI_USB_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_HWA_RST, CCU_AXI_HWA_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_SRAM_RST, CCU_AXI_SRAM_CLK)
-};
-
 /*
  * APB-bus clock is marked as critical since it's a main communication bus
  * for the SoC devices registers IO-operations.
@@ -254,11 +247,6 @@ static const struct ccu_div_info sys_info[] = {
 			 CLK_SET_RATE_GATE, CCU_DIV_SKIP_ONE_TO_THREE)
 };
 
-static const struct ccu_div_rst_map sys_rst_map[] = {
-	CCU_DIV_RST_MAP(CCU_SYS_SATA_REF_RST, CCU_SYS_SATA_REF_CLK),
-	CCU_DIV_RST_MAP(CCU_SYS_APB_RST, CCU_SYS_APB_CLK),
-};
-
 static struct ccu_div *ccu_div_find_desc(struct ccu_div_data *data,
 					 unsigned int clk_id)
 {
@@ -274,42 +262,6 @@ static struct ccu_div *ccu_div_find_desc(struct ccu_div_data *data,
 	return ERR_PTR(-EINVAL);
 }
 
-static int ccu_div_reset(struct reset_controller_dev *rcdev,
-			 unsigned long rst_id)
-{
-	struct ccu_div_data *data = to_ccu_div_data(rcdev);
-	const struct ccu_div_rst_map *map;
-	struct ccu_div *div;
-	int idx, ret;
-
-	for (idx = 0, map = data->rst_map; idx < data->rst_num; ++idx, ++map) {
-		if (map->rst_id == rst_id)
-			break;
-	}
-	if (idx == data->rst_num) {
-		pr_err("Invalid reset ID %lu specified\n", rst_id);
-		return -EINVAL;
-	}
-
-	div = ccu_div_find_desc(data, map->clk_id);
-	if (IS_ERR(div)) {
-		pr_err("Invalid clock ID %d in mapping\n", map->clk_id);
-		return PTR_ERR(div);
-	}
-
-	ret = ccu_div_reset_domain(div);
-	if (ret) {
-		pr_err("Reset isn't supported by divider %s\n",
-			clk_hw_get_name(ccu_div_get_clk_hw(div)));
-	}
-
-	return ret;
-}
-
-static const struct reset_control_ops ccu_div_rst_ops = {
-	.reset = ccu_div_reset,
-};
-
 static struct ccu_div_data *ccu_div_create_data(struct device_node *np)
 {
 	struct ccu_div_data *data;
@@ -323,13 +275,9 @@ static struct ccu_div_data *ccu_div_create_data(struct device_node *np)
 	if (of_device_is_compatible(np, "baikal,bt1-ccu-axi")) {
 		data->divs_num = ARRAY_SIZE(axi_info);
 		data->divs_info = axi_info;
-		data->rst_num = ARRAY_SIZE(axi_rst_map);
-		data->rst_map = axi_rst_map;
 	} else if (of_device_is_compatible(np, "baikal,bt1-ccu-sys")) {
 		data->divs_num = ARRAY_SIZE(sys_info);
 		data->divs_info = sys_info;
-		data->rst_num = ARRAY_SIZE(sys_rst_map);
-		data->rst_map = sys_rst_map;
 	} else {
 		pr_err("Incompatible DT node '%s' specified\n",
 			of_node_full_name(np));
@@ -455,18 +403,19 @@ static void ccu_div_clk_unregister(struct ccu_div_data *data)
 
 static int ccu_div_rst_register(struct ccu_div_data *data)
 {
-	int ret;
+	struct ccu_rst_init_data init = {0};
 
-	data->rcdev.ops = &ccu_div_rst_ops;
-	data->rcdev.of_node = data->np;
-	data->rcdev.nr_resets = data->rst_num;
+	init.sys_regs = data->sys_regs;
+	init.np = data->np;
 
-	ret = reset_controller_register(&data->rcdev);
-	if (ret)
+	data->crd = ccu_rst_hw_register(&init);
+	if (IS_ERR(data->crd)) {
 		pr_err("Couldn't register divider '%s' reset controller\n",
 			of_node_full_name(data->np));
+		return PTR_ERR(data->crd);
+	}
 
-	return ret;
+	return 0;
 }
 
 static void ccu_div_init(struct device_node *np)
diff --git a/drivers/clk/baikal-t1/clk-ccu-rst.c b/drivers/clk/baikal-t1/clk-ccu-rst.c
new file mode 100644
index 000000000000..b10857f48b8b
--- /dev/null
+++ b/drivers/clk/baikal-t1/clk-ccu-rst.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ * Baikal-T1 CCU Resets domain driver
+ */
+#define pr_fmt(fmt) "bt1-ccu-rst: " fmt
+
+#include <linux/bits.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/printk.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/reset/bt1-ccu.h>
+
+#include "ccu-rst.h"
+
+#define CCU_AXI_MAIN_BASE		0x030
+#define CCU_AXI_DDR_BASE		0x034
+#define CCU_AXI_SATA_BASE		0x038
+#define CCU_AXI_GMAC0_BASE		0x03C
+#define CCU_AXI_GMAC1_BASE		0x040
+#define CCU_AXI_XGMAC_BASE		0x044
+#define CCU_AXI_PCIE_M_BASE		0x048
+#define CCU_AXI_PCIE_S_BASE		0x04C
+#define CCU_AXI_USB_BASE		0x050
+#define CCU_AXI_HWA_BASE		0x054
+#define CCU_AXI_SRAM_BASE		0x058
+
+#define CCU_SYS_SATA_REF_BASE		0x060
+#define CCU_SYS_APB_BASE		0x064
+
+#define CCU_RST_TRIG(_id, _base, _ofs)		\
+	{					\
+		.id = _id,			\
+		.base = _base,			\
+		.mask = BIT(_ofs),		\
+	}
+
+struct ccu_rst_info {
+	unsigned int id;
+	unsigned int base;
+	unsigned int mask;
+};
+
+struct ccu_rst_data {
+	struct device_node *np;
+	struct regmap *sys_regs;
+
+	unsigned int rsts_num;
+	const struct ccu_rst_info *rsts_info;
+	struct ccu_rst *rsts;
+
+	struct reset_controller_dev rcdev;
+};
+#define to_ccu_rst_data(_rcdev) container_of(_rcdev, struct ccu_rst_data, rcdev)
+
+/*
+ * Each AXI-bus clock divider is equipped with the corresponding clock-consumer
+ * domain reset (it's self-deasserted reset control).
+ */
+static const struct ccu_rst_info axi_rst_info[] = {
+	CCU_RST_TRIG(CCU_AXI_MAIN_RST, CCU_AXI_MAIN_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_DDR_RST, CCU_AXI_DDR_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_SATA_RST, CCU_AXI_SATA_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_GMAC0_RST, CCU_AXI_GMAC0_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_GMAC1_RST, CCU_AXI_GMAC1_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_XGMAC_RST, CCU_AXI_XGMAC_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_PCIE_M_RST, CCU_AXI_PCIE_M_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_PCIE_S_RST, CCU_AXI_PCIE_S_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_USB_RST, CCU_AXI_USB_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_HWA_RST, CCU_AXI_HWA_BASE, 1),
+	CCU_RST_TRIG(CCU_AXI_SRAM_RST, CCU_AXI_SRAM_BASE, 1),
+};
+
+/*
+ * SATA reference clock domain and APB-bus domain are connected with the
+ * sefl-deasserted reset control, which can be activated via the corresponding
+ * clock divider register. DDR and PCIe sub-domains can be reset with directly
+ * controlled reset signals. Resetting the DDR controller though won't end up
+ * well while the Linux kernel is working.
+ */
+static const struct ccu_rst_info sys_rst_info[] = {
+	CCU_RST_TRIG(CCU_SYS_SATA_REF_RST, CCU_SYS_SATA_REF_BASE, 1),
+	CCU_RST_TRIG(CCU_SYS_APB_RST, CCU_SYS_APB_BASE, 1),
+};
+
+struct ccu_rst *ccu_rst_get_desc(struct reset_controller_dev *rcdev, unsigned long idx)
+{
+	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
+
+	if (idx >= data->rsts_num)
+		return ERR_PTR(-EINVAL);
+
+	return &data->rsts[idx];
+}
+
+static int ccu_rst_of_idx_get(struct reset_controller_dev *rcdev,
+			      const struct of_phandle_args *rstspec)
+{
+	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
+	unsigned int id, idx;
+
+	id = rstspec->args[0];
+	for (idx = 0; idx < data->rsts_num; ++idx) {
+		if (data->rsts[idx].id == id)
+			break;
+	}
+	if (idx == data->rsts_num) {
+		pr_err("Invalid reset ID %u specified\n", id);
+		return -EINVAL;
+	}
+
+	return idx;
+}
+
+static struct ccu_rst_data *ccu_rst_create_data(const struct ccu_rst_init_data *rst_init)
+{
+	struct ccu_rst_data *data;
+	int ret;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->np = rst_init->np;
+	data->sys_regs = rst_init->sys_regs;
+	if (of_device_is_compatible(data->np, "baikal,bt1-ccu-axi")) {
+		data->rsts_num = ARRAY_SIZE(axi_rst_info);
+		data->rsts_info = axi_rst_info;
+	} else if (of_device_is_compatible(data->np, "baikal,bt1-ccu-sys")) {
+		data->rsts_num = ARRAY_SIZE(sys_rst_info);
+		data->rsts_info = sys_rst_info;
+	} else {
+		pr_err("Incompatible DT node '%s' specified\n",
+			of_node_full_name(data->np));
+		ret = -EINVAL;
+		goto err_kfree_data;
+	}
+
+	data->rsts = kcalloc(data->rsts_num, sizeof(*data->rsts), GFP_KERNEL);
+	if (!data->rsts) {
+		ret = -ENOMEM;
+		goto err_kfree_data;
+	}
+
+	return data;
+
+err_kfree_data:
+	kfree(data);
+
+	return ERR_PTR(ret);
+}
+
+static void ccu_rst_free_data(struct ccu_rst_data *data)
+{
+	kfree(data->rsts);
+
+	kfree(data);
+}
+
+static void ccu_rst_init_desc(struct ccu_rst_data *data)
+{
+	struct ccu_rst *rst = data->rsts;
+	unsigned int idx;
+
+	for (idx = 0; idx < data->rsts_num; ++idx, ++rst) {
+		const struct ccu_rst_info *info = &data->rsts_info[idx];
+
+		rst->id = info->id;
+		rst->type = info->type;
+		rst->reg_ctl = info->base;
+		rst->sys_regs = data->sys_regs;
+		rst->mask = info->mask;
+	}
+}
+
+static int ccu_rst_dev_register(struct ccu_rst_data *data)
+{
+	int ret;
+
+	data->rcdev.ops = &ccu_rst_ops;
+	data->rcdev.of_node = data->np;
+	data->rcdev.nr_resets = data->rsts_num;
+	data->rcdev.of_reset_n_cells = 1;
+	data->rcdev.of_xlate = ccu_rst_of_idx_get;
+
+	ret = reset_controller_register(&data->rcdev);
+	if (ret) {
+		pr_err("Couldn't register '%s' reset controller\n",
+			of_node_full_name(data->np));
+	}
+
+	return ret;
+}
+
+static void ccu_rst_dev_unregister(struct ccu_rst_data *data)
+{
+	reset_controller_unregister(&data->rcdev);
+}
+
+struct ccu_rst_data *ccu_rst_hw_register(const struct ccu_rst_init_data *rst_init)
+{
+	struct ccu_rst_data *data;
+	int ret;
+
+	data = ccu_rst_create_data(rst_init);
+	if (IS_ERR(data))
+		return data;
+
+	ccu_rst_init_desc(data);
+
+	ret = ccu_rst_dev_register(data);
+	if (ret)
+		goto err_free_data;
+
+	return data;
+
+err_free_data:
+	ccu_rst_free_data(data);
+
+	return ERR_PTR(ret);
+}
+
+void ccu_rst_hw_unregister(struct ccu_rst_data *data)
+{
+	ccu_rst_dev_unregister(data);
+
+	ccu_rst_free_data(data);
+}
-- 
2.35.1

