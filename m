Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF95B233A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiIHQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiIHQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:12:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D91223AC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:12:18 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 888606601FBA;
        Thu,  8 Sep 2022 17:12:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662653537;
        bh=jIUdtkT4ddNfSHRyN+v/gxKe5FoYLf2qnOUA50l2MJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtWMhA7rx+v6qQhy1Em7Y3pjtbUzQj8/i1otNHUbCYCcSaCUyEfcrU2ep2jWw7n+c
         Vi7Kw2+2ZrR9iKeic1dCieNkmsEanp0Dae2wZImJZrWNi7UyhFIG2bX6hvCUjh6S2R
         My48lMeVEcfu0JzQXZKVWZrHkuDftmfZ9BCePITcAodyj2OABTO2xo4MCuJfO08ZWc
         meiQP8R/jUvThecyTUbwOfNjOtkQl1GbPtCf1/xoIJwKQu8WwzWVdkHKF8OrnjPS1B
         uELc+YqiumTjSPxbkalPp1hg7QzjL51eJyZyiKGo2/hawSfVf94nhOdPd+hpTPOI/M
         VeILSfFXCcBRQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Chunxu Li <chunxu.li@mediatek.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 10/10] ASoC: mediatek: mt8186: Remove clock share parsing from DT
Date:   Thu,  8 Sep 2022 12:11:54 -0400
Message-Id: <20220908161154.648557-11-nfraprado@collabora.com>
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

 sound/soc/mediatek/mt8186/mt8186-dai-i2s.c | 30 ----------------------
 1 file changed, 30 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
index 7e8cad682c83..f07181be4370 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
@@ -44,7 +44,6 @@ struct mtk_afe_i2s_priv {
 	int low_jitter_en;
 	int master; /* only i2s0 has slave mode*/
 
-	const char *share_property_name;
 	int share_i2s_id;
 
 	int mclk_id;
@@ -1140,50 +1139,26 @@ static const struct mtk_afe_i2s_priv mt8186_i2s_priv[DAI_I2S_NUM] = {
 	[DAI_I2S0] = {
 		.id = MT8186_DAI_I2S_0,
 		.mclk_id = MT8186_I2S0_MCK,
-		.share_property_name = "i2s0-share",
 		.share_i2s_id = -1,
 	},
 	[DAI_I2S1] = {
 		.id = MT8186_DAI_I2S_1,
 		.mclk_id = MT8186_I2S1_MCK,
-		.share_property_name = "i2s1-share",
 		.share_i2s_id = -1,
 	},
 	[DAI_I2S2] = {
 		.id = MT8186_DAI_I2S_2,
 		.mclk_id = MT8186_I2S2_MCK,
-		.share_property_name = "i2s2-share",
 		.share_i2s_id = -1,
 	},
 	[DAI_I2S3] = {
 		.id = MT8186_DAI_I2S_3,
 		/*  clock gate naming is hf_faud_i2s4_m_ck*/
 		.mclk_id = MT8186_I2S4_MCK,
-		.share_property_name = "i2s3-share",
 		.share_i2s_id = -1,
 	}
 };
 
-static int mt8186_dai_i2s_get_share(struct mtk_base_afe *afe)
-{
-	struct mt8186_afe_private *afe_priv = afe->platform_priv;
-	const struct device_node *of_node = afe->dev->of_node;
-	const char *of_str;
-	const char *property_name;
-	struct mtk_afe_i2s_priv *i2s_priv;
-	int i;
-
-	for (i = 0; i < DAI_I2S_NUM; i++) {
-		i2s_priv = afe_priv->dai_priv[mt8186_i2s_priv[i].id];
-		property_name = mt8186_i2s_priv[i].share_property_name;
-		if (of_property_read_string(of_node, property_name, &of_str))
-			continue;
-		i2s_priv->share_i2s_id = get_i2s_id_by_name(afe, of_str);
-	}
-
-	return 0;
-}
-
 /**
  * mt8186_dai_i2s_set_share() - Set up I2S ports to share a single clock.
  * @afe: Pointer to &struct mtk_base_afe
@@ -1252,10 +1227,5 @@ int mt8186_dai_i2s_register(struct mtk_base_afe *afe)
 	if (ret)
 		return ret;
 
-	/* parse share i2s */
-	ret = mt8186_dai_i2s_get_share(afe);
-	if (ret)
-		return ret;
-
 	return 0;
 }
-- 
2.37.3

