Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9353D366
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 23:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348998AbiFCVxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 17:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiFCVxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 17:53:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3357583B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 14:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73EF6B824CE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4719C385B8;
        Fri,  3 Jun 2022 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654293178;
        bh=pgXaHU253phBXXtx1iKJe+k6xQpEHHkD4NWOfztbCWA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DjOo6fbwg+bg41Heda3LMLvcCtBXaZQ+cxFwrckVqaRGhnBMfum6FQ22n8eHlbgPQ
         aWTo/63JBG/GVCzorqGcNfB3ENyrkPhj4kIHbf9YAK6MckjObo74FjEQs59pu3aaVl
         iP2JL2QQft9D2esFF/VhaoOl90Zdu78cCwof2sw4QyG059+mawjfIef6QduD6pX94i
         QshTjhCEQsfV4HSOJ63I8Ck3mkrUE5X4/gdkx42FP9bUeKmYHfyXqhJhUakv2lYQYr
         oQq4D5r06PF74120zwja0pW3vggve0L7GMzSqgeN8uOSt6Y8mwqFhRpiq2arlPOcnF
         KpnK1Ttcl3hdg==
Date:   Fri, 3 Jun 2022 14:52:56 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [RFC PATCH 1/2] xen/unpopulated-alloc: Introduce helpers for
 DMA allocations
In-Reply-To: <1652810658-27810-2-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206031420430.2783803@ubuntu-linux-20-04-desktop>
References: <1652810658-27810-1-git-send-email-olekstysh@gmail.com> <1652810658-27810-2-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Add ability to allocate unpopulated DMAable (contiguous) pages
> suitable for grant mapping into. This is going to be used by gnttab
> code (see gnttab_dma_alloc_pages()).
> 
> TODO: There is a code duplication in fill_dma_pool(). Also pool
> oparations likely need to be protected by the lock.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
>  drivers/xen/unpopulated-alloc.c | 167 ++++++++++++++++++++++++++++++++++++++++
>  include/xen/xen.h               |  15 ++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
> index a39f2d3..bca0198 100644
> --- a/drivers/xen/unpopulated-alloc.c
> +++ b/drivers/xen/unpopulated-alloc.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/errno.h>
> +#include <linux/genalloc.h>
>  #include <linux/gfp.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> @@ -16,6 +17,8 @@ static DEFINE_MUTEX(list_lock);
>  static struct page *page_list;
>  static unsigned int list_count;
>  
> +static struct gen_pool *dma_pool;
> +
>  static struct resource *target_resource;
>  
>  /*
> @@ -230,6 +233,161 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>  }
>  EXPORT_SYMBOL(xen_free_unpopulated_pages);
>  
> +static int fill_dma_pool(unsigned int nr_pages)
> +{

I think we shouldn't need to add this function at all as we should be
able to reuse fill_list even for contiguous pages. fill_list could
always call gen_pool_add_virt before returning.


> +	struct dev_pagemap *pgmap;
> +	struct resource *res, *tmp_res = NULL;
> +	void *vaddr;
> +	unsigned int alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
> +	struct range mhp_range;
> +	int ret;
> +
> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res->name = "Xen DMA pool";
> +	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +
> +	mhp_range = mhp_get_pluggable_range(true);
> +
> +	ret = allocate_resource(target_resource, res,
> +				alloc_pages * PAGE_SIZE, mhp_range.start, mhp_range.end,
> +				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
> +	if (ret < 0) {
> +		pr_err("Cannot allocate new IOMEM resource\n");
> +		goto err_resource;
> +	}
> +
> +	/*
> +	 * Reserve the region previously allocated from Xen resource to avoid
> +	 * re-using it by someone else.
> +	 */
> +	if (target_resource != &iomem_resource) {
> +		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
> +		if (!res) {
> +			ret = -ENOMEM;
> +			goto err_insert;
> +		}
> +
> +		tmp_res->name = res->name;
> +		tmp_res->start = res->start;
> +		tmp_res->end = res->end;
> +		tmp_res->flags = res->flags;
> +
> +		ret = request_resource(&iomem_resource, tmp_res);
> +		if (ret < 0) {
> +			pr_err("Cannot request resource %pR (%d)\n", tmp_res, ret);
> +			kfree(tmp_res);
> +			goto err_insert;
> +		}
> +	}
> +
> +	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
> +	if (!pgmap) {
> +		ret = -ENOMEM;
> +		goto err_pgmap;
> +	}
> +
> +	pgmap->type = MEMORY_DEVICE_GENERIC;
> +	pgmap->range = (struct range) {
> +		.start = res->start,
> +		.end = res->end,
> +	};
> +	pgmap->nr_range = 1;
> +	pgmap->owner = res;
> +
> +	vaddr = memremap_pages(pgmap, NUMA_NO_NODE);
> +	if (IS_ERR(vaddr)) {
> +		pr_err("Cannot remap memory range\n");
> +		ret = PTR_ERR(vaddr);
> +		goto err_memremap;
> +	}
> +
> +	ret = gen_pool_add_virt(dma_pool, (unsigned long)vaddr, res->start,
> +			alloc_pages * PAGE_SIZE, NUMA_NO_NODE);
> +	if (ret)
> +		goto err_pool;
> +
> +	return 0;
> +
> +err_pool:
> +	memunmap_pages(pgmap);
> +err_memremap:
> +	kfree(pgmap);
> +err_pgmap:
> +	if (tmp_res) {
> +		release_resource(tmp_res);
> +		kfree(tmp_res);
> +	}
> +err_insert:
> +	release_resource(res);
> +err_resource:
> +	kfree(res);
> +	return ret;
> +}
> +
> +/**
> + * xen_alloc_unpopulated_dma_pages - alloc unpopulated DMAable pages
> + * @dev: valid struct device pointer
> + * @nr_pages: Number of pages
> + * @pages: pages returned
> + * @return 0 on success, error otherwise
> + */
> +int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
> +		struct page **pages)
> +{
> +	void *vaddr;
> +	bool filled = false;
> +	unsigned int i;
> +	int ret;


Also probably it might be better if xen_alloc_unpopulated_pages and
xen_alloc_unpopulated_dma_pages shared the implementation. Something
along these lines:

int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
{
    return _xen_alloc_unpopulated_pages(nr_pages, pages, false);
}

int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
		struct page **pages)
{
    return _xen_alloc_unpopulated_pages(nr_pages, pages, true);
}

static int _xen_alloc_unpopulated_pages(unsigned int nr_pages,
        struct page **pages, bool contiguous)
{
	unsigned int i;
	int ret = 0;

    if (contiguous && !xen_feature(XENFEAT_auto_translated_physmap))
        return -EINVAL;

	/*
	 * Fallback to default behavior if we do not have any suitable resource
	 * to allocate required region from and as the result we won't be able to
	 * construct pages.
	 */
	if (!target_resource) {
        if (contiguous)
            return -EINVAL;
		return xen_alloc_ballooned_pages(nr_pages, pages);
    }

	mutex_lock(&list_lock);
	if (list_count < nr_pages) {
		ret = fill_list(nr_pages - list_count);
		if (ret)
			goto out;
	}

    if (contiguous) {
        vaddr = (void *)gen_pool_alloc(dma_pool, nr_pages * PAGE_SIZE);

        for (i = 0; i < nr_pages; i++)
            pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);
    } else {
        for (i = 0; i < nr_pages; i++) {
            struct page *pg = page_list;

            BUG_ON(!pg);
            page_list = pg->zone_device_data;
            list_count--;
            pages[i] = pg;

    #ifdef CONFIG_XEN_HAVE_PVMMU
            if (!xen_feature(XENFEAT_auto_translated_physmap)) {
                ret = xen_alloc_p2m_entry(page_to_pfn(pg));
                if (ret < 0) {
                    unsigned int j;

                    for (j = 0; j <= i; j++) {
                        pages[j]->zone_device_data = page_list;
                        page_list = pages[j];
                        list_count++;
                    }
                    goto out;
                }
            }
    #endif
        }
    }

out:
	mutex_unlock(&list_lock);
	return ret;
}

	

> +	if (!dma_pool)
> +		return -ENODEV;
> +
> +	/* XXX Handle devices which support 64-bit DMA address only for now */
> +	if (dma_get_mask(dev) != DMA_BIT_MASK(64))
> +		return -EINVAL;
> +
> +	while (!(vaddr = (void *)gen_pool_alloc(dma_pool, nr_pages * PAGE_SIZE))) {
> +		if (filled)
> +			return -ENOMEM;
> +		else {
> +			ret = fill_dma_pool(nr_pages);
> +			if (ret)
> +				return ret;
> +
> +			filled = true;
> +		}
> +	}
> +
> +	for (i = 0; i < nr_pages; i++)
> +		pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(xen_alloc_unpopulated_dma_pages);
> +
> +/**
> + * xen_free_unpopulated_dma_pages - return unpopulated DMAable pages
> + * @dev: valid struct device pointer
> + * @nr_pages: Number of pages
> + * @pages: pages to return
> + */
> +void xen_free_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
> +		struct page **pages)
> +{
> +	void *vaddr;
> +
> +	if (!dma_pool)
> +		return;
> +
> +	vaddr = page_to_virt(pages[0]);
> +
> +	gen_pool_free(dma_pool, (unsigned long)vaddr, nr_pages * PAGE_SIZE);
> +}
> +EXPORT_SYMBOL(xen_free_unpopulated_dma_pages);
> +
>  static int __init unpopulated_init(void)
>  {
>  	int ret;
> @@ -241,8 +399,17 @@ static int __init unpopulated_init(void)
>  	if (ret) {
>  		pr_err("xen:unpopulated: Cannot initialize target resource\n");
>  		target_resource = NULL;
> +		return ret;
>  	}
>  
> +	dma_pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!dma_pool) {
> +		pr_err("xen:unpopulated: Cannot create DMA pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	gen_pool_set_algo(dma_pool, gen_pool_best_fit, NULL);
> +
>  	return ret;
>  }
>  early_initcall(unpopulated_init);
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index a99bab8..a6a7a59 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -52,9 +52,15 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  extern u64 xen_saved_max_mem_size;
>  #endif
>  
> +struct device;
> +
>  #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>  int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
> +int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
> +		struct page **pages);
> +void xen_free_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
> +		struct page **pages);
>  #include <linux/ioport.h>
>  int arch_xen_unpopulated_init(struct resource **res);
>  #else
> @@ -69,6 +75,15 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
>  {
>  	xen_free_ballooned_pages(nr_pages, pages);
>  }
> +static inline int xen_alloc_unpopulated_dma_pages(struct device *dev,
> +		unsigned int nr_pages, struct page **pages)
> +{
> +	return -1;
> +}
> +static inline void xen_free_unpopulated_dma_pages(struct device *dev,
> +		unsigned int nr_pages, struct page **pages)
> +{
> +}
>  #endif

Given that we have these stubs, maybe we don't need to #ifdef the so
much code in the next patch
