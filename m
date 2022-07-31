Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F95861D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbiGaWis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbiGaWi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:38:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40312D11;
        Sun, 31 Jul 2022 15:38:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gk3so5146503ejb.8;
        Sun, 31 Jul 2022 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=M2ycc73FpdaMn3bEjgV7beLocW5w17jbIEDHPtlJrZs=;
        b=gnuqZN7vzFuGvqG1OPjhZqrH1jd6XhOPSSAOaF82sEiARc4VK2WYyZY5H6ri8QjlQL
         O4Rm+Rmw5olEhtfFy+xJBuM6RZqdu0riDRnZQVuOEGbuY2gssMYx49OytO0k+SWong7d
         P9sTombEv1bmjYLNkd5DXXTP6NZeCWN2DXbBFKIG8sv8KyUOjuow+i0lbEh1qoLe9pcG
         bdK9ST56v0EBhbu7s4HuYncul5dXM9TDVdW27jNSaJfaYk0gEqskRRITdABqN2mpmHS/
         3fnmrT+JmfMbSVVGSAnSNywxqPp+VBYagBTZAJ5I/gJgQJ/MgTIh6VIz08ktbmvbbRog
         pGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=M2ycc73FpdaMn3bEjgV7beLocW5w17jbIEDHPtlJrZs=;
        b=wPTX4zFpkOfcLA5zLE1YCik9lXxKpqOz4dmcPBUfKzcxqaLb2sacC8oMLZtMI2dkV/
         MBPCt4NcOl73A7rlKe817Oajahx+76xq/AejC9QkGzu9P3S4MLs2Zzcl5/Qf8eFj1bwB
         IeaACWyjAhARUkNs931XeshY43dhNCBBwFvwsUPrN+kQ42N5ixncwaloZbNBhRVPfQ9F
         K98Lwhj9CJ26NtVO7agIHMCftURZi7qJ9EYQT3StaKY4Nv8+FPWiUOyV4PWlme9IrNmI
         sPpDuCd6U96sPUIHCjfcPwFfI3Q+1SWjfsrSxERtUA+zVeAsXRugsWObTYqDhtBMROWw
         we2g==
X-Gm-Message-State: ACgBeo08a45CtBiNEsyAGZisAKdqE33ieIl2+K/8eDRY2uKVdU3PGTmI
        KBrLs96sn+TJcpgg/b4VrDI=
X-Google-Smtp-Source: AA6agR5+VtabXrBrfh9ATOmi3S3I+OIjvfsia9i92d4oe7DLaGAen+oT7btNsmBdVaKSY81dZGHQ1g==
X-Received: by 2002:a17:906:eeca:b0:730:6880:c397 with SMTP id wu10-20020a170906eeca00b007306880c397mr3479551ejb.593.1659307089535;
        Sun, 31 Jul 2022 15:38:09 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id cq27-20020a056402221b00b0043d482188b4sm3160681edb.29.2022.07.31.15.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:38:09 -0700 (PDT)
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
Subject: [PATCH v3 10/13] regulator: qcom_smd: Sort pmics alphabetically (part 1)
Date:   Mon,  1 Aug 2022 01:37:33 +0300
Message-Id: <20220731223736.1036286-11-iskren.chernev@gmail.com>
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

