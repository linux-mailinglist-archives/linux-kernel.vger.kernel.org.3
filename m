Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029E954D9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358834AbiFPFnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358775AbiFPFnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:43:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25D5A2C8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:42:59 -0700 (PDT)
X-UUID: 3a042d29f65d4d10b8fd32fa8d0b8188-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:06c9de32-63b2-4691-b549-ff1d271fb626,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.6,REQID:06c9de32-63b2-4691-b549-ff1d271fb626,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:b14ad71,CLOUDID:72e3b248-4c92-421c-ad91-b806c0f58b2a,C
        OID:3fb93d03b2a9,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3a042d29f65d4d10b8fd32fa8d0b8188-20220616
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1148593925; Thu, 16 Jun 2022 13:42:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 13:42:52 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 13:42:51 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Yong Wu" <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: [PATCH v2 4/5] iommu/mediatek: Improve safety for mediatek, smi property in larb nodes
Date:   Thu, 16 Jun 2022 13:42:02 +0800
Message-ID: <20220616054203.11365-5-yong.wu@mediatek.com>
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

No functional change. Just improve safety from dts.

All the larbs that connect to one IOMMU must connect with the same
smi-common. This patch checks all the mediatek,smi property for each
larb, If their mediatek,smi are different, it will return fails.
Also avoid there is no available smi-larb nodes.

Suggested-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 49 ++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a869d4aee7b3..5e86fd48928a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1044,7 +1044,7 @@ static const struct component_master_ops mtk_iommu_com_ops = {
 static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **match,
 				  struct mtk_iommu_data *data)
 {
-	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
+	struct device_node *larbnode, *frst_avail_smicomm_node = NULL;
 	struct platform_device *plarbdev;
 	struct device_link *link;
 	int i, larb_nr, ret;
@@ -1056,6 +1056,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		return -EINVAL;
 
 	for (i = 0; i < larb_nr; i++) {
+		struct device_node *smicomm_node, *smi_subcomm_node;
 		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
@@ -1091,27 +1092,43 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
+		/* Get smi-(sub)-common dev from the last larb. */
+		smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+		if (!smi_subcomm_node) {
+			ret = -EINVAL;
+			goto err_larbnode_put;
+		}
+
+		/*
+		 * It may have two level smi-common. the node is smi-sub-common if it
+		 * has a new mediatek,smi property. otherwise it is smi-commmon.
+		 */
+		smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
+		if (smicomm_node)
+			of_node_put(smi_subcomm_node);
+		else
+			smicomm_node = smi_subcomm_node;
+
+		if (!frst_avail_smicomm_node) {
+			frst_avail_smicomm_node = smicomm_node;
+		} else if (frst_avail_smicomm_node != smicomm_node) {
+			dev_err(dev, "mediatek,smi is not right @larb%d.", id);
+			of_node_put(smicomm_node);
+			ret = -EINVAL;
+			goto err_larbnode_put;
+		} else {
+			of_node_put(smicomm_node);
+		}
+
 		component_match_add_release(dev, match, component_release_of,
 					    component_compare_of, larbnode);
 	}
 
-	/* Get smi-(sub)-common dev from the last larb. */
-	smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
-	if (!smi_subcomm_node)
+	if (!frst_avail_smicomm_node)
 		return -EINVAL;
 
-	/*
-	 * It may have two level smi-common. the node is smi-sub-common if it
-	 * has a new mediatek,smi property. otherwise it is smi-commmon.
-	 */
-	smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
-	if (smicomm_node)
-		of_node_put(smi_subcomm_node);
-	else
-		smicomm_node = smi_subcomm_node;
-
-	plarbdev = of_find_device_by_node(smicomm_node);
-	of_node_put(smicomm_node);
+	plarbdev = of_find_device_by_node(frst_avail_smicomm_node);
+	of_node_put(frst_avail_smicomm_node);
 	data->smicomm_dev = &plarbdev->dev;
 
 	link = device_link_add(data->smicomm_dev, dev,
-- 
2.18.0

