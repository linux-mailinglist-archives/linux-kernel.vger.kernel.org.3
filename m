Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4154588411
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiHBWNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiHBWMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:12:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCDE54C8D;
        Tue,  2 Aug 2022 15:11:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id tk8so28283619ejc.7;
        Tue, 02 Aug 2022 15:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0VM1HOfv9+iYeTNizxoVqzafqFFyLv7FBQIAQpN8A8M=;
        b=X3vFz92HvbZbXNePrZtO3EQk+tj2EvZXBLVF8VaxiBgxQjaCszBPntOhDuOvfI5Ub9
         DO4KItT09yguS+54bYemDP0HkRY7b+qkcP1ATh6Rb/ltifXyoi7QxdYuJBW46YoDP2jX
         MGD9sl5yw+sMMKnPyEB23wrlHQphX5C6a2o18zjJyED+cB5sqPhgHZXjbdgNanilFjT4
         JBRQZxlHEHirkcXIzn176XFMzWbNWXGRs3/Qr5MysyUNCXgIoHOu7KVBcA0cgQt2Kukr
         T1AH5e4Cg3B568yyfcaJCWNDxmIZGoWs7F62fGsc3Zxw7+R4kxTKq62UI9Rqy1QQlII3
         5IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0VM1HOfv9+iYeTNizxoVqzafqFFyLv7FBQIAQpN8A8M=;
        b=B1Mk3WpjK0uTLAOv1mEJUcfR+HXqCfVsSyUP0QbVc9Yp5/KhcMDsU0rFlykZD2RhFp
         QG/EM9+UUfvhlT2fJliMt/43ucE0IclycARA8hy2LruLflBn3ZfY+Zf29/zf8R5I3Onl
         ElrQ3fP9w5ERbM9V1+jXFbMIpve/8qj+4QqqOIhTkq3RkFsxR2LdkiRXpE7mx+MegEeR
         vF0dqOcm2iQ7dcjC9gAZQla2mDnO+PKX5DLar0mV2KF9jXaCUFhx5fJLvKlYBiq/3reC
         a3KSEzp9OeJ/nTTTOwyp1c5AguGR2Ebi9aMJq5/VTBYm2l3rCNGfiJvpPskW213j0wxy
         lOyQ==
X-Gm-Message-State: AJIora/xq5qrXeCDmD0aw8dGsqHsIIC9lm+kU75Lpv9PU7fF5J7/37Yh
        gGmJKB5UFYADWWbHZN7kBVs=
X-Google-Smtp-Source: AGRyM1s6R9w+yvTcV8wD9at0ocWq3y0VNWN9gE93o8EyqYuHnm5ak8B1OSGmunID+f8/A6dpakl8PA==
X-Received: by 2002:a17:907:60d1:b0:72f:42a0:f3f9 with SMTP id hv17-20020a17090760d100b0072f42a0f3f9mr18115649ejc.727.1659478314759;
        Tue, 02 Aug 2022 15:11:54 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id ku5-20020a170907788500b007309f007d3asm1190196ejc.128.2022.08.02.15.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:54 -0700 (PDT)
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
Subject: [PATCH v4 11/13] regulator: qcom_smd: Sort pmics alphabetically (part 2)
Date:   Wed,  3 Aug 2022 01:11:10 +0300
Message-Id: <20220802221112.2280686-12-iskren.chernev@gmail.com>
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

