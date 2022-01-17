Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A912949026D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiAQHGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:06:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45546 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235018AbiAQHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:06:17 -0500
X-UUID: effb381d9712497db536a0dff025128c-20220117
X-UUID: effb381d9712497db536a0dff025128c-20220117
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1837693972; Mon, 17 Jan 2022 15:06:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 17 Jan 2022 15:06:13 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 15:06:11 +0800
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
Subject: [PATCH v10 04/13] iommu/mediatek: Add probe_defer for smi-larb
Date:   Mon, 17 Jan 2022 15:05:01 +0800
Message-ID: <20220117070510.17642-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220117070510.17642-1-yong.wu@mediatek.com>
References: <20220117070510.17642-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for adding device_link.

The iommu consumer should use device_link to connect with the
smi-larb(supplier). then the smi-larb should run before the iommu
consumer. Here we delay the iommu driver until the smi driver is ready,
then all the iommu consumers always are after the smi driver.

When there is no this patch, if some consumer drivers run before
smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
device_link_add, then device_links_driver_bound will use WARN_ON
to complain that the link_status of supplier is not right.

device_is_bound may be more elegant here. but it is not allowed to
EXPORT from https://lore.kernel.org/patchwork/patch/1334670/.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c    | 4 ++++
 drivers/iommu/mtk_iommu_v1.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 77ae20ff9b35..5cff5bc556d4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -850,6 +850,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			of_node_put(larbnode);
 			return -ENODEV;
 		}
+		if (!plarbdev->dev.driver) {
+			of_node_put(larbnode);
+			return -EPROBE_DEFER;
+		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 68bf02f87cfd..4089077256f4 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -606,6 +606,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			of_node_put(larbnode);
 			return -ENODEV;
 		}
+		if (!plarbdev->dev.driver) {
+			of_node_put(larbnode);
+			return -EPROBE_DEFER;
+		}
 		data->larb_imu[i].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
-- 
2.18.0

