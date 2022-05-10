Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B0C522193
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347604AbiEJQsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347605AbiEJQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:48:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475A71F3E86
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:44:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ACcjCx032615;
        Tue, 10 May 2022 18:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=y/msJ7NIt3qJCHwYnvJUJKct6w9J6ESjrpSI6eYPwps=;
 b=DW/gqgnRf341zmWK8xvU6KBS1/M0kZLVEZWnGyGtjjDxOKbmTU49LG9jq2CHh1RCtyTb
 /MpXyNNb132DIr1VrYKAmhXJQJx79U9kyi/PTZr5ABQezNHAVM5mfhPwPWJpRsvXwd0O
 p3gkHjlhfo//qvtTolC+aGzPuyb5ObknPEspvLRB2R7tIALdWwYV0/NunJ4DHOW0hRF/
 AK8yGzWGuhr8BEz5xtn4RtCL3cnIIBH7aGfq+d/E7Ddy8JTu1+iBu7J06DMTPkY+GkhN
 aiLe0aNyoGZ0IyxLzRerLaKpeFmifeYHG4Qyo/sVRutDR2siwPOxRCDql/vZuspsSMY8 hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwg411f61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 18:44:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7E7110002A;
        Tue, 10 May 2022 18:44:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B1BE8231530;
        Tue, 10 May 2022 18:44:03 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 10 May 2022 18:44:02
 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: [PATCH 7/7] irqchip/stm32-exti: simplify irq description table
Date:   Tue, 10 May 2022 18:41:23 +0200
Message-ID: <20220510164123.557921-7-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510164123.557921-1-antonio.borneo@foss.st.com>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_04,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having removed the event trigger type from struct stm32_desc_irq
makes worthless keep using a struct.

Replace the struct by a single dimension array and use 8 bit type
to reduce the overal memory footprint.
On armv7a this patch reduces by 7% the size of the driver, from
   text    data     bss     dec     hex filename
   7133     448       4    7585    1da1 irq-stm32-exti.o
to
   6605     448       4    7057    1b91 irq-stm32-exti.o

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 220 ++++++++++++++-----------------
 1 file changed, 101 insertions(+), 119 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 2e00e78bf61e..f239895b00a8 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -39,16 +39,10 @@ struct stm32_exti_bank {
 
 #define UNDEF_REG ~0
 
-struct stm32_desc_irq {
-	u32 exti;
-	u32 irq_parent;
-};
-
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
-	const struct stm32_desc_irq *desc_irqs;
+	const u8 *desc_irqs;
 	u32 bank_nr;
-	u32 irq_nr;
 };
 
 struct stm32_exti_chip_data {
@@ -173,126 +167,114 @@ static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
 static struct irq_chip stm32_exti_h_chip;
 static struct irq_chip stm32_exti_h_chip_direct;
 
-static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6 },
-	{ .exti = 1, .irq_parent = 7 },
-	{ .exti = 2, .irq_parent = 8 },
-	{ .exti = 3, .irq_parent = 9 },
-	{ .exti = 4, .irq_parent = 10 },
-	{ .exti = 5, .irq_parent = 23 },
-	{ .exti = 6, .irq_parent = 64 },
-	{ .exti = 7, .irq_parent = 65 },
-	{ .exti = 8, .irq_parent = 66 },
-	{ .exti = 9, .irq_parent = 67 },
-	{ .exti = 10, .irq_parent = 40 },
-	{ .exti = 11, .irq_parent = 42 },
-	{ .exti = 12, .irq_parent = 76 },
-	{ .exti = 13, .irq_parent = 77 },
-	{ .exti = 14, .irq_parent = 121 },
-	{ .exti = 15, .irq_parent = 127 },
-	{ .exti = 16, .irq_parent = 1 },
-	{ .exti = 19, .irq_parent = 3 },
-	{ .exti = 21, .irq_parent = 31 },
-	{ .exti = 22, .irq_parent = 33 },
-	{ .exti = 23, .irq_parent = 72 },
-	{ .exti = 24, .irq_parent = 95 },
-	{ .exti = 25, .irq_parent = 107 },
-	{ .exti = 26, .irq_parent = 37 },
-	{ .exti = 27, .irq_parent = 38 },
-	{ .exti = 28, .irq_parent = 39 },
-	{ .exti = 29, .irq_parent = 71 },
-	{ .exti = 30, .irq_parent = 52 },
-	{ .exti = 31, .irq_parent = 53 },
-	{ .exti = 32, .irq_parent = 82 },
-	{ .exti = 33, .irq_parent = 83 },
-	{ .exti = 47, .irq_parent = 93 },
-	{ .exti = 48, .irq_parent = 138 },
-	{ .exti = 50, .irq_parent = 139 },
-	{ .exti = 52, .irq_parent = 140 },
-	{ .exti = 53, .irq_parent = 141 },
-	{ .exti = 54, .irq_parent = 135 },
-	{ .exti = 61, .irq_parent = 100 },
-	{ .exti = 65, .irq_parent = 144 },
-	{ .exti = 68, .irq_parent = 143 },
-	{ .exti = 70, .irq_parent = 62 },
-	{ .exti = 73, .irq_parent = 129 },
+#define EXTI_INVALID_IRQ       U8_MAX
+#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
+
+static const u8 stm32mp1_desc_irq[] = {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+
+	[0] = 6,
+	[1] = 7,
+	[2] = 8,
+	[3] = 9,
+	[4] = 10,
+	[5] = 23,
+	[6] = 64,
+	[7] = 65,
+	[8] = 66,
+	[9] = 67,
+	[10] = 40,
+	[11] = 42,
+	[12] = 76,
+	[13] = 77,
+	[14] = 121,
+	[15] = 127,
+	[16] = 1,
+	[19] = 3,
+	[21] = 31,
+	[22] = 33,
+	[23] = 72,
+	[24] = 95,
+	[25] = 107,
+	[26] = 37,
+	[27] = 38,
+	[28] = 39,
+	[29] = 71,
+	[30] = 52,
+	[31] = 53,
+	[32] = 82,
+	[33] = 83,
+	[47] = 93,
+	[48] = 138,
+	[50] = 139,
+	[52] = 140,
+	[53] = 141,
+	[54] = 135,
+	[61] = 100,
+	[65] = 144,
+	[68] = 143,
+	[70] = 62,
+	[73] = 129,
 };
 
-static const struct stm32_desc_irq stm32mp13_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6 },
-	{ .exti = 1, .irq_parent = 7 },
-	{ .exti = 2, .irq_parent = 8 },
-	{ .exti = 3, .irq_parent = 9 },
-	{ .exti = 4, .irq_parent = 10 },
-	{ .exti = 5, .irq_parent = 24 },
-	{ .exti = 6, .irq_parent = 65 },
-	{ .exti = 7, .irq_parent = 66 },
-	{ .exti = 8, .irq_parent = 67 },
-	{ .exti = 9, .irq_parent = 68 },
-	{ .exti = 10, .irq_parent = 41 },
-	{ .exti = 11, .irq_parent = 43 },
-	{ .exti = 12, .irq_parent = 77 },
-	{ .exti = 13, .irq_parent = 78 },
-	{ .exti = 14, .irq_parent = 106 },
-	{ .exti = 15, .irq_parent = 109 },
-	{ .exti = 16, .irq_parent = 1 },
-	{ .exti = 19, .irq_parent = 3 },
-	{ .exti = 21, .irq_parent = 32 },
-	{ .exti = 22, .irq_parent = 34 },
-	{ .exti = 23, .irq_parent = 73 },
-	{ .exti = 24, .irq_parent = 93 },
-	{ .exti = 25, .irq_parent = 114 },
-	{ .exti = 26, .irq_parent = 38 },
-	{ .exti = 27, .irq_parent = 39 },
-	{ .exti = 28, .irq_parent = 40 },
-	{ .exti = 29, .irq_parent = 72 },
-	{ .exti = 30, .irq_parent = 53 },
-	{ .exti = 31, .irq_parent = 54 },
-	{ .exti = 32, .irq_parent = 83 },
-	{ .exti = 33, .irq_parent = 84 },
-	{ .exti = 44, .irq_parent = 96 },
-	{ .exti = 47, .irq_parent = 92 },
-	{ .exti = 48, .irq_parent = 116 },
-	{ .exti = 50, .irq_parent = 117 },
-	{ .exti = 52, .irq_parent = 118 },
-	{ .exti = 53, .irq_parent = 119 },
-	{ .exti = 68, .irq_parent = 63 },
-	{ .exti = 70, .irq_parent = 98 },
+static const u8 stm32mp13_desc_irq[] = {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+
+	[0] = 6,
+	[1] = 7,
+	[2] = 8,
+	[3] = 9,
+	[4] = 10,
+	[5] = 24,
+	[6] = 65,
+	[7] = 66,
+	[8] = 67,
+	[9] = 68,
+	[10] = 41,
+	[11] = 43,
+	[12] = 77,
+	[13] = 78,
+	[14] = 106,
+	[15] = 109,
+	[16] = 1,
+	[19] = 3,
+	[21] = 32,
+	[22] = 34,
+	[23] = 73,
+	[24] = 93,
+	[25] = 114,
+	[26] = 38,
+	[27] = 39,
+	[28] = 40,
+	[29] = 72,
+	[30] = 53,
+	[31] = 54,
+	[32] = 83,
+	[33] = 84,
+	[44] = 96,
+	[47] = 92,
+	[48] = 116,
+	[50] = 117,
+	[52] = 118,
+	[53] = 119,
+	[68] = 63,
+	[70] = 98,
 };
 
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
 	.desc_irqs = stm32mp1_desc_irq,
-	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
 };
 
 static const struct stm32_exti_drv_data stm32mp13_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
 	.desc_irqs = stm32mp13_desc_irq,
-	.irq_nr = ARRAY_SIZE(stm32mp13_desc_irq),
 };
 
-static const struct
-stm32_desc_irq *stm32_exti_get_desc(const struct stm32_exti_drv_data *drv_data,
-				    irq_hw_number_t hwirq)
-{
-	const struct stm32_desc_irq *desc = NULL;
-	int i;
-
-	if (!drv_data->desc_irqs)
-		return NULL;
-
-	for (i = 0; i < drv_data->irq_nr; i++) {
-		desc = &drv_data->desc_irqs[i];
-		if (desc->exti == hwirq)
-			break;
-	}
-
-	return desc;
-}
-
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
@@ -724,7 +706,7 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 {
 	struct stm32_exti_host_data *host_data = dm->host_data;
 	struct stm32_exti_chip_data *chip_data;
-	const struct stm32_desc_irq *desc;
+	u8 desc_irq;
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec p_fwspec;
 	irq_hw_number_t hwirq;
@@ -739,21 +721,21 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	bank  = hwirq / IRQS_PER_BANK;
 	chip_data = &host_data->chips_data[bank];
 
-
-	desc = stm32_exti_get_desc(host_data->drv_data, hwirq);
-	if (!desc)
-		return -EINVAL;
-
 	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
 	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
 	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
 
 	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
-	if (desc->irq_parent) {
+
+	if (!host_data->drv_data || !host_data->drv_data->desc_irqs)
+		return -EINVAL;
+
+	desc_irq = host_data->drv_data->desc_irqs[hwirq];
+	if (desc_irq != EXTI_INVALID_IRQ) {
 		p_fwspec.fwnode = dm->parent->fwnode;
 		p_fwspec.param_count = 3;
 		p_fwspec.param[0] = GIC_SPI;
-		p_fwspec.param[1] = desc->irq_parent;
+		p_fwspec.param[1] = desc_irq;
 		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
 
 		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
-- 
2.36.0

