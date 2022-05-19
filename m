Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD60752CC50
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiESG6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiESG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:58:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485BB82FD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:58:28 -0700 (PDT)
X-UUID: 5e06e23243c441ed9b7ba938ae37ae72-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:c0bcec9f-7c0c-4b7f-9dc2-8f6095442be5,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:1fa3d379-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 5e06e23243c441ed9b7ba938ae37ae72-20220519
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1184963467; Thu, 19 May 2022 14:58:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 19 May 2022 14:58:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 May 2022 14:58:18 +0800
Message-ID: <1625ec1f4cded0f825d93743d3d03fcf83cad5aa.camel@mediatek.com>
Subject: Re: [PATCH v5 2/2] iommu/mediatek: Allow page table PA up to 35bit
From:   Yong Wu <yong.wu@mediatek.com>
To:     <yf.wang@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 19 May 2022 14:58:18 +0800
In-Reply-To: <20220516141608.11709-3-yf.wang@mediatek.com>
References: <20220516141608.11709-1-yf.wang@mediatek.com>
         <20220516141608.11709-3-yf.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-16 at 22:16 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Add the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT support, so that
> allows
> page table PA up to 35bit, not only in ZONE_DMA32.

Comment why this is needed.

e.g. For single normal zone.

> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fd75a60abd6..1b9a876ef271 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -33,6 +33,7 @@
>  
>  #define REG_MMU_PT_BASE_ADDR			0x000
>  #define MMU_PT_ADDR_MASK			GENMASK(31, 7)
> +#define MMU_PT_ADDR_2_0_MASK			GENMASK(2, 0)
>  
>  #define REG_MMU_INVALIDATE			0x020
>  #define F_ALL_INVLD				0x2
> @@ -118,6 +119,7 @@
>  #define WR_THROT_EN			BIT(6)
>  #define HAS_LEGACY_IVRP_PADDR		BIT(7)
>  #define IOVA_34_EN			BIT(8)
> +#define PGTABLE_PA_35_EN		BIT(9)
>  
>  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>  		((((pdata)->flags) & (_x)) == (_x))
> @@ -401,6 +403,9 @@ static int mtk_iommu_domain_finalise(struct
> mtk_iommu_domain *dom,
>  		.iommu_dev = data->dev,
>  	};
>  
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN))
> +		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT;
> +
>  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
>  		dom->cfg.oas = data->enable_4GB ? 33 : 32;
>  	else
> @@ -450,6 +455,7 @@ static int mtk_iommu_attach_device(struct
> iommu_domain *domain,
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>  	struct device *m4udev = data->dev;
>  	int ret, domid;
> +	u32 regval;
>  
>  	domid = mtk_iommu_get_domain_id(dev, data->plat_data);
>  	if (domid < 0)
> @@ -472,8 +478,14 @@ static int mtk_iommu_attach_device(struct
> iommu_domain *domain,
>  			return ret;
>  		}
>  		data->m4u_dom = dom;
> -		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       data->base + REG_MMU_PT_BASE_ADDR);
> +
> +		/* Bits[6:3] are invalid for mediatek platform */
> +		if (MTK_IOMMU_HAS_FLAG(data->plat_data,
> PGTABLE_PA_35_EN))
> +			regval = (dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK) |
> +				 (dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_2_0_MASK);

The bits[2:0] has already handled in ARM_V7S_TTBR_35BIT_PA of
patch[1/2], we need calculate it again here?

1) Extend arm_v7s_cfg.ttbr to u64, then we could put the special ttbr
logical into our file.

2) if 1) is not allowed, We have to put this in v7s.
if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT) {
       cfg->arm_v7s_cfg.ttbr = (paddr & GENMASK(31, 7)) |
upper_32_bits(paddr);
       return &data->iop;
}

This need Robin/Will confirm.

> +		else
> +			regval = dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK;

Save this value to our data. then we don't need calculate it again in
the resume cb.   

> +		writel(regval, data->base + REG_MMU_PT_BASE_ADDR);
>  
>  		pm_runtime_put(m4udev);
>  	}
> @@ -987,6 +999,7 @@ static int __maybe_unused
> mtk_iommu_runtime_resume(struct device *dev)
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
>  	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
>  	void __iomem *base = data->base;
> +	u32 regval;
>  	int ret;
>  
>  	ret = clk_prepare_enable(data->bclk);
> @@ -1010,7 +1023,14 @@ static int __maybe_unused
> mtk_iommu_runtime_resume(struct device *dev)
>  	writel_relaxed(reg->int_main_control, base +
> REG_MMU_INT_MAIN_CONTROL);
>  	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
>  	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
> -	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base +
> REG_MMU_PT_BASE_ADDR);
> +
> +	/* Bits[6:3] are invalid for mediatek platform */
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN))
> +		regval = (m4u_dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK) |
> +			 (m4u_dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_2_0_MASK);
> +	else
> +		regval = m4u_dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK;
> +	writel(regval, base + REG_MMU_PT_BASE_ADDR);
>  
>  	/*
>  	 * Users may allocate dma buffer before they call
> pm_runtime_get,
> @@ -1038,7 +1058,8 @@ static const struct mtk_iommu_plat_data
> mt2712_data = {
>  
>  static const struct mtk_iommu_plat_data mt6779_data = {
>  	.m4u_plat      = M4U_MT6779,
> -	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
> +	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN |
> +			 PGTABLE_PA_35_EN,
>  	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
>  	.iova_region   = single_domain,
>  	.iova_region_nr = ARRAY_SIZE(single_domain),

