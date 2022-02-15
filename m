Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7414B68A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiBOKCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:02:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbiBOKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:02:36 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A010F224;
        Tue, 15 Feb 2022 02:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644919344; x=1676455344;
  h=from:to:cc:subject:date:message-id;
  bh=qPVqXVUN2mGaNrVex8TfRvlY1eCUOH8rfs+vVpRk03Q=;
  b=Tzp0tX7tcwBQ8GnVZMJ/RaJWW0/saLX4+/xXNMIRc83q3V8Rxdqb5S2D
   0I/JOA+0CQvi9AZQs+bkxgQxnmcyleqebxJofywP8szWcRvu5vtNmSbFA
   ksBcCkzViNwYk2+RPx8gZB0Jg6EXz4iJDKwOU7huDH7l4LMGXOc/LMgaB
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 02:02:24 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Feb 2022 02:02:23 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Feb 2022 15:32:21 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id C735D466C; Tue, 15 Feb 2022 15:32:19 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     manivannan.sadhasivam@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 4/7] clk: qcom: Add A7 PLL support for SDX65
Date:   Tue, 15 Feb 2022 15:32:18 +0530
Message-Id: <1644919338-27393-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PLL found in Qualcomm SDX65 platforms which is used to
provide clock to the Cortex A7 CPU via a mux. This PLL can provide high
frequency clock to the CPU above 1GHz as compared to the other sources
like GPLL0.

In this driver, the power domain is attached to the cpudev. This is
required for CPUFreq functionality and there seems to be no better place
to do other than this driver (no dedicated CPUFreq driver).

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/clk/qcom/Kconfig  | 6 +++---
 drivers/clk/qcom/a7-pll.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 6cd0634..10d75d3 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -29,11 +29,11 @@ config QCOM_A53PLL
 	  devices.
 
 config QCOM_A7PLL
-	tristate "SDX55 A7 PLL"
+	tristate "A7 PLL driver for SDX55 and SDX65"
 	help
-	  Support for the A7 PLL on SDX55 devices. It provides the CPU with
+	  Support for the A7 PLL on SDX55 and SDX65 devices. It provides the CPU with
 	  frequencies above 1GHz.
-	  Say Y if you want to support higher CPU frequencies on SDX55
+	  Say Y if you want to support higher CPU frequencies on SDX55 and SDX65
 	  devices.
 
 config QCOM_CLK_APCS_MSM8916
diff --git a/drivers/clk/qcom/a7-pll.c b/drivers/clk/qcom/a7-pll.c
index c4a53e5..adb2121 100644
--- a/drivers/clk/qcom/a7-pll.c
+++ b/drivers/clk/qcom/a7-pll.c
@@ -84,6 +84,7 @@ static int qcom_a7pll_probe(struct platform_device *pdev)
 
 static const struct of_device_id qcom_a7pll_match_table[] = {
 	{ .compatible = "qcom,sdx55-a7pll" },
+	{ .compatible = "qcom,sdx65-a7pll" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_a7pll_match_table);
-- 
2.7.4

