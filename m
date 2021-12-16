Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384A477104
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhLPLrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:47:24 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:61708 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230030AbhLPLrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:47:22 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG6WwLo019726;
        Thu, 16 Dec 2021 05:43:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=phtIJUYnNg6/fKgTeaUUVdx/g4sHBq3AbZNhZEFGScU=;
 b=bYVItV1eWQNERZ7P87mOiHy9xlF9XTR1dQR9NwVSNn77PucbnLUGVNgxEkfjntFfejn+
 e4wdimyY3tLBINEttlVFXTuJLNo41ZDtgBsf9VLNkWOiJY5IHMKTUXuSaAr3S8bIHV4Q
 cwuPlOX0pOSgyMo0keFws348ADrW2TzvoWAnUeY9F1LPj3pBJAVapEL+cIR1S+yq/lPz
 DzDh89ftS3QAiWB0pR4KdlJwHiAygVunG92RhLc8lRaLkPSXOUPU2s9xUNTYlY/2xLLT
 qwr04hqmBbZSM/ETZoOIvXAMI7XagPY/dhsGKZz/83kW6ZmF6yYFt70U66+sVOxlBhfg /Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc110q-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 05:43:40 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:43:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 16 Dec 2021 11:43:38 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C06C545D;
        Thu, 16 Dec 2021 11:43:37 +0000 (UTC)
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
Subject: [PATCH v5 06/10] ASoC: cs35l41: Create shared function for boost configuration
Date:   Thu, 16 Dec 2021 11:43:28 +0000
Message-ID: <20211216114332.153409-7-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
References: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WjRGmj-yFVQkzD-24FFzmP3GEDJDndJe
X-Proofpoint-ORIG-GUID: WjRGmj-yFVQkzD-24FFzmP3GEDJDndJe
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC and HDA will use the same registers to configure
internal boost for the device

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |   2 +
 sound/soc/codecs/cs35l41-lib.c |  98 ++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 105 +--------------------------------
 3 files changed, 102 insertions(+), 103 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 39d150f61382..29a527457b48 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -767,5 +767,7 @@ int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsign
 int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 			 unsigned int tx_num, unsigned int *tx_slot,
 			 unsigned int rx_num, unsigned int *rx_slot);
+int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind, int boost_cap,
+			 int boost_ipk);
 
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index afcec715374d..d026c5e3a378 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -966,6 +966,104 @@ int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 }
 EXPORT_SYMBOL_GPL(cs35l41_set_channels);
 
+static const unsigned char cs35l41_bst_k1_table[4][5] = {
+	{ 0x24, 0x32, 0x32, 0x4F, 0x57 },
+	{ 0x24, 0x32, 0x32, 0x4F, 0x57 },
+	{ 0x40, 0x32, 0x32, 0x4F, 0x57 },
+	{ 0x40, 0x32, 0x32, 0x4F, 0x57 }
+};
+
+static const unsigned char cs35l41_bst_k2_table[4][5] = {
+	{ 0x24, 0x49, 0x66, 0xA3, 0xEA },
+	{ 0x24, 0x49, 0x66, 0xA3, 0xEA },
+	{ 0x48, 0x49, 0x66, 0xA3, 0xEA },
+	{ 0x48, 0x49, 0x66, 0xA3, 0xEA }
+};
+
+static const unsigned char cs35l41_bst_slope_table[4] = {
+	0x75, 0x6B, 0x3B, 0x28
+};
+
+
+int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind, int boost_cap,
+			 int boost_ipk)
+{
+	unsigned char bst_lbst_val, bst_cbst_range, bst_ipk_scaled;
+	int ret;
+
+	switch (boost_ind) {
+	case 1000:	/* 1.0 uH */
+		bst_lbst_val = 0;
+		break;
+	case 1200:	/* 1.2 uH */
+		bst_lbst_val = 1;
+		break;
+	case 1500:	/* 1.5 uH */
+		bst_lbst_val = 2;
+		break;
+	case 2200:	/* 2.2 uH */
+		bst_lbst_val = 3;
+		break;
+	default:
+		dev_err(dev, "Invalid boost inductor value: %d nH\n", boost_ind);
+		return -EINVAL;
+	}
+
+	switch (boost_cap) {
+	case 0 ... 19:
+		bst_cbst_range = 0;
+		break;
+	case 20 ... 50:
+		bst_cbst_range = 1;
+		break;
+	case 51 ... 100:
+		bst_cbst_range = 2;
+		break;
+	case 101 ... 200:
+		bst_cbst_range = 3;
+		break;
+	default:	/* 201 uF and greater */
+		bst_cbst_range = 4;
+	}
+
+	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_COEFF,
+				 CS35L41_BST_K1_MASK | CS35L41_BST_K2_MASK,
+				 cs35l41_bst_k1_table[bst_lbst_val][bst_cbst_range]
+					<< CS35L41_BST_K1_SHIFT |
+				 cs35l41_bst_k2_table[bst_lbst_val][bst_cbst_range]
+					<< CS35L41_BST_K2_SHIFT);
+	if (ret) {
+		dev_err(dev, "Failed to write boost coefficients: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_SLOPE_LBST,
+				 CS35L41_BST_SLOPE_MASK | CS35L41_BST_LBST_VAL_MASK,
+				 cs35l41_bst_slope_table[bst_lbst_val]
+					<< CS35L41_BST_SLOPE_SHIFT |
+				 bst_lbst_val << CS35L41_BST_LBST_VAL_SHIFT);
+	if (ret) {
+		dev_err(dev, "Failed to write boost slope/inductor value: %d\n", ret);
+		return ret;
+	}
+
+	if (boost_ipk < 1600 || boost_ipk > 4500) {
+		dev_err(dev, "Invalid boost inductor peak current: %d mA\n", boost_ipk);
+		return -EINVAL;
+	}
+	bst_ipk_scaled = ((boost_ipk - 1600) / 50) + 0x10;
+
+	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_PEAK_CUR, CS35L41_BST_IPK_MASK,
+				 bst_ipk_scaled << CS35L41_BST_IPK_SHIFT);
+	if (ret) {
+		dev_err(dev, "Failed to write boost inductor peak current: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs35l41_boost_config);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 88d6e77fdb50..d9e6e84e64d0 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -150,24 +150,6 @@ static const struct cs35l41_fs_mon_config cs35l41_fs_mon[] = {
 	{ 6144000,	16,	24 },
 };
 
-static const unsigned char cs35l41_bst_k1_table[4][5] = {
-	{ 0x24, 0x32, 0x32, 0x4F, 0x57 },
-	{ 0x24, 0x32, 0x32, 0x4F, 0x57 },
-	{ 0x40, 0x32, 0x32, 0x4F, 0x57 },
-	{ 0x40, 0x32, 0x32, 0x4F, 0x57 }
-};
-
-static const unsigned char cs35l41_bst_k2_table[4][5] = {
-	{ 0x24, 0x49, 0x66, 0xA3, 0xEA },
-	{ 0x24, 0x49, 0x66, 0xA3, 0xEA },
-	{ 0x48, 0x49, 0x66, 0xA3, 0xEA },
-	{ 0x48, 0x49, 0x66, 0xA3, 0xEA }
-};
-
-static const unsigned char cs35l41_bst_slope_table[4] = {
-	0x75, 0x6B, 0x3B, 0x28
-};
-
 static int cs35l41_get_fs_mon_config_index(int freq)
 {
 	int i;
@@ -992,88 +974,6 @@ static int cs35l41_dai_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int cs35l41_boost_config(struct cs35l41_private *cs35l41,
-				int boost_ind, int boost_cap, int boost_ipk)
-{
-	unsigned char bst_lbst_val, bst_cbst_range, bst_ipk_scaled;
-	struct regmap *regmap = cs35l41->regmap;
-	struct device *dev = cs35l41->dev;
-	int ret;
-
-	switch (boost_ind) {
-	case 1000:	/* 1.0 uH */
-		bst_lbst_val = 0;
-		break;
-	case 1200:	/* 1.2 uH */
-		bst_lbst_val = 1;
-		break;
-	case 1500:	/* 1.5 uH */
-		bst_lbst_val = 2;
-		break;
-	case 2200:	/* 2.2 uH */
-		bst_lbst_val = 3;
-		break;
-	default:
-		dev_err(dev, "Invalid boost inductor value: %d nH\n", boost_ind);
-		return -EINVAL;
-	}
-
-	switch (boost_cap) {
-	case 0 ... 19:
-		bst_cbst_range = 0;
-		break;
-	case 20 ... 50:
-		bst_cbst_range = 1;
-		break;
-	case 51 ... 100:
-		bst_cbst_range = 2;
-		break;
-	case 101 ... 200:
-		bst_cbst_range = 3;
-		break;
-	default:	/* 201 uF and greater */
-		bst_cbst_range = 4;
-	}
-
-	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_COEFF,
-				 CS35L41_BST_K1_MASK | CS35L41_BST_K2_MASK,
-				 cs35l41_bst_k1_table[bst_lbst_val][bst_cbst_range]
-					<< CS35L41_BST_K1_SHIFT |
-				 cs35l41_bst_k2_table[bst_lbst_val][bst_cbst_range]
-					<< CS35L41_BST_K2_SHIFT);
-	if (ret) {
-		dev_err(dev, "Failed to write boost coefficients: %d\n", ret);
-		return ret;
-	}
-
-	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_SLOPE_LBST,
-				 CS35L41_BST_SLOPE_MASK | CS35L41_BST_LBST_VAL_MASK,
-				 cs35l41_bst_slope_table[bst_lbst_val]
-					<< CS35L41_BST_SLOPE_SHIFT |
-				 bst_lbst_val << CS35L41_BST_LBST_VAL_SHIFT);
-	if (ret) {
-		dev_err(dev, "Failed to write boost slope/inductor value: %d\n", ret);
-		return ret;
-	}
-
-	if (boost_ipk < 1600 || boost_ipk > 4500) {
-		dev_err(dev, "Invalid boost inductor peak current: %d mA\n",
-			boost_ipk);
-		return -EINVAL;
-	}
-	bst_ipk_scaled = ((boost_ipk - 1600) / 50) + 0x10;
-
-	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_PEAK_CUR,
-				 CS35L41_BST_IPK_MASK,
-				 bst_ipk_scaled << CS35L41_BST_IPK_SHIFT);
-	if (ret) {
-		dev_err(dev, "Failed to write boost inductor peak current: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 {
 	int ret;
@@ -1082,9 +982,8 @@ static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 	/* Required */
 	if (cs35l41->pdata.bst_ipk &&
 	    cs35l41->pdata.bst_ind && cs35l41->pdata.bst_cap) {
-		ret = cs35l41_boost_config(cs35l41, cs35l41->pdata.bst_ind,
-					   cs35l41->pdata.bst_cap,
-					   cs35l41->pdata.bst_ipk);
+		ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap, cs35l41->pdata.bst_ind,
+					   cs35l41->pdata.bst_cap, cs35l41->pdata.bst_ipk);
 		if (ret) {
 			dev_err(cs35l41->dev, "Error in Boost DT config: %d\n", ret);
 			return ret;
-- 
2.34.1

