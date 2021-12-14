Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221BC47442A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhLNOAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:00:39 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:1414 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234667AbhLNOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:00:31 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEAdVUP003487;
        Tue, 14 Dec 2021 08:00:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=j3V8+JWRmfRTTdDyMQCIL0LOWiyWdzd/3mbfnljnCVY=;
 b=l9jZuFXhLJOI4FwPtOAyV/cxBhZwOqK6Vv82K1V5sVu75B5zRVi/lPO6PpPYOjYWwdfL
 tsmVYTy6MOl4Kk5IFjS8QgdpH11igT50ThiI1j9UvWjRdnrPIdcDhLw++QQeeZjgOWfA
 CKyqblEuOD7vZjSFEMvnLkF7XQq+PyX3sgmCkQ0OFlHrcVvDZvsrhBelNeA8jn3Z6Ect
 q8N3Ob6ItAMS/dQywzUUP/H52NCu4nGe9IVaUXGSLE6J6gW59Eb+PtbaJneO9W4AjMov
 mPLJoY2up39SgjeS/1dj6WhXqe1Vgdc2k4U/yWiJMDn/s2is40uPWrtlJGv86lWjN97i RQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cxe2f0uq1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Dec 2021 08:00:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 14:00:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 14 Dec 2021 14:00:02 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3BBCAB13;
        Tue, 14 Dec 2021 14:00:02 +0000 (UTC)
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
Subject: [PATCH v4 04/10] ASoC: cs35l41: Create shared function for errata patches
Date:   Tue, 14 Dec 2021 13:59:53 +0000
Message-ID: <20211214135959.1317949-5-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
References: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4bloYUJRujw5CEQ2JcdSXWq9m5KU5I32
X-Proofpoint-GUID: 4bloYUJRujw5CEQ2JcdSXWq9m5KU5I32
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC and HDA systems require the same errata patches, so
move it to the shared code using a function the correctly
applies the patches by revision

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  1 +
 sound/soc/codecs/cs35l41-lib.c | 88 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 89 ++--------------------------------
 3 files changed, 92 insertions(+), 86 deletions(-)

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
index 1387553afd3c..035d311d336a 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -658,6 +658,60 @@ static const struct cs35l41_otp_packed_element_t otp_map_2[CS35L41_NUM_OTP_ELEM]
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
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
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
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
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
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
+};
+
 static const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[] = {
 	{
 		.id = 0x01,
@@ -844,6 +898,40 @@ int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_GPL(cs35l41_otp_unpack);
 
+int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsigned int reg_revid)
+{
+	int ret = 0;
+	char *rev;
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
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l41_register_errata_patch);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 4ed7490cab95..afc10f7ca65e 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1271,60 +1271,6 @@ static int cs35l41_handle_pdata(struct device *dev,
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
-	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
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
-	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
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
-	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
-	{ CS35L41_PWR_CTRL2,		 0x00000000 },
-	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
-};
-
 static const struct reg_sequence cs35l41_fs_errata_patch[] = {
 	{ CS35L41_DSP1_RX1_RATE,	0x00000001 },
 	{ CS35L41_DSP1_RX2_RATE,	0x00000001 },
@@ -1504,38 +1450,9 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
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
 
-- 
2.34.1

