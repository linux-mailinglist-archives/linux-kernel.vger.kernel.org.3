Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497AE538A16
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 05:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbiEaDC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 23:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbiEaDCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 23:02:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80947AE2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 20:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653966174; x=1685502174;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iBSluRndD9bMu1tYLdtBixYwGW0xjNPgExwwKpCv1mU=;
  b=WkIqFbkx8GzAEpzf33kLB2a+UCzsLwDKynnu6z6suZvrZBU+VFzUJwqD
   8v9GOnFwNVOjI/2Q5mCB9Cy8UCxngwVSeo92fcDZXWlEqb+rLKXDgL0ge
   euacuPVz98ZDm3CKKK0YwvnhB0ngk5d5VGHXN7z+H1qX3RGB83znefkhX
   GS+f53DUAlN7HQrvAktFpZQyyFUKbaw9aD1C6SxVnoHlnraCpEohyfIqk
   2iA855ZLOEbcYLADEEx96z3pBVC1VzhaRPSfGkGLrJo8GaMLjVGY7jEk/
   zVqQsbsNwbc0xdJrREJ9OWq79qap2x2D+8Hih6V2owGJ91u2E5wCGs9+0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="361498627"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="361498627"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 20:02:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="706372717"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.170.74]) ([10.249.170.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 20:02:08 -0700
Message-ID: <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
Date:   Tue, 31 May 2022 11:02:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220530121412.GX1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/30 20:14, Jason Gunthorpe wrote:
> On Sun, May 29, 2022 at 01:14:46PM +0800, Baolu Lu wrote:
> 
>>  From 1e87b5df40c6ce9414cdd03988c3b52bfb17af5f Mon Sep 17 00:00:00 2001
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Date: Sun, 29 May 2022 10:18:56 +0800
>> Subject: [PATCH 1/1] iommu/vt-d: debugfs: Remove device_domain_lock usage
>>
>> The domain_translation_struct debugfs node is used to dump static
>> mappings of PCI devices. It potentially races with setting new
>> domains to devices and the iommu_map/unmap() interfaces. The existing
>> code tries to use the global spinlock device_domain_lock to avoid the
>> races, but this is problematical as this lock is only used to protect
>> the device tracking lists of the domains.
>>
>> Instead of using an immature lock to cover up the problem, it's better
>> to explicitly restrict the use of this debugfs node. This also makes
>> device_domain_lock static.
> 
> What does "explicitly restrict" mean?

I originally thought about adding restrictions on this interface to a
document. But obviously, this is a naive idea. :-) I went over the code
again. The races exist in two paths:

1. Dump the page table in use while setting a new page table to the
    device.
2. A high-level page table entry has been marked as non-present, but the
    dumping code has walked down to the low-level tables.

For case 1, we can try to solve it by dumping tables while holding the
group->mutex.

For case 2, it is a bit weird. I tried to add a rwsem lock to make the
iommu_unmap() and dumping tables in debugfs exclusive. This does not
work because debugfs may depend on the DMA of the devices to work. It
seems that what we can do is to allow this race, but when we traverse
the page table in debugfs, we will check the validity of the physical
address retrieved from the page table entry. Then, the worst case is to
print some useless information.

The real code looks like this:

 From 3feb0727f9d7095729ef75ab1967270045b3a38c Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Sun, 29 May 2022 10:18:56 +0800
Subject: [PATCH 1/1] iommu/vt-d: debugfs: Remove device_domain_lock usage

The domain_translation_struct debugfs node is used to dump the DMAR page
tables for the PCI devices. It potentially races with setting domains to
devices and the iommu_unmap() interface. The existing code uses a global
spinlock device_domain_lock to avoid the races, but this is problematical
as this lock is only used to protect the device tracking lists of each
domain.

This replaces device_domain_lock with group->mutex to protect the traverse
of the page tables from setting a new domain and always check the physical
address retrieved from the page table entry before traversing to the next-
level page table.

As a cleanup, this also makes device_domain_lock static.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
  drivers/iommu/intel/debugfs.c | 42 ++++++++++++++++++++++-------------
  drivers/iommu/intel/iommu.c   |  2 +-
  drivers/iommu/intel/iommu.h   |  1 -
  3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index d927ef10641b..e6f4835b8d9f 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -333,25 +333,28 @@ static void pgtable_walk_level(struct seq_file *m, 
struct dma_pte *pde,
  			continue;

  		path[level] = pde->val;
-		if (dma_pte_superpage(pde) || level == 1)
+		if (dma_pte_superpage(pde) || level == 1) {
  			dump_page_info(m, start, path);
-		else
-			pgtable_walk_level(m, phys_to_virt(dma_pte_addr(pde)),
+		} else {
+			unsigned long phys_addr;
+
+			phys_addr = (unsigned long)dma_pte_addr(pde);
+			if (!pfn_valid(__phys_to_pfn(phys_addr)))
+				break;
+			pgtable_walk_level(m, phys_to_virt(phys_addr),
  					   level - 1, start, path);
+		}
  		path[level] = 0;
  	}
  }

-static int show_device_domain_translation(struct device *dev, void *data)
+static int __show_device_domain_translation(struct device *dev, void *data)
  {
  	struct device_domain_info *info = dev_iommu_priv_get(dev);
  	struct dmar_domain *domain = info->domain;
  	struct seq_file *m = data;
  	u64 path[6] = { 0 };

-	if (!domain)
-		return 0;
-
  	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
  		   (u64)virt_to_phys(domain->pgd));
  	seq_puts(m, 
"IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
@@ -359,20 +362,27 @@ static int show_device_domain_translation(struct 
device *dev, void *data)
  	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
  	seq_putc(m, '\n');

-	return 0;
+	return 1;
  }

-static int domain_translation_struct_show(struct seq_file *m, void *unused)
+static int show_device_domain_translation(struct device *dev, void *data)
  {
-	unsigned long flags;
-	int ret;
+	struct iommu_group *group;

-	spin_lock_irqsave(&device_domain_lock, flags);
-	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
-			       show_device_domain_translation);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	group = iommu_group_get(dev);
+	if (group) {
+		iommu_group_for_each_dev(group, data,
+					 __show_device_domain_translation);
+		iommu_group_put(group);
+	}

-	return ret;
+	return 0;
+}
+
+static int domain_translation_struct_show(struct seq_file *m, void *unused)
+{
+	return bus_for_each_dev(&pci_bus_type, NULL, m,
+				show_device_domain_translation);
  }
  DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1af4b6562266..cacae8bdaa65 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
  #define IDENTMAP_GFX		2
  #define IDENTMAP_AZALIA		4

-DEFINE_SPINLOCK(device_domain_lock);
+static DEFINE_SPINLOCK(device_domain_lock);
  static LIST_HEAD(device_domain_list);

  /*
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a22adfbdf870..8a6d64d726c0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -480,7 +480,6 @@ enum {
  #define VTD_FLAG_SVM_CAPABLE		(1 << 2)

  extern int intel_iommu_sm;
-extern spinlock_t device_domain_lock;

  #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
  #define pasid_supported(iommu)	(sm_supported(iommu) &&

Best regards,
baolu
