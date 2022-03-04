Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32FE4CD74C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiCDPKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbiCDPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:09:39 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8A7A41B7;
        Fri,  4 Mar 2022 07:08:29 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2248TInM019088;
        Fri, 4 Mar 2022 09:07:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=DvLujPcBLTJP8Oe9RdSiwgbwwIJ5bMu683tSdsdfNww=;
 b=bhGxlMQOzvD9uYe+US57OLNCdz1nyTeukydVrxQ0MarOLqss7kISreGhJdJ6jFd9XpsX
 lWTYCDT/8LiU/BCLtCh7YlZz2uHLCC74ML5UdhtYx8noTk+izxp3tXCY6QvKUHvkum7N
 Pb9T4IKT8I4M8K/ZAp/FlDCaNpWCwxswNCFDKXGrQqlmzSsRJvg8a3vcBbgRU9FNY4Tb
 cpoOsp8cEYyRjfgBnJIXEP0DoPgOcYLjLaUXPjYVIxybhkrOEmSxD6qqjKPGIsCzaGho
 Kx1RuYTDUHyy/lGVcy4Gx3xnNYuiXgmFz96PrkIGE8D3hl1CjnrgAAuXFmxT427e1Fye zA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h413-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:07:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:07:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:07:30 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ED64DB06;
        Fri,  4 Mar 2022 15:07:29 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 18/20] hda: cs35l41: Move external boost handling to lib for ASoC use
Date:   Fri, 4 Mar 2022 15:07:19 +0000
Message-ID: <20220304150721.3802-19-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ADJnuMWnYmLkw1cAwtGLb4dgsmZQiyKQ
X-Proofpoint-ORIG-GUID: ADJnuMWnYmLkw1cAwtGLb4dgsmZQiyKQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To add support for external boost for ASoC move the HDA external
boost implementation to the shared lib.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |   4 +
 sound/pci/hda/cs35l41_hda.c    | 119 ++----------------------------
 sound/soc/codecs/cs35l41-lib.c | 129 ++++++++++++++++++++++++++++++++-
 3 files changed, 137 insertions(+), 115 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index a8537bccedcf..2b2d1d17e552 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -799,5 +799,9 @@ int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind, int boost_cap,
 			 int boost_ipk);
 int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg);
+int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
+		       struct cs35l41_hw_cfg *hw_cfg);
+bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type);
+int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable);
 
 #endif /* __CS35L41_H */
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 2ae074c8613e..190002cdd429 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -32,94 +32,6 @@ static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
 };
 
-static const struct reg_sequence cs35l41_safe_to_reset[] = {
-	{ 0x00000040,			0x00000055 },
-	{ 0x00000040,			0x000000AA },
-	{ 0x0000393C,			0x000000C0, 6000},
-	{ 0x0000393C,			0x00000000 },
-	{ 0x00007414,			0x00C82222 },
-	{ 0x0000742C,			0x00000000 },
-	{ 0x00000040,			0x000000CC },
-	{ 0x00000040,			0x00000033 },
-};
-
-static const struct reg_sequence cs35l41_safe_to_active[] = {
-	{ 0x00000040,			0x00000055 },
-	{ 0x00000040,			0x000000AA },
-	{ 0x0000742C,			0x0000000F },
-	{ 0x0000742C,			0x00000079 },
-	{ 0x00007438,			0x00585941 },
-	{ CS35L41_PWR_CTRL1,		0x00000001, 3000 }, // GLOBAL_EN = 1
-	{ 0x0000742C,			0x000000F9 },
-	{ 0x00007438,			0x00580941 },
-	{ 0x00000040,			0x000000CC },
-	{ 0x00000040,			0x00000033 },
-};
-
-static const struct reg_sequence cs35l41_active_to_safe[] = {
-	{ 0x00000040,			0x00000055 },
-	{ 0x00000040,			0x000000AA },
-	{ 0x00007438,			0x00585941 },
-	{ CS35L41_PWR_CTRL1,		0x00000000 },
-	{ 0x0000742C,			0x00000009, 3000 },
-	{ 0x00007438,			0x00580941 },
-	{ 0x00000040,			0x000000CC },
-	{ 0x00000040,			0x00000033 },
-};
-
-static const struct reg_sequence cs35l41_reset_to_safe[] = {
-	{ 0x00000040,			0x00000055 },
-	{ 0x00000040,			0x000000AA },
-	{ 0x00007438,			0x00585941 },
-	{ 0x00007414,			0x08C82222 },
-	{ 0x0000742C,			0x00000009 },
-	{ 0x00000040,			0x000000CC },
-	{ 0x00000040,			0x00000033 },
-};
-
-static bool cs35l41_hda_safe_reset(struct cs35l41_hda *cs35l41)
-{
-	switch (cs35l41->hw_cfg.bst_type) {
-	case CS35L41_EXT_BOOST:
-		regmap_write(cs35l41->regmap, CS35L41_GPIO1_CTRL1, 0x00000001);
-		regmap_multi_reg_write(cs35l41->regmap, cs35l41_safe_to_reset,
-				       ARRAY_SIZE(cs35l41_safe_to_reset));
-		return true;
-	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
-		return false;
-	default:
-		return true;
-	}
-};
-
-static int cs35l41_hda_global_enable(struct cs35l41_hda *cs35l41, int enable)
-{
-	int ret;
-
-	switch (cs35l41->hw_cfg.bst_type) {
-	case CS35L41_INT_BOOST:
-		ret = regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL1,
-					 CS35L41_GLOBAL_EN_MASK,
-					 enable << CS35L41_GLOBAL_EN_SHIFT);
-		usleep_range(3000, 3100);
-		break;
-	case CS35L41_EXT_BOOST:
-	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
-		if (enable)
-			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_safe_to_active,
-						     ARRAY_SIZE(cs35l41_safe_to_active));
-		else
-			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_active_to_safe,
-						     ARRAY_SIZE(cs35l41_active_to_safe));
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-};
-
 static void cs35l41_hda_playback_hook(struct device *dev, int action)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
@@ -135,11 +47,11 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 			regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00008001);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
-		ret = cs35l41_hda_global_enable(cs35l41, 1);
+		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 1);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
 		regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
-		ret = cs35l41_hda_global_enable(cs35l41, 0);
+		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 0);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
 		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
@@ -207,26 +119,9 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 	if (!cs35l41->hw_cfg.valid)
 		return -EINVAL;
 
-	switch (hw_cfg->bst_type) {
-	case CS35L41_INT_BOOST:
-		ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap,
-					   hw_cfg->bst_ind, hw_cfg->bst_cap, hw_cfg->bst_ipk);
-		if (ret)
-			return ret;
-		break;
-	case CS35L41_EXT_BOOST:
-	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
-		regmap_multi_reg_write(cs35l41->regmap, cs35l41_reset_to_safe,
-				       ARRAY_SIZE(cs35l41_reset_to_safe));
-		ret = regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
-					  CS35L41_BST_DIS_FET_OFF << CS35L41_BST_EN_SHIFT);
-		if (ret)
-			return ret;
-		break;
-	default:
-		dev_err(cs35l41->dev, "Boost type %d not supported\n", hw_cfg->bst_type);
-		return -EINVAL;
-	}
+	ret = cs35l41_init_boost(cs35l41->dev, cs35l41->regmap, hw_cfg);
+	if (ret)
+		return ret;
 
 	if (hw_cfg->gpio1.valid) {
 		switch (hw_cfg->gpio1.func) {
@@ -505,7 +400,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	return 0;
 
 err:
-	if (cs35l41_hda_safe_reset(cs35l41))
+	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
 
@@ -519,7 +414,7 @@ void cs35l41_hda_remove(struct device *dev)
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
 
-	if (cs35l41_hda_safe_reset(cs35l41))
+	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
 }
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 34ba163874a6..91270047bf35 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -954,9 +954,8 @@ static const unsigned char cs35l41_bst_slope_table[4] = {
 	0x75, 0x6B, 0x3B, 0x28
 };
 
-
-int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind, int boost_cap,
-			 int boost_ipk)
+int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind,
+			 int boost_cap, int boost_ipk)
 {
 	unsigned char bst_lbst_val, bst_cbst_range, bst_ipk_scaled;
 	int ret;
@@ -1043,6 +1042,130 @@ int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_in
 }
 EXPORT_SYMBOL_GPL(cs35l41_boost_config);
 
+static const struct reg_sequence cs35l41_safe_to_reset[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x0000393C,			0x000000C0, 6000},
+	{ 0x0000393C,			0x00000000 },
+	{ 0x00007414,			0x00C82222 },
+	{ 0x0000742C,			0x00000000 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_active_to_safe[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00585941 },
+	{ CS35L41_PWR_CTRL1,		0x00000000 },
+	{ 0x0000742C,			0x00000009, 3000 },
+	{ 0x00007438,			0x00580941 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_safe_to_active[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x0000742C,			0x0000000F },
+	{ 0x0000742C,			0x00000079 },
+	{ 0x00007438,			0x00585941 },
+	{ CS35L41_PWR_CTRL1,		0x00000001, 3000 }, // GLOBAL_EN = 1
+	{ 0x0000742C,			0x000000F9 },
+	{ 0x00007438,			0x00580941 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_reset_to_safe[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00585941 },
+	{ 0x00007414,			0x08C82222 },
+	{ 0x0000742C,			0x00000009 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
+		       struct cs35l41_hw_cfg *hw_cfg)
+{
+	int ret;
+
+	switch (hw_cfg->bst_type) {
+	case CS35L41_INT_BOOST:
+		ret = cs35l41_boost_config(dev, regmap, hw_cfg->bst_ind,
+					   hw_cfg->bst_cap, hw_cfg->bst_ipk);
+		if (ret)
+			dev_err(dev, "Error in Boost DT config: %d\n", ret);
+		break;
+	case CS35L41_EXT_BOOST:
+	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
+		/* Only CLSA0100 doesn't use GPIO as VSPK switch, but even on that laptop we can
+		 * toggle GPIO1 as is not connected to anything.
+		 * There will be no other device without VSPK switch.
+		 */
+		regmap_write(regmap, CS35L41_GPIO1_CTRL1, 0x00000001);
+		regmap_multi_reg_write(regmap, cs35l41_reset_to_safe,
+				       ARRAY_SIZE(cs35l41_reset_to_safe));
+		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
+					 CS35L41_BST_DIS_FET_OFF << CS35L41_BST_EN_SHIFT);
+		break;
+	default:
+		dev_err(dev, "Boost type %d not supported\n", hw_cfg->bst_type);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l41_init_boost);
+
+bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type)
+{
+	switch (b_type) {
+	/* There is only one laptop that doesn't have VSPK switch. */
+	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
+		return false;
+	case CS35L41_EXT_BOOST:
+		regmap_write(regmap, CS35L41_GPIO1_CTRL1, 0x00000001);
+		regmap_multi_reg_write(regmap, cs35l41_safe_to_reset,
+				       ARRAY_SIZE(cs35l41_safe_to_reset));
+		return true;
+	default:
+		return true;
+	}
+}
+EXPORT_SYMBOL_GPL(cs35l41_safe_reset);
+
+int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable)
+{
+	int ret;
+
+	switch (b_type) {
+	case CS35L41_INT_BOOST:
+		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
+					 enable << CS35L41_GLOBAL_EN_SHIFT);
+		usleep_range(3000, 3100);
+		break;
+	case CS35L41_EXT_BOOST:
+	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
+		if (enable)
+			ret = regmap_multi_reg_write(regmap, cs35l41_safe_to_active,
+						     ARRAY_SIZE(cs35l41_safe_to_active));
+		else
+			ret = regmap_multi_reg_write(regmap, cs35l41_active_to_safe,
+						     ARRAY_SIZE(cs35l41_active_to_safe));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l41_global_enable);
+
 int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg)
 {
 	struct cs35l41_gpio_cfg *gpio1 = &hw_cfg->gpio1;
-- 
2.35.1

