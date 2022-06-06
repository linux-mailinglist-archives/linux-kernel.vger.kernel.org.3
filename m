Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED153E676
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbiFFQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbiFFQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:29:59 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A932A8C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:29:55 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256EQ7Ht029277;
        Mon, 6 Jun 2022 18:29:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=7wleXYvej/vVXqg+uqOXHYZ7q3JhQoZvov52zABZCZg=;
 b=qAQA97zQuo9Xv203QnZOYjctJc/XDum1SDUyZ54X6Jd2NV1z1CZcsj+7ah5NaEK7wUPX
 iHjthR0hdxKYWsgyXinnF/XvZ5qqgDLtto5VzNxLMB55omsZjOxMGG6+GzlWUWQXXNXM
 JQ+buXTsXCuaVWzcjKskJdRvow1+dj6MtQ6BDLTsiwoUlSAmMFDqnbA1s8G5IVKzL1gZ
 IA5rQyZ4dbdvYGXo9a1joqFK0UwkT7IUXBOL5AYui/rgRAu/mmMZ4QGmpl6O9xlBNwIy
 Ygepsay5bpokKFLMNFTnaG5uuFVPSm20JejpWbyLrkR58/VQen9sWdCMZeh+W8o8a9NJ 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gfxr23b3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 18:29:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE15410002A;
        Mon,  6 Jun 2022 18:29:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C6AD8231DC3;
        Mon,  6 Jun 2022 18:29:43 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 6 Jun
 2022 18:29:43 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: [PATCH v2 5/6] irqchip/stm32-exti: Read event trigger type from event_trg register
Date:   Mon, 6 Jun 2022 18:27:56 +0200
Message-ID: <20220606162757.415354-6-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510164123.557921-1-antonio.borneo@foss.st.com>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
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

The flag reporting whether an event is 'direct' or 'configurable'
is available in the read-only registers EVENT_TRG.

Drop this redundant information from the struct stm32_desc_irq and
use the proper bit from EVENT_TRG register.
On armv7a this patch reduces by 3% the size of the driver, from
   text    data     bss     dec     hex filename
   7233     424       4    7661    1ded irq-stm32-exti.o
to
   6977     424       4    7405    1ced irq-stm32-exti.o

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 180 ++++++++++++++++---------------
 1 file changed, 96 insertions(+), 84 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e8fa91bda4ba..045589627e67 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -34,6 +34,7 @@ struct stm32_exti_bank {
 	u32 swier_ofst;
 	u32 rpr_ofst;
 	u32 fpr_ofst;
+	u32 trg_ofst;
 };
 
 #define UNDEF_REG ~0
@@ -41,7 +42,6 @@ struct stm32_exti_bank {
 struct stm32_desc_irq {
 	u32 exti;
 	u32 irq_parent;
-	struct irq_chip *chip;
 };
 
 struct stm32_exti_drv_data {
@@ -78,6 +78,7 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.swier_ofst	= 0x10,
 	.rpr_ofst	= 0x14,
 	.fpr_ofst	= UNDEF_REG,
+	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
@@ -97,6 +98,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.swier_ofst	= 0x08,
 	.rpr_ofst	= 0x88,
 	.fpr_ofst	= UNDEF_REG,
+	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
@@ -107,6 +109,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
 	.swier_ofst	= 0x28,
 	.rpr_ofst	= 0x98,
 	.fpr_ofst	= UNDEF_REG,
+	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
@@ -117,6 +120,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
 	.swier_ofst	= 0x48,
 	.rpr_ofst	= 0xA8,
 	.fpr_ofst	= UNDEF_REG,
+	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
@@ -138,6 +142,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 	.swier_ofst	= 0x08,
 	.rpr_ofst	= 0x0C,
 	.fpr_ofst	= 0x10,
+	.trg_ofst	= 0x3EC,
 };
 
 static const struct stm32_exti_bank stm32mp1_exti_b2 = {
@@ -148,6 +153,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 	.swier_ofst	= 0x28,
 	.rpr_ofst	= 0x2C,
 	.fpr_ofst	= 0x30,
+	.trg_ofst	= 0x3E8,
 };
 
 static const struct stm32_exti_bank stm32mp1_exti_b3 = {
@@ -158,6 +164,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b3 = {
 	.swier_ofst	= 0x48,
 	.rpr_ofst	= 0x4C,
 	.fpr_ofst	= 0x50,
+	.trg_ofst	= 0x3E4,
 };
 
 static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
@@ -170,90 +177,90 @@ static struct irq_chip stm32_exti_h_chip;
 static struct irq_chip stm32_exti_h_chip_direct;
 
 static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
-	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
-	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
-	{ .exti = 3, .irq_parent = 9, .chip = &stm32_exti_h_chip },
-	{ .exti = 4, .irq_parent = 10, .chip = &stm32_exti_h_chip },
-	{ .exti = 5, .irq_parent = 23, .chip = &stm32_exti_h_chip },
-	{ .exti = 6, .irq_parent = 64, .chip = &stm32_exti_h_chip },
-	{ .exti = 7, .irq_parent = 65, .chip = &stm32_exti_h_chip },
-	{ .exti = 8, .irq_parent = 66, .chip = &stm32_exti_h_chip },
-	{ .exti = 9, .irq_parent = 67, .chip = &stm32_exti_h_chip },
-	{ .exti = 10, .irq_parent = 40, .chip = &stm32_exti_h_chip },
-	{ .exti = 11, .irq_parent = 42, .chip = &stm32_exti_h_chip },
-	{ .exti = 12, .irq_parent = 76, .chip = &stm32_exti_h_chip },
-	{ .exti = 13, .irq_parent = 77, .chip = &stm32_exti_h_chip },
-	{ .exti = 14, .irq_parent = 121, .chip = &stm32_exti_h_chip },
-	{ .exti = 15, .irq_parent = 127, .chip = &stm32_exti_h_chip },
-	{ .exti = 16, .irq_parent = 1, .chip = &stm32_exti_h_chip },
-	{ .exti = 19, .irq_parent = 3, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 21, .irq_parent = 31, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 22, .irq_parent = 33, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 23, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 24, .irq_parent = 95, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 25, .irq_parent = 107, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 26, .irq_parent = 37, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 27, .irq_parent = 38, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 28, .irq_parent = 39, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 29, .irq_parent = 71, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 30, .irq_parent = 52, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 31, .irq_parent = 53, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 32, .irq_parent = 82, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 33, .irq_parent = 83, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 47, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 48, .irq_parent = 138, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 50, .irq_parent = 139, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 52, .irq_parent = 140, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 53, .irq_parent = 141, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 54, .irq_parent = 135, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 61, .irq_parent = 100, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 65, .irq_parent = 144, .chip = &stm32_exti_h_chip },
-	{ .exti = 68, .irq_parent = 143, .chip = &stm32_exti_h_chip },
-	{ .exti = 70, .irq_parent = 62, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 73, .irq_parent = 129, .chip = &stm32_exti_h_chip },
+	{ .exti = 0, .irq_parent = 6 },
+	{ .exti = 1, .irq_parent = 7 },
+	{ .exti = 2, .irq_parent = 8 },
+	{ .exti = 3, .irq_parent = 9 },
+	{ .exti = 4, .irq_parent = 10 },
+	{ .exti = 5, .irq_parent = 23 },
+	{ .exti = 6, .irq_parent = 64 },
+	{ .exti = 7, .irq_parent = 65 },
+	{ .exti = 8, .irq_parent = 66 },
+	{ .exti = 9, .irq_parent = 67 },
+	{ .exti = 10, .irq_parent = 40 },
+	{ .exti = 11, .irq_parent = 42 },
+	{ .exti = 12, .irq_parent = 76 },
+	{ .exti = 13, .irq_parent = 77 },
+	{ .exti = 14, .irq_parent = 121 },
+	{ .exti = 15, .irq_parent = 127 },
+	{ .exti = 16, .irq_parent = 1 },
+	{ .exti = 19, .irq_parent = 3 },
+	{ .exti = 21, .irq_parent = 31 },
+	{ .exti = 22, .irq_parent = 33 },
+	{ .exti = 23, .irq_parent = 72 },
+	{ .exti = 24, .irq_parent = 95 },
+	{ .exti = 25, .irq_parent = 107 },
+	{ .exti = 26, .irq_parent = 37 },
+	{ .exti = 27, .irq_parent = 38 },
+	{ .exti = 28, .irq_parent = 39 },
+	{ .exti = 29, .irq_parent = 71 },
+	{ .exti = 30, .irq_parent = 52 },
+	{ .exti = 31, .irq_parent = 53 },
+	{ .exti = 32, .irq_parent = 82 },
+	{ .exti = 33, .irq_parent = 83 },
+	{ .exti = 47, .irq_parent = 93 },
+	{ .exti = 48, .irq_parent = 138 },
+	{ .exti = 50, .irq_parent = 139 },
+	{ .exti = 52, .irq_parent = 140 },
+	{ .exti = 53, .irq_parent = 141 },
+	{ .exti = 54, .irq_parent = 135 },
+	{ .exti = 61, .irq_parent = 100 },
+	{ .exti = 65, .irq_parent = 144 },
+	{ .exti = 68, .irq_parent = 143 },
+	{ .exti = 70, .irq_parent = 62 },
+	{ .exti = 73, .irq_parent = 129 },
 };
 
 static const struct stm32_desc_irq stm32mp13_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
-	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
-	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
-	{ .exti = 3, .irq_parent = 9, .chip = &stm32_exti_h_chip },
-	{ .exti = 4, .irq_parent = 10, .chip = &stm32_exti_h_chip },
-	{ .exti = 5, .irq_parent = 24, .chip = &stm32_exti_h_chip },
-	{ .exti = 6, .irq_parent = 65, .chip = &stm32_exti_h_chip },
-	{ .exti = 7, .irq_parent = 66, .chip = &stm32_exti_h_chip },
-	{ .exti = 8, .irq_parent = 67, .chip = &stm32_exti_h_chip },
-	{ .exti = 9, .irq_parent = 68, .chip = &stm32_exti_h_chip },
-	{ .exti = 10, .irq_parent = 41, .chip = &stm32_exti_h_chip },
-	{ .exti = 11, .irq_parent = 43, .chip = &stm32_exti_h_chip },
-	{ .exti = 12, .irq_parent = 77, .chip = &stm32_exti_h_chip },
-	{ .exti = 13, .irq_parent = 78, .chip = &stm32_exti_h_chip },
-	{ .exti = 14, .irq_parent = 106, .chip = &stm32_exti_h_chip },
-	{ .exti = 15, .irq_parent = 109, .chip = &stm32_exti_h_chip },
-	{ .exti = 16, .irq_parent = 1, .chip = &stm32_exti_h_chip },
-	{ .exti = 19, .irq_parent = 3, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 21, .irq_parent = 32, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 22, .irq_parent = 34, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 23, .irq_parent = 73, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 24, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 25, .irq_parent = 114, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 26, .irq_parent = 38, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 27, .irq_parent = 39, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 28, .irq_parent = 40, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 29, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 30, .irq_parent = 53, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 31, .irq_parent = 54, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 32, .irq_parent = 83, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 33, .irq_parent = 84, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 44, .irq_parent = 96, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 47, .irq_parent = 92, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 48, .irq_parent = 116, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 50, .irq_parent = 117, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 52, .irq_parent = 118, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 53, .irq_parent = 119, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 68, .irq_parent = 63, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 70, .irq_parent = 98, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 0, .irq_parent = 6 },
+	{ .exti = 1, .irq_parent = 7 },
+	{ .exti = 2, .irq_parent = 8 },
+	{ .exti = 3, .irq_parent = 9 },
+	{ .exti = 4, .irq_parent = 10 },
+	{ .exti = 5, .irq_parent = 24 },
+	{ .exti = 6, .irq_parent = 65 },
+	{ .exti = 7, .irq_parent = 66 },
+	{ .exti = 8, .irq_parent = 67 },
+	{ .exti = 9, .irq_parent = 68 },
+	{ .exti = 10, .irq_parent = 41 },
+	{ .exti = 11, .irq_parent = 43 },
+	{ .exti = 12, .irq_parent = 77 },
+	{ .exti = 13, .irq_parent = 78 },
+	{ .exti = 14, .irq_parent = 106 },
+	{ .exti = 15, .irq_parent = 109 },
+	{ .exti = 16, .irq_parent = 1 },
+	{ .exti = 19, .irq_parent = 3 },
+	{ .exti = 21, .irq_parent = 32 },
+	{ .exti = 22, .irq_parent = 34 },
+	{ .exti = 23, .irq_parent = 73 },
+	{ .exti = 24, .irq_parent = 93 },
+	{ .exti = 25, .irq_parent = 114 },
+	{ .exti = 26, .irq_parent = 38 },
+	{ .exti = 27, .irq_parent = 39 },
+	{ .exti = 28, .irq_parent = 40 },
+	{ .exti = 29, .irq_parent = 72 },
+	{ .exti = 30, .irq_parent = 53 },
+	{ .exti = 31, .irq_parent = 54 },
+	{ .exti = 32, .irq_parent = 83 },
+	{ .exti = 33, .irq_parent = 84 },
+	{ .exti = 44, .irq_parent = 96 },
+	{ .exti = 47, .irq_parent = 92 },
+	{ .exti = 48, .irq_parent = 116 },
+	{ .exti = 50, .irq_parent = 117 },
+	{ .exti = 52, .irq_parent = 118 },
+	{ .exti = 53, .irq_parent = 119 },
+	{ .exti = 68, .irq_parent = 63 },
+	{ .exti = 70, .irq_parent = 98 },
 };
 
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
@@ -711,6 +718,8 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	struct irq_fwspec p_fwspec;
 	irq_hw_number_t hwirq;
 	int bank;
+	u32 event_trg;
+	struct irq_chip *chip;
 
 	hwirq = fwspec->param[0];
 	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
@@ -724,8 +733,11 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	if (!desc)
 		return -EINVAL;
 
-	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, desc->chip,
-				      chip_data);
+	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
+	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
+	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
 	if (desc->irq_parent) {
 		p_fwspec.fwnode = dm->parent->fwnode;
 		p_fwspec.param_count = 3;
-- 
2.36.1

