Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912A2462C45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbhK3Fmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 00:42:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33816 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232397AbhK3Fmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:42:38 -0500
X-UUID: 7fcca7d58fa54c37b40bdb1e4fce2cb6-20211130
X-UUID: 7fcca7d58fa54c37b40bdb1e4fce2cb6-20211130
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1883285016; Tue, 30 Nov 2021 13:39:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 30 Nov 2021 13:39:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Nov 2021 13:39:07 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yc.hung@mediatek.com>
Subject: [PATCH 1/2] ASoC: mediatek: mt8195: support reserved memory assignment
Date:   Tue, 30 Nov 2021 13:39:04 +0800
Message-ID: <20211130053905.28470-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211130053905.28470-1-trevor.wu@mediatek.com>
References: <20211130053905.28470-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security purpose, restrict the memory assess region of AFE memif.
The specified memory region should be assigned from DTS.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 2bb05a828e8d..8a6db24116e3 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pm_runtime.h>
 #include "mt8195-afe-common.h"
 #include "mt8195-afe-clk.h"
@@ -3061,6 +3062,12 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	int i, irq_id, ret;
 	struct snd_soc_component *component;
 
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_err(dev, "failed to assign memory region: %d\n", ret);
+		return ret;
+	}
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));
 	if (ret)
 		return ret;
-- 
2.18.0

