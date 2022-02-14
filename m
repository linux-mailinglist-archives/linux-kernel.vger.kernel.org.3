Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54A94B41D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbiBNGMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:12:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiBNGML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:12:11 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC44517C8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:12:04 -0800 (PST)
X-UUID: 804206638c494790b379c756bf117352-20220214
X-UUID: 804206638c494790b379c756bf117352-20220214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1051305853; Mon, 14 Feb 2022 14:12:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Feb 2022 14:12:00 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:11:58 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
CC:     James Wang <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        <iommu@lists.linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, Rob Clark <robdclark@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH 20/23] ASoC: codecs: wcd938x: Make use of the helper component_compare/release_of
Date:   Mon, 14 Feb 2022 14:08:16 +0800
Message-ID: <20220214060819.7334-21-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220214060819.7334-1-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common compare/release helpers from component.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 sound/soc/codecs/wcd938x.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index eff200a07d9f..54f4a41ceca2 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4417,16 +4417,6 @@ static const struct component_master_ops wcd938x_comp_ops = {
 	.unbind = wcd938x_unbind,
 };
 
-static int wcd938x_compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static void wcd938x_release_of(struct device *dev, void *data)
-{
-	of_node_put(data);
-}
-
 static int wcd938x_add_slave_components(struct wcd938x_priv *wcd938x,
 					struct device *dev,
 					struct component_match **matchptr)
@@ -4442,8 +4432,8 @@ static int wcd938x_add_slave_components(struct wcd938x_priv *wcd938x,
 	}
 
 	of_node_get(wcd938x->rxnode);
-	component_match_add_release(dev, matchptr, wcd938x_release_of,
-				    wcd938x_compare_of,	wcd938x->rxnode);
+	component_match_add_release(dev, matchptr, component_release_of,
+				    component_compare_of, wcd938x->rxnode);
 
 	wcd938x->txnode = of_parse_phandle(np, "qcom,tx-device", 0);
 	if (!wcd938x->txnode) {
@@ -4451,8 +4441,8 @@ static int wcd938x_add_slave_components(struct wcd938x_priv *wcd938x,
 		return -ENODEV;
 	}
 	of_node_get(wcd938x->txnode);
-	component_match_add_release(dev, matchptr, wcd938x_release_of,
-				    wcd938x_compare_of,	wcd938x->txnode);
+	component_match_add_release(dev, matchptr, component_release_of,
+				    component_compare_of, wcd938x->txnode);
 	return 0;
 }
 
-- 
2.18.0

