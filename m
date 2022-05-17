Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1F529CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiEQIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiEQIij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:38:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641EF65BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:38:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4240467373; Tue, 17 May 2022 10:38:35 +0200 (CEST)
Date:   Tue, 17 May 2022 10:38:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de, robin.murphy@arm.com,
        m.szyprowski@samsung.com, chenxiang66@hisilicon.com,
        thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liyihang6@hisilicon.com
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <20220517083834.GA16965@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 09:06:01PM +0800, John Garry wrote:
> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
> exceeds the IOVA rcache upper limit (meaning that they are not cached),
> performance can be reduced.
> 
> Add the IOMMU callback for DMA mapping API dma_max_mapping_size(), which
> allows the drivers to know the mapping limit and thus limit the requested 
> IOVA lengths.
> 
> This resolves the performance issue originally reported in [0] for a SCSI
> HBA driver which was regularly mapping SGLs which required IOVAs in
> excess of the IOVA caching limit. In this case the block layer limits the
> max sectors per request - as configured in __scsi_init_queue() - which
> will limit the total SGL length the driver tries to map and in turn limits
> IOVA lengths requested.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, and not
> a hard limit which I expect is the semantics of dma_map_ops.max_mapping_size
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..e2d5205cde37 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1442,6 +1442,21 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>  	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>  }
>  

> +	if (!domain)
> +		return 0;
> +
> +	cookie = domain->iova_cookie;
> +	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
> +		return 0;

Can these conditions even be true here?

> +static inline unsigned long iova_rcache_range(void)
> +{
> +	return 0;
> +}

Given that IOMMU_DMA select IOMMU_IOVA there is no need for this stub.

Otherwise this looks sensible to me.
