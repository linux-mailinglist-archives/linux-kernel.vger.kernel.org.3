Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF64902B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiAQHHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:07:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48402 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237393AbiAQHH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:07:27 -0500
X-UUID: ed35a4e554b9472794df07a6e645e9ab-20220117
X-UUID: ed35a4e554b9472794df07a6e645e9ab-20220117
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2014408673; Mon, 17 Jan 2022 15:07:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 17 Jan 2022 15:07:23 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 15:07:21 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Joerg Roedel <jroedel@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>,
        <anan.sun@mediatek.com>, <yi.kuo@mediatek.com>,
        <acourbot@chromium.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Dafna Hirschfeld" <dafna.hirschfeld@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        <anthony.huang@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v10 11/13] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
Date:   Mon, 17 Jan 2022 15:05:08 +0800
Message-ID: <20220117070510.17642-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220117070510.17642-1-yong.wu@mediatek.com>
References: <20220117070510.17642-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding device_link between the iommu consumer and smi-larb,
the pm_runtime_get(_sync) of smi-larb and smi-common will be called
automatically. we can get rid of mtk_smi_larb_get/put.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/memory/mtk-smi.c   | 14 --------------
 include/soc/mediatek/smi.h | 20 --------------------
 2 files changed, 34 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b883dcc0bbfa..1b348bb93f0b 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -149,20 +149,6 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	unsigned char			*bank;
 };
 
-int mtk_smi_larb_get(struct device *larbdev)
-{
-	int ret = pm_runtime_resume_and_get(larbdev);
-
-	return (ret < 0) ? ret : 0;
-}
-EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
-
-void mtk_smi_larb_put(struct device *larbdev)
-{
-	pm_runtime_put_sync(larbdev);
-}
-EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
-
 static int
 mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 {
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 15e3397cec58..11f7d6b59642 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -19,26 +19,6 @@ struct mtk_smi_larb_iommu {
 	unsigned char  bank[32];
 };
 
-/*
- * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
- *                   It also initialize some basic setting(like iommu).
- * mtk_smi_larb_put: Disable the power domain and clocks for this local arbiter.
- * Both should be called in non-atomic context.
- *
- * Returns 0 if successful, negative on failure.
- */
-int mtk_smi_larb_get(struct device *larbdev);
-void mtk_smi_larb_put(struct device *larbdev);
-
-#else
-
-static inline int mtk_smi_larb_get(struct device *larbdev)
-{
-	return 0;
-}
-
-static inline void mtk_smi_larb_put(struct device *larbdev) { }
-
 #endif
 
 #endif
-- 
2.18.0

