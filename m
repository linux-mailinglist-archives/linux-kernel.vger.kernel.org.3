Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79316559C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiFXOhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiFXOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:35:43 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48B1C5DF3B;
        Fri, 24 Jun 2022 07:35:16 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6257D16CC;
        Fri, 24 Jun 2022 17:20:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6257D16CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656080422;
        bh=zn6W9aYwFRm9r2y9H+QN9BCOOgvuf6XCDjzAh+V3fVs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ql4Y/sJoO2KUXd5ZpqEPcUAqAJTbn8VEy+V+K/MKnva2KMQ1miOIAiyYSf/S6RimI
         ezgdhuBJpsmLvlqNeXbrwhxIceJbkD9BgFlfTSqzlCYYniew8VzjHCBI/dc6c6wZya
         4y0vdjHi18uA2x1ye6VoAz3SjL5s3lKdIDKbFjbs=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:19:02 +0300
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
Subject: [PATCH RESEND v5 5/8] clk: baikal-t1: Add SATA internal ref clock buffer
Date:   Fri, 24 Jun 2022 17:18:49 +0300
Message-ID: <20220624141853.7417-6-Sergey.Semin@baikalelectronics.ru>
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

It turns out the internal SATA reference clock signal will stay
unavailable for the SATA interface consumer until the buffer on it's way
is ungated. So aside with having the actual clock divider enabled we need
to ungate a buffer placed on the signal way to the SATA controller (most
likely some rudiment from the initial SoC release). Seeing the switch flag
is placed in the same register as the SATA-ref clock divider at a
non-standard ffset, let's implement it as a separate clock controller with
the set-rate propagation to the parental clock divider wrapper. As such
we'll be able to disable/enable and still change the original clock source
rate.

Fixes: 353afa3a8d2e ("clk: Add Baikal-T1 CCU Dividers driver")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- This is a new patch created on v4 lap of the series.
---
 drivers/clk/baikal-t1/ccu-div.c     | 64 +++++++++++++++++++++++++++++
 drivers/clk/baikal-t1/ccu-div.h     |  4 ++
 drivers/clk/baikal-t1/clk-ccu-div.c | 18 +++++++-
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/baikal-t1/ccu-div.c b/drivers/clk/baikal-t1/ccu-div.c
index bbfa3526ee10..a6642f3d33d4 100644
--- a/drivers/clk/baikal-t1/ccu-div.c
+++ b/drivers/clk/baikal-t1/ccu-div.c
@@ -34,6 +34,7 @@
 #define CCU_DIV_CTL_CLKDIV_MASK(_width) \
 	GENMASK((_width) + CCU_DIV_CTL_CLKDIV_FLD - 1, CCU_DIV_CTL_CLKDIV_FLD)
 #define CCU_DIV_CTL_LOCK_SHIFTED	BIT(27)
+#define CCU_DIV_CTL_GATE_REF_BUF	BIT(28)
 #define CCU_DIV_CTL_LOCK_NORMAL		BIT(31)
 
 #define CCU_DIV_RST_DELAY_US		1
@@ -170,6 +171,40 @@ static int ccu_div_gate_is_enabled(struct clk_hw *hw)
 	return !!(val & CCU_DIV_CTL_EN);
 }
 
+static int ccu_div_buf_enable(struct clk_hw *hw)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&div->lock, flags);
+	regmap_update_bits(div->sys_regs, div->reg_ctl,
+			   CCU_DIV_CTL_GATE_REF_BUF, 0);
+	spin_unlock_irqrestore(&div->lock, flags);
+
+	return 0;
+}
+
+static void ccu_div_buf_disable(struct clk_hw *hw)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&div->lock, flags);
+	regmap_update_bits(div->sys_regs, div->reg_ctl,
+			   CCU_DIV_CTL_GATE_REF_BUF, CCU_DIV_CTL_GATE_REF_BUF);
+	spin_unlock_irqrestore(&div->lock, flags);
+}
+
+static int ccu_div_buf_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	u32 val = 0;
+
+	regmap_read(div->sys_regs, div->reg_ctl, &val);
+
+	return !(val & CCU_DIV_CTL_GATE_REF_BUF);
+}
+
 static unsigned long ccu_div_var_recalc_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
@@ -323,6 +358,7 @@ static const struct ccu_div_dbgfs_bit ccu_div_bits[] = {
 	CCU_DIV_DBGFS_BIT_ATTR("div_en", CCU_DIV_CTL_EN),
 	CCU_DIV_DBGFS_BIT_ATTR("div_rst", CCU_DIV_CTL_RST),
 	CCU_DIV_DBGFS_BIT_ATTR("div_bypass", CCU_DIV_CTL_SET_CLKDIV),
+	CCU_DIV_DBGFS_BIT_ATTR("div_buf", CCU_DIV_CTL_GATE_REF_BUF),
 	CCU_DIV_DBGFS_BIT_ATTR("div_lock", CCU_DIV_CTL_LOCK_NORMAL)
 };
 
@@ -441,6 +477,9 @@ static void ccu_div_var_debug_init(struct clk_hw *hw, struct dentry *dentry)
 			continue;
 		}
 
+		if (!strcmp("div_buf", name))
+			continue;
+
 		bits[didx] = ccu_div_bits[bidx];
 		bits[didx].div = div;
 
@@ -477,6 +516,21 @@ static void ccu_div_gate_debug_init(struct clk_hw *hw, struct dentry *dentry)
 				   &ccu_div_dbgfs_fixed_clkdiv_fops);
 }
 
+static void ccu_div_buf_debug_init(struct clk_hw *hw, struct dentry *dentry)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	struct ccu_div_dbgfs_bit *bit;
+
+	bit = kmalloc(sizeof(*bit), GFP_KERNEL);
+	if (!bit)
+		return;
+
+	*bit = ccu_div_bits[3];
+	bit->div = div;
+	debugfs_create_file_unsafe(bit->name, ccu_div_dbgfs_mode, dentry, bit,
+				   &ccu_div_dbgfs_bit_fops);
+}
+
 static void ccu_div_fixed_debug_init(struct clk_hw *hw, struct dentry *dentry)
 {
 	struct ccu_div *div = to_ccu_div(hw);
@@ -489,6 +543,7 @@ static void ccu_div_fixed_debug_init(struct clk_hw *hw, struct dentry *dentry)
 
 #define ccu_div_var_debug_init NULL
 #define ccu_div_gate_debug_init NULL
+#define ccu_div_buf_debug_init NULL
 #define ccu_div_fixed_debug_init NULL
 
 #endif /* !CONFIG_DEBUG_FS */
@@ -520,6 +575,13 @@ static const struct clk_ops ccu_div_gate_ops = {
 	.debug_init = ccu_div_gate_debug_init
 };
 
+static const struct clk_ops ccu_div_buf_ops = {
+	.enable = ccu_div_buf_enable,
+	.disable = ccu_div_buf_disable,
+	.is_enabled = ccu_div_buf_is_enabled,
+	.debug_init = ccu_div_buf_debug_init
+};
+
 static const struct clk_ops ccu_div_fixed_ops = {
 	.recalc_rate = ccu_div_fixed_recalc_rate,
 	.round_rate = ccu_div_fixed_round_rate,
@@ -566,6 +628,8 @@ struct ccu_div *ccu_div_hw_register(const struct ccu_div_init_data *div_init)
 	} else if (div_init->type == CCU_DIV_GATE) {
 		hw_init.ops = &ccu_div_gate_ops;
 		div->divider = div_init->divider;
+	} else if (div_init->type == CCU_DIV_BUF) {
+		hw_init.ops = &ccu_div_buf_ops;
 	} else if (div_init->type == CCU_DIV_FIXED) {
 		hw_init.ops = &ccu_div_fixed_ops;
 		div->divider = div_init->divider;
diff --git a/drivers/clk/baikal-t1/ccu-div.h b/drivers/clk/baikal-t1/ccu-div.h
index b6a9c8e45318..4eb49ff4803c 100644
--- a/drivers/clk/baikal-t1/ccu-div.h
+++ b/drivers/clk/baikal-t1/ccu-div.h
@@ -15,8 +15,10 @@
 
 /*
  * CCU Divider private clock IDs
+ * @CCU_SYS_SATA_CLK: CCU SATA internal clock
  * @CCU_SYS_XGMAC_CLK: CCU XGMAC internal clock
  */
+#define CCU_SYS_SATA_CLK		-1
 #define CCU_SYS_XGMAC_CLK		-2
 
 /*
@@ -37,11 +39,13 @@
  * enum ccu_div_type - CCU Divider types
  * @CCU_DIV_VAR: Clocks gate with variable divider.
  * @CCU_DIV_GATE: Clocks gate with fixed divider.
+ * @CCU_DIV_BUF: Clock gate with no divider.
  * @CCU_DIV_FIXED: Ungateable clock with fixed divider.
  */
 enum ccu_div_type {
 	CCU_DIV_VAR,
 	CCU_DIV_GATE,
+	CCU_DIV_BUF,
 	CCU_DIV_FIXED
 };
 
diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index 3953ae5664be..90f4fda406ee 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -76,6 +76,16 @@
 		.divider = _divider				\
 	}
 
+#define CCU_DIV_BUF_INFO(_id, _name, _pname, _base, _flags)	\
+	{							\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _pname,				\
+		.base = _base,					\
+		.type = CCU_DIV_BUF,				\
+		.flags = _flags					\
+	}
+
 #define CCU_DIV_FIXED_INFO(_id, _name, _pname, _divider)	\
 	{							\
 		.id = _id,					\
@@ -188,11 +198,14 @@ static const struct ccu_div_rst_map axi_rst_map[] = {
  * for the SoC devices registers IO-operations.
  */
 static const struct ccu_div_info sys_info[] = {
-	CCU_DIV_VAR_INFO(CCU_SYS_SATA_REF_CLK, "sys_sata_ref_clk",
+	CCU_DIV_VAR_INFO(CCU_SYS_SATA_CLK, "sys_sata_clk",
 			 "sata_clk", CCU_SYS_SATA_REF_BASE, 4,
 			 CLK_SET_RATE_GATE,
 			 CCU_DIV_SKIP_ONE | CCU_DIV_LOCK_SHIFTED |
 			 CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_BUF_INFO(CCU_SYS_SATA_REF_CLK, "sys_sata_ref_clk",
+			 "sys_sata_clk", CCU_SYS_SATA_REF_BASE,
+			 CLK_SET_RATE_PARENT),
 	CCU_DIV_VAR_INFO(CCU_SYS_APB_CLK, "sys_apb_clk",
 			 "pcie_clk", CCU_SYS_APB_BASE, 5,
 			 CLK_IS_CRITICAL, CCU_DIV_RESET_DOMAIN),
@@ -398,6 +411,9 @@ static int ccu_div_clk_register(struct ccu_div_data *data)
 			init.base = info->base;
 			init.sys_regs = data->sys_regs;
 			init.divider = info->divider;
+		} else if (init.type == CCU_DIV_BUF) {
+			init.base = info->base;
+			init.sys_regs = data->sys_regs;
 		} else {
 			init.divider = info->divider;
 		}
-- 
2.35.1

