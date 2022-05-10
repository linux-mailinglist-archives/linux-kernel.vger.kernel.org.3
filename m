Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CAD522181
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347563AbiEJQrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347539AbiEJQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:46:55 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309AF31527
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:42:56 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AD9BZE028201;
        Tue, 10 May 2022 18:42:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=QWngG9+xWY4MUBFAbNnXrMXXahmezHTgt/gHbcN7PIs=;
 b=DpvW3JFJz4SZbUOmAl21NnTnTv2kroZA2D/NZQqhwEELHJ4BF+G3JU3ZDrnSwfT6i1rR
 P/1ZDnwWjc1NwSPHFFpUk+ppa9IWqOV99Lw2k6PVVK502PEkxfbXWVkYFfQeB4QnNq52
 AE3QQxEEKmyiw2FicrVspOy4Ku4Fug9mpX41Sj04eBDI1FsGXXA5vtfOEiZi3X0jEB3N
 aCODeOL57qW1/p4bK8+H6L4kT1J6JOkk1Q3f+VeU90JTcBQXxBwgrKmCm4W/g57+XWrd
 G8RosAW5RfcrLkQW1YyFHQ8jtnBInWf9e7zWQm6N5yc32fb8Qo4Bn2redLBH5CCfLrX5 SQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwg411ey1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 18:42:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F10210002A;
        Tue, 10 May 2022 18:42:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 090CA231524;
        Tue, 10 May 2022 18:42:29 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 10 May 2022 18:42:28
 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Loic Pallardy <loic.pallardy@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>
Subject: [PATCH 2/7] irqchip/stm32-exti: manage IMR at each mask/unmask for direct event
Date:   Tue, 10 May 2022 18:41:18 +0200
Message-ID: <20220510164123.557921-2-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510164123.557921-1-antonio.borneo@foss.st.com>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
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

From: Loic Pallardy <loic.pallardy@foss.st.com>

Enable EXTI line through IMR also on direct event.

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
2.36.0

