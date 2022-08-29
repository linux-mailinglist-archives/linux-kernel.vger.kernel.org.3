Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ADF5A4D01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiH2NHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiH2NGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:06:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E545F8982D;
        Mon, 29 Aug 2022 06:00:55 -0700 (PDT)
Received: from [10.20.42.22] (unknown [10.20.42.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJuuAxjw+ELAA--.52436S3;
        Mon, 29 Aug 2022 21:00:31 +0800 (CST)
Subject: Re: [PATCH V2 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1659684674-40612-1-git-send-email-lvjianmin@loongson.cn>
 <1659684674-40612-2-git-send-email-lvjianmin@loongson.cn>
 <c43edf84-c93d-e695-e3db-4592cdc8a3d1@arm.com> <YvYG0i0XJSlwP1Wb@lpieralisi>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <09873368-dacb-f2a2-ca93-9e164711a876@loongson.cn>
Date:   Mon, 29 Aug 2022 21:00:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YvYG0i0XJSlwP1Wb@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxBOJuuAxjw+ELAA--.52436S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW8tFyfur15WFWrAF4xWFg_yoWxAFW7pa
        48Ka98GrWjqrsrWrs5ZwsY93W3Z3sY9r4xZrWrG3s3C34qgr17JFy7Cryj9a4rAFWqkr4x
        Za1qkFWrZF1qyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
        W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/12 下午3:52, Lorenzo Pieralisi wrote:
> On Fri, Aug 05, 2022 at 01:46:07PM +0100, Robin Murphy wrote:
> 
> [...]
> 
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
>>
>> We already have the number of resources in ret.
>>
>> Looking at this, I also now wonder if we're doing the right thing if the
>> object is present but contains no resources. The spec isn't clear whether
>> that's even really valid, but if it is, is it meaningful? It seems we'd
>> currently consider an empty object equivalent to no object, but if anything
>> it should perhaps be interpreted as the opposite, i.e. that no DMA is
>> possible because the bus does not decode any ranges. Is anyone more familiar
>> with the intent of the spec here?
> 
> I think we are currently considering no object differently from an
> empty object, since for no object we would return -ENODEV in
> acpi_dma_get_range(), we would not even get to parsing the resources
> (and return 0) and we would fall back to checking IORT to gather the
> DMA address space size.
> 
> I think you are right, we should change the behaviour if an object
> is present but it has no resources though, by reading the specs an
> empty _DMA object implies no DMA is possible and that's not what
> we are doing at the moment (hopefully there is no firmware out
> there with such a set-up but there is only one way to discover it).
> 
> This behavioural change should be a separate patch obviously for
> bisectability (and a possible revert).
> 
> Lorenzo
> 
Hi, Robin and Lorenzo

For the issue of empty _DMA, I consulted ASWG(ACPI Spec Work Group), and 
received an reply from some people that an _DMA object is allowed to 
contain *no* resources, and indicates disabled DMA(some arm systems are 
being used empty _DMA as an indicator to the OS that DMA is disabled for 
specified device). ASWG has isssued an request to clarify it in spec 
after approved.


I think we can submit a seperate patch for that after it is confirmed.

Thanks.

>> Thanks,
>> Robin.
>>
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
>>> @@ -1639,20 +1640,19 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>>>    			  const u32 *input_id)
>>>    {
>>>    	const struct iommu_ops *iommu;
>>> -	u64 dma_addr = 0, size = 0;
>>>    	if (attr == DEV_DMA_NOT_SUPPORTED) {
>>>    		set_dma_ops(dev, &dma_dummy_ops);
>>>    		return 0;
>>>    	}
>>> -	acpi_arch_dma_setup(dev, &dma_addr, &size);
>>> +	acpi_arch_dma_setup(dev);
>>>    	iommu = acpi_iommu_configure_id(dev, input_id);
>>>    	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>>>    		return -EPROBE_DEFER;
>>> -	arch_setup_dma_ops(dev, dma_addr, size,
>>> +	arch_setup_dma_ops(dev, 0, U64_MAX,
>>>    				iommu, attr == DEV_DMA_COHERENT);
>>>    	return 0;
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
>>> index 44975c1..34e0545 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -280,12 +280,12 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
>>>    #ifdef CONFIG_ARM64
>>>    void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
>>> -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
>>> +void acpi_arch_dma_setup(struct device *dev);
>>>    #else
>>>    static inline void
>>>    acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>>>    static inline void
>>> -acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
>>> +acpi_arch_dma_setup(struct device *dev) { }
>>>    #endif
>>>    int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
>>> @@ -974,8 +974,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>>>    	return DEV_DMA_NOT_SUPPORTED;
>>>    }
>>> -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
>>> -				     u64 *offset, u64 *size)
>>> +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>>>    {
>>>    	return -ENODEV;
>>>    }

