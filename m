Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A39599C76
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbiHSMxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349088AbiHSMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:53:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E8DDAA2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:52:50 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J5opPs018534;
        Fri, 19 Aug 2022 07:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Ak2aZKCy0O23kOpbYZpmEFVDG3qgHeAzs0mNs6uszHA=;
 b=kdaklWQMCRqta8Ymh+m0wG40ll4fd2GV1fUy17CoPMmkRhI7UCnNL/oUDcJbR0feozS4
 02uylzDGVboPB8LFlVSVZrXN0lDiychP7Swgby5y59Eego4CKarjR162Kr2IDihsc9gL
 L8dlZ3UB4A5VmS+CPIglE87SOXvo8YhQD09gAF3E2s+0H38LnM3uB4oPhuOMyTOofjL4
 eZh9DTJ/LqNk/GMnKXJ1uLLF+ONxFCoIQ948FY21Hhf7X1Af0T9wY0qujuLFUogR4LG8
 merwQwJeKlhfyYQScRY2E/+s7v77RXV6liBwEQd++xhRnki72B1ARdlWKMIElH9QTpMg WQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hx9c1yrtp-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:52:40 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 19 Aug
 2022 07:52:35 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:52:35 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0999FB16;
        Fri, 19 Aug 2022 12:52:35 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 10/12] ASoC: cs42l42: Export some functions for Soundwire
Date:   Fri, 19 Aug 2022 13:52:28 +0100
Message-ID: <20220819125230.42731-11-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220819125230.42731-1-rf@opensource.cirrus.com>
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aFDVCoQdKcqxHZRCtx0HHSJKOI0B6_RS
X-Proofpoint-GUID: aFDVCoQdKcqxHZRCtx0HHSJKOI0B6_RS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export functions that will be needed by a Soundwire module.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 14 +++++++++-----
 sound/soc/codecs/cs42l42.h |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 7f16de593424..3a4f65233360 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -650,8 +650,8 @@ static const struct cs42l42_pll_params pll_ratio_table[] = {
 	{ 24576000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1}
 };
 
-static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk,
-			      unsigned int sample_rate)
+int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk,
+		       unsigned int sample_rate)
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int i;
@@ -737,8 +737,9 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_pll_config, SND_SOC_CS42L42_CORE);
 
-static void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate)
+void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate)
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	unsigned int fs;
@@ -770,6 +771,7 @@ static void cs42l42_src_config(struct snd_soc_component *component, unsigned int
 				      CS42L42_CLK_OASRC_SEL_MASK,
 				      fs << CS42L42_CLK_OASRC_SEL_SHIFT);
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_src_config, SND_SOC_CS42L42_CORE);
 
 static int cs42l42_asp_config(struct snd_soc_component *component,
 			      unsigned int sclk, unsigned int sample_rate)
@@ -996,7 +998,7 @@ static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
 	return -EINVAL;
 }
 
-static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
@@ -1089,6 +1091,7 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_mute_stream, SND_SOC_CS42L42_CORE);
 
 #define CS42L42_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 			 SNDRV_PCM_FMTBIT_S24_LE |\
@@ -1633,7 +1636,7 @@ static const struct cs42l42_irq_params irq_params_table[] = {
 		CS42L42_TSRS_PLUG_VAL_MASK}
 };
 
-static irqreturn_t cs42l42_irq_thread(int irq, void *data)
+irqreturn_t cs42l42_irq_thread(int irq, void *data)
 {
 	struct cs42l42_private *cs42l42 = (struct cs42l42_private *)data;
 	unsigned int stickies[12];
@@ -1750,6 +1753,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_irq_thread, SND_SOC_CS42L42_CORE);
 
 static void cs42l42_set_interrupt_masks(struct cs42l42_private *cs42l42)
 {
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 942054434afd..f575ef9b5498 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -55,6 +55,11 @@ extern const struct regmap_config cs42l42_regmap;
 extern const struct snd_soc_component_driver cs42l42_soc_component;
 extern struct snd_soc_dai_driver cs42l42_dai;
 
+int cs42l42_pll_config(struct snd_soc_component *component,
+		       unsigned int clk, unsigned int sample_rate);
+void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate);
+int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream);
+irqreturn_t cs42l42_irq_thread(int irq, void *data);
 int cs42l42_suspend(struct device *dev);
 int cs42l42_resume(struct device *dev);
 void cs42l42_resume_restore(struct device *dev);
-- 
2.30.2

