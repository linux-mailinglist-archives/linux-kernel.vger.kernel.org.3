Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0FE4B0A07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiBJJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:51:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiBJJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:51:46 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 01:51:46 PST
Received: from qq.com (smtpbg409.qq.com [113.96.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A451DD;
        Thu, 10 Feb 2022 01:51:46 -0800 (PST)
X-QQ-mid: bizesmtp35t1644486579t7s5pzpj
Received: from localhost.localdomain (unknown [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 10 Feb 2022 17:49:37 +0800 (CST)
X-QQ-SSF: 01400000002000B0L000B00A0000000
X-QQ-FEAT: 1vYwxPNStGkN+kaiA9TtVU7idvHzuLjWRT8ogLx30DRJ+gwRyaLbXx7V2EPtH
        n4qR9GIXYajsebc+ONF04MhxGgVMvpBXESO4EpLChV3ndIPRMsFpTxwwFtttUCtjyNzUAat
        dVWrRXDKV4stfMFW02g8gRERqbuwSdy4mbFzL/7P1YlZVjcLd+47x5y8GiL0INKaCfJs9qm
        oXxo1SRQgURBpl2/zqMXNtE7xOL+m9GFUpLfYamwBxNo4+IZ5n/GGt+BZAOyLbvWjs6R/bA
        YuhIga17DK8zUXIfxgXDuWWKrGReSNCwMpj+TP48TUazq+De/9zCUaC40g/xvag1zwvBF15
        HoFwQSUdyIQzuN1feCaaVvOexbEDzGMBnSCOBg6
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] media: camss-csiphy: Use platform_get_irq_byname() to get the interrupt
Date:   Thu, 10 Feb 2022 17:49:36 +0800
Message-Id: <20220210094936.23462-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_byname().

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/media/platform/qcom/camss/camss-csiphy.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 24eec16197e7..92bdd1cd260f 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -568,7 +568,6 @@ int msm_csiphy_subdev_init(struct camss *camss,
 {
 	struct device *dev = camss->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *r;
 	int i, j;
 	int ret;
 
@@ -610,19 +609,14 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	}
 
 	/* Interrupt */
+	ret = platform_get_irq_byname(pdev, res->interrupt[0]);
+	if (ret < 0)
+		return ret;
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
-					 res->interrupt[0]);
-	if (!r) {
-		dev_err(dev, "missing IRQ\n");
-		return -EINVAL;
-	}
-
-	csiphy->irq = r->start;
 	snprintf(csiphy->irq_name, sizeof(csiphy->irq_name), "%s_%s%d",
 		 dev_name(dev), MSM_CSIPHY_NAME, csiphy->id);
 
-	ret = devm_request_irq(dev, csiphy->irq, csiphy->ops->isr,
+	ret = devm_request_irq(dev, ret, csiphy->ops->isr,
 			       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN,
 			       csiphy->irq_name, csiphy);
 	if (ret < 0) {
-- 
2.20.1



