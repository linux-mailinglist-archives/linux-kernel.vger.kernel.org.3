Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F226557705
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiFWJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiFWJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:40 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928AF49B40;
        Thu, 23 Jun 2022 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WHVNOWKI6E4FR1UMwztSAeuKd9LQg2I0ttlKUhNAPeg=; b=qsHXnbhy3QNW19LAuOZaQS0pxp
        hCrtuLX6IuZ+Ne0SWUYA7xhYqipshJ6U+jSclsywEWnSweaIvbGDCTcvY3M/AGCXA8CkX2/KpMZmw
        wySHztja7GIlfTs53jEWFF0vcGprWGbUIqbmjafa4q7F067xRTzUG6zL0UqfLVloNg4RNTeillQfD
        LAtwNCq8hweGAzNmOPFkzVA7P2TeSXPVMvy9mLmutMv4+6ghAYuXVKc+X3toE8lgODWWMrVlaaqYf
        tP4eIKhphPsmu8OEBp103Suo5QRRPohGxA5N9MhVNfLtXJKEoklQqIO0RQzXtY+TDFBFGME4/AD4u
        25g9p/3w==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o4JQ3-005qg2-3h; Thu, 23 Jun 2022 11:46:35 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 3/3] regulator: qcom_smd: Add PM8909 RPM regulators
Date:   Thu, 23 Jun 2022 11:46:14 +0200
Message-Id: <20220623094614.1410180-4-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
References: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set of regulators available in the PM8909 PMIC is similar to PM8916
which is already supported by the driver. s3, s4 and l16 are missing.
However, probing the SPMI hardware identification registers using the
qcom_spmi-regulator driver reveals that the regulators in PM8909 are
actually some kind of mixture between PM8916 and PM8226:

  - ult_lo_smps (= pm8916_buck_lvo_smps): s1
  - ult_ho_smps (= pm8916_buck_hvo_smps): s2
  - ult_nldo (= pm8916_nldo): l1, l2, l3, l10
  - ult_pldo (= pm8916_pldo): l4, l8, l9, l12-l15, l17, l18
  - pldo (= pm8226_pldo): l5, l6, l7, l11

Use this mapping to add the rpm_regulator_data for PM8909 by reusing
the existing regulator definitions.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/regulator/qcom_smd-regulator.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 8b2d884cd693..59024c639141 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -784,6 +784,29 @@ static const struct rpm_regulator_data rpm_pm8841_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pm8909_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8916_buck_lvo_smps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8916_buck_hvo_smps, "vdd_s2" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm8916_nldo, "vdd_l1" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm8916_nldo, "vdd_l2_l5" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm8916_nldo, "vdd_l3_l6_l10" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm8916_pldo, "vdd_l4_l7" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8226_pldo, "vdd_l2_l5" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8226_pldo, "vdd_l3_l6_l10" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8226_pldo, "vdd_l4_l7" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm8916_pldo, "vdd_l8_l11_l15_l18" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm8916_pldo, "vdd_l9_l12_l14_l17" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm8916_nldo, "vdd_l3_l6_l10" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8226_pldo, "vdd_l8_l11_l15_l18" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8916_pldo, "vdd_l9_l12_l14_l17" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8916_pldo, "vdd_l13" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8916_pldo, "vdd_l9_l12_l14_l17" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8916_pldo, "vdd_l8_l11_l15_l18" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8916_pldo, "vdd_l9_l12_l14_l17" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm8916_pldo, "vdd_l8_l11_l15_l18" },
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pm8916_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8916_buck_lvo_smps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8916_buck_lvo_smps, "vdd_s2" },
@@ -1222,6 +1245,7 @@ static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
 	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
+	{ .compatible = "qcom,rpm-pm8909-regulators", .data = &rpm_pm8909_regulators },
 	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
 	{ .compatible = "qcom,rpm-pm8226-regulators", .data = &rpm_pm8226_regulators },
 	{ .compatible = "qcom,rpm-pm8941-regulators", .data = &rpm_pm8941_regulators },
-- 
2.30.2

