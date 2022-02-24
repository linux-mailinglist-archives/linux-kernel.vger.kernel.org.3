Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0644C30DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiBXQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiBXQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:03:28 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A1A1A39EC;
        Thu, 24 Feb 2022 08:02:46 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21OCQjPN032631;
        Thu, 24 Feb 2022 17:02:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=hNd85QuxAPt1JKcUQ6LwOsIx66UTxc4JQbMHzAv5lJo=;
 b=08/v4qE07WAeCPZLPomUgzvVJaI154SLuO2w6YT/Jt39YIFsxsDa1QaPvBy1puhqYv8Q
 bAZasbL/IKmKo+QOldo6NgeMLATYkIa8XRWHh9tcLDw4PDcaUSG322yQb/1aO+uHmYdB
 JYSNj9NL67eDufoUtEt25RSLw0X4nSfi958TRJlqo0c2MX0dndaVHDG4V+k/VJQBSW/y
 FPNpg0zTLIigs0puaON40K7PpjHWq12+M8e85a1HgEdXgYdAw8FuLiyxnvqEdR56+VCI
 9egs3B3HU3QNNmQx319j8HPojzsDx4wwvxIz1l4qLH4YfqSqCdPjyb7qaM//0gYs2PCh gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ee5x0369f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 17:02:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 037E8100034;
        Thu, 24 Feb 2022 17:02:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E6AE822A6FC;
        Thu, 24 Feb 2022 17:02:12 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 24 Feb 2022 17:02:12
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/13] clk: stm32mp13: add composite clock
Date:   Thu, 24 Feb 2022 17:01:34 +0100
Message-ID: <20220224160141.455881-7-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224160141.455881-1-gabriel.fernandez@foss.st.com>
References: <20220224160141.455881-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_03,2022-02-24_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Just to introduce management of stm32 composite clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32-core.c | 181 +++++++++++++++++++++++++++++
 drivers/clk/stm32/clk-stm32-core.h |  33 ++++++
 drivers/clk/stm32/clk-stm32mp13.c  |  28 +++++
 3 files changed, 242 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 57d039168779..3b00918d0753 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -393,6 +393,166 @@ const struct clk_ops clk_stm32_mux_ops = {
 	.set_parent	= clk_stm32_mux_set_parent,
 };
 
+int clk_stm32_composite_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	unsigned long flags = 0;
+	int ret;
+
+	if (composite->div_id == NO_STM32_DIV)
+		return rate;
+
+	spin_lock_irqsave(composite->lock, flags);
+
+	ret = clk_stm32_set_rate_divider(composite->base, composite->clock_data,
+					 composite->div_id, rate, parent_rate);
+
+	spin_unlock_irqrestore(composite->lock, flags);
+
+	return ret;
+}
+
+unsigned long clk_stm32_composite_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	if (composite->div_id == NO_STM32_DIV)
+		return parent_rate;
+
+	return clk_stm32_get_rate_divider(composite->base,
+					  composite->clock_data,
+					  composite->div_id,
+					  parent_rate);
+}
+
+long clk_stm32_composite_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *prate)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	const struct stm32_div_cfg *divider;
+
+	if (composite->div_id == NO_STM32_DIV)
+		return rate;
+
+	divider = &composite->clock_data->dividers[composite->div_id];
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		u32 val;
+
+		val =  readl(composite->base + divider->offset) >> divider->shift;
+		val &= clk_div_mask(divider->width);
+
+		return divider_ro_round_rate(hw, rate, prate, divider->table,
+				divider->width, divider->flags,
+				val);
+	}
+
+	return divider_round_rate_parent(hw, clk_hw_get_parent(hw),
+					 rate, prate, divider->table,
+					 divider->width, divider->flags);
+}
+
+u8 clk_stm32_composite_get_parent(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	return clk_stm32_get_parent_mux(composite->base, composite->clock_data,
+					composite->mux_id);
+}
+
+int clk_stm32_composite_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(composite->lock, flags);
+
+	clk_stm32_set_parent_mux(composite->base, composite->clock_data,
+				 composite->mux_id, index);
+
+	spin_unlock_irqrestore(composite->lock, flags);
+
+	return 0;
+}
+
+void clk_stm32_composite_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(composite->lock, flags);
+
+	clk_stm32_endisable_gate(composite->base, composite->clock_data,
+				 composite->gate_id, enable);
+
+	spin_unlock_irqrestore(composite->lock, flags);
+}
+
+int clk_stm32_composite_gate_enable(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	if (composite->gate_id == NO_STM32_GATE)
+		return 0;
+
+	clk_stm32_composite_gate_endisable(hw, 1);
+
+	return 0;
+}
+
+void clk_stm32_composite_gate_disable(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	if (composite->gate_id == NO_STM32_GATE)
+		return;
+
+	clk_stm32_composite_gate_endisable(hw, 0);
+}
+
+int clk_stm32_composite_is_enabled(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	if (composite->gate_id == NO_STM32_GATE)
+		return (__clk_get_enable_count(hw->clk) > 0);
+
+	return clk_stm32_is_enabled_gate(composite->base, composite->clock_data,
+					 composite->gate_id);
+}
+
+static void clk_stm32_composite_disable_unused(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	unsigned long flags = 0;
+
+	if (composite->gate_id == NO_STM32_GATE)
+		return;
+
+	spin_lock_irqsave(composite->lock, flags);
+
+	clk_stm32_disable_unused_gate(composite->base, composite->clock_data,
+				      composite->gate_id);
+
+	spin_unlock_irqrestore(composite->lock, flags);
+}
+
+const struct clk_ops clk_stm32_composite_ops = {
+	.set_rate	= clk_stm32_composite_set_rate,
+	.recalc_rate	= clk_stm32_composite_recalc_rate,
+	.round_rate	= clk_stm32_composite_round_rate,
+	.get_parent	= clk_stm32_composite_get_parent,
+	.set_parent	= clk_stm32_composite_set_parent,
+	.enable		= clk_stm32_composite_gate_enable,
+	.disable	= clk_stm32_composite_gate_disable,
+	.is_enabled	= clk_stm32_composite_is_enabled,
+	.disable_unused	= clk_stm32_composite_disable_unused,
+};
+
 struct clk_hw *clk_stm32_gate_register(struct device *dev,
 				       const struct stm32_rcc_match_data *data,
 				       void __iomem *base,
@@ -455,3 +615,24 @@ struct clk_hw *clk_stm32_mux_register(struct device *dev,
 
 	return hw;
 }
+
+struct clk_hw *clk_stm32_composite_register(struct device *dev,
+					    const struct stm32_rcc_match_data *data,
+					    void __iomem *base,
+					    spinlock_t *lock,
+					    const struct clock_config *cfg)
+{
+	struct clk_stm32_composite *composite = cfg->clock_cfg;
+	struct clk_hw *hw = &composite->hw;
+	int err;
+
+	composite->base = base;
+	composite->lock = lock;
+	composite->clock_data = data->clock_data;
+
+	err = clk_hw_register(dev, hw);
+	if (err)
+		return ERR_PTR(err);
+
+	return hw;
+}
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index 833a3d4a064f..846d063ecc6f 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -114,6 +114,18 @@ struct clk_stm32_mux {
 
 #define to_clk_stm32_mux(_hw) container_of(_hw, struct clk_stm32_mux, hw)
 
+struct clk_stm32_composite {
+	u16 gate_id;
+	u16 mux_id;
+	u16 div_id;
+	struct clk_hw hw;
+	void __iomem *base;
+	struct clk_stm32_clock_data *clock_data;
+	spinlock_t *lock; /* spin lock */
+};
+
+#define to_clk_stm32_composite(_hw) container_of(_hw, struct clk_stm32_composite, hw)
+
 /* Clock ops */
 void clk_stm32_endisable_gate(void __iomem *base,
 			      struct clk_stm32_clock_data *data,
@@ -156,9 +168,20 @@ int clk_stm32_set_parent_mux(void __iomem *base,
 u8 clk_stm32_mux_get_parent(struct clk_hw *hw);
 int clk_stm32_mux_set_parent(struct clk_hw *hw, u8 index);
 
+void clk_stm32_composite_gate_endisable(struct clk_hw *hw, int enable);
+int clk_stm32_composite_gate_enable(struct clk_hw *hw);
+void clk_stm32_composite_gate_disable(struct clk_hw *hw);
+int clk_stm32_composite_is_enabled(struct clk_hw *hw);
+u8 clk_stm32_composite_get_parent(struct clk_hw *hw);
+int clk_stm32_composite_set_parent(struct clk_hw *hw, u8 index);
+unsigned long clk_stm32_composite_recalc_rate(struct clk_hw *hw, unsigned long parent_rate);
+long clk_stm32_composite_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate);
+int clk_stm32_composite_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate);
+
 extern const struct clk_ops clk_stm32_gate_ops;
 extern const struct clk_ops clk_stm32_divider_ops;
 extern const struct clk_ops clk_stm32_mux_ops;
+extern const struct clk_ops clk_stm32_composite_ops;
 
 /* Clock registering */
 struct clk_hw *clk_stm32_gate_register(struct device *dev,
@@ -179,6 +202,12 @@ struct clk_hw *clk_stm32_mux_register(struct device *dev,
 				      spinlock_t *lock,
 				      const struct clock_config *cfg);
 
+struct clk_hw *clk_stm32_composite_register(struct device *dev,
+					    const struct stm32_rcc_match_data *data,
+					    void __iomem *base,
+					    spinlock_t *lock,
+					    const struct clock_config *cfg);
+
 #define STM32_CLOCK_CFG(_binding, _clk, _struct, _register)\
 {\
 	.id		= (_binding),\
@@ -197,3 +226,7 @@ struct clk_hw *clk_stm32_mux_register(struct device *dev,
 #define STM32_MUX_CFG(_binding, _clk)\
 	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_mux *,\
 			&clk_stm32_mux_register)
+
+#define STM32_COMPOSITE_CFG(_binding, _clk)\
+	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_composite *,\
+			&clk_stm32_composite_register)
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 66ebfe810b08..1b27c5d4b97d 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -404,6 +404,14 @@ static const char * const eth12_src[] = {
 	"pll4_p", "pll3_q"
 };
 
+static const char * const mco1_src[] = {
+	"ck_hsi", "ck_hse", "ck_csi", "ck_lsi", "ck_lse"
+};
+
+static const char * const mco2_src[] = {
+	"ck_mpu", "ck_axi", "ck_mlahb", "pll4_p", "ck_hse", "ck_hsi"
+};
+
 static struct clk_stm32_mux ck_ker_eth1 = {
 	.mux_id = MUX_ETH1,
 	.hw.init = CLK_HW_INIT_PARENTS("ck_ker_eth1", eth12_src, &clk_stm32_mux_ops,
@@ -421,10 +429,30 @@ static struct clk_stm32_div eth1ptp_k = {
 				  CLK_SET_RATE_NO_REPARENT),
 };
 
+static struct clk_stm32_composite ck_mco1 = {
+	.gate_id = GATE_MCO1,
+	.mux_id = MUX_MCO1,
+	.div_id = DIV_MCO1,
+	.hw.init = CLK_HW_INIT_PARENTS("ck_mco1", mco1_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT |
+				       CLK_IGNORE_UNUSED),
+};
+
+static struct clk_stm32_composite ck_mco2 = {
+	.gate_id = GATE_MCO2,
+	.mux_id = MUX_MCO2,
+	.div_id = DIV_MCO2,
+	.hw.init = CLK_HW_INIT_PARENTS("ck_mco2", mco2_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT |
+				       CLK_IGNORE_UNUSED),
+};
+
 static const struct clock_config stm32mp13_clock_cfg[] = {
 	STM32_MUX_CFG(NO_ID, ck_ker_eth1),
 	STM32_GATE_CFG(ETH1CK_K, eth1ck_k),
 	STM32_DIV_CFG(ETH1PTP_K, eth1ptp_k),
+	STM32_COMPOSITE_CFG(CK_MCO1, ck_mco1),
+	STM32_COMPOSITE_CFG(CK_MCO2, ck_mco2),
 };
 
 u16 stm32mp13_cpt_gate[GATE_NB];
-- 
2.25.1

