Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80150527E38
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbiEPHIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240826AbiEPHI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:08:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795B7E011;
        Mon, 16 May 2022 00:08:25 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G74Po2001259;
        Mon, 16 May 2022 09:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=d8bixZsTjdaUTkgkQoD/qfiDNCuKjND83uCqfblYiwo=;
 b=PBXGHUP6N7X50/dG8dkUFKREwY4senm6DgX+TC6UHMPkxN5jZT7EEL6GVGI0zYDV2/tT
 zrboyxTm5oAVVi10ZTwapBdWRm7WezCsi2Um8LCYYcHXfqQnoIPapjlW2JABN8DJVQlH
 +JzL3RKV8nWXaBn+Oxal623fCbVkIesiwpPuwdHnZsGPm0UEmApM3MzMZ9Y9V6YHqF1l
 uEVDPREqnOuPTJWDbGTDWWiCW8vy1X0+zFYFTAoP2zJbEJvdS8e3tK1MpDfrwRLCAfOu
 hdl2L9GxmdoKOUmoj9YgUDChnmRc0yml6ssUp4R+4/mJgbk6RVaaqig+Fzz8Ytm8bk4I iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21ukfpt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 09:08:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED50E100038;
        Mon, 16 May 2022 09:08:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E47C821230D;
        Mon, 16 May 2022 09:08:07 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 09:08:07
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
Subject: [PATCH v4 08/14] clk: stm32mp13: add all STM32MP13 peripheral clocks
Date:   Mon, 16 May 2022 09:05:54 +0200
Message-ID: <20220516070600.7692-9-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
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

All peripheral clocks are mainly based on stm32_gate clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32mp13.c | 360 ++++++++++++++++++++++++++++++
 1 file changed, 360 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 7c5ae2dada4a..b543474d5074 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -537,6 +537,303 @@ static const char * const mco2_src[] = {
 	"ck_mpu", "ck_axi", "ck_mlahb", "pll4_p", "ck_hse", "ck_hsi"
 };
 
+/* Timer clocks */
+static struct clk_stm32_gate tim2_k = {
+	.gate_id = GATE_TIM2,
+	.hw.init = CLK_HW_INIT("tim2_k", "timg1_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim3_k = {
+	.gate_id = GATE_TIM3,
+	.hw.init = CLK_HW_INIT("tim3_k", "timg1_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim4_k = {
+	.gate_id = GATE_TIM4,
+	.hw.init = CLK_HW_INIT("tim4_k", "timg1_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim5_k = {
+	.gate_id = GATE_TIM5,
+	.hw.init = CLK_HW_INIT("tim5_k", "timg1_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim6_k = {
+	.gate_id = GATE_TIM6,
+	.hw.init = CLK_HW_INIT("tim6_k", "timg1_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim7_k = {
+	.gate_id = GATE_TIM7,
+	.hw.init = CLK_HW_INIT("tim7_k", "timg1_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim1_k = {
+	.gate_id = GATE_TIM1,
+	.hw.init = CLK_HW_INIT("tim1_k", "timg2_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim8_k = {
+	.gate_id = GATE_TIM8,
+	.hw.init = CLK_HW_INIT("tim8_k", "timg2_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim12_k = {
+	.gate_id = GATE_TIM12,
+	.hw.init = CLK_HW_INIT("tim12_k", "timg3_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim13_k = {
+	.gate_id = GATE_TIM13,
+	.hw.init = CLK_HW_INIT("tim13_k", "timg3_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim14_k = {
+	.gate_id = GATE_TIM14,
+	.hw.init = CLK_HW_INIT("tim14_k", "timg3_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim15_k = {
+	.gate_id = GATE_TIM15,
+	.hw.init = CLK_HW_INIT("tim15_k", "timg3_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim16_k = {
+	.gate_id = GATE_TIM16,
+	.hw.init = CLK_HW_INIT("tim16_k", "timg3_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+static struct clk_stm32_gate tim17_k = {
+	.gate_id = GATE_TIM17,
+	.hw.init = CLK_HW_INIT("tim17_k", "timg3_ck", &clk_stm32_gate_ops, CLK_SET_RATE_PARENT),
+};
+
+/* Peripheral clocks */
+static struct clk_stm32_gate sai1 = {
+	.gate_id = GATE_SAI1,
+	.hw.init = CLK_HW_INIT("sai1", "pclk2", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate sai2 = {
+	.gate_id = GATE_SAI2,
+	.hw.init = CLK_HW_INIT("sai2", "pclk2", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate syscfg = {
+	.gate_id = GATE_SYSCFG,
+	.hw.init = CLK_HW_INIT("syscfg", "pclk3", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate vref = {
+	.gate_id = GATE_VREF,
+	.hw.init = CLK_HW_INIT("vref", "pclk3", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate dts = {
+	.gate_id = GATE_DTS,
+	.hw.init = CLK_HW_INIT("dts", "pclk3", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate pmbctrl = {
+	.gate_id = GATE_PMBCTRL,
+	.hw.init = CLK_HW_INIT("pmbctrl", "pclk3", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate hdp = {
+	.gate_id = GATE_HDP,
+	.hw.init = CLK_HW_INIT("hdp", "pclk3", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate iwdg2 = {
+	.gate_id = GATE_IWDG2APB,
+	.hw.init = CLK_HW_INIT("iwdg2", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate stgenro = {
+	.gate_id = GATE_STGENRO,
+	.hw.init = CLK_HW_INIT("stgenro", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpioa = {
+	.gate_id = GATE_GPIOA,
+	.hw.init = CLK_HW_INIT("gpioa", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpiob = {
+	.gate_id = GATE_GPIOB,
+	.hw.init = CLK_HW_INIT("gpiob", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpioc = {
+	.gate_id = GATE_GPIOC,
+	.hw.init = CLK_HW_INIT("gpioc", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpiod = {
+	.gate_id = GATE_GPIOD,
+	.hw.init = CLK_HW_INIT("gpiod", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpioe = {
+	.gate_id = GATE_GPIOE,
+	.hw.init = CLK_HW_INIT("gpioe", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpiof = {
+	.gate_id = GATE_GPIOF,
+	.hw.init = CLK_HW_INIT("gpiof", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpiog = {
+	.gate_id = GATE_GPIOG,
+	.hw.init = CLK_HW_INIT("gpiog", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpioh = {
+	.gate_id = GATE_GPIOH,
+	.hw.init = CLK_HW_INIT("gpioh", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate gpioi = {
+	.gate_id = GATE_GPIOI,
+	.hw.init = CLK_HW_INIT("gpioi", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate tsc = {
+	.gate_id = GATE_TSC,
+	.hw.init = CLK_HW_INIT("tsc", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate ddrperfm = {
+	.gate_id = GATE_DDRPERFM,
+	.hw.init = CLK_HW_INIT("ddrperfm", "pclk4", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate tzpc = {
+	.gate_id = GATE_TZC,
+	.hw.init = CLK_HW_INIT("tzpc", "pclk5", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate iwdg1 = {
+	.gate_id = GATE_IWDG1APB,
+	.hw.init = CLK_HW_INIT("iwdg1", "pclk5", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate bsec = {
+	.gate_id = GATE_BSEC,
+	.hw.init = CLK_HW_INIT("bsec", "pclk5", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate dma1 = {
+	.gate_id = GATE_DMA1,
+	.hw.init = CLK_HW_INIT("dma1", "ck_mlahb", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate dma2 = {
+	.gate_id = GATE_DMA2,
+	.hw.init = CLK_HW_INIT("dma2", "ck_mlahb", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate dmamux1 = {
+	.gate_id = GATE_DMAMUX1,
+	.hw.init = CLK_HW_INIT("dmamux1", "ck_mlahb", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate dma3 = {
+	.gate_id = GATE_DMA3,
+	.hw.init = CLK_HW_INIT("dma3", "ck_mlahb", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate dmamux2 = {
+	.gate_id = GATE_DMAMUX2,
+	.hw.init = CLK_HW_INIT("dmamux2", "ck_mlahb", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate adc1 = {
+	.gate_id = GATE_ADC1,
+	.hw.init = CLK_HW_INIT("adc1", "ck_mlahb", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate adc2 = {
+	.gate_id = GATE_ADC2,
+	.hw.init = CLK_HW_INIT("adc2", "ck_mlahb", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate pka = {
+	.gate_id = GATE_PKA,
+	.hw.init = CLK_HW_INIT("pka", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate cryp1 = {
+	.gate_id = GATE_CRYP1,
+	.hw.init = CLK_HW_INIT("cryp1", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate hash1 = {
+	.gate_id = GATE_HASH1,
+	.hw.init = CLK_HW_INIT("hash1", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate bkpsram = {
+	.gate_id = GATE_BKPSRAM,
+	.hw.init = CLK_HW_INIT("bkpsram", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate mdma = {
+	.gate_id = GATE_MDMA,
+	.hw.init = CLK_HW_INIT("mdma", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate eth1tx = {
+	.gate_id = GATE_ETH1TX,
+	.hw.init = CLK_HW_INIT("eth1tx", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate eth1rx = {
+	.gate_id = GATE_ETH1RX,
+	.hw.init = CLK_HW_INIT("eth1rx", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate eth1mac = {
+	.gate_id = GATE_ETH1MAC,
+	.hw.init = CLK_HW_INIT("eth1mac", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate eth2tx = {
+	.gate_id = GATE_ETH2TX,
+	.hw.init = CLK_HW_INIT("eth2tx", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate eth2rx = {
+	.gate_id = GATE_ETH2RX,
+	.hw.init = CLK_HW_INIT("eth2rx", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate eth2mac = {
+	.gate_id = GATE_ETH2MAC,
+	.hw.init = CLK_HW_INIT("eth2mac", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate crc1 = {
+	.gate_id = GATE_CRC1,
+	.hw.init = CLK_HW_INIT("crc1", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate usbh = {
+	.gate_id = GATE_USBH,
+	.hw.init = CLK_HW_INIT("usbh", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate eth1stp = {
+	.gate_id = GATE_ETH1STP,
+	.hw.init = CLK_HW_INIT("eth1stp", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
+static struct clk_stm32_gate eth2stp = {
+	.gate_id = GATE_ETH2STP,
+	.hw.init = CLK_HW_INIT("eth2stp", "ck_axi", &clk_stm32_gate_ops, 0),
+};
+
 static struct clk_stm32_mux ck_ker_eth1 = {
 	.mux_id = MUX_ETH1,
 	.hw.init = CLK_HW_INIT_PARENTS("ck_ker_eth1", eth12_src, &clk_stm32_mux_ops,
@@ -573,6 +870,69 @@ static struct clk_stm32_composite ck_mco2 = {
 };
 
 static const struct clock_config stm32mp13_clock_cfg[] = {
+	/* Timer clocks */
+	STM32_GATE_CFG(TIM2_K, tim2_k, SECF_NONE),
+	STM32_GATE_CFG(TIM3_K, tim3_k, SECF_NONE),
+	STM32_GATE_CFG(TIM4_K, tim4_k, SECF_NONE),
+	STM32_GATE_CFG(TIM5_K, tim5_k, SECF_NONE),
+	STM32_GATE_CFG(TIM6_K, tim6_k, SECF_NONE),
+	STM32_GATE_CFG(TIM7_K, tim7_k, SECF_NONE),
+	STM32_GATE_CFG(TIM1_K, tim1_k, SECF_NONE),
+	STM32_GATE_CFG(TIM8_K, tim8_k, SECF_NONE),
+	STM32_GATE_CFG(TIM12_K, tim12_k, SECF_TIM12),
+	STM32_GATE_CFG(TIM13_K, tim13_k, SECF_TIM13),
+	STM32_GATE_CFG(TIM14_K, tim14_k, SECF_TIM14),
+	STM32_GATE_CFG(TIM15_K, tim15_k, SECF_TIM15),
+	STM32_GATE_CFG(TIM16_K, tim16_k, SECF_TIM16),
+	STM32_GATE_CFG(TIM17_K, tim17_k, SECF_TIM17),
+
+	/* Peripheral clocks */
+	STM32_GATE_CFG(SAI1, sai1, SECF_NONE),
+	STM32_GATE_CFG(SAI2, sai2, SECF_NONE),
+	STM32_GATE_CFG(SYSCFG, syscfg, SECF_NONE),
+	STM32_GATE_CFG(VREF, vref, SECF_VREF),
+	STM32_GATE_CFG(DTS, dts, SECF_NONE),
+	STM32_GATE_CFG(PMBCTRL, pmbctrl, SECF_NONE),
+	STM32_GATE_CFG(HDP, hdp, SECF_NONE),
+	STM32_GATE_CFG(IWDG2, iwdg2, SECF_NONE),
+	STM32_GATE_CFG(STGENRO, stgenro, SECF_STGENRO),
+	STM32_GATE_CFG(TZPC, tzpc, SECF_TZC),
+	STM32_GATE_CFG(IWDG1, iwdg1, SECF_IWDG1),
+	STM32_GATE_CFG(BSEC, bsec, SECF_BSEC),
+	STM32_GATE_CFG(DMA1, dma1, SECF_NONE),
+	STM32_GATE_CFG(DMA2, dma2, SECF_NONE),
+	STM32_GATE_CFG(DMAMUX1, dmamux1, SECF_NONE),
+	STM32_GATE_CFG(DMA3, dma3, SECF_DMA3),
+	STM32_GATE_CFG(DMAMUX2, dmamux2, SECF_DMAMUX2),
+	STM32_GATE_CFG(ADC1, adc1, SECF_ADC1),
+	STM32_GATE_CFG(ADC2, adc2, SECF_ADC2),
+	STM32_GATE_CFG(GPIOA, gpioa, SECF_NONE),
+	STM32_GATE_CFG(GPIOB, gpiob, SECF_NONE),
+	STM32_GATE_CFG(GPIOC, gpioc, SECF_NONE),
+	STM32_GATE_CFG(GPIOD, gpiod, SECF_NONE),
+	STM32_GATE_CFG(GPIOE, gpioe, SECF_NONE),
+	STM32_GATE_CFG(GPIOF, gpiof, SECF_NONE),
+	STM32_GATE_CFG(GPIOG, gpiog, SECF_NONE),
+	STM32_GATE_CFG(GPIOH, gpioh, SECF_NONE),
+	STM32_GATE_CFG(GPIOI, gpioi, SECF_NONE),
+	STM32_GATE_CFG(TSC, tsc, SECF_TZC),
+	STM32_GATE_CFG(PKA, pka, SECF_PKA),
+	STM32_GATE_CFG(CRYP1, cryp1, SECF_CRYP1),
+	STM32_GATE_CFG(HASH1, hash1, SECF_HASH1),
+	STM32_GATE_CFG(BKPSRAM, bkpsram, SECF_BKPSRAM),
+	STM32_GATE_CFG(MDMA, mdma, SECF_NONE),
+	STM32_GATE_CFG(ETH1TX, eth1tx, SECF_ETH1TX),
+	STM32_GATE_CFG(ETH1RX, eth1rx, SECF_ETH1RX),
+	STM32_GATE_CFG(ETH1MAC, eth1mac, SECF_ETH1MAC),
+	STM32_GATE_CFG(ETH2TX, eth2tx, SECF_ETH2TX),
+	STM32_GATE_CFG(ETH2RX, eth2rx, SECF_ETH2RX),
+	STM32_GATE_CFG(ETH2MAC, eth2mac, SECF_ETH2MAC),
+	STM32_GATE_CFG(CRC1, crc1, SECF_NONE),
+	STM32_GATE_CFG(USBH, usbh, SECF_NONE),
+	STM32_GATE_CFG(DDRPERFM, ddrperfm, SECF_NONE),
+	STM32_GATE_CFG(ETH1STP, eth1stp, SECF_ETH1STP),
+	STM32_GATE_CFG(ETH2STP, eth2stp, SECF_ETH2STP),
+
 	STM32_MUX_CFG(NO_ID, ck_ker_eth1, SECF_ETH1CK),
 	STM32_GATE_CFG(ETH1CK_K, eth1ck_k, SECF_ETH1CK),
 	STM32_DIV_CFG(ETH1PTP_K, eth1ptp_k, SECF_ETH1CK),
-- 
2.25.1

