Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C146F85C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhLJBXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:23:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51492 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhLJBXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:23:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45984B8273A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B3C004DD;
        Fri, 10 Dec 2021 01:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639099183;
        bh=IFigGwU8llVFOWo9j5SLTHKDnhRiAQJVF3W4ZVu+nWE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=s0a7a6BcHfokRWz7x71QwmFziprxpA7/Id3fNMWgSO+tAuWzvD0/DQpsWZ5l1/Lkf
         diHrCt1etTlqXz3ptTHOp17P7tIjkcoQ7cMxbA9jjhJNRTbTsCGa7PwmwE9eplH3ZC
         4GkD1so2Kj30ZmJVXxjOQHG85CiZMR+qslDZQ/GSv0tBcPF4QvJpMKofVW5kstOSnK
         ZHSMKsgicjCbGJW46Fk0PYaH0svJTwJSgZGnbF4CkZCW6uJKlyoPuWMAkdorsmKuWO
         bc8eFB5yEh3bXmOO1HLbJnalu+FwSn07q0k1RAmXYyv5LpCx3LZMjbD5FZW1JH5P/g
         v5dskxHkLyIgQ==
Date:   Thu, 9 Dec 2021 17:19:41 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: Re: [PATCH V4 4/6] xen/unpopulated-alloc: Add mechanism to use Xen
 resource
In-Reply-To: <1639080336-26573-5-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112091719150.4091490@ubuntu-linux-20-04-desktop>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com> <1639080336-26573-5-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> The main reason of this change is that unpopulated-alloc
> code cannot be used in its current form on Arm, but there
> is a desire to reuse it to avoid wasting real RAM pages
> for the grant/foreign mappings.
> 
> The problem is that system "iomem_resource" is used for
> the address space allocation, but the really unallocated
> space can't be figured out precisely by the domain on Arm
> without hypervisor involvement. For example, not all device
> I/O regions are known by the time domain starts creating
> grant/foreign mappings. And following the advise from
> "iomem_resource" we might end up reusing these regions by
> a mistake. So, the hypervisor which maintains the P2M for
> the domain is in the best position to provide unused regions
> of guest physical address space which could be safely used
> to create grant/foreign mappings.
> 
> Introduce new helper arch_xen_unpopulated_init() which purpose
> is to create specific Xen resource based on the memory regions
> provided by the hypervisor to be used as unused space for Xen
> scratch pages. If arch doesn't define arch_xen_unpopulated_init()
> the default "iomem_resource" will be used.
> 
> Update the arguments list of allocate_resource() in fill_list()
> to always allocate a region from the hotpluggable range
> (maximum possible addressable physical memory range for which
> the linear mapping could be created). If arch doesn't define
> arch_get_mappable_range() the default range (0,-1) will be used.
> 
> The behaviour on x86 won't be changed by current patch as both
> arch_xen_unpopulated_init() and arch_get_mappable_range()
> are not implemented for it.
> 
> Also fallback to allocate xenballooned pages (balloon out RAM
> pages) if we do not have any suitable resource to work with
> (target_resource is invalid) and as the result we won't be able
> to provide unpopulated pages on a request.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Given the changes, I took a second look. The patch looks fine to me.


> ---
> Changes RFC -> V2:
>    - new patch, instead of
>     "[RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide unallocated space"
> 
> Changes V2 -> V3:
>    - update patch description and comments in code
>    - modify arch_xen_unpopulated_init() to pass target_resource as an argument
>      and update default helper to assign iomem_resource to it, also drop
>      xen_resource as it will be located in arch code in the future
>    - allocate region from hotpluggable range instead of hardcoded range (0,-1)
>      in fill_list()
>    - use %pR specifier in error message
>    - do not call unpopulated_init() at runtime from xen_alloc_unpopulated_pages(),
>      drop an extra helper and call arch_xen_unpopulated_init() directly from __init()
>    - include linux/ioport.h instead of forward declaration of struct resource
>    - replace insert_resource() with request_resource() in fill_list()
>    - add __init specifier to arch_xen_unpopulated_init()
> 
> Changes V3 -> V4:
>    - add Stefano's R-b
>    - fix copy-paste error in fill_list(), must be "if (!tmp_res)" instead of
>      "if (!res)" in string 66
>    - add unpopulated_init() with early initcall level specifically to call
>      arch_xen_unpopulated_init()
> ---
>  drivers/xen/unpopulated-alloc.c | 86 +++++++++++++++++++++++++++++++++++++++--
>  include/xen/xen.h               |  2 +
>  2 files changed, 84 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
> index a03dc5b..a8b4105 100644
> --- a/drivers/xen/unpopulated-alloc.c
> +++ b/drivers/xen/unpopulated-alloc.c
> @@ -8,6 +8,7 @@
>  
>  #include <asm/page.h>
>  
> +#include <xen/balloon.h>
>  #include <xen/page.h>
>  #include <xen/xen.h>
>  
> @@ -15,13 +16,29 @@ static DEFINE_MUTEX(list_lock);
>  static struct page *page_list;
>  static unsigned int list_count;
>  
> +static struct resource *target_resource;
> +
> +/*
> + * If arch is not happy with system "iomem_resource" being used for
> + * the region allocation it can provide it's own view by creating specific
> + * Xen resource with unused regions of guest physical address space provided
> + * by the hypervisor.
> + */
> +int __weak __init arch_xen_unpopulated_init(struct resource **res)
> +{
> +	*res = &iomem_resource;
> +
> +	return 0;
> +}
> +
>  static int fill_list(unsigned int nr_pages)
>  {
>  	struct dev_pagemap *pgmap;
> -	struct resource *res;
> +	struct resource *res, *tmp_res = NULL;
>  	void *vaddr;
>  	unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
> -	int ret = -ENOMEM;
> +	struct range mhp_range;
> +	int ret;
>  
>  	res = kzalloc(sizeof(*res), GFP_KERNEL);
>  	if (!res)
> @@ -30,14 +47,40 @@ static int fill_list(unsigned int nr_pages)
>  	res->name = "Xen scratch";
>  	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>  
> -	ret = allocate_resource(&iomem_resource, res,
> -				alloc_pages * PAGE_SIZE, 0, -1,
> +	mhp_range = mhp_get_pluggable_range(true);
> +
> +	ret = allocate_resource(target_resource, res,
> +				alloc_pages * PAGE_SIZE, mhp_range.start, mhp_range.end,
>  				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
>  	if (ret < 0) {
>  		pr_err("Cannot allocate new IOMEM resource\n");
>  		goto err_resource;
>  	}
>  
> +	/*
> +	 * Reserve the region previously allocated from Xen resource to avoid
> +	 * re-using it by someone else.
> +	 */
> +	if (target_resource != &iomem_resource) {
> +		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
> +		if (!tmp_res) {
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
>  	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
>  	if (!pgmap) {
>  		ret = -ENOMEM;
> @@ -95,6 +138,11 @@ static int fill_list(unsigned int nr_pages)
>  err_memremap:
>  	kfree(pgmap);
>  err_pgmap:
> +	if (tmp_res) {
> +		release_resource(tmp_res);
> +		kfree(tmp_res);
> +	}
> +err_insert:
>  	release_resource(res);
>  err_resource:
>  	kfree(res);
> @@ -112,6 +160,14 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>  	unsigned int i;
>  	int ret = 0;
>  
> +	/*
> +	 * Fallback to default behavior if we do not have any suitable resource
> +	 * to allocate required region from and as the result we won't be able to
> +	 * construct pages.
> +	 */
> +	if (!target_resource)
> +		return xen_alloc_ballooned_pages(nr_pages, pages);
> +
>  	mutex_lock(&list_lock);
>  	if (list_count < nr_pages) {
>  		ret = fill_list(nr_pages - list_count);
> @@ -159,6 +215,11 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>  {
>  	unsigned int i;
>  
> +	if (!target_resource) {
> +		xen_free_ballooned_pages(nr_pages, pages);
> +		return;
> +	}
> +
>  	mutex_lock(&list_lock);
>  	for (i = 0; i < nr_pages; i++) {
>  		pages[i]->zone_device_data = page_list;
> @@ -201,3 +262,20 @@ static int __init init(void)
>  }
>  subsys_initcall(init);
>  #endif
> +
> +static int __init unpopulated_init(void)
> +{
> +	int ret;
> +
> +	if (!xen_domain())
> +		return -ENODEV;
> +
> +	ret = arch_xen_unpopulated_init(&target_resource);
> +	if (ret) {
> +		pr_err("xen:unpopulated: Cannot initialize target resource\n");
> +		target_resource = NULL;
> +	}
> +
> +	return ret;
> +}
> +early_initcall(unpopulated_init);
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 86c5b37..a99bab8 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -55,6 +55,8 @@ extern u64 xen_saved_max_mem_size;
>  #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>  int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
> +#include <linux/ioport.h>
> +int arch_xen_unpopulated_init(struct resource **res);
>  #else
>  #include <xen/balloon.h>
>  static inline int xen_alloc_unpopulated_pages(unsigned int nr_pages,
> -- 
> 2.7.4
> 
