Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E582246101F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351326AbhK2IaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:30:13 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:5151 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240603AbhK2I2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638174295; x=1669710295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=L+9sXPF4SuCTulw94Ke7UmRKhKGrBjWDzhZHU/4g4+Q=;
  b=xRACFSCe3Jqu3iuI3F6foiT4lUiYDIsj42TkC4QC57OxWrDRa0KRWSEp
   egHdFjINuzc2Rt3fqBzpu/9FgubAFkbq5p1y18wjJ2WuvYGG1qCmI6mb0
   32Rvj6s20WWvNAfSmEI8bAoe/2j0v5Cppfq3I60/Kbju7W/A4J4cHP1Mn
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Nov 2021 00:23:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 00:23:03 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 00:23:02 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 00:23:00 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>
Subject: [PATCH v3 08/10] spmi: pmic-arb: make interrupt support optional
Date:   Mon, 29 Nov 2021 16:22:15 +0800
Message-ID: <1638174137-23290-9-git-send-email-quic_fenglinw@quicinc.com>
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

Make the support of PMIC peripheral interrupts optional for
spmi-pmic-arb devices.  This is useful in situations where
SPMI address mapping is required without the need for IRQ
support.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c | 45 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index e83342a..5e8dec1 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1280,10 +1280,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		goto err_put_ctrl;
 	}
 
-	pmic_arb->irq = platform_get_irq_byname(pdev, "periph_irq");
-	if (pmic_arb->irq < 0) {
-		err = pmic_arb->irq;
-		goto err_put_ctrl;
+	if (of_find_property(pdev->dev.of_node, "interrupt-controller", NULL)) {
+		pmic_arb->irq = platform_get_irq_byname(pdev, "periph_irq");
+		if (pmic_arb->irq < 0) {
+			err = pmic_arb->irq;
+			goto err_put_ctrl;
+		}
 	}
 
 	err = of_property_read_u32(pdev->dev.of_node, "qcom,channel", &channel);
@@ -1343,17 +1345,22 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev_dbg(&pdev->dev, "adding irq domain\n");
-	pmic_arb->domain = irq_domain_add_tree(pdev->dev.of_node,
-					 &pmic_arb_irq_domain_ops, pmic_arb);
-	if (!pmic_arb->domain) {
-		dev_err(&pdev->dev, "unable to create irq_domain\n");
-		err = -ENOMEM;
-		goto err_put_ctrl;
+	if (pmic_arb->irq > 0) {
+		dev_dbg(&pdev->dev, "adding irq domain\n");
+		pmic_arb->domain = irq_domain_add_tree(pdev->dev.of_node,
+					    &pmic_arb_irq_domain_ops, pmic_arb);
+		if (!pmic_arb->domain) {
+			dev_err(&pdev->dev, "unable to create irq_domain\n");
+			err = -ENOMEM;
+			goto err_put_ctrl;
+		}
+
+		irq_set_chained_handler_and_data(pmic_arb->irq,
+						pmic_arb_chained_irq, pmic_arb);
+	} else {
+		dev_dbg(&pdev->dev, "not supporting PMIC interrupts\n");
 	}
 
-	irq_set_chained_handler_and_data(pmic_arb->irq, pmic_arb_chained_irq,
-					pmic_arb);
 	err = spmi_controller_add(ctrl);
 	if (err)
 		goto err_domain_remove;
@@ -1361,8 +1368,10 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	return 0;
 
 err_domain_remove:
-	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
-	irq_domain_remove(pmic_arb->domain);
+	if (pmic_arb->irq > 0) {
+		irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
+		irq_domain_remove(pmic_arb->domain);
+	}
 err_put_ctrl:
 	spmi_controller_put(ctrl);
 	return err;
@@ -1373,8 +1382,10 @@ static int spmi_pmic_arb_remove(struct platform_device *pdev)
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
 	spmi_controller_remove(ctrl);
-	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
-	irq_domain_remove(pmic_arb->domain);
+	if (pmic_arb->irq > 0) {
+		irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
+		irq_domain_remove(pmic_arb->domain);
+	}
 	spmi_controller_put(ctrl);
 	return 0;
 }
-- 
2.7.4

