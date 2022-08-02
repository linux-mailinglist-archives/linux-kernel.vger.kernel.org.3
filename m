Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305C7588402
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiHBWMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiHBWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30F45989;
        Tue,  2 Aug 2022 15:11:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kb8so13731037ejc.4;
        Tue, 02 Aug 2022 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3gLPDlgurgQ7MMMGOVoKiB/i9v0oFQOpPrsP4Tdj2gs=;
        b=k7hXiyMmP5JKokHhFYCzKWGbXD49V7R0DFQf4JEZbj2nOiMoKpYml362ZBRVPThna7
         PmJkgmbNO9HNhI2DQR1Ej0hcFhagE/zgKrD9S7eD7hRincnRpma6jJNuHAgFi27M4dTa
         9ZRCBjJGJSOQrk+YKT26ZWX8HRJzOyOgvE9p1D7RZ7Azf4FQY8+FS8d96gkBXpXsOQJJ
         i5/TIF3FTXU5ZbuFrtI0vOaU5Ea1lCaq8ZaAcc6T0bSCczmJRvcLMKgC4vXeOGA3nESG
         YFhggHvpTfMH4lmxCYAkTd62uXSIhgm58nwfFAGXzR/RiE5S+794NQC3JVm9b2TL0xF+
         LTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3gLPDlgurgQ7MMMGOVoKiB/i9v0oFQOpPrsP4Tdj2gs=;
        b=uRZZv7OGOW1bIzY7cuSYFWQghgSemUuwyzG9RZq1AtoZEoSb2B4+oJ+P3Nq3RF5K0V
         J58oOT4K15vfgDtRdHiniBHIyU6NzU4A+uB9TOaN9K/8+PRKBtxEn88UC507X+HemCEZ
         NWtnJpRfxmRtI4gnKeuE1ER9v4pTeunywyUumtPplc0UPSw4oqTubAK55hHbeOi+NCj/
         V8ogx17GhzrkJBlDulboxzDGgnirElCokc8M8GZ6yh3StNo+cl93MPwaxKXivCph+4/b
         rXeJe4l7XBwbfLfpUMgLyyVlUlUOlFFZkM2bS42aT4V/uMTjlYWbRoasmjor+tsrANSj
         jTRg==
X-Gm-Message-State: AJIora9SQfI3Z5WBUs+pw+dV1p+iSV9D42VZwO8WWqnHNO7xdVj0sADT
        pEWk8fMk4Oslb/+yykEQhtyqVy4K8n9PQDDf
X-Google-Smtp-Source: AGRyM1sgvqLrw8nqvVUuM4+9kWI2qB3dmJDEa8Ba8n7rqUeUdNdncmjRrjcTC5cVuG3lO9KYgoG7lg==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id nd23-20020a170907629700b0072f9aad0fcbmr17566433ejc.161.1659478301166;
        Tue, 02 Aug 2022 15:11:41 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709061c0f00b0070e238ff66fsm6654924ejg.96.2022.08.02.15.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:40 -0700 (PDT)
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
Subject: [PATCH v4 05/13] regulator: qcom_spmi: Add support for HFSMPS regulator type
Date:   Wed,  3 Aug 2022 01:11:04 +0300
Message-Id: <20220802221112.2280686-6-iskren.chernev@gmail.com>
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

This is preparation for supporing PM6125.

The HFSMPS is a BUCK type regulator with subtype 0x0a, same as the
existing HFS430 regulator.

Even though the HFSMPS and HFS430 share a type and subtype, the HFSMPS has
an updated register map, including different mode values, moved pull down
register, and different slew rate address and formula.

In addition to NORMAL (NPM), FAST (AUTO_LPM) and IDLE (LPM), the
regulator also supports RETENTION and AUTO_RM which are currently
unselectable by the driver.

The inspiration of this is taken from [1].

[1] https://source.codeaurora.org/quic/la/kernel/msm-5.4/commit/?h=kernel.lnx.5.4.r1-rel&id=d1220daeffaa440ffff0a8c47322eb0033bf54f5

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 115 +++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index a2d0292a92fd..04e9845a9300 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -99,6 +99,7 @@ enum spmi_regulator_logical_type {
 	SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO,
 	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS426,
 	SPMI_REGULATOR_LOGICAL_TYPE_HFS430,
+	SPMI_REGULATOR_LOGICAL_TYPE_HFSMPS,
 };
 
 enum spmi_regulator_type {
@@ -166,6 +167,7 @@ enum spmi_regulator_subtype {
 	SPMI_REGULATOR_SUBTYPE_HFS430		= 0x0a,
 	SPMI_REGULATOR_SUBTYPE_HT_P150		= 0x35,
 	SPMI_REGULATOR_SUBTYPE_HT_P600		= 0x3d,
+	SPMI_REGULATOR_SUBTYPE_HFSMPS_510	= 0x0a,
 };
 
 enum spmi_common_regulator_registers {
@@ -193,6 +195,14 @@ enum spmi_ftsmps426_regulator_registers {
 	SPMI_FTSMPS426_REG_VOLTAGE_ULS_MSB	= 0x69,
 };
 
+/*
+ * Third common register layout
+ */
+enum spmi_hfsmps_regulator_registers {
+	SPMI_HFSMPS_REG_STEP_CTRL		= 0x3c,
+	SPMI_HFSMPS_REG_PULL_DOWN		= 0xa0,
+};
+
 enum spmi_vs_registers {
 	SPMI_VS_REG_OCP				= 0x4a,
 	SPMI_VS_REG_SOFT_START			= 0x4c,
@@ -260,6 +270,15 @@ enum spmi_common_control_register_index {
 
 #define SPMI_FTSMPS426_MODE_MASK		0x07
 
+/* Third common regulator mode register values */
+#define SPMI_HFSMPS_MODE_BYPASS_MASK		2
+#define SPMI_HFSMPS_MODE_RETENTION_MASK		3
+#define SPMI_HFSMPS_MODE_LPM_MASK		4
+#define SPMI_HFSMPS_MODE_AUTO_MASK		6
+#define SPMI_HFSMPS_MODE_HPM_MASK		7
+
+#define SPMI_HFSMPS_MODE_MASK			0x07
+
 /* Common regulator pull down control register layout */
 #define SPMI_COMMON_PULL_DOWN_ENABLE_MASK	0x80
 
@@ -305,6 +324,9 @@ enum spmi_common_control_register_index {
 #define SPMI_FTSMPS_STEP_MARGIN_NUM	4
 #define SPMI_FTSMPS_STEP_MARGIN_DEN	5
 
+/* slew_rate has units of uV/us. */
+#define SPMI_HFSMPS_SLEW_RATE_38p4 38400
+
 #define SPMI_FTSMPS426_STEP_CTRL_DELAY_MASK	0x03
 #define SPMI_FTSMPS426_STEP_CTRL_DELAY_SHIFT	0
 
@@ -1062,6 +1084,23 @@ static unsigned int spmi_regulator_ftsmps426_get_mode(struct regulator_dev *rdev
 	}
 }
 
+static unsigned int spmi_regulator_hfsmps_get_mode(struct regulator_dev *rdev)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	u8 reg;
+
+	spmi_vreg_read(vreg, SPMI_COMMON_REG_MODE, &reg, 1);
+
+	switch (reg) {
+	case SPMI_HFSMPS_MODE_HPM_MASK:
+		return REGULATOR_MODE_NORMAL;
+	case SPMI_HFSMPS_MODE_AUTO_MASK:
+		return REGULATOR_MODE_FAST;
+	default:
+		return REGULATOR_MODE_IDLE;
+	}
+}
+
 static int
 spmi_regulator_common_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
@@ -1108,6 +1147,30 @@ spmi_regulator_ftsmps426_set_mode(struct regulator_dev *rdev, unsigned int mode)
 	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_MODE, val, mask);
 }
 
+static int
+spmi_regulator_hfsmps_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	u8 mask = SPMI_HFSMPS_MODE_MASK;
+	u8 val;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = SPMI_HFSMPS_MODE_HPM_MASK;
+		break;
+	case REGULATOR_MODE_FAST:
+		val = SPMI_HFSMPS_MODE_AUTO_MASK;
+		break;
+	case REGULATOR_MODE_IDLE:
+		val = SPMI_HFSMPS_MODE_LPM_MASK;
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
@@ -1131,6 +1194,15 @@ static int spmi_regulator_common_set_pull_down(struct regulator_dev *rdev)
 				     mask, mask);
 }
 
+static int spmi_regulator_hfsmps_set_pull_down(struct regulator_dev *rdev)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	unsigned int mask = SPMI_COMMON_PULL_DOWN_ENABLE_MASK;
+
+	return spmi_vreg_update_bits(vreg, SPMI_HFSMPS_REG_PULL_DOWN,
+				     mask, mask);
+}
+
 static int spmi_regulator_common_set_soft_start(struct regulator_dev *rdev)
 {
 	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
@@ -1465,6 +1537,21 @@ static const struct regulator_ops spmi_hfs430_ops = {
 	.get_mode		= spmi_regulator_ftsmps426_get_mode,
 };
 
+static const struct regulator_ops spmi_hfsmps_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_voltage_sel	= spmi_regulator_ftsmps426_set_voltage,
+	.set_voltage_time_sel	= spmi_regulator_set_voltage_time_sel,
+	.get_voltage_sel	= spmi_regulator_ftsmps426_get_voltage,
+	.map_voltage		= spmi_regulator_single_map_voltage,
+	.list_voltage		= spmi_regulator_common_list_voltage,
+	.set_mode		= spmi_regulator_hfsmps_set_mode,
+	.get_mode		= spmi_regulator_hfsmps_get_mode,
+	.set_load		= spmi_regulator_common_set_load,
+	.set_pull_down		= spmi_regulator_hfsmps_set_pull_down,
+};
+
 /* Maximum possible digital major revision value */
 #define INF 0xFF
 
@@ -1473,7 +1560,8 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
 	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
 	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
 	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
-	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
+	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),
+	SPMI_VREG(BUCK,  HFSMPS_510, 4, INF, HFSMPS, hfsmps, hfs430, 100000),
 	SPMI_VREG(LDO,   N300,     0, INF, LDO,    ldo,    nldo1,   10000),
 	SPMI_VREG(LDO,   N600,     0,   0, LDO,    ldo,    nldo2,   10000),
 	SPMI_VREG(LDO,   N1200,    0,   0, LDO,    ldo,    nldo2,   10000),
@@ -1696,6 +1784,26 @@ static int spmi_regulator_init_slew_rate_ftsmps426(struct spmi_regulator *vreg,
 	return ret;
 }
 
+static int spmi_regulator_init_slew_rate_hfsmps(struct spmi_regulator *vreg)
+{
+	int ret;
+	u8 reg = 0;
+	int delay;
+
+	ret = spmi_vreg_read(vreg, SPMI_HFSMPS_REG_STEP_CTRL, &reg, 1);
+	if (ret) {
+		dev_err(vreg->dev, "spmi read failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	delay = reg & SPMI_FTSMPS426_STEP_CTRL_DELAY_MASK;
+	delay >>= SPMI_FTSMPS426_STEP_CTRL_DELAY_SHIFT;
+
+	vreg->slew_rate = SPMI_HFSMPS_SLEW_RATE_38p4 >> delay;
+
+	return ret;
+}
+
 static int spmi_regulator_init_registers(struct spmi_regulator *vreg,
 				const struct spmi_regulator_init_data *data)
 {
@@ -1846,6 +1954,11 @@ static int spmi_regulator_of_parse(struct device_node *node,
 		if (ret)
 			return ret;
 		break;
+	case SPMI_REGULATOR_LOGICAL_TYPE_HFSMPS:
+		ret = spmi_regulator_init_slew_rate_hfsmps(vreg);
+		if (ret)
+			return ret;
+		break;
 	default:
 		break;
 	}
-- 
2.37.1

