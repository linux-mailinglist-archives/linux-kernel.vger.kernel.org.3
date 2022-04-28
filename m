Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A91351289B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiD1BQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiD1BQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:16:28 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6207DA98;
        Wed, 27 Apr 2022 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651108395; x=1682644395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vFm/1iPltzV2y4DMijEhe5IyJTZ/LWY1V45aTZ9IiEs=;
  b=zRc+OEsTpuSWf2Kntrz8eHvXwVqXcTdRl+wUAdv718zTpHk7typTkTnf
   Lh8C/sApSqHlOkWtsFuQaLRHcas88otViUE/I0PlxfhbRU4aO5tHKLWJG
   A3DQJHpWSOjiN1qVWhrqR00lpHJ0YrsjQadsxYY8LQIBtdiwAL4krPF2U
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2022 18:13:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 18:13:15 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 18:13:14 -0700
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 18:13:12 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>,
        <maz@kernel.org>, "Ashay Jaiswal" <ashayj@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>
Subject: [RESEND PATCH V6 05/10] spmi: pmic-arb: add support to dispatch interrupt based on IRQ status
Date:   Thu, 28 Apr 2022 09:12:44 +0800
Message-ID: <1651108369-11059-6-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651108369-11059-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1651108369-11059-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashay Jaiswal <ashayj@codeaurora.org>

Current implementation of SPMI arbiter dispatches interrupt based on the
Arbiter's accumulator status, in some cases the accumulator status may
remain zero and the interrupt remains un-handled. Add logic to dispatch
interrupts based Arbiter's IRQ status if the accumulator status is zero.

Signed-off-by: Ashay Jaiswal <ashayj@codeaurora.org>
Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index e19eaec..56f2294 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -630,12 +630,18 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	u8 ee = pmic_arb->ee;
 	u32 status, enable, handled = 0;
 	int i, id, apid;
+	/* status based dispatch */
+	bool acc_valid = false;
+	u32 irq_status = 0;
 
 	chained_irq_enter(chip, desc);
 
 	for (i = first >> 5; i <= last >> 5; ++i) {
 		status = readl_relaxed(
 				ver_ops->owner_acc_status(pmic_arb, ee, i));
+		if (status)
+			acc_valid = true;
+
 		while (status) {
 			id = ffs(status) - 1;
 			status &= ~BIT(id);
@@ -653,6 +659,29 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 		}
 	}
 
+	/* ACC_STATUS is empty but IRQ fired check IRQ_STATUS */
+	if (!acc_valid) {
+		for (i = first; i <= last; i++) {
+			/* skip if APPS is not irq owner */
+			if (pmic_arb->apid_data[i].irq_ee != pmic_arb->ee)
+				continue;
+
+			irq_status = readl_relaxed(
+					     ver_ops->irq_status(pmic_arb, i));
+			if (irq_status) {
+				enable = readl_relaxed(
+					     ver_ops->acc_enable(pmic_arb, i));
+				if (enable & SPMI_PIC_ACC_ENABLE_BIT) {
+					dev_dbg(&pmic_arb->spmic->dev,
+						"Dispatching IRQ for apid=%d status=%x\n",
+						i, irq_status);
+					if (periph_interrupt(pmic_arb, i) != 0)
+						handled++;
+				}
+			}
+		}
+	}
+
 	if (handled == 0)
 		handle_bad_irq(desc);
 
-- 
2.7.4

