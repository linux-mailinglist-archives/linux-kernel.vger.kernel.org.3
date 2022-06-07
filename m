Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F0539A51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 02:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbiFAATO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 20:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiFAATJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 20:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F07522EB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C01F86149E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E051C385A9;
        Wed,  1 Jun 2022 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654042747;
        bh=P/iz6+csAw0ciTKuenpfmOdcBMP5IIWA42cjgJk9vhg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RlPEtkSEx6F6CWKZ47/uWC1iN+9ybjcUkUNW5g0uMGGhzkNEaQRVAMmLaJQlFNDxh
         CyyxLLGFfORxaKuGG3G3sArabRmUALzpzpiJFSeRTAcPEycRf62F2vLWAC8uTsfXkw
         iSwFuW4TWEEcW2jRMLDQ0PI34+aKf4miSBYzq2woXIXcLFjdHVZv9SB/cCrf27dfKO
         X8DcegkVt/H/ogJBbWpohDKm6ML4sdv8KOdC2hUNzS1qs6Rr/2B9swycHxwo/clOMM
         9BFBG8QT+fsYBWiPnnhU3IvFGeD3lrRImkuMBhlTvVX0IrhO7YJ2p25FwtPfffGELa
         FcqBbiXBHGY0A==
Date:   Tue, 31 May 2022 17:19:05 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V3 3/8] xen/grant-dma-ops: Add option to restrict memory
 access under Xen
In-Reply-To: <1653944417-17168-4-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205311718550.1905099@ubuntu-linux-20-04-desktop>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com> <1653944417-17168-4-git-send-email-olekstysh@gmail.com>
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

On Tue, 31 May 2022, Oleksandr Tyshchenko wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> Introduce Xen grant DMA-mapping layer which contains special DMA-mapping
> routines for providing grant references as DMA addresses to be used by
> frontends (e.g. virtio) in Xen guests.
> 
> Add the needed functionality by providing a special set of DMA ops
> handling the needed grant operations for the I/O pages.
> 
> The subsequent commit will introduce the use case for xen-grant DMA ops
> layer to enable using virtio devices in Xen guests in a safe manner.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Changes RFC -> V1:
>    - squash with almost all changes from commit (except handling "xen,dev-domid"
>      property):
>      "[PATCH 4/6] virtio: Various updates to xen-virtio DMA ops layer"
>    - update commit subject/description and comments in code
>    - leave only single Kconfig option XEN_VIRTIO and remove architectural
>      dependencies
>    - introduce common xen_has_restricted_virtio_memory_access() in xen.h
>      and update arch_has_restricted_virtio_memory_access() for both
>      Arm and x86 to call new helper
>    - use (1ULL << 63) instead of 0x8000000000000000ULL for XEN_GRANT_ADDR_OFF
>    - implement xen_virtio_dma_map(unmap)_sg() using example in swiotlb-xen.c
>    - optimize padding by moving "broken" field in struct xen_virtio_data
>    - remove unneeded per-device spinlock
>    - remove the inclusion of virtio_config.h
>    - remane everything according to the new naming scheme:
>      s/virtio/grant_dma
>    - add new hidden config option XEN_GRANT_DMA_OPS
> 
> Changes V1 -> V2:
>    - fix checkpatch.pl warnings
>    - remove the inclusion of linux/pci.h
>    - rework to use xarray for data context
>    - remove EXPORT_SYMBOL_GPL(xen_grant_setup_dma_ops);
>    - remove the line of * after SPDX-License-Identifier
>    - split changes into grant-dma-ops.c and arch_has_restricted_virtio_memory_access()
>      and update commit subject/description accordingly
>    - remove "default n" for config XEN_VIRTIO
>    - implement xen_grant_dma_alloc(free)_pages()
> 
> Changes V2 -> V3:
>    - Stefano already gave his Reviewed-by, I dropped it due to the changes (minor)
>    - remane field "dev_domid" in struct xen_grant_dma_data to "backend_domid"
>    - remove local variable "domid" in xen_grant_setup_dma_ops()
> ---
>  drivers/xen/Kconfig         |   4 +
>  drivers/xen/Makefile        |   1 +
>  drivers/xen/grant-dma-ops.c | 311 ++++++++++++++++++++++++++++++++++++++++++++
>  include/xen/xen-ops.h       |   8 ++
>  4 files changed, 324 insertions(+)
>  create mode 100644 drivers/xen/grant-dma-ops.c
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 120d32f..313a9127 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -335,4 +335,8 @@ config XEN_UNPOPULATED_ALLOC
>  	  having to balloon out RAM regions in order to obtain physical memory
>  	  space to create such mappings.
>  
> +config XEN_GRANT_DMA_OPS
> +	bool
> +	select DMA_OPS
> +
>  endmenu
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 5aae66e..1a23cb0 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -39,3 +39,4 @@ xen-gntalloc-y				:= gntalloc.o
>  xen-privcmd-y				:= privcmd.o privcmd-buf.o
>  obj-$(CONFIG_XEN_FRONT_PGDIR_SHBUF)	+= xen-front-pgdir-shbuf.o
>  obj-$(CONFIG_XEN_UNPOPULATED_ALLOC)	+= unpopulated-alloc.o
> +obj-$(CONFIG_XEN_GRANT_DMA_OPS)		+= grant-dma-ops.o
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> new file mode 100644
> index 00000000..44659f4
> --- /dev/null
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Xen grant DMA-mapping layer - contains special DMA-mapping routines
> + * for providing grant references as DMA addresses to be used by frontends
> + * (e.g. virtio) in Xen guests
> + *
> + * Copyright (c) 2021, Juergen Gross <jgross@suse.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/of.h>
> +#include <linux/pfn.h>
> +#include <linux/xarray.h>
> +#include <xen/xen.h>
> +#include <xen/grant_table.h>
> +
> +struct xen_grant_dma_data {
> +	/* The ID of backend domain */
> +	domid_t backend_domid;
> +	/* Is device behaving sane? */
> +	bool broken;
> +};
> +
> +static DEFINE_XARRAY(xen_grant_dma_devices);
> +
> +#define XEN_GRANT_DMA_ADDR_OFF	(1ULL << 63)
> +
> +static inline dma_addr_t grant_to_dma(grant_ref_t grant)
> +{
> +	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << PAGE_SHIFT);
> +}
> +
> +static inline grant_ref_t dma_to_grant(dma_addr_t dma)
> +{
> +	return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >> PAGE_SHIFT);
> +}
> +
> +static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
> +{
> +	struct xen_grant_dma_data *data;
> +
> +	xa_lock(&xen_grant_dma_devices);
> +	data = xa_load(&xen_grant_dma_devices, (unsigned long)dev);
> +	xa_unlock(&xen_grant_dma_devices);
> +
> +	return data;
> +}
> +
> +/*
> + * DMA ops for Xen frontends (e.g. virtio).
> + *
> + * Used to act as a kind of software IOMMU for Xen guests by using grants as
> + * DMA addresses.
> + * Such a DMA address is formed by using the grant reference as a frame
> + * number and setting the highest address bit (this bit is for the backend
> + * to be able to distinguish it from e.g. a mmio address).
> + *
> + * Note that for now we hard wire dom0 to be the backend domain. In order
> + * to support any domain as backend we'd need to add a way to communicate
> + * the domid of this backend, e.g. via Xenstore, via the PCI-device's
> + * config space or DT/ACPI.
> + */
> +static void *xen_grant_dma_alloc(struct device *dev, size_t size,
> +				 dma_addr_t *dma_handle, gfp_t gfp,
> +				 unsigned long attrs)
> +{
> +	struct xen_grant_dma_data *data;
> +	unsigned int i, n_pages = PFN_UP(size);
> +	unsigned long pfn;
> +	grant_ref_t grant;
> +	void *ret;
> +
> +	data = find_xen_grant_dma_data(dev);
> +	if (!data)
> +		return NULL;
> +
> +	if (unlikely(data->broken))
> +		return NULL;
> +
> +	ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
> +	if (!ret)
> +		return NULL;
> +
> +	pfn = virt_to_pfn(ret);
> +
> +	if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
> +		free_pages_exact(ret, n_pages * PAGE_SIZE);
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < n_pages; i++) {
> +		gnttab_grant_foreign_access_ref(grant + i, data->backend_domid,
> +				pfn_to_gfn(pfn + i), 0);
> +	}
> +
> +	*dma_handle = grant_to_dma(grant);
> +
> +	return ret;
> +}
> +
> +static void xen_grant_dma_free(struct device *dev, size_t size, void *vaddr,
> +			       dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	struct xen_grant_dma_data *data;
> +	unsigned int i, n_pages = PFN_UP(size);
> +	grant_ref_t grant;
> +
> +	data = find_xen_grant_dma_data(dev);
> +	if (!data)
> +		return;
> +
> +	if (unlikely(data->broken))
> +		return;
> +
> +	grant = dma_to_grant(dma_handle);
> +
> +	for (i = 0; i < n_pages; i++) {
> +		if (unlikely(!gnttab_end_foreign_access_ref(grant + i))) {
> +			dev_alert(dev, "Grant still in use by backend domain, disabled for further use\n");
> +			data->broken = true;
> +			return;
> +		}
> +	}
> +
> +	gnttab_free_grant_reference_seq(grant, n_pages);
> +
> +	free_pages_exact(vaddr, n_pages * PAGE_SIZE);
> +}
> +
> +static struct page *xen_grant_dma_alloc_pages(struct device *dev, size_t size,
> +					      dma_addr_t *dma_handle,
> +					      enum dma_data_direction dir,
> +					      gfp_t gfp)
> +{
> +	void *vaddr;
> +
> +	vaddr = xen_grant_dma_alloc(dev, size, dma_handle, gfp, 0);
> +	if (!vaddr)
> +		return NULL;
> +
> +	return virt_to_page(vaddr);
> +}
> +
> +static void xen_grant_dma_free_pages(struct device *dev, size_t size,
> +				     struct page *vaddr, dma_addr_t dma_handle,
> +				     enum dma_data_direction dir)
> +{
> +	xen_grant_dma_free(dev, size, page_to_virt(vaddr), dma_handle, 0);
> +}
> +
> +static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
> +					 unsigned long offset, size_t size,
> +					 enum dma_data_direction dir,
> +					 unsigned long attrs)
> +{
> +	struct xen_grant_dma_data *data;
> +	unsigned int i, n_pages = PFN_UP(size);
> +	grant_ref_t grant;
> +	dma_addr_t dma_handle;
> +
> +	if (WARN_ON(dir == DMA_NONE))
> +		return DMA_MAPPING_ERROR;
> +
> +	data = find_xen_grant_dma_data(dev);
> +	if (!data)
> +		return DMA_MAPPING_ERROR;
> +
> +	if (unlikely(data->broken))
> +		return DMA_MAPPING_ERROR;
> +
> +	if (gnttab_alloc_grant_reference_seq(n_pages, &grant))
> +		return DMA_MAPPING_ERROR;
> +
> +	for (i = 0; i < n_pages; i++) {
> +		gnttab_grant_foreign_access_ref(grant + i, data->backend_domid,
> +				xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
> +	}
> +
> +	dma_handle = grant_to_dma(grant) + offset;
> +
> +	return dma_handle;
> +}
> +
> +static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +				     size_t size, enum dma_data_direction dir,
> +				     unsigned long attrs)
> +{
> +	struct xen_grant_dma_data *data;
> +	unsigned int i, n_pages = PFN_UP(size);
> +	grant_ref_t grant;
> +
> +	if (WARN_ON(dir == DMA_NONE))
> +		return;
> +
> +	data = find_xen_grant_dma_data(dev);
> +	if (!data)
> +		return;
> +
> +	if (unlikely(data->broken))
> +		return;
> +
> +	grant = dma_to_grant(dma_handle);
> +
> +	for (i = 0; i < n_pages; i++) {
> +		if (unlikely(!gnttab_end_foreign_access_ref(grant + i))) {
> +			dev_alert(dev, "Grant still in use by backend domain, disabled for further use\n");
> +			data->broken = true;
> +			return;
> +		}
> +	}
> +
> +	gnttab_free_grant_reference_seq(grant, n_pages);
> +}
> +
> +static void xen_grant_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> +				   int nents, enum dma_data_direction dir,
> +				   unsigned long attrs)
> +{
> +	struct scatterlist *s;
> +	unsigned int i;
> +
> +	if (WARN_ON(dir == DMA_NONE))
> +		return;
> +
> +	for_each_sg(sg, s, nents, i)
> +		xen_grant_dma_unmap_page(dev, s->dma_address, sg_dma_len(s), dir,
> +				attrs);
> +}
> +
> +static int xen_grant_dma_map_sg(struct device *dev, struct scatterlist *sg,
> +				int nents, enum dma_data_direction dir,
> +				unsigned long attrs)
> +{
> +	struct scatterlist *s;
> +	unsigned int i;
> +
> +	if (WARN_ON(dir == DMA_NONE))
> +		return -EINVAL;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		s->dma_address = xen_grant_dma_map_page(dev, sg_page(s), s->offset,
> +				s->length, dir, attrs);
> +		if (s->dma_address == DMA_MAPPING_ERROR)
> +			goto out;
> +
> +		sg_dma_len(s) = s->length;
> +	}
> +
> +	return nents;
> +
> +out:
> +	xen_grant_dma_unmap_sg(dev, sg, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_dma_len(sg) = 0;
> +
> +	return -EIO;
> +}
> +
> +static int xen_grant_dma_supported(struct device *dev, u64 mask)
> +{
> +	return mask == DMA_BIT_MASK(64);
> +}
> +
> +static const struct dma_map_ops xen_grant_dma_ops = {
> +	.alloc = xen_grant_dma_alloc,
> +	.free = xen_grant_dma_free,
> +	.alloc_pages = xen_grant_dma_alloc_pages,
> +	.free_pages = xen_grant_dma_free_pages,
> +	.mmap = dma_common_mmap,
> +	.get_sgtable = dma_common_get_sgtable,
> +	.map_page = xen_grant_dma_map_page,
> +	.unmap_page = xen_grant_dma_unmap_page,
> +	.map_sg = xen_grant_dma_map_sg,
> +	.unmap_sg = xen_grant_dma_unmap_sg,
> +	.dma_supported = xen_grant_dma_supported,
> +};
> +
> +void xen_grant_setup_dma_ops(struct device *dev)
> +{
> +	struct xen_grant_dma_data *data;
> +
> +	data = find_xen_grant_dma_data(dev);
> +	if (data) {
> +		dev_err(dev, "Xen grant DMA data is already created\n");
> +		return;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		goto err;
> +
> +	/* XXX The dom0 is hardcoded as the backend domain for now */
> +	data->backend_domid = 0;
> +
> +	if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)dev, data,
> +			GFP_KERNEL))) {
> +		dev_err(dev, "Cannot store Xen grant DMA data\n");
> +		goto err;
> +	}
> +
> +	dev->dma_ops = &xen_grant_dma_ops;
> +
> +	return;
> +
> +err:
> +	dev_err(dev, "Cannot set up Xen grant DMA ops, retain platform DMA ops\n");
> +}
> +
> +MODULE_DESCRIPTION("Xen grant DMA-mapping layer");
> +MODULE_AUTHOR("Juergen Gross <jgross@suse.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index a3584a3..4f9fad5 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -221,4 +221,12 @@ static inline void xen_preemptible_hcall_end(void) { }
>  
>  #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
>  
> +#ifdef CONFIG_XEN_GRANT_DMA_OPS
> +void xen_grant_setup_dma_ops(struct device *dev);
> +#else
> +static inline void xen_grant_setup_dma_ops(struct device *dev)
> +{
> +}
> +#endif /* CONFIG_XEN_GRANT_DMA_OPS */
> +
>  #endif /* INCLUDE_XEN_OPS_H */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
