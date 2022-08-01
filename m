Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1213C5871F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiHAUDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiHAUDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:03:09 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589641A801
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:03:07 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Ibd2oiUWV0DonIbd2oUBZk; Mon, 01 Aug 2022 22:03:05 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 01 Aug 2022 22:03:05 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc3: qcom: Fox some error handling path in dwc3_qcom_probe()
Date:   Mon,  1 Aug 2022 22:03:03 +0200
Message-Id: <baf14163148998215eca3eb7d754cc63e1e376dd.1659384164.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace some direct return with goto to the existing error handling path.
Also release 'parent_res', if needed.


In the remove function, handle the case where 'np' is set or not, to call
the right function as already done in the error handling path of the probe.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The patch looks not complete and dwc3_qcom_create_urs_usb_platdev() (and
its acpi_create_platform_device() call) still need undone in the error
handling path, right?

This looks more tricky to me, so I just point it out and leave it to
anyone who cares.

The remove function is also likely incomplete (for example 'parent_res'
leaks if !np).

Even if not perfect, this patch makes code already "better" :)

Comments and follow-up by others welcomed.


Finally, I've not searched for Fixes tag because it is likely that these
issues have been added in several patches. I have the courage to dig into
this log history.
---
 drivers/usb/dwc3/dwc3-qcom.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index c5e482f53e9d..1fe83fd51947 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -815,9 +815,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		parent_res = res;
 	} else {
 		parent_res = kmemdup(res, sizeof(struct resource), GFP_KERNEL);
-		if (!parent_res)
-			return -ENOMEM;
-
+		if (!parent_res) {
+			ret = -ENOMEM;
+			goto clk_disable;
+		}
 		parent_res->start = res->start +
 			qcom->acpi_pdata->qscratch_base_offset;
 		parent_res->end = parent_res->start +
@@ -828,9 +829,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
 				dev_err(dev, "failed to create URS USB platdev\n");
 				if (!qcom->urs_usb)
-					return -ENODEV;
+					ret = -ENODEV;
 				else
-					return PTR_ERR(qcom->urs_usb);
+					ret = PTR_ERR(qcom->urs_usb);
+				goto free_parent_res;
 			}
 		}
 	}
@@ -838,13 +840,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	qcom->qscratch_base = devm_ioremap_resource(dev, parent_res);
 	if (IS_ERR(qcom->qscratch_base)) {
 		ret = PTR_ERR(qcom->qscratch_base);
-		goto clk_disable;
+		goto free_parent_res;
 	}
 
 	ret = dwc3_qcom_setup_irq(pdev);
 	if (ret) {
 		dev_err(dev, "failed to setup IRQs, err=%d\n", ret);
-		goto clk_disable;
+		goto free_parent_res;
 	}
 
 	/*
@@ -906,6 +908,9 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		of_platform_depopulate(&pdev->dev);
 	else
 		platform_device_put(pdev);
+free_parent_res:
+	if (!np)
+		kfree(parent_res);
 clk_disable:
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
@@ -920,11 +925,15 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 static int dwc3_qcom_remove(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	int i;
 
 	device_remove_software_node(&qcom->dwc3->dev);
-	of_platform_depopulate(dev);
+	if (np)
+		of_platform_depopulate(&pdev->dev);
+	else
+		platform_device_put(pdev);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
-- 
2.34.1

