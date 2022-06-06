Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4A53E877
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiFFQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241722AbiFFQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:29:15 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B4B3249AA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:29:13 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256DGp1j017522;
        Mon, 6 Jun 2022 18:28:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=X3R3dd9ZyKVc3FVNHzLE7U3uNwNEI+eXY7lzN95+kzo=;
 b=FGq04MMr2hzi+slj8HcJS2HdUBYOzHU+D2OcWJC2Kzi7+jUYMvcAflQsnL2e4/OKdBC9
 JNJkjgt4/VwYwS+HWj/KVTOP642DGwYqZMsypDAO2F2Wfuc08qtK/9fqq3zjFhfSbcz5
 4Aywv1fKxO7R0+yBTiYzpgPvoIhhCGlihp30NN1w/PjVlIj88jmMVWJeKoWRr2kxZ5Zy
 FkhB+z7MaWQ2+id5ADHOtoC/dfHrX449ZBVNjVmmYAOAo/eUtvdDyXLeXKb8hU7Y0oGw
 eVbIHnIugUK4oE5sbdQVk+2J4pkhIGpP+pcDpcQhsqetieWKfKrPEwVgbLLHoy/8efAN 8Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gfx9huhk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 18:28:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C7B0C100039;
        Mon,  6 Jun 2022 18:28:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C1507231DC0;
        Mon,  6 Jun 2022 18:28:41 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 6 Jun
 2022 18:28:41 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Loic Pallardy <loic.pallardy@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>
Subject: [PATCH v2 2/6] irqchip/stm32-exti: Fix irq_mask/irq_unmask for direct events
Date:   Mon, 6 Jun 2022 18:27:53 +0200
Message-ID: <20220606162757.415354-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510164123.557921-1-antonio.borneo@foss.st.com>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
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

From: Loic Pallardy <loic.pallardy@foss.st.com>

The driver has to mask/unmask the corresponding flag in the
Interrupt Mask Register (IMR).
This is already done for configurable event, while direct events
only forward the mask/unmask request to the parent.

Use the existing stm32_exti_h_mask()/stm32_exti_h_unmask() for
direct events too.

Signed-off-by: Loic Pallardy <loic.pallardy@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 10c9c742c216..1145f064faa8 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -691,8 +691,8 @@ static struct irq_chip stm32_exti_h_chip_direct = {
 	.name			= "stm32-exti-h-direct",
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_ack		= irq_chip_ack_parent,
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_mask		= stm32_exti_h_mask,
+	.irq_unmask		= stm32_exti_h_unmask,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= irq_chip_set_type_parent,
 	.irq_set_wake		= stm32_exti_h_set_wake,
-- 
2.36.1

