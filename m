Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8574F8DB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiDHGIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiDHGIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:08:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CFE76657;
        Thu,  7 Apr 2022 23:06:04 -0700 (PDT)
X-UUID: bfbcc3fa30bd43429af1d8dd72a6b18a-20220408
X-UUID: bfbcc3fa30bd43429af1d8dd72a6b18a-20220408
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 297700657; Fri, 08 Apr 2022 14:05:58 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 8 Apr 2022 14:05:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Apr
 2022 14:05:58 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 14:05:57 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <nfraprado@collabora.com>, <tzungbi@google.com>
CC:     <angelogioacchino.delregno@collabora.com>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [v10 3/4] ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI links of headset
Date:   Fri, 8 Apr 2022 14:05:51 +0800
Message-ID: <20220408060552.26607-4-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408060552.26607-1-jiaxin.yu@mediatek.com>
References: <20220408060552.26607-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the refactoring to allow the same machine driver to be used for
the rt1015(p) and rt5682(s) codecs on the MT8192 platform, parse the
rt5682(s) codec from the headset-codec property in the devicetree and wire
it to the I2S8 and I2S9 backends.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 34 ++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 15711448d259..4a11f687d416 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -28,9 +28,6 @@
 #define RT1015_DEV0_NAME	"rt1015.1-0028"
 #define RT1015_DEV1_NAME	"rt1015.1-0029"
 
-#define RT5682_CODEC_DAI	"rt5682-aif1"
-#define RT5682_DEV0_NAME	"rt5682.1-001a"
-
 struct mt8192_mt6359_priv {
 	struct snd_soc_jack headset_jack;
 	struct snd_soc_jack hdmi_jack;
@@ -626,14 +623,12 @@ SND_SOC_DAILINK_DEFS(i2s7,
 
 SND_SOC_DAILINK_DEFS(i2s8,
 		     DAILINK_COMP_ARRAY(COMP_CPU("I2S8")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC(RT5682_DEV0_NAME,
-						   RT5682_CODEC_DAI)),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(i2s9,
 		     DAILINK_COMP_ARRAY(COMP_CPU("I2S9")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC(RT5682_DEV0_NAME,
-						   RT5682_CODEC_DAI)),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(connsys_i2s,
@@ -1114,7 +1109,7 @@ static int mt8192_mt6359_card_set_be_link(struct snd_soc_card *card,
 static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
-	struct device_node *platform_node, *hdmi_codec, *speaker_codec;
+	struct device_node *platform_node, *hdmi_codec, *headset_codec, *speaker_codec;
 	int ret, i;
 	struct snd_soc_dai_link *dai_link;
 	struct mt8192_mt6359_priv *priv;
@@ -1142,6 +1137,13 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 		goto err_speaker_codec;
 	}
 
+	headset_codec = of_get_child_by_name(pdev->dev.of_node, "headset-codec");
+	if (!headset_codec) {
+		ret = -EINVAL;
+		dev_err_probe(&pdev->dev, ret, "Property 'headset-codec' missing or invalid\n");
+		goto err_headset_codec;
+	}
+
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = mt8192_mt6359_card_set_be_link(card, dai_link, speaker_codec, "I2S3");
 		if (ret) {
@@ -1150,6 +1152,20 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 			goto err_probe;
 		}
 
+		ret = mt8192_mt6359_card_set_be_link(card, dai_link, headset_codec, "I2S8");
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
+				      dai_link->name);
+			goto err_probe;
+		}
+
+		ret = mt8192_mt6359_card_set_be_link(card, dai_link, headset_codec, "I2S9");
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
+				      dai_link->name);
+			goto err_probe;
+		}
+
 		if (hdmi_codec && strcmp(dai_link->name, "TDM") == 0) {
 			dai_link->codecs->of_node = hdmi_codec;
 			dai_link->ignore = 0;
@@ -1180,6 +1196,8 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n", __func__);
 
 err_probe:
+	of_node_put(headset_codec);
+err_headset_codec:
 	of_node_put(speaker_codec);
 err_speaker_codec:
 	of_node_put(platform_node);
-- 
2.25.1

