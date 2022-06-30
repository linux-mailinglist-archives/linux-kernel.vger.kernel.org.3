Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7857561F38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiF3P1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiF3P1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:27:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBCCC3D1C1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:27:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD3B01063;
        Thu, 30 Jun 2022 08:27:16 -0700 (PDT)
Received: from [10.57.85.25] (unknown [10.57.85.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB243F66F;
        Thu, 30 Jun 2022 08:27:14 -0700 (PDT)
Message-ID: <ad86a9b0-42b3-6d10-0f77-74b35cc02a6a@arm.com>
Date:   Thu, 30 Jun 2022 16:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 2/2] iommu/mediatek: Allow page table PA up to 35bit
Content-Language: en-GB
To:     yf.wang@mediatek.com, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220630092927.24925-1-yf.wang@mediatek.com>
 <20220630092927.24925-3-yf.wang@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220630092927.24925-3-yf.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-30 10:29, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA. So add
> the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT to let level 1 and level 2
> pgtable support at most 35bit PA.

FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..3b9f4bdb15b7 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -34,7 +34,6 @@
>   #include <dt-bindings/memory/mtk-memory-port.h>
>   
>   #define REG_MMU_PT_BASE_ADDR			0x000
> -#define MMU_PT_ADDR_MASK			GENMASK(31, 7)
>   
>   #define REG_MMU_INVALIDATE			0x020
>   #define F_ALL_INVLD				0x2
> @@ -138,6 +137,7 @@
>   /* PM and clock always on. e.g. infra iommu */
>   #define PM_CLK_AO			BIT(15)
>   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +#define PGTABLE_PA_35_EN		BIT(17)
>   
>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>   				((((pdata)->flags) & (mask)) == (_x))
> @@ -596,6 +596,9 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
>   		.iommu_dev = data->dev,
>   	};
>   
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN))
> +		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT;
> +
>   	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
>   		dom->cfg.oas = data->enable_4GB ? 33 : 32;
>   	else
> @@ -684,8 +687,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   			goto err_unlock;
>   		}
>   		bank->m4u_dom = dom;
> -		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       bank->base + REG_MMU_PT_BASE_ADDR);
> +		writel(dom->cfg.arm_v7s_cfg.ttbr, bank->base + REG_MMU_PT_BASE_ADDR);
>   
>   		pm_runtime_put(m4udev);
>   	}
> @@ -1366,8 +1368,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>   		writel_relaxed(reg->int_control[i], base + REG_MMU_INT_CONTROL0);
>   		writel_relaxed(reg->int_main_control[i], base + REG_MMU_INT_MAIN_CONTROL);
>   		writel_relaxed(reg->ivrp_paddr[i], base + REG_MMU_IVRP_PADDR);
> -		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       base + REG_MMU_PT_BASE_ADDR);
> +		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr, base + REG_MMU_PT_BASE_ADDR);
>   	} while (++i < data->plat_data->banks_num);
>   
>   	/*
> @@ -1401,7 +1402,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>   static const struct mtk_iommu_plat_data mt6779_data = {
>   	.m4u_plat      = M4U_MT6779,
>   	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
> -			 MTK_IOMMU_TYPE_MM,
> +			 MTK_IOMMU_TYPE_MM | PGTABLE_PA_35_EN,
>   	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
>   	.banks_num    = 1,
>   	.banks_enable = {true},
