Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6483254D9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358727AbiFPFmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358699AbiFPFms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:42:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3622BD1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:42:47 -0700 (PDT)
X-UUID: 62c4fc8db1ca4f139ce513466600e9dd-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:1f969065-5408-4276-9caf-bbcce550025a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:508f6ff6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 62c4fc8db1ca4f139ce513466600e9dd-20220616
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 330060221; Thu, 16 Jun 2022 13:42:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 16 Jun 2022 13:42:40 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 13:42:39 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of mm_dts_parse
Date:   Thu, 16 Jun 2022 13:42:00 +0800
Message-ID: <20220616054203.11365-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220616054203.11365-1-yong.wu@mediatek.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the i+1
larb is parsed fail(return -EINVAL), we should of_node_put for the 0..i
larbs. In the fail path, one of_node_put matches with of_parse_phandle in
it.

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3b2489e8a6dd..ab24078938bf 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1071,12 +1071,12 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 
 		plarbdev = of_find_device_by_node(larbnode);
 		if (!plarbdev) {
-			of_node_put(larbnode);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_larbnode_put;
 		}
 		if (!plarbdev->dev.driver) {
-			of_node_put(larbnode);
-			return -EPROBE_DEFER;
+			ret = -EPROBE_DEFER;
+			goto err_larbnode_put;
 		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
@@ -1107,9 +1107,20 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 	if (!link) {
 		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_larbnode_put;
 	}
 	return 0;
+
+err_larbnode_put:
+	while (i--) {
+		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
+		if (larbnode && of_device_is_available(larbnode)) {
+			of_node_put(larbnode);
+			of_node_put(larbnode);
+		}
+	}
+	return ret;
 }
 
 static int mtk_iommu_probe(struct platform_device *pdev)
-- 
2.18.0

