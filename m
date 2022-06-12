Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D454785F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 05:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiFLD0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiFLDZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 23:25:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B792666FA0;
        Sat, 11 Jun 2022 20:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655004337; x=1686540337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9W8MONWCB3nHa5cG39eCdoNQ68ZRf4zFDKZRUOobOfU=;
  b=UMjCs6hRB908ND3Z+QTH/1IXaVzhMVJTx4GXzvKXH+FGXm9ZiN49lsQL
   CLirZov1wVhmLRZj8WtyQF+kcxR+8bELRSvv8NQthbj029VE5c1jO3RYn
   guNB3DV4+qQf8vODcN5SHXbY2eZTpI1BOas8KALWREt0SpQm8WG1JICBu
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 Jun 2022 20:25:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 20:25:37 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 11 Jun 2022 20:25:36 -0700
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 11 Jun 2022 20:25:34 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>,
        <maz@kernel.org>, "David Collins" <collinsd@codeaurora.org>
Subject: [RESEND PATCH v6 09/10] spmi: pmic-arb: make interrupt support optional
Date:   Sun, 12 Jun 2022 11:24:45 +0800
Message-ID: <1655004286-11493-10-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com>
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
index 39f25bc..0496e5d 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1386,10 +1386,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
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
@@ -1449,17 +1451,22 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
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
@@ -1467,8 +1474,10 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
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
@@ -1479,8 +1488,10 @@ static int spmi_pmic_arb_remove(struct platform_device *pdev)
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

