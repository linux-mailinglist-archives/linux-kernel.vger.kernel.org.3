Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB490539CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349662AbiFAFdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349634AbiFAFdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:33:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4772B9E9DD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 22:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654061622; x=1685597622;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8H5F2NUfv7ermpA8eablQSAS3teC1dmJ9SzBQt0ppCM=;
  b=g/d4ARoLBEsnQGNnfBFyevPcXWnPAGCOv2/z6E33r7eLlZVc80Aheb1G
   bPscPR/L80zg1/j857CpQW8dsLycYLcM1hx2gDQvTmNZfuDveOVJPAhUH
   sCcrlsp7azk6FC2ehdBOD3cO/OE/n8Fqn3Vtu5wyEN9OkG1UQn/7L9rCO
   my+oCmRW1WxpziQqYlOIXDBTS1LaSmLUaHurxSBs789kXWmgOQf2uDb9S
   ed+3hWZ+lFyZTcZ4eOGwWr3+A3MjdVCQh8wu7vXSVy9ZVxikGSXaLjGvr
   LEtVBceJVSEgu+hxhRvWPrDQbeIzPKIGqZtIgeodizSvBoCKEnuObE670
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="263114723"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="263114723"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 22:33:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="706905410"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123]) ([10.255.28.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 22:33:38 -0700
Message-ID: <c9289db7-2d5b-4d1e-ca8b-261b12b264f3@linux.intel.com>
Date:   Wed, 1 Jun 2022 13:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thank you for the comments.

On 2022/5/31 21:52, Robin Murphy wrote:
> On 2022-05-31 04:02, Baolu Lu wrote:
>> On 2022/5/30 20:14, Jason Gunthorpe wrote:
>>> On Sun, May 29, 2022 at 01:14:46PM +0800, Baolu Lu wrote:

[--snip--]

>> diff --git a/drivers/iommu/intel/debugfs.c 
>> b/drivers/iommu/intel/debugfs.c
>> index d927ef10641b..e6f4835b8d9f 100644
>> --- a/drivers/iommu/intel/debugfs.c
>> +++ b/drivers/iommu/intel/debugfs.c
>> @@ -333,25 +333,28 @@ static void pgtable_walk_level(struct seq_file 
>> *m, struct dma_pte *pde,
>>               continue;
>>
>>           path[level] = pde->val;
>> -        if (dma_pte_superpage(pde) || level == 1)
>> +        if (dma_pte_superpage(pde) || level == 1) {
>>               dump_page_info(m, start, path);
>> -        else
>> -            pgtable_walk_level(m, phys_to_virt(dma_pte_addr(pde)),
>> +        } else {
>> +            unsigned long phys_addr;
>> +
>> +            phys_addr = (unsigned long)dma_pte_addr(pde);
>> +            if (!pfn_valid(__phys_to_pfn(phys_addr)))
> 
> Given that pte_present(pde) passed just above, it was almost certainly a 
> valid entry, so it seems unlikely that the physical address it pointed 
> to could have disappeared in the meantime. If you're worried about the 
> potential case where we've been preempted during this walk for long 
> enough that the page has already been freed by an unmap, reallocated, 

Yes. This is exactly what I am worried about and what this patch wants
to solve.

> and filled with someone else's data that happens to look like valid 
> PTEs, this still isn't enough, since that data could just as well happen 
> to look like valid physical addresses too.
> I imagine that if you want to safely walk pagetables concurrently with 
> them potentially being freed, you'd probably need to get RCU involved.

I don't want to make the map/unmap interface more complex or inefficient
because of a debugfs feature. I hope that the debugfs and map/unmap
interfaces are orthogonal, just like the IOMMU hardware traversing the
page tables, as long as the accessed physical address is valid and
accessible. Otherwise, stop the traversal immediately. If we can't
achieve this, I'd rather stop supporting this debugfs node.

> 
>> +                break;
>> +            pgtable_walk_level(m, phys_to_virt(phys_addr),
> 
> Also, obligatory reminder that pfn_valid() only means that pfn_to_page() 
> gets you a valid struct page. Whether that page is direct-mapped kernel 
> memory or not is a different matter.

Perhaps I can check this from the page flags?

> 
>>                          level - 1, start, path);
>> +        }
>>           path[level] = 0;
>>       }
>>   }
>>
>> -static int show_device_domain_translation(struct device *dev, void 
>> *data)
>> +static int __show_device_domain_translation(struct device *dev, void 
>> *data)
>>   {
>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>       struct dmar_domain *domain = info->domain;
>>       struct seq_file *m = data;
>>       u64 path[6] = { 0 };
>>
>> -    if (!domain)
>> -        return 0;
>> -
>>       seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
>>              (u64)virt_to_phys(domain->pgd));
>>       seq_puts(m, 
>> "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
>> @@ -359,20 +362,27 @@ static int show_device_domain_translation(struct 
>> device *dev, void *data)
>>       pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
>>       seq_putc(m, '\n');
>>
>> -    return 0;
>> +    return 1;
>>   }
>>
>> -static int domain_translation_struct_show(struct seq_file *m, void 
>> *unused)
>> +static int show_device_domain_translation(struct device *dev, void 
>> *data)
>>   {
>> -    unsigned long flags;
>> -    int ret;
>> +    struct iommu_group *group;
>>
>> -    spin_lock_irqsave(&device_domain_lock, flags);
>> -    ret = bus_for_each_dev(&pci_bus_type, NULL, m,
>> -                   show_device_domain_translation);
>> -    spin_unlock_irqrestore(&device_domain_lock, flags);
>> +    group = iommu_group_get(dev);
>> +    if (group) {
>> +        iommu_group_for_each_dev(group, data,
>> +                     __show_device_domain_translation);
> 
> Why group_for_each_dev?

This will hold the group mutex when the callback is invoked. With the
group mutex hold, the domain could not get changed.

> If there *are* multiple devices in the group 
> then by definition they should be attached to the same domain, so 
> dumping that domain's mappings more than once seems pointless. 
> Especially given that the outer bus_for_each_dev iteration will already 
> visit each individual device anyway, so this would only make the 
> redundancy even worse than it already is.

__show_device_domain_translation() only dumps mappings once as it always
returns 1.

Best regards,
baolu
