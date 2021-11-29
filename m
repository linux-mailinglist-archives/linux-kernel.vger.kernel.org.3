Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D672E46100A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245203AbhK2I2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:28:13 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:5151 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243317AbhK2I0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638174175; x=1669710175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QtKWRKRPIDZsG/mIHa8J1aT+7Ucf+KbAml0KGOxYzrU=;
  b=vJJlHeRb4fGLk2ETYPR6eJa6nW0naQTfr2YAQ2V1Afnm+0M6NffiNNQP
   2WJcB2Sul+Dj9kq9rSkryQJE7BnW7LQhVvhbEMhELm5JYuvXZPybS7+Ok
   7P1EtbRM4UAHuszbgC8HGnx0XgiK2n8ATO65vaOoRZvzM+L7fcYpPFcvs
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Nov 2021 00:22:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 00:22:54 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 00:22:54 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 00:22:51 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David Collins" <collinsd@codeaurora.org>,
        Kiran Gunda <kgunda@codeaurora.org>
CC:     <subbaram@codeaurora.org>, <quic_fenglinw@quicinc.com>
Subject: [PATCH v3 05/10] spmi: pmic-arb: correct duplicate APID to PPID mapping logic
Date:   Mon, 29 Nov 2021 16:22:12 +0800
Message-ID: <1638174137-23290-6-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638174137-23290-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1638174137-23290-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Correct the way that duplicate PPID mappings are handled for PMIC
arbiter v5.  The final APID mapped to a given PPID should be the
one which has write owner = APPS EE, if it exists, or if not
that, then the first APID mapped to the PPID, if it exists.

Fixes: 40f318f0ed67 ("spmi: pmic-arb: add support for HW version 5")
Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 127a427..011044e 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -925,7 +925,8 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 	 * version 5, there is more than one APID mapped to each PPID.
 	 * The owner field for each of these mappings specifies the EE which is
 	 * allowed to write to the APID.  The owner of the last (highest) APID
-	 * for a given PPID will receive interrupts from the PPID.
+	 * which has the IRQ owner bit set for a given PPID will receive
+	 * interrupts from the PPID.
 	 */
 	for (i = 0; ; i++, apidd++) {
 		offset = pmic_arb->ver_ops->apid_map_offset(i);
@@ -948,16 +949,16 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 		apid = pmic_arb->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
 		prev_apidd = &pmic_arb->apid_data[apid];
 
-		if (valid && is_irq_ee &&
-				prev_apidd->write_ee == pmic_arb->ee) {
+		if (!valid || apidd->write_ee == pmic_arb->ee) {
+			/* First PPID mapping or one for this EE */
+			pmic_arb->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
+		} else if (valid && is_irq_ee &&
+			   prev_apidd->write_ee == pmic_arb->ee) {
 			/*
 			 * Duplicate PPID mapping after the one for this EE;
 			 * override the irq owner
 			 */
 			prev_apidd->irq_ee = apidd->irq_ee;
-		} else if (!valid || is_irq_ee) {
-			/* First PPID mapping or duplicate for another EE */
-			pmic_arb->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
 		}
 
 		apidd->ppid = ppid;
-- 
2.7.4

