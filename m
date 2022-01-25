Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79F249AF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456208AbiAYJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:09:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1455201AbiAYJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:03:31 -0500
X-UUID: e1df7c9c09b149d693aea5b3c6ffe5d8-20220125
X-UUID: e1df7c9c09b149d693aea5b3c6ffe5d8-20220125
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 27112954; Tue, 25 Jan 2022 17:00:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 17:00:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 17:00:31 +0800
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
Subject: [PATCH v4 28/35] iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
Date:   Tue, 25 Jan 2022 16:56:27 +0800
Message-ID: <20220125085634.17972-29-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Just rename this for readable.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu_v1.c | 209 +++++++++++++++++------------------
 1 file changed, 102 insertions(+), 107 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 23c3bc175153..72d5cbeeaecf 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -85,34 +85,34 @@
  */
 #define M2701_IOMMU_PGT_SIZE			SZ_4M
 
-struct mtk_iommu_suspend_reg {
+struct mtk_iommu_v1_suspend_reg {
 	u32			standard_axi_mode;
 	u32			dcm_dis;
 	u32			ctrl_reg;
 	u32			int_control0;
 };
 
-struct mtk_iommu_data {
+struct mtk_iommu_v1_data {
 	void __iomem			*base;
 	int				irq;
 	struct device			*dev;
 	struct clk			*bclk;
 	phys_addr_t			protect_base; /* protect memory base */
-	struct mtk_iommu_domain		*m4u_dom;
+	struct mtk_iommu_v1_domain	*m4u_dom;
 
 	struct iommu_device		iommu;
 	struct dma_iommu_mapping	*mapping;
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 
-	struct mtk_iommu_suspend_reg	reg;
+	struct mtk_iommu_v1_suspend_reg	reg;
 };
 
-struct mtk_iommu_domain {
+struct mtk_iommu_v1_domain {
 	spinlock_t			pgtlock; /* lock for page table */
 	struct iommu_domain		domain;
 	u32				*pgt_va;
 	dma_addr_t			pgt_pa;
-	struct mtk_iommu_data		*data;
+	struct mtk_iommu_v1_data	*data;
 };
 
 static inline int compare_of(struct device *dev, void *data)
@@ -125,23 +125,23 @@ static inline void release_of(struct device *dev, void *data)
 	of_node_put(data);
 }
 
-static inline int mtk_iommu_bind(struct device *dev)
+static inline int mtk_iommu_v1_bind(struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+	struct mtk_iommu_v1_data *data = dev_get_drvdata(dev);
 
 	return component_bind_all(dev, &data->larb_imu);
 }
 
-static inline void mtk_iommu_unbind(struct device *dev)
+static inline void mtk_iommu_v1_unbind(struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+	struct mtk_iommu_v1_data *data = dev_get_drvdata(dev);
 
 	component_unbind_all(dev, &data->larb_imu);
 }
 
-static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
+static struct mtk_iommu_v1_domain *to_mtk_domain(struct iommu_domain *dom)
 {
-	return container_of(dom, struct mtk_iommu_domain, domain);
+	return container_of(dom, struct mtk_iommu_v1_domain, domain);
 }
 
 static const int mt2701_m4u_in_larb[] = {
@@ -167,7 +167,7 @@ static inline int mt2701_m4u_to_port(int id)
 	return id - mt2701_m4u_in_larb[larb];
 }
 
-static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
+static void mtk_iommu_v1_tlb_flush_all(struct mtk_iommu_v1_data *data)
 {
 	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			data->base + REG_MMU_INV_SEL);
@@ -175,8 +175,8 @@ static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 	wmb(); /* Make sure the tlb flush all done */
 }
 
-static void mtk_iommu_tlb_flush_range(struct mtk_iommu_data *data,
-				unsigned long iova, size_t size)
+static void mtk_iommu_v1_tlb_flush_range(struct mtk_iommu_v1_data *data,
+					 unsigned long iova, size_t size)
 {
 	int ret;
 	u32 tmp;
@@ -194,16 +194,16 @@ static void mtk_iommu_tlb_flush_range(struct mtk_iommu_data *data,
 	if (ret) {
 		dev_warn(data->dev,
 			 "Partial TLB flush timed out, falling back to full flush\n");
-		mtk_iommu_tlb_flush_all(data);
+		mtk_iommu_v1_tlb_flush_all(data);
 	}
 	/* Clear the CPE status */
 	writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
 }
 
-static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
+static irqreturn_t mtk_iommu_v1_isr(int irq, void *dev_id)
 {
-	struct mtk_iommu_data *data = dev_id;
-	struct mtk_iommu_domain *dom = data->m4u_dom;
+	struct mtk_iommu_v1_data *data = dev_id;
+	struct mtk_iommu_v1_domain *dom = data->m4u_dom;
 	u32 int_state, regval, fault_iova, fault_pa;
 	unsigned int fault_larb, fault_port;
 
@@ -233,13 +233,13 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	regval |= F_INT_CLR_BIT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL);
 
-	mtk_iommu_tlb_flush_all(data);
+	mtk_iommu_v1_tlb_flush_all(data);
 
 	return IRQ_HANDLED;
 }
 
-static void mtk_iommu_config(struct mtk_iommu_data *data,
-			     struct device *dev, bool enable)
+static void mtk_iommu_v1_config(struct mtk_iommu_v1_data *data,
+				struct device *dev, bool enable)
 {
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
@@ -261,9 +261,9 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	}
 }
 
-static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
+static int mtk_iommu_v1_domain_finalise(struct mtk_iommu_v1_data *data)
 {
-	struct mtk_iommu_domain *dom = data->m4u_dom;
+	struct mtk_iommu_v1_domain *dom = data->m4u_dom;
 
 	spin_lock_init(&dom->pgtlock);
 
@@ -279,9 +279,9 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
 	return 0;
 }
 
-static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *mtk_iommu_v1_domain_alloc(unsigned type)
 {
-	struct mtk_iommu_domain *dom;
+	struct mtk_iommu_v1_domain *dom;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
@@ -293,21 +293,20 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	return &dom->domain;
 }
 
-static void mtk_iommu_domain_free(struct iommu_domain *domain)
+static void mtk_iommu_v1_domain_free(struct iommu_domain *domain)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = dom->data;
+	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_v1_data *data = dom->data;
 
 	dma_free_coherent(data->dev, M2701_IOMMU_PGT_SIZE,
 			dom->pgt_va, dom->pgt_pa);
 	kfree(to_mtk_domain(domain));
 }
 
-static int mtk_iommu_attach_device(struct iommu_domain *domain,
-				   struct device *dev)
+static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	struct dma_iommu_mapping *mtk_mapping;
 	int ret;
 
@@ -318,29 +317,28 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 
 	if (!data->m4u_dom) {
 		data->m4u_dom = dom;
-		ret = mtk_iommu_domain_finalise(data);
+		ret = mtk_iommu_v1_domain_finalise(data);
 		if (ret) {
 			data->m4u_dom = NULL;
 			return ret;
 		}
 	}
 
-	mtk_iommu_config(data, dev, true);
+	mtk_iommu_v1_config(data, dev, true);
 	return 0;
 }
 
-static void mtk_iommu_detach_device(struct iommu_domain *domain,
-				    struct device *dev)
+static void mtk_iommu_v1_detach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
 
-	mtk_iommu_config(data, dev, false);
+	mtk_iommu_v1_config(data, dev, false);
 }
 
-static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			 phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int mtk_iommu_v1_map(struct iommu_domain *domain, unsigned long iova,
+			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	unsigned int page_num = size >> MT2701_IOMMU_PAGE_SHIFT;
 	unsigned long flags;
 	unsigned int i;
@@ -361,16 +359,15 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	mtk_iommu_tlb_flush_range(dom->data, iova, size);
+	mtk_iommu_v1_tlb_flush_range(dom->data, iova, size);
 
 	return map_size == size ? 0 : -EEXIST;
 }
 
-static size_t mtk_iommu_unmap(struct iommu_domain *domain,
-			      unsigned long iova, size_t size,
-			      struct iommu_iotlb_gather *gather)
+static size_t mtk_iommu_v1_unmap(struct iommu_domain *domain, unsigned long iova,
+				 size_t size, struct iommu_iotlb_gather *gather)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
 	u32 *pgt_base_iova = dom->pgt_va + (iova  >> MT2701_IOMMU_PAGE_SHIFT);
 	unsigned int page_num = size >> MT2701_IOMMU_PAGE_SHIFT;
@@ -379,15 +376,14 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 	memset(pgt_base_iova, 0, page_num * sizeof(u32));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	mtk_iommu_tlb_flush_range(dom->data, iova, size);
+	mtk_iommu_v1_tlb_flush_range(dom->data, iova, size);
 
 	return size;
 }
 
-static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
-					  dma_addr_t iova)
+static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
 	phys_addr_t pa;
 
@@ -399,17 +395,16 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static const struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_v1_ops;
 
 /*
  * MTK generation one iommu HW only support one iommu domain, and all the client
  * sharing the same iova address space.
  */
-static int mtk_iommu_create_mapping(struct device *dev,
-				    struct of_phandle_args *args)
+static int mtk_iommu_v1_create_mapping(struct device *dev, struct of_phandle_args *args)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_data *data;
+	struct mtk_iommu_v1_data *data;
 	struct platform_device *m4updev;
 	struct dma_iommu_mapping *mtk_mapping;
 	int ret;
@@ -421,11 +416,11 @@ static int mtk_iommu_create_mapping(struct device *dev,
 	}
 
 	if (!fwspec) {
-		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_ops);
+		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
 		if (ret)
 			return ret;
 		fwspec = dev_iommu_fwspec_get(dev);
-	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_ops) {
+	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_v1_ops) {
 		return -EINVAL;
 	}
 
@@ -457,23 +452,23 @@ static int mtk_iommu_create_mapping(struct device *dev,
 	return 0;
 }
 
-static int mtk_iommu_def_domain_type(struct device *dev)
+static int mtk_iommu_v1_def_domain_type(struct device *dev)
 {
 	return IOMMU_DOMAIN_UNMANAGED;
 }
 
-static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
+static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct of_phandle_args iommu_spec;
-	struct mtk_iommu_data *data;
+	struct mtk_iommu_v1_data *data;
 	int err, idx = 0;
 
 	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
 					   "#iommu-cells",
 					   idx, &iommu_spec)) {
 
-		err = mtk_iommu_create_mapping(dev, &iommu_spec);
+		err = mtk_iommu_v1_create_mapping(dev, &iommu_spec);
 		of_node_put(iommu_spec.np);
 		if (err)
 			return ERR_PTR(err);
@@ -483,7 +478,7 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 		idx++;
 	}
 
-	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
+	if (!fwspec || fwspec->ops != &mtk_iommu_v1_ops)
 		return ERR_PTR(-ENODEV); /* Not a iommu client device */
 
 	data = dev_iommu_priv_get(dev);
@@ -491,10 +486,10 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 	return &data->iommu;
 }
 
-static void mtk_iommu_probe_finalize(struct device *dev)
+static void mtk_iommu_v1_probe_finalize(struct device *dev)
 {
 	struct dma_iommu_mapping *mtk_mapping;
-	struct mtk_iommu_data *data;
+	struct mtk_iommu_v1_data *data;
 	int err;
 
 	data        = dev_iommu_priv_get(dev);
@@ -505,17 +500,17 @@ static void mtk_iommu_probe_finalize(struct device *dev)
 		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
 }
 
-static void mtk_iommu_release_device(struct device *dev)
+static void mtk_iommu_v1_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
+	if (!fwspec || fwspec->ops != &mtk_iommu_v1_ops)
 		return;
 
 	iommu_fwspec_free(dev);
 }
 
-static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
+static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
 {
 	u32 regval;
 	int ret;
@@ -545,7 +540,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 
 	writel_relaxed(F_MMU_DCM_ON, data->base + REG_MMU_DCM);
 
-	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
+	if (devm_request_irq(data->dev, data->irq, mtk_iommu_v1_isr, 0,
 			     dev_name(data->dev), (void *)data)) {
 		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
 		clk_disable_unprepare(data->bclk);
@@ -556,36 +551,36 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	return 0;
 }
 
-static const struct iommu_ops mtk_iommu_ops = {
-	.domain_alloc	= mtk_iommu_domain_alloc,
-	.domain_free	= mtk_iommu_domain_free,
-	.attach_dev	= mtk_iommu_attach_device,
-	.detach_dev	= mtk_iommu_detach_device,
-	.map		= mtk_iommu_map,
-	.unmap		= mtk_iommu_unmap,
-	.iova_to_phys	= mtk_iommu_iova_to_phys,
-	.probe_device	= mtk_iommu_probe_device,
-	.probe_finalize = mtk_iommu_probe_finalize,
-	.release_device	= mtk_iommu_release_device,
-	.def_domain_type = mtk_iommu_def_domain_type,
+static const struct iommu_ops mtk_iommu_v1_ops = {
+	.domain_alloc	= mtk_iommu_v1_domain_alloc,
+	.domain_free	= mtk_iommu_v1_domain_free,
+	.attach_dev	= mtk_iommu_v1_attach_device,
+	.detach_dev	= mtk_iommu_v1_detach_device,
+	.map		= mtk_iommu_v1_map,
+	.unmap		= mtk_iommu_v1_unmap,
+	.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
+	.probe_device	= mtk_iommu_v1_probe_device,
+	.probe_finalize = mtk_iommu_v1_probe_finalize,
+	.release_device	= mtk_iommu_v1_release_device,
+	.def_domain_type = mtk_iommu_v1_def_domain_type,
 	.device_group	= generic_device_group,
 	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
 	.owner          = THIS_MODULE,
 };
 
-static const struct of_device_id mtk_iommu_of_ids[] = {
+static const struct of_device_id mtk_iommu_v1_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
 
-static const struct component_master_ops mtk_iommu_com_ops = {
-	.bind		= mtk_iommu_bind,
-	.unbind		= mtk_iommu_unbind,
+static const struct component_master_ops mtk_iommu_v1_com_ops = {
+	.bind		= mtk_iommu_v1_bind,
+	.unbind		= mtk_iommu_v1_unbind,
 };
 
-static int mtk_iommu_probe(struct platform_device *pdev)
+static int mtk_iommu_v1_probe(struct platform_device *pdev)
 {
-	struct mtk_iommu_data		*data;
+	struct mtk_iommu_v1_data	*data;
 	struct device			*dev = &pdev->dev;
 	struct resource			*res;
 	struct component_match		*match = NULL;
@@ -649,7 +644,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	ret = mtk_iommu_hw_init(data);
+	ret = mtk_iommu_v1_hw_init(data);
 	if (ret)
 		return ret;
 
@@ -658,17 +653,17 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
+	ret = iommu_device_register(&data->iommu, &mtk_iommu_v1_ops, dev);
 	if (ret)
 		goto out_sysfs_remove;
 
 	if (!iommu_present(&platform_bus_type)) {
-		ret = bus_set_iommu(&platform_bus_type,  &mtk_iommu_ops);
+		ret = bus_set_iommu(&platform_bus_type,  &mtk_iommu_v1_ops);
 		if (ret)
 			goto out_dev_unreg;
 	}
 
-	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
+	ret = component_master_add_with_match(dev, &mtk_iommu_v1_com_ops, match);
 	if (ret)
 		goto out_bus_set_null;
 	return ret;
@@ -682,9 +677,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
+static int mtk_iommu_v1_remove(struct platform_device *pdev)
 {
-	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
+	struct mtk_iommu_v1_data *data = platform_get_drvdata(pdev);
 
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
@@ -694,14 +689,14 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+	component_master_del(&pdev->dev, &mtk_iommu_v1_com_ops);
 	return 0;
 }
 
-static int __maybe_unused mtk_iommu_suspend(struct device *dev)
+static int __maybe_unused mtk_iommu_v1_suspend(struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_get_drvdata(dev);
-	struct mtk_iommu_suspend_reg *reg = &data->reg;
+	struct mtk_iommu_v1_data *data = dev_get_drvdata(dev);
+	struct mtk_iommu_v1_suspend_reg *reg = &data->reg;
 	void __iomem *base = data->base;
 
 	reg->standard_axi_mode = readl_relaxed(base +
@@ -712,10 +707,10 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mtk_iommu_resume(struct device *dev)
+static int __maybe_unused mtk_iommu_v1_resume(struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_get_drvdata(dev);
-	struct mtk_iommu_suspend_reg *reg = &data->reg;
+	struct mtk_iommu_v1_data *data = dev_get_drvdata(dev);
+	struct mtk_iommu_v1_suspend_reg *reg = &data->reg;
 	void __iomem *base = data->base;
 
 	writel_relaxed(data->m4u_dom->pgt_pa, base + REG_MMU_PT_BASE_ADDR);
@@ -728,20 +723,20 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops mtk_iommu_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
+static const struct dev_pm_ops mtk_iommu_v1_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_iommu_v1_suspend, mtk_iommu_v1_resume)
 };
 
-static struct platform_driver mtk_iommu_driver = {
-	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
+static struct platform_driver mtk_iommu_v1_driver = {
+	.probe	= mtk_iommu_v1_probe,
+	.remove	= mtk_iommu_v1_remove,
 	.driver	= {
 		.name = "mtk-iommu-v1",
-		.of_match_table = mtk_iommu_of_ids,
-		.pm = &mtk_iommu_pm_ops,
+		.of_match_table = mtk_iommu_v1_of_ids,
+		.pm = &mtk_iommu_v1_pm_ops,
 	}
 };
-module_platform_driver(mtk_iommu_driver);
+module_platform_driver(mtk_iommu_v1_driver);
 
 MODULE_DESCRIPTION("IOMMU API for MediaTek M4U v1 implementations");
 MODULE_LICENSE("GPL v2");
-- 
2.18.0

