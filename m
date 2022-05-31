Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BAC5392C3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbiEaNzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbiEaNyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:54:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7822E99682
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:52:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFD4D23A;
        Tue, 31 May 2022 06:52:35 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256633F73D;
        Tue, 31 May 2022 06:52:34 -0700 (PDT)
Message-ID: <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
Date:   Tue, 31 May 2022 14:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 04:02, Baolu Lu wrote:
> On 2022/5/30 20:14, Jason Gunthorpe wrote:
>> On Sun, May 29, 2022 at 01:14:46PM +0800, Baolu Lu wrote:
>>
>>>  From 1e87b5df40c6ce9414cdd03988c3b52bfb17af5f Mon Sep 17 00:00:00 2001
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>> Date: Sun, 29 May 2022 10:18:56 +0800
>>> Subject: [PATCH 1/1] iommu/vt-d: debugfs: Remove device_domain_lock 
>>> usage
>>>
>>> The domain_translation_struct debugfs node is used to dump static
>>> mappings of PCI devices. It potentially races with setting new
>>> domains to devices and the iommu_map/unmap() interfaces. The existing
>>> code tries to use the global spinlock device_domain_lock to avoid the
>>> races, but this is problematical as this lock is only used to protect
>>> the device tracking lists of the domains.
>>>
>>> Instead of using an immature lock to cover up the problem, it's better
>>> to explicitly restrict the use of this debugfs node. This also makes
>>> device_domain_lock static.
>>
>> What does "explicitly restrict" mean?
> 
> I originally thought about adding restrictions on this interface to a
> document. But obviously, this is a naive idea. :-) I went over the code
> again. The races exist in two paths:
> 
> 1. Dump the page table in use while setting a new page table to the
>     device.
> 2. A high-level page table entry has been marked as non-present, but the
>     dumping code has walked down to the low-level tables.
> 
> For case 1, we can try to solve it by dumping tables while holding the
> group->mutex.
> 
> For case 2, it is a bit weird. I tried to add a rwsem lock to make the
> iommu_unmap() and dumping tables in debugfs exclusive. This does not
> work because debugfs may depend on the DMA of the devices to work. It
> seems that what we can do is to allow this race, but when we traverse
> the page table in debugfs, we will check the validity of the physical
> address retrieved from the page table entry. Then, the worst case is to
> print some useless information.
> 
> The real code looks like this:
> 
>  From 3feb0727f9d7095729ef75ab1967270045b3a38c Mon Sep 17 00:00:00 2001
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Date: Sun, 29 May 2022 10:18:56 +0800
> Subject: [PATCH 1/1] iommu/vt-d: debugfs: Remove device_domain_lock usage
> 
> The domain_translation_struct debugfs node is used to dump the DMAR page
> tables for the PCI devices. It potentially races with setting domains to
> devices and the iommu_unmap() interface. The existing code uses a global
> spinlock device_domain_lock to avoid the races, but this is problematical
> as this lock is only used to protect the device tracking lists of each
> domain.
> 
> This replaces device_domain_lock with group->mutex to protect the traverse
> of the page tables from setting a new domain and always check the physical
> address retrieved from the page table entry before traversing to the next-
> level page table.
> 
> As a cleanup, this also makes device_domain_lock static.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 42 ++++++++++++++++++++++-------------
>   drivers/iommu/intel/iommu.c   |  2 +-
>   drivers/iommu/intel/iommu.h   |  1 -
>   3 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index d927ef10641b..e6f4835b8d9f 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -333,25 +333,28 @@ static void pgtable_walk_level(struct seq_file *m, 
> struct dma_pte *pde,
>               continue;
> 
>           path[level] = pde->val;
> -        if (dma_pte_superpage(pde) || level == 1)
> +        if (dma_pte_superpage(pde) || level == 1) {
>               dump_page_info(m, start, path);
> -        else
> -            pgtable_walk_level(m, phys_to_virt(dma_pte_addr(pde)),
> +        } else {
> +            unsigned long phys_addr;
> +
> +            phys_addr = (unsigned long)dma_pte_addr(pde);
> +            if (!pfn_valid(__phys_to_pfn(phys_addr)))

Given that pte_present(pde) passed just above, it was almost certainly a 
valid entry, so it seems unlikely that the physical address it pointed 
to could have disappeared in the meantime. If you're worried about the 
potential case where we've been preempted during this walk for long 
enough that the page has already been freed by an unmap, reallocated, 
and filled with someone else's data that happens to look like valid 
PTEs, this still isn't enough, since that data could just as well happen 
to look like valid physical addresses too.

I imagine that if you want to safely walk pagetables concurrently with 
them potentially being freed, you'd probably need to get RCU involved.

> +                break;
> +            pgtable_walk_level(m, phys_to_virt(phys_addr),

Also, obligatory reminder that pfn_valid() only means that pfn_to_page() 
gets you a valid struct page. Whether that page is direct-mapped kernel 
memory or not is a different matter.

>                          level - 1, start, path);
> +        }
>           path[level] = 0;
>       }
>   }
> 
> -static int show_device_domain_translation(struct device *dev, void *data)
> +static int __show_device_domain_translation(struct device *dev, void 
> *data)
>   {
>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>       struct dmar_domain *domain = info->domain;
>       struct seq_file *m = data;
>       u64 path[6] = { 0 };
> 
> -    if (!domain)
> -        return 0;
> -
>       seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
>              (u64)virt_to_phys(domain->pgd));
>       seq_puts(m, 
> "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
> @@ -359,20 +362,27 @@ static int show_device_domain_translation(struct 
> device *dev, void *data)
>       pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
>       seq_putc(m, '\n');
> 
> -    return 0;
> +    return 1;
>   }
> 
> -static int domain_translation_struct_show(struct seq_file *m, void 
> *unused)
> +static int show_device_domain_translation(struct device *dev, void *data)
>   {
> -    unsigned long flags;
> -    int ret;
> +    struct iommu_group *group;
> 
> -    spin_lock_irqsave(&device_domain_lock, flags);
> -    ret = bus_for_each_dev(&pci_bus_type, NULL, m,
> -                   show_device_domain_translation);
> -    spin_unlock_irqrestore(&device_domain_lock, flags);
> +    group = iommu_group_get(dev);
> +    if (group) {
> +        iommu_group_for_each_dev(group, data,
> +                     __show_device_domain_translation);

Why group_for_each_dev? If there *are* multiple devices in the group 
then by definition they should be attached to the same domain, so 
dumping that domain's mappings more than once seems pointless. 
Especially given that the outer bus_for_each_dev iteration will already 
visit each individual device anyway, so this would only make the 
redundancy even worse than it already is.

Robin.

> +        iommu_group_put(group);
> +    }
> 
> -    return ret;
> +    return 0;
> +}
> +
> +static int domain_translation_struct_show(struct seq_file *m, void 
> *unused)
> +{
> +    return bus_for_each_dev(&pci_bus_type, NULL, m,
> +                show_device_domain_translation);
>   }
>   DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1af4b6562266..cacae8bdaa65 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
>   #define IDENTMAP_GFX        2
>   #define IDENTMAP_AZALIA        4
> 
> -DEFINE_SPINLOCK(device_domain_lock);
> +static DEFINE_SPINLOCK(device_domain_lock);
>   static LIST_HEAD(device_domain_list);
> 
>   /*
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index a22adfbdf870..8a6d64d726c0 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -480,7 +480,6 @@ enum {
>   #define VTD_FLAG_SVM_CAPABLE        (1 << 2)
> 
>   extern int intel_iommu_sm;
> -extern spinlock_t device_domain_lock;
> 
>   #define sm_supported(iommu)    (intel_iommu_sm && 
> ecap_smts((iommu)->ecap))
>   #define pasid_supported(iommu)    (sm_supported(iommu) &&
> 
> Best regards,
> baolu
