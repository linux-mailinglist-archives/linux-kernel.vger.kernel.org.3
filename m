Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2684B9F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiBQLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:38:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbiBQLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:38:43 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A32ABD39;
        Thu, 17 Feb 2022 03:37:59 -0800 (PST)
X-UUID: 36279420ab6b4bafa470bab6694b12d0-20220217
X-UUID: 36279420ab6b4bafa470bab6694b12d0-20220217
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 576722015; Thu, 17 Feb 2022 19:37:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Feb 2022 19:37:53 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 19:37:52 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, <yen-chang.chen@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>
Subject: [PATCH v5 19/34] iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
Date:   Thu, 17 Feb 2022 19:34:38 +0800
Message-ID: <20220217113453.13658-20-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220217113453.13658-1-yong.wu@mediatek.com>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
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

The power/clock of infra iommu is always on, and it doesn't have the
device link with the master devices, then the infra iommu device's pm
statua is not active, thus we add A PM_CLK_AO flag for infra iommu.

The tlb operation is a bit not clear in this file, Comment them in the
code here.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ba9d61bec3e8..9634e9d8fcea 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -130,6 +130,8 @@
 #define MTK_IOMMU_TYPE_MM		(0x0 << 13)
 #define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
 #define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
+/* PM and clock always on. e.g. infra iommu */
+#define PM_CLK_AO			BIT(15)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))
 
@@ -235,13 +237,33 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   struct mtk_iommu_data *data)
 {
 	struct list_head *head = data->hw_list;
+	bool check_pm_status;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
 
 	for_each_m4u(data, head) {
-		if (pm_runtime_get_if_in_use(data->dev) <= 0)
-			continue;
+		/*
+		 * To avoid resume the iommu device frequently when the iommu device
+		 * is not active, it doesn't always call pm_runtime_get here, then tlb
+		 * flush depends on the tlb flush all in the runtime resume.
+		 *
+		 * There are 2 special cases:
+		 *
+		 * Case1: The iommu dev doesn't have power domain but has bclk. This case
+		 * should also avoid the tlb flush while the dev is not active to mute
+		 * the tlb timeout log. like mt8173.
+		 *
+		 * Case2: The power/clock of infra iommu is always on, and it doesn't
+		 * have the device link with the master devices. This case should avoid
+		 * the PM status check.
+		 */
+		check_pm_status = !MTK_IOMMU_HAS_FLAG(data->plat_data, PM_CLK_AO);
+
+		if (check_pm_status) {
+			if (pm_runtime_get_if_in_use(data->dev) <= 0)
+				continue;
+		}
 
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
@@ -268,7 +290,8 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 			mtk_iommu_tlb_flush_all(data);
 		}
 
-		pm_runtime_put(data->dev);
+		if (check_pm_status)
+			pm_runtime_put(data->dev);
 	}
 }
 
-- 
2.18.0

