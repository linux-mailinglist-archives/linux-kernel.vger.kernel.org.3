Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11E458197E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiGZSMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbiGZSLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:11:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF6030545;
        Tue, 26 Jul 2022 11:11:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id tk8so27589051ejc.7;
        Tue, 26 Jul 2022 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWnxtMOghd/qKBYmTayRWQt4z1nvFge8RqZZD7iF4sE=;
        b=FooEP1/WQmN06dEzvIZYYYZZoFWCV9jwDAOB3OwrFxjk1LUCDU62amjtEysc5DWGhn
         R/JKl0Dpb4UgzTliqipaqkIlKGvd9gmMf0rN+J6l2enDNPpQlmW9TwSq+ftQKputCIdt
         7DVMvj1Pqy1imDDyWZS2ydk+SS67sxqZs6ZHxekI86lpVY/GhKdoLYaKgRITwp+Wwl9M
         maYl8RQpz8U9MbOr5xoIjLJkRV8hiwOMTovdcdFK+eolLdpsDPmX3cKLjcSx2yfa15p3
         61dYOkD0JlrbP2d0wuCNt5eCxiVBV6uNWvp7u724I8hFDdibVqgod81kevF1FMx9Pwzj
         7B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWnxtMOghd/qKBYmTayRWQt4z1nvFge8RqZZD7iF4sE=;
        b=W6graH8pGvL4n7J34XIEus39glaB63TtwOhZIwL1EVUVZd8gVpMDUh8mh8e25P/4gJ
         Nj95yATDyc4K0JZCCzZl8mzWAq2TrbJuj9fOJEElFmHT6sNzFlmQ75DEdNwRsl5rtGr2
         UqLyQiy+jHZNYKdSZ6wKg7UWeYjTr0arIEeZgC0KHUKVls6lj3ksr4MnhAEDBEYbgTso
         8nhA8nBLaaIdmCFlKwShI0e/txgnCkTXfqvqeRp1pEdwQA8CRnJDTQP1+/iG6New0+e2
         q3vrc+UzPD8IMKBEAkd5YidlRyvNaKzidT3nGifs0CJroFH5BeDjJJY+dQ4en0Dnr37s
         X0cg==
X-Gm-Message-State: AJIora+qzxLeW1jeIznJbDC1lMVyTF8oXMpNuhBFP3PtIK8jVhim1mSB
        m0AsWM1TScBYMFYzmSvCBsc=
X-Google-Smtp-Source: AGRyM1vgmX3GNjF76rfe7sfaHDHYPUX86OgDtVTSAZPU8sPBXesikR+iDYIh5KmCvpfNbVToLk6geg==
X-Received: by 2002:a17:906:ff48:b0:72f:10c:bb3f with SMTP id zo8-20020a170906ff4800b0072f010cbb3fmr15194526ejb.718.1658859106921;
        Tue, 26 Jul 2022 11:11:46 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id i8-20020a056402054800b0043bb71edd36sm8903587edx.44.2022.07.26.11.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:11:46 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 5/5] regulator: qcom_smd: Add PM6125 regulators support
Date:   Tue, 26 Jul 2022 21:11:33 +0300
Message-Id: <20220726181133.3262695-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726181133.3262695-1-iskren.chernev@gmail.com>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
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

Add support for PM6125 PMIC which is found on SM4250/6115 SoCs.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/regulator/qcom_smd-regulator.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 59024c639141..2ce2941a032f 100644
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
@@ -1190,6 +1199,42 @@ static const struct rpm_regulator_data rpm_pm660l_regulators[] = {
 	{ }
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
 static const struct rpm_regulator_data rpm_pms405_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pms405_hfsmps3, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pms405_hfsmps3, "vdd_s2" },
@@ -1255,6 +1300,7 @@ static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8998-regulators", .data = &rpm_pm8998_regulators },
 	{ .compatible = "qcom,rpm-pm660-regulators", .data = &rpm_pm660_regulators },
 	{ .compatible = "qcom,rpm-pm660l-regulators", .data = &rpm_pm660l_regulators },
+	{ .compatible = "qcom,rpm-pm6125-regulators", .data = &rpm_pm6125_regulators },
 	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
 	{ .compatible = "qcom,rpm-pmi8994-regulators", .data = &rpm_pmi8994_regulators },
 	{ .compatible = "qcom,rpm-pmi8998-regulators", .data = &rpm_pmi8998_regulators },
-- 
2.37.1

