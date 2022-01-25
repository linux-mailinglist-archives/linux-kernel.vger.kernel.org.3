Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EEB49AF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455018AbiAYJCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:02:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1454375AbiAYI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:59:22 -0500
X-UUID: 0ce1cb300b4142469599f7f4483f9679-20220125
X-UUID: 0ce1cb300b4142469599f7f4483f9679-20220125
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 448279544; Tue, 25 Jan 2022 16:58:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 25 Jan 2022 16:58:12 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 16:58:11 +0800
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
Subject: [PATCH v4 10/35] iommu/mediatek: Add 12G~16G support for multi domains
Date:   Tue, 25 Jan 2022 16:56:09 +0800
Message-ID: <20220125085634.17972-11-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mt8192, we preassign 0-4G; 4G-8G; 8G-12G for different multimedia
engines. This depends on the "dma-ranges=" in the iommu consumer's dtsi
node.

Adds 12G-16G region here. and reword the previous comment. we don't limit
which master locate in which region.

CCU still is 8G-12G. Don't change it here.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1712f5fcdcab..4a24977274e3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -180,10 +180,12 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 };
 
 static const struct mtk_iommu_iova_region mt8192_multi_dom[] = {
-	{ .iova_base = 0x0,		.size = SZ_4G},		/* disp: 0 ~ 4G */
+	{ .iova_base = 0x0,		.size = SZ_4G},		/* 0 ~ 4G */
 	#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
-	{ .iova_base = SZ_4G,		.size = SZ_4G},		/* vdec: 4G ~ 8G */
-	{ .iova_base = SZ_4G * 2,	.size = SZ_4G},		/* CAM/MDP: 8G ~ 12G */
+	{ .iova_base = SZ_4G,		.size = SZ_4G},		/* 4G ~ 8G */
+	{ .iova_base = SZ_4G * 2,	.size = SZ_4G},		/* 8G ~ 12G */
+	{ .iova_base = SZ_4G * 3,	.size = SZ_4G},		/* 12G ~ 16G */
+
 	{ .iova_base = 0x240000000ULL,	.size = 0x4000000},	/* CCU0 */
 	{ .iova_base = 0x244000000ULL,	.size = 0x4000000},	/* CCU1 */
 	#endif
-- 
2.18.0

