Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0FB4DB0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356093AbiCPNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355998AbiCPNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:12:43 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7755F8D7;
        Wed, 16 Mar 2022 06:11:24 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GAFxGH001886;
        Wed, 16 Mar 2022 14:11:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=5JdwOYbAWhiElIir3yc1zTehwjupY28JyCqayddrPog=;
 b=HuTp9q972IDYxcxpQl+pLtv2kf8EJiwO61oC7pM6fnz6FS3wiN9MfWxOac/nzy/GlNez
 06MmE+KMSdYR2GXhvkATtGw9V+YodcYAh45Lw4vSe2914RXpFiQPjbNOMTfsv5T2JJXs
 zgHU4dJNUJ9xY4nsWtsL2ATCLEo/QuLKj/ErXWU//EbBMlJuSjCfhogFiBBpPeZdggfw
 T8FxLnR7WVZA85kP6+cTjkqN3xzVoYt8y8ECYDlrEvzfLIu8acErNnk0w0DU6+2OO2Pz
 VN0cQspMCx3C+l0lZdK/FaJAF5DkzGHT9AeBDpNjKwfT3rsmH/FX1lXl5s9QmErua+Qk Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ethxu2heh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 14:11:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB959100034;
        Wed, 16 Mar 2022 14:11:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A3D462278A6;
        Wed, 16 Mar 2022 14:11:11 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 16 Mar 2022 14:11:11
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
Subject: [PATCH RESEND v3 05/13] clk: stm32mp13: add stm32 divider clock
Date:   Wed, 16 Mar 2022 14:09:52 +0100
Message-ID: <20220316131000.9874-6-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316131000.9874-1-gabriel.fernandez@foss.st.com>
References: <20220316131000.9874-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_05,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Just to introduce management of a stm32 divider clock

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32-core.c | 159 +++++++++++++++++++++++++++++
 drivers/clk/stm32/clk-stm32-core.h |  21 ++++
 drivers/clk/stm32/clk-stm32mp13.c  |   7 ++
 3 files changed, 187 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index ca2605da873d..da38eca2b8c5 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -175,6 +175,80 @@ static int stm32_gate_is_enabled(void __iomem *base,
 	return (readl(base + gate->offset) & BIT(gate->bit_idx)) != 0;
 }
 
+static unsigned int _get_table_div(const struct clk_div_table *table,
+				   unsigned int val)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->val == val)
+			return clkt->div;
+	return 0;
+}
+
+static unsigned int _get_div(const struct clk_div_table *table,
+			     unsigned int val, unsigned long flags, u8 width)
+{
+	if (flags & CLK_DIVIDER_ONE_BASED)
+		return val;
+	if (flags & CLK_DIVIDER_POWER_OF_TWO)
+		return 1 << val;
+	if (table)
+		return _get_table_div(table, val);
+	return val + 1;
+}
+
+static unsigned long stm32_divider_get_rate(void __iomem *base,
+					    struct clk_stm32_clock_data *data,
+					    u16 div_id,
+					    unsigned long parent_rate)
+{
+	const struct stm32_div_cfg *divider = &data->dividers[div_id];
+	unsigned int val;
+	unsigned int div;
+
+	val =  readl(base + divider->offset) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+	div = _get_div(divider->table, val, divider->flags, divider->width);
+
+	if (!div) {
+		WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
+		     "%d: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
+		     div_id);
+		return parent_rate;
+	}
+
+	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+}
+
+static int stm32_divider_set_rate(void __iomem *base,
+				  struct clk_stm32_clock_data *data,
+				  u16 div_id, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	const struct stm32_div_cfg *divider = &data->dividers[div_id];
+	int value;
+	u32 val;
+
+	value = divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+		val = clk_div_mask(divider->width) << (divider->shift + 16);
+	} else {
+		val = readl(base + divider->offset);
+		val &= ~(clk_div_mask(divider->width) << divider->shift);
+	}
+
+	val |= (u32)value << divider->shift;
+
+	writel(val, base + divider->offset);
+
+	return 0;
+}
+
 static u8 clk_stm32_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_stm32_mux *mux = to_clk_stm32_mux(hw);
@@ -251,6 +325,70 @@ const struct clk_ops clk_stm32_gate_ops = {
 	.disable_unused	= clk_stm32_gate_disable_unused,
 };
 
+static int clk_stm32_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct clk_stm32_div *div = to_clk_stm32_divider(hw);
+	unsigned long flags = 0;
+	int ret;
+
+	if (div->div_id == NO_STM32_DIV)
+		return rate;
+
+	spin_lock_irqsave(div->lock, flags);
+
+	ret = stm32_divider_set_rate(div->base, div->clock_data, div->div_id, rate, parent_rate);
+
+	spin_unlock_irqrestore(div->lock, flags);
+
+	return ret;
+}
+
+static long clk_stm32_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+					 unsigned long *prate)
+{
+	struct clk_stm32_div *div = to_clk_stm32_divider(hw);
+	const struct stm32_div_cfg *divider;
+
+	if (div->div_id == NO_STM32_DIV)
+		return rate;
+
+	divider = &div->clock_data->dividers[div->div_id];
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		u32 val;
+
+		val =  readl(div->base + divider->offset) >> divider->shift;
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
+static unsigned long clk_stm32_divider_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct clk_stm32_div *div = to_clk_stm32_divider(hw);
+
+	if (div->div_id == NO_STM32_DIV)
+		return parent_rate;
+
+	return stm32_divider_get_rate(div->base, div->clock_data, div->div_id, parent_rate);
+}
+
+const struct clk_ops clk_stm32_divider_ops = {
+	.recalc_rate	= clk_stm32_divider_recalc_rate,
+	.round_rate	= clk_stm32_divider_round_rate,
+	.set_rate	= clk_stm32_divider_set_rate,
+};
+
 struct clk_hw *clk_stm32_mux_register(struct device *dev,
 				      const struct stm32_rcc_match_data *data,
 				      void __iomem *base,
@@ -292,3 +430,24 @@ struct clk_hw *clk_stm32_gate_register(struct device *dev,
 
 	return hw;
 }
+
+struct clk_hw *clk_stm32_div_register(struct device *dev,
+				      const struct stm32_rcc_match_data *data,
+				      void __iomem *base,
+				      spinlock_t *lock,
+				      const struct clock_config *cfg)
+{
+	struct clk_stm32_div *div = cfg->clock_cfg;
+	struct clk_hw *hw = &div->hw;
+	int err;
+
+	div->base = base;
+	div->lock = lock;
+	div->clock_data = data->clock_data;
+
+	err = clk_hw_register(dev, hw);
+	if (err)
+		return ERR_PTR(err);
+
+	return hw;
+}
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index f958ef610f72..c2de58a22aa8 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -104,9 +104,20 @@ struct clk_stm32_gate {
 
 #define to_clk_stm32_gate(_hw) container_of(_hw, struct clk_stm32_gate, hw)
 
+struct clk_stm32_div {
+	u16 div_id;
+	struct clk_hw hw;
+	void __iomem *base;
+	struct clk_stm32_clock_data *clock_data;
+	spinlock_t *lock; /* spin lock */
+};
+
+#define to_clk_stm32_divider(_hw) container_of(_hw, struct clk_stm32_div, hw)
+
 /* Clock operators */
 extern const struct clk_ops clk_stm32_mux_ops;
 extern const struct clk_ops clk_stm32_gate_ops;
+extern const struct clk_ops clk_stm32_divider_ops;
 
 /* Clock registering */
 struct clk_hw *clk_stm32_mux_register(struct device *dev,
@@ -121,6 +132,12 @@ struct clk_hw *clk_stm32_gate_register(struct device *dev,
 				       spinlock_t *lock,
 				       const struct clock_config *cfg);
 
+struct clk_hw *clk_stm32_div_register(struct device *dev,
+				      const struct stm32_rcc_match_data *data,
+				      void __iomem *base,
+				      spinlock_t *lock,
+				      const struct clock_config *cfg);
+
 #define STM32_CLOCK_CFG(_binding, _clk, _struct, _register)\
 {\
 	.id		= (_binding),\
@@ -135,3 +152,7 @@ struct clk_hw *clk_stm32_gate_register(struct device *dev,
 #define STM32_GATE_CFG(_binding, _clk)\
 	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_gate *,\
 			&clk_stm32_gate_register)
+
+#define STM32_DIV_CFG(_binding, _clk)\
+	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_div *,\
+			&clk_stm32_div_register)
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 55326d4d34dd..d93d92b5fe82 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -415,9 +415,16 @@ static struct clk_stm32_gate eth1ck_k = {
 	.hw.init = CLK_HW_INIT_HW("eth1ck_k", &ck_ker_eth1.hw, &clk_stm32_gate_ops, 0),
 };
 
+static struct clk_stm32_div eth1ptp_k = {
+	.div_id = DIV_ETH1PTP,
+	.hw.init = CLK_HW_INIT_HW("eth1ptp_k", &ck_ker_eth1.hw, &clk_stm32_divider_ops,
+				  CLK_SET_RATE_NO_REPARENT),
+};
+
 static const struct clock_config stm32mp13_clock_cfg[] = {
 	STM32_MUX_CFG(NO_ID, ck_ker_eth1),
 	STM32_GATE_CFG(ETH1CK_K, eth1ck_k),
+	STM32_DIV_CFG(ETH1PTP_K, eth1ptp_k),
 };
 
 static u16 stm32mp13_cpt_gate[GATE_NB];
-- 
2.25.1

