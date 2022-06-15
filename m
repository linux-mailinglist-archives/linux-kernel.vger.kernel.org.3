Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F8954CF87
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbiFOROe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357484AbiFORO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:14:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA63425595
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:14:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC787153B;
        Wed, 15 Jun 2022 10:14:25 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FAB23F73B;
        Wed, 15 Jun 2022 10:14:23 -0700 (PDT)
Message-ID: <949c22c4-5f64-47cf-673c-14fcadcc1d27@arm.com>
Date:   Wed, 15 Jun 2022 18:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 2/3] iommu/mediatek: Rename MTK_IOMMU_TLB_ADDR to
 MTK_IOMMU_ADDR
Content-Language: en-GB
To:     yf.wang@mediatek.com, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
References: <20220615161224.6923-1-yf.wang@mediatek.com>
 <20220615161224.6923-3-yf.wang@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220615161224.6923-3-yf.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-15 17:12, yf.wang--- via iommu wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR, and update MTK_IOMMU_ADDR
> definition for better generality.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..3d62399e8865 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -265,8 +265,8 @@ static const struct iommu_ops mtk_iommu_ops;
>   
>   static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int bankid);
>   
> -#define MTK_IOMMU_TLB_ADDR(iova) ({					\
> -	dma_addr_t _addr = iova;					\
> +#define MTK_IOMMU_ADDR(addr) ({						\
> +	unsigned long long _addr = addr;				\

If phys_addr_t is 64-bit, then dma_addr_t is also 64-bit, so there is no 
loss of generality from using an appropriate type - IOVAs have to fit 
into dma_addr_t for iommu-dma, after all. However, since IOVAs also have 
to fit into unsigned long in the general IOMMU API, as "addr" is here, 
then this is still just as broken for 32-bit LPAE as the existing code is.

Thanks,
Robin.

>   	((lower_32_bits(_addr) & GENMASK(31, 12)) | upper_32_bits(_addr));\
>   })
>   
> @@ -381,8 +381,8 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>   			       base + data->plat_data->inv_sel_reg);
>   
> -		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova), base + REG_MMU_INVLD_START_A);
> -		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova + size - 1),
> +		writel_relaxed(MTK_IOMMU_ADDR(iova), base + REG_MMU_INVLD_START_A);
> +		writel_relaxed(MTK_IOMMU_ADDR(iova + size - 1),
>   			       base + REG_MMU_INVLD_END_A);
>   		writel_relaxed(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
>   
