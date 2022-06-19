Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C25550AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiFSNjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237713AbiFSNje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:39:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77341DED5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:39:12 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e63so6535933pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbGK9Cq/QWBNj6gBb6mPcVvrSb8ReFvWjVflhIKzRWs=;
        b=rrTVVCLMAjnM1+iVJatswqIcAjrTDLivAhEksYylMzYTE62fDIBvFj8k8Z7h0BBUdT
         +WsGb6Hu/sGx6GK5ywjn6SAz3SakeLqEB2h73m/GumXE2U+lHyol1NIgak8/DmWPrs13
         qTwjGL87wdjLTjMu6akWK1uB8FZ21Iw2xJj/nruXCvqc+DmWT/hrzVrge3HoFARRXqOv
         VB28FTF63Yjqok8tO2rAJ+i/fxFzt943jZSLY2wP2k9U4IBEhN7K8jLp6fWZUHJiCSPx
         OmUeeZIibVFk/jNb3UKf8hrtQxHFXw1om8GvdLrR8AkbjktTI/9wqEWlv/06hDHCAGs5
         Quqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbGK9Cq/QWBNj6gBb6mPcVvrSb8ReFvWjVflhIKzRWs=;
        b=kDNApt2suLzYgJdQ6e9Ww33lBniEZxazDKa1fRhXfWg3/4TZmc6QrLz7yHeIr27T31
         OWBe5nl9oyueSS+YYMsTLhFShhlNzox7+jd20RXE3Xw6hBzM+DPV/jtonZCGVZ438mQr
         DB4fF+bFcGIcQsMNPMc2XwT12CpFDRnmKm9ZeeL6EMZQpIzke0hBmMpxjRCkOL3u0JTI
         dVMyuGxCT2YBDq5jQHH7qM28uFWW+V/najl7A/hkxV4umcTg4JkhXbVku2g12k7/KX+K
         VLSmHRQYrynqaay7yqfp4ZRUuayMHuHPytyQ+vBN/up1L83x0fo9ocE+k2qFbiUY3v9i
         Vmsw==
X-Gm-Message-State: AJIora968ne/V12F7SjyPOw43okHpWF1mZu7LIL2LlRU7hevbHOItJI1
        +ZAh+UiE4AuK/NjwTnVDV9cUGw==
X-Google-Smtp-Source: AGRyM1st/sgk1MrcQAH2Rp8wmGiSGnKtidFnDrDQccBM0dtJs6MhGnNGM51UuqornnzuEPbgq4Vomw==
X-Received: by 2002:a63:9257:0:b0:40c:7b32:4734 with SMTP id s23-20020a639257000000b0040c7b324734mr6329043pgn.317.1655645951737;
        Sun, 19 Jun 2022 06:39:11 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id y23-20020a056a001c9700b0051b95c76752sm6990982pfw.153.2022.06.19.06.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 06:39:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, osalvador@suse.de, paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with memmap_on_memory
Date:   Sun, 19 Jun 2022 21:38:51 +0800
Message-Id: <20220619133851.68184-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220619133851.68184-1-songmuchun@bytedance.com>
References: <20220619133851.68184-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 Documentation/admin-guide/kernel-parameters.txt | 22 +++++------
 Documentation/admin-guide/sysctl/vm.rst         |  5 +--
 include/linux/memory_hotplug.h                  |  9 -----
 include/linux/page-flags.h                      | 11 ++++++
 mm/hugetlb_vmemmap.c                            | 52 +++++++++++++++++++++----
 mm/memory_hotplug.c                             | 27 ++++++-------
 6 files changed, 79 insertions(+), 47 deletions(-)

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
index 1089ea8a9c98..73bfbb47f6a4 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -10,7 +10,7 @@
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
-#include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -97,18 +97,54 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 	return ret;
 }
 
+static unsigned int vmemmap_optimizable_pages(struct hstate *h,
+					      struct page *head)
+{
+	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
+		return 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+		unsigned long pfn = page_to_pfn(head);
+
+		/*
+		 * Due to HugeTLB alignment requirements and the vmemmap pages
+		 * being at the start of the hotplugged memory region in
+		 * memory_hotplug.memmap_on_memory case. Checking the first
+		 * vmemmap page's vmemmap if it is marked as VmemmapSelfHosted
+		 * is sufficient.
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
+		 *
+		 * Hotplugged memory block never has non-present sections, while
+		 * boot memory block can have one or more. So pfn_valid() is
+		 * used to filter out the non-present section which also cannot
+		 * be memmap_on_memory.
+		 */
+		pfn = ALIGN_DOWN(pfn, PHYS_PFN(memory_block_size_bytes()));
+		if (pfn_valid(pfn) && PageVmemmapSelfHosted(pfn_to_page(pfn)))
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
@@ -199,10 +235,10 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
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

