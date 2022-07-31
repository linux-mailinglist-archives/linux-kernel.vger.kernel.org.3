Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251755861CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiGaWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbiGaWiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:38:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C824512754;
        Sun, 31 Jul 2022 15:38:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k26so1584643ejx.5;
        Sun, 31 Jul 2022 15:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Oa5+tWAoHl3dRc+/QGRg84GXSnTkehTPxkkMilq0S4g=;
        b=jA+0zNq+QtWLhYRQRwsDzw76/XKc8UgpDL/bIc/1hfF+a16/l1v5sc/2bdXK11xTPy
         b/4xPzb3VzwT7h5TtUQCcKn2bJy9hMOkUyub6A3ryTxv2Ph5l7MpcznHQT2XFaeL4DGB
         ItEar2sEgB7NPUnZwvsO7Jy8WPF95Wk9ouXfkII/eXloCXd/OR3QVjrPhkeEF+SKIHRX
         Rxmpf1xrjOOb9qejykHaHgsp+dG/iC/WbQKLXA1pX16AMiWiVDtb9oVwObNN7kG50hdj
         83DtFxy8bcrQIEXuovNbXZcUqHAGfzB/6JtXlyXyOQre4b4SngGb2iUccSkcL5XdEciN
         UrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Oa5+tWAoHl3dRc+/QGRg84GXSnTkehTPxkkMilq0S4g=;
        b=51+UPP6Om6hkNUCMA3I1YoSUmJrmscserqx1EkT8IRJCub69nP1BCtHnYp/hbqsQCK
         5KjAbvOjBm4q9eI8spFmuqkGr6X/weBhQ0TS8ZCHdvVTsNqXtM+FppQ2AxQ8X+V2FQeQ
         Dz2/REiXLghxVLMgZzUo1U/ENga4cx75cbUHLlJAcznIsIQ9lKrRa8o143RBzY8pgcGv
         3OflxYBtK85ywvb3iJPkk5BFX0CnzpgUzWJxhBa41bb41sINMBFmBmaUqd2/uhMoq6tP
         PrSvN6F7m1/8Ccqh0eUxgnRvapWa5SZ8Th6EHYdNPB3VVYZX1iUZ/KSdjNV0pUVJcZnJ
         4KQQ==
X-Gm-Message-State: AJIora8u6ChEkVzu8NKZyvHRIlsJHs75FE8SdVZgAGG+N/ugQZBllGwR
        +XKSvXCxLFX0pp/VJgjF1FE=
X-Google-Smtp-Source: AGRyM1ufK/Njx13svf2PMQenfnbzrvbKcwUdvX3AOVD/qrKg8PQ4sdHg3IW/LWC1Q2+0GnRBGh7iIw==
X-Received: by 2002:a17:907:2ce9:b0:72b:30e5:f1bc with SMTP id hz9-20020a1709072ce900b0072b30e5f1bcmr10290635ejc.127.1659307083830;
        Sun, 31 Jul 2022 15:38:03 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id r1-20020aa7cfc1000000b0043be16f5f4csm5926867edy.52.2022.07.31.15.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:38:03 -0700 (PDT)
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
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 08/13] regulator: qcom_spmi: Sort pmics alphabetically (part 2)
Date:   Mon,  1 Aug 2022 01:37:31 +0300
Message-Id: <20220731223736.1036286-9-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220731223736.1036286-1-iskren.chernev@gmail.com>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
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

The sorting is split in multiple commits for easier reviewing.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 129 ++++++++++++------------
 1 file changed, 64 insertions(+), 65 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index bbb464717afa..d4dba02ad6a6 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2026,6 +2026,68 @@ static int spmi_regulator_of_parse(struct device_node *node,
 	return 0;
 }
 
+static const struct spmi_regulator_data pm660_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1", },
+	{ "s2", 0x1700, "vdd_s2", },
+	{ "s3", 0x1a00, "vdd_s3", },
+	{ "s4", 0x1d00, "vdd_s3", },
+	{ "s5", 0x2000, "vdd_s5", },
+	{ "s6", 0x2300, "vdd_s6", },
+	{ "l1", 0x4000, "vdd_l1_l6_l7", },
+	{ "l2", 0x4100, "vdd_l2_l3", },
+	{ "l3", 0x4200, "vdd_l2_l3", },
+	/* l4 is unaccessible on PM660 */
+	{ "l5", 0x4400, "vdd_l5", },
+	{ "l6", 0x4500, "vdd_l1_l6_l7", },
+	{ "l7", 0x4600, "vdd_l1_l6_l7", },
+	{ "l8", 0x4700, "vdd_l8_l9_l10_l11_l12_l13_l14", },
+	{ "l9", 0x4800, "vdd_l8_l9_l10_l11_l12_l13_l14", },
+	{ "l10", 0x4900, "vdd_l8_l9_l10_l11_l12_l13_l14", },
+	{ "l11", 0x4a00, "vdd_l8_l9_l10_l11_l12_l13_l14", },
+	{ "l12", 0x4b00, "vdd_l8_l9_l10_l11_l12_l13_l14", },
+	{ "l13", 0x4c00, "vdd_l8_l9_l10_l11_l12_l13_l14", },
+	{ "l14", 0x4d00, "vdd_l8_l9_l10_l11_l12_l13_l14", },
+	{ "l15", 0x4e00, "vdd_l15_l16_l17_l18_l19", },
+	{ "l16", 0x4f00, "vdd_l15_l16_l17_l18_l19", },
+	{ "l17", 0x5000, "vdd_l15_l16_l17_l18_l19", },
+	{ "l18", 0x5100, "vdd_l15_l16_l17_l18_l19", },
+	{ "l19", 0x5200, "vdd_l15_l16_l17_l18_l19", },
+	{ }
+};
+
+static const struct spmi_regulator_data pm660l_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1", },
+	{ "s2", 0x1700, "vdd_s2", },
+	{ "s3", 0x1a00, "vdd_s3", },
+	{ "s4", 0x1d00, "vdd_s4", },
+	{ "s5", 0x2000, "vdd_s5", },
+	{ "l1", 0x4000, "vdd_l1_l9_l10", },
+	{ "l2", 0x4100, "vdd_l2", },
+	{ "l3", 0x4200, "vdd_l3_l5_l7_l8", },
+	{ "l4", 0x4300, "vdd_l4_l6", },
+	{ "l5", 0x4400, "vdd_l3_l5_l7_l8", },
+	{ "l6", 0x4500, "vdd_l4_l6", },
+	{ "l7", 0x4600, "vdd_l3_l5_l7_l8", },
+	{ "l8", 0x4700, "vdd_l3_l5_l7_l8", },
+	{ "l9", 0x4800, "vdd_l1_l9_l10", },
+	{ "l10", 0x4900, "vdd_l1_l9_l10", },
+	{ }
+};
+
+static const struct spmi_regulator_data pm8004_regulators[] = {
+	{ "s2", 0x1700, "vdd_s2", },
+	{ "s5", 0x2000, "vdd_s5", },
+	{ }
+};
+
+static const struct spmi_regulator_data pm8005_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1", },
+	{ "s2", 0x1700, "vdd_s2", },
+	{ "s3", 0x1a00, "vdd_s3", },
+	{ "s4", 0x1d00, "vdd_s4", },
+	{ }
+};
+
 static const struct spmi_regulator_data pm8226_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
@@ -2230,69 +2292,6 @@ static const struct spmi_regulator_data pmi8994_regulators[] = {
 	{ }
 };
 
-static const struct spmi_regulator_data pm660_regulators[] = {
-	{ "s1", 0x1400, "vdd_s1", },
-	{ "s2", 0x1700, "vdd_s2", },
-	{ "s3", 0x1a00, "vdd_s3", },
-	{ "s4", 0x1d00, "vdd_s3", },
-	{ "s5", 0x2000, "vdd_s5", },
-	{ "s6", 0x2300, "vdd_s6", },
-	{ "l1", 0x4000, "vdd_l1_l6_l7", },
-	{ "l2", 0x4100, "vdd_l2_l3", },
-	{ "l3", 0x4200, "vdd_l2_l3", },
-	/* l4 is unaccessible on PM660 */
-	{ "l5", 0x4400, "vdd_l5", },
-	{ "l6", 0x4500, "vdd_l1_l6_l7", },
-	{ "l7", 0x4600, "vdd_l1_l6_l7", },
-	{ "l8", 0x4700, "vdd_l8_l9_l10_l11_l12_l13_l14", },
-	{ "l9", 0x4800, "vdd_l8_l9_l10_l11_l12_l13_l14", },
-	{ "l10", 0x4900, "vdd_l8_l9_l10_l11_l12_l13_l14", },
-	{ "l11", 0x4a00, "vdd_l8_l9_l10_l11_l12_l13_l14", },
-	{ "l12", 0x4b00, "vdd_l8_l9_l10_l11_l12_l13_l14", },
-	{ "l13", 0x4c00, "vdd_l8_l9_l10_l11_l12_l13_l14", },
-	{ "l14", 0x4d00, "vdd_l8_l9_l10_l11_l12_l13_l14", },
-	{ "l15", 0x4e00, "vdd_l15_l16_l17_l18_l19", },
-	{ "l16", 0x4f00, "vdd_l15_l16_l17_l18_l19", },
-	{ "l17", 0x5000, "vdd_l15_l16_l17_l18_l19", },
-	{ "l18", 0x5100, "vdd_l15_l16_l17_l18_l19", },
-	{ "l19", 0x5200, "vdd_l15_l16_l17_l18_l19", },
-	{ }
-};
-
-static const struct spmi_regulator_data pm660l_regulators[] = {
-	{ "s1", 0x1400, "vdd_s1", },
-	{ "s2", 0x1700, "vdd_s2", },
-	{ "s3", 0x1a00, "vdd_s3", },
-	{ "s4", 0x1d00, "vdd_s4", },
-	{ "s5", 0x2000, "vdd_s5", },
-	{ "l1", 0x4000, "vdd_l1_l9_l10", },
-	{ "l2", 0x4100, "vdd_l2", },
-	{ "l3", 0x4200, "vdd_l3_l5_l7_l8", },
-	{ "l4", 0x4300, "vdd_l4_l6", },
-	{ "l5", 0x4400, "vdd_l3_l5_l7_l8", },
-	{ "l6", 0x4500, "vdd_l4_l6", },
-	{ "l7", 0x4600, "vdd_l3_l5_l7_l8", },
-	{ "l8", 0x4700, "vdd_l3_l5_l7_l8", },
-	{ "l9", 0x4800, "vdd_l1_l9_l10", },
-	{ "l10", 0x4900, "vdd_l1_l9_l10", },
-	{ }
-};
-
-
-static const struct spmi_regulator_data pm8004_regulators[] = {
-	{ "s2", 0x1700, "vdd_s2", },
-	{ "s5", 0x2000, "vdd_s5", },
-	{ }
-};
-
-static const struct spmi_regulator_data pm8005_regulators[] = {
-	{ "s1", 0x1400, "vdd_s1", },
-	{ "s2", 0x1700, "vdd_s2", },
-	{ "s3", 0x1a00, "vdd_s3", },
-	{ "s4", 0x1d00, "vdd_s4", },
-	{ }
-};
-
 static const struct spmi_regulator_data pmp8074_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1"},
 	{ "s2", 0x1700, "vdd_s2"},
@@ -2321,6 +2320,8 @@ static const struct spmi_regulator_data pms405_regulators[] = {
 };
 
 static const struct of_device_id qcom_spmi_regulator_match[] = {
+	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
+	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
 	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
 	{ .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
 	{ .compatible = "qcom,pm8226-regulators", .data = &pm8226_regulators },
@@ -2330,8 +2331,6 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm8950-regulators", .data = &pm8950_regulators },
 	{ .compatible = "qcom,pm8994-regulators", .data = &pm8994_regulators },
 	{ .compatible = "qcom,pmi8994-regulators", .data = &pmi8994_regulators },
-	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
-	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
 	{ .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },
 	{ .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
 	{ }
-- 
2.37.1

