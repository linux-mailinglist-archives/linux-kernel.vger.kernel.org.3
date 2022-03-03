Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5CC4CC3E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiCCRc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiCCRcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7219E70C;
        Thu,  3 Mar 2022 09:31:19 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234AAE1028599;
        Thu, 3 Mar 2022 11:31:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=y85Ic/hi1LlZQZyXOUJffZoXaymM0x0kKSegT1ubZek=;
 b=Te1vESkzGNkGI8L8AmDBmRze56ZF0xW6f4vViBqoWtqeKFaKiL1SUBg6zDc/xKGRCpwf
 WucQBR81h6vesNlgXMuvxmNqrpF3baFJvh2qTaVr0JZDhZwN+heD3bjtu3XMcc4ZOkrd
 NxN6tw0AF0oryuZgI0FmTOOUs6AKJoT6NCf6TYKW3LJWugjg1gqC61l2U5oBhWSdRREP
 aN53JfLNtnvOke16GkQ2YvOgERYDOvAefId5tjieCn5TaWkdtszbDCyY2Wov68jgehYg
 zYVG7zZOBdw2xJpzwyVwSNMiFBGti6pUEEhUPd1XgWIECASAfJqApaXqLQtrSqCZ5G8A 5g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybk-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:10 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:09 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:09 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0F9A5B1A;
        Thu,  3 Mar 2022 17:31:09 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 19/20] ASoC: cs35l41: Support external boost
Date:   Thu, 3 Mar 2022 17:30:58 +0000
Message-ID: <20220303173059.269657-20-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HeciYBAp_XbzoYQLzV92zDeFK8IryKnd
X-Proofpoint-GUID: HeciYBAp_XbzoYQLzV92zDeFK8IryKnd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for external boost voltage, where
GPIO1 must control a switch to isolate CS35L41
from the external Boost Voltage

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  4 +--
 sound/soc/codecs/cs35l41-lib.c |  5 ++--
 sound/soc/codecs/cs35l41.c     | 49 +++++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index bb008c6954d4..4e01caa14422 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -701,6 +701,8 @@
 #define CS35L41_GPIO1_CTRL_SHIFT	16
 #define CS35L41_GPIO2_CTRL_MASK		0x07000000
 #define CS35L41_GPIO2_CTRL_SHIFT	24
+#define CS35L41_GPIO_LVL_SHIFT		15
+#define CS35L41_GPIO_LVL_MASK		BIT(CS35L41_GPIO_LVL_SHIFT)
 #define CS35L41_GPIO_POL_MASK		0x1000
 #define CS35L41_GPIO_POL_SHIFT		12
 
@@ -796,8 +798,6 @@ int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsign
 int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 			 unsigned int tx_num, unsigned int *tx_slot,
 			 unsigned int rx_num, unsigned int *rx_slot);
-int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind, int boost_cap,
-			 int boost_ipk);
 int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 7e9577af73b4..bf31776701cf 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -954,8 +954,8 @@ static const unsigned char cs35l41_bst_slope_table[4] = {
 	0x75, 0x6B, 0x3B, 0x28
 };
 
-int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind,
-			 int boost_cap, int boost_ipk)
+static int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind,
+				int boost_cap, int boost_ipk)
 {
 	unsigned char bst_lbst_val, bst_cbst_range, bst_ipk_scaled;
 	int ret;
@@ -1040,7 +1040,6 @@ int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_in
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cs35l41_boost_config);
 
 static const struct reg_sequence cs35l41_safe_to_reset[] = {
 	{ 0x00000040,			0x00000055 },
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index d25689fe0c60..912196f45648 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -578,15 +578,10 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 						cs35l41_pup_patch,
 						ARRAY_SIZE(cs35l41_pup_patch));
 
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL1,
-				   CS35L41_GLOBAL_EN_MASK,
-				   1 << CS35L41_GLOBAL_EN_SHIFT);
-
-		usleep_range(1000, 1100);
+		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL1,
-				   CS35L41_GLOBAL_EN_MASK, 0);
+		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0);
 
 		ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 					       val, val &  CS35L41_PDN_DONE_MASK,
@@ -1001,13 +996,13 @@ static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 	if (!hw_cfg->valid)
 		return -EINVAL;
 
+	if (hw_cfg->bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH)
+		return -EINVAL;
+
 	/* Required */
-	ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap,
-				   hw_cfg->bst_ind, hw_cfg->bst_cap, hw_cfg->bst_ipk);
-	if (ret) {
-		dev_err(cs35l41->dev, "Error in Boost DT config: %d\n", ret);
+	ret = cs35l41_init_boost(cs35l41->dev, cs35l41->regmap, hw_cfg);
+	if (ret)
 		return ret;
-	}
 
 	/* Optional */
 	if (hw_cfg->dout_hiz <= CS35L41_ASP_DOUT_HIZ_MASK && hw_cfg->dout_hiz >= 0)
@@ -1017,9 +1012,31 @@ static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 	return 0;
 }
 
+static const struct snd_soc_dapm_route cs35l41_ext_bst_routes[] = {
+	{"Main AMP", NULL, "VSPK"},
+};
+
+static const struct snd_soc_dapm_widget cs35l41_ext_bst_widget[] = {
+	SND_SOC_DAPM_SUPPLY("VSPK", CS35L41_GPIO1_CTRL1, CS35L41_GPIO_LVL_SHIFT, 0, NULL, 0),
+};
+
 static int cs35l41_component_probe(struct snd_soc_component *component)
 {
 	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	int ret;
+
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST) {
+		ret = snd_soc_dapm_new_controls(dapm, cs35l41_ext_bst_widget,
+						ARRAY_SIZE(cs35l41_ext_bst_widget));
+		if (ret)
+			return ret;
+
+		ret = snd_soc_dapm_add_routes(dapm, cs35l41_ext_bst_routes,
+					      ARRAY_SIZE(cs35l41_ext_bst_routes));
+		if (ret)
+			return ret;
+	}
 
 	return wm_adsp2_component_probe(&cs35l41->dsp, component);
 }
@@ -1084,6 +1101,10 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
 	unsigned int val;
 	int ret;
 
+	ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
+	if (ret >= 0)
+		hw_cfg->bst_type = val;
+
 	ret = device_property_read_u32(dev, "cirrus,boost-peak-milliamp", &val);
 	if (ret >= 0)
 		hw_cfg->bst_ipk = val;
@@ -1376,6 +1397,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 
 	wm_adsp2_remove(&cs35l41->dsp);
 err:
+	cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
 	regulator_bulk_disable(CS35L41_NUM_SUPPLIES, cs35l41->supplies);
 	gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 
@@ -1390,6 +1412,7 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
 
 	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
 	wm_adsp2_remove(&cs35l41->dsp);
+	cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
 
 	pm_runtime_put_noidle(cs35l41->dev);
 
@@ -1409,6 +1432,7 @@ static int __maybe_unused cs35l41_runtime_suspend(struct device *dev)
 
 	dev_dbg(cs35l41->dev, "Enter hibernate\n");
 
+	cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
 	regmap_write(cs35l41->regmap, CS35L41_WAKESRC_CTL, 0x0088);
 	regmap_write(cs35l41->regmap, CS35L41_WAKESRC_CTL, 0x0188);
 
@@ -1505,6 +1529,7 @@ static int __maybe_unused cs35l41_runtime_resume(struct device *dev)
 		dev_err(cs35l41->dev, "Failed to restore register cache: %d\n", ret);
 		return ret;
 	}
+	cs35l41_init_boost(cs35l41->dev, cs35l41->regmap, &cs35l41->hw_cfg);
 
 	return 0;
 }
-- 
2.35.1

