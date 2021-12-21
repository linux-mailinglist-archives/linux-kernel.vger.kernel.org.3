Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0709347BAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhLUHVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:21:04 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:34095 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbhLUHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640071255; x=1671607255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OhR72xqFkzDx/cOjDRLsolT9JZibeLMb3xt2MB4DjB8=;
  b=tNuOi2nhRX2IFNOPg2LJtYrvUQrtmHEN844fA5c8N1NC6Z3okq438q/8
   WDt3Stg7mosR2Ox/UC9wkVvfbLfWW9JoA+24hnrGSe6zbzhIHSnR5LkXU
   p+7ee/kUrFcb3e2l7t8FbCSSHcyDVdHxOl/nXFkItzCIg/RB3jQfxp6S7
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Dec 2021 23:20:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:20:53 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 23:20:53 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 23:20:49 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kiran Gunda" <kgunda@codeaurora.org>,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH v4 03/11] spmi: pmic-arb: do not ack and clear peripheral interrupts in cleanup_irq
Date:   Tue, 21 Dec 2021 15:20:01 +0800
Message-ID: <1640071211-31462-4-git-send-email-quic_fenglinw@quicinc.com>
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

From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>

Currently, cleanup_irq() is invoked when a peripheral's interrupt
fires and there is no mapping present in the interrupt domain of
spmi interrupt controller.

The cleanup_irq clears the arbiter bit, clears the pmic interrupt
and disables it at the pmic in that order. The last disable in
cleanup_irq races with request_irq() in that it stomps over the
enable issued by request_irq. Fix this by not writing to the pmic
in cleanup_irq. The latched bit will be left set in the pmic,
which will not send us more interrupts even if the enable bit
stays enabled.

When a client wants to request an interrupt, use the activate
callback on the irq_domain to clear latched bit. This ensures
that the latched, if set due to the above changes in cleanup_irq
or when the bootloader leaves it set, gets cleaned up, paving way
for upcoming interrupts to trigger.

With this, there is a possibility of unwanted triggering of
interrupt right after the latched bit is cleared - the interrupt
may be left enabled too. To avoid that, clear the enable first
followed by clearing the latched bit in the activate callback.

Fixes: 6bc546e71e50 ("spmi: pmic-arb: cleanup unrequested irqs")
Fixes: 02abec3616c1 ("spmi: pmic-arb: rename pa_xx to pmic_arb_xx and other cleanup")
Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
[collinsd@codeaurora.org: fix merge conflict]
Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 719bd73..2bc3b88 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -593,16 +593,6 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
 	dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
 			__func__, apid, sid, per, id);
 	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
-
-	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
-			(per << 8) + QPNPINT_REG_LATCHED_CLR, &irq_mask, 1))
-		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed to ack irq_mask = 0x%x for ppid = %x\n",
-				irq_mask, ppid);
-
-	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
-			       (per << 8) + QPNPINT_REG_EN_CLR, &irq_mask, 1))
-		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed to ack irq_mask = 0x%x for ppid = %x\n",
-				irq_mask, ppid);
 }
 
 static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
@@ -780,6 +770,7 @@ static int qpnpint_irq_domain_activate(struct irq_domain *domain,
 	u16 apid = hwirq_to_apid(d->hwirq);
 	u16 sid = hwirq_to_sid(d->hwirq);
 	u16 irq = hwirq_to_irq(d->hwirq);
+	u8 buf;
 
 	if (pmic_arb->apid_data[apid].irq_ee != pmic_arb->ee) {
 		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u: ee=%u but owner=%u\n",
@@ -788,6 +779,10 @@ static int qpnpint_irq_domain_activate(struct irq_domain *domain,
 		return -ENODEV;
 	}
 
+	buf = BIT(irq);
+	qpnpint_spmi_write(d, QPNPINT_REG_EN_CLR, &buf, 1);
+	qpnpint_spmi_write(d, QPNPINT_REG_LATCHED_CLR, &buf, 1);
+
 	return 0;
 }
 
-- 
2.7.4

