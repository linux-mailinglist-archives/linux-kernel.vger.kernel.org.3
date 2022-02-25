Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EB84C4696
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbiBYNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbiBYNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:34:58 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205F1DB3C6;
        Fri, 25 Feb 2022 05:34:26 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21PD4i3S003178;
        Fri, 25 Feb 2022 14:34:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=T0hES+frT2cGbNMPSgvAWoyBLQHw6p0nNIHn15fvCf8=;
 b=MWoxmADL8l8GhfUqNaxopRTmLdg+nVAAm8nEuJ8l+gnt7Bd2qE/vQi0OJUCnoX0Fp6cu
 GcSJgwv6YMd7fV/sSv5BVjyHsvJo/88exa/EEtKvR60pYdytxkkXcSzoBRgyME3eqMm/
 TPEWYap1vFag0z+43gvugIO3zeO54K1kKCJoWsK5VVhhUjYLbRevGYsaTLpPw7vZFeTA
 SV5WqmJUADV1kxZ66DlQRTK3m8ExTqsDw29podWQK0MtfK9FLumbfISLBx4PECISv2f+
 ypkRIxS66h/UA+QZd8anMkXGTdt5TOk7phk3dzhmUYnuzvzZDDNlEExP51dKfOwPNIhv xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3eetrn27uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 14:34:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 883EC100034;
        Fri, 25 Feb 2022 14:34:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F8FA2278AA;
        Fri, 25 Feb 2022 14:34:14 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Feb 2022 14:34:14
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
Subject: [PATCH v2 11/13] clk: stm32mp13: add safe mux management
Date:   Fri, 25 Feb 2022 14:31:35 +0100
Message-ID: <20220225133137.813919-12-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
References: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
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

Some muxes need to set a the safe position when clock is off.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32-core.c | 55 ++++++++++++++++++++++++++++++
 drivers/clk/stm32/clk-stm32-core.h |  1 +
 drivers/clk/stm32/clk-stm32mp13.c  | 11 +++---
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 69cfa2d1b8e2..d1fe9e5dfdbb 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -397,6 +397,55 @@ const struct clk_ops clk_stm32_mux_ops = {
 	.set_parent	= clk_stm32_mux_set_parent,
 };
 
+#define MUX_SAFE_POSITION 0
+
+static int clk_stm32_has_safe_mux(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	const struct stm32_mux_cfg *mux = &composite->clock_data->muxes[composite->mux_id];
+
+	return !!(mux->flags & MUX_SAFE);
+}
+
+static void clk_stm32_set_safe_position_mux(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+
+	if (!clk_stm32_composite_is_enabled(hw)) {
+		unsigned long flags = 0;
+
+		if (composite->clock_data->is_multi_mux) {
+			struct clk_hw *other_mux_hw = NULL;
+
+			other_mux_hw = composite->clock_data->is_multi_mux(hw);
+
+			if (!other_mux_hw || clk_stm32_composite_is_enabled(other_mux_hw))
+				return;
+		}
+
+		spin_lock_irqsave(composite->lock, flags);
+
+		clk_stm32_set_parent_mux(composite->base, composite->clock_data,
+					 composite->mux_id, MUX_SAFE_POSITION);
+
+		spin_unlock_irqrestore(composite->lock, flags);
+	}
+}
+
+static void clk_stm32_safe_restore_position_mux(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	int sel = clk_hw_get_parent_index(hw);
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(composite->lock, flags);
+
+	clk_stm32_set_parent_mux(composite->base, composite->clock_data,
+				 composite->mux_id, sel);
+
+	spin_unlock_irqrestore(composite->lock, flags);
+}
+
 int clk_stm32_composite_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long parent_rate)
 {
@@ -515,6 +564,9 @@ int clk_stm32_composite_gate_enable(struct clk_hw *hw)
 
 	clk_stm32_composite_gate_endisable(hw, 1);
 
+	if (composite->mux_id != NO_STM32_MUX && clk_stm32_has_safe_mux(hw))
+		clk_stm32_safe_restore_position_mux(hw);
+
 	return 0;
 }
 
@@ -526,6 +578,9 @@ void clk_stm32_composite_gate_disable(struct clk_hw *hw)
 		return;
 
 	clk_stm32_composite_gate_endisable(hw, 0);
+
+	if (composite->mux_id != NO_STM32_MUX && clk_stm32_has_safe_mux(hw))
+		clk_stm32_set_safe_position_mux(hw);
 }
 
 int clk_stm32_composite_is_enabled(struct clk_hw *hw)
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index 61a7b4bb6a19..5a99998c74d9 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -84,6 +84,7 @@ int stm32_rcc_init(struct device *dev, const struct of_device_id *match_data,
 
 /* MUX define */
 #define MUX_NO_RDY		0xFF
+#define MUX_SAFE		BIT(7)
 
 /* DIV define */
 #define DIV_NO_RDY		0xFF
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 783a54e08439..30ecf66f9529 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -359,6 +359,9 @@ enum enum_mux_cfg {
 #define CFG_MUX(_id, _offset, _shift, _witdh)\
 	_CFG_MUX(_id, _offset, _shift, _witdh, MUX_NO_RDY, 0)
 
+#define CFG_MUX_SAFE(_id, _offset, _shift, _witdh)\
+	_CFG_MUX(_id, _offset, _shift, _witdh, MUX_NO_RDY, MUX_SAFE)
+
 static const struct stm32_mux_cfg stm32mp13_muxes[] = {
 	CFG_MUX(MUX_I2C12,	RCC_I2C12CKSELR,	0, 3),
 	CFG_MUX(MUX_LPTIM45,	RCC_LPTIM45CKSELR,	0, 3),
@@ -394,10 +397,10 @@ static const struct stm32_mux_cfg stm32mp13_muxes[] = {
 	CFG_MUX(MUX_UART6,	RCC_UART6CKSELR,	0, 3),
 	CFG_MUX(MUX_USBO,	RCC_USBCKSELR,		4, 1),
 	CFG_MUX(MUX_USBPHY,	RCC_USBCKSELR,		0, 2),
-	CFG_MUX(MUX_FMC,	RCC_FMCCKSELR,		0, 2),
-	CFG_MUX(MUX_QSPI,	RCC_QSPICKSELR,		0, 2),
-	CFG_MUX(MUX_SDMMC1,	RCC_SDMMC12CKSELR,	0, 3),
-	CFG_MUX(MUX_SDMMC2,	RCC_SDMMC12CKSELR,	3, 3),
+	CFG_MUX_SAFE(MUX_FMC,	RCC_FMCCKSELR,		0, 2),
+	CFG_MUX_SAFE(MUX_QSPI,	RCC_QSPICKSELR,		0, 2),
+	CFG_MUX_SAFE(MUX_SDMMC1, RCC_SDMMC12CKSELR,	0, 3),
+	CFG_MUX_SAFE(MUX_SDMMC2, RCC_SDMMC12CKSELR,	3, 3),
 };
 
 struct clk_stm32_securiy {
-- 
2.25.1

