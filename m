Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EFE52C2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbiERSsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbiERSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:48:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC2229FDB;
        Wed, 18 May 2022 11:48:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i19so5479664eja.11;
        Wed, 18 May 2022 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpQYDqqTMKvAHgyQOKIaDAZVZin4gTd/M2O8Q7thQ0s=;
        b=C/g80f+yE3wm8L1b/YcCR4YzUOOkxD/a4V12I0qORZyUVQsw4dCO2psu4vvIJcZjWG
         u6WEvf1fpJ1pGSit3uA/oUghm/6O9vQvtZRUSUj/XTMf4mDUxltk/wZ6z+uR/JqobWco
         88PGqJ5heWSoFmnKnuTZCb/bTuzCSCYPeexK9gwud9o1+yozPpXIQgzQfSRSTKYJCdz6
         WJk0WkJZZhCdg1/btK+Gt1Yx7gXOVzGajaqlumuhK1IuBO7pbN9+Mpj3CE2qvUP7B2YV
         O6Gj4pPqQq4IhE7a1q7zilPb/oFgTELXwDEp5mMC/8sGkLaauojcJ4+73RmgYmsF4Kmq
         8SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpQYDqqTMKvAHgyQOKIaDAZVZin4gTd/M2O8Q7thQ0s=;
        b=FrgWnTNabD/KVbQocSWEx7d8betuXldebv5lq1qsRZmOnKDzn4WsE47XaPPpzB3Y1i
         yoT/gF9My6j30ZdFkdnI3naBrQZHU/DxdFKhDU1n+79SG4PH+aaT+NyI5QPZvEO0gxtm
         HHpzrsBFzVkrwgYm6HyOY2vgFrEyTdzo94E55VgLzLi4WwUfNZGizjZl6l2LUTvkIleL
         kvhQUDH1Jg9l/lcwtj54gGUmIABW+DofMxJIf+yRp/8sOVQq1W1w4k8KAiLFYwVOJOsK
         x0Hnryl1O5aoVwS2AAvW0fF3DJtphnvm3iBJc5Fk9kirm9WlzEqK+0sH7sNOKLrl6ebZ
         p05g==
X-Gm-Message-State: AOAM533R/h4lm9xfOlJEG1/B760pKWUQxjmtRO8c6TxDHF5McUIdoL3a
        VD6CgV8qkvHEtVxui++Odc0=
X-Google-Smtp-Source: ABdhPJwoNQj/GqGAIrPTIuqi2EISFzwVV3g0nRMP/jCZJcNPAXcKEcA6MWcvr7wgllAJxCEHoeXPqw==
X-Received: by 2002:a17:907:1c21:b0:6f4:7a8a:d6a2 with SMTP id nc33-20020a1709071c2100b006f47a8ad6a2mr904546ejc.288.1652899712819;
        Wed, 18 May 2022 11:48:32 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id q18-20020aa7cc12000000b0042aa40e76cbsm1702662edt.80.2022.05.18.11.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:48:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 5/6] regulator: qcom_spmi: Add support for PMP8074 regulators
Date:   Wed, 18 May 2022 20:48:24 +0200
Message-Id: <20220518184825.1034976-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518184825.1034976-1-robimarko@gmail.com>
References: <20220518184825.1034976-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMP8074 is a companion PMIC for the Qualcomm IPQ8074 WiSoC-s.

It features 5 HF-SMPS and 13 LDO regulators.

HF-SMPS regulators are Buck HFS430 regulators.
L1, L2 and L3 are HT_N1200_ST subtype LDO regulators.
L4 is HT_N300_ST subtype LDO regulator.
L5 and L6 are HT_P600 subtype LDO regulators.
L7, L11, L12 and L13 are HT_P150 subtype LDO regulators.
L10 is HT_P50 subtype LDO regulator.

This commit adds support for all of the buck regulators and LDO-s except
for L10 as I dont have documentation on its output voltage range.

S3 is the CPU cluster voltage supply, S4 supplies the UBI32 NPU cores
and L11 is the SDIO/eMMC I/O voltage regulator required for high speeds.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v4:
* Add remaining regulators, minus L11
* Sort structure and compatible
---
 drivers/regulator/qcom_spmi-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index ad9ad9f4be8e..a2d0292a92fd 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2139,6 +2139,28 @@ static const struct spmi_regulator_data pm8005_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pmp8074_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1"},
+	{ "s2", 0x1700, "vdd_s2"},
+	{ "s3", 0x1a00, "vdd_s3"},
+	{ "s4", 0x1d00, "vdd_s4"},
+	{ "s5", 0x2000, "vdd_s5"},
+	{ "l1", 0x4000, "vdd_l1_l2"},
+	{ "l2", 0x4100, "vdd_l1_l2"},
+	{ "l3", 0x4200, "vdd_l3_l8"},
+	{ "l4", 0x4300, "vdd_l4"},
+	{ "l5", 0x4400, "vdd_l5_l6_l15"},
+	{ "l6", 0x4500, "vdd_l5_l6_l15"},
+	{ "l7", 0x4600, "vdd_l7"},
+	{ "l8", 0x4700, "vdd_l3_l8"},
+	{ "l9", 0x4800, "vdd_l9"},
+	/* l10 is currently unsupported HT_P50 */
+	{ "l11", 0x4a00, "vdd_l10_l11_l12_l13"},
+	{ "l12", 0x4b00, "vdd_l10_l11_l12_l13"},
+	{ "l13", 0x4c00, "vdd_l10_l11_l12_l13"},
+	{ }
+};
+
 static const struct spmi_regulator_data pms405_regulators[] = {
 	{ "s3", 0x1a00, "vdd_s3"},
 	{ }
@@ -2156,6 +2178,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pmi8994-regulators", .data = &pmi8994_regulators },
 	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
 	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
+	{ .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },
 	{ .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
 	{ }
 };
-- 
2.36.1

