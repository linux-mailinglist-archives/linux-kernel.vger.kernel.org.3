Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72201560E92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiF3BG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiF3BG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:06:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D116275D9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8EEB1CE2719
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6359DC34114;
        Thu, 30 Jun 2022 01:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656551212;
        bh=rf8ydyMF9jB1/wdlniuphKYaGwrKeatmW07T0hp5ssY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Jwu502o8WWiI46qeXhszzTv9Irueag1IhJCd7UH2r5tgWCxBbtreJrGSBaDO1GbPJ
         5+2TPNq6teIjJyRPYx7VknbWw1hIFe7IhKNUOzh9S84bmgIHXSeeoaMf3JfY7Q9/jn
         VuWxUbcomUea8k+NbJYxH2tBIRrYxwXf/JnicRNHzaEP2uz4nXrEAR5N4o5BXalamZ
         K1/m/RLqkkcLNioqoYaAAe2DcOn2w+nkzL27ir9b4TV9kF8b6ElbTdDj1opCKyH7pA
         9SFXdPn8gsO2sHuLbybM45lrx02S18Nt+LZVQ/L7xUBNe96+qssFmF5fNkiVeDa2qc
         duCw//hfcU9UQ==
Date:   Wed, 29 Jun 2022 18:06:51 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [PATCH V1 1/2] xen/unpopulated-alloc: Introduce helpers for
 contiguous allocations
In-Reply-To: <1655740136-3974-2-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206291733500.4389@ubuntu-linux-20-04-desktop>
References: <1655740136-3974-1-git-send-email-olekstysh@gmail.com> <1655740136-3974-2-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Add ability to allocate unpopulated contiguous pages suitable for
> grant mapping into. This is going to be used by userspace PV backends
> for grant mappings in gnttab code (see gnttab_dma_alloc_pages()).
> 
> Patch also changes the allocation mechanism for unpopulated pages.
> Instead of using page_list and page->zone_device_data to manage
> hot-plugged in fill_pool() (former fill_list()) pages, reuse genpool
> subsystem to do the job for us.
> 
> Please note that even for non-contiguous allocations we always try
> to allocate single contiguous chunk in alloc_unpopulated_pages()
> instead of allocating memory page-by-page. Although it leads to less
> efficient resource utilization, it is faster. Taking into the account
> that on both x86 and Arm the unpopulated memory resource is arbitrarily
> large (it is not backed by real memory) this is not going to be a problem.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> I am still thinking how we can optimize free_unpopulated_pages()
> to avoid freeing memory page-by-page for non-contiguous allocations:
> 1. We could update users to allocate/free contiguous pages even when
>    continuity is not strictly required. But besides a need to alter
>    a few places, this also requires having a valid struct device
>    pointer in hand (maybe instead of passing *dev we could pass
>    max_addr? With that we could drop DMA_BIT_MASK).
> 2. Almost all users of unpopulated pages (except gnttab_page_cache_shrink()
>    in grant-table.c) retain initially allocated pages[i] array, so it
>    passed in free_unpopulated_pages() absolutely unmodified since
>    being allocated.
>    We could update free_unpopulated_pages() to always try to free memory
>    by a single chuck (previously make sure that chunk is in a pool using
>    gen_pool_has_addr()) and update gnttab_page_cache_shrink() to not pass
>    pages[i] array with mixed pages in it when dealing with unpopulated
>    pages. This doesn't require altering a few places.
> 
> Any thoughts?
 
I think it would be better to change the callers, because it would be an
obvious explicit change, compared to try to be smarter in
free_unpopulated_pages.


> Changes RFC -> V1:
>    - update commit subject/description
>    - rework to avoid code duplication (resolve initial TODO)
>    - rename API according to new naming scheme (s/dma/contiguous),
>      also rename some local stuff
>    - drop the page_list & friends entirely and use unpopulated_pool for all
>      (contiguous and non-contiguous) allocations
>    - fix build on x86 by inclusion of <linux/dma-mapping.h>
>    - introduce is_xen_unpopulated_page()
>    - share the implementation for xen_alloc_unpopulated_contiguous_pages()
>      and xen_alloc_unpopulated_pages()
> ---
>  drivers/xen/unpopulated-alloc.c | 188 +++++++++++++++++++++++++++++-----------
>  include/xen/xen.h               |  20 +++++
>  2 files changed, 158 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
> index a39f2d3..3988480d 100644
> --- a/drivers/xen/unpopulated-alloc.c
> +++ b/drivers/xen/unpopulated-alloc.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/dma-mapping.h>
>  #include <linux/errno.h>
> +#include <linux/genalloc.h>
>  #include <linux/gfp.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> @@ -12,9 +14,8 @@
>  #include <xen/page.h>
>  #include <xen/xen.h>
>  
> -static DEFINE_MUTEX(list_lock);
> -static struct page *page_list;
> -static unsigned int list_count;
> +static DEFINE_MUTEX(pool_lock);
> +static struct gen_pool *unpopulated_pool;
>  
>  static struct resource *target_resource;
>  
> @@ -31,12 +32,12 @@ int __weak __init arch_xen_unpopulated_init(struct resource **res)
>  	return 0;
>  }
>  
> -static int fill_list(unsigned int nr_pages)
> +static int fill_pool(unsigned int nr_pages)
>  {
>  	struct dev_pagemap *pgmap;
>  	struct resource *res, *tmp_res = NULL;
>  	void *vaddr;
> -	unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
> +	unsigned int alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
>  	struct range mhp_range;
>  	int ret;
>  
> @@ -106,6 +107,7 @@ static int fill_list(unsigned int nr_pages)
>           * conflict with any devices.
>           */
>  	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> +		unsigned int i;
>  		xen_pfn_t pfn = PFN_DOWN(res->start);
>  
>  		for (i = 0; i < alloc_pages; i++) {
> @@ -125,16 +127,17 @@ static int fill_list(unsigned int nr_pages)
>  		goto err_memremap;
>  	}
>  
> -	for (i = 0; i < alloc_pages; i++) {
> -		struct page *pg = virt_to_page(vaddr + PAGE_SIZE * i);
> -
> -		pg->zone_device_data = page_list;
> -		page_list = pg;
> -		list_count++;
> +	ret = gen_pool_add_virt(unpopulated_pool, (unsigned long)vaddr, res->start,
> +			alloc_pages * PAGE_SIZE, NUMA_NO_NODE);
> +	if (ret) {
> +		pr_err("Cannot add memory range to the unpopulated pool\n");
> +		goto err_pool;
>  	}
>  
>  	return 0;
>  
> +err_pool:
> +	memunmap_pages(pgmap);
>  err_memremap:
>  	kfree(pgmap);
>  err_pgmap:
> @@ -149,51 +152,49 @@ static int fill_list(unsigned int nr_pages)
>  	return ret;
>  }
>  
> -/**
> - * xen_alloc_unpopulated_pages - alloc unpopulated pages
> - * @nr_pages: Number of pages
> - * @pages: pages returned
> - * @return 0 on success, error otherwise
> - */
> -int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
> +static int alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages,
> +		bool contiguous)
>  {
>  	unsigned int i;
>  	int ret = 0;
> +	void *vaddr;
> +	bool filled = false;
>  
>  	/*
>  	 * Fallback to default behavior if we do not have any suitable resource
>  	 * to allocate required region from and as the result we won't be able to
>  	 * construct pages.
>  	 */
> -	if (!target_resource)
> +	if (!target_resource) {
> +		if (contiguous && nr_pages > 1)
> +			return -ENODEV;

unpopulated_init fails and return an error if !target_resource. Does the
latest Linux continue booting if unpopulated_init, an early_initcall,
fails?

If not, then there is no point in this check because we cannot get to
this point.


>  		return xen_alloc_ballooned_pages(nr_pages, pages);
> +	}
> +
> +	mutex_lock(&pool_lock);
>  
> -	mutex_lock(&list_lock);
> -	if (list_count < nr_pages) {
> -		ret = fill_list(nr_pages - list_count);
> +	while (!(vaddr = (void *)gen_pool_alloc(unpopulated_pool,
> +			nr_pages * PAGE_SIZE))) {
> +		if (filled)
> +			ret = -ENOMEM;
> +		else {
> +			ret = fill_pool(nr_pages);
> +			filled = true;
> +		}
>  		if (ret)
>  			goto out;
>  	}
>  
>  	for (i = 0; i < nr_pages; i++) {
> -		struct page *pg = page_list;
> -
> -		BUG_ON(!pg);
> -		page_list = pg->zone_device_data;
> -		list_count--;
> -		pages[i] = pg;
> +		pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);
>  
>  #ifdef CONFIG_XEN_HAVE_PVMMU
>  		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> -			ret = xen_alloc_p2m_entry(page_to_pfn(pg));
> +			ret = xen_alloc_p2m_entry(page_to_pfn(pages[i]));
>  			if (ret < 0) {
> -				unsigned int j;
> -
> -				for (j = 0; j <= i; j++) {
> -					pages[j]->zone_device_data = page_list;
> -					page_list = pages[j];
> -					list_count++;
> -				}
> +				gen_pool_free(unpopulated_pool, (unsigned long)vaddr,
> +						nr_pages * PAGE_SIZE);
>  				goto out;
>  			}
>  		}
> @@ -201,9 +202,68 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>  	}
>  
>  out:
> -	mutex_unlock(&list_lock);
> +	mutex_unlock(&pool_lock);
>  	return ret;
>  }
> +
> +static bool in_unpopulated_pool(unsigned int nr_pages, struct page *page)
> +{
> +	if (!target_resource)
> +		return false;
> +
> +	return gen_pool_has_addr(unpopulated_pool,
> +			(unsigned long)page_to_virt(page), nr_pages * PAGE_SIZE);
> +}
> +
> +static void free_unpopulated_pages(unsigned int nr_pages, struct page **pages,
> +		bool contiguous)
> +{
> +	if (!target_resource) {
> +		if (contiguous && nr_pages > 1)
> +			return;
> +
> +		xen_free_ballooned_pages(nr_pages, pages);
> +		return;
> +	}
> +
> +	mutex_lock(&pool_lock);
> +
> +	/* XXX Do we need to check the range (gen_pool_has_addr)? */
> +	if (contiguous)
> +		gen_pool_free(unpopulated_pool, (unsigned long)page_to_virt(pages[0]),
> +				nr_pages * PAGE_SIZE);
> +	else {
> +		unsigned int i;
> +
> +		for (i = 0; i < nr_pages; i++)
> +			gen_pool_free(unpopulated_pool,
> +					(unsigned long)page_to_virt(pages[i]), PAGE_SIZE);
> +	}
> +
> +	mutex_unlock(&pool_lock);
> +}
> +
> +/**
> + * is_xen_unpopulated_page - check whether page is unpopulated
> + * @page: page to be checked
> + * @return true if page is unpopulated, else otherwise
> + */
> +bool is_xen_unpopulated_page(struct page *page)
> +{
> +	return in_unpopulated_pool(1, page);
> +}
> +EXPORT_SYMBOL(is_xen_unpopulated_page);
> +
> +/**
> + * xen_alloc_unpopulated_pages - alloc unpopulated pages
> + * @nr_pages: Number of pages
> + * @pages: pages returned
> + * @return 0 on success, error otherwise
> + */
> +int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
> +{
> +	return alloc_unpopulated_pages(nr_pages, pages, false);
> +}
>  EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
>  
>  /**
> @@ -213,22 +273,40 @@ EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
>   */
>  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>  {
> -	unsigned int i;
> +	free_unpopulated_pages(nr_pages, pages, false);
> +}
> +EXPORT_SYMBOL(xen_free_unpopulated_pages);
>  
> -	if (!target_resource) {
> -		xen_free_ballooned_pages(nr_pages, pages);
> -		return;
> -	}
> +/**
> + * xen_alloc_unpopulated_contiguous_pages - alloc unpopulated contiguous pages
> + * @dev: valid struct device pointer
> + * @nr_pages: Number of pages
> + * @pages: pages returned
> + * @return 0 on success, error otherwise
> + */
> +int xen_alloc_unpopulated_contiguous_pages(struct device *dev,
> +		unsigned int nr_pages, struct page **pages)
> +{
> +	/* XXX Handle devices which support 64-bit DMA address only for now */
> +	if (dma_get_mask(dev) != DMA_BIT_MASK(64))
> +		return -EINVAL;
>  
> -	mutex_lock(&list_lock);
> -	for (i = 0; i < nr_pages; i++) {
> -		pages[i]->zone_device_data = page_list;
> -		page_list = pages[i];
> -		list_count++;
> -	}
> -	mutex_unlock(&list_lock);
> +	return alloc_unpopulated_pages(nr_pages, pages, true);
>  }
> -EXPORT_SYMBOL(xen_free_unpopulated_pages);
> +EXPORT_SYMBOL(xen_alloc_unpopulated_contiguous_pages);
> +
> +/**
> + * xen_free_unpopulated_contiguous_pages - return unpopulated contiguous pages
> + * @dev: valid struct device pointer
> + * @nr_pages: Number of pages
> + * @pages: pages to return
> + */
> +void xen_free_unpopulated_contiguous_pages(struct device *dev,
> +		unsigned int nr_pages, struct page **pages)
> +{
> +	free_unpopulated_pages(nr_pages, pages, true);
> +}
> +EXPORT_SYMBOL(xen_free_unpopulated_contiguous_pages);
>  
>  static int __init unpopulated_init(void)
>  {
> @@ -237,9 +315,19 @@ static int __init unpopulated_init(void)
>  	if (!xen_domain())
>  		return -ENODEV;
>  
> +	unpopulated_pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!unpopulated_pool) {
> +		pr_err("xen:unpopulated: Cannot create unpopulated pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	gen_pool_set_algo(unpopulated_pool, gen_pool_best_fit, NULL);
> +
>  	ret = arch_xen_unpopulated_init(&target_resource);
>  	if (ret) {
>  		pr_err("xen:unpopulated: Cannot initialize target resource\n");
> +		gen_pool_destroy(unpopulated_pool);
> +		unpopulated_pool = NULL;
>  		target_resource = NULL;
>  	}
>  
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 0780a81..7d396cc 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -60,9 +60,16 @@ static inline void xen_set_restricted_virtio_memory_access(void)
>  		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
>  }
>  
> +struct device;
> +
>  #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>  int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
> +int xen_alloc_unpopulated_contiguous_pages(struct device *dev,
> +		unsigned int nr_pages, struct page **pages);
> +void xen_free_unpopulated_contiguous_pages(struct device *dev,
> +		unsigned int nr_pages, struct page **pages);
> +bool is_xen_unpopulated_page(struct page *page);
>  #include <linux/ioport.h>
>  int arch_xen_unpopulated_init(struct resource **res);
>  #else
> @@ -77,6 +84,19 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
>  {
>  	xen_free_ballooned_pages(nr_pages, pages);
>  }
> +static inline int xen_alloc_unpopulated_contiguous_pages(struct device *dev,
> +		unsigned int nr_pages, struct page **pages)
> +{
> +	return -1;
> +}
> +static inline void xen_free_unpopulated_contiguous_pages(struct device *dev,
> +		unsigned int nr_pages, struct page **pages)
> +{
> +}
> +static inline bool is_xen_unpopulated_page(struct page *page)
> +{
> +	return false;
> +}
>  #endif
>  
>  #endif	/* _XEN_XEN_H */
> -- 
> 2.7.4
> 
