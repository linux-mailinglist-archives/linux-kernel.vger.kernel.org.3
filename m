Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8714C4674
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbiBYNeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbiBYNd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:33:57 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9AA20BCDD;
        Fri, 25 Feb 2022 05:33:25 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21PDGZ6Y003206;
        Fri, 25 Feb 2022 14:33:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=SzLXOSkhzGzN5m22rAwAREfKfOZltcH16yNIJ5ynJA4=;
 b=LLNUtAF9QF2ZYfieOw0ljVt2iqUp+nu+OVKkORdPFIdaSzNODag5gyuYnsGVgkneBpCL
 N3Px+BTvSLSlfsAGQkcC9DCZpWDUYq7CFIqGWKFNxe7P8rJJX7+juurMM8iKZslMy5fs
 sZpMbfcg8S7/xo+6cAH9GJGIelDHobxZmhkMxJBDgUGS7HaHchcyCGMRLlhADz4r9k71
 skyozcUSl7D+BmHkcttEtXUYE9UF95izhqxdAFbX93WAPB/WYUlEWV2oeGCVSYWh+TPw
 nIoGZMBq7/zz6tL+5kNuxOViYXOlU0cSMep2uZZymN1feQTc7yLvJyp4HTnUkVp9RBsi Qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3eetrn27mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 14:33:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66B1610002A;
        Fri, 25 Feb 2022 14:33:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5C7712278A4;
        Fri, 25 Feb 2022 14:33:11 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Feb 2022 14:33:11
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
Subject: [PATCH v2 05/13] clk: stm32mp13: add stm32 divider clock
Date:   Fri, 25 Feb 2022 14:31:29 +0100
Message-ID: <20220225133137.813919-6-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
References: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_08,2022-02-25_01,2022-02-23_01
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
 drivers/clk/stm32/clk-stm32-core.c | 161 +++++++++++++++++++++++++++++
 drivers/clk/stm32/clk-stm32-core.h |  36 +++++++
 drivers/clk/stm32/clk-stm32mp13.c  |   7 ++
 3 files changed, 204 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 91eae0386e5e..57d039168779 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -195,6 +195,146 @@ const struct clk_ops clk_stm32_gate_ops = {
 	.disable_unused	= clk_stm32_gate_disable_unused,
 };
 
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
+unsigned long clk_stm32_get_rate_divider(void __iomem *base,
+					 struct clk_stm32_clock_data *data,
+					 u16 div_id, unsigned long parent_rate)
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
+int clk_stm32_set_rate_divider(void __iomem *base,
+			       struct clk_stm32_clock_data *data,
+			       u16 div_id,
+			       unsigned long rate,
+			       unsigned long parent_rate)
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
+int clk_stm32_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
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
+	ret = clk_stm32_set_rate_divider(div->base, div->clock_data, div->div_id,
+					 rate, parent_rate);
+
+	spin_unlock_irqrestore(div->lock, flags);
+
+	return ret;
+}
+
+long clk_stm32_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
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
+unsigned long clk_stm32_divider_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct clk_stm32_div *div = to_clk_stm32_divider(hw);
+
+	if (div->div_id == NO_STM32_DIV)
+		return parent_rate;
+
+	return clk_stm32_get_rate_divider(div->base, div->clock_data,
+					  div->div_id, parent_rate);
+}
+
+const struct clk_ops clk_stm32_divider_ops = {
+	.recalc_rate	= clk_stm32_divider_recalc_rate,
+	.round_rate	= clk_stm32_divider_round_rate,
+	.set_rate	= clk_stm32_divider_set_rate,
+};
+
 u8 clk_stm32_get_parent_mux(void __iomem *base,
 			    struct clk_stm32_clock_data *data,
 			    u16 mux_id)
@@ -274,6 +414,27 @@ struct clk_hw *clk_stm32_gate_register(struct device *dev,
 	return hw;
 }
 
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
+
 struct clk_hw *clk_stm32_mux_register(struct device *dev,
 				      const struct stm32_rcc_match_data *data,
 				      void __iomem *base,
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index 1b4a73556512..833a3d4a064f 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -94,6 +94,16 @@ struct clk_stm32_gate {
 
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
 struct clk_stm32_mux {
 	u16 mux_id;
 	struct clk_hw hw;
@@ -121,6 +131,21 @@ void clk_stm32_gate_disable(struct clk_hw *hw);
 int clk_stm32_gate_is_enabled(struct clk_hw *hw);
 void clk_stm32_gate_disable_unused(struct clk_hw *hw);
 
+int clk_stm32_set_rate_divider(void __iomem *base,
+			       struct clk_stm32_clock_data *data,
+			       u16 div_id, unsigned long rate,
+			       unsigned long parent_rate);
+unsigned long clk_stm32_get_rate_divider(void __iomem *base,
+					 struct clk_stm32_clock_data *data,
+					 u16 div_id, unsigned long parent_rate);
+
+int clk_stm32_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate);
+long clk_stm32_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate);
+unsigned long clk_stm32_divider_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate);
+
 u8 clk_stm32_get_parent_mux(void __iomem *base,
 			    struct clk_stm32_clock_data *data, u16 mux_id);
 
@@ -132,6 +157,7 @@ u8 clk_stm32_mux_get_parent(struct clk_hw *hw);
 int clk_stm32_mux_set_parent(struct clk_hw *hw, u8 index);
 
 extern const struct clk_ops clk_stm32_gate_ops;
+extern const struct clk_ops clk_stm32_divider_ops;
 extern const struct clk_ops clk_stm32_mux_ops;
 
 /* Clock registering */
@@ -141,6 +167,12 @@ struct clk_hw *clk_stm32_gate_register(struct device *dev,
 				       spinlock_t *lock,
 				       const struct clock_config *cfg);
 
+struct clk_hw *clk_stm32_div_register(struct device *dev,
+				      const struct stm32_rcc_match_data *data,
+				      void __iomem *base,
+				      spinlock_t *lock,
+				      const struct clock_config *cfg);
+
 struct clk_hw *clk_stm32_mux_register(struct device *dev,
 				      const struct stm32_rcc_match_data *data,
 				      void __iomem *base,
@@ -158,6 +190,10 @@ struct clk_hw *clk_stm32_mux_register(struct device *dev,
 	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_gate *,\
 			&clk_stm32_gate_register)
 
+#define STM32_DIV_CFG(_binding, _clk)\
+	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_div *,\
+			&clk_stm32_div_register)
+
 #define STM32_MUX_CFG(_binding, _clk)\
 	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_mux *,\
 			&clk_stm32_mux_register)
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 24c0c9ff3602..66ebfe810b08 100644
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
 
 u16 stm32mp13_cpt_gate[GATE_NB];
-- 
2.25.1

