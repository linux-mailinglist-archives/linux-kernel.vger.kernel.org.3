Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3246D406
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhLHNJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:09:51 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46728 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234066AbhLHNJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:09:50 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B8CcliG025876;
        Wed, 8 Dec 2021 14:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=E4g7nrOh/UnPPrXpcy7LXKrM7q2PxRAAMvKD/WLyTPI=;
 b=UW2WzRMu008jzuWDKmsM9MRUfoAXMIGfRpcfuXGFUGbxsilUUpR1n7oArpj1RlrxHDYN
 umBuKhMQP2e3fPXNJ72ARkPx8lQjClLdtOH6iMwUjGevhN4OllH57INTopUaRlzJBYWR
 WeohuOCmnpVEX1Lunk2Z6Z3RRbxF43WyGWRjcxjoCiyMFUUaPVU6RzZ18eF4yltlhTQ2
 nwiZfRvfIYT/n6DBeYQktiONd+7JROFAF4Np0F58bgSnKN7ICgy/AiYOigyokIqU0dj6
 PZ4aU/DXfTAtTMfIo5ER27ZByL/FPf67vpynnJqtvEI0ZxdTNMfVBOFbgK5VwLEDZXbA UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ctrpq9sar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:05:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D322710002A;
        Wed,  8 Dec 2021 14:05:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CABCA2A4D60;
        Wed,  8 Dec 2021 14:05:53 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec 2021 14:05:53
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 2/3] irqchip/stm32-exti: add STM32MP13 support
Date:   Wed, 8 Dec 2021 14:04:55 +0100
Message-ID: <20211208130456.4002-3-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
References: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_04,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance stm32-exti driver to support STM32MP13 SoC. This SoC uses the same
hardware version than STM32MP15. Only EXTI line mapping is changed and
following EXTI lines are supported: GPIO, RTC, I2C[1-5], UxART[1-8],
USBH_EHCI, USBH_OHCI, USB_OTG, LPTIM[1-5], ETH[1-2].

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b7cb2da71888..9d18f47040eb 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -214,6 +214,48 @@ static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
 	{ .exti = 73, .irq_parent = 129, .chip = &stm32_exti_h_chip },
 };
 
+static const struct stm32_desc_irq stm32mp13_desc_irq[] = {
+	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
+	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
+	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
+	{ .exti = 3, .irq_parent = 9, .chip = &stm32_exti_h_chip },
+	{ .exti = 4, .irq_parent = 10, .chip = &stm32_exti_h_chip },
+	{ .exti = 5, .irq_parent = 24, .chip = &stm32_exti_h_chip },
+	{ .exti = 6, .irq_parent = 65, .chip = &stm32_exti_h_chip },
+	{ .exti = 7, .irq_parent = 66, .chip = &stm32_exti_h_chip },
+	{ .exti = 8, .irq_parent = 67, .chip = &stm32_exti_h_chip },
+	{ .exti = 9, .irq_parent = 68, .chip = &stm32_exti_h_chip },
+	{ .exti = 10, .irq_parent = 41, .chip = &stm32_exti_h_chip },
+	{ .exti = 11, .irq_parent = 43, .chip = &stm32_exti_h_chip },
+	{ .exti = 12, .irq_parent = 77, .chip = &stm32_exti_h_chip },
+	{ .exti = 13, .irq_parent = 78, .chip = &stm32_exti_h_chip },
+	{ .exti = 14, .irq_parent = 106, .chip = &stm32_exti_h_chip },
+	{ .exti = 15, .irq_parent = 109, .chip = &stm32_exti_h_chip },
+	{ .exti = 16, .irq_parent = 1, .chip = &stm32_exti_h_chip },
+	{ .exti = 19, .irq_parent = 3, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 21, .irq_parent = 32, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 22, .irq_parent = 34, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 23, .irq_parent = 73, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 24, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 25, .irq_parent = 114, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 26, .irq_parent = 38, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 27, .irq_parent = 39, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 28, .irq_parent = 40, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 29, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 30, .irq_parent = 53, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 31, .irq_parent = 54, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 32, .irq_parent = 83, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 33, .irq_parent = 84, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 44, .irq_parent = 96, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 47, .irq_parent = 92, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 48, .irq_parent = 116, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 50, .irq_parent = 117, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 52, .irq_parent = 118, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 53, .irq_parent = 119, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 68, .irq_parent = 63, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 70, .irq_parent = 98, .chip = &stm32_exti_h_chip_direct },
+};
+
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
@@ -221,6 +263,13 @@ static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
 };
 
+static const struct stm32_exti_drv_data stm32mp13_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs = stm32mp13_desc_irq,
+	.irq_nr = ARRAY_SIZE(stm32mp13_desc_irq),
+};
+
 static const struct
 stm32_desc_irq *stm32_exti_get_desc(const struct stm32_exti_drv_data *drv_data,
 				    irq_hw_number_t hwirq)
@@ -922,6 +971,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 /* platform driver only for MP1 */
 static const struct of_device_id stm32_exti_ids[] = {
 	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
+	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_exti_ids);
-- 
2.17.1

