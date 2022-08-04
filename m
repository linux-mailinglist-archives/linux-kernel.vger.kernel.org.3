Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C258058A07C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiHDS0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHDS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:26:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 957336BD73;
        Thu,  4 Aug 2022 11:26:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0A6A113E;
        Thu,  4 Aug 2022 11:26:33 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 046BA3F73B;
        Thu,  4 Aug 2022 11:26:31 -0700 (PDT)
Message-ID: <a26d8edc-a3a6-8f95-0e7a-c9f60ee04462@arm.com>
Date:   Thu, 4 Aug 2022 19:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ACPI / scan: Support multiple dma windows with different
 offsets
Content-Language: en-GB
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1659255431-22796-1-git-send-email-lvjianmin@loongson.cn>
 <e12706ef-70de-08b6-ada0-818d03b8c2f5@loongson.cn>
 <YuvJLxa5zsMj1pGf@lpieralisi>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YuvJLxa5zsMj1pGf@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 2:27 pm, Lorenzo Pieralisi wrote:
> [+Robin]
> 
> On Thu, Aug 04, 2022 at 05:59:23PM +0800, Jianmin Lv wrote:
>> Hi, all
>>
>> Can anybody help to review the patch, or I missed somebody else?
> 
> I will review the patch - added Robin since it affects the DMA
> ranges handling.

Thanks Lorenzo!

> 
> Lorenzo
> 
>> Thanks!
>>
>> On 2022/7/31 下午4:17, Jianmin Lv wrote:
>>> For DT, of_dma_get_range returns bus_dma_region typed dma regions,
>>> which makes multiple dma windows with different offset available
>>> for translation between dma address and cpu address.
>>>
>>> But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
>>> causing no path for setting dev->dma_range_map conveniently. So the
>>> patch changes acpi_dma_get_range and returns bus_dma_region typed
>>> dma regions according to of_dma_get_range.
>>>
>>> After changing acpi_dma_get_range, original part of internal code
>>> only available for ARM is moved to acpi_arch_dma_setup for remaining
>>> unchanged.

This seems a bit silly. If we've finally done the work to parse a proper 
dma_range_map, we can use it; no need to artificially maintain the old 
dma_pfn_offset limitation. TBH I wouldn't even preserve the dmaaddr and 
size calculations as they are either, just set dev->bus_dma_limit based 
on the highest entry in the map, and pass 0 and U64_MAX to 
arch_setup_dma_ops() since those are basically meaningless now (I plan 
to remove them entirely once I unpick the IOMMU setup).

Thanks,
Robin.

>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>
>>> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
>>> index f16739a..840f918 100644
>>> --- a/drivers/acpi/arm64/dma.c
>>> +++ b/drivers/acpi/arm64/dma.c
>>> @@ -9,6 +9,7 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>>    	int ret;
>>>    	u64 end, mask;
>>>    	u64 dmaaddr = 0, size = 0, offset = 0;
>>> +	const struct bus_dma_region *map = NULL;
>>>    	/*
>>>    	 * If @dev is expected to be DMA-capable then the bus code that created
>>> @@ -26,10 +27,37 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>>    	else
>>>    		size = 1ULL << 32;
>>> -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
>>> +	ret = acpi_dma_get_range(dev, &map);
>>>    	if (ret == -ENODEV)
>>>    		ret = iort_dma_get_ranges(dev, &size);
>>>    	if (!ret) {
>>> +		const struct bus_dma_region *r = map;
>>> +		u64 len, dma_start, dma_end = 0;
>>> +
>>> +		/* determine the overall bounds of all dma regions */
>>> +		for (dma_start = U64_MAX; r->size; r++) {
>>> +			if (offset && r->offset != offset) {
>>> +				dev_warn(dev, "Can't handle multiple windows with different offsets\n");
>>> +				return;
>>> +			}
>>> +			offset = r->offset;
>>> +
>>> +			/* Take lower and upper limits */
>>> +			if (r->dma_start < dma_start)
>>> +				dma_start = r->dma_start;
>>> +			if (r->dma_start + r->size - 1 > dma_end)
>>> +				dma_end = r->dma_start + r->size - 1;
>>> +		}
>>> +
>>> +		if (dma_start >= dma_end) {
>>> +			dev_dbg(dev, "Invalid DMA regions configuration\n");
>>> +			return;
>>> +		}
>>> +
>>> +		dmaaddr = dma_start;
>>> +		len = dma_end - dma_start;
>>> +		size = max(len, len + 1);
>>> +
>>>    		/*
>>>    		 * Limit coherent and dma mask based on size retrieved from
>>>    		 * firmware.
>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>> index 762b61f..8961b51 100644
>>> --- a/drivers/acpi/scan.c
>>> +++ b/drivers/acpi/scan.c
>>> @@ -20,6 +20,7 @@
>>>    #include <linux/platform_data/x86/apple.h>
>>>    #include <linux/pgtable.h>
>>>    #include <linux/crc32.h>
>>> +#include <linux/dma-direct.h>
>>>    #include "internal.h"
>>> @@ -1492,15 +1493,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>>>     *
>>>     * Return 0 on success, < 0 on failure.
>>>     */
>>> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>>> -		       u64 *size)
>>> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>>>    {
>>>    	struct acpi_device *adev;
>>>    	LIST_HEAD(list);
>>>    	struct resource_entry *rentry;
>>>    	int ret;
>>>    	struct device *dma_dev = dev;
>>> -	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
>>> +	int num_ranges = 0;
>>> +	struct bus_dma_region *r;
>>>    	/*
>>>    	 * Walk the device tree chasing an ACPI companion with a _DMA
>>> @@ -1525,31 +1526,31 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>>>    	ret = acpi_dev_get_dma_resources(adev, &list);
>>>    	if (ret > 0) {
>>> +		list_for_each_entry(rentry, &list, node)
>>> +			num_ranges++;
>>> +
>>> +		r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
>>> +		if (!r) {
>>> +			ret = -ENOMEM;
>>> +			goto out;
>>> +		}
>>> +
>>> +		*map = r;
>>> +
>>>    		list_for_each_entry(rentry, &list, node) {
>>> -			if (dma_offset && rentry->offset != dma_offset) {
>>> +			if (rentry->res->start >= rentry->res->end) {
>>>    				ret = -EINVAL;
>>> -				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
>>> +				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>>>    				goto out;
>>>    			}
>>> -			dma_offset = rentry->offset;
>>> -
>>> -			/* Take lower and upper limits */
>>> -			if (rentry->res->start < dma_start)
>>> -				dma_start = rentry->res->start;
>>> -			if (rentry->res->end > dma_end)
>>> -				dma_end = rentry->res->end;
>>> -		}
>>> -		if (dma_start >= dma_end) {
>>> -			ret = -EINVAL;
>>> -			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>>> -			goto out;
>>> +			r->cpu_start = rentry->res->start;
>>> +			r->dma_start = rentry->res->start - rentry->offset;
>>> +			r->size = rentry->res->end - rentry->res->start + 1;
>>> +			r->offset = rentry->offset;
>>> +			r++;
>>>    		}
>>> -		*dma_addr = dma_start - dma_offset;
>>> -		len = dma_end - dma_start;
>>> -		*size = max(len, len + 1);
>>> -		*offset = dma_offset;
>>>    	}
>>>     out:
>>>    	acpi_dev_free_resource_list(&list);
>>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>>> index 0dc1ea0b..e106073 100644
>>> --- a/include/acpi/acpi_bus.h
>>> +++ b/include/acpi/acpi_bus.h
>>> @@ -611,8 +611,7 @@ struct acpi_pci_root {
>>>    int acpi_iommu_fwspec_init(struct device *dev, u32 id,
>>>    			   struct fwnode_handle *fwnode,
>>>    			   const struct iommu_ops *ops);
>>> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>>> -		       u64 *size);
>>> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
>>>    int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>>>    			   const u32 *input_id);
>>>    static inline int acpi_dma_configure(struct device *dev,
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index 44975c1..f806092 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -974,8 +974,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>>>    	return DEV_DMA_NOT_SUPPORTED;
>>>    }
>>> -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
>>> -				     u64 *offset, u64 *size)
>>> +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>>>    {
>>>    	return -ENODEV;
>>>    }
>>>
>>
