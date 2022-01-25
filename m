Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F5A49AF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456064AbiAYJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:09:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37260 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1454516AbiAYI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:59:51 -0500
X-UUID: 19dc5225e7804486a1639847a3fa5784-20220125
X-UUID: 19dc5225e7804486a1639847a3fa5784-20220125
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1122185969; Tue, 25 Jan 2022 16:59:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 16:59:08 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 16:59:06 +0800
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
Subject: [PATCH v4 16/35] iommu/mediatek: Add IOMMU_TYPE flag
Date:   Tue, 25 Jan 2022 16:56:15 +0800
Message-ID: <20220125085634.17972-17-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IOMMU_TYPE definition. In the mt8195, we have another IOMMU_TYPE:
infra iommu, also there will be another APU_IOMMU, thus, use 2bits for the
IOMMU_TYPE.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 47d5f34f4db0..418ec0b7a43b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -126,9 +126,17 @@
 #define SHARE_PGTABLE			BIT(10) /* 2 HW share pgtable */
 #define DCM_DISABLE			BIT(11)
 #define NOT_STD_AXI_MODE		BIT(12)
+/* 2 bits: iommu type */
+#define MTK_IOMMU_TYPE_MM		(0x0 << 13)
+#define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
+#define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
 
-#define MTK_IOMMU_HAS_FLAG(pdata, _x) \
-		((((pdata)->flags) & (_x)) == (_x))
+#define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))
+
+#define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
+				((((pdata)->flags) & (mask)) == (_x))
+#define MTK_IOMMU_IS_TYPE(pdata, _x)	MTK_IOMMU_HAS_FLAG_MASK(pdata, _x,\
+							MTK_IOMMU_TYPE_MASK)
 
 struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
-- 
2.18.0

