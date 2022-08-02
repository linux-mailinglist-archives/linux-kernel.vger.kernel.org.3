Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A095883F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiHBWMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiHBWMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:12:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6013445989;
        Tue,  2 Aug 2022 15:11:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w3so3642968edc.2;
        Tue, 02 Aug 2022 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=M2ycc73FpdaMn3bEjgV7beLocW5w17jbIEDHPtlJrZs=;
        b=M8zvmJQivjeEj/S94zy7riR/WTDDdqyglPBSf334Er8kx99SzBvJUXOm8RGXtlnICR
         gHHwYm2gE6O1VNHC8cTvwYzgoqlupOpw0uKtGp2v/gZla2CBpaw5wBTvQIVHLPksG5kU
         BoY3xSbrPIkXU7v6f6YqMH+3XQ53NmxC3oc2Uxeqd2J6IQ6aitmHwusL6CpFL4vAiVO0
         ObBZLorlJW6i1pGD8lMnD/oEaHflHpuqe7KYRancN0eCsy6/bBqvq1TPz/mz4Vy+a5yg
         Xhz4HYDu3d0QjJlrNOBexA71c2GvdPY06mItJhP58iKRC9T5pmLRkKqK01XDfLNQZL/a
         vXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=M2ycc73FpdaMn3bEjgV7beLocW5w17jbIEDHPtlJrZs=;
        b=HZjQ/k3XpACpIIbmQdle7DYsCj0B1m2S44DQLZXsVjq6jgpmPbSqYYF+0f5KWb4js1
         6T8wg3GtOgcUCb4JlIspCfX9/KUpKPDdy/2CCy1OWc8NcQGKhNX1q5qjytu/QaKUNI3R
         tbXZa1OyZsULR/MHd3/lbvAAmNaEXd06OOnefgdq0IkAuzEAfTOyotuLubqAeSVdB2H+
         7GeJRHpErhHRNDaAI3T4vxXUUQ6gwnJnm4feTzXoqpMcZlTRvUQb2OhjnpTiXnnywZnZ
         TBKOGPgwS8NCzfLASXmXoGarhyqjWN/VVHka3HiwRyK0BoSVPxg4Z2K+SFX7G3TMy3Zz
         ghyQ==
X-Gm-Message-State: ACgBeo1Z74UuqEGhGsevgGbtTFie0qxMCJY+6yIHaF8cWW421exjhKFD
        zdKlEilQcXAd5wIu+IrXOFk=
X-Google-Smtp-Source: AA6agR7duz5n+FDcrBqE7ICNTGABywTUOijPyNWihLEnFityEV0wWLtvwi1zpcWcxusGGWerQk5RzA==
X-Received: by 2002:a05:6402:524a:b0:43d:aa71:33d8 with SMTP id t10-20020a056402524a00b0043daa7133d8mr11369421edd.33.1659478312509;
        Tue, 02 Aug 2022 15:11:52 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id la20-20020a170907781400b0072b7d76211dsm6620962ejc.107.2022.08.02.15.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:51 -0700 (PDT)
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
Subject: [PATCH v4 10/13] regulator: qcom_smd: Sort pmics alphabetically (part 1)
Date:   Wed,  3 Aug 2022 01:11:09 +0300
Message-Id: <20220802221112.2280686-11-iskren.chernev@gmail.com>
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
 drivers/regulator/qcom_smd-regulator.c | 178 ++++++++++++-------------
 1 file changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 59024c639141..c807768d1927 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -772,6 +772,44 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pm8226_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8226_hfsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8226_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm8226_hfsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm8226_hfsmps, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm8226_hfsmps, "vdd_s5" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm8226_nldo, "vdd_l1_l2_l4_l5" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm8226_nldo, "vdd_l1_l2_l4_l5" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm8226_nldo, "vdd_l3_l24_l26" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm8226_nldo, "vdd_l1_l2_l4_l5" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8226_nldo, "vdd_l1_l2_l4_l5" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm8226_pldo, "vdd_l10_l11_l13" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8226_pldo, "vdd_l10_l11_l13" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8226_pldo, "vdd_l12_l14" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8226_pldo, "vdd_l10_l11_l13" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8226_pldo, "vdd_l12_l14" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8226_pldo, "vdd_l15_l16_l17_l18" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm8226_pldo, "vdd_l15_l16_l17_l18" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8226_pldo, "vdd_l15_l16_l17_l18" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm8226_pldo, "vdd_l15_l16_l17_l18" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
+	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
+	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pm8226_nldo, "vdd_l3_l24_l26" },
+	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pm8226_pldo, "vdd_l25" },
+	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pm8226_nldo, "vdd_l3_l24_l26" },
+	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
+	{ "l28", QCOM_SMD_RPM_LDOA, 28, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
+	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pm8226_switch, "vdd_lvs1" },
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pm8841_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPB, 1, &pm8x41_hfsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPB, 2, &pm8841_ftsmps, "vdd_s2" },
@@ -833,44 +871,6 @@ static const struct rpm_regulator_data rpm_pm8916_regulators[] = {
 	{}
 };
 
-static const struct rpm_regulator_data rpm_pm8226_regulators[] = {
-	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8226_hfsmps, "vdd_s1" },
-	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8226_ftsmps, "vdd_s2" },
-	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm8226_hfsmps, "vdd_s3" },
-	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm8226_hfsmps, "vdd_s4" },
-	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm8226_hfsmps, "vdd_s5" },
-	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm8226_nldo, "vdd_l1_l2_l4_l5" },
-	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm8226_nldo, "vdd_l1_l2_l4_l5" },
-	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm8226_nldo, "vdd_l3_l24_l26" },
-	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm8226_nldo, "vdd_l1_l2_l4_l5" },
-	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8226_nldo, "vdd_l1_l2_l4_l5" },
-	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
-	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
-	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
-	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
-	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm8226_pldo, "vdd_l10_l11_l13" },
-	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8226_pldo, "vdd_l10_l11_l13" },
-	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8226_pldo, "vdd_l12_l14" },
-	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8226_pldo, "vdd_l10_l11_l13" },
-	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8226_pldo, "vdd_l12_l14" },
-	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8226_pldo, "vdd_l15_l16_l17_l18" },
-	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm8226_pldo, "vdd_l15_l16_l17_l18" },
-	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8226_pldo, "vdd_l15_l16_l17_l18" },
-	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm8226_pldo, "vdd_l15_l16_l17_l18" },
-	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
-	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
-	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
-	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
-	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
-	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pm8226_nldo, "vdd_l3_l24_l26" },
-	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pm8226_pldo, "vdd_l25" },
-	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pm8226_nldo, "vdd_l3_l24_l26" },
-	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pm8226_pldo, "vdd_l6_l7_l8_l9_l27" },
-	{ "l28", QCOM_SMD_RPM_LDOA, 28, &pm8226_pldo, "vdd_l19_l20_l21_l22_l23_l28" },
-	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pm8226_switch, "vdd_lvs1" },
-	{}
-};
-
 static const struct rpm_regulator_data rpm_pm8941_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8x41_hfsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8x41_hfsmps, "vdd_s2" },
@@ -912,57 +912,6 @@ static const struct rpm_regulator_data rpm_pm8941_regulators[] = {
 	{}
 };
 
-static const struct rpm_regulator_data rpm_pma8084_regulators[] = {
-	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pma8084_ftsmps, "vdd_s1" },
-	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pma8084_ftsmps, "vdd_s2" },
-	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pma8084_hfsmps, "vdd_s3" },
-	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pma8084_hfsmps, "vdd_s4" },
-	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pma8084_hfsmps, "vdd_s5" },
-	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pma8084_ftsmps, "vdd_s6" },
-	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pma8084_ftsmps, "vdd_s7" },
-	{ "s8", QCOM_SMD_RPM_SMPA, 8, &pma8084_ftsmps, "vdd_s8" },
-	{ "s9", QCOM_SMD_RPM_SMPA, 9, &pma8084_ftsmps, "vdd_s9" },
-	{ "s10", QCOM_SMD_RPM_SMPA, 10, &pma8084_ftsmps, "vdd_s10" },
-	{ "s11", QCOM_SMD_RPM_SMPA, 11, &pma8084_ftsmps, "vdd_s11" },
-	{ "s12", QCOM_SMD_RPM_SMPA, 12, &pma8084_ftsmps, "vdd_s12" },
-
-	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pma8084_nldo, "vdd_l1_l11" },
-	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
-	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
-	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
-	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pma8084_pldo, "vdd_l5_l7" },
-	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
-	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pma8084_pldo, "vdd_l5_l7" },
-	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pma8084_pldo, "vdd_l8" },
-	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
-	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
-	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pma8084_nldo, "vdd_l1_l11" },
-	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
-	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
-	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
-	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
-	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pma8084_pldo, "vdd_l16_l25" },
-	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pma8084_pldo, "vdd_l17" },
-	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pma8084_pldo, "vdd_l18" },
-	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pma8084_pldo, "vdd_l19" },
-	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
-	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pma8084_pldo, "vdd_l21" },
-	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pma8084_pldo, "vdd_l22" },
-	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
-	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
-	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pma8084_pldo, "vdd_l16_l25" },
-	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
-	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
-
-	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pma8084_switch },
-	{ "lvs2", QCOM_SMD_RPM_VSA, 2, &pma8084_switch },
-	{ "lvs3", QCOM_SMD_RPM_VSA, 3, &pma8084_switch },
-	{ "lvs4", QCOM_SMD_RPM_VSA, 4, &pma8084_switch },
-	{ "5vs1", QCOM_SMD_RPM_VSA, 5, &pma8084_switch },
-
-	{}
-};
-
 static const struct rpm_regulator_data rpm_pm8950_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8950_hfsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8950_hfsmps, "vdd_s2" },
@@ -1082,6 +1031,57 @@ static const struct rpm_regulator_data rpm_pm8994_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pma8084_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pma8084_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pma8084_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pma8084_hfsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pma8084_hfsmps, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pma8084_hfsmps, "vdd_s5" },
+	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pma8084_ftsmps, "vdd_s6" },
+	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pma8084_ftsmps, "vdd_s7" },
+	{ "s8", QCOM_SMD_RPM_SMPA, 8, &pma8084_ftsmps, "vdd_s8" },
+	{ "s9", QCOM_SMD_RPM_SMPA, 9, &pma8084_ftsmps, "vdd_s9" },
+	{ "s10", QCOM_SMD_RPM_SMPA, 10, &pma8084_ftsmps, "vdd_s10" },
+	{ "s11", QCOM_SMD_RPM_SMPA, 11, &pma8084_ftsmps, "vdd_s11" },
+	{ "s12", QCOM_SMD_RPM_SMPA, 12, &pma8084_ftsmps, "vdd_s12" },
+
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pma8084_nldo, "vdd_l1_l11" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pma8084_pldo, "vdd_l5_l7" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pma8084_pldo, "vdd_l5_l7" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pma8084_pldo, "vdd_l8" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pma8084_nldo, "vdd_l1_l11" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pma8084_pldo, "vdd_l16_l25" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pma8084_pldo, "vdd_l17" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pma8084_pldo, "vdd_l18" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pma8084_pldo, "vdd_l19" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pma8084_pldo, "vdd_l21" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pma8084_pldo, "vdd_l22" },
+	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pma8084_pldo, "vdd_l16_l25" },
+	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
+
+	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pma8084_switch },
+	{ "lvs2", QCOM_SMD_RPM_VSA, 2, &pma8084_switch },
+	{ "lvs3", QCOM_SMD_RPM_VSA, 3, &pma8084_switch },
+	{ "lvs4", QCOM_SMD_RPM_VSA, 4, &pma8084_switch },
+	{ "5vs1", QCOM_SMD_RPM_VSA, 5, &pma8084_switch },
+
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pmi8994_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPB, 1, &pmi8994_ftsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPB, 2, &pmi8994_hfsmps, "vdd_s2" },
-- 
2.37.1

