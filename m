Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E159B520F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiEJHxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiEJHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:53:06 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969A1900E1;
        Tue, 10 May 2022 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652168912; x=1683704912;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=66sP44ABH8cW1KMcQ/acjMJ0/jSkvrRxLCtDRKD7gqo=;
  b=gdoY93kop7NLTmOqQ/FLMeiDBFyEd2gduQP8+1U/E3vNwX2atDtLGSqm
   4RrBEhzHd2rXr+trjabvsElWVwxElm4XVPIQWjkni+u8Fxo8OZG92InA2
   xERGaIBZk8hin9qdJpExpWwcmuxzmWccCWxBmbhnQ/xOGEEDJyT6QESGU
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 May 2022 00:48:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 00:48:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 00:48:31 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 00:48:28 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mani@kernel.org>,
        <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <agross@kernel.org>, Prasad Sodagudi <quic_psodagud@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH] mailbox: qcom-ipcc: Log the pending interrupt during resume
Date:   Tue, 10 May 2022 13:18:13 +0530
Message-ID: <1652168893-11814-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prasad Sodagudi <quic_psodagud@quicinc.com>

Enable logging of the pending interrupt that triggered device wakeup. This
logging information helps to debug IRQs that cause periodic device wakeups
and prints the detailed information of pending IPCC interrupts instead of
the generic "Resume caused by IRQ 17, ipcc".

Scenario: Device wakeup caused by Modem crash
Logs:
qcom-ipcc mailbox: virq: 182 triggered smp2p client-id: 2; signal-id: 2

From the IPCC bindings it can further understood that the client here is
IPCC_CLIENT_MPSS and the signal was IPCC_MPROC_SIGNAL_SMP2P.

Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/mailbox/qcom-ipcc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index c5d963222014..5be3a2809d09 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -254,6 +254,35 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
 	return devm_mbox_controller_register(dev, mbox);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int qcom_ipcc_pm_resume(struct device *dev)
+{
+	struct qcom_ipcc *ipcc = dev_get_drvdata(dev);
+	const char *name = "null";
+	struct irq_desc *desc;
+	u32 hwirq;
+	int virq;
+
+	hwirq = readl(ipcc->base + IPCC_REG_RECV_ID);
+	if (hwirq == IPCC_NO_PENDING_IRQ)
+		return 0;
+
+	virq = irq_find_mapping(ipcc->irq_domain, hwirq);
+	desc = irq_to_desc(virq);
+	if (!desc)
+		name = "stray irq";
+	else if (desc->action && desc->action->name)
+		name = desc->action->name;
+
+	dev_info(dev, "virq: %d triggered %s client-id: %ld; signal-id: %ld\n", virq, name,
+		 FIELD_GET(IPCC_CLIENT_ID_MASK, hwirq), FIELD_GET(IPCC_SIGNAL_ID_MASK, hwirq));
+
+	return 0;
+}
+#else
+#define qcom_ipcc_pm_resume NULL
+#endif
+
 static int qcom_ipcc_probe(struct platform_device *pdev)
 {
 	struct qcom_ipcc *ipcc;
@@ -324,6 +353,10 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
 
+static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
+};
+
 static struct platform_driver qcom_ipcc_driver = {
 	.probe = qcom_ipcc_probe,
 	.remove = qcom_ipcc_remove,
@@ -331,6 +364,7 @@ static struct platform_driver qcom_ipcc_driver = {
 		.name = "qcom-ipcc",
 		.of_match_table = qcom_ipcc_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &qcom_ipcc_dev_pm_ops,
 	},
 };
 
-- 
2.7.4

