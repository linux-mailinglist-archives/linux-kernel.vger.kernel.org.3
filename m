Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC994DB081
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356082AbiCPNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356044AbiCPNL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:11:56 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102486541D;
        Wed, 16 Mar 2022 06:10:36 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GA8HGY009707;
        Wed, 16 Mar 2022 14:10:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=wRT0JYipMUZ4/OdwtJAQFFdh8ZFZU1+8wrQDfj5TNNo=;
 b=7TJqrODWu34XPtwcP0dsQLzuZRbYRbCAz54d2s1SGpw54gjqS5Z5/fA86444gn74bOiY
 MiQ7+SO5t5cN/6ztDls6JDTwpRdsaOVCrnzIJ/1BpRgHZIUgsantkEXni5orAGn8M4Bz
 X39qsRTPq7RZmMRPojxmacNx1KI/KR3CpxDvHHe9BkLWECTREDxRYJ/zB3P9Gl9SyzaS
 7tFqeaHo21yBc2IbaSbLAOmQLZZ9ebp8cawovHtYOILMMgFlIlLTfM60QDSHac3pmspP
 3tmr0w7MecTcGIIntolXfogGjoZqUZ6JUEPfh+1M9C/3edy147MREKAYV8otk+oO/wbl 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3et63hdp5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 14:10:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E47F10002A;
        Wed, 16 Mar 2022 14:10:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 05D322291A2;
        Wed, 16 Mar 2022 14:10:11 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 16 Mar 2022 14:10:10
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
Subject: [PATCH RESEND v3 04/13] clk: stm32mp13: add stm32_gate management
Date:   Wed, 16 Mar 2022 14:09:51 +0100
Message-ID: <20220316131000.9874-5-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316131000.9874-1-gabriel.fernandez@foss.st.com>
References: <20220316131000.9874-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_04,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Just to introduce management of a stm32 gate clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32-core.c | 122 +++++++++++++++++++++++++++++
 drivers/clk/stm32/clk-stm32-core.h |  21 +++++
 drivers/clk/stm32/clk-stm32mp13.c  |   6 ++
 3 files changed, 149 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 98699093eb21..ca2605da873d 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -124,6 +124,57 @@ static int stm32_mux_set_parent(void __iomem *base,
 	return 0;
 }
 
+static void stm32_gate_endisable(void __iomem *base,
+				 struct clk_stm32_clock_data *data,
+				 u16 gate_id, int enable)
+{
+	const struct stm32_gate_cfg *gate = &data->gates[gate_id];
+	void __iomem *addr = base + gate->offset;
+
+	if (enable) {
+		if (data->gate_cpt[gate_id]++ > 0)
+			return;
+
+		if (gate->set_clr != 0)
+			writel(BIT(gate->bit_idx), addr);
+		else
+			writel(readl(addr) | BIT(gate->bit_idx), addr);
+	} else {
+		if (--data->gate_cpt[gate_id] > 0)
+			return;
+
+		if (gate->set_clr != 0)
+			writel(BIT(gate->bit_idx), addr + gate->set_clr);
+		else
+			writel(readl(addr) & ~BIT(gate->bit_idx), addr);
+	}
+}
+
+static void stm32_gate_disable_unused(void __iomem *base,
+				      struct clk_stm32_clock_data *data,
+				      u16 gate_id)
+{
+	const struct stm32_gate_cfg *gate = &data->gates[gate_id];
+	void __iomem *addr = base + gate->offset;
+
+	if (data->gate_cpt[gate_id] > 0)
+		return;
+
+	if (gate->set_clr != 0)
+		writel(BIT(gate->bit_idx), addr + gate->set_clr);
+	else
+		writel(readl(addr) & ~BIT(gate->bit_idx), addr);
+}
+
+static int stm32_gate_is_enabled(void __iomem *base,
+				 struct clk_stm32_clock_data *data,
+				 u16 gate_id)
+{
+	const struct stm32_gate_cfg *gate = &data->gates[gate_id];
+
+	return (readl(base + gate->offset) & BIT(gate->bit_idx)) != 0;
+}
+
 static u8 clk_stm32_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_stm32_mux *mux = to_clk_stm32_mux(hw);
@@ -150,6 +201,56 @@ const struct clk_ops clk_stm32_mux_ops = {
 	.set_parent	= clk_stm32_mux_set_parent,
 };
 
+static void clk_stm32_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_stm32_gate *gate = to_clk_stm32_gate(hw);
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	stm32_gate_endisable(gate->base, gate->clock_data, gate->gate_id, enable);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static int clk_stm32_gate_enable(struct clk_hw *hw)
+{
+	clk_stm32_gate_endisable(hw, 1);
+
+	return 0;
+}
+
+static void clk_stm32_gate_disable(struct clk_hw *hw)
+{
+	clk_stm32_gate_endisable(hw, 0);
+}
+
+static int clk_stm32_gate_is_enabled(struct clk_hw *hw)
+{
+	struct clk_stm32_gate *gate = to_clk_stm32_gate(hw);
+
+	return stm32_gate_is_enabled(gate->base, gate->clock_data, gate->gate_id);
+}
+
+static void clk_stm32_gate_disable_unused(struct clk_hw *hw)
+{
+	struct clk_stm32_gate *gate = to_clk_stm32_gate(hw);
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	stm32_gate_disable_unused(gate->base, gate->clock_data, gate->gate_id);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+}
+
+const struct clk_ops clk_stm32_gate_ops = {
+	.enable		= clk_stm32_gate_enable,
+	.disable	= clk_stm32_gate_disable,
+	.is_enabled	= clk_stm32_gate_is_enabled,
+	.disable_unused	= clk_stm32_gate_disable_unused,
+};
+
 struct clk_hw *clk_stm32_mux_register(struct device *dev,
 				      const struct stm32_rcc_match_data *data,
 				      void __iomem *base,
@@ -170,3 +271,24 @@ struct clk_hw *clk_stm32_mux_register(struct device *dev,
 
 	return hw;
 }
+
+struct clk_hw *clk_stm32_gate_register(struct device *dev,
+				       const struct stm32_rcc_match_data *data,
+				       void __iomem *base,
+				       spinlock_t *lock,
+				       const struct clock_config *cfg)
+{
+	struct clk_stm32_gate *gate = cfg->clock_cfg;
+	struct clk_hw *hw = &gate->hw;
+	int err;
+
+	gate->base = base;
+	gate->lock = lock;
+	gate->clock_data = data->clock_data;
+
+	err = clk_hw_register(dev, hw);
+	if (err)
+		return ERR_PTR(err);
+
+	return hw;
+}
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index 8563e6e1c91a..f958ef610f72 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -94,8 +94,19 @@ struct clk_stm32_mux {
 
 #define to_clk_stm32_mux(_hw) container_of(_hw, struct clk_stm32_mux, hw)
 
+struct clk_stm32_gate {
+	u16 gate_id;
+	struct clk_hw hw;
+	void __iomem *base;
+	struct clk_stm32_clock_data *clock_data;
+	spinlock_t *lock; /* spin lock */
+};
+
+#define to_clk_stm32_gate(_hw) container_of(_hw, struct clk_stm32_gate, hw)
+
 /* Clock operators */
 extern const struct clk_ops clk_stm32_mux_ops;
+extern const struct clk_ops clk_stm32_gate_ops;
 
 /* Clock registering */
 struct clk_hw *clk_stm32_mux_register(struct device *dev,
@@ -104,6 +115,12 @@ struct clk_hw *clk_stm32_mux_register(struct device *dev,
 				      spinlock_t *lock,
 				      const struct clock_config *cfg);
 
+struct clk_hw *clk_stm32_gate_register(struct device *dev,
+				       const struct stm32_rcc_match_data *data,
+				       void __iomem *base,
+				       spinlock_t *lock,
+				       const struct clock_config *cfg);
+
 #define STM32_CLOCK_CFG(_binding, _clk, _struct, _register)\
 {\
 	.id		= (_binding),\
@@ -114,3 +131,7 @@ struct clk_hw *clk_stm32_mux_register(struct device *dev,
 #define STM32_MUX_CFG(_binding, _clk)\
 	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_mux *,\
 			&clk_stm32_mux_register)
+
+#define STM32_GATE_CFG(_binding, _clk)\
+	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_gate *,\
+			&clk_stm32_gate_register)
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 40568a676111..55326d4d34dd 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -410,8 +410,14 @@ static struct clk_stm32_mux ck_ker_eth1 = {
 				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
 };
 
+static struct clk_stm32_gate eth1ck_k = {
+	.gate_id = GATE_ETH1CK,
+	.hw.init = CLK_HW_INIT_HW("eth1ck_k", &ck_ker_eth1.hw, &clk_stm32_gate_ops, 0),
+};
+
 static const struct clock_config stm32mp13_clock_cfg[] = {
 	STM32_MUX_CFG(NO_ID, ck_ker_eth1),
+	STM32_GATE_CFG(ETH1CK_K, eth1ck_k),
 };
 
 static u16 stm32mp13_cpt_gate[GATE_NB];
-- 
2.25.1

