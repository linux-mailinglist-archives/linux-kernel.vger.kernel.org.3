Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B125B2337
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiIHQM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiIHQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:12:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F241FB8E9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:12:11 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B9B26601FB5;
        Thu,  8 Sep 2022 17:12:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662653530;
        bh=bJrQlXtZFjKmWBjENQnAJRAjQYFjDCeWroymGCzeWVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQDVE4Tx/oVkySDoYoQ2rXejshtJ41dAP2dDlT9lbDmC8/J12YXIg1h28UtVBElJ0
         VeXVZA8ksTM7gVumx4+JsDevIfvd/JSAwefmw01tjUuqQiSvKHfGT6csWZEZDVfqWK
         4U3qADpZgAVGdyc4fBpWhZllOv+ce5NebMqnS08pQZ3QQGXs2xUBYcE9moPQ5lwFkA
         hdwei1Kw9Vv/jiykrpltBnKC2LjF+BpBPRZrOpl2TbEBvvoPpn+ua3LlAaHO71vCNh
         TVzX9lsdYiuwRB/Qyn2SKZ2FiIGBLKZQ65QxwRk/fY7SIvO6ki830k0FXy9Kgb1PRv
         ncR0zvsdtHnTQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 06/10] ASoC: mediatek: mt8183: Remove clock share parsing from DT
Date:   Thu,  8 Sep 2022 12:11:50 -0400
Message-Id: <20220908161154.648557-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908161154.648557-1-nfraprado@collabora.com>
References: <20220908161154.648557-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the clock sharing for i2s ports can be configured from the
sound machine driver, remove the logic that was used to parse the
properties from the devicetree.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c | 31 ----------------------
 1 file changed, 31 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
index 8902ff608d26..6a9ace4180d3 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
@@ -43,7 +43,6 @@ struct mtk_afe_i2s_priv {
 	int rate; /* for determine which apll to use */
 	int low_jitter_en;
 
-	const char *share_property_name;
 	int share_i2s_id;
 
 	int mclk_id;
@@ -977,55 +976,30 @@ static const struct mtk_afe_i2s_priv mt8183_i2s_priv[DAI_I2S_NUM] = {
 	[DAI_I2S0] = {
 		.id = MT8183_DAI_I2S_0,
 		.mclk_id = MT8183_I2S0_MCK,
-		.share_property_name = "i2s0-share",
 		.share_i2s_id = -1,
 	},
 	[DAI_I2S1] = {
 		.id = MT8183_DAI_I2S_1,
 		.mclk_id = MT8183_I2S1_MCK,
-		.share_property_name = "i2s1-share",
 		.share_i2s_id = -1,
 	},
 	[DAI_I2S2] = {
 		.id = MT8183_DAI_I2S_2,
 		.mclk_id = MT8183_I2S2_MCK,
-		.share_property_name = "i2s2-share",
 		.share_i2s_id = -1,
 	},
 	[DAI_I2S3] = {
 		.id = MT8183_DAI_I2S_3,
 		.mclk_id = MT8183_I2S3_MCK,
-		.share_property_name = "i2s3-share",
 		.share_i2s_id = -1,
 	},
 	[DAI_I2S5] = {
 		.id = MT8183_DAI_I2S_5,
 		.mclk_id = MT8183_I2S5_MCK,
-		.share_property_name = "i2s5-share",
 		.share_i2s_id = -1,
 	},
 };
 
-static int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
-{
-	struct mt8183_afe_private *afe_priv = afe->platform_priv;
-	const struct device_node *of_node = afe->dev->of_node;
-	const char *of_str;
-	const char *property_name;
-	struct mtk_afe_i2s_priv *i2s_priv;
-	int i;
-
-	for (i = 0; i < DAI_I2S_NUM; i++) {
-		i2s_priv = afe_priv->dai_priv[mt8183_i2s_priv[i].id];
-		property_name = mt8183_i2s_priv[i].share_property_name;
-		if (of_property_read_string(of_node, property_name, &of_str))
-			continue;
-		i2s_priv->share_i2s_id = get_i2s_id_by_name(afe, of_str);
-	}
-
-	return 0;
-}
-
 /**
  * mt8183_dai_i2s_set_share() - Set up I2S ports to share a single clock.
  * @afe: Pointer to &struct mtk_base_afe
@@ -1100,10 +1074,5 @@ int mt8183_dai_i2s_register(struct mtk_base_afe *afe)
 	if (ret)
 		return ret;
 
-	/* parse share i2s */
-	ret = mt8183_dai_i2s_get_share(afe);
-	if (ret)
-		return ret;
-
 	return 0;
 }
-- 
2.37.3

