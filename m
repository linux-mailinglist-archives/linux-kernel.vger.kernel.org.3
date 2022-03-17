Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586774DC2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiCQJeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiCQJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:34:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B01D66E3;
        Thu, 17 Mar 2022 02:32:32 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22H5dQJV011402;
        Thu, 17 Mar 2022 04:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=of9QB3tmkL0oOWKdhTGtzmf3Ml8UuecLfoNp3KwvfIM=;
 b=RY9dz5Cci6k0Rmt3kjQDUYMzluF89vDNX7bR3huhk7UFElzYZ4FZx5+Ir6Hc3IixkbxX
 IwUTju+m9QmJFuuoE3i9IBBIDxl0BfZO351zST0huiIVv1K1j53PCwcYjwYphpgKxcc+
 19kN6JGb49MNpLlxQTzZ0asl9XlppBcM8vu8U9a+659anEDaLQulYGVfG4mk8fBaJ8mT
 h/Tdsc5pjuvq/gsTJ1kfQBCvW3Z3wy06C60taDOR8qBM4Y1a0/RMYZrkOpE4qHHIh9nP
 /DmMwET2Ak6CN61nN7IIXaWrReYcN2NolKcgE4+VmH/1MsnfQuGTqX/DsxKJrrFfre+c Qg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3et642cbn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Mar 2022 04:31:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Mar
 2022 09:31:34 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 17 Mar 2022 09:31:34 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 047B6459;
        Thu, 17 Mar 2022 09:31:33 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v4 13/16] ALSA: hda: cs35l41: Handle all external boost setups the same way
Date:   Thu, 17 Mar 2022 09:31:17 +0000
Message-ID: <20220317093120.168534-14-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317093120.168534-1-tanureal@opensource.cirrus.com>
References: <20220317093120.168534-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kkXDEu0KRjjHBYo5P-gAp1oAE-0IP45e
X-Proofpoint-ORIG-GUID: kkXDEu0KRjjHBYo5P-gAp1oAE-0IP45e
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

External boost enables sequences for devices with or without GPIO1 as
VSPK switch are the same if devices are put in safe mode from reset.
As a previous patch put all external boost devices into safe mode
from reset, all external boost devices can be handled in the same way
for stream open and close.

The only difference is that devices without an VSPK switch can not be
put in reset and devices with it can be put into reset if a
configuration is applied.
The function cs35l41_hda_safe_reset is created to handle the safe reset
of the chip, and as systems without VSPK switch are not supported
anymore, only the CS35L41 HDA driver should check its return.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 60 +++++++++++++++----------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 3294837ff606..e54b5fbb6fb5 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -32,33 +32,9 @@ static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
 };
 
-// only on amps where GPIO1 is used to control ext. VSPK switch
-static const struct reg_sequence cs35l41_start_ext_vspk[] = {
+static const struct reg_sequence cs35l41_safe_to_reset[] = {
 	{ 0x00000040,			0x00000055 },
 	{ 0x00000040,			0x000000AA },
-	{ 0x00007438,			0x00585941 },
-	{ 0x00007414,			0x08C82222 },
-	{ 0x0000742C,			0x00000009 },
-	{ 0x00011008,			0x00008001 },
-	{ 0x0000742C,			0x0000000F },
-	{ 0x0000742C,			0x00000079 },
-	{ 0x00007438,			0x00585941 },
-	{ CS35L41_PWR_CTRL1,		0x00000001, 3000}, // set GLOBAL_EN = 1
-	{ 0x0000742C,			0x000000F9 },
-	{ 0x00007438,			0x00580941 },
-	{ 0x00000040,			0x000000CC },
-	{ 0x00000040,			0x00000033 },
-};
-
-//only on amps where GPIO1 is used to control ext. VSPK switch
-static const struct reg_sequence cs35l41_stop_ext_vspk[] = {
-	{ 0x00000040,			0x00000055 },
-	{ 0x00000040,			0x000000AA },
-	{ 0x00007438,			0x00585941 },
-	{ 0x00002014,			0x00000000, 3000}, // set GLOBAL_EN = 0
-	{ 0x0000742C,			0x00000009 },
-	{ 0x00007438,			0x00580941 },
-	{ 0x00011008,			0x00000001 },
 	{ 0x0000393C,			0x000000C0, 6000},
 	{ 0x0000393C,			0x00000000 },
 	{ 0x00007414,			0x00C82222 },
@@ -73,7 +49,7 @@ static const struct reg_sequence cs35l41_safe_to_active[] = {
 	{ 0x0000742C,			0x0000000F },
 	{ 0x0000742C,			0x00000079 },
 	{ 0x00007438,			0x00585941 },
-	{ CS35L41_PWR_CTRL1,		0x00000001, 2000 }, // GLOBAL_EN = 1
+	{ CS35L41_PWR_CTRL1,		0x00000001, 3000 }, // GLOBAL_EN = 1
 	{ 0x0000742C,			0x000000F9 },
 	{ 0x00007438,			0x00580941 },
 	{ 0x00000040,			0x000000CC },
@@ -85,7 +61,7 @@ static const struct reg_sequence cs35l41_active_to_safe[] = {
 	{ 0x00000040,			0x000000AA },
 	{ 0x00007438,			0x00585941 },
 	{ CS35L41_PWR_CTRL1,		0x00000000 },
-	{ 0x0000742C,			0x00000009, 2000 },
+	{ 0x0000742C,			0x00000009, 3000 },
 	{ 0x00007438,			0x00580941 },
 	{ 0x00000040,			0x000000CC },
 	{ 0x00000040,			0x00000033 },
@@ -101,6 +77,21 @@ static const struct reg_sequence cs35l41_reset_to_safe[] = {
 	{ 0x00000040,			0x00000033 },
 };
 
+static bool cs35l41_hda_safe_reset(struct cs35l41_hda *cs35l41)
+{
+	switch (cs35l41->hw_cfg.bst_type) {
+	case CS35L41_EXT_BOOST:
+		regmap_write(cs35l41->regmap, CS35L41_GPIO1_CTRL1, 0x00000001);
+		regmap_multi_reg_write(cs35l41->regmap, cs35l41_safe_to_reset,
+				       ARRAY_SIZE(cs35l41_safe_to_reset));
+		return true;
+	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
+		return false;
+	default:
+		return true;
+	}
+};
+
 static int cs35l41_hda_global_enable(struct cs35l41_hda *cs35l41, int enable)
 {
 	int ret;
@@ -113,13 +104,6 @@ static int cs35l41_hda_global_enable(struct cs35l41_hda *cs35l41, int enable)
 		usleep_range(3000, 3100);
 		break;
 	case CS35L41_EXT_BOOST:
-		if (enable)
-			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_start_ext_vspk,
-						     ARRAY_SIZE(cs35l41_start_ext_vspk));
-		else
-			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_stop_ext_vspk,
-						     ARRAY_SIZE(cs35l41_stop_ext_vspk));
-		break;
 	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
 		if (enable)
 			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_safe_to_active,
@@ -147,6 +131,8 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		regmap_multi_reg_write(reg, cs35l41_hda_config, ARRAY_SIZE(cs35l41_hda_config));
 		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 					 CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
+		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
+			regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00008001);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		ret = cs35l41_hda_global_enable(cs35l41, 1);
@@ -158,6 +144,8 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 	case HDA_GEN_PCM_ACT_CLOSE:
 		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 					 CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
+		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
+			regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00000001);
 		break;
 	default:
 		dev_warn(cs35l41->dev, "Playback action not supported: %d\n", action);
@@ -517,7 +505,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	return 0;
 
 err:
-	if (cs35l41->hw_cfg.bst_type != CS35L41_EXT_BOOST_NO_VSPK_SWITCH)
+	if (cs35l41_hda_safe_reset(cs35l41))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
 
@@ -531,7 +519,7 @@ void cs35l41_hda_remove(struct device *dev)
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
 
-	if (cs35l41->hw_cfg.bst_type != CS35L41_EXT_BOOST_NO_VSPK_SWITCH)
+	if (cs35l41_hda_safe_reset(cs35l41))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
 }
-- 
2.35.1

