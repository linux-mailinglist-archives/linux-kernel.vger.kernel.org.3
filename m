Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB357369C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiGMMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiGMMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:51:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56D3ED63
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:51:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dn9so19658861ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqWHK6Yyk33dx1tcMFDdwo1FbX9l1ulzWZZtM5OCjfw=;
        b=iE32R9noTVPQSi1sdjYoHbPRtfCp3JNWbqZrqOx3kw2qvmainEK2KrqqQJYRJaW2eU
         izZJaFQIjMKuQw+UVTH1YLI78hiBCopre3HB+zfvSYW1yqRhwsUipedpODOB63aaR4s7
         3xgbZN7g8HSB1JKxrXzIt96/2olgbOtdd/j9qAJiQznsgy8yZHyBiDsSeExKEe+CKGuf
         vlHAnvr6KGMXMJltKN73cEklTR85JFzI7Stns+iGDCBqJFSc6TalYROOOYfEB6ZTJQAf
         rO9XduyUvnw0fX7KKDi3RcxC0HH2k/0qH84DIUaqV/g8wYNo/i7w76qSLBvRTdijBrUP
         wjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqWHK6Yyk33dx1tcMFDdwo1FbX9l1ulzWZZtM5OCjfw=;
        b=6S5umprP8oP11cih/JC7+RHuIHdg0KaU121fE8av7YNEVi5CupGThxS1PjThSqsy+W
         XKfGdj1v7vFxJuXQv2PKEA7Ufl9RTPbMop2co5GtoPgaqhnnBYOedm+OiGAtFFb5T3Sq
         d7w8oWjlU9+5LxlQLKDcs1A/S92eFqNVnnu6viBIL1yY4C+Jbf81G/Liz+tdpIRUDrUV
         TOB51Xe3G+PEb+dgZ/7reyQZ0XJm0Xx8ZoWLMR4bRWAuJ5Exve4vdcTq9CmGKwZrSMJG
         euemACiHSmvauV5b+NAgqCFGz2+m71liGLdRjA7NLA/pTfe2A2T/q8jI/M30Xr8zIN/N
         UjgA==
X-Gm-Message-State: AJIora/Mpw+gJ7NB9J7GrA3x3iTU0r2UlyMFmlNWckeZvv0eYmAzVjYT
        uLjNNl5c7AkEh+6rLc90fCU=
X-Google-Smtp-Source: AGRyM1s8n5o93jOVOC41BNSFpna1hREU+5q946zt0VcHa9z5vnQ1Xtu9sVkHABx9NdzT/9NS4G61MQ==
X-Received: by 2002:a17:906:5055:b0:6ff:1dfb:1e2c with SMTP id e21-20020a170906505500b006ff1dfb1e2cmr3432779ejk.200.1657716669851;
        Wed, 13 Jul 2022 05:51:09 -0700 (PDT)
Received: from PCBABN.skidata.net ([2001:67c:2330:2014:7a45:c4ff:fe0f:c570])
        by smtp.gmail.com with ESMTPSA id s17-20020a056402037100b00437938c731fsm7898593edw.97.2022.07.13.05.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 05:51:08 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH] regulator: da9063: disable unused voltage monitors
Date:   Wed, 13 Jul 2022 14:49:58 +0200
Message-Id: <20220713124958.3094505-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

This enables the kernel to disable the voltage monitor of unused regs.

Some boards might use the PWR_OK functionality, which asserts GP_FB2
if each measured voltage is in-range.
However, if a regulator (which is enabled and monitored) is disabled,
also its voltage monitor must be disabled to keep a valid PWR_OK state.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 51 ++++++++++++++++++++++++++--
 include/linux/mfd/da9063/registers.h | 23 +++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 82f52a2a031a..c0a8c88d9ef6 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -83,6 +83,9 @@ struct da9063_regulator_info {
 
 	/* DA9063 event detection bit */
 	struct reg_field oc_event;
+
+	/* DA9063 voltage monitor bit */
+	struct reg_field vmon;
 };
 
 /* Macros for LDO */
@@ -148,6 +151,7 @@ struct da9063_regulator {
 	struct regmap_field			*suspend;
 	struct regmap_field			*sleep;
 	struct regmap_field			*suspend_sleep;
+	struct regmap_field			*vmon;
 };
 
 /* Encapsulates all information for the regulators driver */
@@ -203,6 +207,24 @@ static const unsigned int da9063_bmem_bio_merged_limits[] = {
 	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
 };
 
+static int da9063_vmon_disable(struct regulator_dev *rdev)
+{
+	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
+
+	return regmap_field_write(regl->vmon, 0);
+}
+
+static int da9063_disable(struct regulator_dev *rdev)
+{
+	int ret;
+
+	ret = da9063_vmon_disable(rdev);
+	if (ret < 0)
+		return ret;
+
+	return regulator_disable_regmap(rdev);
+}
+
 static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
@@ -542,7 +564,7 @@ static int da9063_buck_get_current_limit(struct regulator_dev *rdev)
 
 static const struct regulator_ops da9063_buck_ops = {
 	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
+	.disable		= da9063_disable,
 	.is_enabled		= regulator_is_enabled_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
@@ -560,7 +582,7 @@ static const struct regulator_ops da9063_buck_ops = {
 
 static const struct regulator_ops da9063_ldo_ops = {
 	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
+	.disable		= da9063_disable,
 	.is_enabled		= regulator_is_enabled_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
@@ -581,36 +603,42 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BCORE1_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORE2, 300, 10, 1570,
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE2_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE2),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BCORE2_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BPRO, 530, 10, 1800,
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_B, DA9063_BPRO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPRO),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BPRO_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BMEM_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BIO, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BIO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BIO),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BIO_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BPERI, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_B, DA9063_BPERI_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPERI),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BPERI_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORES_MERGED, 300, 10, 1570,
@@ -618,6 +646,7 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		/* BCORES_MERGED uses the same register fields as BCORE1 */
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BCORE1_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
@@ -625,47 +654,59 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		/* BMEM_BIO_MERGED uses the same register fields as BMEM */
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BMEM_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO3_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO3_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO7, 900, 50, 3600),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO7_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO7_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO8, 900, 50, 3600),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO8_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO8_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_3, DA9063_LDO9_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO11_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_3, DA9063_LDO11_MON_EN),
 	},
 
 	/* The following LDOs are present only on DA9063, not on DA9063L */
 	{
 		DA9063_LDO(DA9063, LDO1, 600, 20, 1860),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO1_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO2, 600, 20, 1860),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO2_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO4, 900, 20, 3440),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO4_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO4_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO5, 900, 50, 3600),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO5_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO6, 900, 50, 3600),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO6_MON_EN),
 	},
 
 	{
 		DA9063_LDO(DA9063, LDO10, 900, 50, 3600),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_3, DA9063_LDO10_MON_EN),
 	},
 };
 
@@ -932,6 +973,12 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 			if (IS_ERR(regl->suspend_sleep))
 				return PTR_ERR(regl->suspend_sleep);
 		}
+		if (regl->info->vmon.reg) {
+			regl->vmon = devm_regmap_field_alloc(&pdev->dev,
+				da9063->regmap, regl->info->vmon);
+			if (IS_ERR(regl->vmon))
+				return PTR_ERR(regl->vmon);
+		}
 
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index 6e0f66a2e727..7b8364bd08a0 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -1040,6 +1040,29 @@
 /* DA9063_REG_CONFIG_J (addr=0x10F) */
 #define DA9063_TWOWIRE_TO			0x40
 
+/* DA9063_REG_MON_REG_2 (addr=0x115) */
+#define DA9063_LDO1_MON_EN			0x01
+#define DA9063_LDO2_MON_EN			0x02
+#define DA9063_LDO3_MON_EN			0x04
+#define DA9063_LDO4_MON_EN			0x08
+#define DA9063_LDO5_MON_EN			0x10
+#define DA9063_LDO6_MON_EN			0x20
+#define DA9063_LDO7_MON_EN			0x40
+#define DA9063_LDO8_MON_EN			0x80
+
+/* DA9063_REG_MON_REG_3 (addr=0x116) */
+#define DA9063_LDO9_MON_EN			0x01
+#define DA9063_LDO10_MON_EN			0x02
+#define DA9063_LDO11_MON_EN			0x04
+
+/* DA9063_REG_MON_REG_4 (addr=0x117) */
+#define DA9063_BCORE1_MON_EN			0x04
+#define DA9063_BCORE2_MON_EN			0x08
+#define DA9063_BPRO_MON_EN			0x10
+#define DA9063_BIO_MON_EN			0x20
+#define DA9063_BMEM_MON_EN			0x40
+#define DA9063_BPERI_MON_EN			0x80
+
 /* DA9063_REG_MON_REG_5 (addr=0x116) */
 #define DA9063_MON_A8_IDX_MASK			0x07
 #define		DA9063_MON_A8_IDX_NONE		0x00
-- 
2.34.1

