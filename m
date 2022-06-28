Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDBB55E413
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbiF1NLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbiF1NLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:11:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6816012AA6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656421889; x=1687957889;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DaNkICMn0cvyN3Nw69IWZXGw9/gClLhfsSUxhFyTR1w=;
  b=jXMv+sJTbDcBV1TcFej9Hh4S/bAIsDUywfKEn+jD538wwdXhiTmbCB15
   IC8vmCHZSIlG0VDVVZY8f5COWChAAiW9/s9PQ8oAfhNYuAHFZliCmvpJY
   06yGD3Zz2UoZwjl2XWZ9Xr1ZIt56lkTFN6nKDNph3jIKMNqf5nEnV3obe
   sg7nxD6qDsVO6n0c5o8ag6WwDOp2TEcEc306cBMr35UOhpVnzQffyI/UT
   ei6M8r934Am0jjU58F/vLBrr+tMA+6uj1dCw3nzKfetexy6V6lxco8dH7
   7gucsAXnqqcqBTDYnXI/BMefpeYfMDOqsixW6/Pi3JzwhGH1PHWkOTkZ6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307219111"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307219111"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:11:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646908165"
Received: from iannetti-mobl.ger.corp.intel.com ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:11:26 -0700
Date:   Tue, 28 Jun 2022 16:11:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Chao Gao <chao.gao@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, dave.hansen@intel.com,
        len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v1 1/3] swiotlb: Use bitmap to track free slots
In-Reply-To: <20220628070136.419163-2-chao.gao@intel.com>
Message-ID: <ae35e2-f224-635f-442f-ce1a537374e3@linux.intel.com>
References: <20220628070136.419163-1-chao.gao@intel.com> <20220628070136.419163-2-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1081361240-1656421888=:1603"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1081361240-1656421888=:1603
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jun 2022, Chao Gao wrote:

> Currently, each slot tracks the number of contiguous free slots starting
> from itself. It helps to quickly check if there are enough contiguous
> entries when dealing with an allocation request. But maintaining this
> information can leads to some overhead. Specifically, if a slot is
> allocated/freed, preceding slots may need to be updated as the number
> of contiguous free slots can change. This process may access memory
> scattering over multiple cachelines.
> 
> To reduce the overhead of maintaining the number of contiguous free
> entries, use a global bitmap to track free slots; each bit represents
> if a slot is available. The number of contiguous free slots can be
> calculated by counting the number of consecutive 1s in the bitmap.
> 
> Tests show that the average cost of freeing slots drops by 120 cycles
> while the average cost of allocation increases by 20 cycles. Overall,
> 100 cycles are saved from a pair of allocation and freeing.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

One nit below.

> ---
>  include/linux/swiotlb.h |  6 ++--
>  kernel/dma/swiotlb.c    | 64 ++++++++++++++++++++---------------------
>  2 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 7ed35dd3de6e..c3eab237991a 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -78,8 +78,6 @@ extern enum swiotlb_force swiotlb_force;
>   *		@end. For default swiotlb, this is command line adjustable via
>   *		setup_io_tlb_npages.
>   * @used:	The number of used IO TLB block.
> - * @list:	The free list describing the number of free entries available
> - *		from each index.
>   * @index:	The index to start searching in the next round.
>   * @orig_addr:	The original address corresponding to a mapped entry.
>   * @alloc_size:	Size of the allocated buffer.
> @@ -89,6 +87,8 @@ extern enum swiotlb_force swiotlb_force;
>   * @late_alloc:	%true if allocated using the page allocator
>   * @force_bounce: %true if swiotlb bouncing is forced
>   * @for_alloc:  %true if the pool is used for memory allocation
> + * @bitmap:	The bitmap used to track free entries. 1 in bit X means the slot
> + *		indexed by X is free.
>   */
>  struct io_tlb_mem {
>  	phys_addr_t start;
> @@ -105,8 +105,8 @@ struct io_tlb_mem {
>  	struct io_tlb_slot {
>  		phys_addr_t orig_addr;
>  		size_t alloc_size;
> -		unsigned int list;
>  	} *slots;
> +	unsigned long *bitmap;
>  };
>  extern struct io_tlb_mem io_tlb_default_mem;
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index cb50f8d38360..d7f68c0af7f5 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -207,7 +207,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>  
>  	spin_lock_init(&mem->lock);
>  	for (i = 0; i < mem->nslabs; i++) {
> -		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> +		__set_bit(i, mem->bitmap);
>  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size = 0;
>  	}
> @@ -274,6 +274,11 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
>  		      __func__, alloc_size, PAGE_SIZE);
>  
> +	mem->bitmap = memblock_alloc(BITS_TO_BYTES(nslabs), SMP_CACHE_BYTES);
> +	if (!mem->bitmap)
> +		panic("%s: Failed to allocate %lu bytes align=0x%x\n",
> +		      __func__, DIV_ROUND_UP(nslabs, BITS_PER_BYTE), SMP_CACHE_BYTES);
> +
>  	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false);
>  
>  	if (flags & SWIOTLB_VERBOSE)
> @@ -337,10 +342,13 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  			(PAGE_SIZE << order) >> 20);
>  	}
>  
> +	mem->bitmap = bitmap_zalloc(nslabs, GFP_KERNEL);
>  	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  		get_order(array_size(sizeof(*mem->slots), nslabs)));
> -	if (!mem->slots) {
> +	if (!mem->slots || !mem->bitmap) {
>  		free_pages((unsigned long)vstart, order);
> +		bitmap_free(mem->bitmap);
> +		kfree(mem->slots);
>  		return -ENOMEM;
>  	}
>  
> @@ -498,7 +506,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  	unsigned int iotlb_align_mask =
>  		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>  	unsigned int nslots = nr_slots(alloc_size), stride;
> -	unsigned int index, wrap, count = 0, i;
> +	unsigned int index, wrap, i;
>  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>  	unsigned long flags;
>  
> @@ -514,6 +522,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
>  	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
>  
> +	/* slots shouldn't cross one segment */
> +	max_slots = min_t(unsigned long, max_slots, IO_TLB_SEGSIZE);
> +
>  	spin_lock_irqsave(&mem->lock, flags);
>  	if (unlikely(nslots > mem->nslabs - mem->used))
>  		goto not_found;
> @@ -535,8 +546,15 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  		if (!iommu_is_span_boundary(index, nslots,
>  					    nr_slots(tbl_dma_addr),
>  					    max_slots)) {
> -			if (mem->slots[index].list >= nslots)
> +			if (find_next_zero_bit(mem->bitmap, index + nslots, index) ==
> +					index + nslots)
>  				goto found;
> +		} else {
> +			/*
> +			 * Remaining slots between current one and the next
> +			 * bounary cannot meet our requirement.

bounary -> boundary


-- 
 i.

--8323329-1081361240-1656421888=:1603--
