Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E142529FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344457AbiEQKn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiEQKnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:43:18 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F09429CAD;
        Tue, 17 May 2022 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652784195; x=1684320195;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7p0dGKuqEbRbw64q/uX8k4TvVX18WXNffIzyoespWLo=;
  b=ZBv1sodi6Dkxi95/dTxAJWQiZopCesSk76THFzKgy4kEkhIj2NGtvR3P
   2EEruRHt67a42rZTaTkUVBJNNnh4Tuz02lgfR1lQr0hFRdVpWhQoj9T1u
   IKItkcMezx/Bxhl33nSsiTsCc9jbRn/MOMmxnFiZXcj80V+0DK6AAqlMG
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 May 2022 03:43:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 03:43:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 03:43:15 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 03:43:11 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mani@kernel.org>,
        <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <agross@kernel.org>, Prasad Sodagudi <quic_psodagud@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v3] mailbox: qcom-ipcc: Log the pending interrupt during resume
Date:   Tue, 17 May 2022 16:13:00 +0530
Message-ID: <1652784180-10142-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

From: Prasad Sodagudi <quic_psodagud@quicinc.com>

Enable logging of the pending interrupt that triggered device wakeup. This
logging information helps to debug IRQs that cause periodic device wakeups
by printing the detailed information of pending IPCC interrupts.

Scenario: Device wakeup caused by Modem crash
Logs:
qcom-ipcc mailbox: virq: 182 triggered client-id: 2; signal-id: 2

From the IPCC bindings it can further be understood that the client here is
IPCC_CLIENT_MPSS and the signal was IPCC_MPROC_SIGNAL_SMP2P.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

V3:
 * Use pm_sleep_ptr and convert info to dbg [Mani]
 * Fixup commit message

V2:
 * Fix build error when ipcc is a module [Kernel Test Bot]

 drivers/mailbox/qcom-ipcc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index c5d963222014..5a42bc2a1083 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -254,6 +254,24 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
 	return devm_mbox_controller_register(dev, mbox);
 }
 
+static int qcom_ipcc_pm_resume(struct device *dev)
+{
+	struct qcom_ipcc *ipcc = dev_get_drvdata(dev);
+	u32 hwirq;
+	int virq;
+
+	hwirq = readl(ipcc->base + IPCC_REG_RECV_ID);
+	if (hwirq == IPCC_NO_PENDING_IRQ)
+		return 0;
+
+	virq = irq_find_mapping(ipcc->irq_domain, hwirq);
+
+	dev_dbg(dev, "virq: %d triggered client-id: %ld; signal-id: %ld\n", virq,
+		FIELD_GET(IPCC_CLIENT_ID_MASK, hwirq), FIELD_GET(IPCC_SIGNAL_ID_MASK, hwirq));
+
+	return 0;
+}
+
 static int qcom_ipcc_probe(struct platform_device *pdev)
 {
 	struct qcom_ipcc *ipcc;
@@ -324,6 +342,10 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
 
+static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
+};
+
 static struct platform_driver qcom_ipcc_driver = {
 	.probe = qcom_ipcc_probe,
 	.remove = qcom_ipcc_remove,
@@ -331,6 +353,7 @@ static struct platform_driver qcom_ipcc_driver = {
 		.name = "qcom-ipcc",
 		.of_match_table = qcom_ipcc_of_match,
 		.suppress_bind_attrs = true,
+		.pm = pm_sleep_ptr(&qcom_ipcc_dev_pm_ops),
 	},
 };
 
-- 
2.7.4

