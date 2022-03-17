Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84234DBF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiCQGWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCQGWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:22:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B7126F80;
        Wed, 16 Mar 2022 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647497569; x=1679033569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OhR72xqFkzDx/cOjDRLsolT9JZibeLMb3xt2MB4DjB8=;
  b=ntq4Tk/6g3xEtCt3TPN91zsWRBCAOOPb8Y8VP0b9j5SU+SzysNoLyIT6
   mAseXIWtTTCxtAaPBQSHmeMNCZAH/3pLAbb3Xr70QTvCZLjIl1TNaSO1n
   eFisc5x3XucReoWAp6p+ziqts3PyyhLA01GuOJ0IMKQ3hZ2YfJLs429W2
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 16 Mar 2022 23:12:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 23:12:48 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 23:12:48 -0700
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 23:12:45 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
        Kiran Gunda <kgunda@codeaurora.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH v6 03/10] spmi: pmic-arb: do not ack and clear peripheral interrupts in cleanup_irq
Date:   Thu, 17 Mar 2022 14:12:08 +0800
Message-ID: <1647497535-32151-4-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647497535-32151-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1647497535-32151-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

