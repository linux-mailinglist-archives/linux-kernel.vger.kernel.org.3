Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6AB517E64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiECHU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiECHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:20:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69932AE0A;
        Tue,  3 May 2022 00:16:21 -0700 (PDT)
X-UUID: e8c082ece90b4c748051912c7aaee11c-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7a13dfdc-c756-4e9d-8732-194757ee8278,OB:30,L
        OB:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ha
        m,ACTION:release,TS:80
X-CID-INFO: VERSION:1.1.4,REQID:7a13dfdc-c756-4e9d-8732-194757ee8278,OB:30,LOB
        :10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3
        D,ACTION:quarantine,TS:80
X-CID-META: VersionHash:faefae9,CLOUDID:feaa822f-6199-437e-8ab4-9920b4bc5b76,C
        OID:d2f05428c351,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: e8c082ece90b4c748051912c7aaee11c-20220503
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2070391374; Tue, 03 May 2022 15:16:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 15:16:04 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:16:03 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, <yen-chang.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>
Subject: [PATCH v7 09/36] iommu/mediatek: Adapt sharing and non-sharing pgtable case
Date:   Tue, 3 May 2022 15:14:00 +0800
Message-ID: <20220503071427.2285-10-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous mt2712, Both IOMMUs are MM IOMMU, and they will share pgtable.
However in the latest SoC, another is infra IOMMU, there is no reason to
share pgtable between MM with INFRA IOMMU. This patch manage to
implement the two case(sharing and non-sharing pgtable).

Currently we use for_each_m4u to loop the 2 HWs. Add the list_head into
this macro.
In the sharing pgtable case, the list_head is the global "m4ulist".
In the non-sharing pgtable case, the list_head is hw_list_head which is a
variable in the "data". then for_each_m4u will only loop itself.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 43 +++++++++++++++++++++------------------
 drivers/iommu/mtk_iommu.h |  7 +++++++
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ecdce5d3e8cf..1b8e4405dd0f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -118,6 +118,7 @@
 #define WR_THROT_EN			BIT(6)
 #define HAS_LEGACY_IVRP_PADDR		BIT(7)
 #define IOVA_34_EN			BIT(8)
+#define SHARE_PGTABLE			BIT(9) /* 2 HW share pgtable */
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -167,7 +168,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
 
 static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
-#define for_each_m4u(data)	list_for_each_entry(data, &m4ulist, list)
+#define for_each_m4u(data, head)  list_for_each_entry(data, head, list)
 
 struct mtk_iommu_iova_region {
 	dma_addr_t		iova_base;
@@ -188,21 +189,10 @@ static const struct mtk_iommu_iova_region mt8192_multi_dom[] = {
 	#endif
 };
 
-/*
- * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
- * for the performance.
- *
- * Here always return the mtk_iommu_data of the first probed M4U where the
- * iommu domain information is recorded.
- */
-static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
+/* If 2 M4U share a domain(use the same hwlist), Put the corresponding info in first data.*/
+static struct mtk_iommu_data *mtk_iommu_get_frst_data(struct list_head *hwlist)
 {
-	struct mtk_iommu_data *data;
-
-	for_each_m4u(data)
-		return data;
-
-	return NULL;
+	return list_first_entry(hwlist, struct mtk_iommu_data, list);
 }
 
 static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
@@ -226,11 +216,12 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   size_t granule,
 					   struct mtk_iommu_data *data)
 {
+	struct list_head *head = data->hw_list;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
 
-	for_each_m4u(data) {
+	for_each_m4u(data, head) {
 		if (pm_runtime_get_if_in_use(data->dev) <= 0)
 			continue;
 
@@ -451,6 +442,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev), *frstdata;
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct list_head *hw_list = data->hw_list;
 	struct device *m4udev = data->dev;
 	int ret, domid;
 
@@ -461,7 +453,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	mutex_lock(&dom->mutex);
 	if (!dom->data) {
 		/* Data is in the frstdata in sharing pgtable case. */
-		frstdata = mtk_iommu_get_m4u_data();
+		frstdata = mtk_iommu_get_frst_data(hw_list);
 
 		ret = mtk_iommu_domain_finalise(dom, frstdata, domid);
 		if (ret) {
@@ -625,10 +617,12 @@ static void mtk_iommu_release_device(struct device *dev)
 
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
+	struct list_head *hw_list = c_data->hw_list;
 	struct iommu_group *group;
 	int domid;
 
+	data = mtk_iommu_get_frst_data(hw_list);
 	if (!data)
 		return ERR_PTR(-ENODEV);
 
@@ -938,7 +932,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		goto out_sysfs_remove;
 
 	spin_lock_init(&data->tlb_lock);
-	list_add_tail(&data->list, &m4ulist);
+
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
+		list_add_tail(&data->list, data->plat_data->hw_list);
+		data->hw_list = data->plat_data->hw_list;
+	} else {
+		INIT_LIST_HEAD(&data->hw_list_head);
+		list_add_tail(&data->list, &data->hw_list_head);
+		data->hw_list = &data->hw_list_head;
+	}
 
 	if (!iommu_present(&platform_bus_type)) {
 		ret = bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
@@ -1047,7 +1049,8 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
 
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
-	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
+	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG | SHARE_PGTABLE,
+	.hw_list      = &m4ulist,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 5e8da947affc..dc868fce0d2a 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -55,6 +55,7 @@ struct mtk_iommu_plat_data {
 	u32                 flags;
 	u32                 inv_sel_reg;
 
+	struct list_head			*hw_list;
 	unsigned int				iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
@@ -82,6 +83,12 @@ struct mtk_iommu_data {
 
 	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
 
+	/*
+	 * In the sharing pgtable case, list data->list to the global list like m4ulist.
+	 * In the non-sharing pgtable case, list data->list to the itself hw_list_head.
+	 */
+	struct list_head		*hw_list;
+	struct list_head		hw_list_head;
 	struct list_head		list;
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
-- 
2.18.0

