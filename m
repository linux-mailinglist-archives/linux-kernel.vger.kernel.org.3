Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAAF52217A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbiEJQq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347555AbiEJQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:46:53 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCE2A727
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:42:54 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ACrHKi011776;
        Tue, 10 May 2022 18:42:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=a+EtpUIXpsP9dQ8fNMclc8SiQiMp8KylWZlaOQgjTPM=;
 b=QTrxWQTWRXT0pQUuhBhAf3cwM1Y6Q0mE8NPUntRuxaVlTW0/lWKPd1yX+OEvNKBtefzc
 aPrTy4PF3nwhhJugGYcB+yqTt/ERkxhuLXPgWV44kruG9FCz2UsypW9Ix6oDgxuFc2bZ
 zROM11by3CPoMgtzV9XEDhRW0BTClmpIt0y9v3g4BB1EqSClNMXZIRdG0gJOaPhZFVj5
 FQAN9I58rgz6C+tKXib7KsHizeY042FuVza2F19izNYplkkW2O/0Peol6ul+kctapsGI
 M5qrytUZeUpnPsPJRY8MiocYUpHq2G1nZYHOSnGUwZ4VUOtILlzsegRmShyPbxV08OXD hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwfngkwxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 18:42:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BA8510002A;
        Tue, 10 May 2022 18:42:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 199C022ECFA;
        Tue, 10 May 2022 18:42:20 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 10 May 2022 18:42:19
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
Subject: [PATCH 1/7] irqchip/stm32-exti: set_affinity return IRQ_SET_MASK_OK_DONE if no parent
Date:   Tue, 10 May 2022 18:41:17 +0200
Message-ID: <20220510164123.557921-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.0
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

From: Ludovic Barre <ludovic.barre@foss.st.com>

If no parent, there is no specific action to do in
stm32 irqchip, and so return IRQ_SET_MASK_OK_DONE.

Signed-off-by: Ludovic Barre <ludovic.barre@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 9d18f47040eb..10c9c742c216 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -614,7 +614,7 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	if (d->parent_data->chip)
 		return irq_chip_set_affinity_parent(d, dest, force);
 
-	return -EINVAL;
+	return IRQ_SET_MASK_OK_DONE;
 }
 
 static int __maybe_unused stm32_exti_h_suspend(void)
-- 
2.36.0

