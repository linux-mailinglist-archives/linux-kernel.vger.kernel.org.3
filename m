Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F04CC3F4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiCCRdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiCCRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:10 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B419E726;
        Thu,  3 Mar 2022 09:31:21 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223509T4013880;
        Thu, 3 Mar 2022 11:31:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=k1V9y3nDelaf3sZIcLeP2ii1zTXwfv1iy74wJ115Xmc=;
 b=VS20O5X3TVNiV4M/cHrE3SCQipS1vOlaquaTslidKdinsW86FwKCnqj/KJ4o8wQqWRhQ
 Y80PsWwsjB/LLMN3eaZEHeCmW1RVxJhjZwpwonaCI6lnvkB54wfgLl9VVa8eHseGXHES
 dpEgKqEbL+HxUf4nYYxpj5xW+IanKgra8HXVO+GH48XHKKtP2q7oDdS3ryk0ZAJiG9en
 uOW/ZfohTYZjqAC+jVyDqm+OrKCrzLOLJLxX6TBE6DeBjWL0ZWHzf7KABlk681cZySQn
 iT1mgiHXVCLFchZxE/FL/12d6cyL4alJtA6WcPrSBf7fyvfzT4y264jTxFVs+O2X4LG3 rA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:07 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:05 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:05 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D0340B1A;
        Thu,  3 Mar 2022 17:31:04 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 07/20] sound: cs35l41: Move cs35l41_gpio_config to shared lib
Date:   Thu, 3 Mar 2022 17:30:46 +0000
Message-ID: <20220303173059.269657-8-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ycmhttec4LQmNG7BMS1gqyUO8znU_CJa
X-Proofpoint-GUID: ycmhttec4LQmNG7BMS1gqyUO8znU_CJa
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC and HDA can use a single function to configure gpios

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  1 +
 sound/pci/hda/cs35l41_hda.c    | 11 ++++-----
 sound/soc/codecs/cs35l41-lib.c | 41 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 45 +---------------------------------
 4 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 57c47636c223..e3ec0f422fff 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -792,5 +792,6 @@ int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 			 unsigned int rx_num, unsigned int *rx_slot);
 int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind, int boost_cap,
 			 int boost_ipk);
+int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg);
 
 #endif /* __CS35L41_H */
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index a14ad3b0d516..81cdbd84cf7d 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -235,12 +235,11 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 		case CS35L41_NOT_USED:
 			break;
 		case CS35l41_VSPK_SWITCH:
-			regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
-					   CS35L41_GPIO1_CTRL_MASK, 1 << CS35L41_GPIO1_CTRL_SHIFT);
+			hw_cfg->gpio1.func = CS35L41_GPIO;
+			hw_cfg->gpio1.out_en = true;
 			break;
 		case CS35l41_SYNC:
-			regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
-					   CS35L41_GPIO1_CTRL_MASK, 2 << CS35L41_GPIO1_CTRL_SHIFT);
+			hw_cfg->gpio1.func = CS35L41_MDSYNC_GPIO1;
 			break;
 		default:
 			dev_err(cs35l41->dev, "Invalid function %d for GPIO1\n",
@@ -254,8 +253,6 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 		case CS35L41_NOT_USED:
 			break;
 		case CS35L41_INTERRUPT:
-			regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
-					   CS35L41_GPIO2_CTRL_MASK, 2 << CS35L41_GPIO2_CTRL_SHIFT);
 			break;
 		default:
 			dev_err(cs35l41->dev, "Invalid GPIO2 function %d\n", hw_cfg->gpio2.func);
@@ -263,6 +260,8 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 		}
 	}
 
+	cs35l41_gpio_config(cs35l41->regmap, hw_cfg);
+
 	if (internal_boost) {
 		cs35l41->reg_seq = &cs35l41_hda_reg_seq_int_bst;
 		ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap,
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 905c648a8f49..3fae34a232cd 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1040,6 +1040,47 @@ int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_in
 }
 EXPORT_SYMBOL_GPL(cs35l41_boost_config);
 
+int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg)
+{
+	struct cs35l41_gpio_cfg *gpio1 = &hw_cfg->gpio1;
+	struct cs35l41_gpio_cfg *gpio2 = &hw_cfg->gpio2;
+	int irq_pol = IRQF_TRIGGER_NONE;
+
+	regmap_update_bits(regmap, CS35L41_GPIO1_CTRL1,
+			   CS35L41_GPIO_POL_MASK | CS35L41_GPIO_DIR_MASK,
+			   gpio1->pol_inv << CS35L41_GPIO_POL_SHIFT |
+			   !gpio1->out_en << CS35L41_GPIO_DIR_SHIFT);
+
+	regmap_update_bits(regmap, CS35L41_GPIO2_CTRL1,
+			   CS35L41_GPIO_POL_MASK | CS35L41_GPIO_DIR_MASK,
+			   gpio2->pol_inv << CS35L41_GPIO_POL_SHIFT |
+			   !gpio2->out_en << CS35L41_GPIO_DIR_SHIFT);
+
+	if (gpio1->valid)
+		regmap_update_bits(regmap, CS35L41_GPIO_PAD_CONTROL, CS35L41_GPIO1_CTRL_MASK,
+				   gpio1->func << CS35L41_GPIO1_CTRL_SHIFT);
+
+	if (gpio2->valid) {
+		regmap_update_bits(regmap, CS35L41_GPIO_PAD_CONTROL, CS35L41_GPIO2_CTRL_MASK,
+				   gpio2->func << CS35L41_GPIO2_CTRL_SHIFT);
+
+		switch (gpio2->func) {
+		case CS35L41_INT_PUSH_PULL_LOW_GPIO2:
+		case CS35L41_INT_OPEN_DRAIN_GPIO2:
+			irq_pol = IRQF_TRIGGER_LOW;
+			break;
+		case CS35L41_INT_PUSH_PULL_HIGH_GPIO2:
+			irq_pol = IRQF_TRIGGER_HIGH;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return irq_pol;
+}
+EXPORT_SYMBOL_GPL(cs35l41_gpio_config);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 5dbc2147209a..d25689fe0c60 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1017,49 +1017,6 @@ static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 	return 0;
 }
 
-static int cs35l41_gpio_config(struct cs35l41_private *cs35l41)
-{
-	struct cs35l41_gpio_cfg *gpio1 = &cs35l41->hw_cfg.gpio1;
-	struct cs35l41_gpio_cfg *gpio2 = &cs35l41->hw_cfg.gpio2;
-	int irq_pol = IRQF_TRIGGER_NONE;
-
-	regmap_update_bits(cs35l41->regmap, CS35L41_GPIO1_CTRL1,
-			   CS35L41_GPIO_POL_MASK | CS35L41_GPIO_DIR_MASK,
-			   gpio1->pol_inv << CS35L41_GPIO_POL_SHIFT |
-			   !gpio1->out_en << CS35L41_GPIO_DIR_SHIFT);
-
-	regmap_update_bits(cs35l41->regmap, CS35L41_GPIO2_CTRL1,
-			   CS35L41_GPIO_POL_MASK | CS35L41_GPIO_DIR_MASK,
-			   gpio2->pol_inv << CS35L41_GPIO_POL_SHIFT |
-			   !gpio2->out_en << CS35L41_GPIO_DIR_SHIFT);
-
-
-	if (gpio1->valid)
-		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
-				   CS35L41_GPIO1_CTRL_MASK,
-				   gpio1->func << CS35L41_GPIO1_CTRL_SHIFT);
-
-	if (gpio2->valid) {
-		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
-				   CS35L41_GPIO2_CTRL_MASK,
-				   gpio2->func << CS35L41_GPIO2_CTRL_SHIFT);
-
-		switch (gpio2->func) {
-		case CS35L41_INT_PUSH_PULL_LOW_GPIO2:
-		case CS35L41_INT_OPEN_DRAIN_GPIO2:
-			irq_pol = IRQF_TRIGGER_LOW;
-			break;
-		case CS35L41_INT_PUSH_PULL_HIGH_GPIO2:
-			irq_pol = IRQF_TRIGGER_HIGH;
-			break;
-		default:
-			break;
-		}
-	}
-
-	return irq_pol;
-}
-
 static int cs35l41_component_probe(struct snd_soc_component *component)
 {
 	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(component);
@@ -1367,7 +1324,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 
 	cs35l41_test_key_lock(cs35l41->dev, cs35l41->regmap);
 
-	irq_pol = cs35l41_gpio_config(cs35l41);
+	irq_pol = cs35l41_gpio_config(cs35l41->regmap, &cs35l41->hw_cfg);
 
 	/* Set interrupt masks for critical errors */
 	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1,
-- 
2.35.1

