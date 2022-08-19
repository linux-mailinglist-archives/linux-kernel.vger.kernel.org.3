Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEAC599C50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiHSMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349072AbiHSMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:52:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465A9DAB9D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:52:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JBix0Q020060;
        Fri, 19 Aug 2022 07:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=nKtJZgoVT5msd6d2g2FF3eUTwfX6urlD3iU/MkRT4Ow=;
 b=DIFGxJiK1LabfmgyE6ysA2LXVuQ6SFYPkvYOvc6XP0XOt3vXgCCIfOgYx8eeu7FKCytN
 +SRg9IMu2MvwreA3vOffGlSEb4U6QGh+AztP6PjLYjITvF4420IUZ7bXhUKydLP03urT
 ERkaOXndxklQYvBdxV/d8Ec1INJB3YBuMWChXDUej9H7jDORi4flNfMp4hKWzmpPdXsj
 xvTa/07OhsaLvTL6YXxSBtlD52zctqI7M3KNel+hBUzy595TcPSfHRE5F3p2/JssgacX
 FjuZ9dCcgOUC/T0Xpi+nE5k4Q4pluS2J2aKrd17qsruU7Rhzyv9cwZUxtExXYgYlgvuM yQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpfuvn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:52:36 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 19 Aug
 2022 07:52:34 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:52:34 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A4A43B0E;
        Fri, 19 Aug 2022 12:52:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 04/12] ASoC: cs42l42: Separate ASP config from PLL config
Date:   Fri, 19 Aug 2022 13:52:22 +0100
Message-ID: <20220819125230.42731-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220819125230.42731-1-rf@opensource.cirrus.com>
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nlssAeiSidrrLH-vAN240o8wIKYT_HaR
X-Proofpoint-GUID: nlssAeiSidrrLH-vAN240o8wIKYT_HaR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup of the ASP (audio serial port) was being done as a side-effect of
cs42l42_pll_config() and forces a restriction on the ratio of sample_rate
to bit_clock that is invalid for Soundwire.

Move the ASP setup into a dedicated function.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 81 +++++++++++++++++++++-----------------
 sound/soc/codecs/cs42l42.h |  1 -
 2 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 66c10d24169d..946b2a935256 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -654,7 +654,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int i;
-	u32 fsync;
 
 	/* Don't reconfigure if there is an audio stream running */
 	if (cs42l42->stream_use) {
@@ -680,40 +679,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
 					(pll_ratio_table[i].mclk_int !=
 					24000000)) <<
 					CS42L42_INTERNAL_FS_SHIFT);
-
-			/* Set up the LRCLK */
-			fsync = clk / cs42l42->srate;
-			if (((fsync * cs42l42->srate) != clk)
-				|| ((fsync % 2) != 0)) {
-				dev_err(component->dev,
-					"Unsupported sclk %d/sample rate %d\n",
-					clk,
-					cs42l42->srate);
-				return -EINVAL;
-			}
-			/* Set the LRCLK period */
-			snd_soc_component_update_bits(component,
-					CS42L42_FSYNC_P_LOWER,
-					CS42L42_FSYNC_PERIOD_MASK,
-					CS42L42_FRAC0_VAL(fsync - 1) <<
-					CS42L42_FSYNC_PERIOD_SHIFT);
-			snd_soc_component_update_bits(component,
-					CS42L42_FSYNC_P_UPPER,
-					CS42L42_FSYNC_PERIOD_MASK,
-					CS42L42_FRAC1_VAL(fsync - 1) <<
-					CS42L42_FSYNC_PERIOD_SHIFT);
-			/* Set the LRCLK to 50% duty cycle */
-			fsync = fsync / 2;
-			snd_soc_component_update_bits(component,
-					CS42L42_FSYNC_PW_LOWER,
-					CS42L42_FSYNC_PULSE_WIDTH_MASK,
-					CS42L42_FRAC0_VAL(fsync - 1) <<
-					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
-			snd_soc_component_update_bits(component,
-					CS42L42_FSYNC_PW_UPPER,
-					CS42L42_FSYNC_PULSE_WIDTH_MASK,
-					CS42L42_FRAC1_VAL(fsync - 1) <<
-					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
 			if (pll_ratio_table[i].mclk_src_sel == 0) {
 				/* Pass the clock straight through */
 				snd_soc_component_update_bits(component,
@@ -805,6 +770,46 @@ static void cs42l42_src_config(struct snd_soc_component *component, unsigned int
 				      fs << CS42L42_CLK_OASRC_SEL_SHIFT);
 }
 
+static int cs42l42_asp_config(struct snd_soc_component *component,
+			      unsigned int sclk, unsigned int sample_rate)
+{
+	u32 fsync = sclk / sample_rate;
+
+	/* Set up the LRCLK */
+	if (((fsync * sample_rate) != sclk) || ((fsync % 2) != 0)) {
+		dev_err(component->dev,
+			"Unsupported sclk %d/sample rate %d\n",
+			sclk,
+			sample_rate);
+		return -EINVAL;
+	}
+	/* Set the LRCLK period */
+	snd_soc_component_update_bits(component,
+				      CS42L42_FSYNC_P_LOWER,
+				      CS42L42_FSYNC_PERIOD_MASK,
+				      CS42L42_FRAC0_VAL(fsync - 1) <<
+				      CS42L42_FSYNC_PERIOD_SHIFT);
+	snd_soc_component_update_bits(component,
+				      CS42L42_FSYNC_P_UPPER,
+				      CS42L42_FSYNC_PERIOD_MASK,
+				      CS42L42_FRAC1_VAL(fsync - 1) <<
+				      CS42L42_FSYNC_PERIOD_SHIFT);
+	/* Set the LRCLK to 50% duty cycle */
+	fsync = fsync / 2;
+	snd_soc_component_update_bits(component,
+				      CS42L42_FSYNC_PW_LOWER,
+				      CS42L42_FSYNC_PULSE_WIDTH_MASK,
+				      CS42L42_FRAC0_VAL(fsync - 1) <<
+				      CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
+	snd_soc_component_update_bits(component,
+				      CS42L42_FSYNC_PW_UPPER,
+				      CS42L42_FSYNC_PULSE_WIDTH_MASK,
+				      CS42L42_FRAC1_VAL(fsync - 1) <<
+				      CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
+
+	return 0;
+}
+
 static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = codec_dai->component;
@@ -900,8 +905,6 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	unsigned int bclk;
 	int ret;
 
-	cs42l42->srate = params_rate(params);
-
 	if (cs42l42->sclk) {
 		/* machine driver has set the SCLK */
 		bclk = cs42l42->sclk;
@@ -959,6 +962,10 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
+	ret = cs42l42_asp_config(component, bclk, sample_rate);
+	if (ret)
+		return ret;
+
 	cs42l42_src_config(component, sample_rate);
 
 	return 0;
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index b4ba1467c558..2e4e01f9e389 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -31,7 +31,6 @@ struct  cs42l42_private {
 	struct mutex irq_lock;
 	int pll_config;
 	u32 sclk;
-	u32 srate;
 	u8 plug_state;
 	u8 hs_type;
 	u8 ts_inv;
-- 
2.30.2

