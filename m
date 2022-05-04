Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800E451A06B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbiEDNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350334AbiEDNKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:10:49 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DB41301;
        Wed,  4 May 2022 06:07:00 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244AIcL7026474;
        Wed, 4 May 2022 15:06:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=i160vd3SYJnXlFBbcmO1jrB6imf8Y/vVEsSy9dgKnng=;
 b=sK2kW1PK5X6qbZyiQZY66lDrImimdWnBeL31H1Nn0imk804FiE4BVZWizxQQydYBpE4l
 Ex+mTef2K/OcaNzVaDbObwPoSaALY8uusYsRRT2go74WZ5LVfi7V26QSZHEmLY6S2tiT
 tsedHAMkYFeiMhAlqnbEkYVpVMk5PaUk21Rl5+fNwOx1J4n8XzBn0tV4dNgC6XFl8LV4
 47F1GHqb8p3g8qe02E505mMxnKxmFGSSHjqCXJRAD1smeC3lGcLsU9tkixS4h1auEpcY
 9YemV5SLIVjCL18Ev9al416ccmyje1aucpm5DueReRds6cD8z7qTJ4l/fmlYMqN3RBcA Tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frt88wq4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 15:06:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 98CA810002A;
        Wed,  4 May 2022 15:06:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 91BCB21FEAA;
        Wed,  4 May 2022 15:06:38 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
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
Subject: [PATCH 4/6] rtc: stm32: add alarm A out feature
Date:   Wed, 4 May 2022 15:06:15 +0200
Message-ID: <20220504130617.331290-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504130233.330983-1-valentin.caron@foss.st.com>
References: <20220504130233.330983-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
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

STM32 RTC can pulse some SOC pins when an RTC alarm expires.
This patch adds this functionality for alarm A. The pulse can out on three
pins RTC_OUT1, RTC_OUT2, RTC_OUT2_RMP (PC13, PB2, PI8 on stm32mp15)
(PC13, PB2, PI1 on stm32mp13).

This patch only adds the functionality for devices which are using
st,stm32mp1-rtc compatible.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/rtc/rtc-stm32.c | 77 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index ace041eb44b8..f27927be20b2 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/iopoll.h>
@@ -44,8 +45,10 @@
 #define STM32_RTC_CR_ALRAIE		BIT(12)
 #define STM32_RTC_CR_COSEL		BIT(19)
 #define STM32_RTC_CR_OSEL		GENMASK(22, 21)
+#define STM32_RTC_CR_OSEL_ALARM_A	FIELD_PREP(STM32_RTC_CR_OSEL, 0x01)
 #define STM32_RTC_CR_COE		BIT(23)
 #define STM32_RTC_CR_TAMPOE		BIT(26)
+#define STM32_RTC_CR_TAMPALRM_TYPE	BIT(30)
 #define STM32_RTC_CR_OUT2EN		BIT(31)
 
 /* STM32_RTC_ISR/STM32_RTC_ICSR bit fields */
@@ -134,6 +137,7 @@ struct stm32_rtc_data {
 	bool need_dbp;
 	bool has_wakeirq;
 	bool has_lsco;
+	bool has_alarm_out;
 };
 
 struct stm32_rtc {
@@ -149,6 +153,7 @@ struct stm32_rtc {
 	int wakeirq_alarm;
 	int lsco;
 	struct clk *clk_lsco;
+	int out_alarm;
 };
 
 /*
@@ -253,6 +258,64 @@ static void stm32_rtc_clk_lsco_disable(struct platform_device *pdev)
 	writel_relaxed(cfgr &= ~STM32_RTC_CFGR_LSCOEN, rtc->base + regs.cfgr);
 }
 
+static int stm32_rtc_out_alarm_config(struct platform_device *pdev)
+{
+	struct stm32_rtc *rtc = platform_get_drvdata(pdev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	unsigned int cr = readl_relaxed(rtc->base + regs.cr);
+	unsigned int cfgr = readl_relaxed(rtc->base + regs.cfgr);
+
+	cr &= ~STM32_RTC_CR_OSEL;
+	cr |= STM32_RTC_CR_OSEL_ALARM_A;
+	cr &= ~STM32_RTC_CR_TAMPOE;
+	cr &= ~STM32_RTC_CR_COE;
+	cr &= ~STM32_RTC_CR_TAMPALRM_TYPE;
+
+	switch (rtc->out_alarm) {
+	case RTC_OUT1:
+		cr &= ~STM32_RTC_CR_OUT2EN;
+		cfgr &= ~STM32_RTC_CFGR_OUT2_RMP;
+		break;
+	case RTC_OUT2:
+		cr |= STM32_RTC_CR_OUT2EN;
+		cfgr &= ~STM32_RTC_CFGR_OUT2_RMP;
+		break;
+	case RTC_OUT2_RMP:
+		cr |= STM32_RTC_CR_OUT2EN;
+		cfgr |= STM32_RTC_CFGR_OUT2_RMP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	stm32_rtc_wpr_unlock(rtc);
+	writel_relaxed(cr, rtc->base + regs.cr);
+	writel_relaxed(cfgr, rtc->base + regs.cfgr);
+	stm32_rtc_wpr_lock(rtc);
+
+	return 0;
+}
+
+static void stm32_rtc_out_alarm_disable(struct platform_device *pdev)
+{
+	struct stm32_rtc *rtc = platform_get_drvdata(pdev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	unsigned int cr = readl_relaxed(rtc->base + regs.cr);
+	unsigned int cfgr = readl_relaxed(rtc->base + regs.cfgr);
+
+	cr &= ~STM32_RTC_CR_OSEL;
+	cr &= ~STM32_RTC_CR_TAMPOE;
+	cr &= ~STM32_RTC_CR_COE;
+	cr &= ~STM32_RTC_CR_TAMPALRM_TYPE;
+	cr &= ~STM32_RTC_CR_OUT2EN;
+	cfgr &= ~STM32_RTC_CFGR_OUT2_RMP;
+
+	stm32_rtc_wpr_unlock(rtc);
+	writel_relaxed(cr, rtc->base + regs.cr);
+	writel_relaxed(cfgr, rtc->base + regs.cfgr);
+	stm32_rtc_wpr_lock(rtc);
+}
+
 static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
 {
 	const struct stm32_rtc_registers *regs = &rtc->data->regs;
@@ -657,6 +720,7 @@ static const struct stm32_rtc_data stm32_rtc_data = {
 	.need_dbp = true,
 	.has_wakeirq = false,
 	.has_lsco = false,
+	.has_alarm_out = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -681,6 +745,7 @@ static const struct stm32_rtc_data stm32h7_rtc_data = {
 	.need_dbp = true,
 	.has_wakeirq = false,
 	.has_lsco = false,
+	.has_alarm_out = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -714,6 +779,7 @@ static const struct stm32_rtc_data stm32mp1_data = {
 	.need_dbp = false,
 	.has_wakeirq = true,
 	.has_lsco = true,
+	.has_alarm_out = true,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -928,6 +994,17 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	if (rtc->data->has_alarm_out) {
+		ret = of_property_read_s32(pdev->dev.of_node, "st,alarm", &rtc->out_alarm);
+		if (!ret) {
+			ret = stm32_rtc_out_alarm_config(pdev);
+		} else {
+			stm32_rtc_out_alarm_disable(pdev);
+			rtc->out_alarm = ret;
+			dev_dbg(&pdev->dev, "No alarm out: %d\n", ret);
+		}
+	}
+
 	if (rtc->data->has_lsco) {
 		ret = of_property_read_s32(pdev->dev.of_node,
 					   "st,lsco", &rtc->lsco);
-- 
2.25.1

