Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECFC54B1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiFNM4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiFNM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4A3EF09
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB9B61630
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E45C3411B;
        Tue, 14 Jun 2022 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655211398;
        bh=iHxMC4bK6vMql08nJAlYbsQGBq196kEhV81vmOYVdZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OL3u7YQsW8BKxJr9mZnLJZ54ASq/5yWpIgMB7+NQ6dB47B8QBKOaj3DWsXG4WZZWo
         94+tTl3/bXtEEsJx+YhNGunEoioNhiWTqPKGWeeKsojraklxMaeLknfvE2/anjJpna
         hjjHfvga0anMPUX6M1dFbEOtF7CDq/yBGhc1mpZh8GKa5mjPAxnmqb5wkG65Hm+PHv
         rFFGKJzhIdhSdsC6yPyNoChrzdooUpJoUST+3Egcf+R/MKhqoYqj7k2xQ4b3iJnsh4
         d5sszGowTb0c2X8W5g6+E0ZVt8LIqpmaFEjys0R8Z5wy6skpmm6Wy194g+erJCvXrU
         5Qqc5Xa7jGttQ==
Date:   Tue, 14 Jun 2022 13:56:31 +0100
From:   Will Deacon <will@kernel.org>
To:     yf.wang@mediatek.com
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Sven Peter <sven@svenpeter.dev>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, wsd_upstream@mediatek.com,
        Libo Kang <Libo.Kang@mediatek.com>,
        Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
Subject: Re: [PATCH v8 1/3] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
Message-ID: <20220614125630.GA8159@willie-the-truck>
References: <20220611102656.10954-1-yf.wang@mediatek.com>
 <20220611102656.10954-2-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611102656.10954-2-yf.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For some reason, this series has landed in my spam folder so apologies
for the delay :/

On Sat, Jun 11, 2022 at 06:26:53PM +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA and
> cause pgtable PA size larger than 32bit.
> 
> Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> so add a quirk to allow the PA of pgtables support up to bit35.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 48 ++++++++++++++++++++++--------
>  include/linux/io-pgtable.h         | 17 +++++++----
>  2 files changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index be066c1503d3..d4702d8d825a 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -182,14 +182,8 @@ static bool arm_v7s_is_mtk_enabled(struct io_pgtable_cfg *cfg)
>  		(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT);
>  }
>  
> -static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> -				    struct io_pgtable_cfg *cfg)
> +static arm_v7s_iopte to_iopte_mtk(phys_addr_t paddr, arm_v7s_iopte pte)
>  {
> -	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> -
> -	if (!arm_v7s_is_mtk_enabled(cfg))
> -		return pte;
> -
>  	if (paddr & BIT_ULL(32))
>  		pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
>  	if (paddr & BIT_ULL(33))
> @@ -199,6 +193,17 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>  	return pte;
>  }
>  
> +static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> +				    struct io_pgtable_cfg *cfg)
> +{
> +	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> +
> +	if (!arm_v7s_is_mtk_enabled(cfg))
> +		return pte;
> +
> +	return to_iopte_mtk(paddr, pte);

nit, but can we rename and rework this so it reads a bit better, please?
Something like:


	if (arm_v7s_is_mtk_enabled(cfg))
		return to_mtk_iopte(paddr, pte);

	return pte;


>  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>  				  struct io_pgtable_cfg *cfg)
>  {
> @@ -234,6 +239,7 @@ static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
>  static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>  				   struct arm_v7s_io_pgtable *data)
>  {
> +	gfp_t gfp_l1 = __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA;
>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	struct device *dev = cfg->iommu_dev;
>  	phys_addr_t phys;
> @@ -241,9 +247,11 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>  	size_t size = ARM_V7S_TABLE_SIZE(lvl, cfg);
>  	void *table = NULL;
>  
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> +		gfp_l1 = GFP_KERNEL | __GFP_ZERO;

I think it's a bit grotty to override the flags inline like this (same for
the slab flag later on). Something like this is a bit cleaner:


	/*
	 * Comment explaining why GFP_KERNEL is desirable here.
	 * I'm assuming it's because the walker can address all of memory.
	 */
	gfp_l1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
		 GFP_KERNEL : ARM_V7S_TABLE_GFP_DMA;

	...

	__get_free_pages(gfp_l1 | __GFP_ZERO, ...);


and similar for the slab flag.

>  	if (lvl == 1)
> -		table = (void *)__get_free_pages(
> -			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
> +		table = (void *)__get_free_pages(gfp_l1, get_order(size));
>  	else if (lvl == 2)
>  		table = kmem_cache_zalloc(data->l2_tables, gfp);
>  
> @@ -251,7 +259,8 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>  		return NULL;
>  
>  	phys = virt_to_phys(table);
> -	if (phys != (arm_v7s_iopte)phys) {
> +	if (phys != (arm_v7s_iopte)phys &&
> +	    !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)) {
>  		/* Doesn't fit in PTE */

Shouldn't we be checking that the address is within 35 bits here? Perhaps we
should generate a mask from the oas instead of just using the cast.

>  		dev_err(dev, "Page table does not fit in PTE: %pa", &phys);
>  		goto out_free;
> @@ -457,9 +466,14 @@ static arm_v7s_iopte arm_v7s_install_table(arm_v7s_iopte *table,
>  					   arm_v7s_iopte curr,
>  					   struct io_pgtable_cfg *cfg)
>  {
> +	phys_addr_t phys = virt_to_phys(table);
>  	arm_v7s_iopte old, new;
>  
> -	new = virt_to_phys(table) | ARM_V7S_PTE_TYPE_TABLE;
> +	new = phys | ARM_V7S_PTE_TYPE_TABLE;
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> +		new = to_iopte_mtk(phys, new);
> +
>  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
>  		new |= ARM_V7S_ATTR_NS_TABLE;
>  
> @@ -778,6 +792,7 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
>  static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  						void *cookie)
>  {
> +	slab_flags_t slab_flag = ARM_V7S_TABLE_SLAB_FLAGS;
>  	struct arm_v7s_io_pgtable *data;
>  
>  	if (cfg->ias > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
> @@ -788,7 +803,8 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
>  			    IO_PGTABLE_QUIRK_NO_PERMS |
> -			    IO_PGTABLE_QUIRK_ARM_MTK_EXT))
> +			    IO_PGTABLE_QUIRK_ARM_MTK_EXT |
> +			    IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT))
>  		return NULL;
>  
>  	/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
> @@ -796,15 +812,21 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  	    !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))
>  			return NULL;
>  
> +	if ((cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT) &&
> +	    !arm_v7s_is_mtk_enabled(cfg))
> +		return NULL;
> +
>  	data = kmalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return NULL;
>  
>  	spin_lock_init(&data->split_lock);
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> +		slab_flag = 0;
>  	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
>  					    ARM_V7S_TABLE_SIZE(2, cfg),
>  					    ARM_V7S_TABLE_SIZE(2, cfg),
> -					    ARM_V7S_TABLE_SLAB_FLAGS, NULL);
> +					    slab_flag, NULL);
>  	if (!data->l2_tables)
>  		goto out_free_data;
>  
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 86af6f0a00a2..c9189716f6bd 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -74,17 +74,22 @@ struct io_pgtable_cfg {
>  	 *	to support up to 35 bits PA where the bit32, bit33 and bit34 are
>  	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
>  	 *
> +	 * IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT: (ARM v7s format) MediaTek IOMMUs
> +	 *	extend the translation table base support up to 35 bits PA, the
> +	 *	encoding format is same with IO_PGTABLE_QUIRK_ARM_MTK_EXT.
> +	 *

One thing I don't get is how the existing driver handles this. It seems
as though if the HAS_4GB_MODE flag is not set, then we set oas to 35 but
without any pgtable changes. How does this work?

If it turns out that the existing devices can't handle 35-bit PAs, then
could we use an oas of 35 to indicate that this new format is in use
instead of introducing another quirk?

Will
