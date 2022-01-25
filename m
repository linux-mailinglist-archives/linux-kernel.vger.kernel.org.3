Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229E549AF64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454779AbiAYJJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:09:28 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56956 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1455157AbiAYJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:03:14 -0500
X-UUID: 7bbfde51197340bc9a7ccc06b54e7137-20220125
X-UUID: 7bbfde51197340bc9a7ccc06b54e7137-20220125
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 352859111; Tue, 25 Jan 2022 17:00:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 17:00:56 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 17:00:54 +0800
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
Subject: [PATCH v4 32/35] iommu/mediatek: Get the proper bankid for multi banks
Date:   Tue, 25 Jan 2022 16:56:31 +0800
Message-ID: <20220125085634.17972-33-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We preassign some ports in a special bank via the new defined
banks_portmsk. Put it in the plat_data means it is not expected to be
adjusted dynamically.

If the iommu id in the iommu consumer's dtsi node is inside this
banks_portmsk, then we switch it to this special iommu bank, and
initialise the IOMMU bank HW.

Each a bank has the independent pgtable(4GB iova range). Each a bank
is a independent iommu domain/group. Currently we don't separate different
iova ranges inside a bank.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 22586d1aed72..c6de9304bbc6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -191,6 +191,7 @@ struct mtk_iommu_plat_data {
 
 	u8                  banks_num;
 	bool                banks_enable[MTK_IOMMU_BANK_MAX];
+	unsigned int        banks_portmsk[MTK_IOMMU_BANK_MAX];
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
 };
 
@@ -478,6 +479,30 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static unsigned int mtk_iommu_get_bank_id(struct device *dev,
+					  const struct mtk_iommu_plat_data *plat_data)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	unsigned int i, portmsk = 0, bankid = 0;
+
+	if (plat_data->banks_num == 1)
+		return bankid;
+
+	for (i = 0; i < fwspec->num_ids; i++)
+		portmsk |= BIT(MTK_M4U_TO_PORT(fwspec->ids[i]));
+
+	for (i = 0; i < plat_data->banks_num && i < MTK_IOMMU_BANK_MAX; i++) {
+		if (!plat_data->banks_enable[i])
+			continue;
+
+		if (portmsk & plat_data->banks_portmsk[i]) {
+			bankid = i;
+			break;
+		}
+	}
+	return bankid; /* default is 0 */
+}
+
 static int mtk_iommu_get_iova_region_id(struct device *dev,
 					const struct mtk_iommu_plat_data *plat_data)
 {
@@ -630,13 +655,14 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	struct list_head *hw_list = data->hw_list;
 	struct device *m4udev = data->dev;
 	struct mtk_iommu_bank_data *bank;
-	unsigned int bankid = 0;
+	unsigned int bankid;
 	int ret, region_id;
 
 	region_id = mtk_iommu_get_iova_region_id(dev, data->plat_data);
 	if (region_id < 0)
 		return region_id;
 
+	bankid = mtk_iommu_get_bank_id(dev, data->plat_data);
 	mutex_lock(&dom->mutex);
 	if (!dom->bank) {
 		/* Data is in the frstdata in sharing pgtable case. */
@@ -778,6 +804,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
 	struct list_head *hw_list = c_data->hw_list;
 	struct iommu_group *group;
+	unsigned int bankid, groupid;
 	int regionid;
 
 	data = mtk_iommu_get_frst_data(hw_list);
@@ -788,12 +815,18 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	if (regionid < 0)
 		return ERR_PTR(regionid);
 
+	bankid = mtk_iommu_get_bank_id(dev, data->plat_data);
 	mutex_lock(&data->mutex);
-	group = data->m4u_group[regionid];
+	/*
+	 * If the bank function is enabled, each a bank is a iommu group/domain.
+	 * otherwise, each a iova region is a iommu group/domain.
+	 */
+	groupid = bankid ? bankid : regionid;
+	group = data->m4u_group[groupid];
 	if (!group) {
 		group = iommu_group_alloc();
 		if (!IS_ERR(group))
-			data->m4u_group[regionid] = group;
+			data->m4u_group[groupid] = group;
 	} else {
 		iommu_group_ref_get(group);
 	}
-- 
2.18.0

