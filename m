Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD34D527E39
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbiEPHJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiEPHI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:08:26 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C2E00E;
        Mon, 16 May 2022 00:08:23 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FKOBf5014061;
        Mon, 16 May 2022 09:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=81AC0tKKyrs0sUbd7KAH5uXIk4yAJL1tAjAFsMtkmFI=;
 b=DQKsxpQMmTnoIjOJqQAIuVrS3AcGr/wOJRgVTgZjpVL1ATr7w7fA+3kdCKGUDmzy+Kaa
 0wDjs65SW3OliiRmIB8sTHbspaaordro+LvzMoM8kEIZzS6pxchDjqSXwKopMt/QiBo9
 7HCOnBiUv8SG55R2QVIJ3eMsz/cK8+GsqR0t4Jw33vT4XVRpJe+hFscaq9cJexkLcxPr
 zXFJuVi6OwkIxzAScKkpqVwYgdeny9c0tqBZColRNt12XRckgSQYUw0q1W9WWCigMgyI
 WJDTLovlOxX/+tF4EQQ51U9TXEeKq84jvxy/iGCAC6JjargP2menO3ALoAB5b65oAe4U IQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23ah8qrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 09:08:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 390A710002A;
        Mon, 16 May 2022 09:08:09 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2FCFB2122F6;
        Mon, 16 May 2022 09:08:09 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 09:08:08
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
Subject: [PATCH v4 09/14] clk: stm32mp13: add all STM32MP13 kernel clocks
Date:   Mon, 16 May 2022 09:05:55 +0200
Message-ID: <20220516070600.7692-10-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
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

Complete all kernel clocks of stm32mp13.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32mp13.c | 513 ++++++++++++++++++++++++++++++
 1 file changed, 513 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index b543474d5074..9edd32018f8f 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -525,10 +525,46 @@ static const struct clk_stm32_securiy stm32mp13_security[] = {
 	SECF(SECF_MCO2, RCC_SECCFGR, RCC_SECCFGR_MCO2SEC),
 };
 
+static const char * const adc12_src[] = {
+	"pll4_r", "ck_per", "pll3_q"
+};
+
+static const char * const dcmipp_src[] = {
+	"ck_axi", "pll2_q", "pll4_p", "ck_per",
+};
+
 static const char * const eth12_src[] = {
 	"pll4_p", "pll3_q"
 };
 
+static const char * const fdcan_src[] = {
+	"ck_hse", "pll3_q", "pll4_q", "pll4_r"
+};
+
+static const char * const fmc_src[] = {
+	"ck_axi", "pll3_r", "pll4_p", "ck_per"
+};
+
+static const char * const i2c12_src[] = {
+	"pclk1", "pll4_r", "ck_hsi", "ck_csi"
+};
+
+static const char * const i2c345_src[] = {
+	"pclk6", "pll4_r", "ck_hsi", "ck_csi"
+};
+
+static const char * const lptim1_src[] = {
+	"pclk1", "pll4_p", "pll3_q", "ck_lse", "ck_lsi", "ck_per"
+};
+
+static const char * const lptim23_src[] = {
+	"pclk3", "pll4_q", "ck_per", "ck_lse", "ck_lsi"
+};
+
+static const char * const lptim45_src[] = {
+	"pclk3", "pll4_p", "pll3_q", "ck_lse", "ck_lsi", "ck_per"
+};
+
 static const char * const mco1_src[] = {
 	"ck_hsi", "ck_hse", "ck_csi", "ck_lsi", "ck_lse"
 };
@@ -537,6 +573,70 @@ static const char * const mco2_src[] = {
 	"ck_mpu", "ck_axi", "ck_mlahb", "pll4_p", "ck_hse", "ck_hsi"
 };
 
+static const char * const qspi_src[] = {
+	"ck_axi", "pll3_r", "pll4_p", "ck_per"
+};
+
+static const char * const rng1_src[] = {
+	"ck_csi", "pll4_r", "ck_lse", "ck_lsi"
+};
+
+static const char * const saes_src[] = {
+	"ck_axi", "ck_per", "pll4_r", "ck_lsi"
+};
+
+static const char * const sai1_src[] = {
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "pll3_r"
+};
+
+static const char * const sai2_src[] = {
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb", "pll3_r"
+};
+
+static const char * const sdmmc12_src[] = {
+	"ck_axi", "pll3_r", "pll4_p", "ck_hsi"
+};
+
+static const char * const spdif_src[] = {
+	"pll4_p", "pll3_q", "ck_hsi"
+};
+
+static const char * const spi123_src[] = {
+	"pll4_p", "pll3_q", "i2s_ckin", "ck_per", "pll3_r"
+};
+
+static const char * const spi4_src[] = {
+	"pclk6", "pll4_q", "ck_hsi", "ck_csi", "ck_hse", "i2s_ckin"
+};
+
+static const char * const spi5_src[] = {
+	"pclk6", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const stgen_src[] = {
+	"ck_hsi", "ck_hse"
+};
+
+static const char * const usart12_src[] = {
+	"pclk6", "pll3_q", "ck_hsi", "ck_csi", "pll4_q", "ck_hse"
+};
+
+static const char * const usart34578_src[] = {
+	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const usart6_src[] = {
+	"pclk2", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const usbo_src[] = {
+	"pll4_r", "ck_usbo_48m"
+};
+
+static const char * const usbphy_src[] = {
+	"ck_hse", "pll4_r", "clk-hse-div2"
+};
+
 /* Timer clocks */
 static struct clk_stm32_gate tim2_k = {
 	.gate_id = GATE_TIM2,
@@ -834,6 +934,337 @@ static struct clk_stm32_gate eth2stp = {
 	.hw.init = CLK_HW_INIT("eth2stp", "ck_axi", &clk_stm32_gate_ops, 0),
 };
 
+/* Kernel clocks */
+static struct clk_stm32_composite sdmmc1_k = {
+	.gate_id = GATE_SDMMC1,
+	.mux_id = MUX_SDMMC1,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("sdmmc1_k", sdmmc12_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite sdmmc2_k = {
+	.gate_id = GATE_SDMMC2,
+	.mux_id = MUX_SDMMC2,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("sdmmc2_k", sdmmc12_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite fmc_k = {
+	.gate_id = GATE_FMC,
+	.mux_id = MUX_FMC,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("fmc_k", fmc_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite qspi_k = {
+	.gate_id = GATE_QSPI,
+	.mux_id = MUX_QSPI,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("qspi_k", qspi_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite spi2_k = {
+	.gate_id = GATE_SPI2,
+	.mux_id = MUX_SPI23,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("spi2_k", spi123_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite spi3_k = {
+	.gate_id = GATE_SPI3,
+	.mux_id = MUX_SPI23,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("spi3_k", spi123_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite i2c1_k = {
+	.gate_id = GATE_I2C1,
+	.mux_id = MUX_I2C12,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("i2c1_k", i2c12_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite i2c2_k = {
+	.gate_id = GATE_I2C2,
+	.mux_id = MUX_I2C12,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("i2c2_k", i2c12_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite lptim4_k = {
+	.gate_id = GATE_LPTIM4,
+	.mux_id = MUX_LPTIM45,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("lptim4_k", lptim45_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite lptim5_k = {
+	.gate_id = GATE_LPTIM5,
+	.mux_id = MUX_LPTIM45,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("lptim5_k", lptim45_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite usart3_k = {
+	.gate_id = GATE_USART3,
+	.mux_id = MUX_UART35,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("usart3_k", usart34578_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite uart5_k = {
+	.gate_id = GATE_UART5,
+	.mux_id = MUX_UART35,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("uart5_k", usart34578_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite uart7_k = {
+	.gate_id = GATE_UART7,
+	.mux_id = MUX_UART78,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("uart7_k", usart34578_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite uart8_k = {
+	.gate_id = GATE_UART8,
+	.mux_id = MUX_UART78,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("uart8_k", usart34578_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite sai1_k = {
+	.gate_id = GATE_SAI1,
+	.mux_id = MUX_SAI1,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("sai1_k", sai1_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite adfsdm_k = {
+	.gate_id = GATE_ADFSDM,
+	.mux_id = MUX_SAI1,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("adfsdm_k", sai1_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite sai2_k = {
+	.gate_id = GATE_SAI2,
+	.mux_id = MUX_SAI2,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("sai2_k", sai2_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite adc1_k = {
+	.gate_id = GATE_ADC1,
+	.mux_id = MUX_ADC1,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("adc1_k", adc12_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite adc2_k = {
+	.gate_id = GATE_ADC2,
+	.mux_id = MUX_ADC2,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("adc2_k", adc12_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite rng1_k = {
+	.gate_id = GATE_RNG1,
+	.mux_id = MUX_RNG1,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("rng1_k", rng1_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite usbphy_k = {
+	.gate_id = GATE_USBPHY,
+	.mux_id = MUX_USBPHY,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("usbphy_k", usbphy_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite stgen_k = {
+	.gate_id = GATE_STGENC,
+	.mux_id = MUX_STGEN,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("stgen_k", stgen_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite spdif_k = {
+	.gate_id = GATE_SPDIF,
+	.mux_id = MUX_SPDIF,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("spdif_k", spdif_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite spi1_k = {
+	.gate_id = GATE_SPI1,
+	.mux_id = MUX_SPI1,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("spi1_k", spi123_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite spi4_k = {
+	.gate_id = GATE_SPI4,
+	.mux_id = MUX_SPI4,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("spi4_k", spi4_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite spi5_k = {
+	.gate_id = GATE_SPI5,
+	.mux_id = MUX_SPI5,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("spi5_k", spi5_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite i2c3_k = {
+	.gate_id = GATE_I2C3,
+	.mux_id = MUX_I2C3,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("i2c3_k", i2c345_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite i2c4_k = {
+	.gate_id = GATE_I2C4,
+	.mux_id = MUX_I2C4,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("i2c4_k", i2c345_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite i2c5_k = {
+	.gate_id = GATE_I2C5,
+	.mux_id = MUX_I2C5,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("i2c5_k", i2c345_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite lptim1_k = {
+	.gate_id = GATE_LPTIM1,
+	.mux_id = MUX_LPTIM1,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("lptim1_k", lptim1_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite lptim2_k = {
+	.gate_id = GATE_LPTIM2,
+	.mux_id = MUX_LPTIM2,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("lptim2_k", lptim23_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite lptim3_k = {
+	.gate_id = GATE_LPTIM3,
+	.mux_id = MUX_LPTIM3,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("lptim3_k", lptim23_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite usart1_k = {
+	.gate_id = GATE_USART1,
+	.mux_id = MUX_UART1,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("usart1_k", usart12_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite usart2_k = {
+	.gate_id = GATE_USART2,
+	.mux_id = MUX_UART2,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("usart2_k", usart12_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite uart4_k = {
+	.gate_id = GATE_UART4,
+	.mux_id = MUX_UART4,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("uart4_k", usart34578_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite uart6_k = {
+	.gate_id = GATE_USART6,
+	.mux_id = MUX_UART6,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("uart6_k", usart6_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite fdcan_k = {
+	.gate_id = GATE_FDCAN,
+	.mux_id = MUX_FDCAN,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("fdcan_k", fdcan_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite dcmipp_k = {
+	.gate_id = GATE_DCMIPP,
+	.mux_id = MUX_DCMIPP,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("dcmipp_k", dcmipp_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite usbo_k = {
+	.gate_id = GATE_USBO,
+	.mux_id = MUX_USBO,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("usbo_k", usbo_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_composite saes_k = {
+	.gate_id = GATE_SAES,
+	.mux_id = MUX_SAES,
+	.div_id = NO_STM32_DIV,
+	.hw.init = CLK_HW_INIT_PARENTS("saes_k", saes_src, &clk_stm32_composite_ops,
+				       CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_gate dfsdm_k = {
+	.gate_id = GATE_DFSDM,
+	.hw.init = CLK_HW_INIT("dfsdm_k", "ck_mlahb", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate ltdc_px = {
+	.gate_id = GATE_LTDC,
+	.hw.init = CLK_HW_INIT("ltdc_px", "pll4_q", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
 static struct clk_stm32_mux ck_ker_eth1 = {
 	.mux_id = MUX_ETH1,
 	.hw.init = CLK_HW_INIT_PARENTS("ck_ker_eth1", eth12_src, &clk_stm32_mux_ops,
@@ -851,6 +1282,23 @@ static struct clk_stm32_div eth1ptp_k = {
 				  CLK_SET_RATE_NO_REPARENT),
 };
 
+static struct clk_stm32_mux ck_ker_eth2 = {
+	.mux_id = MUX_ETH2,
+	.hw.init = CLK_HW_INIT_PARENTS("ck_ker_eth2", eth12_src, &clk_stm32_mux_ops,
+					    CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_NO_REPARENT),
+};
+
+static struct clk_stm32_gate eth2ck_k = {
+	.gate_id = GATE_ETH2CK,
+	.hw.init = CLK_HW_INIT_HW("eth2ck_k", &ck_ker_eth2.hw, &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_div eth2ptp_k = {
+	.div_id = DIV_ETH2PTP,
+	.hw.init = CLK_HW_INIT_HW("eth2ptp_k", &ck_ker_eth2.hw, &clk_stm32_divider_ops,
+				  CLK_SET_RATE_NO_REPARENT),
+};
+
 static struct clk_stm32_composite ck_mco1 = {
 	.gate_id = GATE_MCO1,
 	.mux_id = MUX_MCO1,
@@ -869,6 +1317,19 @@ static struct clk_stm32_composite ck_mco2 = {
 				       CLK_IGNORE_UNUSED),
 };
 
+/* Debug clocks */
+static struct clk_stm32_gate ck_sys_dbg = {
+	.gate_id = GATE_DBGCK,
+	.hw.init = CLK_HW_INIT("ck_sys_dbg", "ck_axi", &clk_stm32_gate_ops, CLK_IS_CRITICAL),
+};
+
+static struct clk_stm32_composite ck_trace = {
+	.gate_id = GATE_TRACECK,
+	.mux_id = NO_STM32_MUX,
+	.div_id = DIV_TRACE,
+	.hw.init = CLK_HW_INIT("ck_trace", "ck_axi", &clk_stm32_composite_ops, CLK_IGNORE_UNUSED),
+};
+
 static const struct clock_config stm32mp13_clock_cfg[] = {
 	/* Timer clocks */
 	STM32_GATE_CFG(TIM2_K, tim2_k, SECF_NONE),
@@ -933,9 +1394,61 @@ static const struct clock_config stm32mp13_clock_cfg[] = {
 	STM32_GATE_CFG(ETH1STP, eth1stp, SECF_ETH1STP),
 	STM32_GATE_CFG(ETH2STP, eth2stp, SECF_ETH2STP),
 
+	/* Kernel clocks */
+	STM32_COMPOSITE_CFG(SDMMC1_K, sdmmc1_k, SECF_SDMMC1),
+	STM32_COMPOSITE_CFG(SDMMC2_K, sdmmc2_k, SECF_SDMMC2),
+	STM32_COMPOSITE_CFG(FMC_K, fmc_k, SECF_FMC),
+	STM32_COMPOSITE_CFG(QSPI_K, qspi_k, SECF_QSPI),
+	STM32_COMPOSITE_CFG(SPI2_K, spi2_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(SPI3_K, spi3_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(I2C1_K, i2c1_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(I2C2_K, i2c2_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(LPTIM4_K, lptim4_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(LPTIM5_K, lptim5_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(USART3_K, usart3_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(UART5_K, uart5_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(UART7_K, uart7_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(UART8_K, uart8_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(SAI1_K, sai1_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(SAI2_K, sai2_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(ADFSDM_K, adfsdm_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(ADC1_K, adc1_k, SECF_ADC1),
+	STM32_COMPOSITE_CFG(ADC2_K, adc2_k, SECF_ADC2),
+	STM32_COMPOSITE_CFG(RNG1_K, rng1_k, SECF_RNG1),
+	STM32_COMPOSITE_CFG(USBPHY_K, usbphy_k, SECF_USBPHY),
+	STM32_COMPOSITE_CFG(STGEN_K, stgen_k, SECF_STGENC),
+	STM32_COMPOSITE_CFG(SPDIF_K, spdif_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(SPI1_K, spi1_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(SPI4_K, spi4_k, SECF_SPI4),
+	STM32_COMPOSITE_CFG(SPI5_K, spi5_k, SECF_SPI5),
+	STM32_COMPOSITE_CFG(I2C3_K, i2c3_k, SECF_I2C3),
+	STM32_COMPOSITE_CFG(I2C4_K, i2c4_k, SECF_I2C4),
+	STM32_COMPOSITE_CFG(I2C5_K, i2c5_k, SECF_I2C5),
+	STM32_COMPOSITE_CFG(LPTIM1_K, lptim1_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(LPTIM2_K, lptim2_k, SECF_LPTIM2),
+	STM32_COMPOSITE_CFG(LPTIM3_K, lptim3_k, SECF_LPTIM3),
+	STM32_COMPOSITE_CFG(USART1_K, usart1_k, SECF_USART1),
+	STM32_COMPOSITE_CFG(USART2_K, usart2_k, SECF_USART2),
+	STM32_COMPOSITE_CFG(UART4_K, uart4_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(USART6_K, uart6_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(FDCAN_K, fdcan_k, SECF_NONE),
+	STM32_COMPOSITE_CFG(DCMIPP_K, dcmipp_k, SECF_DCMIPP),
+	STM32_COMPOSITE_CFG(USBO_K, usbo_k, SECF_USBO),
+	STM32_COMPOSITE_CFG(SAES_K, saes_k, SECF_SAES),
+	STM32_GATE_CFG(DFSDM_K, dfsdm_k, SECF_NONE),
+	STM32_GATE_CFG(LTDC_PX, ltdc_px, SECF_NONE),
+
 	STM32_MUX_CFG(NO_ID, ck_ker_eth1, SECF_ETH1CK),
 	STM32_GATE_CFG(ETH1CK_K, eth1ck_k, SECF_ETH1CK),
 	STM32_DIV_CFG(ETH1PTP_K, eth1ptp_k, SECF_ETH1CK),
+
+	STM32_MUX_CFG(NO_ID, ck_ker_eth2, SECF_ETH2CK),
+	STM32_GATE_CFG(ETH2CK_K, eth2ck_k, SECF_ETH2CK),
+	STM32_DIV_CFG(ETH2PTP_K, eth2ptp_k, SECF_ETH2CK),
+
+	STM32_GATE_CFG(CK_DBG, ck_sys_dbg, SECF_NONE),
+	STM32_COMPOSITE_CFG(CK_TRACE, ck_trace, SECF_NONE),
+
 	STM32_COMPOSITE_CFG(CK_MCO1, ck_mco1, SECF_MCO1),
 	STM32_COMPOSITE_CFG(CK_MCO2, ck_mco2, SECF_MCO2),
 };
-- 
2.25.1

