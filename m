Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341DE551699
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbiFTLHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbiFTLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:07:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9F215730
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:07:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r66so4050715pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxJJWDMDRJ/V/J/ulLlbT6AgINdDK754dun2Uv1AOgg=;
        b=PW19D8SVO6QhENw3JVhyts0Te0k8ojpGqOn8mKPL3HS83cBv49L4iil947ieW6KN1r
         +gZfQTWs1TO+jdiBN5ZsHdcpod44pXk8rY3Lwyvhv+ilCUDPHoFLbk3+lYXp9P9gBVC9
         5zmBfaXf0AzIUm6PAuwnNitDwq5RcMoQ+9Bn2QxAHsbE9uCKQnLjJxbLgPV1PA3cfF4d
         7VBbfcxUkmFa8+0ySDYrFo375WlZU4e2xHLJ1rggEPyeHnKSU7K6GOzt54l5Hc1k5XCf
         CEucGRCG5Tw4gx9iwOn2otnzt4h8em2ie2SoBqohw9bH7PORfzRIn+NNt2xSqIhadiT1
         jpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxJJWDMDRJ/V/J/ulLlbT6AgINdDK754dun2Uv1AOgg=;
        b=6aHHugw18xrtpcNFMq4W9iWHZ2ohg2lAlU592p+ravQrubPt1eiQ368DVHZnJYSMZ0
         Z1/1n0OWztknAcuwO13/gOLdxYN7+oV2P97fJOa2FCiI/SppWP4rkVGuIUOwSE7PQVrZ
         0JjHmyLS5Q9VbelvvlzD/30rtXEpEBNuKwMhSIrh6znqKOvOwDwtRf8YrzSDlyE424TU
         Iq42QibhoUKVugb7IyJcCPkEjEtNBn543Ci5M5vCd4k/isk1Kvs8XkKoqOEr5tQ8AX7P
         2icU9v93ohO9SuG/equx9ufhPZYmrqL3nVv8Gu/EJWkAn0XSnL4KQwUjE8Pv/v7MexQN
         FtCA==
X-Gm-Message-State: AJIora8veCTyJsl25S6qM9O+IVBnZr5JmUG5hQos68XGlzktjcXRXbOn
        zOW7WwGa9cNOyuVjPHRvBwjLLQ==
X-Google-Smtp-Source: AGRyM1tCstRyg8UXzuaobRAsYvJVWreh4n+PaNIU7Gw8NlY+EetwGRq8AQ4deuoVumyseTykKVrMXg==
X-Received: by 2002:a63:6ecb:0:b0:40c:95e7:b9e1 with SMTP id j194-20020a636ecb000000b0040c95e7b9e1mr8468506pgc.57.1655723247910;
        Mon, 20 Jun 2022 04:07:27 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b0016a214e4afasm2385962plb.125.2022.06.20.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:07:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, osalvador@suse.de, paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with memmap_on_memory
Date:   Mon, 20 Jun 2022 19:06:16 +0800
Message-Id: <20220620110616.12056-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220620110616.12056-1-songmuchun@bytedance.com>
References: <20220620110616.12056-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, the feature of hugetlb_free_vmemmap is not compatible with the
feature of memory_hotplug.memmap_on_memory, and hugetlb_free_vmemmap
takes precedence over memory_hotplug.memmap_on_memory. However, someone
wants to make memory_hotplug.memmap_on_memory takes precedence over
hugetlb_free_vmemmap since memmap_on_memory makes it more likely to
succeed memory hotplug in close-to-OOM situations.  So the decision
of making hugetlb_free_vmemmap take precedence is not wise and elegant.
The proper approach is to have hugetlb_vmemmap.c do the check whether
the section which the HugeTLB pages belong to can be optimized.  If
the section's vmemmap pages are allocated from the added memory block
itself, hugetlb_free_vmemmap should refuse to optimize the vmemmap,
otherwise, do the optimization.  Then both kernel parameters are
compatible.  So this patch introduces VmemmapSelfHosted to mask any
non-optimizable vmemmap pages. The hugetlb_vmemmap can use this flag
to detect if a vmemmap page can be optimized.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Co-developed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 22 ++++-----
 Documentation/admin-guide/sysctl/vm.rst         |  5 +-
 include/linux/memory_hotplug.h                  |  9 ----
 include/linux/page-flags.h                      | 11 +++++
 mm/hugetlb_vmemmap.c                            | 66 ++++++++++++++++++++++---
 mm/memory_hotplug.c                             | 27 +++++-----
 6 files changed, 93 insertions(+), 47 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8090130b544b..d740e2ed0e61 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1722,9 +1722,11 @@
 			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
 			the default is on.
 
-			This is not compatible with memory_hotplug.memmap_on_memory.
-			If both parameters are enabled, hugetlb_free_vmemmap takes
-			precedence over memory_hotplug.memmap_on_memory.
+			Note that the vmemmap pages may be allocated from the added
+			memory block itself when memory_hotplug.memmap_on_memory is
+			enabled, those vmemmap pages cannot be optimized even if this
+			feature is enabled.  Other vmemmap pages not allocated from
+			the added memory block itself do not be affected.
 
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
@@ -3069,10 +3071,12 @@
 			[KNL,X86,ARM] Boolean flag to enable this feature.
 			Format: {on | off (default)}
 			When enabled, runtime hotplugged memory will
-			allocate its internal metadata (struct pages)
-			from the hotadded memory which will allow to
-			hotadd a lot of memory without requiring
-			additional memory to do so.
+			allocate its internal metadata (struct pages,
+			those vmemmap pages cannot be optimized even
+			if hugetlb_free_vmemmap is enabled) from the
+			hotadded memory which will allow to hotadd a
+			lot of memory without requiring additional
+			memory to do so.
 			This feature is disabled by default because it
 			has some implication on large (e.g. GB)
 			allocations in some configurations (e.g. small
@@ -3082,10 +3086,6 @@
 			Note that even when enabled, there are a few cases where
 			the feature is not effective.
 
-			This is not compatible with hugetlb_free_vmemmap. If
-			both parameters are enabled, hugetlb_free_vmemmap takes
-			precedence over memory_hotplug.memmap_on_memory.
-
 	memtest=	[KNL,X86,ARM,M68K,PPC,RISCV] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 5c9aa171a0d3..d7374a1e8ac9 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -565,9 +565,8 @@ See Documentation/admin-guide/mm/hugetlbpage.rst
 hugetlb_optimize_vmemmap
 ========================
 
-This knob is not available when memory_hotplug.memmap_on_memory (kernel parameter)
-is configured or the size of 'struct page' (a structure defined in
-include/linux/mm_types.h) is not power of two (an unusual system config could
+This knob is not available when the size of 'struct page' (a structure defined
+in include/linux/mm_types.h) is not power of two (an unusual system config could
 result in this).
 
 Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 20d7edf62a6a..e0b2209ab71c 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -351,13 +351,4 @@ void arch_remove_linear_mapping(u64 start, u64 size);
 extern bool mhp_supports_memmap_on_memory(unsigned long size);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
-bool mhp_memmap_on_memory(void);
-#else
-static inline bool mhp_memmap_on_memory(void)
-{
-	return false;
-}
-#endif
-
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e66f7aa3191d..2aa5dcbfe468 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -193,6 +193,11 @@ enum pageflags {
 
 	/* Only valid for buddy pages. Used to track pages that are reported */
 	PG_reported = PG_uptodate,
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/* For self-hosted memmap pages */
+	PG_vmemmap_self_hosted = PG_owner_priv_1,
+#endif
 };
 
 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -628,6 +633,12 @@ PAGEFLAG_FALSE(SkipKASanPoison, skip_kasan_poison)
  */
 __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+PAGEFLAG(VmemmapSelfHosted, vmemmap_self_hosted, PF_ANY)
+#else
+PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
+#endif
+
 /*
  * On an anonymous page mapped into a user virtual memory area,
  * page->mapping points to its anon_vma, not to a struct address_space;
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1089ea8a9c98..6d9801bb3fec 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -10,7 +10,7 @@
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
-#include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -97,18 +97,68 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 	return ret;
 }
 
+static unsigned int vmemmap_optimizable_pages(struct hstate *h,
+					      struct page *head)
+{
+	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
+		return 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+		pmd_t *pmdp, pmd;
+		struct page *vmemmap_page;
+		unsigned long vaddr = (unsigned long)head;
+
+		/*
+		 * Only the vmemmap page's vmemmap page can be self-hosted.
+		 * Walking the page tables to find the backing page of the
+		 * vmemmap page.
+		 */
+		pmdp = pmd_off_k(vaddr);
+		/*
+		 * The READ_ONCE() is used to stabilize *pmdp in a register or
+		 * on the stack so that it will stop changing under the code.
+		 * The only concurrent operation where it can be changed is
+		 * split_vmemmap_huge_pmd() (*pmdp will be stable after this
+		 * operation).
+		 */
+		pmd = READ_ONCE(*pmdp);
+		if (pmd_leaf(pmd))
+			vmemmap_page = pmd_page(pmd) + pte_index(vaddr);
+		else
+			vmemmap_page = pte_page(*pte_offset_kernel(pmdp, vaddr));
+		/*
+		 * Due to HugeTLB alignment requirements and the vmemmap pages
+		 * being at the start of the hotplugged memory region in
+		 * memory_hotplug.memmap_on_memory case. Checking any vmemmap
+		 * page's vmemmap page if it is marked as VmemmapSelfHosted is
+		 * sufficient.
+		 *
+		 * [                  hotplugged memory                  ]
+		 * [        section        ][...][        section        ]
+		 * [ vmemmap ][              usable memory               ]
+		 *   ^   |     |                                        |
+		 *   +---+     |                                        |
+		 *     ^       |                                        |
+		 *     +-------+                                        |
+		 *          ^                                           |
+		 *          +-------------------------------------------+
+		 */
+		if (PageVmemmapSelfHosted(vmemmap_page))
+			return 0;
+	}
+
+	return hugetlb_optimize_vmemmap_pages(h);
+}
+
 void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 {
 	unsigned long vmemmap_addr = (unsigned long)head;
 	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
 
-	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
+	vmemmap_pages = vmemmap_optimizable_pages(h, head);
 	if (!vmemmap_pages)
 		return;
 
-	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
-		return;
-
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
 	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
@@ -199,10 +249,10 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 static __init int hugetlb_vmemmap_sysctls_init(void)
 {
 	/*
-	 * If "memory_hotplug.memmap_on_memory" is enabled or "struct page"
-	 * crosses page boundaries, the vmemmap pages cannot be optimized.
+	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
+	 * be optimized.
 	 */
-	if (!mhp_memmap_on_memory() && is_power_of_2(sizeof(struct page)))
+	if (is_power_of_2(sizeof(struct page)))
 		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
 
 	return 0;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6662b86e9e64..3a59d4e97c03 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -43,30 +43,22 @@
 #include "shuffle.h"
 
 #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
-static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
-{
-	if (hugetlb_optimize_vmemmap_enabled())
-		return 0;
-	return param_set_bool(val, kp);
-}
-
-static const struct kernel_param_ops memmap_on_memory_ops = {
-	.flags	= KERNEL_PARAM_OPS_FL_NOARG,
-	.set	= memmap_on_memory_set,
-	.get	= param_get_bool,
-};
-
 /*
  * memory_hotplug.memmap_on_memory parameter
  */
 static bool memmap_on_memory __ro_after_init;
-module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
+module_param(memmap_on_memory, bool, 0444);
 MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
 
-bool mhp_memmap_on_memory(void)
+static inline bool mhp_memmap_on_memory(void)
 {
 	return memmap_on_memory;
 }
+#else
+static inline bool mhp_memmap_on_memory(void)
+{
+	return false;
+}
 #endif
 
 enum {
@@ -1035,7 +1027,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 			      struct zone *zone)
 {
 	unsigned long end_pfn = pfn + nr_pages;
-	int ret;
+	int ret, i;
 
 	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 	if (ret)
@@ -1043,6 +1035,9 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
 
+	for (i = 0; i < nr_pages; i++)
+		SetPageVmemmapSelfHosted(pfn_to_page(pfn + i));
+
 	/*
 	 * It might be that the vmemmap_pages fully span sections. If that is
 	 * the case, mark those sections online here as otherwise they will be
-- 
2.11.0

