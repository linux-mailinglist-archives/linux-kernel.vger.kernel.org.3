Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E719858840E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiHBWNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiHBWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:12:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F03C40BCD;
        Tue,  2 Aug 2022 15:11:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ss3so28249663ejc.11;
        Tue, 02 Aug 2022 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=C0jW64/KiFwvjDsl6sIOegZf+KbryaIBgl5ahVhWno4=;
        b=WPM5AcMIIul1+jqYaxYLV7iy1y12BnmTX4t6FIkKJzIaNMKTvHbPm2rYWAgjzKTHlQ
         PMTv4ly+uyfDB0kcgsiT+S02Uf4FYwhcIWijhlVDmllJpxh5GSvVxqAw53pE8TKUa5Ux
         KljRUyqemJuqtTgn2UaWrvP7vQb76xUdLPQViCnMHkZvjQtaHyZtGs38ymnVLyK+EiCM
         zCIjcPfdzBs3Xd7OxmF/J7G9iABQ/Oxv2x5Zka/P4ePQjuMjzuwFv25XPsPGFEUrNU+p
         U8nIMd1czx6mp1SlbNH2AIkYgWAIwKeFOcNNEA78OmQHTt197dj4a0mk61tvuGFdow7R
         qy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=C0jW64/KiFwvjDsl6sIOegZf+KbryaIBgl5ahVhWno4=;
        b=1hk0ZXou54PRl0xv1Tq8/CY9Njn2pDM8IVEG9tw2viOr65+6OiI01HTQVal7YqI208
         0ze/XsInoWSeVFncMTKidYMIXrocVFWCVHXBlYYYEelKKXgG2PjRppnfTyn4Bg8ZXy9n
         RXJ4hbsFUGPjvApEgh4NGhA5Rf21w883u+2RxBUY+cULEcWiC6eTs9HHhA8Sukvq0tih
         xPbnwieyPvRZHHtCYxcJBo+3HxVorROTJDtV4hj4qzHd8yKp/Qti7Qf+xt9Xqv/6guy/
         R1yydBPY9jHDvwv3sh1vbzmbfL9R3ffsCekdL659NeFLv5QXL/x6Hw4oTIE27h+Zz4LA
         Jiqg==
X-Gm-Message-State: AJIora/C4tLP+SD+qNKY1g9oTfhwFJc8L5tUdbKu7qPuZ7MX4THh1uYi
        F8SE+Yxr9ABg6iHGmX4/ZrQ=
X-Google-Smtp-Source: AGRyM1vsnzF3FuCRRfhnVQ0KrN+qmJuxmVYslbsk3N0pNBnEA+G51JnKGGxwiKPQ1tVcljwljkAx2w==
X-Received: by 2002:a17:907:7601:b0:730:3da4:217c with SMTP id jx1-20020a170907760100b007303da4217cmr14148973ejc.563.1659478307870;
        Tue, 02 Aug 2022 15:11:47 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709061b4700b0072aac7446easm6612254ejg.47.2022.08.02.15.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:47 -0700 (PDT)
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
Subject: [PATCH v4 08/13] regulator: qcom_spmi: Sort pmics alphabetically (part 2)
Date:   Wed,  3 Aug 2022 01:11:07 +0300
Message-Id: <20220802221112.2280686-9-iskren.chernev@gmail.com>
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

The sorting is split in multiple commits for easier reviewing.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 129 ++++++++++++------------
 1 file changed, 64 insertions(+), 65 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 4c6494e3bbf6..aed818c7a4d4 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2021,6 +2021,68 @@ static int spmi_regulator_of_parse(struct device_node *node,
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
@@ -2225,69 +2287,6 @@ static const struct spmi_regulator_data pmi8994_regulators[] = {
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
@@ -2316,6 +2315,8 @@ static const struct spmi_regulator_data pms405_regulators[] = {
 };
 
 static const struct of_device_id qcom_spmi_regulator_match[] = {
+	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
+	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
 	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
 	{ .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
 	{ .compatible = "qcom,pm8226-regulators", .data = &pm8226_regulators },
@@ -2325,8 +2326,6 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
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

