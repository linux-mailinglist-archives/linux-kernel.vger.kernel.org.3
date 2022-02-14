Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283494B41D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbiBNGMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:12:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240815AbiBNGMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:12:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0EC1928A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:11:55 -0800 (PST)
X-UUID: 9b51b6cac15140bcb076f524a6448dbe-20220214
X-UUID: 9b51b6cac15140bcb076f524a6448dbe-20220214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1724654025; Mon, 14 Feb 2022 14:11:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 14:11:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:11:47 +0800
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
        <linux-kernel@vger.kernel.org>, "Joerg Roedel" <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, Rob Clark <robdclark@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        "Yunfei Wang" <yf.wang@mediatek.com>,
        Libo Kang <libo.kang@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>,
        Mingyuan Ma <mingyuan.ma@mediatek.com>,
        Xueqi Zhang <xueqi.zhang@mediatek.com>
Subject: [PATCH 19/23] iommu/mediatek: Make use of the helper component_compare/release_of
Date:   Mon, 14 Feb 2022 14:08:15 +0800
Message-ID: <20220214060819.7334-20-yong.wu@mediatek.com>
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

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Yunfei Wang <yf.wang@mediatek.com>
Cc: Libo Kang <libo.kang@mediatek.com>
Cc: Anan Sun <anan.sun@mediatek.com>
Cc: Mingyuan Ma <mingyuan.ma@mediatek.com>
Cc: Xueqi Zhang <xueqi.zhang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    |  4 ++--
 drivers/iommu/mtk_iommu.h    | 10 ----------
 drivers/iommu/mtk_iommu_v1.c |  4 ++--
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 25b834104790..a2ec9003826c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -852,8 +852,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
-		component_match_add_release(dev, &match, release_of,
-					    compare_of, larbnode);
+		component_match_add_release(dev, &match, component_release_of,
+					    component_compare_of, larbnode);
 	}
 
 	/* Get smi-common dev from the last larb. */
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index f81fa8862ed0..b742432220c5 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -84,16 +84,6 @@ struct mtk_iommu_data {
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
 
-static inline int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static inline void release_of(struct device *dev, void *data)
-{
-	of_node_put(data);
-}
-
 static inline int mtk_iommu_bind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index be22fcf988ce..83bd10617c9f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -599,8 +599,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		}
 		data->larb_imu[i].dev = &plarbdev->dev;
 
-		component_match_add_release(dev, &match, release_of,
-					    compare_of, larbnode);
+		component_match_add_release(dev, &match, component_release_of,
+					    component_compare_of, larbnode);
 	}
 
 	platform_set_drvdata(pdev, data);
-- 
2.18.0

