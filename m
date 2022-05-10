Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0852217C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347560AbiEJQrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343547AbiEJQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:46:53 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDB323BC6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:42:53 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AF57Dc032368;
        Tue, 10 May 2022 18:42:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=OnIqBC652dGZO3WZb/2lM8W2Bu2100kdB0YW8gEUpuY=;
 b=B2tiqDASPfzSCX/Z5RU04HGscUpJxkNRsgHSsmFNPsIFhdZQziRfwifYm8N6s50oAF3K
 ptH17hiPnFYOKhXCYK44m7QEgmLwhvenM6QGVW0bhY4bJ/AnzUzdHcd4y7dcms+wstqw
 FWbS7oq/0U+xO2PcRcPjOqj8SFb/hw8teEheBotcd+LtEE/5AAAqKjxfKlUaXK/mvLm+
 wiCY467kL9JiyBBuMaEEB14TjiItN5u+mt1H4jYXzLwl9bbj2jw7P628bbu9eZRVnXVK
 NV0LtlcNyYYBsTTuK65EUzDNnYrLjQ6kZFa2Fnzu/S2Z9fhI2MvJ06Jb565nl41bMxmd LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwfngkx0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 18:42:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF9E0100034;
        Tue, 10 May 2022 18:42:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D8CAF23152B;
        Tue, 10 May 2022 18:42:34 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 10 May 2022 18:42:33
 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Ludovic Barre <ludovic.barre@foss.st.com>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>
Subject: [PATCH 3/7] irqchip/stm32-exti: remove EMR register access for stm32mp15
Date:   Tue, 10 May 2022 18:41:19 +0200
Message-ID: <20220510164123.557921-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510164123.557921-1-antonio.borneo@foss.st.com>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
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

From: Alexandre Torgue <alexandre.torgue@foss.st.com>

C1EMRx registers are not accessible on STM32MP15x.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 1145f064faa8..c8003f4f0457 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -132,7 +132,6 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 	.imr_ofst	= 0x80,
-	.emr_ofst	= 0x84,
 	.rtsr_ofst	= 0x00,
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
@@ -142,7 +141,6 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 	.imr_ofst	= 0x90,
-	.emr_ofst	= 0x94,
 	.rtsr_ofst	= 0x20,
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
@@ -152,7 +150,6 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b3 = {
 	.imr_ofst	= 0xA0,
-	.emr_ofst	= 0xA4,
 	.rtsr_ofst	= 0x40,
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
@@ -792,7 +789,8 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	writel_relaxed(0, base + stm32_bank->emr_ofst);
+	if (stm32_bank->emr_ofst)
+		writel_relaxed(0, base + stm32_bank->emr_ofst);
 
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
-- 
2.36.0

