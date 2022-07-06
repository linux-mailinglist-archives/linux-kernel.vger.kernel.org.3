Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2765C567E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiGFGDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGFGCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:02:55 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD822295;
        Tue,  5 Jul 2022 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657087374; x=1688623374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2bdejReHpno5cbtrQjXdLhWumUnQnqp1aTK4h3lAwec=;
  b=CPxIN/bBi6CtTYd7KITPNolHfqVj9HEapBCfb0voY+B1FAjgWsBy5brP
   8Bx1dzyO2DQ1zFvkrGO+vNihlP2wv9xdb/HdsEJvWyh1FzJM1jAfSTe/r
   mfjhYWptGPn3QPgbzCuydon0boVKnZp2oCcnpf0VenVsRk7wkDU38rJGy
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 23:02:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:02:53 -0700
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
Subject: [PATCH 3/4] soc: qcom: smp2p: Add memory barrier for irq_pending
Date:   Tue, 5 Jul 2022 23:02:10 -0700
Message-ID: <1657087331-32455-4-git-send-email-quic_clew@quicinc.com>
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

There is a very tight race where the irq_retrigger function is run
on one cpu and the actual retrigger softirq is running on a second
cpu. When this happens, there may be a chance that the second cpu
will not see the updated irq_pending value from first cpu.

Add a memory barrier to ensure that irq_pending is read correctly.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/soc/qcom/smp2p.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index a94cddcb0298..a1ea5f55c228 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -249,6 +249,9 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
 
 		status = val ^ entry->last_value;
 		entry->last_value = val;
+
+		/* Ensure irq_pending is read correctly */
+		mb();
 		status |= *entry->irq_pending;
 
 		/* No changes of this entry? */
@@ -356,6 +359,11 @@ static int smp2p_retrigger_irq(struct irq_data *irqd)
 
 	set_bit(irq, entry->irq_pending);
 
+	/* Ensure irq_pending is visible to all cpus that retried interrupt
+	 * can run on
+	 */
+	mb();
+
 	return 0;
 }
 
-- 
2.7.4

