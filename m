Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C24511F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiD0PLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbiD0PK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3661338A9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:44 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RBg6qE022428;
        Wed, 27 Apr 2022 10:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=oexWDZMMh/7506IlXy/tU91+gIURReqabzxPCviuK/4=;
 b=WTQNBVhV8D807snXKPHhjaII8By5fVUkw35/AjmyYI/NJLol8R4gQp1xHl1uo9sBbb9b
 s+emR+aNKlNGC9camdAU756IadnQMc4RPVFxiSlttA4wCZlINdqWWhmGCOLCA3qzr5Ju
 RhspINXbduk0Yggki/csBrENgkplYGAXnkYTeC1qAYghuuNGO6K4ii540DZv8MOQB8Id
 OxV57kh6tyPIkmNV5ANO/j0TOA4QFZbLTImeDA6Kt9ns4RYhILZ1alYuklk9SMdOsfq5
 lXhGA7FpiDVZ7lN0q/NSCnfwjYNGOwZa0x6+kBywdMOPpkuF4dnL3GeiHsGVwPtHB1rc Cw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xte-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:25 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B69F146C;
        Wed, 27 Apr 2022 15:07:24 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 07/26] ASoC: cs35l41: Move cs35l41 fs errata into shared code
Date:   Wed, 27 Apr 2022 16:07:01 +0100
Message-ID: <20220427150720.9194-8-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SugMQLUQVDdRxosv0negCrPeLDnd-fdI
X-Proofpoint-ORIG-GUID: SugMQLUQVDdRxosv0negCrPeLDnd-fdI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

This sequence is required to setup firmware, and will
be needed for hda driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  1 +
 sound/soc/codecs/cs35l41-lib.c | 32 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 26 ++------------------------
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 2271471225b1..d0cfb41495b0 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -879,6 +879,7 @@ int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg);
 int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
 			      enum cs35l41_cspl_mbox_cmd cmd);
+int cs35l41_write_fs_errata(struct device *dev, struct regmap *regmap);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
 bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type);
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 451d3be37157..85fe5f88d6b4 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -667,6 +667,25 @@ static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
 	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 };
 
+static const struct reg_sequence cs35l41_fs_errata_patch[] = {
+	{ CS35L41_DSP1_RX1_RATE,	0x00000001 },
+	{ CS35L41_DSP1_RX2_RATE,	0x00000001 },
+	{ CS35L41_DSP1_RX3_RATE,	0x00000001 },
+	{ CS35L41_DSP1_RX4_RATE,	0x00000001 },
+	{ CS35L41_DSP1_RX5_RATE,	0x00000001 },
+	{ CS35L41_DSP1_RX6_RATE,	0x00000001 },
+	{ CS35L41_DSP1_RX7_RATE,	0x00000001 },
+	{ CS35L41_DSP1_RX8_RATE,	0x00000001 },
+	{ CS35L41_DSP1_TX1_RATE,	0x00000001 },
+	{ CS35L41_DSP1_TX2_RATE,	0x00000001 },
+	{ CS35L41_DSP1_TX3_RATE,	0x00000001 },
+	{ CS35L41_DSP1_TX4_RATE,	0x00000001 },
+	{ CS35L41_DSP1_TX5_RATE,	0x00000001 },
+	{ CS35L41_DSP1_TX6_RATE,	0x00000001 },
+	{ CS35L41_DSP1_TX7_RATE,	0x00000001 },
+	{ CS35L41_DSP1_TX8_RATE,	0x00000001 },
+};
+
 static const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[] = {
 	{
 		.id = 0x01,
@@ -1263,6 +1282,19 @@ int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_GPL(cs35l41_set_cspl_mbox_cmd);
 
+int cs35l41_write_fs_errata(struct device *dev, struct regmap *regmap)
+{
+	int ret;
+
+	ret = regmap_multi_reg_write(regmap, cs35l41_fs_errata_patch,
+				     ARRAY_SIZE(cs35l41_fs_errata_patch));
+	if (ret < 0)
+		dev_err(dev, "Failed to write fs errata: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l41_write_fs_errata);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 0285946688f7..75527649bb14 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1093,25 +1093,6 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
 	return 0;
 }
 
-static const struct reg_sequence cs35l41_fs_errata_patch[] = {
-	{ CS35L41_DSP1_RX1_RATE,	0x00000001 },
-	{ CS35L41_DSP1_RX2_RATE,	0x00000001 },
-	{ CS35L41_DSP1_RX3_RATE,	0x00000001 },
-	{ CS35L41_DSP1_RX4_RATE,	0x00000001 },
-	{ CS35L41_DSP1_RX5_RATE,	0x00000001 },
-	{ CS35L41_DSP1_RX6_RATE,	0x00000001 },
-	{ CS35L41_DSP1_RX7_RATE,	0x00000001 },
-	{ CS35L41_DSP1_RX8_RATE,	0x00000001 },
-	{ CS35L41_DSP1_TX1_RATE,	0x00000001 },
-	{ CS35L41_DSP1_TX2_RATE,	0x00000001 },
-	{ CS35L41_DSP1_TX3_RATE,	0x00000001 },
-	{ CS35L41_DSP1_TX4_RATE,	0x00000001 },
-	{ CS35L41_DSP1_TX5_RATE,	0x00000001 },
-	{ CS35L41_DSP1_TX6_RATE,	0x00000001 },
-	{ CS35L41_DSP1_TX7_RATE,	0x00000001 },
-	{ CS35L41_DSP1_TX8_RATE,	0x00000001 },
-};
-
 static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 {
 	struct wm_adsp *dsp;
@@ -1132,12 +1113,9 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 	dsp->cs_dsp.num_mems = ARRAY_SIZE(cs35l41_dsp1_regions);
 	dsp->cs_dsp.lock_regions = 0xFFFFFFFF;
 
-	ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_fs_errata_patch,
-				     ARRAY_SIZE(cs35l41_fs_errata_patch));
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Failed to write fs errata: %d\n", ret);
+	ret = cs35l41_write_fs_errata(cs35l41->dev, cs35l41->regmap);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = wm_halo_init(dsp);
 	if (ret) {
-- 
2.32.0

