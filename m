Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931AE4BD540
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbiBUFXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:23:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344419AbiBUFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:23:36 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1BD109C;
        Sun, 20 Feb 2022 21:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645420994; x=1676956994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PX/WHKWbkuwa/EAALLC2/n7hI8uaF1SS9QQ5iBOgSbM=;
  b=FIEVwUIaBQlH/gcA2nNoDS6SX5x0Eu4kpwt4ET+SDughv1THb+rfuAK1
   v853DsjgxNE0vxXNLpePaxh8SaGYJgYrnKhR5bc9mCUdzLa+Xx2yYNQdd
   3axU0/wJrHo2BMER+heqPzzEv62bYjgWZMV11XLSYds1+0ZYgMU52HKl1
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Feb 2022 21:23:13 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Feb 2022 21:23:11 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 10:52:53 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 1A6CE46C2; Mon, 21 Feb 2022 10:52:52 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 2/7] mailbox: qcom: Add support for SDX65 APCS IPC
Date:   Mon, 21 Feb 2022 10:52:28 +0530
Message-Id: <1645420953-21176-3-git-send-email-quic_rohiagar@quicinc.com>
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

In SDX65, the IPC bits are located in the APCS GCC block. Also, this block
can provide clock functionality. Hence, add support for IPC with correct
offset and name of the clock provider.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 9325d2a..54d7659 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -53,6 +53,10 @@ static const struct qcom_apcs_ipc_data sdx55_apcs_data = {
 	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
 };
 
+static const struct qcom_apcs_ipc_data sdx65_apcs_data = {
+	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
+};
+
 static const struct regmap_config apcs_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -159,6 +163,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
+	{ .compatible = "qcom,sdx65-apcs-gcc", .data = &sdx65_apcs_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
-- 
2.7.4

