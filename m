Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428E34B68DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbiBOKJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:09:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiBOKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:09:39 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A1B88B1D;
        Tue, 15 Feb 2022 02:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644919770; x=1676455770;
  h=from:to:cc:subject:date:message-id;
  bh=6AwSMXffc+ZIF68gcqh0h7X3F8Mo1HWIO+7WbtTu0i4=;
  b=RiIlFbl8L32mEk6Ub85kj8tMvE/5zyiUGuXS3Ighwpl2/DutdLK9r6yN
   s3l6IIgxbY4G+RaYUqfTsNUHyCnB96WX3i8GE4hbokz+k1Oee40zg60G5
   0ZrgfKtAIBs9pouixgBo6/5Q9N1zGqmuAI8Ppd3BwK0PVoZMmZQkH3t6N
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 02:09:30 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Feb 2022 02:09:28 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 15 Feb 2022 15:39:16 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 2EC904665; Tue, 15 Feb 2022 15:39:16 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     manivannan.sadhasivam@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 7/7] clk: qcom: Add SDX65 APCS clock controller support
Date:   Tue, 15 Feb 2022 15:39:13 +0530
Message-Id: <1644919753-28855-1-git-send-email-quic_rohiagar@quicinc.com>
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

Add a driver config support for the SDX65 APCS clock controller. It is part
of the APCS hardware block, which among other things implements a combined
mux and half integer divider functionality. The APCS clock controller has 3
parent clocks:

1. Board XO
2. Fixed rate GPLL0
3. A7 PLL

This is required for enabling CPU frequency scaling on SDX65-based
platforms.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/clk/qcom/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 10d75d3..05abf78 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,13 +55,13 @@ config QCOM_CLK_APCC_MSM8996
 	  drivers for dynamic power management.
 
 config QCOM_CLK_APCS_SDX55
-	tristate "SDX55 APCS Clock Controller"
+	tristate "SDX55 and SDX65 APCS Clock Controller"
 	depends on QCOM_APCS_IPC || COMPILE_TEST
 	help
-	  Support for the APCS Clock Controller on SDX55 platform. The
+	  Support for the APCS Clock Controller on SDX55, SDX65 platform. The
 	  APCS is managing the mux and divider which feeds the CPUs.
 	  Say Y if you want to support CPU frequency scaling on devices
-	  such as SDX55.
+	  such as SDX55, SDX65.
 
 config QCOM_CLK_RPM
 	tristate "RPM based Clock Controller"
-- 
2.7.4

