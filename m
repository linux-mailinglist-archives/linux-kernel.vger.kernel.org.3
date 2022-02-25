Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC5E4C4677
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbiBYNd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiBYNd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:33:57 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC620BCCE;
        Fri, 25 Feb 2022 05:33:25 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21PD5HGj003464;
        Fri, 25 Feb 2022 14:33:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=ttTWXMFriJVCywKTnYHtOeXYaWJ9TXpTQVubwl3aJjQ=;
 b=IMcu5UJMTT6AyKSm+vfxWyWNC9f61obzxYdrcQfzaMcMi1smXEoyo3vQqnH1lBeKka77
 ntTGCbixNkVS8CdcO8vzmRv40rHWh3eoI9fgn4EEhg94JyIn+oZc73l7C8akmecVczSn
 GY55wiI6wm0lidunu1/HdxJVMnSgFnUHxvH9US3REKyN7GGDcvMqnINSuqyLlzEdNcMj
 ZiOLn/QA9rqiCCis/Lcoew83RtA6karxpS+OIiHonGoKmJyj+3DMGB/HmqsU0ofCaT1a
 eI+G1HCWRlQ7uGJ15E4d4NARj+lU+JLdDsp3OsMgAhMOlb9S/yCM2p9kavs7LY1VjmJo gA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3eetrn27mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 14:33:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78EA310002A;
        Fri, 25 Feb 2022 14:33:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CE2F2278A4;
        Fri, 25 Feb 2022 14:33:12 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Feb 2022 14:33:12
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
Subject: [PATCH v2 07/13] clk: stm32mp13: manage secured clocks
Date:   Fri, 25 Feb 2022 14:31:31 +0100
Message-ID: <20220225133137.813919-8-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
References: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
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

Don't register a clock if this clock is secured.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32-core.c |   4 +
 drivers/clk/stm32/clk-stm32-core.h |  22 +++--
 drivers/clk/stm32/clk-stm32mp13.c  | 152 ++++++++++++++++++++++++++++-
 3 files changed, 164 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 3b00918d0753..fc32e62e0b44 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -46,6 +46,10 @@ static int stm32_rcc_clock_init(struct device *dev,
 		const struct clock_config *cfg_clock = &data->tab_clocks[n];
 		struct clk_hw *hw = ERR_PTR(-ENOENT);
 
+		if (data->check_security &&
+		    data->check_security(base, cfg_clock))
+			continue;
+
 		if (cfg_clock->func)
 			hw = (*cfg_clock->func)(dev, data, base, &rlock,
 						cfg_clock);
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index 846d063ecc6f..8ffa700323b8 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -46,6 +46,7 @@ struct stm32_composite_cfg {
 
 struct clock_config {
 	unsigned long	id;
+	int		sec_id;
 	void		*clock_cfg;
 
 	struct clk_hw *(*func)(struct device *dev,
@@ -69,6 +70,8 @@ struct stm32_rcc_match_data {
 	unsigned int			maxbinding;
 	struct clk_stm32_clock_data	*clock_data;
 	u32				clear_offset;
+	int (*check_security)(void __iomem *base,
+			      const struct clock_config *cfg);
 };
 
 int stm32_rcc_reset_init(struct device *dev, const struct of_device_id *match,
@@ -208,25 +211,26 @@ struct clk_hw *clk_stm32_composite_register(struct device *dev,
 					    spinlock_t *lock,
 					    const struct clock_config *cfg);
 
-#define STM32_CLOCK_CFG(_binding, _clk, _struct, _register)\
+#define STM32_CLOCK_CFG(_binding, _clk, _sec_id, _struct, _register)\
 {\
 	.id		= (_binding),\
+	.sec_id		= (_sec_id),\
 	.clock_cfg	= (_struct) {_clk},\
 	.func		= (_register),\
 }
 
-#define STM32_GATE_CFG(_binding, _clk)\
-	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_gate *,\
+#define STM32_GATE_CFG(_binding, _clk, _sec_id)\
+	STM32_CLOCK_CFG(_binding, &(_clk), _sec_id, struct clk_stm32_gate *,\
 			&clk_stm32_gate_register)
 
-#define STM32_DIV_CFG(_binding, _clk)\
-	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_div *,\
+#define STM32_DIV_CFG(_binding, _clk, _sec_id)\
+	STM32_CLOCK_CFG(_binding, &(_clk), _sec_id, struct clk_stm32_div *,\
 			&clk_stm32_div_register)
 
-#define STM32_MUX_CFG(_binding, _clk)\
-	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_mux *,\
+#define STM32_MUX_CFG(_binding, _clk, _sec_id)\
+	STM32_CLOCK_CFG(_binding, &(_clk), _sec_id, struct clk_stm32_mux *,\
 			&clk_stm32_mux_register)
 
-#define STM32_COMPOSITE_CFG(_binding, _clk)\
-	STM32_CLOCK_CFG(_binding, &(_clk), struct clk_stm32_composite *,\
+#define STM32_COMPOSITE_CFG(_binding, _clk, _sec_id)\
+	STM32_CLOCK_CFG(_binding, &(_clk), _sec_id, struct clk_stm32_composite *,\
 			&clk_stm32_composite_register)
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 1b27c5d4b97d..7e83204dd405 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -400,6 +400,131 @@ static const struct stm32_mux_cfg stm32mp13_muxes[] = {
 	CFG_MUX(MUX_SDMMC2,	RCC_SDMMC12CKSELR,	3, 3),
 };
 
+struct clk_stm32_securiy {
+	u32	offset;
+	u8	bit_idx;
+	unsigned long scmi_id;
+};
+
+enum securit_clk {
+	SECF_NONE,
+	SECF_LPTIM2,
+	SECF_LPTIM3,
+	SECF_VREF,
+	SECF_DCMIPP,
+	SECF_USBPHY,
+	SECF_TZC,
+	SECF_ETZPC,
+	SECF_IWDG1,
+	SECF_BSEC,
+	SECF_STGENC,
+	SECF_STGENRO,
+	SECF_USART1,
+	SECF_USART2,
+	SECF_SPI4,
+	SECF_SPI5,
+	SECF_I2C3,
+	SECF_I2C4,
+	SECF_I2C5,
+	SECF_TIM12,
+	SECF_TIM13,
+	SECF_TIM14,
+	SECF_TIM15,
+	SECF_TIM16,
+	SECF_TIM17,
+	SECF_DMA3,
+	SECF_DMAMUX2,
+	SECF_ADC1,
+	SECF_ADC2,
+	SECF_USBO,
+	SECF_TSC,
+	SECF_PKA,
+	SECF_SAES,
+	SECF_CRYP1,
+	SECF_HASH1,
+	SECF_RNG1,
+	SECF_BKPSRAM,
+	SECF_MCE,
+	SECF_FMC,
+	SECF_QSPI,
+	SECF_SDMMC1,
+	SECF_SDMMC2,
+	SECF_ETH1CK,
+	SECF_ETH1TX,
+	SECF_ETH1RX,
+	SECF_ETH1MAC,
+	SECF_ETH1STP,
+	SECF_ETH2CK,
+	SECF_ETH2TX,
+	SECF_ETH2RX,
+	SECF_ETH2MAC,
+	SECF_ETH2STP,
+	SECF_MCO1,
+	SECF_MCO2
+};
+
+#define SECF(_sec_id, _offset, _bit_idx)[_sec_id] = {\
+	.offset	= _offset,\
+	.bit_idx	= _bit_idx,\
+	.scmi_id	= -1,\
+}
+
+static const struct clk_stm32_securiy stm32mp13_security[] = {
+	SECF(SECF_LPTIM2, RCC_APB3SECSR, RCC_APB3SECSR_LPTIM2SECF),
+	SECF(SECF_LPTIM3, RCC_APB3SECSR, RCC_APB3SECSR_LPTIM3SECF),
+	SECF(SECF_VREF, RCC_APB3SECSR, RCC_APB3SECSR_VREFSECF),
+	SECF(SECF_DCMIPP, RCC_APB4SECSR, RCC_APB4SECSR_DCMIPPSECF),
+	SECF(SECF_USBPHY, RCC_APB4SECSR, RCC_APB4SECSR_USBPHYSECF),
+	SECF(SECF_TZC, RCC_APB5SECSR, RCC_APB5SECSR_TZCSECF),
+	SECF(SECF_ETZPC, RCC_APB5SECSR, RCC_APB5SECSR_ETZPCSECF),
+	SECF(SECF_IWDG1, RCC_APB5SECSR, RCC_APB5SECSR_IWDG1SECF),
+	SECF(SECF_BSEC, RCC_APB5SECSR, RCC_APB5SECSR_BSECSECF),
+	SECF(SECF_STGENC, RCC_APB5SECSR, RCC_APB5SECSR_STGENCSECF),
+	SECF(SECF_STGENRO, RCC_APB5SECSR, RCC_APB5SECSR_STGENROSECF),
+	SECF(SECF_USART1, RCC_APB6SECSR, RCC_APB6SECSR_USART1SECF),
+	SECF(SECF_USART2, RCC_APB6SECSR, RCC_APB6SECSR_USART2SECF),
+	SECF(SECF_SPI4, RCC_APB6SECSR, RCC_APB6SECSR_SPI4SECF),
+	SECF(SECF_SPI5, RCC_APB6SECSR, RCC_APB6SECSR_SPI5SECF),
+	SECF(SECF_I2C3, RCC_APB6SECSR, RCC_APB6SECSR_I2C3SECF),
+	SECF(SECF_I2C4, RCC_APB6SECSR, RCC_APB6SECSR_I2C4SECF),
+	SECF(SECF_I2C5, RCC_APB6SECSR, RCC_APB6SECSR_I2C5SECF),
+	SECF(SECF_TIM12, RCC_APB6SECSR, RCC_APB6SECSR_TIM12SECF),
+	SECF(SECF_TIM13, RCC_APB6SECSR, RCC_APB6SECSR_TIM13SECF),
+	SECF(SECF_TIM14, RCC_APB6SECSR, RCC_APB6SECSR_TIM14SECF),
+	SECF(SECF_TIM15, RCC_APB6SECSR, RCC_APB6SECSR_TIM15SECF),
+	SECF(SECF_TIM16, RCC_APB6SECSR, RCC_APB6SECSR_TIM16SECF),
+	SECF(SECF_TIM17, RCC_APB6SECSR, RCC_APB6SECSR_TIM17SECF),
+	SECF(SECF_DMA3, RCC_AHB2SECSR, RCC_AHB2SECSR_DMA3SECF),
+	SECF(SECF_DMAMUX2, RCC_AHB2SECSR, RCC_AHB2SECSR_DMAMUX2SECF),
+	SECF(SECF_ADC1, RCC_AHB2SECSR, RCC_AHB2SECSR_ADC1SECF),
+	SECF(SECF_ADC2, RCC_AHB2SECSR, RCC_AHB2SECSR_ADC2SECF),
+	SECF(SECF_USBO, RCC_AHB2SECSR, RCC_AHB2SECSR_USBOSECF),
+	SECF(SECF_TSC, RCC_AHB4SECSR, RCC_AHB4SECSR_TSCSECF),
+	SECF(SECF_PKA, RCC_AHB5SECSR, RCC_AHB5SECSR_PKASECF),
+	SECF(SECF_SAES, RCC_AHB5SECSR, RCC_AHB5SECSR_SAESSECF),
+	SECF(SECF_CRYP1, RCC_AHB5SECSR, RCC_AHB5SECSR_CRYP1SECF),
+	SECF(SECF_HASH1, RCC_AHB5SECSR, RCC_AHB5SECSR_HASH1SECF),
+	SECF(SECF_RNG1, RCC_AHB5SECSR, RCC_AHB5SECSR_RNG1SECF),
+	SECF(SECF_BKPSRAM, RCC_AHB5SECSR, RCC_AHB5SECSR_BKPSRAMSECF),
+	SECF(SECF_MCE, RCC_AHB6SECSR, RCC_AHB6SECSR_MCESECF),
+	SECF(SECF_FMC, RCC_AHB6SECSR, RCC_AHB6SECSR_FMCSECF),
+	SECF(SECF_QSPI, RCC_AHB6SECSR, RCC_AHB6SECSR_QSPISECF),
+	SECF(SECF_SDMMC1, RCC_AHB6SECSR, RCC_AHB6SECSR_SDMMC1SECF),
+	SECF(SECF_SDMMC2, RCC_AHB6SECSR, RCC_AHB6SECSR_SDMMC2SECF),
+	SECF(SECF_ETH1CK, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH1CKSECF),
+	SECF(SECF_ETH1TX, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH1TXSECF),
+	SECF(SECF_ETH1RX, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH1RXSECF),
+	SECF(SECF_ETH1MAC, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH1MACSECF),
+	SECF(SECF_ETH1STP, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH1STPSECF),
+	SECF(SECF_ETH2CK, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH2CKSECF),
+	SECF(SECF_ETH2TX, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH2TXSECF),
+	SECF(SECF_ETH2RX, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH2RXSECF),
+	SECF(SECF_ETH2MAC, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH2MACSECF),
+	SECF(SECF_ETH2STP, RCC_AHB6SECSR, RCC_AHB6SECSR_ETH2STPSECF),
+	SECF(SECF_MCO1, RCC_SECCFGR, RCC_SECCFGR_MCO1SEC),
+	SECF(SECF_MCO2, RCC_SECCFGR, RCC_SECCFGR_MCO2SEC),
+};
+
 static const char * const eth12_src[] = {
 	"pll4_p", "pll3_q"
 };
@@ -448,13 +573,29 @@ static struct clk_stm32_composite ck_mco2 = {
 };
 
 static const struct clock_config stm32mp13_clock_cfg[] = {
-	STM32_MUX_CFG(NO_ID, ck_ker_eth1),
-	STM32_GATE_CFG(ETH1CK_K, eth1ck_k),
-	STM32_DIV_CFG(ETH1PTP_K, eth1ptp_k),
-	STM32_COMPOSITE_CFG(CK_MCO1, ck_mco1),
-	STM32_COMPOSITE_CFG(CK_MCO2, ck_mco2),
+	STM32_MUX_CFG(NO_ID, ck_ker_eth1, SECF_ETH1CK),
+	STM32_GATE_CFG(ETH1CK_K, eth1ck_k, SECF_ETH1CK),
+	STM32_DIV_CFG(ETH1PTP_K, eth1ptp_k, SECF_ETH1CK),
+	STM32_COMPOSITE_CFG(CK_MCO1, ck_mco1, SECF_MCO1),
+	STM32_COMPOSITE_CFG(CK_MCO2, ck_mco2, SECF_MCO2),
 };
 
+static int stm32mp13_clock_is_provided_by_secure(void __iomem *base,
+						 const struct clock_config *cfg)
+{
+	int sec_id = cfg->sec_id;
+
+	if (sec_id != SECF_NONE) {
+		const struct clk_stm32_securiy *secf;
+
+		secf = &stm32mp13_security[sec_id];
+
+		return !!(readl(base + secf->offset) & BIT(secf->bit_idx));
+	}
+
+	return 0;
+}
+
 u16 stm32mp13_cpt_gate[GATE_NB];
 
 struct clk_stm32_clock_data stm32mp13_clock_data = {
@@ -468,6 +609,7 @@ static const struct stm32_rcc_match_data stm32mp13_data = {
 	.tab_clocks	= stm32mp13_clock_cfg,
 	.num_clocks	= ARRAY_SIZE(stm32mp13_clock_cfg),
 	.clock_data	= &stm32mp13_clock_data,
+	.check_security = &stm32mp13_clock_is_provided_by_secure,
 	.maxbinding	= STM32MP1_LAST_CLK,
 	.clear_offset	= RCC_CLR_OFFSET,
 };
-- 
2.25.1

