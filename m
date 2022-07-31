Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFFD5861D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiGaWjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbiGaWib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:38:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399DE12A84;
        Sun, 31 Jul 2022 15:38:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kb8so2732469ejc.4;
        Sun, 31 Jul 2022 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0VM1HOfv9+iYeTNizxoVqzafqFFyLv7FBQIAQpN8A8M=;
        b=EdC3Ki58tTQUVhmibi1y42IPs+8LFu8m+U7GGIRMvUPzKOGAj9MyUi6VZsdZIr4FcJ
         Ors/OGawau3+GW4c7wShOa7jQdAWKK3u04SaUv+QmewbCSsxdaDyWqQOR6djNSk1iqq7
         zssHqtOU0+1KkCiIFprZOVRAgxv5mAgNravy8RccoSYYT/iyoTtbHIt08ZNwPuXbru+q
         s++ZNv7NvOu8cHgPtZi3nFj/iFbkBAB30vnlFB3DZS9x/BQXwEQA5WZ4dvUsqH+d1RXZ
         /R+8+B11Bula3VxQHFswc1ctPdCygwKByFV/jyH/9PAALU9RTzSjxMkA9f7L0Ik7IaL/
         07SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0VM1HOfv9+iYeTNizxoVqzafqFFyLv7FBQIAQpN8A8M=;
        b=2GXiC0dnmGe+IIPaJsK03ujot16aekGX9FsZ7YBzBwLMsjsnSrc3Ja3gu10AvV6yaX
         zJi2kmfocej6HzJrU2MML5e9nv9brZcarfMh+bXgr37knR5U17d7NiyitaZKuixhLzZo
         /L+HMZ/EvtX+sIEX60TfV3DFY67J0SR76MChEdzgIIYD43hmFWL3W1hIgcAb3cMXVHA7
         RJJzoDtwO9Z4S/1FeDAMRVzNIFlQTAX+NzBCMYdNIieV4oID3ge0F4fQ2+pBj5e/xNs6
         8HnpCL18zDFIJaLFYTeD7RdUn1Pr2KGEqXNz0zFsWu2EUefYZT966ddbp8DkNZNM+eXG
         HhWg==
X-Gm-Message-State: AJIora8XsE7krnylvMx1HaF8WwD+DHD1dVUgJN+gd+iSaJqNZx17xwF+
        dGgfxAWYTGGfyQBQlLLBPT4OAiUWFT5H1ZiF
X-Google-Smtp-Source: AGRyM1u0/ELtzXSP38vO19R4ZQHpdNzNnRB2g+vzYD+5QDhd2CS/sX1ph5VNXVhVx6tJ/KrWKWz+pw==
X-Received: by 2002:a17:906:84e8:b0:72b:6d91:a0d1 with SMTP id zp8-20020a17090684e800b0072b6d91a0d1mr10384025ejb.60.1659307091886;
        Sun, 31 Jul 2022 15:38:11 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id ky1-20020a170907778100b0073048c183a2sm2389029ejc.110.2022.07.31.15.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:38:11 -0700 (PDT)
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
Subject: [PATCH v3 11/13] regulator: qcom_smd: Sort pmics alphabetically (part 2)
Date:   Mon,  1 Aug 2022 01:37:34 +0300
Message-Id: <20220731223736.1036286-12-iskren.chernev@gmail.com>
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
 drivers/regulator/qcom_smd-regulator.c | 154 ++++++++++++-------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index c807768d1927..cabcf9944ac1 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -772,6 +772,36 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm2250_lvftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm2250_lvftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm2250_lvftsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm2250_ftsmps, "vdd_s4" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pm8226_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8226_hfsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8226_ftsmps, "vdd_s2" },
@@ -1031,6 +1061,53 @@ static const struct rpm_regulator_data rpm_pm8994_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pm8998_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8998_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8998_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm8998_hfsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm8998_hfsmps, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm8998_hfsmps, "vdd_s5" },
+	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pm8998_ftsmps, "vdd_s6" },
+	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pm8998_ftsmps, "vdd_s7" },
+	{ "s8", QCOM_SMD_RPM_SMPA, 8, &pm8998_ftsmps, "vdd_s8" },
+	{ "s9", QCOM_SMD_RPM_SMPA, 9, &pm8998_ftsmps, "vdd_s9" },
+	{ "s10", QCOM_SMD_RPM_SMPA, 10, &pm8998_ftsmps, "vdd_s10" },
+	{ "s11", QCOM_SMD_RPM_SMPA, 11, &pm8998_ftsmps, "vdd_s11" },
+	{ "s12", QCOM_SMD_RPM_SMPA, 12, &pm8998_ftsmps, "vdd_s12" },
+	{ "s13", QCOM_SMD_RPM_SMPA, 13, &pm8998_ftsmps, "vdd_s13" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm8998_nldo, "vdd_l1_l27" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm8998_nldo, "vdd_l2_l8_l17" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm8998_nldo, "vdd_l3_l11" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm8998_nldo, "vdd_l4_l5" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8998_nldo, "vdd_l4_l5" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8998_pldo, "vdd_l6" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm8998_nldo, "vdd_l2_l8_l17" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm8998_pldo, "vdd_l9" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm8998_pldo, "vdd_l10_l23_l25" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8998_nldo, "vdd_l3_l11" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8998_pldo, "vdd_l13_l19_l21" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm8998_pldo, "vdd_l16_l28" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8998_nldo, "vdd_l2_l8_l17" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm8998_pldo, "vdd_l18_l22" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm8998_pldo, "vdd_l13_l19_l21" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm8998_pldo, "vdd_l20_l24" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm8998_pldo, "vdd_l13_l19_l21" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm8998_pldo, "vdd_l18_l22" },
+	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pm8998_pldo, "vdd_l10_l23_l25" },
+	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pm8998_pldo, "vdd_l20_l24" },
+	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pm8998_pldo, "vdd_l10_l23_l25" },
+	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pm8998_nldo, "vdd_l26" },
+	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pm8998_nldo, "vdd_l1_l27" },
+	{ "l28", QCOM_SMD_RPM_LDOA, 28, &pm8998_pldo, "vdd_l16_l28" },
+	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pm8998_switch, "vdd_lvs1_lvs2" },
+	{ "lvs2", QCOM_SMD_RPM_VSA, 2, &pm8998_switch, "vdd_lvs1_lvs2" },
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pma8084_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pma8084_ftsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pma8084_ftsmps, "vdd_s2" },
@@ -1090,53 +1167,6 @@ static const struct rpm_regulator_data rpm_pmi8994_regulators[] = {
 	{}
 };
 
-static const struct rpm_regulator_data rpm_pm8998_regulators[] = {
-	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8998_ftsmps, "vdd_s1" },
-	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8998_ftsmps, "vdd_s2" },
-	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm8998_hfsmps, "vdd_s3" },
-	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm8998_hfsmps, "vdd_s4" },
-	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm8998_hfsmps, "vdd_s5" },
-	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pm8998_ftsmps, "vdd_s6" },
-	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pm8998_ftsmps, "vdd_s7" },
-	{ "s8", QCOM_SMD_RPM_SMPA, 8, &pm8998_ftsmps, "vdd_s8" },
-	{ "s9", QCOM_SMD_RPM_SMPA, 9, &pm8998_ftsmps, "vdd_s9" },
-	{ "s10", QCOM_SMD_RPM_SMPA, 10, &pm8998_ftsmps, "vdd_s10" },
-	{ "s11", QCOM_SMD_RPM_SMPA, 11, &pm8998_ftsmps, "vdd_s11" },
-	{ "s12", QCOM_SMD_RPM_SMPA, 12, &pm8998_ftsmps, "vdd_s12" },
-	{ "s13", QCOM_SMD_RPM_SMPA, 13, &pm8998_ftsmps, "vdd_s13" },
-	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm8998_nldo, "vdd_l1_l27" },
-	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm8998_nldo, "vdd_l2_l8_l17" },
-	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm8998_nldo, "vdd_l3_l11" },
-	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm8998_nldo, "vdd_l4_l5" },
-	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8998_nldo, "vdd_l4_l5" },
-	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8998_pldo, "vdd_l6" },
-	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
-	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm8998_nldo, "vdd_l2_l8_l17" },
-	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm8998_pldo, "vdd_l9" },
-	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm8998_pldo, "vdd_l10_l23_l25" },
-	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8998_nldo, "vdd_l3_l11" },
-	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
-	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8998_pldo, "vdd_l13_l19_l21" },
-	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
-	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
-	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm8998_pldo, "vdd_l16_l28" },
-	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8998_nldo, "vdd_l2_l8_l17" },
-	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm8998_pldo, "vdd_l18_l22" },
-	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm8998_pldo, "vdd_l13_l19_l21" },
-	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm8998_pldo, "vdd_l20_l24" },
-	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm8998_pldo, "vdd_l13_l19_l21" },
-	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm8998_pldo, "vdd_l18_l22" },
-	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pm8998_pldo, "vdd_l10_l23_l25" },
-	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pm8998_pldo, "vdd_l20_l24" },
-	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pm8998_pldo, "vdd_l10_l23_l25" },
-	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pm8998_nldo, "vdd_l26" },
-	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pm8998_nldo, "vdd_l1_l27" },
-	{ "l28", QCOM_SMD_RPM_LDOA, 28, &pm8998_pldo, "vdd_l16_l28" },
-	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pm8998_switch, "vdd_lvs1_lvs2" },
-	{ "lvs2", QCOM_SMD_RPM_VSA, 2, &pm8998_switch, "vdd_lvs1_lvs2" },
-	{}
-};
-
 static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
 	{ "bob", QCOM_SMD_RPM_BOBB, 1, &pmi8998_bob, "vdd_bob" },
 	{}
@@ -1212,36 +1242,6 @@ static const struct rpm_regulator_data rpm_pms405_regulators[] = {
 	{}
 };
 
-static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
-	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm2250_lvftsmps, "vdd_s1" },
-	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm2250_lvftsmps, "vdd_s2" },
-	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm2250_lvftsmps, "vdd_s3" },
-	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm2250_ftsmps, "vdd_s4" },
-	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
-	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
-	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
-	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
-	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
-	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
-	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
-	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
-	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
-	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
-	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
-	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
-	{}
-};
-
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
 	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
-- 
2.37.1

