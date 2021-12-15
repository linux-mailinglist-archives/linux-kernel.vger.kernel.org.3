Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5525247571B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbhLOK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:59:23 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50978 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241838AbhLOK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:59:13 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF9Fb0n015598;
        Wed, 15 Dec 2021 11:58:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=X9dVnytFI7OAO3IiR0FuXUg5I3PpVRIoMb/bwqZaTCg=;
 b=RuERZtZ816tZiFVtM/giJiWtXdUqsraHFF/Ye7ECPo4YcTGfEQcElYyfF/P3ilTYVpq6
 bbrnK645KrqAyPlOSZPp6nci6DKi1FK99v/BrvDoYSR2KT1z8dI+afpm+iIGyTNm8mzT
 Auv7v5ATUrS/Oy96ZH5cpE06Ox6ZJeOzickaBDqygjpmTdO94gVGpUFI6bT3EPcEPC9g
 LZ3lRQTzjMuuPdRcnRWITpCiv8sgA1V7o5aiN7gLTbqt1Oe8tAHtLKGSEnpm3/5ymfWh
 Rz4dDEqt+Z7tmx0l5B/wvygeqQrQBdB3H2hLLA2+ymM2LhE+6zSuT966MMl98rx+FtIm Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxrthy017-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:58:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88CC6100038;
        Wed, 15 Dec 2021 11:58:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7FCF9235F6C;
        Wed, 15 Dec 2021 11:58:53 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 11:58:53
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v2 2/5] irqchip/stm32: use device tree to define EXTI-GIC mapping
Date:   Wed, 15 Dec 2021 11:58:44 +0100
Message-ID: <20211215105847.2328-3-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_08,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware mapping between EXTI line and GIC line better fits with device
tree description. It avoids also to waste memory space as this mapping is
SoC dependent. Note that stm32mp15 table is kept to ensure backward
compatibility.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b7cb2da71888..b56530675799 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -21,6 +21,7 @@
 #include <linux/syscore_ops.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/stm32-exti.h>
 
 #define IRQS_PER_BANK 32
 
@@ -46,7 +47,7 @@ struct stm32_desc_irq {
 
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
-	const struct stm32_desc_irq *desc_irqs;
+	struct stm32_desc_irq *desc_irqs;
 	u32 bank_nr;
 	u32 irq_nr;
 };
@@ -66,6 +67,8 @@ struct stm32_exti_host_data {
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
 	struct hwspinlock *hwlock;
+	struct stm32_desc_irq *desc_irqs;
+	u32 irq_nr;
 };
 
 static struct stm32_exti_host_data *stm32_host_data;
@@ -169,7 +172,7 @@ static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
 static struct irq_chip stm32_exti_h_chip;
 static struct irq_chip stm32_exti_h_chip_direct;
 
-static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
+static struct stm32_desc_irq stm32mp1_desc_irq[] = {
 	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
 	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
 	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
@@ -221,20 +224,28 @@ static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
 };
 
-static const struct
-stm32_desc_irq *stm32_exti_get_desc(const struct stm32_exti_drv_data *drv_data,
-				    irq_hw_number_t hwirq)
+static struct
+stm32_desc_irq *stm32_exti_get_desc(struct stm32_exti_host_data *host_data, irq_hw_number_t hwirq)
 {
-	const struct stm32_desc_irq *desc = NULL;
+	const struct stm32_exti_drv_data *drv_data = host_data->drv_data;
+	struct stm32_desc_irq *desc = NULL;
+	u32 irq_nr;
 	int i;
 
-	if (!drv_data->desc_irqs)
+	if (host_data->desc_irqs) {
+		desc = &host_data->desc_irqs[0];
+		irq_nr = host_data->irq_nr;
+	} else if (drv_data && drv_data->desc_irqs) {
+		desc = &drv_data->desc_irqs[0];
+		irq_nr = drv_data->irq_nr;
+	} else {
 		return NULL;
+	}
 
-	for (i = 0; i < drv_data->irq_nr; i++) {
-		desc = &drv_data->desc_irqs[i];
+	for (i = 0; i < irq_nr; i++) {
 		if (desc->exti == hwirq)
 			break;
+		desc++;
 	}
 
 	return desc;
@@ -657,7 +668,7 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 {
 	struct stm32_exti_host_data *host_data = dm->host_data;
 	struct stm32_exti_chip_data *chip_data;
-	const struct stm32_desc_irq *desc;
+	struct stm32_desc_irq *desc;
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec p_fwspec;
 	irq_hw_number_t hwirq;
@@ -668,7 +679,7 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	chip_data = &host_data->chips_data[bank];
 
 
-	desc = stm32_exti_get_desc(host_data->drv_data, hwirq);
+	desc = stm32_exti_get_desc(host_data, hwirq);
 	if (!desc)
 		return -EINVAL;
 
@@ -687,6 +698,50 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	return 0;
 }
 
+static int stm32_exti_get_irq_mapping(struct device *dev, struct stm32_exti_host_data *host_data)
+{
+	struct device_node *np = dev->of_node;
+	const __be32 *p = NULL;
+	struct property *prop;
+	int i, ret;
+	u32 chip;
+
+	prop = of_find_property(np, "st,exti-mapping", NULL);
+	if (!prop) {
+		dev_dbg(dev, "st,exti-mapping DT property not provided");
+		return 0;
+	}
+
+	ret = of_property_count_elems_of_size(np, "st,exti-mapping",
+					      STM32_EXTI_MAPPING_CELL_NB * sizeof(u32));
+	if (ret <= 0) {
+		dev_err(dev, "Wrong EXTI/GIC mapping!\n");
+		return ret;
+	}
+
+	host_data->irq_nr = ret;
+
+	host_data->desc_irqs = devm_kzalloc(dev, host_data->irq_nr * sizeof(*host_data->desc_irqs),
+					    GFP_KERNEL);
+	if (!host_data->desc_irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < host_data->irq_nr; i++) {
+		p = of_prop_next_u32(prop, p, &host_data->desc_irqs[i].exti);
+		p = of_prop_next_u32(prop, p, &host_data->desc_irqs[i].irq_parent);
+		p = of_prop_next_u32(prop, p, &chip);
+
+		if (chip == STM32_EXTI_TYPE_CONFIGURABLE)
+			host_data->desc_irqs[i].chip = &stm32_exti_h_chip;
+		else if (chip == STM32_EXTI_TYPE_DIRECT)
+			host_data->desc_irqs[i].chip = &stm32_exti_h_chip_direct;
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct
 stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 					   struct device_node *node)
@@ -910,6 +965,10 @@ static int stm32_exti_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ret = stm32_exti_get_irq_mapping(dev, host_data);
+	if (ret)
+		return ret;
+
 	ret = devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
 	if (ret)
 		return ret;
-- 
2.17.1

