Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7658AB01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiHEMqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiHEMqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:46:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D1D813D28;
        Fri,  5 Aug 2022 05:46:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A77E311FB;
        Fri,  5 Aug 2022 05:46:15 -0700 (PDT)
Received: from [10.57.74.3] (unknown [10.57.74.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768BB3F67D;
        Fri,  5 Aug 2022 05:46:13 -0700 (PDT)
Message-ID: <c43edf84-c93d-e695-e3db-4592cdc8a3d1@arm.com>
Date:   Fri, 5 Aug 2022 13:46:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
Content-Language: en-GB
To:     Jianmin Lv <lvjianmin@loongson.cn>, lpieralisi@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1659684674-40612-1-git-send-email-lvjianmin@loongson.cn>
 <1659684674-40612-2-git-send-email-lvjianmin@loongson.cn>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1659684674-40612-2-git-send-email-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-05 08:31, Jianmin Lv wrote:
> For DT, of_dma_get_range returns bus_dma_region typed dma regions,
> which makes multiple dma windows with different offset available
> for translation between dma address and cpu address.
> 
> But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
> causing no path for setting dev->dma_range_map conveniently. So the
> patch changes acpi_dma_get_range and returns bus_dma_region typed
> dma regions according to of_dma_get_range.
> 
> After changing acpi_dma_get_range, acpi_arch_dma_setup is changed for
> ARM64, where original dma_addr and size are removed, and pass 0 and
> U64_MAX for dma_base and size of arch_setup_dma_ops.

Hmm, I realise the reasoning behind this exists largely in my head, so 
for the benefit of everyone else we should perhaps clarify that these 
arguments are now redundant, so this is a simplification consistent with 
what other ACPI architectures also pass to iommu_setup_dma_ops().

> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>   drivers/acpi/arm64/dma.c | 44 +++++++++++++++++++++++++++++++++-----------
>   drivers/acpi/scan.c      | 48 ++++++++++++++++++++++++------------------------
>   include/acpi/acpi_bus.h  |  3 +--
>   include/linux/acpi.h     |  7 +++----
>   4 files changed, 61 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> index f16739a..64a41b2 100644
> --- a/drivers/acpi/arm64/dma.c
> +++ b/drivers/acpi/arm64/dma.c
> @@ -4,11 +4,12 @@
>   #include <linux/device.h>
>   #include <linux/dma-direct.h>
>   
> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +void acpi_arch_dma_setup(struct device *dev)
>   {
>   	int ret;
>   	u64 end, mask;
> -	u64 dmaaddr = 0, size = 0, offset = 0;
> +	u64 size = 0;
> +	const struct bus_dma_region *map = NULL;
>   
>   	/*
>   	 * If @dev is expected to be DMA-capable then the bus code that created
> @@ -26,7 +27,33 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   	else
>   		size = 1ULL << 32;
>   
> -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> +	ret = acpi_dma_get_range(dev, &map);
> +	if (!ret) {
> +		const struct bus_dma_region *r = map;
> +		u64 dma_start, dma_end = 0;
> +
> +		/* determine the overall bounds of all dma regions */
> +		for (dma_start = U64_MAX; r->size; r++) {
> +
> +			/* Take lower and upper limits */
> +			if (r->dma_start < dma_start)
> +				dma_start = r->dma_start;

dma_start now only serves as an overcomplicated way to tell if the list 
was empty, so we don't need it...

> +			if (r->dma_start + r->size - 1 > dma_end)
> +				dma_end = r->dma_start + r->size - 1;
> +		}
> +
> +		if (dma_start >= dma_end) {
> +			dev_dbg(dev, "Invalid DMA regions configuration\n");
> +			return;

...but we also don't need this check anway - either there was at least 
one valid resource, so dma_end is now set to something sensible, or 
there were none, in which case the implementation of 
acpi_dma_get_range() here returns success while leaving map == NULL, so 
we've already crashed dereferencing r->size.

> +		}
> +
> +		mask = DMA_BIT_MASK(ilog2(dma_end) + 1);
> +		dev->bus_dma_limit = dma_end;
> +		dev->dma_range_map = map;
> +		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> +		*dev->dma_mask = min(*dev->dma_mask, mask);

Don't duplicate all this, just set "size = dma_end + 1" so the existing 
code below picks it up.

> +	}
> +
>   	if (ret == -ENODEV)
>   		ret = iort_dma_get_ranges(dev, &size);
>   	if (!ret) {
> @@ -34,17 +61,12 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   		 * Limit coherent and dma mask based on size retrieved from
>   		 * firmware.
>   		 */
> -		end = dmaaddr + size - 1;
> +		end = size - 1;
>   		mask = DMA_BIT_MASK(ilog2(end) + 1);
>   		dev->bus_dma_limit = end;
>   		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
>   		*dev->dma_mask = min(*dev->dma_mask, mask);
> -	}
>   
> -	*dma_addr = dmaaddr;
> -	*dma_size = size;
> -
> -	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> -
> -	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
> +		ret = dma_direct_set_offset(dev, 0, 0, size);

Don't call this - we're setting dev->dma_range_map now, so it will only 
scream and fail (or do nothing if there's no offset).

> +	}
>   }
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 762b61f..736517e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -20,6 +20,7 @@
>   #include <linux/platform_data/x86/apple.h>
>   #include <linux/pgtable.h>
>   #include <linux/crc32.h>
> +#include <linux/dma-direct.h>
>   
>   #include "internal.h"
>   
> @@ -1492,15 +1493,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>    *
>    * Return 0 on success, < 0 on failure.
>    */

Don't forget to update the kerneldoc as well.

> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> -		       u64 *size)
> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   {
>   	struct acpi_device *adev;
>   	LIST_HEAD(list);
>   	struct resource_entry *rentry;
>   	int ret;
>   	struct device *dma_dev = dev;
> -	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> +	int num_ranges = 0;
> +	struct bus_dma_region *r;
>   
>   	/*
>   	 * Walk the device tree chasing an ACPI companion with a _DMA
> @@ -1525,31 +1526,31 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>   
>   	ret = acpi_dev_get_dma_resources(adev, &list);
>   	if (ret > 0) {
> +		list_for_each_entry(rentry, &list, node)
> +			num_ranges++;

We already have the number of resources in ret.

Looking at this, I also now wonder if we're doing the right thing if the 
object is present but contains no resources. The spec isn't clear 
whether that's even really valid, but if it is, is it meaningful? It 
seems we'd currently consider an empty object equivalent to no object, 
but if anything it should perhaps be interpreted as the opposite, i.e. 
that no DMA is possible because the bus does not decode any ranges. Is 
anyone more familiar with the intent of the spec here?

Thanks,
Robin.

> +
> +		r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
> +		if (!r) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		*map = r;
> +
>   		list_for_each_entry(rentry, &list, node) {
> -			if (dma_offset && rentry->offset != dma_offset) {
> +			if (rentry->res->start >= rentry->res->end) {
>   				ret = -EINVAL;
> -				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
> +				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>   				goto out;
>   			}
> -			dma_offset = rentry->offset;
> -
> -			/* Take lower and upper limits */
> -			if (rentry->res->start < dma_start)
> -				dma_start = rentry->res->start;
> -			if (rentry->res->end > dma_end)
> -				dma_end = rentry->res->end;
> -		}
>   
> -		if (dma_start >= dma_end) {
> -			ret = -EINVAL;
> -			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
> -			goto out;
> +			r->cpu_start = rentry->res->start;
> +			r->dma_start = rentry->res->start - rentry->offset;
> +			r->size = rentry->res->end - rentry->res->start + 1;
> +			r->offset = rentry->offset;
> +			r++;
>   		}
>   
> -		*dma_addr = dma_start - dma_offset;
> -		len = dma_end - dma_start;
> -		*size = max(len, len + 1);
> -		*offset = dma_offset;
>   	}
>    out:
>   	acpi_dev_free_resource_list(&list);
> @@ -1639,20 +1640,19 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   			  const u32 *input_id)
>   {
>   	const struct iommu_ops *iommu;
> -	u64 dma_addr = 0, size = 0;
>   
>   	if (attr == DEV_DMA_NOT_SUPPORTED) {
>   		set_dma_ops(dev, &dma_dummy_ops);
>   		return 0;
>   	}
>   
> -	acpi_arch_dma_setup(dev, &dma_addr, &size);
> +	acpi_arch_dma_setup(dev);
>   
>   	iommu = acpi_iommu_configure_id(dev, input_id);
>   	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>   		return -EPROBE_DEFER;
>   
> -	arch_setup_dma_ops(dev, dma_addr, size,
> +	arch_setup_dma_ops(dev, 0, U64_MAX,
>   				iommu, attr == DEV_DMA_COHERENT);
>   
>   	return 0;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 0dc1ea0b..e106073 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -611,8 +611,7 @@ struct acpi_pci_root {
>   int acpi_iommu_fwspec_init(struct device *dev, u32 id,
>   			   struct fwnode_handle *fwnode,
>   			   const struct iommu_ops *ops);
> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> -		       u64 *size);
> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
>   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   			   const u32 *input_id);
>   static inline int acpi_dma_configure(struct device *dev,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 44975c1..34e0545 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -280,12 +280,12 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
>   
>   #ifdef CONFIG_ARM64
>   void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
> +void acpi_arch_dma_setup(struct device *dev);
>   #else
>   static inline void
>   acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>   static inline void
> -acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
> +acpi_arch_dma_setup(struct device *dev) { }
>   #endif
>   
>   int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> @@ -974,8 +974,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>   	return DEV_DMA_NOT_SUPPORTED;
>   }
>   
> -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
> -				     u64 *offset, u64 *size)
> +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   {
>   	return -ENODEV;
>   }
