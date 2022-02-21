Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059254BD560
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbiBUFXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:23:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344414AbiBUFXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:23:35 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17ECEB7;
        Sun, 20 Feb 2022 21:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645420993; x=1676956993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TGPshyGLQVn+XUcTmwqZz7StC7gbCPyK/DutjTq1Skw=;
  b=YK8li8a3qR7IllQzEaIteBgO+0g2lHUFZhJxo5V8I2obXO4wknlsAg0e
   0naLa2293gdTJrc0d7fYiWzAQjSTbGSx2EGwlJt0KqPTQqRwKwdjABkwT
   JFCybB5d9NuJiqZjYfF37urFKFuVwlXYJZgmvwgMLGfx4jX/5qyJvc7p/
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Feb 2022 21:23:11 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Feb 2022 21:23:08 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 10:52:54 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id D94DD46C2; Mon, 21 Feb 2022 10:52:53 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 4/7] clk: qcom: Add A7 PLL support for SDX65
Date:   Mon, 21 Feb 2022 10:52:30 +0530
Message-Id: <1645420953-21176-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
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
index 42c8741..5159a1d 100644
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

