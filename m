Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB749AF44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455845AbiAYJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:07:36 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1454997AbiAYJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:02:09 -0500
X-UUID: a41564b1970443bdb264540a86af9f8a-20220125
X-UUID: a41564b1970443bdb264540a86af9f8a-20220125
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 244645084; Tue, 25 Jan 2022 17:00:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 25 Jan 2022 17:00:38 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 17:00:36 +0800
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
Subject: [PATCH v4 29/35] iommu/mediatek: Add mtk_iommu_bank_data structure
Date:   Tue, 25 Jan 2022 16:56:28 +0800
Message-ID: <20220125085634.17972-30-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for supporting multi-banks for the IOMMU HW, No functional change.

Add a new structure(mtk_iommu_bank_data) for each a bank. Each a bank have
the independent HW base/IRQ/tlb-range ops, and each a bank has its special
iommu-domain(independent pgtable), thus, also move the domain information
into it.

In previous SoC, we have only one bank which could be treated as bank0(
bankid always is 0 for the previous SoC).

After adding this structure, the tlb operations and irq could use
bank_data as parameter.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 179 +++++++++++++++++++++++++-------------
 1 file changed, 117 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f88c7bb235bf..dc47dc0e3163 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -151,6 +151,7 @@
 #define MTK_LARB_SUBCOM_MAX	8
 
 #define MTK_IOMMU_GROUP_MAX	8
+#define MTK_IOMMU_BANK_MAX	5
 
 enum mtk_iommu_plat {
 	M4U_MT2712,
@@ -187,25 +188,36 @@ struct mtk_iommu_plat_data {
 	struct list_head			*hw_list;
 	unsigned int				iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
+
+	u8                  banks_num;
+	bool                banks_enable[MTK_IOMMU_BANK_MAX];
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
 };
 
-struct mtk_iommu_data {
+struct mtk_iommu_bank_data {
 	void __iomem			*base;
 	int				irq;
+	u8				id;
+	struct device			*parent_dev;
+	struct mtk_iommu_data		*parent_data;
+	spinlock_t			tlb_lock; /* lock for tlb range flush */
+	struct mtk_iommu_domain		*m4u_dom; /* Each bank has a domain */
+};
+
+struct mtk_iommu_data {
 	struct device			*dev;
 	struct clk			*bclk;
 	phys_addr_t			protect_base; /* protect memory base */
 	struct mtk_iommu_suspend_reg	reg;
-	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group[MTK_IOMMU_GROUP_MAX];
 	bool                            enable_4GB;
-	spinlock_t			tlb_lock; /* lock for tlb range flush */
 
 	struct iommu_device		iommu;
 	const struct mtk_iommu_plat_data *plat_data;
 	struct device			*smicomm_dev;
 
+	struct mtk_iommu_bank_data	*bank;
+
 	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
 	struct regmap			*pericfg;
 
@@ -225,7 +237,7 @@ struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
 	struct io_pgtable_ops		*iop;
 
-	struct mtk_iommu_data		*data;
+	struct mtk_iommu_bank_data	*bank;
 	struct iommu_domain		domain;
 
 	struct mutex			mutex; /* Protect "data" in this structure */
@@ -322,20 +334,24 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
-	void __iomem *base = data->base;
+	/* Tlb flush all always is in bank0. */
+	struct mtk_iommu_bank_data *bank = &data->bank[0];
+	void __iomem *base = bank->base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&data->tlb_lock, flags);
+	spin_lock_irqsave(&bank->tlb_lock, flags);
 	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + data->plat_data->inv_sel_reg);
 	writel_relaxed(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
 	wmb(); /* Make sure the tlb flush all done */
-	spin_unlock_irqrestore(&data->tlb_lock, flags);
+	spin_unlock_irqrestore(&bank->tlb_lock, flags);
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-					   struct mtk_iommu_data *data)
+					   struct mtk_iommu_bank_data *bank)
 {
-	struct list_head *head = data->hw_list;
+	struct list_head *head = bank->parent_data->hw_list;
+	struct mtk_iommu_bank_data *curbank;
+	struct mtk_iommu_data *data;
 	bool check_pm_status;
 	unsigned long flags;
 	void __iomem *base;
@@ -365,9 +381,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 				continue;
 		}
 
-		base = data->base;
+		curbank = &data->bank[bank->id];
+		base = curbank->base;
 
-		spin_lock_irqsave(&data->tlb_lock, flags);
+		spin_lock_irqsave(&curbank->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       base + data->plat_data->inv_sel_reg);
 
@@ -382,7 +399,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 
 		/* Clear the CPE status */
 		writel_relaxed(0, base + REG_MMU_CPE_DONE);
-		spin_unlock_irqrestore(&data->tlb_lock, flags);
+		spin_unlock_irqrestore(&curbank->tlb_lock, flags);
 
 		if (ret) {
 			dev_warn(data->dev,
@@ -397,12 +414,13 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 
 static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 {
-	struct mtk_iommu_data *data = dev_id;
-	struct mtk_iommu_domain *dom = data->m4u_dom;
+	struct mtk_iommu_bank_data *bank = dev_id;
+	struct mtk_iommu_data *data = bank->parent_data;
+	struct mtk_iommu_domain *dom = bank->m4u_dom;
 	unsigned int fault_larb = MTK_INVALID_LARBID, fault_port = 0, sub_comm = 0;
 	u32 int_state, regval, va34_32, pa34_32;
 	const struct mtk_iommu_plat_data *plat_data = data->plat_data;
-	void __iomem *base = data->base;
+	void __iomem *base = bank->base;
 	u64 fault_iova, fault_pa;
 	bool layer, write;
 
@@ -441,10 +459,10 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}
 
-	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
+	if (report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
-			data->dev,
+			bank->parent_dev,
 			"fault type=0x%x iova=0x%llx pa=0x%llx master=0x%x(larb=%d port=%d) layer=%d %s\n",
 			int_state, fault_iova, fault_pa, regval, fault_larb, fault_port,
 			layer, write ? "write" : "read");
@@ -541,12 +559,14 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 				     unsigned int domid)
 {
 	const struct mtk_iommu_iova_region *region;
-
-	/* Use the exist domain as there is only one pgtable here. */
-	if (data->m4u_dom) {
-		dom->iop = data->m4u_dom->iop;
-		dom->cfg = data->m4u_dom->cfg;
-		dom->domain.pgsize_bitmap = data->m4u_dom->cfg.pgsize_bitmap;
+	struct mtk_iommu_domain	*m4u_dom;
+
+	/* Always use bank0 in sharing pgtable case */
+	m4u_dom = data->bank[0].m4u_dom;
+	if (m4u_dom) {
+		dom->iop = m4u_dom->iop;
+		dom->cfg = m4u_dom->cfg;
+		dom->domain.pgsize_bitmap = m4u_dom->cfg.pgsize_bitmap;
 		goto update_iova_region;
 	}
 
@@ -609,6 +629,8 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct list_head *hw_list = data->hw_list;
 	struct device *m4udev = data->dev;
+	struct mtk_iommu_bank_data *bank;
+	unsigned int bankid = 0;
 	int ret, domid;
 
 	domid = mtk_iommu_get_domain_id(dev, data->plat_data);
@@ -616,7 +638,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		return domid;
 
 	mutex_lock(&dom->mutex);
-	if (!dom->data) {
+	if (!dom->bank) {
 		/* Data is in the frstdata in sharing pgtable case. */
 		frstdata = mtk_iommu_get_frst_data(hw_list);
 
@@ -625,12 +647,13 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 			mutex_unlock(&dom->mutex);
 			return -ENODEV;
 		}
-		dom->data = data;
+		dom->bank = &data->bank[bankid];
 	}
 	mutex_unlock(&dom->mutex);
 
 	mutex_lock(&data->mutex);
-	if (!data->m4u_dom) { /* Initialize the M4U HW */
+	bank = &data->bank[bankid];
+	if (!bank->m4u_dom) { /* Initialize the M4U HW */
 		ret = pm_runtime_resume_and_get(m4udev);
 		if (ret < 0)
 			goto data_unlock;
@@ -640,9 +663,9 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 			pm_runtime_put(m4udev);
 			goto data_unlock;
 		}
-		data->m4u_dom = dom;
+		bank->m4u_dom = dom;
 		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
-		       data->base + REG_MMU_PT_BASE_ADDR);
+		       bank->base + REG_MMU_PT_BASE_ADDR);
 
 		pm_runtime_put(m4udev);
 	}
@@ -669,7 +692,7 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
 	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
-	if (dom->data->enable_4GB)
+	if (dom->bank->parent_data->enable_4GB)
 		paddr |= BIT_ULL(32);
 
 	/* Synchronize with the tlb_lock */
@@ -690,7 +713,7 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_all(dom->data);
+	mtk_iommu_tlb_flush_all(dom->bank->parent_data);
 }
 
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
@@ -699,7 +722,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	size_t length = gather->end - gather->start + 1;
 
-	mtk_iommu_tlb_flush_range_sync(gather->start, length, dom->data);
+	mtk_iommu_tlb_flush_range_sync(gather->start, length, dom->bank);
 }
 
 static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
@@ -707,7 +730,7 @@ static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_range_sync(iova, size, dom->data);
+	mtk_iommu_tlb_flush_range_sync(iova, size, dom->bank);
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -718,7 +741,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
-	    dom->data->enable_4GB &&
+	    dom->bank->parent_data->enable_4GB &&
 	    pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
 		pa &= ~BIT_ULL(32);
 
@@ -850,16 +873,17 @@ static const struct iommu_ops mtk_iommu_ops = {
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 {
+	const struct mtk_iommu_bank_data *bank0 = &data->bank[0];
 	u32 regval;
 
 	if (data->plat_data->m4u_plat == M4U_MT8173) {
 		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
 			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
 	} else {
-		regval = readl_relaxed(data->base + REG_MMU_CTRL_REG);
+		regval = readl_relaxed(bank0->base + REG_MMU_CTRL_REG);
 		regval |= F_MMU_TF_PROT_TO_PROGRAM_ADDR;
 	}
-	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
+	writel_relaxed(regval, bank0->base + REG_MMU_CTRL_REG);
 
 	if (data->enable_4GB &&
 	    MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_VLD_PA_RNG)) {
@@ -868,31 +892,31 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
 		 */
 		regval = F_MMU_VLD_PA_RNG(7, 4);
-		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
+		writel_relaxed(regval, bank0->base + REG_MMU_VLD_PA_RNG);
 	}
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, DCM_DISABLE))
-		writel_relaxed(F_MMU_DCM, data->base + REG_MMU_DCM_DIS);
+		writel_relaxed(F_MMU_DCM, bank0->base + REG_MMU_DCM_DIS);
 	else
-		writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
+		writel_relaxed(0, bank0->base + REG_MMU_DCM_DIS);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, WR_THROT_EN)) {
 		/* write command throttling mode */
-		regval = readl_relaxed(data->base + REG_MMU_WR_LEN_CTRL);
+		regval = readl_relaxed(bank0->base + REG_MMU_WR_LEN_CTRL);
 		regval &= ~F_MMU_WR_THROT_DIS_MASK;
-		writel_relaxed(regval, data->base + REG_MMU_WR_LEN_CTRL);
+		writel_relaxed(regval, bank0->base + REG_MMU_WR_LEN_CTRL);
 	}
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
 		/* The register is called STANDARD_AXI_MODE in this case */
 		regval = 0;
 	} else {
-		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
+		regval = readl_relaxed(bank0->base + REG_MMU_MISC_CTRL);
 		if (MTK_IOMMU_HAS_FLAG(data->plat_data, NOT_STD_AXI_MODE))
 			regval &= ~F_MMU_STANDARD_AXI_MODE_MASK;
 		if (MTK_IOMMU_HAS_FLAG(data->plat_data, OUT_ORDER_WR_EN))
 			regval &= ~F_MMU_IN_ORDER_WR_EN_MASK;
 	}
-	writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
+	writel_relaxed(regval, bank0->base + REG_MMU_MISC_CTRL);
 
 	regval = F_L2_MULIT_HIT_EN |
 		F_TABLE_WALK_FAULT_INT_EN |
@@ -900,7 +924,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_MISS_FIFO_OVERFLOW_INT_EN |
 		F_PREFETCH_FIFO_ERR_INT_EN |
 		F_MISS_FIFO_ERR_INT_EN;
-	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
+	writel_relaxed(regval, bank0->base + REG_MMU_INT_CONTROL0);
 
 	regval = F_INT_TRANSLATION_FAULT |
 		F_INT_MAIN_MULTI_HIT_FAULT |
@@ -909,19 +933,19 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_TLB_MISS_FAULT |
 		F_INT_MISS_TRANSACTION_FIFO_FAULT |
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
-	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
+	writel_relaxed(regval, bank0->base + REG_MMU_INT_MAIN_CONTROL);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
 			 upper_32_bits(data->protect_base);
-	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
+	writel_relaxed(regval, bank0->base + REG_MMU_IVRP_PADDR);
 
-	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
-			     dev_name(data->dev), (void *)data)) {
-		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
-		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
+	if (devm_request_irq(bank0->parent_dev, bank0->irq, mtk_iommu_isr, 0,
+			     dev_name(bank0->parent_dev), (void *)bank0)) {
+		writel_relaxed(0, bank0->base + REG_MMU_PT_BASE_ADDR);
+		dev_err(bank0->parent_dev, "Failed @ IRQ-%d Request\n", bank0->irq);
 		return -ENODEV;
 	}
 
@@ -1011,9 +1035,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	struct component_match  *match = NULL;
 	struct regmap		*infracfg;
 	void                    *protect;
-	int                     ret;
+	int                     ret, banks_num;
 	u32			val;
 	char                    *p;
+	struct mtk_iommu_bank_data *bank;
+	void __iomem		*base;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -1051,14 +1077,26 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->base))
-		return PTR_ERR(data->base);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 	ioaddr = res->start;
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
+	banks_num = data->plat_data->banks_num;
+	data->bank = devm_kmalloc(dev, banks_num * sizeof(*data->bank), GFP_KERNEL);
+	if (!data->bank)
+		return -ENOMEM;
+
+	bank = &data->bank[0];
+	bank->id = 0;
+	bank->base = base;
+	bank->m4u_dom = NULL;
+	bank->irq = platform_get_irq(pdev, 0);
+	if (bank->irq < 0)
+		return bank->irq;
+	bank->parent_dev = dev;
+	bank->parent_data = data;
+	spin_lock_init(&bank->tlb_lock);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)) {
 		data->bclk = devm_clk_get(dev, "bclk");
@@ -1095,8 +1133,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_sysfs_remove;
 
-	spin_lock_init(&data->tlb_lock);
-
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
 		list_add_tail(&data->list, data->plat_data->hw_list);
 		data->hw_list = data->plat_data->hw_list;
@@ -1146,6 +1182,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
+	struct mtk_iommu_bank_data *bank = &data->bank[0];
 
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
@@ -1162,7 +1199,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 #endif
 	}
 	pm_runtime_disable(&pdev->dev);
-	devm_free_irq(&pdev->dev, data->irq, data);
+	devm_free_irq(&pdev->dev, bank->irq, bank);
 	return 0;
 }
 
@@ -1170,7 +1207,7 @@ static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	void __iomem *base = data->base;
+	void __iomem *base = data->bank[0].base;
 
 	reg->wr_len_ctrl = readl_relaxed(base + REG_MMU_WR_LEN_CTRL);
 	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
@@ -1188,8 +1225,8 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
-	void __iomem *base = data->base;
+	struct mtk_iommu_domain *m4u_dom = data->bank[0].m4u_dom;
+	void __iomem *base = data->bank[0].base;
 	int ret;
 
 	ret = clk_prepare_enable(data->bclk);
@@ -1237,6 +1274,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.hw_list      = &m4ulist,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
+	.banks_num    = 1,
+	.banks_enable = {true},
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
 };
@@ -1246,6 +1285,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
 			 NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
+	.banks_num    = 1,
+	.banks_enable = {true},
 	.iova_region   = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
@@ -1256,6 +1297,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
 			MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.banks_num    = 1,
+	.banks_enable = {true},
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
@@ -1267,6 +1310,8 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
 			MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.banks_num    = 1,
+	.banks_enable = {true},
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
@@ -1276,6 +1321,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
 	.flags        = RESET_AXI | MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.banks_num    = 1,
+	.banks_enable = {true},
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
@@ -1287,6 +1334,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE |
 			  MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num      = 1,
+	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
@@ -1299,6 +1348,8 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
 			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT,
 	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
 	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
+	.banks_num        = 1,
+	.banks_enable     = {true},
 	.iova_region      = single_domain,
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
 };
@@ -1310,6 +1361,8 @@ static const struct mtk_iommu_plat_data mt8195_data_vdo = {
 			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
 	.hw_list        = &m4ulist,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num      = 1,
+	.banks_enable   = {true},
 	.iova_region	= mt8192_multi_dom,
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
@@ -1323,6 +1376,8 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
 	.hw_list        = &m4ulist,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num      = 1,
+	.banks_enable   = {true},
 	.iova_region	= mt8192_multi_dom,
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{1}, {3},
-- 
2.18.0

