Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0A527E25
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiEPHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240791AbiEPHHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:07:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80839DFD4;
        Mon, 16 May 2022 00:07:21 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FHw6IK017719;
        Mon, 16 May 2022 09:07:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=aNAKiDgQmVMtARYEnjcXeEx9NYRt10Bq/PSrWEIvoQw=;
 b=tALnBMm5ebLyD0RaF6GILCmKFv0qfA5XSd9nuFBPEa/VE4GCt67fe3xTqkE/blZxKNBw
 etu5P+7/9jTo1ewMYdhoQr2HjY9spJsCbmOE0gGGE/GNK1vjMf+VZxwHlHbm2Ua0n3le
 4dMMSAiBS7FjqOy+gNOGJnfDcQNsGN/DykOKGeCbjGeCeqx0pCO3ioKABCrBgM+o9Kqa
 AKuGP07ELxGuRU76iaKm6fIXIPFzp9l82mtlP+yf6mKmxvLVEC3jh8J1BgfC7EuaANaU
 XR4hsVogB/C+2dikigYXP+bVRkSJLkUl2ssZ9tW9jEyblnoQ/Ep9lSg+46sdKzgHvi/J Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21j8h36s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 09:07:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF5D5100038;
        Mon, 16 May 2022 09:07:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B81B82122FD;
        Mon, 16 May 2022 09:07:06 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 09:07:06
 +0200
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
Subject: [PATCH v4 06/14] clk: stm32mp13: add composite clock
Date:   Mon, 16 May 2022 09:05:52 +0200
Message-ID: <20220516070600.7692-7-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_03,2022-05-13_01,2022-02-23_01
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
 drivers/clk/stm32/clk-stm32-core.c | 174 +++++++++++++++++++++++++++++
 drivers/clk/stm32/clk-stm32-core.h |  23 ++++
 drivers/clk/stm32/clk-stm32mp13.c  |  28 +++++
 3 files changed, 225 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index da38eca2b8c5..69e40c152d2f 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -389,6 +389,159 @@ const struct clk_ops clk_stm32_divider_ops = {
 	.set_rate	= clk_stm32_divider_set_rate,
 };
 
+static int clk_stm32_composite_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
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
+	ret = stm32_divider_set_rate(composite->base, composite->clock_data,
+				     composite->div_id, rate, parent_rate);
+
+	spin_unlock_irqrestore(composite->lock, flags);
+
+	return ret;
+}
+
+static unsigned long clk_stm32_composite_recalc_rate(struct clk_hw *hw,
+						     unsigned long parent_rate)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	if (composite->div_id == NO_STM32_DIV)
+		return parent_rate;
+
+	return stm32_divider_get_rate(composite->base, composite->clock_data,
+				      composite->div_id, parent_rate);
+}
+
+static long clk_stm32_composite_round_rate(struct clk_hw *hw, unsigned long rate,
+					   unsigned long *prate)
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
+static u8 clk_stm32_composite_get_parent(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	return stm32_mux_get_parent(composite->base, composite->clock_data, composite->mux_id);
+}
+
+static int clk_stm32_composite_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(composite->lock, flags);
+
+	stm32_mux_set_parent(composite->base, composite->clock_data, composite->mux_id, index);
+
+	spin_unlock_irqrestore(composite->lock, flags);
+
+	return 0;
+}
+
+static int clk_stm32_composite_is_enabled(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	if (composite->gate_id == NO_STM32_GATE)
+		return (__clk_get_enable_count(hw->clk) > 0);
+
+	return stm32_gate_is_enabled(composite->base, composite->clock_data, composite->gate_id);
+}
+
+static void clk_stm32_composite_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(composite->lock, flags);
+
+	stm32_gate_endisable(composite->base, composite->clock_data, composite->gate_id, enable);
+
+	spin_unlock_irqrestore(composite->lock, flags);
+}
+
+static int clk_stm32_composite_gate_enable(struct clk_hw *hw)
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
+static void clk_stm32_composite_gate_disable(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	if (composite->gate_id == NO_STM32_GATE)
+		return;
+
+	clk_stm32_composite_gate_endisable(hw, 0);
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
+	stm32_gate_disable_unused(composite->base, composite->clock_data, composite->gate_id);
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
 struct clk_hw *clk_stm32_mux_register(struct device *dev,
 				      const struct stm32_rcc_match_data *data,
 				      void __iomem *base,
@@ -451,3 +604,24 @@ struct clk_hw *clk_stm32_div_register(struct device *dev,
 
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
index c2de58a22aa8..6c5c8c08ecbf 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -114,10 +114,23 @@ struct clk_stm32_div {
 
 #define to_clk_stm32_divider(_hw) container_of(_hw, struct clk_stm32_div, hw)
 
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
 /* Clock operators */
 extern const struct clk_ops clk_stm32_mux_ops;
 extern const struct clk_ops clk_stm32_gate_ops;
 extern const struct clk_ops clk_stm32_divider_ops;
+extern const struct clk_ops clk_stm32_composite_ops;
 
 /* Clock registering */
 struct clk_hw *clk_stm32_mux_register(struct device *dev,
@@ -138,6 +151,12 @@ struct clk_hw *clk_stm32_div_register(struct device *dev,
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
@@ -156,3 +175,7 @@ struct clk_hw *clk_stm32_div_register(struct device *dev,
 #define STM32_DIV_CFG(_binding, _clk)\
 	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_div *,\
 			&clk_stm32_div_register)
+
+#define STM32_COMPOSITE_CFG(_binding, _clk)\
+	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_composite *,\
+			&clk_stm32_composite_register)
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index d93d92b5fe82..af9518a0d262 100644
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
 
 static u16 stm32mp13_cpt_gate[GATE_NB];
-- 
2.25.1

