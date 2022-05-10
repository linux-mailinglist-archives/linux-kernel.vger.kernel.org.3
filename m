Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102E52217E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347590AbiEJQrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347556AbiEJQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:46:53 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0B2CDDF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:42:54 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ADqApE011169;
        Tue, 10 May 2022 18:42:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=cT5bl4hMyx6MvIaEIWQIuKbjqZzMOn/zldfQYiAYDnY=;
 b=66oAUaRGuHee/hfzY4M7knaqvFlPa5NDiOIgt932BuJWDKHCt3pYfv1ibxkipjuOG5Rg
 LFOzU3EfE9ul06gh6UUC1hLOrUFZmeNVdjeuqJr2zfQvTdtU/68VUfKUBU8vIYmlFUqQ
 9mnNg23E8fDYFnQw4+E+ZZLj0awOYhKnt5/ZKMA6kYTp2/Ub4taYdTWJE/DUDZUio2rb
 8jCAvzmau13x1jBNhaAwA89+fVds5H5K2mIn/XD6T6jIhmxuEO5v7wJ0ZoaMIfo3BciB
 KjJ1uJly+0oBj2P7xZ0PBC8RI13tY7winl+JC4cdK2ABdvOysexFrznQtzWjcDnmz+xK 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwfngkx0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 18:42:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C004100038;
        Tue, 10 May 2022 18:42:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25FE823152B;
        Tue, 10 May 2022 18:42:38 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 10 May 2022 18:42:37
 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Pascal Paillet <p.paillet@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>
Subject: [PATCH 4/7] irqchip/stm32-exti: forward irq_request_resources to parent
Date:   Tue, 10 May 2022 18:41:20 +0200
Message-ID: <20220510164123.557921-4-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510164123.557921-1-antonio.borneo@foss.st.com>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
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

From: Pascal Paillet <p.paillet@foss.st.com>

Enhance stm32-exti driver to forward request_resources and
release_resources_parent operations to parent.
Do not use irq_request_resources_parent because it returns
an error when the parent does not implement irq_request_resources.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index c8003f4f0457..3f6d524a87fe 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -550,6 +550,16 @@ static void stm32_exti_h_unmask(struct irq_data *d)
 		irq_chip_unmask_parent(d);
 }
 
+static int stm32_exti_h_request_resources(struct irq_data *data)
+{
+	data = data->parent_data;
+
+	if (data->chip->irq_request_resources)
+		return data->chip->irq_request_resources(data);
+
+	return 0;
+}
+
 static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 {
 	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
@@ -677,6 +687,8 @@ static struct irq_chip stm32_exti_h_chip = {
 	.irq_eoi		= stm32_exti_h_eoi,
 	.irq_mask		= stm32_exti_h_mask,
 	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_request_resources	= stm32_exti_h_request_resources,
+	.irq_release_resources	= irq_chip_release_resources_parent,
 	.irq_retrigger		= stm32_exti_h_retrigger,
 	.irq_set_type		= stm32_exti_h_set_type,
 	.irq_set_wake		= stm32_exti_h_set_wake,
@@ -690,6 +702,8 @@ static struct irq_chip stm32_exti_h_chip_direct = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_mask		= stm32_exti_h_mask,
 	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_request_resources	= stm32_exti_h_request_resources,
+	.irq_release_resources	= irq_chip_release_resources_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= irq_chip_set_type_parent,
 	.irq_set_wake		= stm32_exti_h_set_wake,
-- 
2.36.0

