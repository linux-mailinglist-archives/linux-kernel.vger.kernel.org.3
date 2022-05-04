Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB63C51A073
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350326AbiEDNLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350390AbiEDNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:10:47 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE2403DA;
        Wed,  4 May 2022 06:06:53 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244ALwSj018222;
        Wed, 4 May 2022 15:06:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=xlADDDAYf7bLutWTVCq2qRcVqVGLfJSifwbAguzb0gc=;
 b=HmCIJQCrZDeDppLqlB5AYEhWMgfGoOmSt7ACGIv+gmuJCipK4Ac8ozCcT9SovDNRRENh
 92UEDE/8m+0Thd6/S5+j0kMDadtE5cUq+GzD04QPYHEZy20U/8eibHFMKP8dSqyxnI29
 MS505Tmn1LyaBw/hYloTU4xOBj0F0LB8gtymgogYfWutfaZNL2j4nuZDfpEdIMXU7fDq
 uv9mnJp1ssWdZ6+Z3NzCSCfcxuqCxZ1qiei93Ci3tFK3BmqU909NXIVqyLaFW1GHu3bc
 gfEmbQCEL+ul7OOWLKVEQfPqiKXbb4UD9cgxOpZHCZldoO2jAOonW4rI3M/3kLfRYNAv oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjvfg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 15:06:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C7DC100034;
        Wed,  4 May 2022 15:06:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 026C321FEAA;
        Wed,  4 May 2022 15:06:38 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 15:06:37
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] rtc: stm32: add Low Speed Clock Output (LSCO) support
Date:   Wed, 4 May 2022 15:06:14 +0200
Message-ID: <20220504130617.331290-2-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504130233.330983-1-valentin.caron@foss.st.com>
References: <20220504130233.330983-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

STM32 RTC is now registered as a clock provider.
It provides rtc_lsco clock, that means RTC_LSCO is output on either
RTC_OUT1 or RTC_OUT2_RMP, depending on st,lsco DT property
(PC13 or PI8 on stm32mp15), (PC13 or PI1 on stm32mp13).

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/rtc/Kconfig     |   1 +
 drivers/rtc/rtc-stm32.c | 133 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 41c65b4d2baf..2e8021d7c98a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1888,6 +1888,7 @@ config RTC_DRV_R7301
 config RTC_DRV_STM32
 	tristate "STM32 RTC"
 	select REGMAP_MMIO
+	depends on COMMON_CLK
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
 	   If you say yes here you get support for the STM32 On-Chip
diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index ac9e228b56d0..ace041eb44b8 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -6,6 +6,7 @@
 
 #include <linux/bcd.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/mfd/syscon.h>
@@ -15,6 +16,8 @@
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 
+#include <dt-bindings/rtc/rtc-stm32.h>
+
 #define DRIVER_NAME "stm32_rtc"
 
 /* STM32_RTC_TR bit fields  */
@@ -39,6 +42,11 @@
 #define STM32_RTC_CR_FMT		BIT(6)
 #define STM32_RTC_CR_ALRAE		BIT(8)
 #define STM32_RTC_CR_ALRAIE		BIT(12)
+#define STM32_RTC_CR_COSEL		BIT(19)
+#define STM32_RTC_CR_OSEL		GENMASK(22, 21)
+#define STM32_RTC_CR_COE		BIT(23)
+#define STM32_RTC_CR_TAMPOE		BIT(26)
+#define STM32_RTC_CR_OUT2EN		BIT(31)
 
 /* STM32_RTC_ISR/STM32_RTC_ICSR bit fields */
 #define STM32_RTC_ISR_ALRAWF		BIT(0)
@@ -75,6 +83,12 @@
 /* STM32_RTC_SR/_SCR bit fields */
 #define STM32_RTC_SR_ALRA		BIT(0)
 
+/* STM32_RTC_CFGR bit fields */
+#define STM32_RTC_CFGR_OUT2_RMP		BIT(0)
+#define STM32_RTC_CFGR_LSCOEN		GENMASK(2, 1)
+#define STM32_RTC_CFGR_LSCOEN_OUT1	1
+#define STM32_RTC_CFGR_LSCOEN_OUT2_RMP	2
+
 /* STM32_RTC_VERR bit fields */
 #define STM32_RTC_VERR_MINREV_SHIFT	0
 #define STM32_RTC_VERR_MINREV		GENMASK(3, 0)
@@ -89,6 +103,9 @@
 /* Max STM32 RTC register offset is 0x3FC */
 #define UNDEF_REG			0xFFFF
 
+/* Frequency of HSE clock (Hz) */
+#define STM32_RTC_HSE_FREQ 32768
+
 struct stm32_rtc;
 
 struct stm32_rtc_registers {
@@ -101,6 +118,7 @@ struct stm32_rtc_registers {
 	u16 wpr;
 	u16 sr;
 	u16 scr;
+	u16 cfgr;
 	u16 verr;
 };
 
@@ -115,6 +133,7 @@ struct stm32_rtc_data {
 	bool has_pclk;
 	bool need_dbp;
 	bool has_wakeirq;
+	bool has_lsco;
 };
 
 struct stm32_rtc {
@@ -128,8 +147,88 @@ struct stm32_rtc {
 	const struct stm32_rtc_data *data;
 	int irq_alarm;
 	int wakeirq_alarm;
+	int lsco;
+	struct clk *clk_lsco;
 };
 
+/*
+ *  -------------------------------------------------------------------------
+ * | TAMPOE | OSEL[1:0] | COE | OUT2EN |     RTC_OUT1     |     RTC_OUT2     |
+ * |	    |           |     |        |                  | or RTC_OUT2_RMP  |
+ * |-------------------------------------------------------------------------|
+ * |    0   |     00    |  0  | 0 or 1 |         -        |         -        |
+ * |--------|-----------|-----|--------|------------------|------------------|
+ * |    0   |     00    |  1  |    0   |      CALIB       |         -        |
+ * |--------|-----------|-----|--------|------------------|------------------|
+ * | 0 or 1 |    !=00   |  0  |    0   |     TAMPALRM     |         -        |
+ * |--------|-----------|-----|--------|------------------|------------------|
+ * |    0   |     00    |  1  |    1   |         -        |      CALIB       |
+ * |--------|-----------|-----|--------|------------------|------------------|
+ * | 0 or 1 |    !=00   |  0  |    1   |         -        |     TAMPALRM     |
+ * |--------|-----------|-----|--------|------------------|------------------|
+ * | 0 or 1 |    !=00   |  1  |    1   |     TAMPALRM     |      CALIB       |
+ *  -------------------------------------------------------------------------
+ */
+static int stm32_rtc_clk_lsco_check_availability(struct stm32_rtc *rtc)
+{
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	unsigned int cr = readl_relaxed(rtc->base + regs.cr);
+	unsigned int cfgr = readl_relaxed(rtc->base + regs.cfgr);
+	unsigned int calib = STM32_RTC_CR_COE;
+	unsigned int tampalrm = STM32_RTC_CR_TAMPOE | STM32_RTC_CR_OSEL;
+
+	switch (rtc->lsco) {
+	case RTC_OUT1:
+		if ((!(cr & STM32_RTC_CR_OUT2EN) &&
+		     ((cr & calib) || cr & tampalrm)) ||
+		     ((cr & calib) && (cr & tampalrm)))
+			return -EBUSY;
+		break;
+	case RTC_OUT2_RMP:
+		if ((cr & STM32_RTC_CR_OUT2EN) &&
+		    (cfgr & STM32_RTC_CFGR_OUT2_RMP) &&
+		    ((cr & calib) || (cr & tampalrm)))
+			return -EBUSY;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* LSCO can only work if RTC clock source is HSE */
+	if (clk_get_rate(rtc->rtc_ck) != STM32_RTC_HSE_FREQ)
+		return -ERANGE;
+
+	return 0;
+}
+
+static int stm32_rtc_clk_lsco_register(struct platform_device *pdev)
+{
+	struct stm32_rtc *rtc = platform_get_drvdata(pdev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	u8 lscoen;
+	int ret;
+
+	ret = stm32_rtc_clk_lsco_check_availability(rtc);
+	if (ret)
+		return ret;
+
+	lscoen = (rtc->lsco == RTC_OUT1) ? STM32_RTC_CFGR_LSCOEN_OUT1 :
+					   STM32_RTC_CFGR_LSCOEN_OUT2_RMP;
+
+	rtc->clk_lsco = clk_register_gate(&pdev->dev, "rtc_lsco",
+					  __clk_get_name(rtc->rtc_ck),
+					  CLK_IS_CRITICAL,
+					  rtc->base + regs.cfgr, lscoen,
+					  0, NULL);
+	if (IS_ERR(rtc->clk_lsco))
+		return PTR_ERR(rtc->clk_lsco);
+
+	of_clk_add_provider(pdev->dev.of_node,
+			    of_clk_src_simple_get, rtc->clk_lsco);
+
+	return 0;
+}
+
 static void stm32_rtc_wpr_unlock(struct stm32_rtc *rtc)
 {
 	const struct stm32_rtc_registers *regs = &rtc->data->regs;
@@ -145,6 +244,15 @@ static void stm32_rtc_wpr_lock(struct stm32_rtc *rtc)
 	writel_relaxed(RTC_WPR_WRONG_KEY, rtc->base + regs->wpr);
 }
 
+static void stm32_rtc_clk_lsco_disable(struct platform_device *pdev)
+{
+	struct stm32_rtc *rtc = platform_get_drvdata(pdev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	unsigned int cfgr = readl_relaxed(rtc->base + regs.cfgr);
+
+	writel_relaxed(cfgr &= ~STM32_RTC_CFGR_LSCOEN, rtc->base + regs.cfgr);
+}
+
 static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
 {
 	const struct stm32_rtc_registers *regs = &rtc->data->regs;
@@ -548,6 +656,7 @@ static const struct stm32_rtc_data stm32_rtc_data = {
 	.has_pclk = false,
 	.need_dbp = true,
 	.has_wakeirq = false,
+	.has_lsco = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -558,6 +667,7 @@ static const struct stm32_rtc_data stm32_rtc_data = {
 		.wpr = 0x24,
 		.sr = 0x0C, /* set to ISR offset to ease alarm management */
 		.scr = UNDEF_REG,
+		.cfgr = UNDEF_REG,
 		.verr = UNDEF_REG,
 	},
 	.events = {
@@ -570,6 +680,7 @@ static const struct stm32_rtc_data stm32h7_rtc_data = {
 	.has_pclk = true,
 	.need_dbp = true,
 	.has_wakeirq = false,
+	.has_lsco = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -580,6 +691,7 @@ static const struct stm32_rtc_data stm32h7_rtc_data = {
 		.wpr = 0x24,
 		.sr = 0x0C, /* set to ISR offset to ease alarm management */
 		.scr = UNDEF_REG,
+		.cfgr = UNDEF_REG,
 		.verr = UNDEF_REG,
 	},
 	.events = {
@@ -601,6 +713,7 @@ static const struct stm32_rtc_data stm32mp1_data = {
 	.has_pclk = true,
 	.need_dbp = false,
 	.has_wakeirq = true,
+	.has_lsco = true,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -611,6 +724,7 @@ static const struct stm32_rtc_data stm32mp1_data = {
 		.wpr = 0x24,
 		.sr = 0x50,
 		.scr = 0x5C,
+		.cfgr = 0x60,
 		.verr = 0x3F4,
 	},
 	.events = {
@@ -814,6 +928,22 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	if (rtc->data->has_lsco) {
+		ret = of_property_read_s32(pdev->dev.of_node,
+					   "st,lsco", &rtc->lsco);
+		if (!ret) {
+			ret = stm32_rtc_clk_lsco_register(pdev);
+			if (ret)
+				dev_warn(&pdev->dev,
+					 "LSCO clock registration failed: %d\n",
+					 ret);
+		} else {
+			stm32_rtc_clk_lsco_disable(pdev);
+			rtc->lsco = ret;
+			dev_dbg(&pdev->dev, "No LSCO clock: %d\n", ret);
+		}
+	}
+
 	/*
 	 * If INITS flag is reset (calendar year field set to 0x00), calendar
 	 * must be initialized
@@ -852,6 +982,9 @@ static int stm32_rtc_remove(struct platform_device *pdev)
 	const struct stm32_rtc_registers *regs = &rtc->data->regs;
 	unsigned int cr;
 
+	if (!IS_ERR_OR_NULL(rtc->clk_lsco))
+		clk_unregister_gate(rtc->clk_lsco);
+
 	/* Disable interrupts */
 	stm32_rtc_wpr_unlock(rtc);
 	cr = readl_relaxed(rtc->base + regs->cr);
-- 
2.25.1

