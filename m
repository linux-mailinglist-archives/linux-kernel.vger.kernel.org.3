Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B178559C37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiFXOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiFXOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:35:18 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1903756C33;
        Fri, 24 Jun 2022 07:35:00 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id DDAC816D0;
        Fri, 24 Jun 2022 17:20:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com DDAC816D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656080424;
        bh=5SZFRGy/nZ/cEBklGA8f9L7A+oo0OtNgAJRVAPxDZos=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ag/v6cLhL/sDsVl/hCFz5bYKakOC2jruiu0Zl0vY5Q9+ByMU5TcCAHRRLEx3VJOSA
         AYCYbcTwv6B5CWKn9pfKp6faWbxvVDJyY05J4IpxWjMFWd9b9DXGyWXc2cDsgPFJTV
         TptorRL/IAdPnBlsXlAiPHXz922hOIwerLH4veN0=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:19:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH RESEND v5 7/8] clk: baikal-t1: Add DDR/PCIe directly controlled resets support
Date:   Fri, 24 Jun 2022 17:18:51 +0300
Message-ID: <20220624141853.7417-8-Sergey.Semin@baikalelectronics.ru>
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

Aside with a set of the trigger-like resets Baikal-T1 CCU provides two
additional blocks with directly controlled reset signals. In particular it
concerns DDR full and initial resets and various PCIe sub-domains resets.
Let's add the direct reset assertion/de-assertion of the corresponding
flags support into the Baikal-T1 CCU driver then. It will be required at
least for the PCIe platform driver. Obviously the DDR controller isn't
supposed to be fully reset in the kernel, so the corresponding controls
are added just for the sake of the interface implementation completeness.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/clk/baikal-t1/ccu-rst.c     | 56 +++++++++++++++++++++++++++++
 drivers/clk/baikal-t1/ccu-rst.h     | 12 +++++++
 drivers/clk/baikal-t1/clk-ccu-rst.c | 21 +++++++++++
 include/dt-bindings/reset/bt1-ccu.h |  9 +++++
 4 files changed, 98 insertions(+)

diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
index b355bf0b399a..a3b41cbe6230 100644
--- a/drivers/clk/baikal-t1/ccu-rst.c
+++ b/drivers/clk/baikal-t1/ccu-rst.c
@@ -30,6 +30,9 @@ static int ccu_rst_reset(struct reset_controller_dev *rcdev, unsigned long idx)
 		return PTR_ERR(rst);
 	}
 
+	if (rst->type != CCU_RST_TRIG)
+		return -EOPNOTSUPP;
+
 	regmap_update_bits(rst->sys_regs, rst->reg_ctl, rst->mask, rst->mask);
 
 	/* The next delay must be enough to cover all the resets. */
@@ -38,6 +41,59 @@ static int ccu_rst_reset(struct reset_controller_dev *rcdev, unsigned long idx)
 	return 0;
 }
 
+static int ccu_rst_set(struct reset_controller_dev *rcdev,
+		       unsigned long idx, bool high)
+{
+	struct ccu_rst *rst;
+
+	rst = ccu_rst_get_desc(rcdev, idx);
+	if (IS_ERR(rst)) {
+		pr_err("Invalid reset index %lu specified\n", idx);
+		return PTR_ERR(rst);
+	}
+
+	if (rst->type != CCU_RST_DIR)
+		return high ? -EOPNOTSUPP : 0;
+
+	return regmap_update_bits(rst->sys_regs, rst->reg_ctl,
+				  rst->mask, high ? rst->mask : 0);
+}
+
+static int ccu_rst_assert(struct reset_controller_dev *rcdev,
+			  unsigned long idx)
+{
+	return ccu_rst_set(rcdev, idx, true);
+}
+
+static int ccu_rst_deassert(struct reset_controller_dev *rcdev,
+			    unsigned long idx)
+{
+	return ccu_rst_set(rcdev, idx, false);
+}
+
+static int ccu_rst_status(struct reset_controller_dev *rcdev,
+			  unsigned long idx)
+{
+	struct ccu_rst *rst;
+	u32 val;
+
+	rst = ccu_rst_get_desc(rcdev, idx);
+	if (IS_ERR(rst)) {
+		pr_err("Invalid reset index %lu specified\n", idx);
+		return PTR_ERR(rst);
+	}
+
+	if (rst->type != CCU_RST_DIR)
+		return -EOPNOTSUPP;
+
+	regmap_read(rst->sys_regs, rst->reg_ctl, &val);
+
+	return !!(val & rst->mask);
+}
+
 const struct reset_control_ops ccu_rst_ops = {
 	.reset = ccu_rst_reset,
+	.assert = ccu_rst_assert,
+	.deassert = ccu_rst_deassert,
+	.status = ccu_rst_status,
 };
diff --git a/drivers/clk/baikal-t1/ccu-rst.h b/drivers/clk/baikal-t1/ccu-rst.h
index d03bae4b7a05..7b9b9c81f5c9 100644
--- a/drivers/clk/baikal-t1/ccu-rst.h
+++ b/drivers/clk/baikal-t1/ccu-rst.h
@@ -12,6 +12,16 @@
 
 struct ccu_rst_data;
 
+/*
+ * enum ccu_rst_type - CCU Reset types
+ * @CCU_RST_TRIG: Self-deasserted reset signal.
+ * @CCU_RST_DIR: Directly controlled reset signal.
+ */
+enum ccu_rst_type {
+	CCU_RST_TRIG,
+	CCU_RST_DIR,
+};
+
 /*
  * struct ccu_rst_init_data - CCU Resets initialization data
  * @sys_regs: Baikal-T1 System Controller registers map.
@@ -25,12 +35,14 @@ struct ccu_rst_init_data {
 /*
  * struct ccu_rst - CCU Reset descriptor
  * @id: Reset identifier.
+ * @type: Reset control type.
  * @reg_ctl: Reset control register base address.
  * @sys_regs: Baikal-T1 System Controller registers map.
  * @mask: Reset bitmask (normally it's just a single bit flag).
  */
 struct ccu_rst {
 	unsigned int id;
+	enum ccu_rst_type type;
 	unsigned int reg_ctl;
 	struct regmap *sys_regs;
 	u32 mask;
diff --git a/drivers/clk/baikal-t1/clk-ccu-rst.c b/drivers/clk/baikal-t1/clk-ccu-rst.c
index b10857f48b8b..592a95308c62 100644
--- a/drivers/clk/baikal-t1/clk-ccu-rst.c
+++ b/drivers/clk/baikal-t1/clk-ccu-rst.c
@@ -33,18 +33,30 @@
 #define CCU_AXI_HWA_BASE		0x054
 #define CCU_AXI_SRAM_BASE		0x058
 
+#define CCU_SYS_DDR_BASE		0x02c
 #define CCU_SYS_SATA_REF_BASE		0x060
 #define CCU_SYS_APB_BASE		0x064
+#define CCU_SYS_PCIE_BASE		0x144
 
 #define CCU_RST_TRIG(_id, _base, _ofs)		\
 	{					\
 		.id = _id,			\
+		.type = CCU_RST_TRIG,		\
+		.base = _base,			\
+		.mask = BIT(_ofs),		\
+	}
+
+#define CCU_RST_DIR(_id, _base, _ofs)		\
+	{					\
+		.id = _id,			\
+		.type = CCU_RST_DIR,		\
 		.base = _base,			\
 		.mask = BIT(_ofs),		\
 	}
 
 struct ccu_rst_info {
 	unsigned int id;
+	enum ccu_rst_type type;
 	unsigned int base;
 	unsigned int mask;
 };
@@ -89,6 +101,15 @@ static const struct ccu_rst_info axi_rst_info[] = {
 static const struct ccu_rst_info sys_rst_info[] = {
 	CCU_RST_TRIG(CCU_SYS_SATA_REF_RST, CCU_SYS_SATA_REF_BASE, 1),
 	CCU_RST_TRIG(CCU_SYS_APB_RST, CCU_SYS_APB_BASE, 1),
+	CCU_RST_DIR(CCU_SYS_DDR_FULL_RST, CCU_SYS_DDR_BASE, 1),
+	CCU_RST_DIR(CCU_SYS_DDR_INIT_RST, CCU_SYS_DDR_BASE, 2),
+	CCU_RST_DIR(CCU_SYS_PCIE_PCS_PHY_RST, CCU_SYS_PCIE_BASE, 0),
+	CCU_RST_DIR(CCU_SYS_PCIE_PIPE0_RST, CCU_SYS_PCIE_BASE, 4),
+	CCU_RST_DIR(CCU_SYS_PCIE_CORE_RST, CCU_SYS_PCIE_BASE, 8),
+	CCU_RST_DIR(CCU_SYS_PCIE_PWR_RST, CCU_SYS_PCIE_BASE, 9),
+	CCU_RST_DIR(CCU_SYS_PCIE_STICKY_RST, CCU_SYS_PCIE_BASE, 10),
+	CCU_RST_DIR(CCU_SYS_PCIE_NSTICKY_RST, CCU_SYS_PCIE_BASE, 11),
+	CCU_RST_DIR(CCU_SYS_PCIE_HOT_RST, CCU_SYS_PCIE_BASE, 12),
 };
 
 struct ccu_rst *ccu_rst_get_desc(struct reset_controller_dev *rcdev, unsigned long idx)
diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/reset/bt1-ccu.h
index 3578e83026bc..c691efaa678f 100644
--- a/include/dt-bindings/reset/bt1-ccu.h
+++ b/include/dt-bindings/reset/bt1-ccu.h
@@ -21,5 +21,14 @@
 
 #define CCU_SYS_SATA_REF_RST		0
 #define CCU_SYS_APB_RST			1
+#define CCU_SYS_DDR_FULL_RST		2
+#define CCU_SYS_DDR_INIT_RST		3
+#define CCU_SYS_PCIE_PCS_PHY_RST	4
+#define CCU_SYS_PCIE_PIPE0_RST		5
+#define CCU_SYS_PCIE_CORE_RST		6
+#define CCU_SYS_PCIE_PWR_RST		7
+#define CCU_SYS_PCIE_STICKY_RST		8
+#define CCU_SYS_PCIE_NSTICKY_RST	9
+#define CCU_SYS_PCIE_HOT_RST		10
 
 #endif /* __DT_BINDINGS_RESET_BT1_CCU_H */
-- 
2.35.1

