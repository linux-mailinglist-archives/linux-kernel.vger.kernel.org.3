Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51812511DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiD0PLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbiD0PK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6063207D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:45 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RBg6qD022428;
        Wed, 27 Apr 2022 10:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=xUFf/tHEB9c65AsWJmwCDUemoEDqn+aYh1RJ+ogl2xY=;
 b=fFCsMXu/6kIrK/YkJFxWnY6eyJcFujxnOnjpElRS+XLzEJgUm9aP8D7G+LVZqaNtw6fi
 Qxi3XUn0eG3qUZGdUY7ODJ/w8/edsaBG4xsCRFC6DnwR7kGAfxY45jIZbLOO6tBp8F36
 NCB9IMgUiw/Slx3DiknlVXiRZmZoFaxrAcTjscpiASD5HlNY2me8lcQHNqHaxsc1XJuU
 den7Fe6rbDcJndFAZqT1+jNcdFhwVZtsWF7ziPcvKTuCTyBNK780u/7BS7uSn3E3TMMl
 MNQJTVuYLWoGsGLWTpk58xUuuooWZs79WsTFYUGSxluVF7gGIypIj7uWhftRLMdAo3OU VQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xte-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:24 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 267FC46C;
        Wed, 27 Apr 2022 15:07:24 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 06/26] ASoC: cs35l41: Move cs35l41_set_cspl_mbox_cmd to shared code
Date:   Wed, 27 Apr 2022 16:07:00 +0100
Message-ID: <20220427150720.9194-7-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xfJ8G3Cz57CCrLbMaEgXK0pHFlNDxw5f
X-Proofpoint-ORIG-GUID: xfJ8G3Cz57CCrLbMaEgXK0pHFlNDxw5f
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

This function is used to control the DSP Firmware for cs35l41,
and will be needed by the cs35l41 hda driver, when firmware
support is added.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 include/sound/cs35l41.h        | 20 ++++++++++
 sound/soc/codecs/cs35l41-lib.c | 57 ++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 69 +++-------------------------------
 sound/soc/codecs/cs35l41.h     | 18 ---------
 4 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 8e4b125c81c8..2271471225b1 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -801,6 +801,24 @@ struct cs35l41_otp_map_element_t {
 	u32 word_offset;
 };
 
+enum cs35l41_cspl_mbox_status {
+	CSPL_MBOX_STS_RUNNING = 0,
+	CSPL_MBOX_STS_PAUSED = 1,
+	CSPL_MBOX_STS_RDY_FOR_REINIT = 2,
+};
+
+enum cs35l41_cspl_mbox_cmd {
+	CSPL_MBOX_CMD_NONE = 0,
+	CSPL_MBOX_CMD_PAUSE = 1,
+	CSPL_MBOX_CMD_RESUME = 2,
+	CSPL_MBOX_CMD_REINIT = 3,
+	CSPL_MBOX_CMD_STOP_PRE_REINIT = 4,
+	CSPL_MBOX_CMD_HIBERNATE = 5,
+	CSPL_MBOX_CMD_OUT_OF_HIBERNATE = 6,
+	CSPL_MBOX_CMD_UNKNOWN_CMD = -1,
+	CSPL_MBOX_CMD_INVALID_SEQUENCE = -2,
+};
+
 /*
  * IRQs
  */
@@ -859,6 +877,8 @@ int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 			 unsigned int tx_num, unsigned int *tx_slot,
 			 unsigned int rx_num, unsigned int *rx_slot);
 int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg);
+int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
+			      enum cs35l41_cspl_mbox_cmd cmd);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
 bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type);
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 491616c7c5c7..451d3be37157 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1206,6 +1206,63 @@ int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg)
 }
 EXPORT_SYMBOL_GPL(cs35l41_gpio_config);
 
+static bool cs35l41_check_cspl_mbox_sts(enum cs35l41_cspl_mbox_cmd cmd,
+					enum cs35l41_cspl_mbox_status sts)
+{
+	switch (cmd) {
+	case CSPL_MBOX_CMD_NONE:
+	case CSPL_MBOX_CMD_UNKNOWN_CMD:
+		return true;
+	case CSPL_MBOX_CMD_PAUSE:
+	case CSPL_MBOX_CMD_OUT_OF_HIBERNATE:
+		return (sts == CSPL_MBOX_STS_PAUSED);
+	case CSPL_MBOX_CMD_RESUME:
+		return (sts == CSPL_MBOX_STS_RUNNING);
+	case CSPL_MBOX_CMD_REINIT:
+		return (sts == CSPL_MBOX_STS_RUNNING);
+	case CSPL_MBOX_CMD_STOP_PRE_REINIT:
+		return (sts == CSPL_MBOX_STS_RDY_FOR_REINIT);
+	default:
+		return false;
+	}
+}
+
+int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
+			      enum cs35l41_cspl_mbox_cmd cmd)
+{
+	unsigned int sts = 0, i;
+	int ret;
+
+	// Set mailbox cmd
+	ret = regmap_write(regmap, CS35L41_DSP_VIRT1_MBOX_1, cmd);
+	if (ret < 0) {
+		if (cmd != CSPL_MBOX_CMD_OUT_OF_HIBERNATE)
+			dev_err(dev, "Failed to write MBOX: %d\n", ret);
+		return ret;
+	}
+
+	// Read mailbox status and verify it is appropriate for the given cmd
+	for (i = 0; i < 5; i++) {
+		usleep_range(1000, 1100);
+
+		ret = regmap_read(regmap, CS35L41_DSP_MBOX_2, &sts);
+		if (ret < 0) {
+			dev_err(dev, "Failed to read MBOX STS: %d\n", ret);
+			continue;
+		}
+
+		if (!cs35l41_check_cspl_mbox_sts(cmd, sts))
+			dev_dbg(dev, "[%u] cmd %u returned invalid sts %u", i, cmd, sts);
+		else
+			return 0;
+	}
+
+	dev_err(dev, "Failed to set mailbox cmd %u (status %u)\n", cmd, sts);
+
+	return -ENOMSG;
+}
+EXPORT_SYMBOL_GPL(cs35l41_set_cspl_mbox_cmd);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 912196f45648..0285946688f7 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -208,67 +208,6 @@ static int cs35l41_dsp_preload_ev(struct snd_soc_dapm_widget *w,
 	}
 }
 
-static bool cs35l41_check_cspl_mbox_sts(enum cs35l41_cspl_mbox_cmd cmd,
-					enum cs35l41_cspl_mbox_status sts)
-{
-	switch (cmd) {
-	case CSPL_MBOX_CMD_NONE:
-	case CSPL_MBOX_CMD_UNKNOWN_CMD:
-		return true;
-	case CSPL_MBOX_CMD_PAUSE:
-	case CSPL_MBOX_CMD_OUT_OF_HIBERNATE:
-		return (sts == CSPL_MBOX_STS_PAUSED);
-	case CSPL_MBOX_CMD_RESUME:
-		return (sts == CSPL_MBOX_STS_RUNNING);
-	case CSPL_MBOX_CMD_REINIT:
-		return (sts == CSPL_MBOX_STS_RUNNING);
-	case CSPL_MBOX_CMD_STOP_PRE_REINIT:
-		return (sts == CSPL_MBOX_STS_RDY_FOR_REINIT);
-	default:
-		return false;
-	}
-}
-
-static int cs35l41_set_cspl_mbox_cmd(struct cs35l41_private *cs35l41,
-				     enum cs35l41_cspl_mbox_cmd cmd)
-{
-	unsigned int sts = 0, i;
-	int ret;
-
-	// Set mailbox cmd
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP_VIRT1_MBOX_1, cmd);
-	if (ret < 0) {
-		if (cmd != CSPL_MBOX_CMD_OUT_OF_HIBERNATE)
-			dev_err(cs35l41->dev, "Failed to write MBOX: %d\n", ret);
-		return ret;
-	}
-
-	// Read mailbox status and verify it is appropriate for the given cmd
-	for (i = 0; i < 5; i++) {
-		usleep_range(1000, 1100);
-
-		ret = regmap_read(cs35l41->regmap, CS35L41_DSP_MBOX_2, &sts);
-		if (ret < 0) {
-			dev_err(cs35l41->dev, "Failed to read MBOX STS: %d\n", ret);
-			continue;
-		}
-
-		if (!cs35l41_check_cspl_mbox_sts(cmd, sts)) {
-			dev_dbg(cs35l41->dev,
-				"[%u] cmd %u returned invalid sts %u",
-				i, cmd, sts);
-		} else {
-			return 0;
-		}
-	}
-
-	dev_err(cs35l41->dev,
-		"Failed to set mailbox cmd %u (status %u)\n",
-		cmd, sts);
-
-	return -ENOMSG;
-}
-
 static int cs35l41_dsp_audio_ev(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
@@ -299,9 +238,11 @@ static int cs35l41_dsp_audio_ev(struct snd_soc_dapm_widget *w,
 			return -EINVAL;
 		}
 
-		return cs35l41_set_cspl_mbox_cmd(cs35l41, CSPL_MBOX_CMD_RESUME);
+		return cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap,
+						 CSPL_MBOX_CMD_RESUME);
 	case SND_SOC_DAPM_PRE_PMD:
-		return cs35l41_set_cspl_mbox_cmd(cs35l41, CSPL_MBOX_CMD_PAUSE);
+		return cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap,
+						 CSPL_MBOX_CMD_PAUSE);
 	default:
 		return 0;
 	}
@@ -1475,7 +1416,7 @@ static int cs35l41_exit_hibernate(struct cs35l41_private *cs35l41)
 		dev_dbg(cs35l41->dev, "Exit hibernate\n");
 
 		for (j = 0; j < wake_retries; j++) {
-			ret = cs35l41_set_cspl_mbox_cmd(cs35l41,
+			ret = cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap,
 							CSPL_MBOX_CMD_OUT_OF_HIBERNATE);
 			if (!ret)
 				break;
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index e3369e0aa89f..c85cbc1dd333 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -23,24 +23,6 @@
 
 extern const struct dev_pm_ops cs35l41_pm_ops;
 
-enum cs35l41_cspl_mbox_status {
-	CSPL_MBOX_STS_RUNNING = 0,
-	CSPL_MBOX_STS_PAUSED = 1,
-	CSPL_MBOX_STS_RDY_FOR_REINIT = 2,
-};
-
-enum cs35l41_cspl_mbox_cmd {
-	CSPL_MBOX_CMD_NONE = 0,
-	CSPL_MBOX_CMD_PAUSE = 1,
-	CSPL_MBOX_CMD_RESUME = 2,
-	CSPL_MBOX_CMD_REINIT = 3,
-	CSPL_MBOX_CMD_STOP_PRE_REINIT = 4,
-	CSPL_MBOX_CMD_HIBERNATE = 5,
-	CSPL_MBOX_CMD_OUT_OF_HIBERNATE = 6,
-	CSPL_MBOX_CMD_UNKNOWN_CMD = -1,
-	CSPL_MBOX_CMD_INVALID_SEQUENCE = -2,
-};
-
 struct cs35l41_private {
 	struct wm_adsp dsp; /* needs to be first member */
 	struct snd_soc_codec *codec;
-- 
2.32.0

