Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1B46B7E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhLGJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:51:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38542 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhLGJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:51:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA3F6B816D2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9FEC341C3;
        Tue,  7 Dec 2021 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638870505;
        bh=vU8wO38cP4NaOW9H1aLEKq1y2IOx0CaMh4iBi218CjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKxmAVaxRiMthinPzyb/GcsePkjpJw8O/mteJcgWW9g3zif2K+CfLAKjdwJxdrV6h
         4r+MXtfN5+JID54y4/Z+GKX2EX/usLdo1iXgniGYgujBHcGZc07NhBk21P9XvCGVlq
         zkrpag/zlD0PM6BVrhCHBl6pwYe2FhBlTvxhDzgDgM/cl1+FIm4eD/claqL9k6ZFXW
         uJtDSGZ9uWSd7+DrynFCx74rwtQdFsEbCkAwGIzqhM+/s1NzaIys5E/1aNOlJprNGx
         Hkv8fd7EG7o4HrkIHd3IKyHz0/FpXfUhnFrQmD1SVMoYx/Dy5w6RjfHfcqFeP87Hol
         50IdLUEtOQDqg==
Date:   Tue, 7 Dec 2021 09:48:18 +0000
From:   Will Deacon <will@kernel.org>
To:     yf.wang@mediatek.com
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, wsd_upstream@mediatek.com,
        Libo Kang <Libo.Kang@mediatek.com>,
        Yong Wu <Yong.Wu@mediatek.com>,
        Guangming Cao <Guangming.Cao@mediatek.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: Add error handle for page
 table allocation failure
Message-ID: <20211207094817.GA31382@willie-the-truck>
References: <20211207024723.25751-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207024723.25751-1-yf.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:47:22AM +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> In __arm_v7s_alloc_table function:
> iommu call kmem_cache_alloc to allocate page table, this function
> allocate memory may fail, when kmem_cache_alloc fails to allocate
> table, call virt_to_phys will be abnomal and return unexpected phys
> and goto out_free, then call kmem_cache_free to release table will
> trigger KE, __get_free_pages and free_pages have similar problem,
> so add error handle for page table allocation failure.
> 
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index bfb6acb651e5..d84240308f4b 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -246,6 +246,12 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>  			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
>  	else if (lvl == 2)
>  		table = kmem_cache_zalloc(data->l2_tables, gfp);
> +
> +	if (!table) {
> +		dev_err(dev, "Page table allocation failure lvl:%d\n", lvl);

I'd expect the allocator to shout loudly on failure anyway, so I don't think
we need to print another message here.

Will
