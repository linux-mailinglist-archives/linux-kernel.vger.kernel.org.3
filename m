Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ACC50892E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378975AbiDTN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356684AbiDTN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:26:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E511442A2D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650461023; x=1681997023;
  h=from:to:cc:subject:date:message-id;
  bh=bFw9jBOeodp0zCARNf/d8JtgIIyNELjWMG7lzca9XA4=;
  b=krgLlgf1DnoLEA8dnR81xc45UXPseGoJzQlm5+A79Nh37YIyM6t2mRKj
   IsIJgq3GKVDVlPQeXBfHGV3F3sl4KyxjY66LCMs1IcUpR71jkJPfoZ7Ck
   KAWFswth+RAC/im3UytMG6Vir5QTOU/pJ4GAhAB7HyD3Qieu28AZ4WnWn
   t9l+3xbj+rWsOQoiIgsZ+bKI8ieve3hZBUali5n69AOPPkoYeA7nz8Tth
   xXmusVNfrwoGyFJY2SZuGNJ8B1v9sgK0hXkq7ZlJGBB+hpqucvcqaqWNU
   edI4HqEayyLlI5kTCcUr5l2vuwYDhLoiYt+JRdk/mDt3DnBqEhuQrXilA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="244606005"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="244606005"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 06:23:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="555191349"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 06:23:20 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-mm@kvack.org (open list:HWPOISON MEMORY FAILURE HANDLING),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH 1/1] x86/mm: Forbid the zero page once it has uncorrectable errors
Date:   Wed, 20 Apr 2022 17:00:09 -0400
Message-Id: <20220420210009.65666-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing to the zero page with uncorrectable errors causes unexpected
machine checks. So forbid the zero page from being used by user-space
processes once it has uncorrectable errors. Processes that have already
mapped the zero page with uncorrectable errors will get killed once they
access to it. New processes will not use the zero page.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
1) Processes that have already mapped the zero page with uncorrectable
   errors could be recovered by attaching a new zeroed anonymous page.
   But this may need to walk all page tables for all such processes to
   update the PTEs pointing to the zero page. Looks like a big modification
   for a rare problem?

2) Some validation tests that sometimes pick up the virtual address
   mapped to the zero page to inject errors get themself killed and can't
   run anymore until reboot the system. To avoid injecting errors to the
   zero page, please refer to the path:

   https://lore.kernel.org/all/20220419211921.2230752-1-tony.luck@intel.com/

 arch/x86/include/asm/pgtable.h | 3 +++
 arch/x86/kernel/cpu/mce/core.c | 6 ++++++
 arch/x86/mm/pgtable.c          | 2 ++
 mm/memory-failure.c            | 2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 62ab07e24aef..d4b8693452e5 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -55,6 +55,9 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 	__visible;
 #define ZERO_PAGE(vaddr) ((void)(vaddr),virt_to_page(empty_zero_page))
 
+extern bool __read_mostly forbids_zeropage;
+#define mm_forbids_zeropage(x)	forbids_zeropage
+
 extern spinlock_t pgd_lock;
 extern struct list_head pgd_list;
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 981496e6bc0e..5b3af27cc8fa 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -44,6 +44,7 @@
 #include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
+#include <linux/pgtable.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -1370,6 +1371,11 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
 	if (count > 1)
 		return;
 
+	if (is_zero_pfn(current->mce_addr >> PAGE_SHIFT) && !forbids_zeropage) {
+		pr_err("Forbid user-space process from using zero page\n");
+		forbids_zeropage = true;
+	}
+
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..c0c56bce3acc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -28,6 +28,8 @@ void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
+bool __read_mostly forbids_zeropage;
+
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	return __pte_alloc_one(mm, __userpte_alloc_gfp);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index dcb6bb9cf731..30ad7bdeb89f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1744,7 +1744,7 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 	}
 
-	if (TestSetPageHWPoison(p)) {
+	if (TestSetPageHWPoison(p) || is_zero_pfn(pfn)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
 		res = -EHWPOISON;
-- 
2.17.1

