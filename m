Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F3567E2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiGFGDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGFGC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:02:57 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90122294;
        Tue,  5 Jul 2022 23:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657087373; x=1688623373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=X1Xeb7Fgnw4Fu+51DpHFBm7BDpOqou5CXewNC9Ul0sQ=;
  b=ibboQN6TkmJqw3li3yS7KzmHdgBOqIh7lAj7B9nbfbwC1NMJrJr35PFw
   VphiSRjU4agSmu0yZdHIh5waK+Wa2UPZtQOrT4s3LoLd0JghRbL2GlPxZ
   pKEhHHNYiOPexQhExXSaOCwQxmZl4x8z/FDw1YYfMzT35hTvWlOUQGtaZ
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 05 Jul 2022 23:02:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:02:52 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:02:52 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:02:52 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 2/4] soc: qcom: smp2p: Add proper retrigger detection
Date:   Tue, 5 Jul 2022 23:02:09 -0700
Message-ID: <1657087331-32455-3-git-send-email-quic_clew@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657087331-32455-1-git-send-email-quic_clew@quicinc.com>
References: <1657087331-32455-1-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, smp2p relies on the hwirq resend feature to retrigger irqs
that were missed because the irq was disabled at the time of receiving
it. The hwirq resend feature will retrigger the parent smp2p interrupt.
In order to keep track of what children needed to be retriggered, the
pending bitmap was added.

After calling handle_nested_irq, smp2p checks if the interrupt is
enabled and sets the pending bit if the interrupt is not enabled. There
is a small window where a client can enable the interrupt between
calling handle_nested_irq and checking if the interrupt is enabled.
If this happens, the interrupt is never called when the parent smp2p
interrupt is retriggered.

Add the irq_retrigger callback so smp2p can know which child interrupts
need to be retriggered. Set the pending bits accordingly.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/soc/qcom/smp2p.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 1c3259fe98be..a94cddcb0298 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -260,11 +260,7 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
 			    (!(val & BIT(i)) && test_bit(i, entry->irq_falling))) {
 				irq_pin = irq_find_mapping(entry->domain, i);
 				handle_nested_irq(irq_pin);
-
-				if (test_bit(i, entry->irq_enabled))
-					clear_bit(i, entry->irq_pending);
-				else
-					set_bit(i, entry->irq_pending);
+				clear_bit(i, entry->irq_pending);
 			}
 		}
 	}
@@ -353,11 +349,22 @@ static int smp2p_set_irq_type(struct irq_data *irqd, unsigned int type)
 	return 0;
 }
 
+static int smp2p_retrigger_irq(struct irq_data *irqd)
+{
+	struct smp2p_entry *entry = irq_data_get_irq_chip_data(irqd);
+	irq_hw_number_t irq = irqd_to_hwirq(irqd);
+
+	set_bit(irq, entry->irq_pending);
+
+	return 0;
+}
+
 static struct irq_chip smp2p_irq_chip = {
 	.name           = "smp2p",
 	.irq_mask       = smp2p_mask_irq,
 	.irq_unmask     = smp2p_unmask_irq,
 	.irq_set_type	= smp2p_set_irq_type,
+	.irq_retrigger	= smp2p_retrigger_irq,
 };
 
 static int smp2p_irq_map(struct irq_domain *d,
-- 
2.7.4

