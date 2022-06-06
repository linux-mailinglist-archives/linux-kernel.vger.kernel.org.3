Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8344053EC89
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiFFQ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241726AbiFFQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:29:15 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA953249B6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:29:14 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256D2J0w030658;
        Mon, 6 Jun 2022 18:28:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=neoUJ8Q8MnVWs6Yy7PShzHl8kKF3V7sjILdSoqdJ1lk=;
 b=f9Yzktdknxath2c5tYr11ki58w90tkMiR8D2NxM65rTOBJMt/PlwgLOKScCRvTWyxir1
 Dsd6mVNsp6TSe9CMR6YHGglScVfki/fmqoEk1mN7OSc1Fuft78PqZxSuT5e036S9vcca
 kfkzeaQUozvNLoRYH27Eg8c7vZGQjYbzk8vo0AdBk+laZEUNXEH8gstQtMjz9Krj0d87
 5afPl670BgdcA+JusHKJsL2JKN9qQZywGD9eQbIV47noWKGozHq7X9WhmnIeisOJGmyP
 6ffyElQoeaQ85o5+iORK+pYtCyAgeIN7LjShZ3SMV6XRdXC7fJCcZpdErpl1m8eDdu8W eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gfvha3u2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 18:28:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37F3C10002A;
        Mon,  6 Jun 2022 18:28:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3191D231DC0;
        Mon,  6 Jun 2022 18:28:43 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 6 Jun
 2022 18:28:42 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Ludovic Barre <ludovic.barre@foss.st.com>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>
Subject: [PATCH v2 4/6] irqchip/stm32-exti: Tag emr register as undefined for stm32mp15
Date:   Mon, 6 Jun 2022 18:27:55 +0200
Message-ID: <20220606162757.415354-5-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510164123.557921-1-antonio.borneo@foss.st.com>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_04,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Torgue <alexandre.torgue@foss.st.com>

The reference manual RM0436 of stm32mp15 till version v4.0 was
erroneously reporting the Event Mask Registers (EMR) for the
Cortex-A CPUs.
These registers have been removed from v5.0 of the manual and the
corresponding offsets have been marked as 'Reserved'.

Prevent accessing these reserved addresses by tagging the EMR
offsets as UNDEF_REG and modifying the code to handle this case.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e2722e499ae5..e8fa91bda4ba 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -132,7 +132,7 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 	.imr_ofst	= 0x80,
-	.emr_ofst	= 0x84,
+	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x00,
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
@@ -142,7 +142,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 	.imr_ofst	= 0x90,
-	.emr_ofst	= 0x94,
+	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x20,
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
@@ -152,7 +152,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 
 static const struct stm32_exti_bank stm32mp1_exti_b3 = {
 	.imr_ofst	= 0xA0,
-	.emr_ofst	= 0xA4,
+	.emr_ofst	= UNDEF_REG,
 	.rtsr_ofst	= 0x40,
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
@@ -795,7 +795,8 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	writel_relaxed(0, base + stm32_bank->emr_ofst);
+	if (stm32_bank->emr_ofst != UNDEF_REG)
+		writel_relaxed(0, base + stm32_bank->emr_ofst);
 
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
-- 
2.36.1

