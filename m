Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5134F1044
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377802AbiDDHtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377791AbiDDHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:49:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E263B028
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:47:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so7949678pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JDJT3Qxh7fbWsff5CNkcwlCUJKfGwejjpZxOeH2orE=;
        b=cv0bvkOz4QU7byShnVLo1cg1rr2nYKGki7mEcTk0uRyT1j07VStWmstjgCKwyYLOTN
         hlqQVWAjNNac4Er3/x+mlx8GkShHtxxirT4Ntat+wpqKWU6y7R4/Wj9+ksqwUj8br8Cp
         tcNDxdC8cApKebr0QG5srntAEwIbkp+JWgXQXZSFUzQYessOu83inDt/CYlklAU3E8XT
         dQoLyFmmeoZSxcCBT8BXUzlb9Mt+iYc8XicTN7krhBJiQ14INpl0qPWyOIxGUJXqNG+d
         hoihQ18s7+DRC0gLbhbRQ7KwCODRbb+Nk3ldp0FT1mW1YWFsxPrHA0Opi1H4U95HRGfz
         owcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JDJT3Qxh7fbWsff5CNkcwlCUJKfGwejjpZxOeH2orE=;
        b=LRbWYsOhwMW5CxwlWIC2o3kFyaaCbzWQCic5wniWJ+ZchJNsjbB9GP1YymWU9lg1hV
         GPHXNAUUDi1Btwqx8GcJoj0eaDs0sRF+WN/rFDkEXIq73SoajWF+6sEyF74+If4cPMI0
         QCvu8J4wDBX/ypiG5O+af18pRW9sifejvS1sA/sGMy980tQffVycyqW8o+qUI8yY5/99
         nFs+9CCxMrUaVnYR8K4jx0k80hXxerPy47lCN4JfwjTagTUuhisbIx8nucAkVLEjij1B
         BmLSNtr05hORzReSkuA68X74mhcLYMMDfdR3IW/Fw53dU2UvsySbPX9pIHnXozrlkz/S
         HFQg==
X-Gm-Message-State: AOAM5322WCyjNcYruVcra2GIWDlj2FzcgI4MD6nctsIfGvEYKn88QLpT
        SPA5c1B4K7GsvFP6l4AJdVtHvA==
X-Google-Smtp-Source: ABdhPJzc54DXU8VFqaNDpbxjrIsBuqp7LseE/GLvp12Eg/j7vGkoZGZR/ITzF4BE9JyF3XSfj7EicA==
X-Received: by 2002:a17:902:e889:b0:151:a56d:eb8f with SMTP id w9-20020a170902e88900b00151a56deb8fmr21594082plg.142.1649058447273;
        Mon, 04 Apr 2022 00:47:27 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b003823dd39d41sm9376579pgc.64.2022.04.04.00.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 00:47:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/3] mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
Date:   Mon,  4 Apr 2022 15:46:52 +0800
Message-Id: <20220404074652.68024-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220404074652.68024-1-songmuchun@bytedance.com>
References: <20220404074652.68024-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word of "free" is not expressive enough to express the feature of optimizing
vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
In this patch , cheanup configs to make code more expressive.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++--
 Documentation/admin-guide/mm/hugetlbpage.rst    |  2 +-
 arch/arm64/Kconfig                              |  2 +-
 arch/arm64/mm/flush.c                           |  2 +-
 arch/x86/Kconfig                                |  2 +-
 arch/x86/mm/init_64.c                           |  2 +-
 fs/Kconfig                                      | 16 ++++++++--------
 include/linux/hugetlb.h                         |  2 +-
 include/linux/mm.h                              |  2 +-
 include/linux/page-flags.h                      |  6 +++---
 mm/Makefile                                     |  2 +-
 mm/hugetlb_vmemmap.c                            |  4 ++--
 mm/hugetlb_vmemmap.h                            |  4 ++--
 mm/sparse-vmemmap.c                             |  4 ++--
 14 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 56edbe3f458f..89a58ac49d5f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1660,7 +1660,7 @@
 			Format: size[KMG]
 
 	hugetlb_free_vmemmap=
-			[KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+			[KNL] Reguires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 			enabled.
 			Allows heavy hugetlb users to free up some more
 			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
@@ -1669,7 +1669,7 @@
 			on:  enable the feature
 			off: disable the feature
 
-			Built with CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON=y,
+			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
 			the default is on.
 
 			This is not compatible with memory_hotplug.memmap_on_memory.
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 0166f9de3428..a90330d0a837 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -164,7 +164,7 @@ default_hugepagesz
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
 hugetlb_free_vmemmap
-	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
+	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables optimizing
 	unused vmemmap pages associated with each HugeTLB page.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bb7fc91d14f4..42ff6d3dbfb5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -96,7 +96,7 @@ config ARM64
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
-	select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
+	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index d19a13234a81..9e39598bbc21 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -78,7 +78,7 @@ void flush_dcache_page(struct page *page)
 	/*
 	 * Only the head page's flags of HugeTLB can be cleared since the tail
 	 * vmemmap pages associated with each HugeTLB page are mapped with
-	 * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
+	 * read-only when CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled (more
 	 * details can refer to vmemmap_remap_pte()).  Although
 	 * __sync_icache_dcache() only set PG_dcache_clean flag on the head
 	 * page struct, some tail page structs still can be seen the flag is
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a4cc8dd871f2..7ec9a91e2386 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -121,7 +121,7 @@ config X86
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE
-	select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP	if X86_64
+	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP	if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 96d34ebb20a9..af34dd1510d6 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1269,7 +1269,7 @@ static struct kcore_list kcore_vsyscall;
 
 static void __init register_page_bootmem_info(void)
 {
-#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
+#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)
 	int i;
 
 	for_each_online_node(i)
diff --git a/fs/Kconfig b/fs/Kconfig
index 8f6ab1cf5115..5976eb33535f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -250,22 +250,22 @@ config HUGETLB_PAGE
 # to enable the feature of minimizing overhead of struct page associated with
 # each HugeTLB page.
 #
-config ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
+config ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	bool
 
-config HUGETLB_PAGE_FREE_VMEMMAP
+config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	def_bool HUGETLB_PAGE
-	depends on ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
+	depends on ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
 
-config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
-	bool "Default freeing vmemmap pages of HugeTLB to on"
+config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
+	bool "Default optimizing vmemmap pages of HugeTLB to on"
 	default n
-	depends on HUGETLB_PAGE_FREE_VMEMMAP
+	depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	help
-	  When using HUGETLB_PAGE_FREE_VMEMMAP, the freeing unused vmemmap
+	  When using HUGETLB_PAGE_OPTIMIZE_VMEMMAP, the optimizing unused vmemmap
 	  pages associated with each HugeTLB page is default off. Say Y here
-	  to enable freeing vmemmap pages of HugeTLB by default. It can then
+	  to enable optimizing vmemmap pages of HugeTLB by default. It can then
 	  be disabled on the command line via hugetlb_free_vmemmap=off.
 
 config MEMFD_CREATE
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c16fbb1228a3..c40dda4daf51 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -617,7 +617,7 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	unsigned int optimize_vmemmap_pages;
 #endif
 #ifdef CONFIG_CGROUP_HUGETLB
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 26428ff262fc..75f7d309a9cf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3188,7 +3188,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 }
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int vmemmap_remap_free(unsigned long start, unsigned long end,
 		       unsigned long reuse);
 int vmemmap_remap_alloc(unsigned long start, unsigned long end,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 557d15ef3dc0..b70124b9c7c1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -199,13 +199,13 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
 			 hugetlb_optimize_vmemmap_key);
 
 static __always_inline bool hugetlb_optimize_vmemmap_enabled(void)
 {
-	return static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+	return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
 				   &hugetlb_optimize_vmemmap_key);
 }
 
diff --git a/mm/Makefile b/mm/Makefile
index 4cc13f3179a5..6f9ffa968a1a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -77,7 +77,7 @@ obj-$(CONFIG_FRONTSWAP)	+= frontswap.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
-obj-$(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)	+= hugetlb_vmemmap.o
+obj-$(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	+= hugetlb_vmemmap.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f25294973398..2655434a946b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -188,7 +188,7 @@
 #define RESERVE_VMEMMAP_NR		1U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
-DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
 			hugetlb_optimize_vmemmap_key);
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
@@ -276,7 +276,7 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 
 	/*
 	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
-	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
+	 * page structs that can be used when CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP,
 	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
 	 */
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 9760537849b5..109b0a53b6fe 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -10,7 +10,7 @@
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
 
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head);
 void hugetlb_vmemmap_free(struct hstate *h, struct page *head);
 void hugetlb_vmemmap_init(struct hstate *h);
@@ -41,5 +41,5 @@ static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
 {
 	return 0;
 }
-#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
+#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 8aecd6b3896c..52f36527bab3 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -34,7 +34,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
  *
@@ -420,7 +420,7 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 
 	return 0;
 }
-#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
+#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
-- 
2.11.0

