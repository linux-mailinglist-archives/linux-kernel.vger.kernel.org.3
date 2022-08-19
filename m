Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2265992E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbiHSCFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbiHSCFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:05:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40662D1E33
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660874712; x=1692410712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/NRHceWCW4BRZifLcKURaP+NP/AZlWzPRnfQFh6oyGU=;
  b=E39rX0vuvIXFtUvklck1ekVnTSwy/X72GyBXL1bH8piEclvSk2b6VtX0
   I+I0Pg0IawCJdOyICJTZwhfHj8oVd5A0ysGNzB/qdos/Z20zuVYLdkNeo
   6dQjrxAB72V+0ldyc7DOWyseELwQtw/pUoq4bJlEdnL+Qiu4cMecQOL5M
   bzsWT9gKHHWuO36fVWehcMVXXxfZ4EfmOudvHGQOewKe5wXsCm+e2k6js
   ZvosVNOADZTPlfUV73LHio6hAdspejoezwxRUDDc6luUU8yp62tCqF5Qk
   aUI/kR4UXoJeSw4YG6FISHFH9PNALWHUgKHCBuff/dqBKzp9JVNMcowrh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="273305872"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="273305872"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 19:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="608043055"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2022 19:05:08 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lennert Buytenhek <buytenh@wantstofly.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix lockdep splat due to klist iteration in atomic context
Date:   Fri, 19 Aug 2022 09:59:49 +0800
Message-Id: <20220819015949.4795-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_INTEL_IOMMU_DEBUGFS enabled, below lockdep splat are seen
when an I/O fault occurs on a machine with an Intel IOMMU in it.

 DMAR: DRHD: handling fault status reg 3
 DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0
       [fault reason 0x05] PTE Write access is not set
 DMAR: Dump dmar0 table entries for IOVA 0x0
 DMAR: root entry: 0x0000000127f42001
 DMAR: context entry: hi 0x0000000000001502, low 0x000000012d8ab001
 ================================
 WARNING: inconsistent lock state
 5.20.0-0.rc0.20220812git7ebfc85e2cd7.10.fc38.x86_64 #1 Not tainted
 --------------------------------
 inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
 rngd/1006 [HC1[1]:SC0[0]:HE0:SE1] takes:
 ff177021416f2d78 (&k->k_lock){?.+.}-{2:2}, at: klist_next+0x1b/0x160
 {HARDIRQ-ON-W} state was registered at:
   lock_acquire+0xce/0x2d0
   _raw_spin_lock+0x33/0x80
   klist_add_tail+0x46/0x80
   bus_add_device+0xee/0x150
   device_add+0x39d/0x9a0
   add_memory_block+0x108/0x1d0
   memory_dev_init+0xe1/0x117
   driver_init+0x43/0x4d
   kernel_init_freeable+0x1c2/0x2cc
   kernel_init+0x16/0x140
   ret_from_fork+0x1f/0x30
 irq event stamp: 7812
 hardirqs last  enabled at (7811): [<ffffffff85000e86>] asm_sysvec_apic_timer_interrupt+0x16/0x20
 hardirqs last disabled at (7812): [<ffffffff84f16894>] irqentry_enter+0x54/0x60
 softirqs last  enabled at (7794): [<ffffffff840ff669>] __irq_exit_rcu+0xf9/0x170
 softirqs last disabled at (7787): [<ffffffff840ff669>] __irq_exit_rcu+0xf9/0x170

The klist iterator functions using spin_*lock_irq*() but the klist
insertion functions using spin_*lock(), combined with the Intel DMAR
IOMMU driver iterating over klists from atomic (hardirq) context, where
pci_get_domain_bus_and_slot() calls into bus_find_device() which iterates
over klists.

As currently there's no plan to fix the klist to make it safe to use in
atomic context, this fixes the lockdep splat by avoid calling
pci_get_domain_bus_and_slot() in the hardirq context.

Fixes: 8ac0b64b9735 ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
Reported-by: Lennert Buytenhek <buytenh@wantstofly.org>
Link: https://lore.kernel.org/linux-iommu/Yvo2dfpEh%2FWC+Wrr@wantstofly.org/
Link: https://lore.kernel.org/linux-iommu/YvyBdPwrTuHHbn5X@wantstofly.org/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 47 +++++++++++++++----------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f12046f4b9aa..795529feac01 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -794,32 +794,11 @@ static void free_context_table(struct intel_iommu *iommu)
 }
 
 #ifdef CONFIG_DMAR_DEBUG
-static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u8 devfn)
+static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
+			 u8 bus, u8 devfn, struct dma_pte *parent, int level)
 {
-	struct device_domain_info *info;
-	struct dma_pte *parent, *pte;
-	struct dmar_domain *domain;
-	struct pci_dev *pdev;
-	int offset, level;
-
-	pdev = pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);
-	if (!pdev)
-		return;
-
-	info = dev_iommu_priv_get(&pdev->dev);
-	if (!info || !info->domain) {
-		pr_info("device [%02x:%02x.%d] not probed\n",
-			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
-		return;
-	}
-
-	domain = info->domain;
-	level = agaw_to_level(domain->agaw);
-	parent = domain->pgd;
-	if (!parent) {
-		pr_info("no page table setup\n");
-		return;
-	}
+	struct dma_pte *pte;
+	int offset;
 
 	while (1) {
 		offset = pfn_level_offset(pfn, level);
@@ -846,9 +825,10 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	struct pasid_entry *entries, *pte;
 	struct context_entry *ctx_entry;
 	struct root_entry *rt_entry;
+	int i, dir_index, index, level;
 	u8 devfn = source_id & 0xff;
 	u8 bus = source_id >> 8;
-	int i, dir_index, index;
+	struct dma_pte *pgtable;
 
 	pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
 
@@ -876,8 +856,11 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 		ctx_entry->hi, ctx_entry->lo);
 
 	/* legacy mode does not require PASID entries */
-	if (!sm_supported(iommu))
+	if (!sm_supported(iommu)) {
+		level = agaw_to_level(ctx_entry->hi & 7);
+		pgtable = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
 		goto pgtable_walk;
+	}
 
 	/* get the pointer to pasid directory entry */
 	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
@@ -904,8 +887,16 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	for (i = 0; i < ARRAY_SIZE(pte->val); i++)
 		pr_info("pasid table entry[%d]: 0x%016llx\n", i, pte->val[i]);
 
+	if (pasid_pte_get_pgtt(pte) == PASID_ENTRY_PGTT_FL_ONLY) {
+		level = pte->val[2] & BIT_ULL(2) ? 5 : 4;
+		pgtable = phys_to_virt(pte->val[2] & VTD_PAGE_MASK);
+	} else {
+		level = agaw_to_level((pte->val[0] >> 2) & 0x7);
+		pgtable = phys_to_virt(pte->val[0] & VTD_PAGE_MASK);
+	}
+
 pgtable_walk:
-	pgtable_walk(iommu, addr >> VTD_PAGE_SHIFT, bus, devfn);
+	pgtable_walk(iommu, addr >> VTD_PAGE_SHIFT, bus, devfn, pgtable, level);
 }
 #endif
 
-- 
2.25.1

