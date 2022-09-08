Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979A5B2332
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiIHQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiIHQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:12:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1BFEB84B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:12:08 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA9846601FB3;
        Thu,  8 Sep 2022 17:12:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662653526;
        bh=1m8CobNwZn4GhVwZE+bnolPPFRG5PI3OCAmyya1eAAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXi4qRc1Z4CqK2vX59XBgyqXt/EKvwcoMQvhBcNRm9auQetdppCb3o1TMd26hhmQk
         5ByJWTReYOHoFECKSxGvFHHj08WqNjQkpkJTvS3pfWc9rMjaH//yttXpb938dSlwpz
         PAsM/6AZRxa/a3DNTokHEoZi2C3UGwmu13IQ4nND6pqiNVDjNaG0Pam3Hg4NvEH1Mv
         a3GF4G8PJ3SizXkExy6WEgzRT5xxTcPy3BRg2Xz44nzWegMw2KyOxnCoB9vuxy5KK1
         +ojlAq2aBAlL3a7xHdFQ61ozPaeeN1sQbjGMW0GEz7kp9S8C/JwpnkaCm5FA5+Olj1
         CBtlDEE0q1FHA==
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
Subject: [PATCH 04/10] ASoC: mediatek: mt8183: Allow setting shared clocks from machine driver
Date:   Thu,  8 Sep 2022 12:11:48 -0400
Message-Id: <20220908161154.648557-5-nfraprado@collabora.com>
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

Add a new function to configure the shared clock between two i2s ports,
and export it. This will allow the clock sharing to be set from the
machine driver instead of the devicetree.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/mediatek/mt8183/mt8183-afe-common.h |  3 +++
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c    | 26 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-common.h b/sound/soc/mediatek/mt8183/mt8183-afe-common.h
index b220e7a7db7e..40ab48c1566c 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-common.h
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-common.h
@@ -99,6 +99,9 @@ unsigned int mt8183_general_rate_transform(struct device *dev,
 unsigned int mt8183_rate_transform(struct device *dev,
 				   unsigned int rate, int aud_blk);
 
+int mt8183_dai_i2s_set_share(struct mtk_base_afe *afe, const char *main_i2s_name,
+			     const char *secondary_i2s_name);
+
 /* dai register */
 int mt8183_dai_adda_register(struct mtk_base_afe *afe);
 int mt8183_dai_pcm_register(struct mtk_base_afe *afe);
diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
index 138591d71ebd..8902ff608d26 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
@@ -1026,6 +1026,32 @@ static int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 	return 0;
 }
 
+/**
+ * mt8183_dai_i2s_set_share() - Set up I2S ports to share a single clock.
+ * @afe: Pointer to &struct mtk_base_afe
+ * @main_i2s_name: The name of the I2S port that will provide the clock
+ * @secondary_i2s_name: The name of the I2S port that will use this clock
+ */
+int mt8183_dai_i2s_set_share(struct mtk_base_afe *afe, const char *main_i2s_name,
+			     const char *secondary_i2s_name)
+{
+	struct mtk_afe_i2s_priv *secondary_i2s_priv;
+	int main_i2s_id;
+
+	secondary_i2s_priv = get_i2s_priv_by_name(afe, secondary_i2s_name);
+	if (!secondary_i2s_priv)
+		return -EINVAL;
+
+	main_i2s_id = get_i2s_id_by_name(afe, main_i2s_name);
+	if (main_i2s_id < 0)
+		return main_i2s_id;
+
+	secondary_i2s_priv->share_i2s_id = main_i2s_id;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt8183_dai_i2s_set_share);
+
 static int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
-- 
2.37.3

