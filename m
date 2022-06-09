Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C1D5452A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbiFIRHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiFIRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:07:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAA428731
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654794423; x=1686330423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DqcLSXzla24BAOWUg0Q7TFQHtplmc6Xrbtg5PjslZl4=;
  b=fQRoW/5/n7nIF/pbRnu/R4hSJ9ghqeM3FDe/oKI07QmGiDTtg+8d6Fcj
   LiOictOVuA85mqIowdSKWuCmEH+Kgkc541h50jQlxUBX1uEdGDERsLe89
   f+ESM9N7uCfEuiYcJ2hu+rWnfb/YGH21cMuKPheb51ieLZ69hV64OMNfr
   04lfj9D51t61LsrPQu4+DAYlcPWmdzeeqhd6tFaHvC8srxbQPnSaF/jHb
   Fqx/A4sNeGIUueXMFRcpfNvijrqTtr7tY5NbL/vkCWwURz40IWuV8PYOf
   C6r2tQ873m6fRIoTj/mh94pGrQX+D/M9otyBH2g7gbswPREccaBtEv7p6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341427575"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341427575"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 10:06:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="610347539"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 10:06:44 -0700
Date:   Thu, 9 Jun 2022 17:06:44 +0000
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Message-ID: <20220609170644.GA33363@araj-dh-work>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609070811.902868-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:08:10PM +0800, Lu Baolu wrote:
> The IOMMU page tables are updated using iommu_map/unmap() interfaces.
> Currently, there is no mandatory requirement for drivers to use locks
> to ensure concurrent updates to page tables, because it's assumed that
> overlapping IOVA ranges do not have concurrent updates. Therefore the
> IOMMU drivers only need to take care of concurrent updates to level
> page table entries.

The last part doesn't read well.. 
s/updates to level page table entries/ updates to page-table entries at the
same level

> 
> But enabling new features challenges this assumption. For example, the
> hardware assisted dirty page tracking feature requires scanning page
> tables in interfaces other than mapping and unmapping. This might result
> in a use-after-free scenario in which a level page table has been freed
> by the unmap() interface, while another thread is scanning the next level
> page table.
> 
> This adds RCU-protected page free support so that the pages are really
> freed and reused after a RCU grace period. Hence, the page tables are
> safe for scanning within a rcu_read_lock critical region. Considering
> that scanning the page table is a rare case, this also adds a domain
> flag and the RCU-protected page free is only used when this flat is set.

s/flat/flag

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  9 +++++++++
>  drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..6f68eabb8567 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -95,6 +95,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	unsigned long concurrent_traversal:1;

Does this need to be a bitfield? Even though you are needing just one bit
now, you can probably make have maskbits?


>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -657,6 +658,12 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>  	dev->iommu->priv = priv;
>  }
>  
> +static inline void domain_set_concurrent_traversal(struct iommu_domain *domain,
> +						   bool value)
> +{
> +	domain->concurrent_traversal = value;
> +}
> +
>  int iommu_probe_device(struct device *dev);
>  void iommu_release_device(struct device *dev);
>  
> @@ -677,6 +684,8 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>  
> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
> +			    struct list_head *pages);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 847ad47a2dfd..ceeb97ebe3e2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3252,3 +3252,26 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  	return user;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +static void pgtble_page_free_rcu(struct rcu_head *rcu)

maybe the names can be consistent? pgtble_ vs pgtbl below.

vote to drop the 'e' :-)

> +{
> +	struct page *page = container_of(rcu, struct page, rcu_head);
> +
> +	__free_pages(page, 0);
> +}
> +
> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
> +			    struct list_head *pages)
> +{
> +	struct page *page, *next;
> +
> +	if (!domain->concurrent_traversal) {
> +		put_pages_list(pages);
> +		return;
> +	}
> +
> +	list_for_each_entry_safe(page, next, pages, lru) {
> +		list_del(&page->lru);
> +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
> +	}
> +}
> -- 
> 2.25.1
> 
