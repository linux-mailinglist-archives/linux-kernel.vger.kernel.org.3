Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28558840D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiHBWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiHBWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:12:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AD354C9B;
        Tue,  2 Aug 2022 15:11:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ss3so28250208ejc.11;
        Tue, 02 Aug 2022 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MHgNJvBeRz/l5NsbZlDMXQF+HONKnG9pnnUJlGD6K1c=;
        b=otOW3qk+ZgZBPKSwI2wP8+ofExkM45rJyYST4SMG6DylK1jeRHLL5SURdbO8pETwlx
         BfkLO4cwgxNcjgwN6hJs5duEmz/AqRLo6Cu/AV3ArxLl1bG4OwQ5w28NxgWY3iDykftU
         8dv4zn2rNZQwkB4QvUj7zvS4U5L93EhpAb+aelpXNB1tH4JR4+LxorntrogtuzDpsJjl
         07214yUb8FMgWJYIMQeR0dlBrLXjQrCc3IKdmGVldoeBrFdyqqXAulVQ56kSzsgrLR8t
         cUHBPF/YzYnYpJqbUvVq/HHLukFnzftbBZaE1zwPbOWn3joXQKp2yo2/aeWr5khSWHs+
         V74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MHgNJvBeRz/l5NsbZlDMXQF+HONKnG9pnnUJlGD6K1c=;
        b=gGmrWYupZRqZqH2t1+QIihbYf5wPw4mQjnXnjy7rLnblMv8wg9Paz3w04mew6bwJow
         p2vFQZyYNeLnKkcP6gxFd3ramsZZA2OcoaQ1XsWEYl5NyN+xeSMK9k01jYQT35CKIW3j
         u6YATp5aZNs2ih8ucdfB6auh5KYJsI7yZfR0wyQ/rOnbX1ikO42vi+wbuNgKLB+OSAXy
         TGMoLpGjiQ4ZrzdGo1WrX7nIL1KckAZ1E58Zfrro5tBQIbmSuxBjE3cHKSDqyVPLLmjD
         Sganu6dy3ngg1Zwv+cra6z0ebOo+6daZWINpjjkZWmfL5qWkeqAzwARSKnIPHQ5NNyHW
         HwyQ==
X-Gm-Message-State: AJIora+luS5ggglTtAKP37YlrsmRWIwEEJHgNSxZEf8OQIlFIhX23UHd
        k+jW/b2oEiJx7DpnmB8QBmk=
X-Google-Smtp-Source: AGRyM1tRqSFaXtitOWY5T+pzUPdZP2qroZBoxOnRk81OYYfcF4muRDiY2D7bBBLMh1UVwhxuzF1ewg==
X-Received: by 2002:a17:907:c26:b0:72b:4d8e:b458 with SMTP id ga38-20020a1709070c2600b0072b4d8eb458mr18179330ejc.195.1659478316987;
        Tue, 02 Aug 2022 15:11:56 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0043a5bcf80a2sm8728941eds.60.2022.08.02.15.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:56 -0700 (PDT)
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
Subject: [PATCH v4 12/13] regulator: qcom_smd: Sort pmics alphabetically (part 3)
Date:   Wed,  3 Aug 2022 01:11:11 +0300
Message-Id: <20220802221112.2280686-13-iskren.chernev@gmail.com>
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
 drivers/regulator/qcom_smd-regulator.c | 104 ++++++++++++-------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index cabcf9944ac1..92c9631a2415 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -802,6 +802,54 @@ static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pm660_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm660_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm660_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm660_ftsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm660_hfsmps, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm660_hfsmps, "vdd_s5" },
+	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pm660_hfsmps, "vdd_s6" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm660_nldo660, "vdd_l1_l6_l7" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm660_ht_nldo, "vdd_l2_l3" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm660_nldo660, "vdd_l2_l3" },
+	/* l4 is unaccessible on PM660 */
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm660_ht_nldo, "vdd_l5" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm660_ht_nldo, "vdd_l1_l6_l7" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm660_ht_nldo, "vdd_l1_l6_l7" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
+	{ }
+};
+
+static const struct rpm_regulator_data rpm_pm660l_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPB, 1, &pm660_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPB, 2, &pm660_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_RWCX, 0, &pm660_ftsmps, "vdd_s3_s4" },
+	{ "s5", QCOM_SMD_RPM_RWMX, 0, &pm660_ftsmps, "vdd_s5" },
+	{ "l1", QCOM_SMD_RPM_LDOB, 1, &pm660_nldo660, "vdd_l1_l9_l10" },
+	{ "l2", QCOM_SMD_RPM_LDOB, 2, &pm660_pldo660, "vdd_l2" },
+	{ "l3", QCOM_SMD_RPM_LDOB, 3, &pm660_pldo660, "vdd_l3_l5_l7_l8" },
+	{ "l4", QCOM_SMD_RPM_LDOB, 4, &pm660_pldo660, "vdd_l4_l6" },
+	{ "l5", QCOM_SMD_RPM_LDOB, 5, &pm660_pldo660, "vdd_l3_l5_l7_l8" },
+	{ "l6", QCOM_SMD_RPM_LDOB, 6, &pm660_pldo660, "vdd_l4_l6" },
+	{ "l7", QCOM_SMD_RPM_LDOB, 7, &pm660_pldo660, "vdd_l3_l5_l7_l8" },
+	{ "l8", QCOM_SMD_RPM_LDOB, 8, &pm660_pldo660, "vdd_l3_l5_l7_l8" },
+	{ "l9", QCOM_SMD_RPM_RWLC, 0, &pm660_ht_nldo, "vdd_l1_l9_l10" },
+	{ "l10", QCOM_SMD_RPM_RWLM, 0, &pm660_ht_nldo, "vdd_l1_l9_l10" },
+	{ "bob", QCOM_SMD_RPM_BOBB, 1, &pm660l_bob, "vdd_bob", },
+	{ }
+};
+
 static const struct rpm_regulator_data rpm_pm8226_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8226_hfsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8226_ftsmps, "vdd_s2" },
@@ -1172,54 +1220,6 @@ static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
 	{}
 };
 
-static const struct rpm_regulator_data rpm_pm660_regulators[] = {
-	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm660_ftsmps, "vdd_s1" },
-	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm660_ftsmps, "vdd_s2" },
-	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm660_ftsmps, "vdd_s3" },
-	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm660_hfsmps, "vdd_s4" },
-	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm660_hfsmps, "vdd_s5" },
-	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pm660_hfsmps, "vdd_s6" },
-	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm660_nldo660, "vdd_l1_l6_l7" },
-	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm660_ht_nldo, "vdd_l2_l3" },
-	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm660_nldo660, "vdd_l2_l3" },
-	/* l4 is unaccessible on PM660 */
-	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm660_ht_nldo, "vdd_l5" },
-	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm660_ht_nldo, "vdd_l1_l6_l7" },
-	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm660_ht_nldo, "vdd_l1_l6_l7" },
-	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
-	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
-	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
-	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
-	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
-	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
-	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm660_ht_lvpldo, "vdd_l8_l9_l10_l11_l12_l13_l14" },
-	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
-	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
-	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
-	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
-	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm660_pldo660, "vdd_l15_l16_l17_l18_l19" },
-	{ }
-};
-
-static const struct rpm_regulator_data rpm_pm660l_regulators[] = {
-	{ "s1", QCOM_SMD_RPM_SMPB, 1, &pm660_ftsmps, "vdd_s1" },
-	{ "s2", QCOM_SMD_RPM_SMPB, 2, &pm660_ftsmps, "vdd_s2" },
-	{ "s3", QCOM_SMD_RPM_RWCX, 0, &pm660_ftsmps, "vdd_s3_s4" },
-	{ "s5", QCOM_SMD_RPM_RWMX, 0, &pm660_ftsmps, "vdd_s5" },
-	{ "l1", QCOM_SMD_RPM_LDOB, 1, &pm660_nldo660, "vdd_l1_l9_l10" },
-	{ "l2", QCOM_SMD_RPM_LDOB, 2, &pm660_pldo660, "vdd_l2" },
-	{ "l3", QCOM_SMD_RPM_LDOB, 3, &pm660_pldo660, "vdd_l3_l5_l7_l8" },
-	{ "l4", QCOM_SMD_RPM_LDOB, 4, &pm660_pldo660, "vdd_l4_l6" },
-	{ "l5", QCOM_SMD_RPM_LDOB, 5, &pm660_pldo660, "vdd_l3_l5_l7_l8" },
-	{ "l6", QCOM_SMD_RPM_LDOB, 6, &pm660_pldo660, "vdd_l4_l6" },
-	{ "l7", QCOM_SMD_RPM_LDOB, 7, &pm660_pldo660, "vdd_l3_l5_l7_l8" },
-	{ "l8", QCOM_SMD_RPM_LDOB, 8, &pm660_pldo660, "vdd_l3_l5_l7_l8" },
-	{ "l9", QCOM_SMD_RPM_RWLC, 0, &pm660_ht_nldo, "vdd_l1_l9_l10" },
-	{ "l10", QCOM_SMD_RPM_RWLM, 0, &pm660_ht_nldo, "vdd_l1_l9_l10" },
-	{ "bob", QCOM_SMD_RPM_BOBB, 1, &pm660l_bob, "vdd_bob", },
-	{ }
-};
-
 static const struct rpm_regulator_data rpm_pms405_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pms405_hfsmps3, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pms405_hfsmps3, "vdd_s2" },
@@ -1244,22 +1244,22 @@ static const struct rpm_regulator_data rpm_pms405_regulators[] = {
 
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
+	{ .compatible = "qcom,rpm-pm2250-regulators", .data = &rpm_pm2250_regulators },
+	{ .compatible = "qcom,rpm-pm660-regulators", .data = &rpm_pm660_regulators },
+	{ .compatible = "qcom,rpm-pm660l-regulators", .data = &rpm_pm660l_regulators },
+	{ .compatible = "qcom,rpm-pm8226-regulators", .data = &rpm_pm8226_regulators },
 	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
 	{ .compatible = "qcom,rpm-pm8909-regulators", .data = &rpm_pm8909_regulators },
 	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
-	{ .compatible = "qcom,rpm-pm8226-regulators", .data = &rpm_pm8226_regulators },
 	{ .compatible = "qcom,rpm-pm8941-regulators", .data = &rpm_pm8941_regulators },
 	{ .compatible = "qcom,rpm-pm8950-regulators", .data = &rpm_pm8950_regulators },
 	{ .compatible = "qcom,rpm-pm8953-regulators", .data = &rpm_pm8953_regulators },
 	{ .compatible = "qcom,rpm-pm8994-regulators", .data = &rpm_pm8994_regulators },
 	{ .compatible = "qcom,rpm-pm8998-regulators", .data = &rpm_pm8998_regulators },
-	{ .compatible = "qcom,rpm-pm660-regulators", .data = &rpm_pm660_regulators },
-	{ .compatible = "qcom,rpm-pm660l-regulators", .data = &rpm_pm660l_regulators },
 	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
 	{ .compatible = "qcom,rpm-pmi8994-regulators", .data = &rpm_pmi8994_regulators },
 	{ .compatible = "qcom,rpm-pmi8998-regulators", .data = &rpm_pmi8998_regulators },
 	{ .compatible = "qcom,rpm-pms405-regulators", .data = &rpm_pms405_regulators },
-	{ .compatible = "qcom,rpm-pm2250-regulators", .data = &rpm_pm2250_regulators },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rpm_of_match);
-- 
2.37.1

