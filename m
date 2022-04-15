Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550A6503159
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiDOWE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiDOWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:04:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ACF36683
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 829E0B8312B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FCAC385A5;
        Fri, 15 Apr 2022 22:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650060144;
        bh=ibniDVagqscz7a9Zqfo95NyntpeZavcP31iiyCGyBhk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sgTvRxnqzjSXyujNEr61AXshfpFwRsPyEjfhWozbdOo1d5PIsG/V/KJ+zIokfZmf6
         5V3oTSlhN2Bj64ypUrDD8wbuI7a/NXYvrsmGnDxIn8TxY//OHvqrYSBsfyPLSK7uE4
         mp9UK703vMqODlPgd/mDUwo/TATJ629EBvXVjQ/VC+dyUZxjEm/6e6821+hFNS51hq
         vyNQ2n3CUG3N+EF0aoJXwLOUKwiPinKtwkA25QuSmxgxZ3rzUWSrPjCgySpgYT+1xm
         t0eT4xBysLmHXbt6NvDvxRHJN5N15JV4FFjaQKvLCvpTxQuRIgO/V2p8xrvSbO9fmY
         oBxC5hp/myqEA==
Date:   Fri, 15 Apr 2022 15:02:23 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [RFC PATCH 4/6] virtio: Various updates to xen-virtio DMA ops
 layer
In-Reply-To: <1649963973-22879-5-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204151302350.915916@ubuntu-linux-20-04-desktop>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com> <1649963973-22879-5-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-487410210-1650053003=:915916"
Content-ID: <alpine.DEB.2.22.394.2204151317490.915916@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-487410210-1650053003=:915916
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2204151317491.915916@ubuntu-linux-20-04-desktop>

On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> In the context of current patch do the following:
> 1. Update code to support virtio-mmio devices
> 2. Introduce struct xen_virtio_data and account passed virtio devices
>    (using list) as we need to store some per-device data
> 3. Add multi-page support for xen_virtio_dma_map(unmap)_page callbacks
> 4. Harden code against malicious backend
> 5. Change to use alloc_pages_exact() instead of __get_free_pages()
> 6. Introduce locking scheme to protect mappings (I am not 100% sure
>    whether per-device lock is really needed)
> 7. Handle virtio device's DMA mask
> 8. Retrieve the ID of backend domain from DT for virtio-mmio device
>    instead of hardcoding it.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
>  arch/arm/xen/enlighten.c |  11 +++
>  drivers/xen/Kconfig      |   2 +-
>  drivers/xen/xen-virtio.c | 200 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/xen/xen-ops.h    |   5 ++
>  4 files changed, 196 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index ec5b082..870d92f 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -409,6 +409,17 @@ int __init arch_xen_unpopulated_init(struct resource **res)
>  }
>  #endif
>  
> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +int arch_has_restricted_virtio_memory_access(void)
> +{
> +	if (IS_ENABLED(CONFIG_XEN_HVM_VIRTIO_GRANT) && xen_hvm_domain())
> +		return 1;

Instead of xen_hvm_domain(), you can just use xen_domain(). Also there
is no need for the #ifdef
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, given that:

CONFIG_XEN_HVM_VIRTIO_GRANT depends on XEN_VIRTIO which selects
ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS


> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
> +#endif
> +
>  static void __init xen_dt_guest_init(void)
>  {
>  	struct device_node *xen_node;
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index fc61f7a..56afe6a 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -347,7 +347,7 @@ config XEN_VIRTIO
>  
>  config XEN_HVM_VIRTIO_GRANT
>  	bool "Require virtio for fully virtualized guests to use grant mappings"
> -	depends on XEN_VIRTIO && X86_64
> +	depends on XEN_VIRTIO && (X86_64 || ARM || ARM64)

you can remove the architectural dependencies


>  	default y
>  	help
>  	  Require virtio for fully virtualized guests to use grant mappings.
> diff --git a/drivers/xen/xen-virtio.c b/drivers/xen/xen-virtio.c
> index cfd5eda..c5b2ec9 100644
> --- a/drivers/xen/xen-virtio.c
> +++ b/drivers/xen/xen-virtio.c
> @@ -7,12 +7,26 @@
>  
>  #include <linux/module.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/of.h>
>  #include <linux/pci.h>
>  #include <linux/pfn.h>
>  #include <linux/virtio_config.h>
>  #include <xen/xen.h>
>  #include <xen/grant_table.h>
>  
> +struct xen_virtio_data {
> +	/* The ID of backend domain */
> +	domid_t dev_domid;
> +	struct device *dev;
> +	struct list_head list;
> +	spinlock_t lock;
> +	/* Is device behaving sane? */
> +	bool broken;

If you moved "broken" after "dev_domid" we would save a few bytes for
every allocation due to padding.

Is data->lock only there to protect accesses to "broken"? If so, we
might not need it, but I am not sure.


> +};
> +
> +static LIST_HEAD(xen_virtio_devices);
> +static DEFINE_SPINLOCK(xen_virtio_lock);
> +
>  #define XEN_GRANT_ADDR_OFF	0x8000000000000000ULL
>  
>  static inline dma_addr_t grant_to_dma(grant_ref_t grant)
> @@ -25,6 +39,25 @@ static inline grant_ref_t dma_to_grant(dma_addr_t dma)
>  	return (grant_ref_t)((dma & ~XEN_GRANT_ADDR_OFF) >> PAGE_SHIFT);
>  }
>  
> +static struct xen_virtio_data *find_xen_virtio_data(struct device *dev)
> +{
> +	struct xen_virtio_data *data = NULL;
> +	bool found = false;
> +
> +	spin_lock(&xen_virtio_lock);
> +
> +	list_for_each_entry( data, &xen_virtio_devices, list) {
> +		if (data->dev == dev) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	spin_unlock(&xen_virtio_lock);
> +
> +	return found ? data : NULL;
> +}
> +
>  /*
>   * DMA ops for Xen virtio frontends.
>   *
> @@ -43,48 +76,78 @@ static void *xen_virtio_dma_alloc(struct device *dev, size_t size,
>  				  dma_addr_t *dma_handle, gfp_t gfp,
>  				  unsigned long attrs)
>  {
> -	unsigned int n_pages = PFN_UP(size);
> -	unsigned int i;
> +	struct xen_virtio_data *data;
> +	unsigned int i, n_pages = PFN_UP(size);
>  	unsigned long pfn;
>  	grant_ref_t grant;
> -	void *ret;
> +	void *ret = NULL;
>  
> -	ret = (void *)__get_free_pages(gfp, get_order(size));
> -	if (!ret)
> +	data = find_xen_virtio_data(dev);
> +	if (!data)
>  		return NULL;
>  
> +	spin_lock(&data->lock);
> +
> +	if (unlikely(data->broken))
> +		goto out;
> +
> +	ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
> +	if (!ret)
> +		goto out;
> +
>  	pfn = virt_to_pfn(ret);
>  
>  	if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
> -		free_pages((unsigned long)ret, get_order(size));
> -		return NULL;
> +		free_pages_exact(ret, n_pages * PAGE_SIZE);
> +		ret = NULL;
> +		goto out;
>  	}
>  
>  	for (i = 0; i < n_pages; i++) {
> -		gnttab_grant_foreign_access_ref(grant + i, 0,
> +		gnttab_grant_foreign_access_ref(grant + i, data->dev_domid,
>  						pfn_to_gfn(pfn + i), 0);
>  	}
>  
>  	*dma_handle = grant_to_dma(grant);
>  
> +out:
> +	spin_unlock(&data->lock);
> +
>  	return ret;
>  }
>  
>  static void xen_virtio_dma_free(struct device *dev, size_t size, void *vaddr,
>  				dma_addr_t dma_handle, unsigned long attrs)
>  {
> -	unsigned int n_pages = PFN_UP(size);
> -	unsigned int i;
> +	struct xen_virtio_data *data;
> +	unsigned int i, n_pages = PFN_UP(size);
>  	grant_ref_t grant;
>  
> +	data = find_xen_virtio_data(dev);
> +	if (!data)
> +		return;
> +
> +	spin_lock(&data->lock);
> +
> +	if (unlikely(data->broken))
> +		goto out;
> +
>  	grant = dma_to_grant(dma_handle);
>  
> -	for (i = 0; i < n_pages; i++)
> -		gnttab_end_foreign_access_ref(grant + i);
> +	for (i = 0; i < n_pages; i++) {
> +		if (unlikely(!gnttab_end_foreign_access_ref(grant + i))) {
> +			dev_alert(dev, "Grant still in use by backend domain, disabled for further use\n");
> +			data->broken = true;
> +			goto out;
> +		}
> +	}
>  
>  	gnttab_free_grant_reference_seq(grant, n_pages);
>  
> -	free_pages((unsigned long)vaddr, get_order(size));
> +	free_pages_exact(vaddr, n_pages * PAGE_SIZE);
> +
> +out:
> +	spin_unlock(&data->lock);
>  }
>  
>  static struct page *xen_virtio_dma_alloc_pages(struct device *dev, size_t size,
> @@ -108,28 +171,71 @@ static dma_addr_t xen_virtio_dma_map_page(struct device *dev, struct page *page,
>  					  enum dma_data_direction dir,
>  					  unsigned long attrs)
>  {
> +	struct xen_virtio_data *data;
> +	unsigned int i, n_pages = PFN_UP(size);
>  	grant_ref_t grant;
> +	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
> +
> +	BUG_ON(dir == DMA_NONE);
> +
> +	data = find_xen_virtio_data(dev);
> +	if (!data)
> +		return DMA_MAPPING_ERROR;
> +
> +	spin_lock(&data->lock);
>  
> -	if (gnttab_alloc_grant_references(1, &grant))
> -		return 0;
> +	if (unlikely(data->broken))
> +		goto out;
>  
> -	gnttab_grant_foreign_access_ref(grant, 0, xen_page_to_gfn(page),
> -					dir == DMA_TO_DEVICE);
> +	if (gnttab_alloc_grant_reference_seq(n_pages, &grant))
> +		goto out;
>  
> -	return grant_to_dma(grant) + offset;
> +	for (i = 0; i < n_pages; i++) {
> +		gnttab_grant_foreign_access_ref(grant + i, data->dev_domid,
> +				xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
> +	}
> +
> +	dma_handle = grant_to_dma(grant) + offset;
> +
> +out:
> +	spin_unlock(&data->lock);
> +
> +	return dma_handle;
>  }
>  
>  static void xen_virtio_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>  				      size_t size, enum dma_data_direction dir,
>  				      unsigned long attrs)
>  {
> +	struct xen_virtio_data *data;
> +	unsigned int i, n_pages = PFN_UP(size);
>  	grant_ref_t grant;
>  
> +	BUG_ON(dir == DMA_NONE);
> +
> +	data = find_xen_virtio_data(dev);
> +	if (!data)
> +		return;
> +
> +	spin_lock(&data->lock);
> +
> +	if (unlikely(data->broken))
> +		goto out;
> +
>  	grant = dma_to_grant(dma_handle);
>  
> -	gnttab_end_foreign_access_ref(grant);
> +	for (i = 0; i < n_pages; i++) {
> +		if (unlikely(!gnttab_end_foreign_access_ref(grant + i))) {
> +			dev_alert(dev, "Grant still in use by backend domain, disabled for further use\n");
> +			data->broken = true;
> +			goto out;
> +		}
> +	}
> +
> +	gnttab_free_grant_reference_seq(grant, n_pages);
>  
> -	gnttab_free_grant_reference(grant);
> +out:
> +	spin_unlock(&data->lock);
>  }
>  
>  static int xen_virtio_dma_map_sg(struct device *dev, struct scatterlist *sg,
> @@ -149,7 +255,7 @@ static void xen_virtio_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  
>  static int xen_virtio_dma_dma_supported(struct device *dev, u64 mask)
>  {
> -	return 1;
> +	return mask == DMA_BIT_MASK(64);
>  }
>  
>  static const struct dma_map_ops xen_virtio_dma_ops = {
> @@ -166,9 +272,61 @@ static const struct dma_map_ops xen_virtio_dma_ops = {
>  	.dma_supported = xen_virtio_dma_dma_supported,
>  };
>  
> +bool xen_is_virtio_device(struct device *dev)
> +{
> +	/* XXX Handle only DT devices for now */
> +	if (!dev->of_node)
> +		return false;
> +
> +	if (!of_device_is_compatible(dev->of_node, "virtio,mmio"))
> +		return false;
> +
> +	return of_property_read_bool(dev->of_node, "xen,dev-domid");
> +}
> +EXPORT_SYMBOL_GPL(xen_is_virtio_device);
> +
>  void xen_virtio_setup_dma_ops(struct device *dev)
>  {
> +	struct xen_virtio_data *data;
> +	uint32_t dev_domid;
> +
> +	data = find_xen_virtio_data(dev);
> +	if (data) {
> +		dev_err(dev, "xen_virtio data is already created\n");
> +		return;
> +	}
> +
> +	if (dev_is_pci(dev)) {
> +		/* XXX Leave it hard wired to dom0 for now */
> +		dev_domid = 0;
> +	} else if (dev->of_node) {
> +		if (of_property_read_u32(dev->of_node, "xen,dev-domid", &dev_domid)) {
> +			dev_err(dev, "xen,dev-domid property is not present\n");
> +			goto err;
> +		}
> +	} else
> +		/* The ACPI case is not supported */
> +		goto err;

If we get here, it means that xen_is_virtio_device returned true, so the
PCI case is actually impossible?

I would rewrite these checks like this:

/* XXX: ACPI and PCI unsupported for now */
if (dev_is_pci(dev) || !dev->of_node) {
	goto err;
}
if (of_property_read_u32(dev->of_node, "xen,dev-domid", &dev_domid)) {
	dev_err(dev, "xen,dev-domid property is not present\n");
	goto err;
}



> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		dev_err(dev, "Сannot allocate xen_virtio data\n");
> +		goto err;
> +	}
> +	data->dev_domid = dev_domid;
> +	data->dev = dev;
> +	spin_lock_init(&data->lock);
> +
> +	spin_lock(&xen_virtio_lock);
> +	list_add(&data->list, &xen_virtio_devices);
> +	spin_unlock(&xen_virtio_lock);
> +
>  	dev->dma_ops = &xen_virtio_dma_ops;
> +
> +	return;
> +
> +err:
> +	dev_err(dev, "Сannot set up xen_virtio DMA ops, retain platform DMA ops\n");
>  }
>  EXPORT_SYMBOL_GPL(xen_virtio_setup_dma_ops);
>  
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index ae3c1bc..fdbcb99 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -223,10 +223,15 @@ static inline void xen_preemptible_hcall_end(void) { }
>  
>  #ifdef CONFIG_XEN_VIRTIO
>  void xen_virtio_setup_dma_ops(struct device *dev);
> +bool xen_is_virtio_device(struct device *dev);
>  #else
>  static inline void xen_virtio_setup_dma_ops(struct device *dev)
>  {
>  }
> +static inline bool xen_is_virtio_device(struct device *dev)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_XEN_VIRTIO */
>  
>  #endif /* INCLUDE_XEN_OPS_H */
--8323329-487410210-1650053003=:915916--
