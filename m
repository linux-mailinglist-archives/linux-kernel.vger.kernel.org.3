Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8246753E7BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241775AbiFFQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbiFFQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:29:14 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C387A324993
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:29:13 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256F1XC5021423;
        Mon, 6 Jun 2022 18:28:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=MJUdj1zP+sx1j811Eaq4RVk/PwdjBT6XHosmIPCWXnk=;
 b=Kd9XeKDGmWAFqUhE8ADV3otWFSzM3m3d4da1S7eP7pIaKT1oWnJymLwdq/2KJ7LSgp68
 Ipx5mIWhqqhtZuGtLWM4Ikf6Cvwpgx3pkgCjHYlEU7/3lMp9aI6igiLZvPfzfDC7OgMX
 Wsd49KcP5xNDf+bFCFCv7zBUjqqmHmjOoYNvQbX4AEagMOvgYDKKLui0miE/r8OCKaxn
 zHoLwHl+4QvCz8+cvMcHkx6I+a8CHN/c4dKWw/qSdlvTYZpiphPWICSIhRggkvErrSBH
 qpRm2ISaMW7N5kM8StkXxwL3P+RCIG0aPJ5/LURHzbUOr9QJJ/4yFv75ZlUUAKeFH7bg fA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gfvha3u29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 18:28:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41FD010002A;
        Mon,  6 Jun 2022 18:28:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3BA53231DC0;
        Mon,  6 Jun 2022 18:28:42 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE1.st.com (10.75.129.69)
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
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: [PATCH v2 3/6] irqchip/stm32-exti: Prevent illegal read due to unbounded DT value
Date:   Mon, 6 Jun 2022 18:27:54 +0200
Message-ID: <20220606162757.415354-4-antonio.borneo@foss.st.com>
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

The value hwirq is received from DT. If it exceeds the maximum
valid value it causes the code to address unexisting irq chips
reading outside the array boundary.

Check the value of hwirq before using it.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 1145f064faa8..e2722e499ae5 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -713,6 +713,9 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	int bank;
 
 	hwirq = fwspec->param[0];
+	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
+		return -EINVAL;
+
 	bank  = hwirq / IRQS_PER_BANK;
 	chip_data = &host_data->chips_data[bank];
 
-- 
2.36.1

