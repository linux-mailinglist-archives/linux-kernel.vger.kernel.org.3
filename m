Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED29562BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiGAG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiGAG2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:28:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130EB101D5;
        Thu, 30 Jun 2022 23:28:19 -0700 (PDT)
X-UUID: 91811ca6c2924fdea75ffc103b4b6ccc-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:8404843f-f21f-4704-b6c4-d7094d8f5cf8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:87442a2,CLOUDID:a99b4586-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 91811ca6c2924fdea75ffc103b4b6ccc-20220701
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 903881029; Fri, 01 Jul 2022 14:28:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 1 Jul 2022 14:28:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 1 Jul 2022 14:28:12 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <matthias.bgg@gmail.com>, <deller@gmx.de>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
        <liangxu.xu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v13 10/10] drm/mediatek: fix no audio when resolution change
Date:   Fri, 1 Jul 2022 14:28:08 +0800
Message-ID: <20220701062808.18596-11-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220701062808.18596-1-rex-bc.chen@mediatek.com>
References: <20220701062808.18596-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching resolutions, config the audio setting with the
previous audio parameters.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 54 ++++++++++---------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index f1d800b0c76e..a72631cb1888 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -105,7 +105,7 @@ struct mtk_dp_audio_cfg {
 struct mtk_dp_info {
 	u32 depth;
 	enum dp_pixelformat format;
-	struct mtk_dp_audio_cfg audio_caps;
+	struct mtk_dp_audio_cfg audio_cur_cfg;
 	struct mtk_dp_timings timings;
 };
 
@@ -1879,9 +1879,7 @@ static bool mtk_dp_edid_parse_audio_capabilities(struct mtk_dp *mtk_dp,
 						 struct mtk_dp_audio_cfg *cfg)
 {
 	struct cea_sad *sads;
-	int sad_count;
-	int i;
-	bool ret = false;
+	int ret;
 
 	if (mtk_dp_is_edp(mtk_dp))
 		return false;
@@ -1892,36 +1890,16 @@ static bool mtk_dp_edid_parse_audio_capabilities(struct mtk_dp *mtk_dp,
 		dev_err(mtk_dp->dev, "EDID not found!\n");
 		return false;
 	}
-	sad_count = drm_edid_to_sad(mtk_dp->edid, &sads);
-	mutex_unlock(&mtk_dp->edid_lock);
 
-	if (sad_count <= 0) {
+	ret = drm_edid_to_sad(mtk_dp->edid, &sads);
+	mutex_unlock(&mtk_dp->edid_lock);
+	if (ret <= 0) {
 		drm_info(mtk_dp->drm_dev, "The SADs is NULL\n");
 		return false;
 	}
-
-	for (i = 0; i < sad_count; i++) {
-		int sample_rate, word_length;
-
-		/* Only PCM supported at the moment */
-		if (sads[i].format != HDMI_AUDIO_CODING_TYPE_PCM)
-			continue;
-
-		sample_rate = drm_cea_sad_get_sample_rate(&sads[i]);
-		word_length =
-			drm_cea_sad_get_uncompressed_word_length(&sads[i]);
-		if (sample_rate <= 0 || word_length <= 0)
-			continue;
-
-		cfg->channels = sads[i].channels;
-		cfg->word_length_bits = word_length;
-		cfg->sample_rate = sample_rate;
-		ret = true;
-		break;
-	}
 	kfree(sads);
 
-	return ret;
+	return true;
 }
 
 static void mtk_dp_train_change_mode(struct mtk_dp *mtk_dp)
@@ -2097,13 +2075,13 @@ static int mtk_dp_training(struct mtk_dp *mtk_dp)
 
 	mtk_dp->audio_enable =
 		mtk_dp_edid_parse_audio_capabilities(mtk_dp,
-						     &mtk_dp->info.audio_caps);
+						     &mtk_dp->info.audio_cur_cfg);
 	if (mtk_dp->audio_enable) {
-		mtk_dp_audio_setup(mtk_dp, &mtk_dp->info.audio_caps);
+		mtk_dp_audio_setup(mtk_dp, &mtk_dp->info.audio_cur_cfg);
 		mtk_dp_audio_mute(mtk_dp, false);
 	} else {
-		memset(&mtk_dp->info.audio_caps, 0,
-		       sizeof(mtk_dp->info.audio_caps));
+		memset(&mtk_dp->info.audio_cur_cfg, 0,
+		       sizeof(mtk_dp->info.audio_cur_cfg));
 	}
 
 	return 0;
@@ -2526,6 +2504,9 @@ static void mtk_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 	if (mtk_dp_plug_state(mtk_dp)) {
 		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POWER_D3);
 		usleep_range(2000, 3000);
+	} else {
+		memset(&mtk_dp->info.audio_cur_cfg, 0,
+		       sizeof(mtk_dp->info.audio_cur_cfg));
 	}
 
 	mtk_dp_video_mute(mtk_dp, true);
@@ -2736,18 +2717,17 @@ static int mtk_dp_audio_hw_params(struct device *dev, void *data,
 				  struct hdmi_codec_params *params)
 {
 	struct mtk_dp *mtk_dp = dev_get_drvdata(dev);
-	struct mtk_dp_audio_cfg cfg;
 
 	if (!mtk_dp->enabled) {
 		pr_err("%s, DP is not ready!\n", __func__);
 		return -ENODEV;
 	}
 
-	cfg.channels = params->cea.channels;
-	cfg.sample_rate = params->sample_rate;
-	cfg.word_length_bits = 24;
+	mtk_dp->info.audio_cur_cfg.channels = params->cea.channels;
+	mtk_dp->info.audio_cur_cfg.sample_rate = params->sample_rate;
+	mtk_dp->info.audio_cur_cfg.word_length_bits = 24;
 
-	mtk_dp_audio_setup(mtk_dp, &cfg);
+	mtk_dp_audio_setup(mtk_dp, &mtk_dp->info.audio_cur_cfg);
 
 	return 0;
 }
-- 
2.18.0

