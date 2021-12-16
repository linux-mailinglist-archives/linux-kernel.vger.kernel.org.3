Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5574770E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhLPLoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:44:17 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:19460 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233748AbhLPLoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:44:07 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG6WwLm019726;
        Thu, 16 Dec 2021 05:43:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=P95jRnxTNpTTnBxEgj64aqh6RHhx6DAfvOrgb1F9Zu0=;
 b=JrLtQ37pJ1LxkGVuwN/uqsdnnW34BL6N8lL8boHJW/5HJEtQmlhLLt4xD4aEnhz4tsp/
 ksvpC32Qm86AruH9uL0u17Q4WLPoSBeCIEnZUBa4SpnryJUIEk0z3QCB6PHjD6+rqlKu
 TyQ+DarT4PRcEjkImHgOYSgyyoY/Syd1b1hJK8jhVyfhhf7IQQg8tNTYCedusFaCTFPR
 xgia6jHn/iUuWhV+jTSsh71eadg69so3KJ9kI7RpVfaSrec7hWJObkZnoz/6Zy4diJd4
 G9pnYhgSN2C+DewSJ4IwrqPLcWaO7Gl2BMi7EVUkRvjPT04PntDtuidlzDrYhNCJ/lum rA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc110q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 05:43:39 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:43:37 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 16 Dec 2021 11:43:37 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B558E45D;
        Thu, 16 Dec 2021 11:43:36 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v5 04/10] ASoC: cs35l41: Create shared function for errata patches
Date:   Thu, 16 Dec 2021 11:43:26 +0000
Message-ID: <20211216114332.153409-5-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
References: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yUWwipG6f3dD-Kz_JiMnm7YLEWMMiiaL
X-Proofpoint-ORIG-GUID: yUWwipG6f3dD-Kz_JiMnm7YLEWMMiiaL
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC and HDA systems require the same errata patches, so
move it to the shared code using a function the correctly
applies the patches by revision

Also, move CS35L41_DSP1_CCM_CORE_CTRL write to errata
patch function as is required to be written at boot,
but not in regmap_register_patch sequence as will affect
waking up from hibernation

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  1 +
 sound/soc/codecs/cs35l41-lib.c | 89 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 92 ++--------------------------------
 3 files changed, 93 insertions(+), 89 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 6cf3ef02b26a..ad2e32a12b8c 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -763,5 +763,6 @@ extern struct regmap_config cs35l41_regmap_i2c;
 extern struct regmap_config cs35l41_regmap_spi;
 
 int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap);
+int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsigned int reg_revid);
 
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index b3567e10adc4..5e382eaea340 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -659,6 +659,57 @@ static const struct cs35l41_otp_packed_element_t otp_map_2[CS35L41_NUM_OTP_ELEM]
 	{ 0x00017044,	0,	24 }, /*LOT_NUMBER*/
 };
 
+static const struct reg_sequence cs35l41_reva0_errata_patch[] = {
+	{ 0x00000040,			 0x00005555 },
+	{ 0x00000040,			 0x0000AAAA },
+	{ 0x00003854,			 0x05180240 },
+	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
+	{ 0x00004310,			 0x00000000 },
+	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
+	{ CS35L41_OTP_TRIM_30,		 0x9091A1C8 },
+	{ 0x00003014,			 0x0200EE0E },
+	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
+	{ 0x00000054,			 0x00000004 },
+	{ CS35L41_IRQ1_DB3,		 0x00000000 },
+	{ CS35L41_IRQ2_DB3,		 0x00000000 },
+	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
+	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
+	{ 0x00000040,			 0x0000CCCC },
+	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
+};
+
+static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
+	{ 0x00000040,			 0x00005555 },
+	{ 0x00000040,			 0x0000AAAA },
+	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
+	{ 0x00004310,			 0x00000000 },
+	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
+	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
+	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
+	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
+	{ 0x00000040,			 0x0000CCCC },
+	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
+};
+
+static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
+	{ 0x00000040,			 0x00005555 },
+	{ 0x00000040,			 0x0000AAAA },
+	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
+	{ 0x00004310,			 0x00000000 },
+	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
+	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
+	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
+	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
+	{ 0x00000040,			 0x0000CCCC },
+	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
+};
+
 static const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[] = {
 	{
 		.id = 0x01,
@@ -845,6 +896,44 @@ int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_GPL(cs35l41_otp_unpack);
 
+int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsigned int reg_revid)
+{
+	char *rev;
+	int ret;
+
+	switch (reg_revid) {
+	case CS35L41_REVID_A0:
+		ret = regmap_register_patch(reg, cs35l41_reva0_errata_patch,
+					    ARRAY_SIZE(cs35l41_reva0_errata_patch));
+		rev = "A0";
+		break;
+	case CS35L41_REVID_B0:
+		ret = regmap_register_patch(reg, cs35l41_revb0_errata_patch,
+					    ARRAY_SIZE(cs35l41_revb0_errata_patch));
+		rev = "B0";
+		break;
+	case CS35L41_REVID_B2:
+		ret = regmap_register_patch(reg, cs35l41_revb2_errata_patch,
+					    ARRAY_SIZE(cs35l41_revb2_errata_patch));
+		rev = "B2";
+		break;
+	default:
+		ret = -EINVAL;
+		rev = "XX";
+		break;
+	}
+
+	if (ret)
+		dev_err(dev, "Failed to apply %s errata patch: %d\n", rev, ret);
+
+	ret = regmap_write(reg, CS35L41_DSP1_CCM_CORE_CTRL, 0);
+	if (ret < 0)
+		dev_err(dev, "Write CCM_CORE_CTRL failed: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l41_register_errata_patch);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 7494710ae6e6..afc10f7ca65e 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1271,57 +1271,6 @@ static int cs35l41_handle_pdata(struct device *dev,
 	return 0;
 }
 
-static const struct reg_sequence cs35l41_reva0_errata_patch[] = {
-	{ 0x00000040,			 0x00005555 },
-	{ 0x00000040,			 0x0000AAAA },
-	{ 0x00003854,			 0x05180240 },
-	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
-	{ 0x00004310,			 0x00000000 },
-	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
-	{ CS35L41_OTP_TRIM_30,		 0x9091A1C8 },
-	{ 0x00003014,			 0x0200EE0E },
-	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
-	{ 0x00000054,			 0x00000004 },
-	{ CS35L41_IRQ1_DB3,		 0x00000000 },
-	{ CS35L41_IRQ2_DB3,		 0x00000000 },
-	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
-	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
-	{ 0x00000040,			 0x0000CCCC },
-	{ 0x00000040,			 0x00003333 },
-	{ CS35L41_PWR_CTRL2,		 0x00000000 },
-	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
-};
-
-static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
-	{ 0x00000040,			 0x00005555 },
-	{ 0x00000040,			 0x0000AAAA },
-	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
-	{ 0x00004310,			 0x00000000 },
-	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
-	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
-	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
-	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
-	{ 0x00000040,			 0x0000CCCC },
-	{ 0x00000040,			 0x00003333 },
-	{ CS35L41_PWR_CTRL2,		 0x00000000 },
-	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
-};
-
-static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
-	{ 0x00000040,			 0x00005555 },
-	{ 0x00000040,			 0x0000AAAA },
-	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
-	{ 0x00004310,			 0x00000000 },
-	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
-	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
-	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
-	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
-	{ 0x00000040,			 0x0000CCCC },
-	{ 0x00000040,			 0x00003333 },
-	{ CS35L41_PWR_CTRL2,		 0x00000000 },
-	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
-};
-
 static const struct reg_sequence cs35l41_fs_errata_patch[] = {
 	{ CS35L41_DSP1_RX1_RATE,	0x00000001 },
 	{ CS35L41_DSP1_RX2_RATE,	0x00000001 },
@@ -1501,38 +1450,9 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		goto err;
 	}
 
-	switch (reg_revid) {
-	case CS35L41_REVID_A0:
-		ret = regmap_register_patch(cs35l41->regmap,
-					    cs35l41_reva0_errata_patch,
-					    ARRAY_SIZE(cs35l41_reva0_errata_patch));
-		if (ret < 0) {
-			dev_err(cs35l41->dev,
-				"Failed to apply A0 errata patch: %d\n", ret);
-			goto err;
-		}
-		break;
-	case CS35L41_REVID_B0:
-		ret = regmap_register_patch(cs35l41->regmap,
-					    cs35l41_revb0_errata_patch,
-					    ARRAY_SIZE(cs35l41_revb0_errata_patch));
-		if (ret < 0) {
-			dev_err(cs35l41->dev,
-				"Failed to apply B0 errata patch: %d\n", ret);
-			goto err;
-		}
-		break;
-	case CS35L41_REVID_B2:
-		ret = regmap_register_patch(cs35l41->regmap,
-					    cs35l41_revb2_errata_patch,
-					    ARRAY_SIZE(cs35l41_revb2_errata_patch));
-		if (ret < 0) {
-			dev_err(cs35l41->dev,
-				"Failed to apply B2 errata patch: %d\n", ret);
-			goto err;
-		}
-		break;
-	}
+	ret = cs35l41_register_errata_patch(cs35l41->dev, cs35l41->regmap, reg_revid);
+	if (ret)
+		goto err;
 
 	irq_pol = cs35l41_irq_gpio_config(cs35l41);
 
@@ -1556,12 +1476,6 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		goto err;
 	}
 
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_CCM_CORE_CTRL, 0);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write CCM_CORE_CTRL failed: %d\n", ret);
-		goto err;
-	}
-
 	ret = cs35l41_set_pdata(cs35l41);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Set pdata failed: %d\n", ret);
-- 
2.34.1

