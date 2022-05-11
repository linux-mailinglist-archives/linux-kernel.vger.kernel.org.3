Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9776D522C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiEKGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiEKGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:43:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F08B1D4;
        Tue, 10 May 2022 23:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652251423; x=1683787423;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=PTO+On8Bs9vt5yZvZ1hxSaNlJGopfMF1D5C9kQY7ebs=;
  b=s1Rq46lVeG0L3uCi9uTO0VYBweE9Di51XzSFM2ZbFrGC7gsx3Umtt7yz
   nGixCQbFIj0bmM0R6cINn3Q5fD8bYK5IR/lrcpeT7jM3Mbo0s2EmSYLFc
   +3qy0D5w/4wdyySxkh3s0xcoAyvXW8iUszdHS9fjZgpbqxWSsL3Kd1xsH
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 May 2022 23:43:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 23:43:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 23:43:41 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 23:43:38 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mani@kernel.org>,
        <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <agross@kernel.org>, Prasad Sodagudi <quic_psodagud@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2] mailbox: qcom-ipcc: Log the pending interrupt during resume
Date:   Wed, 11 May 2022 12:13:24 +0530
Message-ID: <1652251404-30562-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
qcom-ipcc mailbox: virq: 182 triggered client-id: 2; signal-id: 2

From the IPCC bindings it can further understood that the client here is
IPCC_CLIENT_MPSS and the signal was IPCC_MPROC_SIGNAL_SMP2P.

Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

V2:
 * Fix build error when ipcc is a module [Kernel Test Bot]

 drivers/mailbox/qcom-ipcc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index c5d963222014..21c071ec119c 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -254,6 +254,28 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
 	return devm_mbox_controller_register(dev, mbox);
 }
 
+#ifdef CONFIG_PM_SLEEP
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
+	dev_info(dev, "virq: %d triggered client-id: %ld; signal-id: %ld\n", virq,
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
@@ -324,6 +346,10 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
 
+static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
+};
+
 static struct platform_driver qcom_ipcc_driver = {
 	.probe = qcom_ipcc_probe,
 	.remove = qcom_ipcc_remove,
@@ -331,6 +357,7 @@ static struct platform_driver qcom_ipcc_driver = {
 		.name = "qcom-ipcc",
 		.of_match_table = qcom_ipcc_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &qcom_ipcc_dev_pm_ops,
 	},
 };
 
-- 
2.7.4

