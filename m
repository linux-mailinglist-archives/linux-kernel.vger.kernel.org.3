Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2415B52D412
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiESNau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiESNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:30:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF5CCEB99;
        Thu, 19 May 2022 06:30:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c12so6966808eds.10;
        Thu, 19 May 2022 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpQYDqqTMKvAHgyQOKIaDAZVZin4gTd/M2O8Q7thQ0s=;
        b=KQAOvZ8mR+QYcwZPfx2ifx2cf3gdrDghVsHNnNA4rF6Xxl7UGpNCi0ura6e47DnVjJ
         sAEWBgPJMunZziZosiW0A/c/jMeFrzeNd/yu1OUG6y3n+g11Pzq+8lk7f2wPEpRhY8DR
         W0s9Ag3uDIK7N2bbY5MPT+oMC5Jq8uGsRR5OaJap8XVoBhr6Rya0dvC2FMHFgW8JCxcC
         W+RDhMBoPaa1P41+ZlgetegSYBhbqJiSlEBHcvNhHhXgMJDqlh/zsvrbS8a7p/nRx/pP
         sY5rEkXMvnHY2PJXj9y5CNg5lZO88ziC1fFwGk6X75OY1jzGWmBtEjnUHjDn4LoFeP2s
         PZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpQYDqqTMKvAHgyQOKIaDAZVZin4gTd/M2O8Q7thQ0s=;
        b=cvTYM+86gpe2k0RkTVy3WepkD3qn2Daj5cXWNpuzJD1maXSDJWfJwXCJwEwl9RsFcq
         2PLO7usSvSR7c16tJ5E7071D2Ho/pCnneSUGj9+vMVZSvRewTAvDtyuL4QiRkrICzKFp
         cGnu/doVLpY33JjJp7FrqyX1FHqyAGUvVuyAgIYjQe0BMtZE+fDl298yoSS4KWH8EtWU
         5GWkN4q9KxYB5mPy2TrN3+qJvU5G4no/y4nRTXpHytvGm3gTUgwcJ+nS8sb9EzhhJbly
         QnvMBIBJGafcQfgobfaNZEZbJTaGlpWV2CjSu1PADqOPznbDGhx1oibmxIWmTEZCr64p
         KDuw==
X-Gm-Message-State: AOAM533tOsza8Cl5Bie8izrXj0riuo/s/LmwXvldw/nxHZTvEKbUkZuG
        +R6opTaIpCfpi9qNLR1Ruvs=
X-Google-Smtp-Source: ABdhPJzQGVvEHrjDwozA9/bS9X1RUoku0kFYDCzF8VQfQ/nnkyDaM7G+d3t8lcF1iJcXM/rfPwEOpQ==
X-Received: by 2002:a05:6402:51c8:b0:427:b374:6af4 with SMTP id r8-20020a05640251c800b00427b3746af4mr5258073edd.349.1652967023981;
        Thu, 19 May 2022 06:30:23 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-71.zg.cable.xnet.hr. [94.253.165.71])
        by smtp.googlemail.com with ESMTPSA id y17-20020a17090614d100b006f3ef214dd4sm2120383ejc.58.2022.05.19.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:30:23 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 5/7] regulator: qcom_spmi: add support for PMP8074 regulators
Date:   Thu, 19 May 2022 15:30:13 +0200
Message-Id: <20220519133015.484639-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519133015.484639-1-robimarko@gmail.com>
References: <20220519133015.484639-1-robimarko@gmail.com>
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

