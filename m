Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D959F588401
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiHBWM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiHBWMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:12:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A2748EBC;
        Tue,  2 Aug 2022 15:11:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j8so3057045ejx.9;
        Tue, 02 Aug 2022 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=la17xaelk160+s/mBP0bNJQeEZJpu3BrM7ezc7XQ5ik=;
        b=dQsrlv+/gKwMIMsxFhyPaYVBKsG/52t+LoI69rMOZrlrWCuyUCpVVfN7zW3k2yoxdH
         7je5Kj0XCQpPf8ECRGGxrCKQm2V4S+a0aRqV0kGpVZxtMIxVmt6L9ewG0f3udHlCspHz
         8L7lwUz8yhBJ/JsbZfu3Mf/D2LaOKvXFy0s7JFFibSKb1wu7Ubev+KUN7tIyix6aEWC2
         KZJOPkVV36ot0XYSuha89P9wwGp3pkiUw67oRbYq4N8vOLm8NVg4l762XQRpO8d7NIyr
         HtOY6FZkGWoySh/xqscjDeaFvVzXrQ2Se0O734Vz8Yg7X/w8zleUGlI7szb5MTtxv3yE
         /pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=la17xaelk160+s/mBP0bNJQeEZJpu3BrM7ezc7XQ5ik=;
        b=0jFYKF0/KLlhARxn9Pv5NdH3z7CowHhZ3IPG6Y/vtvEoiMikk6b1Nn6BW1e27aJpoJ
         YoRHBa3cjcrcEuZhA9Dlgw7E/0p2CVl7W4Ku3inpYB8BZ1sIiOdA0NWuVLOqLsQL1gRZ
         bPOsVpjOyVVxGy6sWv/g6qtGrOJVLX/9qBn6qZu0cafD1yViR1vscy89unUQCKSptSf4
         6EbtRSOBlHXW237u64yhWREtyTxVkmcn6ikk6ShreSsmbsVHMyUwfdI8IiiiPaSy0Lh1
         6p8pRmpckC6BUAoI31686UMzb/baUNbQbsfDthpPuoFkwVqPiXpzf1j09i6m/5er4uM5
         Cv5Q==
X-Gm-Message-State: AJIora9GPsm9nv4IALTiVZR7NGT7d6BHEGvdUme/BG3p6BPnl4mEquhZ
        qVeL60QMh6Pk2IapTv7QXo8=
X-Google-Smtp-Source: AGRyM1vJocl02MFP8gTQnfV8syC2vmZFSMfOMYaIb7VXBu7+Yoc0+xUU3CYW5qhdw1AkcZCyGhMJ0Q==
X-Received: by 2002:a17:906:6a14:b0:72b:64bd:ea2b with SMTP id qw20-20020a1709066a1400b0072b64bdea2bmr16964190ejc.680.1659478319232;
        Tue, 02 Aug 2022 15:11:59 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id be10-20020a0564021a2a00b0043ceb444515sm8797121edb.5.2022.08.02.15.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:58 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 13/13] regulator: qcom_smd: Add PM6125 RPM regulators
Date:   Wed,  3 Aug 2022 01:11:12 +0300
Message-Id: <20220802221112.2280686-14-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802221112.2280686-1-iskren.chernev@gmail.com>
References: <20220802221112.2280686-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ranges and types are taken from the relevant SPMI driver:

- ftsmps_510: s1-s4, s8
- buck_510: s5-s7
- ldo_nX_510: l1-l4, l6-l8, l17-18
- ldo_mv_pX_510: l5, l15, l19-l24
- ldo_lv_pX_510: l9-l14, l16

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/regulator/qcom_smd-regulator.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 92c9631a2415..f98168d58dce 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -668,6 +668,15 @@ static const struct regulator_desc pm660l_bob = {
 	.ops = &rpm_bob_ops,
 };
 
+static const struct regulator_desc pm6125_ftsmps = {
+	.linear_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(300000, 0, 268, 4000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 269,
+	.ops = &rpm_smps_ldo_ops,
+};
+
 static const struct regulator_desc pms405_hfsmps3 = {
 	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
@@ -802,6 +811,42 @@ static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pm6125_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm6125_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm6125_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm6125_ftsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm6125_ftsmps, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm8998_hfsmps, "vdd_s5" },
+	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pm8998_hfsmps, "vdd_s6" },
+	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pm8998_hfsmps, "vdd_s7" },
+	{ "s8", QCOM_SMD_RPM_SMPA, 8, &pm6125_ftsmps, "vdd_s8" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm660_nldo660, "vdd_l1_l7_l17_l18" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm660_nldo660, "vdd_l2_l3_l4" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm660_nldo660, "vdd_l2_l3_l4" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm660_nldo660, "vdd_l2_l3_l4" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm660_nldo660, "vdd_l6_l8" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm660_nldo660, "vdd_l1_l7_l17_l18" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm660_nldo660, "vdd_l6_l8" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm660_ht_lvpldo, "vdd_l9_l11" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm660_ht_lvpldo, "vdd_l10_l13_l14" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm660_ht_lvpldo, "vdd_l9_l11" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm660_ht_lvpldo, "vdd_l12_l16" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm660_ht_lvpldo, "vdd_l10_l13_l14" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm660_ht_lvpldo, "vdd_l10_l13_l14" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm660_ht_lvpldo, "vdd_l12_l16" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm660_nldo660, "vdd_l1_l7_l17_l18" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm660_nldo660, "vdd_l1_l7_l17_l18" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pm660_pldo660, "vdd_l23_l24" },
+	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pm660_pldo660, "vdd_l23_l24" },
+	{ }
+};
+
 static const struct rpm_regulator_data rpm_pm660_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm660_ftsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm660_ftsmps, "vdd_s2" },
@@ -1245,6 +1290,7 @@ static const struct rpm_regulator_data rpm_pms405_regulators[] = {
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
 	{ .compatible = "qcom,rpm-pm2250-regulators", .data = &rpm_pm2250_regulators },
+	{ .compatible = "qcom,rpm-pm6125-regulators", .data = &rpm_pm6125_regulators },
 	{ .compatible = "qcom,rpm-pm660-regulators", .data = &rpm_pm660_regulators },
 	{ .compatible = "qcom,rpm-pm660l-regulators", .data = &rpm_pm660l_regulators },
 	{ .compatible = "qcom,rpm-pm8226-regulators", .data = &rpm_pm8226_regulators },
-- 
2.37.1

