Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA954876E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbiFMPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386389AbiFMPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:01:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F6415FC7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:04:46 -0700 (PDT)
X-UUID: bc5b06b7414c4008bf4af9e070d92552-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:e1dfe471-26a4-4d41-9671-d546e6afb218,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:10,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:15
X-CID-META: VersionHash:b14ad71,CLOUDID:77b666c6-12ba-4305-bfdf-9aefbdc32516,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: bc5b06b7414c4008bf4af9e070d92552-20220613
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 44229586; Mon, 13 Jun 2022 20:04:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 13 Jun 2022 20:04:40 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 13 Jun 2022 20:04:40 +0800
Message-ID: <6172e09f04adeade200fe28109e02add89bf722a.camel@mediatek.com>
Subject: Re: [PATCH v8 3/3] iommu/mediatek: Allow page table PA up to 35bit
From:   Yong Wu <yong.wu@mediatek.com>
To:     <yf.wang@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
Date:   Mon, 13 Jun 2022 20:04:39 +0800
In-Reply-To: <20220611102656.10954-4-yf.wang@mediatek.com>
References: <20220611102656.10954-1-yf.wang@mediatek.com>
         <20220611102656.10954-4-yf.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-11 at 18:26 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA. So
> add
> the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT to let level 1 and level
> 2
> pgtable support at most 35bit PA.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

Thanks very much for this function. All the lastest SoCs like
mt8192/mt8195 support this.

> ---
>  drivers/iommu/mtk_iommu.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 3d62399e8865..4dbc33758711 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -138,6 +138,7 @@
>  /* PM and clock always on. e.g. infra iommu */
>  #define PM_CLK_AO			BIT(15)
>  #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +#define PGTABLE_PA_35_EN		BIT(17)
>  
>  #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>  				((((pdata)->flags) & (mask)) == (_x))
> @@ -240,6 +241,7 @@ struct mtk_iommu_data {
>  struct mtk_iommu_domain {
>  	struct io_pgtable_cfg		cfg;
>  	struct io_pgtable_ops		*iop;
> +	u32				ttbr;
>  
>  	struct mtk_iommu_bank_data	*bank;
>  	struct iommu_domain		domain;
> @@ -596,6 +598,9 @@ static int mtk_iommu_domain_finalise(struct
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
> @@ -684,8 +689,8 @@ static int mtk_iommu_attach_device(struct
> iommu_domain *domain,
>  			goto err_unlock;
>  		}
>  		bank->m4u_dom = dom;
> -		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       bank->base + REG_MMU_PT_BASE_ADDR);
> +		bank->m4u_dom->ttbr = MTK_IOMMU_ADDR(dom-
> >cfg.arm_v7s_cfg.ttbr);
> +		writel(bank->m4u_dom->ttbr, data->base +
> REG_MMU_PT_BASE_ADDR);
>  
>  		pm_runtime_put(m4udev);
>  	}
> @@ -1366,8 +1371,7 @@ static int __maybe_unused
> mtk_iommu_runtime_resume(struct device *dev)
>  		writel_relaxed(reg->int_control[i], base +
> REG_MMU_INT_CONTROL0);
>  		writel_relaxed(reg->int_main_control[i], base +
> REG_MMU_INT_MAIN_CONTROL);
>  		writel_relaxed(reg->ivrp_paddr[i], base +
> REG_MMU_IVRP_PADDR);
> -		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK,
> -		       base + REG_MMU_PT_BASE_ADDR);
> +		writel(m4u_dom->ttbr, base + REG_MMU_PT_BASE_ADDR);
>  	} while (++i < data->plat_data->banks_num);
>  
>  	/*
> @@ -1401,7 +1405,7 @@ static const struct mtk_iommu_plat_data
> mt2712_data = {
>  static const struct mtk_iommu_plat_data mt6779_data = {
>  	.m4u_plat      = M4U_MT6779,
>  	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
> WR_THROT_EN |
> -			 MTK_IOMMU_TYPE_MM,
> +			 MTK_IOMMU_TYPE_MM | PGTABLE_PA_35_EN,
>  	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
>  	.banks_num    = 1,
>  	.banks_enable = {true},

