Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66705861D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiGaWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbiGaWih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:38:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0515612AAB;
        Sun, 31 Jul 2022 15:38:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b96so1363941edf.0;
        Sun, 31 Jul 2022 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sgxF61aUPAke836gP2VtidT0A3gv65L2eAzKeFf5m8o=;
        b=BC11g2EtV6cMtyupCbiyEkG5uTHykgCyOoh8ULnoOpsKeej0q02u5BjawbiNMJUKl8
         dwY0VKtyDC+NW6k7MeL0KxpZ5gSyGWK6PXyptTLuf4VeF+FTUu/g4BOM2lIV4hsL1t6G
         I5eyoC2EpKeup6Fkl/6lC6Mh8purktVct7dusXIHFm8g2BC6hnqnfjkZbH4Bu071ZORx
         B/xX1SyicAFuJglpKK68xpeu7D4GK5u4+gO6cLf5e5tM8jxVLpTPkK4TpEo4haikTiRm
         mHFyNMHZnLWvQ6hcU8etR1xCvaakQAk6te6KO0HeMb0SZ/O/HRXJ/qEZjfnEZGU+/41X
         V3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sgxF61aUPAke836gP2VtidT0A3gv65L2eAzKeFf5m8o=;
        b=13y4Mxuubg3EskCnUaUwqBUyuQEUhwm6UshM8CXjzxYsLJLzTeavE2uj6V/S2BZ7L4
         +nvU6tJSZX6pZzJNDnAFUd/w9WmQ/XmAY9copZ+RQBm8cL1LtfkWnpgqpaagc3qm29H7
         fkzRzzAkv5fueLka4hPGnLDEFKkLnOhk0wJx5QQ48SvYo90R59OumfxnE/yqJcK/PNUD
         XLS1+9A7KDtBMrdXOtDqeycBiVLiWUxABvfXddWXAyxzDtDzi5mto+H+4R+1+/ExIAHg
         e/pPQespOv7z+OFA7DbOJ3NEaclzqfV8x8j4e2muuQnrOz0o+oBS8jTovr6j42ymsI7y
         uNtQ==
X-Gm-Message-State: ACgBeo0RZlgWnbXl1Q76zgJJ8lu6XP8kDn91O03IFfqRlwpgUPyMJDIS
        51adw8R/dB6MpEF8vo72sPM=
X-Google-Smtp-Source: AA6agR5/11Fpkor3fwiszGmAfEew7yuGwKvJ0e8yT/6Kf1HWpUBEOstxZyNz5nbx4dTW/nl1q7Temw==
X-Received: by 2002:a05:6402:22bc:b0:43d:73a7:370a with SMTP id cx28-20020a05640222bc00b0043d73a7370amr5508241edb.120.1659307097158;
        Sun, 31 Jul 2022 15:38:17 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b00726c0e63b94sm4478572ejd.27.2022.07.31.15.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:38:16 -0700 (PDT)
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
Subject: [PATCH v3 13/13] regulator: qcom_smd: Add PM6125 regulators support
Date:   Mon,  1 Aug 2022 01:37:36 +0300
Message-Id: <20220731223736.1036286-14-iskren.chernev@gmail.com>
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

Add support for PM6125 PMIC which is found on SM4250/6115 SoCs.

S1, S2, S3, S4, S8 are FTS+FTSMPS_510, rev 2
- range is 0.3-1.372V by 4mV increments
S5, S6, s7 are BUCK+HFSMPS_510, rev 4
- range is 0.32-2.04V by 8mV increment
L1, L3, L7 are LDO+N600_510, rev 2
L2, L4, L8, L17, L18 are LDO+N300_510, rev 2
L6 is LDO+N1200_510, rev 2
- range is 0.32-1.304V by 8mV increment
L5 is LDO+MV_P50_510, rev 2
L15, L19, L20 are LDO+MV_P150_510, rev 2
L21, L22, L23, L24 are LDO+MV_P600_510, rev 2
- range is 1.504-3.544V by 8mV increment
L9, L11, L14 are LDO+LV_P600_510, rev 2
L10, L16 are LDO+LV_P150_510, rev 2
L12, L13 are LDO+LV_P300_510, rev 2
- range 1.504-2V by 8mV increment

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

