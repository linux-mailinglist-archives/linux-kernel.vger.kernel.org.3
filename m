Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1E4707BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbhLJR4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:42 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44676 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244816AbhLJR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:15 -0500
X-UUID: 5b3d7f91eb6d48e1b8622f788aab8c6f-20211211
X-UUID: 5b3d7f91eb6d48e1b8622f788aab8c6f-20211211
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1621512975; Sat, 11 Dec 2021 01:52:36 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:52:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:52:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:34 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "JB Tsai" <jb.tsai@mediatek.com>
Subject: [PATCH 04/12] iommu/mediatek: Add APU iommu data for mt8195
Date:   Sat, 11 Dec 2021 01:52:15 +0800
Message-ID: <20211210175223.31131-5-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware settins for support mt8195 apu iommu.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 drivers/iommu/mtk_iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 4bc7c76062e6..3fda9ad9f925 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -218,6 +218,13 @@ static const struct mtk_iommu_iova_region mt8192_multi_dom_apu[] = {
 	{ .iova_base = 0x70000000ULL,	.size = 0x12600000}, /* APU REG */
 };
 
+static const struct mtk_iommu_iova_region mt8195_multi_dom_apu[] = {
+	{ .iova_base = 0x0,		.size = SZ_4G}, /* APU DATA */
+	{ .iova_base = 0x8000000ULL,	.size = 0x8000000},  /* APU VLM */
+	{ .iova_base = 0x20000000ULL,	.size = 0xe0000000}, /* APU VPU */
+	{ .iova_base = 0x70000000ULL,	.size = 0x12600000}, /* APU REG */
+};
+
 /* If 2 M4U share a domain(use the same hwlist), Put the corresponding info in first data.*/
 static struct mtk_iommu_data *mtk_iommu_get_frst_data(struct list_head *hwlist)
 {
@@ -1312,6 +1319,18 @@ static const struct mtk_iommu_plat_data mt8192_data_apu = {
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom_apu),
 };
 
+static const struct mtk_iommu_plat_data mt8195_data_apu = {
+	.m4u_plat       = M4U_MT8195,
+	.flags          = DCM_DISABLE | MTK_IOMMU_TYPE_APU |
+			  SHARE_PGTABLE,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.hw_list        = &apulist,
+	.bank_nr	= 1,
+	.bank_enable    = {true},
+	.iova_region    = mt8195_multi_dom_apu,
+	.iova_region_nr = ARRAY_SIZE(mt8195_multi_dom_apu),
+};
+
 static const struct mtk_iommu_plat_data mt8195_data_infra = {
 	.m4u_plat	  = M4U_MT8195,
 	.flags            = WR_THROT_EN | DCM_DISABLE |
@@ -1368,6 +1387,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{ .compatible = "mediatek,mt8192-iommu-apu",   .data = &mt8192_data_apu},
+	{ .compatible = "mediatek,mt8195-iommu-apu",   .data = &mt8195_data_apu},
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
 	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
-- 
2.18.0

