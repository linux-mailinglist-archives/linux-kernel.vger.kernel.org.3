Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35C3567E2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiGFGDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGFGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:02:56 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887C222298;
        Tue,  5 Jul 2022 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657087375; x=1688623375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=x69ZXl0q6YPIjoY3r38mvBjwXx/dRoW5Meq0IZxS9z0=;
  b=N7FF+YvAh83YLCpHxasi6CWXJ0yMnIF9QDOOdjtXzcUrx1zO6NiH+xgw
   mqR6mzdLiZGbtq1wYP6wKCmKT4/T3SjVpoJ3kFGD6ctMiNyhVpw5/ZuPc
   gTvJ24yV87gnwahZBbNWJXjEbfHeMEalLXDFRbyABRpl6HOZJf+v50usU
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 23:02:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:02:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:02:53 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:02:52 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>, Tao Zhang <quic_taozhan@quicinc.com>
Subject: [PATCH 4/4] soc: qcom: smp2p: Add remote_id into irq name
Date:   Tue, 5 Jul 2022 23:02:11 -0700
Message-ID: <1657087331-32455-5-git-send-email-quic_clew@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657087331-32455-1-git-send-email-quic_clew@quicinc.com>
References: <1657087331-32455-1-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Zhang <quic_taozhan@quicinc.com>

Changed smp2p irq devname from "smp2p" to "smp2p_<remote_id>", which
makes the wakeup source distinguishable in irq wakeup prints.

Signed-off-by: Tao Zhang <quic_taozhan@quicinc.com>
Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/soc/qcom/smp2p.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index a1ea5f55c228..21a0e84b16f4 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -541,6 +541,7 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 	struct device_node *node;
 	struct qcom_smp2p *smp2p;
 	const char *key;
+	char *name;
 	int irq;
 	int ret;
 
@@ -632,10 +633,16 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 	qcom_smp2p_kick(smp2p);
 
 	smp2p->irq = irq;
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "smp2p_%d",
+			      smp2p->remote_pid);
+	if (!name) {
+		ret = -ENOMEM;
+		goto unwind_interfaces;
+	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					NULL, qcom_smp2p_intr,
 					IRQF_ONESHOT,
-					"smp2p", (void *)smp2p);
+					name, (void *)smp2p);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request interrupt\n");
 		goto unwind_interfaces;
-- 
2.7.4

