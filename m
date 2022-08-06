Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2A58B407
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiHFGN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiHFGN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:13:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3556205D2;
        Fri,  5 Aug 2022 23:13:23 -0700 (PDT)
Received: from [10.20.42.22] (unknown [10.20.42.22])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxgM94Bu5i2XkIAA--.29591S3;
        Sat, 06 Aug 2022 14:13:12 +0800 (CST)
Subject: Re: [PATCH V2 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     Robin Murphy <robin.murphy@arm.com>, lpieralisi@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1659684674-40612-1-git-send-email-lvjianmin@loongson.cn>
 <1659684674-40612-2-git-send-email-lvjianmin@loongson.cn>
 <c43edf84-c93d-e695-e3db-4592cdc8a3d1@arm.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <ce8221a2-921b-f5fb-9b48-8fcf40199721@loongson.cn>
Date:   Sat, 6 Aug 2022 14:13:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c43edf84-c93d-e695-e3db-4592cdc8a3d1@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxgM94Bu5i2XkIAA--.29591S3
X-Coremail-Antispam: 1UD129KBjvAXoW3CF4fAFyUCw1rWF43Aw4UXFb_yoW8GFy7Zo
        W7Kw13Xr4rJw1jgr4UGr1UJry3Xr1DXrnrtryrGrWayF48JFyUJ348Jry5t3yUJF1rGr18
        Gry7JryYqFW7Jr18n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYh7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
        0xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rc
        xSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14
        v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/5 下午8:46, Robin Murphy wrote:
> On 2022-08-05 08:31, Jianmin Lv wrote:
>> For DT, of_dma_get_range returns bus_dma_region typed dma regions,
>> which makes multiple dma windows with different offset available
>> for translation between dma address and cpu address.
>>
>> But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
>> causing no path for setting dev->dma_range_map conveniently. So the
>> patch changes acpi_dma_get_range and returns bus_dma_region typed
>> dma regions according to of_dma_get_range.
>>
>> After changing acpi_dma_get_range, acpi_arch_dma_setup is changed for
>> ARM64, where original dma_addr and size are removed, and pass 0 and
>> U64_MAX for dma_base and size of arch_setup_dma_ops.
> 
> Hmm, I realise the reasoning behind this exists largely in my head, so 
> for the benefit of everyone else we should perhaps clarify that these 
> arguments are now redundant, so this is a simplification consistent with 
> what other ACPI architectures also pass to iommu_setup_dma_ops().
> 

Ok, I'll add reason of changing it into commit log for everyone else.


>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/acpi/arm64/dma.c | 44 
>> +++++++++++++++++++++++++++++++++-----------
>>   drivers/acpi/scan.c      | 48 
>> ++++++++++++++++++++++++------------------------
>>   include/acpi/acpi_bus.h  |  3 +--
>>   include/linux/acpi.h     |  7 +++----
>>   4 files changed, 61 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
>> index f16739a..64a41b2 100644
>> --- a/drivers/acpi/arm64/dma.c
>> +++ b/drivers/acpi/arm64/dma.c
>> @@ -4,11 +4,12 @@
>>   #include <linux/device.h>
>>   #include <linux/dma-direct.h>
>> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 
>> *dma_size)
>> +void acpi_arch_dma_setup(struct device *dev)
>>   {
>>       int ret;
>>       u64 end, mask;
>> -    u64 dmaaddr = 0, size = 0, offset = 0;
>> +    u64 size = 0;
>> +    const struct bus_dma_region *map = NULL;
>>       /*
>>        * If @dev is expected to be DMA-capable then the bus code that 
>> created
>> @@ -26,7 +27,33 @@ void acpi_arch_dma_setup(struct device *dev, u64 
>> *dma_addr, u64 *dma_size)
>>       else
>>           size = 1ULL << 32;
>> -    ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
>> +    ret = acpi_dma_get_range(dev, &map);
>> +    if (!ret) {
>> +        const struct bus_dma_region *r = map;
>> +        u64 dma_start, dma_end = 0;
>> +
>> +        /* determine the overall bounds of all dma regions */
>> +        for (dma_start = U64_MAX; r->size; r++) {
>> +
>> +            /* Take lower and upper limits */
>> +            if (r->dma_start < dma_start)
>> +                dma_start = r->dma_start;
> 
> dma_start now only serves as an overcomplicated way to tell if the list 
> was empty, so we don't need it...

Ok,thanks.

> 
>> +            if (r->dma_start + r->size - 1 > dma_end)
>> +                dma_end = r->dma_start + r->size - 1;
>> +        }
>> +
>> +        if (dma_start >= dma_end) {
>> +            dev_dbg(dev, "Invalid DMA regions configuration\n");
>> +            return;
> 
> ...but we also don't need this check anway - either there was at least 
> one valid resource, so dma_end is now set to something sensible, or 
> there were none, in which case the implementation of 
> acpi_dma_get_range() here returns success while leaving map == NULL, so 
> we've already crashed dereferencing r->size.
> 

Ok, thanks.


>> +        }
>> +
>> +        mask = DMA_BIT_MASK(ilog2(dma_end) + 1);
>> +        dev->bus_dma_limit = dma_end;
>> +        dev->dma_range_map = map;
>> +        dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
>> +        *dev->dma_mask = min(*dev->dma_mask, mask);
> 
> Don't duplicate all this, just set "size = dma_end + 1" so the existing 
> code below picks it up.
> 

TBH, I'm not familiar with ARM64's DMA stuff, but from the code here, I 
think there are two ways to get dma ranges: acpi_dma_get_range or 
iort_dma_get_ranges.

Before the patch, after obtaining the dmaaddr, offset and size in any 
way of the both, the bus_dma_limit, mask and dma_range_map will be 
initialized, and dma_range_map is created a *new* one for *both* ways.

But after changing acpi_dma_get_range, when we are ok to obtain 
dma_range_map by acpi_dma_get_range, we'll use it instead of creating a
new one like before. For iort_dma_get_ranges, we have to still create a 
new dma_range_map. So, I have to handle separately each way here.

It seems that it's enough to handle dma_range_map separately, and others 
can be still initialized in one place.

>> +    }
>> +
>>       if (ret == -ENODEV)
>>           ret = iort_dma_get_ranges(dev, &size);
>>       if (!ret) {
>> @@ -34,17 +61,12 @@ void acpi_arch_dma_setup(struct device *dev, u64 
>> *dma_addr, u64 *dma_size)
>>            * Limit coherent and dma mask based on size retrieved from
>>            * firmware.
>>            */
>> -        end = dmaaddr + size - 1;
>> +        end = size - 1;
>>           mask = DMA_BIT_MASK(ilog2(end) + 1);
>>           dev->bus_dma_limit = end;
>>           dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
>>           *dev->dma_mask = min(*dev->dma_mask, mask);
>> -    }
>> -    *dma_addr = dmaaddr;
>> -    *dma_size = size;
>> -
>> -    ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
>> -
>> -    dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" 
>> : "");
>> +        ret = dma_direct_set_offset(dev, 0, 0, size);
> 
> Don't call this - we're setting dev->dma_range_map now, so it will only 
> scream and fail (or do nothing if there's no offset).
> 

Same as above.

>> +    }
>>   }
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 762b61f..736517e 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/platform_data/x86/apple.h>
>>   #include <linux/pgtable.h>
>>   #include <linux/crc32.h>
>> +#include <linux/dma-direct.h>
>>   #include "internal.h"
>> @@ -1492,15 +1493,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct 
>> acpi_device *adev)
>>    *
>>    * Return 0 on success, < 0 on failure.
>>    */
> 
> Don't forget to update the kerneldoc as well.
> 

Ok, thanks.


>> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>> -               u64 *size)
>> +int acpi_dma_get_range(struct device *dev, const struct 
>> bus_dma_region **map)
>>   {
>>       struct acpi_device *adev;
>>       LIST_HEAD(list);
>>       struct resource_entry *rentry;
>>       int ret;
>>       struct device *dma_dev = dev;
>> -    u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
>> +    int num_ranges = 0;
>> +    struct bus_dma_region *r;
>>       /*
>>        * Walk the device tree chasing an ACPI companion with a _DMA
>> @@ -1525,31 +1526,31 @@ int acpi_dma_get_range(struct device *dev, u64 
>> *dma_addr, u64 *offset,
>>       ret = acpi_dev_get_dma_resources(adev, &list);
>>       if (ret > 0) {
>> +        list_for_each_entry(rentry, &list, node)
>> +            num_ranges++;
> 
> We already have the number of resources in ret.
> 

Ok, thanks.


> Looking at this, I also now wonder if we're doing the right thing if the 
> object is present but contains no resources. The spec isn't clear 
> whether that's even really valid, but if it is, is it meaningful? It 
> seems we'd currently consider an empty object equivalent to no object, 
> but if anything it should perhaps be interpreted as the opposite, i.e. 
> that no DMA is possible because the bus does not decode any ranges. Is 
> anyone more familiar with the intent of the spec here?
> 
> Thanks,
> Robin.
> 

According to _DMA of ACPI spec, _DMA is optional, if without it(no _DMA 
object configured in DSDT), kernel assumes that any address range placed 
on bus by a child device is valid and can be decoded. So I think it is 
still legal if _DMA is present and no resources contained in it. I mean 
an empty _DMA object equals no _DMA object. But obviously it's not 
meaningful for an empty _DMA object, anybody should not pass an empty 
_DMA object.

>> +
>> +        r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
>> +        if (!r) {
>> +            ret = -ENOMEM;
>> +            goto out;
>> +        }
>> +
>> +        *map = r;
>> +
>>           list_for_each_entry(rentry, &list, node) {
>> -            if (dma_offset && rentry->offset != dma_offset) {
>> +            if (rentry->res->start >= rentry->res->end) {
>>                   ret = -EINVAL;
>> -                dev_warn(dma_dev, "Can't handle multiple windows with 
>> different offsets\n");
>> +                dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>>                   goto out;
>>               }
>> -            dma_offset = rentry->offset;
>> -
>> -            /* Take lower and upper limits */
>> -            if (rentry->res->start < dma_start)
>> -                dma_start = rentry->res->start;
>> -            if (rentry->res->end > dma_end)
>> -                dma_end = rentry->res->end;
>> -        }
>> -        if (dma_start >= dma_end) {
>> -            ret = -EINVAL;
>> -            dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>> -            goto out;
>> +            r->cpu_start = rentry->res->start;
>> +            r->dma_start = rentry->res->start - rentry->offset;
>> +            r->size = rentry->res->end - rentry->res->start + 1;
>> +            r->offset = rentry->offset;
>> +            r++;
>>           }
>> -        *dma_addr = dma_start - dma_offset;
>> -        len = dma_end - dma_start;
>> -        *size = max(len, len + 1);
>> -        *offset = dma_offset;
>>       }
>>    out:
>>       acpi_dev_free_resource_list(&list);
>> @@ -1639,20 +1640,19 @@ int acpi_dma_configure_id(struct device *dev, 
>> enum dev_dma_attr attr,
>>                 const u32 *input_id)
>>   {
>>       const struct iommu_ops *iommu;
>> -    u64 dma_addr = 0, size = 0;
>>       if (attr == DEV_DMA_NOT_SUPPORTED) {
>>           set_dma_ops(dev, &dma_dummy_ops);
>>           return 0;
>>       }
>> -    acpi_arch_dma_setup(dev, &dma_addr, &size);
>> +    acpi_arch_dma_setup(dev);
>>       iommu = acpi_iommu_configure_id(dev, input_id);
>>       if (PTR_ERR(iommu) == -EPROBE_DEFER)
>>           return -EPROBE_DEFER;
>> -    arch_setup_dma_ops(dev, dma_addr, size,
>> +    arch_setup_dma_ops(dev, 0, U64_MAX,
>>                   iommu, attr == DEV_DMA_COHERENT);
>>       return 0;
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 0dc1ea0b..e106073 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -611,8 +611,7 @@ struct acpi_pci_root {
>>   int acpi_iommu_fwspec_init(struct device *dev, u32 id,
>>                  struct fwnode_handle *fwnode,
>>                  const struct iommu_ops *ops);
>> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>> -               u64 *size);
>> +int acpi_dma_get_range(struct device *dev, const struct 
>> bus_dma_region **map);
>>   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>>                  const u32 *input_id);
>>   static inline int acpi_dma_configure(struct device *dev,
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 44975c1..34e0545 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -280,12 +280,12 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
>>   #ifdef CONFIG_ARM64
>>   void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
>> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 
>> *dma_size);
>> +void acpi_arch_dma_setup(struct device *dev);
>>   #else
>>   static inline void
>>   acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>>   static inline void
>> -acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) 
>> { }
>> +acpi_arch_dma_setup(struct device *dev) { }
>>   #endif
>>   int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
>> @@ -974,8 +974,7 @@ static inline enum dev_dma_attr 
>> acpi_get_dma_attr(struct acpi_device *adev)
>>       return DEV_DMA_NOT_SUPPORTED;
>>   }
>> -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
>> -                     u64 *offset, u64 *size)
>> +static inline int acpi_dma_get_range(struct device *dev, const struct 
>> bus_dma_region **map)
>>   {
>>       return -ENODEV;
>>   }

