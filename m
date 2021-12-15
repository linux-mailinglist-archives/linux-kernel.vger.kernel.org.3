Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76A4475719
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhLOK7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:59:20 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:47324 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241839AbhLOK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:59:13 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFAOkgx014340;
        Wed, 15 Dec 2021 11:58:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=8tFWO6Ps5CA5NVyFqF1zqR1krUDsIUMBgZKXkDv0nXM=;
 b=YcQiMCIiONj0bwkHaf1n1ykt8j7UYLo9Lo8mfQ+1TMp9lwUNZICfmVCHa/jEyXv10jm2
 ta/2tavFR+ACnHq2UswTkIZ+fgtrn+wXA+d0MzIus1sKQxZR2ejxkR7UGHlNCq4cQdI2
 h6g27Ta7efhGV0Vf6xLMOeqFnkmhzxzVouSfBn8lsRb5BCmQ3eUXURD987krtzMOROKG
 3on0822GFPphdFas0LUN7Wf4+oPIJhGyPnEWTibDeaQwmdEg+aCBKpsDqMnDREuIlQ2B
 6T1/MhUh5S9iTGqzJce8jG8RIdOtEE+4K1sk93NVowOaE6TF+q8QxA4KhEM5Ho/ALjbX jA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cyeka85r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:58:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B14B4100034;
        Wed, 15 Dec 2021 11:58:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A8D40235F6C;
        Wed, 15 Dec 2021 11:58:54 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 11:58:54
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v2 4/5] irqchip/stm32-exti: add STM32MP13 support
Date:   Wed, 15 Dec 2021 11:58:46 +0100
Message-ID: <20211215105847.2328-5-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_08,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance stm32-exti driver to support STM32MP13 SoC. This SoC uses the same
hardware version than STM32MP15. Only EXTI line mapping is changed and
following EXTI lines are supported: GPIO, RTC, I2C[1-5], UxART[1-8],
USBH_EHCI, USBH_OHCI, USB_OTG, LPTIM[1-5], ETH[1-2].

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b56530675799..646fd15972c9 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -224,6 +224,11 @@ static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
 };
 
+static const struct stm32_exti_drv_data stm32mp13_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+};
+
 static struct
 stm32_desc_irq *stm32_exti_get_desc(struct stm32_exti_host_data *host_data, irq_hw_number_t hwirq)
 {
@@ -981,6 +986,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 /* platform driver only for MP1 */
 static const struct of_device_id stm32_exti_ids[] = {
 	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
+	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_exti_ids);
-- 
2.17.1

