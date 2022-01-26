Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5149C3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiAZGdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:33:01 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48556 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235931AbiAZGcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643178771; x=1674714771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dHMURxnIsgonyHWuwt/5fkDXVTWfVe9P2gTB2bgBiiA=;
  b=cs7Xjc9U8ITEcqJxRSj2XPJ3/2K4gDAiAOPWOCh5HypmrRyFasj5sTlx
   R32ljRl4lQuV+b9/TPbNRfD/808ymLOyrRZHJnqbOCxcpiLG4UPmEwt/w
   pQ6WnWb9BxJimDt3LNKIV0ng2F1SLaWn+IazvGyJ54yluNiVXbHqXwWh1
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jan 2022 22:32:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 22:32:47 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 22:32:47 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 22:32:44 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH v5 04/10] spmi: pmic-arb: check apid against limits before calling irq handler
Date:   Wed, 26 Jan 2022 14:31:46 +0800
Message-ID: <1643178713-17178-5-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643178713-17178-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1643178713-17178-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Check that the apid for an SPMI interrupt falls between the
min_apid and max_apid that can be handled by the APPS processor
before invoking the per-apid interrupt handler:
periph_interrupt().

This avoids an access violation in rare cases where the status
bit is set for an interrupt that is not owned by the APPS
processor.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 2bc3b88..e19eaec 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -625,21 +625,26 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	struct spmi_pmic_arb *pmic_arb = irq_desc_get_handler_data(desc);
 	const struct pmic_arb_ver_ops *ver_ops = pmic_arb->ver_ops;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int first = pmic_arb->min_apid >> 5;
-	int last = pmic_arb->max_apid >> 5;
+	int first = pmic_arb->min_apid;
+	int last = pmic_arb->max_apid;
 	u8 ee = pmic_arb->ee;
 	u32 status, enable, handled = 0;
 	int i, id, apid;
 
 	chained_irq_enter(chip, desc);
 
-	for (i = first; i <= last; ++i) {
+	for (i = first >> 5; i <= last >> 5; ++i) {
 		status = readl_relaxed(
 				ver_ops->owner_acc_status(pmic_arb, ee, i));
 		while (status) {
 			id = ffs(status) - 1;
 			status &= ~BIT(id);
 			apid = id + i * 32;
+			if (apid < first || apid > last) {
+				WARN_ONCE(true, "spurious spmi irq received for apid=%d\n",
+					apid);
+				continue;
+			}
 			enable = readl_relaxed(
 					ver_ops->acc_enable(pmic_arb, apid));
 			if (enable & SPMI_PIC_ACC_ENABLE_BIT)
-- 
2.7.4

