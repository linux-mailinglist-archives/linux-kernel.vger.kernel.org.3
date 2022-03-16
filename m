Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421544DAA71
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353868AbiCPGJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353781AbiCPGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:08:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4AC60AAC;
        Tue, 15 Mar 2022 23:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647410866; x=1678946866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cZrDloP/7lXSlRe8nV2apCerDfz4MdbPHsS6uRLzOPo=;
  b=eDFdGPR1fJfC+ZVDvA1T3PCiIBMRcBJdf7+S6fntVslqbd/3OlXblbws
   sw2e4wLPr1G1L5HLpuueMPsDjkuJHhWH9/amA22iLuWjHbgOk8kUTDPQP
   uc9uCq4WLbS8ofHvDkE7C+LgwTj2JpO159kIXE5PuoDobl4pMZyze7Uq6
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 23:07:45 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 23:07:43 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 16 Mar 2022 11:37:22 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 12D654794; Wed, 16 Mar 2022 11:37:21 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, rnayak@codeaurora.org, collinsd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/6] regulator: qcom-rpmh: Add support for SDX65
Date:   Wed, 16 Mar 2022 11:37:13 +0530
Message-Id: <1647410837-22537-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support from RPMH regulators found in SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index a3bc0eb..561de6b 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1121,6 +1121,39 @@ static const struct rpmh_vreg_init_data pmx55_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pmx65_vreg_data[] = {
+	RPMH_VREG("smps1",   "smp%s1",    &pmic5_ftsmps510, "vdd-s1"),
+	RPMH_VREG("smps2",   "smp%s2",    &pmic5_hfsmps510, "vdd-s2"),
+	RPMH_VREG("smps3",   "smp%s3",    &pmic5_hfsmps510, "vdd-s3"),
+	RPMH_VREG("smps4",   "smp%s4",    &pmic5_hfsmps510, "vdd-s4"),
+	RPMH_VREG("smps5",   "smp%s5",    &pmic5_hfsmps510, "vdd-s5"),
+	RPMH_VREG("smps6",   "smp%s6",    &pmic5_ftsmps510, "vdd-s6"),
+	RPMH_VREG("smps7",   "smp%s7",    &pmic5_hfsmps510, "vdd-s7"),
+	RPMH_VREG("smps8",   "smp%s8",    &pmic5_hfsmps510, "vdd-s8"),
+	RPMH_VREG("ldo1",    "ldo%s1",    &pmic5_nldo,      "vdd-l1"),
+	RPMH_VREG("ldo2",    "ldo%s2",    &pmic5_nldo,      "vdd-l2-l18"),
+	RPMH_VREG("ldo3",    "ldo%s3",    &pmic5_nldo,      "vdd-l3"),
+	RPMH_VREG("ldo4",    "ldo%s4",    &pmic5_nldo,      "vdd-l4"),
+	RPMH_VREG("ldo5",    "ldo%s5",    &pmic5_pldo,      "vdd-l5-l6-l16"),
+	RPMH_VREG("ldo6",    "ldo%s6",    &pmic5_pldo,      "vdd-l5-l6-l16"),
+	RPMH_VREG("ldo7",    "ldo%s7",    &pmic5_nldo,      "vdd-l7"),
+	RPMH_VREG("ldo8",    "ldo%s8",    &pmic5_nldo,      "vdd-l8-l9"),
+	RPMH_VREG("ldo9",    "ldo%s9",    &pmic5_nldo,      "vdd-l8-l9"),
+	RPMH_VREG("ldo10",   "ldo%s10",   &pmic5_pldo,      "vdd-l10"),
+	RPMH_VREG("ldo11",   "ldo%s11",   &pmic5_pldo,      "vdd-l11-l13"),
+	RPMH_VREG("ldo12",   "ldo%s12",   &pmic5_nldo,      "vdd-l12"),
+	RPMH_VREG("ldo13",   "ldo%s13",   &pmic5_pldo,      "vdd-l11-l13"),
+	RPMH_VREG("ldo14",   "ldo%s14",   &pmic5_nldo,      "vdd-l14"),
+	RPMH_VREG("ldo15",   "ldo%s15",   &pmic5_nldo,      "vdd-l15"),
+	RPMH_VREG("ldo16",   "ldo%s16",   &pmic5_pldo,      "vdd-l5-l6-l16"),
+	RPMH_VREG("ldo17",   "ldo%s17",   &pmic5_nldo,      "vdd-l17"),
+	/* ldo18 not configured */
+	RPMH_VREG("ldo19",   "ldo%s19",   &pmic5_nldo,      "vdd-l19"),
+	RPMH_VREG("ldo20",   "ldo%s20",   &pmic5_nldo,      "vdd-l20"),
+	RPMH_VREG("ldo21",   "ldo%s21",   &pmic5_nldo,      "vdd-l21"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
@@ -1277,6 +1310,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.data = pmx55_vreg_data,
 	},
 	{
+		.compatible = "qcom,pmx65-rpmh-regulators",
+		.data = pmx65_vreg_data,
+	},
+	{
 		.compatible = "qcom,pm7325-rpmh-regulators",
 		.data = pm7325_vreg_data,
 	},
-- 
2.7.4

