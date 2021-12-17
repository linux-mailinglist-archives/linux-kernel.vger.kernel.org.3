Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08984478A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhLQL6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:58:04 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:58798 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235783AbhLQL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:57:48 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BH7xa1k006045;
        Fri, 17 Dec 2021 05:57:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=jUXTJ7ictjIJSVYhOpCkqR3DNBf/qRCuaX47KxJkx6I=;
 b=KvJMBtn1hD1exHh2nibd8NtjlwoBdQWvPbLNdWbaSkRYQLL2s0MDf9r8jJb88rsxvxEd
 HGj29fEzr0Cjdx/UZn0CNyi16NgGBwy965Al2uadkSbd6ihK/oJSZh4eZPxqLzqULAdF
 ZEP9mEtkFHUvrf2T7Z70KI2RzfkZ7FbMtFvrBprgvO0NIwpiUatRt3QLToVdv6tudWZB
 /T8+U5e8cWXLMIMrB1D5lMMP3ftokjYCgopVMq0XqfeXOxqXD4rLyhzUiGOKQdXf+8xt
 d9SAUrZCdwHMLO2z8cr0Z2o+gHSVAYpdo/0n29O9+WgYSujDR0s7K4Xca0AyjHNvUTL0 wQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc2f3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Dec 2021 05:57:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 11:57:22 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 11:57:22 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2408C11CB;
        Fri, 17 Dec 2021 11:57:22 +0000 (UTC)
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
Subject: [PATCH v6 05/10] ASoC: cs35l41: Create shared function for setting channels
Date:   Fri, 17 Dec 2021 11:57:03 +0000
Message-ID: <20211217115708.882525-6-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: G0VGIDDXBy3iDkCFLkgqZPjyNmGZMWYp
X-Proofpoint-ORIG-GUID: G0VGIDDXBy3iDkCFLkgqZPjyNmGZMWYp
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
index 5e382eaea340..afcec715374d 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -934,6 +934,38 @@ int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsign
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

