Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5F4770D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhLPLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:44:06 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:61370 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232287AbhLPLoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:44:05 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG6fNWC032113;
        Thu, 16 Dec 2021 05:43:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=JwdEvJNSccwPwzdfwacOslSxZt9T4OuG+VPsh+orUNE=;
 b=lgsfT5oPwy7HdcRrr4/xLKKOkLcP5fWZ8EzoVf7wS2o7UiqeHEXRX7grXAQuer/AddTx
 Ky8U6wVWbUWhXEg3v+kcj+hbsziMXaOFg4/R8VyQSrFe03nxyCkTCnrXnuvlqgx4QxmY
 SjanAO9Mha/uHPYfvoBCCpWIyw0qwI0B+tpiTOZKVQEyjd+G9GYJMYVQq6W6TC27zIcJ
 GGYGVxCgeB1/L3LNZ0KtFz3PaT/Oqh2xXth3I8ny1Jfn/lbqruNRgPskhGsW88qbBemL
 BLGsrSaw9wZRG9eO+/fzyx+CsCA6jp4N9qSKJdVOkHG9QSNftNvYYGx1RMlCAq6Necig Pw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc110r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 05:43:39 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:43:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 16 Dec 2021 11:43:36 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B9A4B45D;
        Thu, 16 Dec 2021 11:43:35 +0000 (UTC)
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
Subject: [PATCH v5 02/10] ASoC: cs35l41: Move cs35l41_otp_unpack to shared code
Date:   Thu, 16 Dec 2021 11:43:24 +0000
Message-ID: <20211216114332.153409-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
References: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rkyFrGMuy9ue6LNrt1dNfap0yDTQnU5w
X-Proofpoint-ORIG-GUID: rkyFrGMuy9ue6LNrt1dNfap0yDTQnU5w
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC and HDA will do the same cs35l41_otp_unpack, so move it
to shared code

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |   4 +-
 sound/soc/codecs/cs35l41-lib.c | 121 ++++++++++++++++++++++++++++++-
 sound/soc/codecs/cs35l41.c     | 125 +--------------------------------
 3 files changed, 122 insertions(+), 128 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index aac3ffb9bc89..6cf3ef02b26a 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -534,7 +534,6 @@
 #define CS35L41_MAX_CACHE_REG		36
 #define CS35L41_OTP_SIZE_WORDS		32
 #define CS35L41_NUM_OTP_ELEM		100
-#define CS35L41_NUM_OTP_MAPS		5
 
 #define CS35L41_VALID_PDATA		0x80000000
 #define CS35L41_NUM_SUPPLIES            2
@@ -760,8 +759,9 @@ struct cs35l41_otp_map_element_t {
 	u32 word_offset;
 };
 
-extern const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[CS35L41_NUM_OTP_MAPS];
 extern struct regmap_config cs35l41_regmap_i2c;
 extern struct regmap_config cs35l41_regmap_spi;
 
+int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap);
+
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index f19531ebf729..dc5f502447a2 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -7,8 +7,11 @@
 // Author: David Rhodes <david.rhodes@cirrus.com>
 // Author: Lucas Tanure <lucas.tanure@cirrus.com>
 
+#include <linux/dev_printk.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
 #include <sound/cs35l41.h>
 
@@ -655,7 +658,7 @@ static const struct cs35l41_otp_packed_element_t otp_map_2[CS35L41_NUM_OTP_ELEM]
 	{ 0x00017044,	0,	24 }, /*LOT_NUMBER*/
 };
 
-const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[CS35L41_NUM_OTP_MAPS] = {
+static const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[] = {
 	{
 		.id = 0x01,
 		.map = otp_map_1,
@@ -692,7 +695,6 @@ const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[CS35L41_NUM_OTP_MAPS]
 		.word_offset = 2,
 	},
 };
-EXPORT_SYMBOL_GPL(cs35l41_otp_map_map);
 
 struct regmap_config cs35l41_regmap_i2c = {
 	.reg_bits = 32,
@@ -727,6 +729,121 @@ struct regmap_config cs35l41_regmap_spi = {
 };
 EXPORT_SYMBOL_GPL(cs35l41_regmap_spi);
 
+static const struct cs35l41_otp_map_element_t *cs35l41_find_otp_map(u32 otp_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l41_otp_map_map); i++) {
+		if (cs35l41_otp_map_map[i].id == otp_id)
+			return &cs35l41_otp_map_map[i];
+	}
+
+	return NULL;
+}
+
+int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap)
+{
+	const struct cs35l41_otp_map_element_t *otp_map_match;
+	const struct cs35l41_otp_packed_element_t *otp_map;
+	int bit_offset, word_offset, ret, i;
+	unsigned int bit_sum = 8;
+	u32 otp_val, otp_id_reg;
+	u32 *otp_mem;
+
+	otp_mem = kmalloc_array(CS35L41_OTP_SIZE_WORDS, sizeof(*otp_mem), GFP_KERNEL);
+	if (!otp_mem)
+		return -ENOMEM;
+
+	ret = regmap_read(regmap, CS35L41_OTPID, &otp_id_reg);
+	if (ret) {
+		dev_err(dev, "Read OTP ID failed: %d\n", ret);
+		goto err_otp_unpack;
+	}
+
+	otp_map_match = cs35l41_find_otp_map(otp_id_reg);
+
+	if (!otp_map_match) {
+		dev_err(dev, "OTP Map matching ID %d not found\n", otp_id_reg);
+		ret = -EINVAL;
+		goto err_otp_unpack;
+	}
+
+	ret = regmap_bulk_read(regmap, CS35L41_OTP_MEM0, otp_mem, CS35L41_OTP_SIZE_WORDS);
+	if (ret) {
+		dev_err(dev, "Read OTP Mem failed: %d\n", ret);
+		goto err_otp_unpack;
+	}
+
+	otp_map = otp_map_match->map;
+
+	bit_offset = otp_map_match->bit_offset;
+	word_offset = otp_map_match->word_offset;
+
+	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x00000055);
+	if (ret) {
+		dev_err(dev, "Write Unlock key failed 1/2: %d\n", ret);
+		goto err_otp_unpack;
+	}
+	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x000000AA);
+	if (ret) {
+		dev_err(dev, "Write Unlock key failed 2/2: %d\n", ret);
+		goto err_otp_unpack;
+	}
+
+	for (i = 0; i < otp_map_match->num_elements; i++) {
+		dev_dbg(dev, "bitoffset= %d, word_offset=%d, bit_sum mod 32=%d\n",
+			bit_offset, word_offset, bit_sum % 32);
+		if (bit_offset + otp_map[i].size - 1 >= 32) {
+			otp_val = (otp_mem[word_offset] &
+					GENMASK(31, bit_offset)) >> bit_offset;
+			otp_val |= (otp_mem[++word_offset] &
+					GENMASK(bit_offset + otp_map[i].size - 33, 0)) <<
+					(32 - bit_offset);
+			bit_offset += otp_map[i].size - 32;
+		} else {
+			otp_val = (otp_mem[word_offset] &
+				   GENMASK(bit_offset + otp_map[i].size - 1, bit_offset)
+				  ) >> bit_offset;
+			bit_offset += otp_map[i].size;
+		}
+		bit_sum += otp_map[i].size;
+
+		if (bit_offset == 32) {
+			bit_offset = 0;
+			word_offset++;
+		}
+
+		if (otp_map[i].reg != 0) {
+			ret = regmap_update_bits(regmap, otp_map[i].reg,
+						 GENMASK(otp_map[i].shift + otp_map[i].size - 1,
+							 otp_map[i].shift),
+						 otp_val << otp_map[i].shift);
+			if (ret < 0) {
+				dev_err(dev, "Write OTP val failed: %d\n", ret);
+				goto err_otp_unpack;
+			}
+		}
+	}
+
+	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x000000CC);
+	if (ret) {
+		dev_err(dev, "Write Lock key failed 1/2: %d\n", ret);
+		goto err_otp_unpack;
+	}
+	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x00000033);
+	if (ret) {
+		dev_err(dev, "Write Lock key failed 2/2: %d\n", ret);
+		goto err_otp_unpack;
+	}
+	ret = 0;
+
+err_otp_unpack:
+	kfree(otp_mem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l41_otp_unpack);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 60332eae1162..aa57c59b334d 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -14,7 +14,6 @@
 #include <linux/moduleparam.h>
 #include <linux/of_device.h>
 #include <linux/property.h>
-#include <linux/slab.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -420,128 +419,6 @@ static const struct snd_kcontrol_new cs35l41_aud_controls[] = {
 	WM_ADSP_FW_CONTROL("DSP1", 0),
 };
 
-static const struct cs35l41_otp_map_element_t *cs35l41_find_otp_map(u32 otp_id)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(cs35l41_otp_map_map); i++) {
-		if (cs35l41_otp_map_map[i].id == otp_id)
-			return &cs35l41_otp_map_map[i];
-	}
-
-	return NULL;
-}
-
-static int cs35l41_otp_unpack(void *data)
-{
-	const struct cs35l41_otp_map_element_t *otp_map_match;
-	const struct cs35l41_otp_packed_element_t *otp_map;
-	struct cs35l41_private *cs35l41 = data;
-	int bit_offset, word_offset, ret, i;
-	unsigned int bit_sum = 8;
-	u32 otp_val, otp_id_reg;
-	u32 *otp_mem;
-
-	otp_mem = kmalloc_array(CS35L41_OTP_SIZE_WORDS, sizeof(*otp_mem), GFP_KERNEL);
-	if (!otp_mem)
-		return -ENOMEM;
-
-	ret = regmap_read(cs35l41->regmap, CS35L41_OTPID, &otp_id_reg);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Read OTP ID failed: %d\n", ret);
-		goto err_otp_unpack;
-	}
-
-	otp_map_match = cs35l41_find_otp_map(otp_id_reg);
-
-	if (!otp_map_match) {
-		dev_err(cs35l41->dev, "OTP Map matching ID %d not found\n",
-			otp_id_reg);
-		ret = -EINVAL;
-		goto err_otp_unpack;
-	}
-
-	ret = regmap_bulk_read(cs35l41->regmap, CS35L41_OTP_MEM0, otp_mem,
-			       CS35L41_OTP_SIZE_WORDS);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Read OTP Mem failed: %d\n", ret);
-		goto err_otp_unpack;
-	}
-
-	otp_map = otp_map_match->map;
-
-	bit_offset = otp_map_match->bit_offset;
-	word_offset = otp_map_match->word_offset;
-
-	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x00000055);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write Unlock key failed 1/2: %d\n", ret);
-		goto err_otp_unpack;
-	}
-	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x000000AA);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write Unlock key failed 2/2: %d\n", ret);
-		goto err_otp_unpack;
-	}
-
-	for (i = 0; i < otp_map_match->num_elements; i++) {
-		dev_dbg(cs35l41->dev,
-			"bitoffset= %d, word_offset=%d, bit_sum mod 32=%d\n",
-			bit_offset, word_offset, bit_sum % 32);
-		if (bit_offset + otp_map[i].size - 1 >= 32) {
-			otp_val = (otp_mem[word_offset] &
-					GENMASK(31, bit_offset)) >>
-					bit_offset;
-			otp_val |= (otp_mem[++word_offset] &
-					GENMASK(bit_offset +
-						otp_map[i].size - 33, 0)) <<
-					(32 - bit_offset);
-			bit_offset += otp_map[i].size - 32;
-		} else {
-			otp_val = (otp_mem[word_offset] &
-				GENMASK(bit_offset + otp_map[i].size - 1,
-					bit_offset)) >>	bit_offset;
-			bit_offset += otp_map[i].size;
-		}
-		bit_sum += otp_map[i].size;
-
-		if (bit_offset == 32) {
-			bit_offset = 0;
-			word_offset++;
-		}
-
-		if (otp_map[i].reg != 0) {
-			ret = regmap_update_bits(cs35l41->regmap,
-						 otp_map[i].reg,
-						 GENMASK(otp_map[i].shift +
-							 otp_map[i].size - 1,
-						 otp_map[i].shift),
-						 otp_val << otp_map[i].shift);
-			if (ret < 0) {
-				dev_err(cs35l41->dev, "Write OTP val failed: %d\n",
-					ret);
-				goto err_otp_unpack;
-			}
-		}
-	}
-
-	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x000000CC);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write Lock key failed 1/2: %d\n", ret);
-		goto err_otp_unpack;
-	}
-	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x00000033);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write Lock key failed 2/2: %d\n", ret);
-		goto err_otp_unpack;
-	}
-	ret = 0;
-
-err_otp_unpack:
-	kfree(otp_mem);
-	return ret;
-}
-
 static irqreturn_t cs35l41_irq(int irq, void *data)
 {
 	struct cs35l41_private *cs35l41 = data;
@@ -1667,7 +1544,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		goto err;
 	}
 
-	ret = cs35l41_otp_unpack(cs35l41);
+	ret = cs35l41_otp_unpack(cs35l41->dev, cs35l41->regmap);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "OTP Unpack failed: %d\n", ret);
 		goto err;
-- 
2.34.1

