Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9544D10E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbiCHHZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiCHHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:25:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1DE3DA49;
        Mon,  7 Mar 2022 23:24:46 -0800 (PST)
X-UUID: 761774f7553a4f738949973e9d494bd7-20220308
X-UUID: 761774f7553a4f738949973e9d494bd7-20220308
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1803571036; Tue, 08 Mar 2022 15:24:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Mar 2022 15:24:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 15:24:41 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <yc.hung@mediatek.com>
Subject: [PATCH 1/5] ASoC: mediatek: mt8195: add reset controller
Date:   Tue, 8 Mar 2022 15:24:31 +0800
Message-ID: <20220308072435.22460-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220308072435.22460-1-trevor.wu@mediatek.com>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio hardware is possibly used in the firmware stage, so resetting audio
hardware before regcache records default register values is required.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 550636500949..72b2c6d629b9 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include "mt8195-afe-common.h"
 #include "mt8195-afe-clk.h"
 #include "mt8195-reg.h"
@@ -3056,6 +3057,7 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct mtk_base_afe *afe;
 	struct mt8195_afe_private *afe_priv;
 	struct device *dev = &pdev->dev;
+	struct reset_control *rstc;
 	int i, irq_id, ret;
 	struct snd_soc_component *component;
 
@@ -3092,6 +3094,20 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* reset controller to reset audio regs before regmap cache */
+	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		dev_err(dev, "could not get audiosys reset:%d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_reset(rstc);
+	if (ret) {
+		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
+		return ret;
+	}
+
 	spin_lock_init(&afe_priv->afe_ctrl_lock);
 
 	mutex_init(&afe->irq_alloc_lock);
-- 
2.18.0

