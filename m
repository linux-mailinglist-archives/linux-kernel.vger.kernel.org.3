Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD26E46E33C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhLIHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:36:08 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:40056 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229530AbhLIHgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:36:07 -0500
X-UUID: b641029928e94b418ac0d281571828e2-20211209
X-UUID: b641029928e94b418ac0d281571828e2-20211209
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1055023594; Thu, 09 Dec 2021 15:32:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 9 Dec 2021 15:32:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 9 Dec 2021 15:32:27 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tzungbi@google.com>, <trevor.wu@mediatek.com>,
        <yc.hung@mediatek.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: mediatek: assign correct type to argument
Date:   Thu, 9 Dec 2021 15:32:24 +0800
Message-ID: <20211209073224.21793-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning: (new ones prefixed by >>)
>> sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33:
     sparse: sparse: incorrect type in argument 3 (different base types)
   sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:
     expected unsigned int to
   sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:
     got restricted snd_pcm_format_t [usertype]

Correct discription of format, use S32_LE and S24_LE to distinguish the
different 32bit.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c   |  8 ++++----
 .../mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 12 ++++++------
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c    |  4 ++--
 .../mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c    |  4 ++--
 .../mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c    |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index a4d26a6fc849..f8a72a5102ad 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -155,9 +155,9 @@ static const struct snd_soc_ops mt8183_da7219_rt1015_i2s_ops = {
 static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S32_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
-			     0, SNDRV_PCM_FORMAT_LAST);
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
 	params_set_format(params, SNDRV_PCM_FORMAT_S32_LE);
 
@@ -167,9 +167,9 @@ static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int mt8183_rt1015_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					     struct snd_pcm_hw_params *params)
 {
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S24_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
-			     0, SNDRV_PCM_FORMAT_LAST);
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
 	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
 
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index aeb1af86047e..d5fc86132b49 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -94,11 +94,11 @@ static const struct snd_soc_ops mt8183_mt6358_rt1015_i2s_ops = {
 static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
-	dev_dbg(rtd->dev, "%s(), fix format to 32bit\n", __func__);
+	dev_dbg(rtd->dev, "%s(), fix format to S32_LE\n", __func__);
 
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S32_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
-			     0, SNDRV_PCM_FORMAT_LAST);
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
 	params_set_format(params, SNDRV_PCM_FORMAT_S32_LE);
 	return 0;
@@ -107,11 +107,11 @@ static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int mt8183_rt1015_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					     struct snd_pcm_hw_params *params)
 {
-	dev_dbg(rtd->dev, "%s(), fix format to 32bit\n", __func__);
+	dev_dbg(rtd->dev, "%s(), fix format to S24_LE\n", __func__);
 
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S24_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
-			     0, SNDRV_PCM_FORMAT_LAST);
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
 	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index a606133951b7..1d16939f80e3 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -350,9 +350,9 @@ static int mt8192_mt6359_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 static int mt8192_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S24_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
-			     0, SNDRV_PCM_FORMAT_LAST);
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
 	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
 
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
index cca1c739e690..5cdbfaafd479 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
@@ -359,7 +359,7 @@ static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				       struct snd_pcm_hw_params *params)
 {
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S24_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
 			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
@@ -464,7 +464,7 @@ static int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				       struct snd_pcm_hw_params *params)
 
 {
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S24_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
 			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index 11a185da0d96..fa50a31e9718 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -355,7 +355,7 @@ static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				       struct snd_pcm_hw_params *params)
 {
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S24_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
 			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
@@ -463,7 +463,7 @@ static int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				       struct snd_pcm_hw_params *params)
 
 {
-	/* fix BE i2s format to 32bit, clean param mask first */
+	/* fix BE i2s format to S24_LE, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
 			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
 
-- 
2.25.1

