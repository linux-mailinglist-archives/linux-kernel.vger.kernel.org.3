Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5F4C46A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbiBYNfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiBYNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:34:57 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F61DB3C1;
        Fri, 25 Feb 2022 05:34:24 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21P9a5LH019229;
        Fri, 25 Feb 2022 14:34:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=TT2fZVNlHK9vb5NNbFYqvqP0J/vHa5Erb6Q7BQphl7M=;
 b=yITRAYpl4ESTtL+rBulsalsdd/+Jh54n1doKEQB39eSbUV76vNn5o4+slbanGzyaggjp
 I4MtsNbuRveHgcGQ5d3RfT0yV0cKSaX6Lfy/TRNWju5FEocnVMn+TceNOeAdQyZBeMK6
 Vf8KhRwCzXnOAjIb2yOZOEDYtfOZ5RYKsPDg2SvxbUw3o6k7kdklzXaSt8r0BINrc35Q
 6DiZ+RpyG9qv/d7Z3maZMlvxEUW482T3aY90CNsnOe0GMwNLhP/FWo5J0xwzwa31nqAm
 blyj4eQ/lW9IhZ7PfU8LMPWKv6J/zgFLNiuXp2Vh4/9s+aI3aPDwBjUm3mUaxHV9l0kd LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3eevmgsa1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 14:34:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F378A10002A;
        Fri, 25 Feb 2022 14:34:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EB9582278AA;
        Fri, 25 Feb 2022 14:34:13 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Feb 2022 14:34:13
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
Subject: [PATCH v2 10/13] clk: stm32mp13: add multi mux function
Date:   Fri, 25 Feb 2022 14:31:34 +0100
Message-ID: <20220225133137.813919-11-gabriel.fernandez@foss.st.com>
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

Some RCC muxes can manages two output clocks with same register.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32-core.c | 10 ++++++++++
 drivers/clk/stm32/clk-stm32-core.h |  2 ++
 drivers/clk/stm32/clk-stm32mp13.c  | 30 ++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index fc32e62e0b44..69cfa2d1b8e2 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -480,6 +480,16 @@ int clk_stm32_composite_set_parent(struct clk_hw *hw, u8 index)
 
 	spin_unlock_irqrestore(composite->lock, flags);
 
+	if (composite->clock_data->is_multi_mux) {
+		struct clk_hw *other_mux_hw = composite->clock_data->is_multi_mux(hw);
+
+		if (other_mux_hw) {
+			struct clk_hw *hwp = clk_hw_get_parent_by_index(hw, index);
+
+			clk_hw_reparent(other_mux_hw, hwp);
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index 8ffa700323b8..61a7b4bb6a19 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -61,6 +61,7 @@ struct clk_stm32_clock_data {
 	const struct stm32_gate_cfg	*gates;
 	const struct stm32_mux_cfg	*muxes;
 	const struct stm32_div_cfg	*dividers;
+	struct clk_hw *(*is_multi_mux)(struct clk_hw *hw);
 };
 
 struct stm32_rcc_match_data {
@@ -72,6 +73,7 @@ struct stm32_rcc_match_data {
 	u32				clear_offset;
 	int (*check_security)(void __iomem *base,
 			      const struct clock_config *cfg);
+	int (*multi_mux)(void __iomem *base, const struct clock_config *cfg);
 };
 
 int stm32_rcc_reset_init(struct device *dev, const struct of_device_id *match,
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 462e00877474..783a54e08439 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -1429,6 +1429,35 @@ static int stm32mp13_clock_is_provided_by_secure(void __iomem *base,
 	return 0;
 }
 
+struct multi_mux {
+	struct clk_hw *hw1;
+	struct clk_hw *hw2;
+};
+
+static struct multi_mux *stm32_mp13_multi_mux[MUX_NB] = {
+	[MUX_SPI23]	= &(struct multi_mux){ &spi2_k.hw,	&spi3_k.hw },
+	[MUX_I2C12]	= &(struct multi_mux){ &i2c1_k.hw,	&i2c2_k.hw },
+	[MUX_LPTIM45]	= &(struct multi_mux){ &lptim4_k.hw,	&lptim5_k.hw },
+	[MUX_UART35]	= &(struct multi_mux){ &usart3_k.hw,	&uart5_k.hw },
+	[MUX_UART78]	= &(struct multi_mux){ &uart7_k.hw,	&uart8_k.hw },
+	[MUX_SAI1]	= &(struct multi_mux){ &sai1_k.hw,	&adfsdm_k.hw },
+};
+
+static struct clk_hw *stm32mp13_is_multi_mux(struct clk_hw *hw)
+{
+	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
+	struct multi_mux *mmux = stm32_mp13_multi_mux[composite->mux_id];
+
+	if (mmux) {
+		if (!(mmux->hw1 == hw))
+			return mmux->hw1;
+		else
+			return mmux->hw2;
+	}
+
+	return NULL;
+}
+
 u16 stm32mp13_cpt_gate[GATE_NB];
 
 struct clk_stm32_clock_data stm32mp13_clock_data = {
@@ -1436,6 +1465,7 @@ struct clk_stm32_clock_data stm32mp13_clock_data = {
 	.gates		= stm32mp13_gates,
 	.muxes		= stm32mp13_muxes,
 	.dividers	= stm32mp13_dividers,
+	.is_multi_mux	= stm32mp13_is_multi_mux,
 };
 
 static const struct stm32_rcc_match_data stm32mp13_data = {
-- 
2.25.1

