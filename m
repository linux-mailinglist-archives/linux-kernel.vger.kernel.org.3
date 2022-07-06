Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C13567E29
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiGFGC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFGCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:02:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D322290;
        Tue,  5 Jul 2022 23:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657087373; x=1688623373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0kW1VSyqTJhDf3jEF4wZYjvbzY3W1A1738qYXvtRQDk=;
  b=IwbJKK9apoeUO16Kvibb34WyM4stG+NRvvTzxvr+6fKZRv74svDryGD4
   F5nY0Cvy22hZ/6LG+7gcpyDec0pdzpS5T45lVReZePT5xV6OzojFJAxgf
   VXuMAMJ433ak9gDpHOXDX94GNPRL9+n59lSqUQy8B9u0SJQhP8lSGulYC
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 23:02:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:02:52 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:02:52 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:02:51 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 1/4] soc: qcom: smp2p: Introduce pending state for virtual irq
Date:   Tue, 5 Jul 2022 23:02:08 -0700
Message-ID: <1657087331-32455-2-git-send-email-quic_clew@quicinc.com>
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

If a smp2p change occurs while a virtual interrupt is disabled, smp2p
should be able to resend that interrupt on enablement.

This functionality requires the CONFIG_HARDIRQS_SW_RESEND to be enabled
to reschedule the interrupts. To ensure the mask and unmask functions
are called during enabled and disable, set the flag to disable lazy
IRQ state handling (IRQ_DISABLE_UNLAZY).

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/soc/qcom/smp2p.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 59dbf4b61e6c..1c3259fe98be 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -101,6 +101,7 @@ struct smp2p_entry {
 
 	struct irq_domain *domain;
 	DECLARE_BITMAP(irq_enabled, 32);
+	DECLARE_BITMAP(irq_pending, 32);
 	DECLARE_BITMAP(irq_rising, 32);
 	DECLARE_BITMAP(irq_falling, 32);
 
@@ -146,6 +147,7 @@ struct qcom_smp2p {
 	unsigned local_pid;
 	unsigned remote_pid;
 
+	int irq;
 	struct regmap *ipc_regmap;
 	int ipc_offset;
 	int ipc_bit;
@@ -217,8 +219,8 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
 {
 	struct smp2p_smem_item *in;
 	struct smp2p_entry *entry;
+	unsigned long status;
 	int irq_pin;
-	u32 status;
 	char buf[SMP2P_MAX_ENTRY_NAME];
 	u32 val;
 	int i;
@@ -247,19 +249,22 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
 
 		status = val ^ entry->last_value;
 		entry->last_value = val;
+		status |= *entry->irq_pending;
 
 		/* No changes of this entry? */
 		if (!status)
 			continue;
 
-		for_each_set_bit(i, entry->irq_enabled, 32) {
-			if (!(status & BIT(i)))
-				continue;
-
+		for_each_set_bit(i, &status, 32) {
 			if ((val & BIT(i) && test_bit(i, entry->irq_rising)) ||
 			    (!(val & BIT(i)) && test_bit(i, entry->irq_falling))) {
 				irq_pin = irq_find_mapping(entry->domain, i);
 				handle_nested_irq(irq_pin);
+
+				if (test_bit(i, entry->irq_enabled))
+					clear_bit(i, entry->irq_pending);
+				else
+					set_bit(i, entry->irq_pending);
 			}
 		}
 	}
@@ -365,6 +370,8 @@ static int smp2p_irq_map(struct irq_domain *d,
 	irq_set_chip_data(irq, entry);
 	irq_set_nested_thread(irq, 1);
 	irq_set_noprobe(irq);
+	irq_set_parent(irq, entry->smp2p->irq);
+	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
 
 	return 0;
 }
@@ -609,6 +616,7 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 	/* Kick the outgoing edge after allocating entries */
 	qcom_smp2p_kick(smp2p);
 
+	smp2p->irq = irq;
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					NULL, qcom_smp2p_intr,
 					IRQF_ONESHOT,
-- 
2.7.4

