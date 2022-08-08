Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC358CA70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbiHHOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbiHHOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:21:22 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 07:21:19 PDT
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76953E021
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:21:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1659968028; bh=ib8r/AIaYsAtqmifxmdDYYXoFfRn3JeYUHoc/D5TFUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eW9gGOFo44UUq67FI8Mu6BGtibqGBZpNhNXfQKXXXuTt0PTUARFcfL3FeLR+5fi5S
         f/5zjGOnMQ9AqKGTuyftEWhBTiYa8ebymuU3j/o8X42gfOYptboHGz+RKO/T/Yaj74
         BCdbnvx8VhMteB6qdcyR8RAjviiFCuTIOMz2fgGI=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Stephen Kitt <steve@sk2.org>,
        Frank Shi <shifu0704@thundersoft.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 1/4] ASoC: tas2770: Set correct FSYNC polarity
Date:   Mon,  8 Aug 2022 16:12:43 +0200
Message-Id: <20220808141246.5749-2-povik+lin@cutebit.org>
In-Reply-To: <20220808141246.5749-1-povik+lin@cutebit.org>
References: <20220808141246.5749-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix setting of FSYNC polarity for DAI formats other than I2S. Also
add support for polarity inversion.

Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2770.c | 20 +++++++++++++++++++-
 sound/soc/codecs/tas2770.h |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c1dbd978d550..10b64d5ba756 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -337,7 +337,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	struct snd_soc_component *component = dai->component;
 	struct tas2770_priv *tas2770 =
 			snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, invert_fpol = 0, fpol_preinv = 0, asi_cfg_1 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -349,9 +349,15 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_IF:
+		invert_fpol = 1;
+		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 |= TAS2770_TDM_CFG_REG1_RX_RSING;
 		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		invert_fpol = 1;
+		fallthrough;
 	case SND_SOC_DAIFMT_IB_NF:
 		asi_cfg_1 |= TAS2770_TDM_CFG_REG1_RX_FALING;
 		break;
@@ -369,15 +375,19 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		tdm_rx_start_slot = 1;
+		fpol_preinv = 0;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		tdm_rx_start_slot = 0;
+		fpol_preinv = 1;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		tdm_rx_start_slot = 1;
+		fpol_preinv = 1;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		tdm_rx_start_slot = 0;
+		fpol_preinv = 1;
 		break;
 	default:
 		dev_err(tas2770->dev,
@@ -391,6 +401,14 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
+					    TAS2770_TDM_CFG_REG0_FPOL_MASK,
+					    (fpol_preinv ^ invert_fpol)
+					     ? TAS2770_TDM_CFG_REG0_FPOL_RSING
+					     : TAS2770_TDM_CFG_REG0_FPOL_FALING);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index d156666bcc55..d51e88d8c338 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -41,6 +41,9 @@
 #define TAS2770_TDM_CFG_REG0_31_44_1_48KHZ  0x6
 #define TAS2770_TDM_CFG_REG0_31_88_2_96KHZ  0x8
 #define TAS2770_TDM_CFG_REG0_31_176_4_192KHZ  0xa
+#define TAS2770_TDM_CFG_REG0_FPOL_MASK  BIT(0)
+#define TAS2770_TDM_CFG_REG0_FPOL_RSING  0
+#define TAS2770_TDM_CFG_REG0_FPOL_FALING  1
     /* TDM Configuration Reg1 */
 #define TAS2770_TDM_CFG_REG1  TAS2770_REG(0X0, 0x0B)
 #define TAS2770_TDM_CFG_REG1_MASK	GENMASK(5, 1)
-- 
2.33.0

