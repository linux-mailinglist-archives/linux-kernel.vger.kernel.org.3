Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C24D47441C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhLNOA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:00:29 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:51002 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232413AbhLNOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:00:25 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE4Ko3l006814;
        Tue, 14 Dec 2021 08:00:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=55Tlm3XthgJZqC2vFPO/vC51Npg+sQltLMDPXr7iYCg=;
 b=rEPPDOz9Nk6fV8RunMuf0mZTecHyByNtiuz8e5McWh1YZ/t8FStL4RzGCdlE6POip43t
 aRjmFR8Q0nJ56IkTFpta/T1mZ80/HyvaMnp/lONiuTl9/hAbVDWBLKQNuxBWLlEGEbRK
 AqykOmJbKEvPD//idyKUwS/DXK9OvzQrj1YGuJpspKk7sJhVn/WK1dLtOsUg5exChTZS
 ExpoKFNelYquzhSZOetAnfVj6TKNryt4HDuN7p4ibwDLKMqE6QKCkQg3xXdLIOLtBS8E
 ZjruFfsJ34xBVqhiOPR+te8Ye0E4jvbR+xCenAHqLKkSmC8mE4mUPOSjZWiw04jsQiR5 4g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cxh14grht-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Dec 2021 08:00:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 14:00:03 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 14 Dec 2021 14:00:03 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B116B45A;
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
Subject: [PATCH v4 05/10] ASoC: cs35l41: Create shared function for setting channels
Date:   Tue, 14 Dec 2021 13:59:54 +0000
Message-ID: <20211214135959.1317949-6-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
References: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RRlwJ-3vnjDIkpj8uyEcX_CgBxVHsr1A
X-Proofpoint-ORIG-GUID: RRlwJ-3vnjDIkpj8uyEcX_CgBxVHsr1A
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC and HDA will use the same register to set channels
for the device

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  3 +++
 sound/soc/codecs/cs35l41-lib.c | 32 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 30 +++---------------------------
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index ad2e32a12b8c..39d150f61382 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -764,5 +764,8 @@ extern struct regmap_config cs35l41_regmap_spi;
 
 int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap);
 int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsigned int reg_revid);
+int cs35l41_set_channels(struct device *dev, struct regmap *reg,
+			 unsigned int tx_num, unsigned int *tx_slot,
+			 unsigned int rx_num, unsigned int *rx_slot);
 
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 035d311d336a..99f2b246f5b7 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -932,6 +932,38 @@ int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsign
 }
 EXPORT_SYMBOL_GPL(cs35l41_register_errata_patch);
 
+int cs35l41_set_channels(struct device *dev, struct regmap *reg,
+			 unsigned int tx_num, unsigned int *tx_slot,
+			 unsigned int rx_num, unsigned int *rx_slot)
+{
+	unsigned int val, mask;
+	int i;
+
+	if (tx_num > 4 || rx_num > 2)
+		return -EINVAL;
+
+	val = 0;
+	mask = 0;
+	for (i = 0; i < rx_num; i++) {
+		dev_dbg(dev, "rx slot %d position = %d\n", i, rx_slot[i]);
+		val |= rx_slot[i] << (i * 8);
+		mask |= 0x3F << (i * 8);
+	}
+	regmap_update_bits(reg, CS35L41_SP_FRAME_RX_SLOT, mask, val);
+
+	val = 0;
+	mask = 0;
+	for (i = 0; i < tx_num; i++) {
+		dev_dbg(dev, "tx slot %d position = %d\n", i, tx_slot[i]);
+		val |= tx_slot[i] << (i * 8);
+		mask |= 0x3F << (i * 8);
+	}
+	regmap_update_bits(reg, CS35L41_SP_FRAME_TX_SLOT, mask, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs35l41_set_channels);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index afc10f7ca65e..88d6e77fdb50 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -751,36 +751,12 @@ static const struct cs_dsp_region cs35l41_dsp1_regions[] = {
 	{. type = WMFW_ADSP2_YM,	.base = CS35L41_DSP1_YMEM_UNPACK24_0},
 };
 
-static int cs35l41_set_channel_map(struct snd_soc_dai *dai, unsigned int tx_num,
-				   unsigned int *tx_slot, unsigned int rx_num,
-				   unsigned int *rx_slot)
+static int cs35l41_set_channel_map(struct snd_soc_dai *dai, unsigned int tx_n,
+				   unsigned int *tx_slot, unsigned int rx_n, unsigned int *rx_slot)
 {
 	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(dai->component);
-	unsigned int val, mask;
-	int i;
-
-	if (tx_num > 4 || rx_num > 2)
-		return -EINVAL;
 
-	val = 0;
-	mask = 0;
-	for (i = 0; i < rx_num; i++) {
-		dev_dbg(cs35l41->dev, "rx slot %d position = %d\n", i, rx_slot[i]);
-		val |= rx_slot[i] << (i * 8);
-		mask |= 0x3F << (i * 8);
-	}
-	regmap_update_bits(cs35l41->regmap, CS35L41_SP_FRAME_RX_SLOT, mask, val);
-
-	val = 0;
-	mask = 0;
-	for (i = 0; i < tx_num; i++) {
-		dev_dbg(cs35l41->dev, "tx slot %d position = %d\n", i, tx_slot[i]);
-		val |= tx_slot[i] << (i * 8);
-		mask |= 0x3F << (i * 8);
-	}
-	regmap_update_bits(cs35l41->regmap, CS35L41_SP_FRAME_TX_SLOT, mask, val);
-
-	return 0;
+	return cs35l41_set_channels(cs35l41->dev, cs35l41->regmap, tx_n, tx_slot, rx_n, rx_slot);
 }
 
 static int cs35l41_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
-- 
2.34.1

