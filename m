Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509E447BAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhLUHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:20:56 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:41931 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhLUHUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640071249; x=1671607249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=g3rY4bpEO25fMFkUyVjEe7VfSZehXBwtx/lekwobvxU=;
  b=ppL2sO5Cno5YcqfJO7HzgAs8BqTcBHbEm0JUXoeJycOV/66uOHlptC9n
   Kpmj+wtwS1SyxIyJ1Akwvdkkf1nL8hnYuo9LT8ULpqwT8vOcZFpMsy3Kx
   AwHRvYvmc4B3zXm4RHc3NFUPHu7IN2PRByMmATFIx1epFWQsRpSNxv17r
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Dec 2021 23:20:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:20:47 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 23:20:47 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 23:20:45 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH v4 02/11] spmi: pmic-arb: handle spurious interrupt
Date:   Tue, 21 Dec 2021 15:20:00 +0800
Message-ID: <1640071211-31462-3-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call handle_bad_irq() when the summary interrupt is fired spuriously.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 5a99723..719bd73 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -605,10 +605,11 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
 				irq_mask, ppid);
 }
 
-static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
+static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
 {
 	unsigned int irq;
 	u32 status, id;
+	int handled = 0;
 	u8 sid = (pmic_arb->apid_data[apid].ppid >> 8) & 0xF;
 	u8 per = pmic_arb->apid_data[apid].ppid & 0xFF;
 
@@ -623,7 +624,10 @@ static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
 			continue;
 		}
 		generic_handle_irq(irq);
+		handled++;
 	}
+
+	return handled;
 }
 
 static void pmic_arb_chained_irq(struct irq_desc *desc)
@@ -634,7 +638,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	int first = pmic_arb->min_apid >> 5;
 	int last = pmic_arb->max_apid >> 5;
 	u8 ee = pmic_arb->ee;
-	u32 status, enable;
+	u32 status, enable, handled = 0;
 	int i, id, apid;
 
 	chained_irq_enter(chip, desc);
@@ -649,10 +653,14 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 			enable = readl_relaxed(
 					ver_ops->acc_enable(pmic_arb, apid));
 			if (enable & SPMI_PIC_ACC_ENABLE_BIT)
-				periph_interrupt(pmic_arb, apid);
+				if (periph_interrupt(pmic_arb, apid) != 0)
+					handled++;
 		}
 	}
 
+	if (handled == 0)
+		handle_bad_irq(desc);
+
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.7.4

