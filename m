Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B109E58197B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiGZSLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbiGZSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:11:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C12A94E;
        Tue, 26 Jul 2022 11:11:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ez10so27464484ejc.13;
        Tue, 26 Jul 2022 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Bfdt9tGdwz/D90+nhlEbJNVS0W0H76UD/uMcWRALzo=;
        b=VRPx07VvNL/tokrOunzwDtEZ5tjpFAuuru2SDPVUY783vgODXoASeE9wwD0FTMaEK6
         HkI0oUUGaw7l4YblVhpoZf6KpPkkZx24c7/Rf62kxbXOaQqeqfHJ45CWs/YRA9+aHHR4
         KYPqbxsEJwQnKm1Ly7QK/YfBxgzDALjknizIUBPwKrOtg0bgj6SIQ68llRXIuC+2nGH/
         FbnHwRBvme45YSvtzB30JFgwRmjbZ2tiffmjw/tKytLwiHBjF1yzmKLGGh+18JjMcMgc
         bB3QSpdlFI1u5Ds9s8vUMJEB6dyAcb0S1plplFwBBtY+1BMPr8ePqsyzHEhmrZRUOc7J
         E5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Bfdt9tGdwz/D90+nhlEbJNVS0W0H76UD/uMcWRALzo=;
        b=4HtnWydOg3grjwxcd69/wJa/18kjJKZO+CSFtnh6Ik4AGmbP0Kjggcr1fsQ9rDpPuR
         m6zDTUHHM/6vYN/Si55sLpkn0cDLA96SFC84Ec1hpShDifuGHgzbR5btBWN1rxdBL9IB
         Xym7GXn5p9GVzvUI919E++jJxfRJidfJkn7qg8QQD8IeWi0m5GnJDZtnkAaXmp4I6iIO
         /eh4KN8UDtJrfVlCGoFWceLJYJyGXAPFuajXymH4qQDEhYxnUq+wbmOrrbAfboF+3Xbw
         N2/CX097NBX+FqySlGZpig7wjSPQwejN5pMm1Ceft1zY393TQYVrLOTFbVTAfdhDoEEU
         E6cw==
X-Gm-Message-State: AJIora/Turqrdu/4h1hnWUBNkXiqKgdH7Sken1/PhTi4JV9aI1yHroZe
        8rCsblfVsCsXKjhxELxo9oZ+NRVFXDtjUQ==
X-Google-Smtp-Source: AGRyM1sCB3HxcxK6liuXCZ4Riv8YDiF53ojaGbccguW6BQ5FPti1twtkmhZ3qscBKpIqr6KgcALdIQ==
X-Received: by 2002:a17:907:b08:b0:72b:1bc8:19e4 with SMTP id h8-20020a1709070b0800b0072b1bc819e4mr15498222ejl.106.1658859102893;
        Tue, 26 Jul 2022 11:11:42 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090622cc00b0072ed72072aesm6735326eja.192.2022.07.26.11.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:11:42 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 3/5] regulator: qcom_spmi: Add support for new regulator types
Date:   Tue, 26 Jul 2022 21:11:31 +0300
Message-Id: <20220726181133.3262695-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726181133.3262695-1-iskren.chernev@gmail.com>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
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

Add support for some regulator types that are missing in this driver, all
belonging to the FTSMPS426 register layout.  This is done in preparation
for adding support for the PM6125 PMIC.

The inspiration for the magic constants was taken from [1]

[1]: https://source.codeaurora.org/quic/la/kernel/msm-5.4/commit/?h=kernel.lnx.5.4.r1-rel&id=d1220daeffaa440ffff0a8c47322eb0033bf54f5

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 123 +++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index a2d0292a92fd..efb3f6fffb4f 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -99,6 +99,9 @@ enum spmi_regulator_logical_type {
 	SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO,
 	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS426,
 	SPMI_REGULATOR_LOGICAL_TYPE_HFS430,
+	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3,
+	SPMI_REGULATOR_LOGICAL_TYPE_LDO_510,
+	SPMI_REGULATOR_LOGICAL_TYPE_HFSMPS,
 };

 enum spmi_regulator_type {
@@ -166,6 +169,17 @@ enum spmi_regulator_subtype {
 	SPMI_REGULATOR_SUBTYPE_HFS430		= 0x0a,
 	SPMI_REGULATOR_SUBTYPE_HT_P150		= 0x35,
 	SPMI_REGULATOR_SUBTYPE_HT_P600		= 0x3d,
+	SPMI_REGULATOR_SUBTYPE_HFSMPS_510	= 0x0a,
+	SPMI_REGULATOR_SUBTYPE_FTSMPS_510	= 0x0b,
+	SPMI_REGULATOR_SUBTYPE_LV_P150_510	= 0x71,
+	SPMI_REGULATOR_SUBTYPE_LV_P300_510	= 0x72,
+	SPMI_REGULATOR_SUBTYPE_LV_P600_510	= 0x73,
+	SPMI_REGULATOR_SUBTYPE_N300_510		= 0x6a,
+	SPMI_REGULATOR_SUBTYPE_N600_510		= 0x6b,
+	SPMI_REGULATOR_SUBTYPE_N1200_510	= 0x6c,
+	SPMI_REGULATOR_SUBTYPE_MV_P50_510	= 0x7a,
+	SPMI_REGULATOR_SUBTYPE_MV_P150_510	= 0x7b,
+	SPMI_REGULATOR_SUBTYPE_MV_P600_510	= 0x7d,
 };

 enum spmi_common_regulator_registers {
@@ -193,6 +207,14 @@ enum spmi_ftsmps426_regulator_registers {
 	SPMI_FTSMPS426_REG_VOLTAGE_ULS_MSB	= 0x69,
 };

+/*
+ * Third common register layout
+ */
+enum spmi_ftsmps3_regulator_registers {
+	SPMI_FTSMPS3_REG_STEP_CTRL		= 0x3c,
+};
+
+
 enum spmi_vs_registers {
 	SPMI_VS_REG_OCP				= 0x4a,
 	SPMI_VS_REG_SOFT_START			= 0x4c,
@@ -260,6 +282,15 @@ enum spmi_common_control_register_index {

 #define SPMI_FTSMPS426_MODE_MASK		0x07

+/* Third common regulator mode register values */
+#define SPMI_FTSMPS3_MODE_BYPASS_MASK		2
+#define SPMI_FTSMPS3_MODE_RETENTION_MASK	3
+#define SPMI_FTSMPS3_MODE_LPM_MASK		4
+#define SPMI_FTSMPS3_MODE_AUTO_MASK		6
+#define SPMI_FTSMPS3_MODE_HPM_MASK		7
+
+#define SPMI_FTSMPS3_MODE_MASK			0x07
+
 /* Common regulator pull down control register layout */
 #define SPMI_COMMON_PULL_DOWN_ENABLE_MASK	0x80

@@ -305,6 +336,9 @@ enum spmi_common_control_register_index {
 #define SPMI_FTSMPS_STEP_MARGIN_NUM	4
 #define SPMI_FTSMPS_STEP_MARGIN_DEN	5

+/* slew_rate has units of uV/us. */
+#define SPMI_FTSMPS3_SLEW_RATE_38p4 38400
+
 #define SPMI_FTSMPS426_STEP_CTRL_DELAY_MASK	0x03
 #define SPMI_FTSMPS426_STEP_CTRL_DELAY_SHIFT	0

@@ -554,6 +588,14 @@ static struct spmi_voltage_range ht_p600_ranges[] = {
 	SPMI_VOLTAGE_RANGE(0, 1704000, 1704000, 1896000, 1896000, 8000),
 };

+static struct spmi_voltage_range nldo_510_ranges[] = {
+	SPMI_VOLTAGE_RANGE(0, 320000, 320000, 1304000, 1304000, 8000),
+};
+
+static struct spmi_voltage_range ftsmps510_ranges[] = {
+	SPMI_VOLTAGE_RANGE(0, 300000, 300000, 1372000, 1372000, 4000),
+};
+
 static DEFINE_SPMI_SET_POINTS(pldo);
 static DEFINE_SPMI_SET_POINTS(nldo1);
 static DEFINE_SPMI_SET_POINTS(nldo2);
@@ -576,6 +618,8 @@ static DEFINE_SPMI_SET_POINTS(ht_nldo);
 static DEFINE_SPMI_SET_POINTS(hfs430);
 static DEFINE_SPMI_SET_POINTS(ht_p150);
 static DEFINE_SPMI_SET_POINTS(ht_p600);
+static DEFINE_SPMI_SET_POINTS(nldo_510);
+static DEFINE_SPMI_SET_POINTS(ftsmps510);

 static inline int spmi_vreg_read(struct spmi_regulator *vreg, u16 addr, u8 *buf,
 				 int len)
@@ -1108,6 +1152,33 @@ spmi_regulator_ftsmps426_set_mode(struct regulator_dev *rdev, unsigned int mode)
 	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_MODE, val, mask);
 }

+static int
+spmi_regulator_ftsmps3_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	u8 mask = SPMI_FTSMPS3_MODE_MASK;
+	u8 val;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = SPMI_FTSMPS3_MODE_HPM_MASK;
+		break;
+	case REGULATOR_MODE_FAST:
+		val = SPMI_FTSMPS3_MODE_AUTO_MASK;
+		break;
+	case REGULATOR_MODE_IDLE:
+		val = vreg->logical_type ==
+				SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3 ?
+			SPMI_FTSMPS3_MODE_RETENTION_MASK :
+			SPMI_FTSMPS3_MODE_LPM_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_MODE, val, mask);
+}
+
 static int
 spmi_regulator_common_set_load(struct regulator_dev *rdev, int load_uA)
 {
@@ -1465,6 +1536,19 @@ static const struct regulator_ops spmi_hfs430_ops = {
 	.get_mode		= spmi_regulator_ftsmps426_get_mode,
 };

+static const struct regulator_ops spmi_ftsmps3_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_voltage_sel	= spmi_regulator_ftsmps426_set_voltage,
+	.set_voltage_time_sel	= spmi_regulator_set_voltage_time_sel,
+	.get_voltage_sel	= spmi_regulator_ftsmps426_get_voltage,
+	.map_voltage		= spmi_regulator_single_map_voltage,
+	.list_voltage		= spmi_regulator_common_list_voltage,
+	.set_mode		= spmi_regulator_ftsmps3_set_mode,
+	.get_mode		= spmi_regulator_ftsmps426_get_mode,
+};
+
 /* Maximum possible digital major revision value */
 #define INF 0xFF

@@ -1473,7 +1557,7 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
 	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
 	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
 	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
-	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
+	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),
 	SPMI_VREG(LDO,   N300,     0, INF, LDO,    ldo,    nldo1,   10000),
 	SPMI_VREG(LDO,   N600,     0,   0, LDO,    ldo,    nldo2,   10000),
 	SPMI_VREG(LDO,   N1200,    0,   0, LDO,    ldo,    nldo2,   10000),
@@ -1549,6 +1633,17 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
 	SPMI_VREG(ULT_LDO, P300,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 10000),
 	SPMI_VREG(ULT_LDO, P150,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 10000),
 	SPMI_VREG(ULT_LDO, P50,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 5000),
+	SPMI_VREG(LDO, LV_P150_510, 0, INF, LDO_510, ftsmps3, ht_lvpldo, 10000),
+	SPMI_VREG(LDO, LV_P300_510, 0, INF, LDO_510, ftsmps3, ht_lvpldo, 10000),
+	SPMI_VREG(LDO, LV_P600_510, 0, INF, LDO_510, ftsmps3, ht_lvpldo, 10000),
+	SPMI_VREG(LDO, MV_P50_510,  0, INF, LDO_510, ftsmps3, pldo660, 10000),
+	SPMI_VREG(LDO, MV_P150_510, 0, INF, LDO_510, ftsmps3, pldo660, 10000),
+	SPMI_VREG(LDO, MV_P600_510, 0, INF, LDO_510, ftsmps3, pldo660, 10000),
+	SPMI_VREG(LDO, N300_510,    0, INF, LDO_510, ftsmps3, nldo_510, 10000),
+	SPMI_VREG(LDO, N600_510,    0, INF, LDO_510, ftsmps3, nldo_510, 10000),
+	SPMI_VREG(LDO, N1200_510,   0, INF, LDO_510, ftsmps3, nldo_510, 10000),
+	SPMI_VREG(BUCK, HFSMPS_510, 4, INF, HFSMPS,  ftsmps3, hfs430, 100000),
+	SPMI_VREG(FTS, FTSMPS_510,  0, INF, FTSMPS3, ftsmps3, ftsmps510, 100000),
 };

 static void spmi_calculate_num_voltages(struct spmi_voltage_set_points *points)
@@ -1696,6 +1791,27 @@ static int spmi_regulator_init_slew_rate_ftsmps426(struct spmi_regulator *vreg,
 	return ret;
 }

+static int spmi_regulator_init_slew_rate_ftsmps3(struct spmi_regulator *vreg)
+{
+	int ret;
+	u8 reg = 0;
+	int delay;
+
+	ret = spmi_vreg_read(vreg, SPMI_FTSMPS3_REG_STEP_CTRL, &reg, 1);
+	if (ret) {
+		dev_err(vreg->dev, "spmi read failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	delay = reg & SPMI_FTSMPS426_STEP_CTRL_DELAY_MASK;
+	delay >>= SPMI_FTSMPS426_STEP_CTRL_DELAY_SHIFT;
+
+
+	vreg->slew_rate = SPMI_FTSMPS3_SLEW_RATE_38p4 >> delay;
+
+	return ret;
+}
+
 static int spmi_regulator_init_registers(struct spmi_regulator *vreg,
 				const struct spmi_regulator_init_data *data)
 {
@@ -1846,6 +1962,11 @@ static int spmi_regulator_of_parse(struct device_node *node,
 		if (ret)
 			return ret;
 		break;
+	case SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3:
+		ret = spmi_regulator_init_slew_rate_ftsmps3(vreg);
+		if (ret)
+			return ret;
+		break;
 	default:
 		break;
 	}
--
2.37.1

