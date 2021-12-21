Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37147C357
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhLUPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbhLUPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:46:57 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE3CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:46:57 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id n15so13301395qta.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cI7YVBo+Cohe6VKMVjfceS0qoE/CwWGaUs+lrS/IFhw=;
        b=j9YnSfPBq3Uj1s+FVmAJaDYoGxPz4B7+SyaV0NM2+GjRboMUIbJXQqvyzkDSGOukFa
         G13jNSIoE5JSsqf5nBU0FqbHa9KrtdU6umw3dBV9vcEhWI7LLFlZJIogNi02qvXShmyb
         BrJbgiabYSHPmwtNSqZptFzHSSMUXQ0K43QGHpgwwzjHnfGsw6ivu0gwMnXPKMgpegyQ
         3st+WrYpN6vJwHS2IjdBsqwM3Q2yaIXybCHMdgSkVbheFO/d7NA+CPpp1EUJRxby+oI2
         8vUqw9UWOubI2AVpG5Zd9hNotCKDe5nyKukLEyTc5fCxQpEjeSb+IkFTOZ2fsFMdeB+y
         kPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cI7YVBo+Cohe6VKMVjfceS0qoE/CwWGaUs+lrS/IFhw=;
        b=3VJY9I8Ahm/Kbpym9JqUi2ZxXlNLdkKoNWjx7ypXC0qn8Yq956KVcRiiqXzfqYT1qJ
         2NCCu0JEQSDeK2TLepUUDy9BWs225LRaArrYxwIlo0R9bBxIoAxzkzs60vPcHOcDX2M1
         TqKRPfD1w3o33Xu23b8DWu6Gwk0bo3Kt5zyPnWDlx2I3j9OPp8m2LQIkZ/waziQctjHn
         7GC1+AY3tNypPaBQdt3ZA5AcUorP0GgN4pEjBRDTUgm+CMT9KcCd7ZwTMo///H6lH1Wi
         6GoZ++sYnFxaf8Tm5GTBjT2Lplp0Cjan63e6b+BIvqTPIgdqvZH8vU7dJtl4vd3GAb4m
         fdaw==
X-Gm-Message-State: AOAM533RRkzB82FTHokolwxbaOcPy8XBztjzgGOvRaOb7IW1BnaL+/Zt
        op7ukPr7xjAseD7rNAJhvM5vZxXbf3zVAw==
X-Google-Smtp-Source: ABdhPJwlMJHxT8pjC4T4DgGsxuBW0b2SGWQjuWAGtDd4XhfZroIVquyM1GZwaRX9tJWbgpmt03OfTQ==
X-Received: by 2002:a05:622a:54d:: with SMTP id m13mr2685987qtx.33.1640101616027;
        Tue, 21 Dec 2021 07:46:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d20sm224588qtg.73.2021.12.21.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:46:55 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        corbet@lwn.net, will@kernel.org, rppt@kernel.org,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        masahiroy@kernel.org, samitolvanen@google.com,
        dave.hansen@linux.intel.com, x86@kernel.org, frederic@kernel.org,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com
Subject: [PATCH v3 3/4] mm: page table check
Date:   Tue, 21 Dec 2021 15:46:49 +0000
Message-Id: <20211221154650.1047963-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211221154650.1047963-1-pasha.tatashin@soleen.com>
References: <20211221154650.1047963-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check user page table entries at the time they are added and removed.

Allows to synchronously catch memory corruption issues related to double
mapping.

When a pte for an anonymous page is added into page table, we verify that
this pte does not already point to a file backed page, and vice versa if
this is a file backed page that is being added we verify that this page
does not have an anonymous mapping

We also enforce that read-only sharing for anonymous pages is allowed
(i.e.  cow after fork).  All other sharing must be for file pages.

Page table check allows to protect and debug cases where "struct page"
metadata became corrupted for some reason.  For example, when refcnt or
mapcount become invalid.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/vm/index.rst            |   1 +
 Documentation/vm/page_table_check.rst |  56 ++++++
 MAINTAINERS                           |   9 +
 arch/Kconfig                          |   3 +
 include/linux/page_table_check.h      | 147 ++++++++++++++
 mm/Kconfig.debug                      |  24 +++
 mm/Makefile                           |   1 +
 mm/page_alloc.c                       |   4 +
 mm/page_ext.c                         |   4 +
 mm/page_table_check.c                 | 270 ++++++++++++++++++++++++++
 10 files changed, 519 insertions(+)
 create mode 100644 Documentation/vm/page_table_check.rst
 create mode 100644 include/linux/page_table_check.h
 create mode 100644 mm/page_table_check.c

diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 6f5ffef4b716..43bb54d897d9 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -31,6 +31,7 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
    page_migration
    page_frags
    page_owner
+   page_table_check
    remap_file_pages
    slub
    split_page_table_lock
diff --git a/Documentation/vm/page_table_check.rst b/Documentation/vm/page_table_check.rst
new file mode 100644
index 000000000000..81f521ff7ea7
--- /dev/null
+++ b/Documentation/vm/page_table_check.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _page_table_check:
+
+================
+Page Table Check
+================
+
+Introduction
+============
+
+Page table check allows to hardern the kernel by ensuring that some types of
+the memory corruptions are prevented.
+
+Page table check performs extra verifications at the time when new pages become
+accessible from the userspace by getting their page table entries (PTEs PMDs
+etc.) added into the table.
+
+In case of detected corruption, the kernel is crashed. There is a small
+performance and memory overhead associated with the page table check. Therefore,
+it is disabled by default, but can be optionally enabled on systems where the
+extra hardening outweighs the performance costs. Also, because page table check
+is synchronous, it can help with debugging double map memory corruption issues,
+by crashing kernel at the time wrong mapping occurs instead of later which is
+often the case with memory corruptions bugs.
+
+Double mapping detection logic
+==============================
+
++-------------------+-------------------+-------------------+------------------+
+| Current Mapping   | New mapping       | Permissions       | Rule             |
++===================+===================+===================+==================+
+| Anonymous         | Anonymous         | Read              | Allow            |
++-------------------+-------------------+-------------------+------------------+
+| Anonymous         | Anonymous         | Read / Write      | Prohibit         |
++-------------------+-------------------+-------------------+------------------+
+| Anonymous         | Named             | Any               | Prohibit         |
++-------------------+-------------------+-------------------+------------------+
+| Named             | Anonymous         | Any               | Prohibit         |
++-------------------+-------------------+-------------------+------------------+
+| Named             | Named             | Any               | Allow            |
++-------------------+-------------------+-------------------+------------------+
+
+Enabling Page Table Check
+=========================
+
+Build kernel with:
+
+- PAGE_TABLE_CHECK=y
+  Note, it can only be enabled on platforms where ARCH_SUPPORTS_PAGE_TABLE_CHECK
+  is available.
+
+- Boot with 'page_table_check=on' kernel parameter.
+
+Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
+table support without extra kernel parameter.
diff --git a/MAINTAINERS b/MAINTAINERS
index 4403b348851d..16bc8cdc1492 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14485,6 +14485,15 @@ F:	include/net/page_pool.h
 F:	include/trace/events/page_pool.h
 F:	net/core/page_pool.c
 
+PAGE TABLE CHECK
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+M:	Andrew Morton <akpm@linux-foundation.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/vm/page_table_check.rst
+F:	include/linux/page_table_check.h
+F:	mm/page_table_check.c
+
 PANASONIC LAPTOP ACPI EXTRAS DRIVER
 M:	Kenneth Chan <kenneth.t.chan@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/arch/Kconfig b/arch/Kconfig
index 75ad877c5c48..fdba59052abc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1307,6 +1307,9 @@ config HAVE_ARCH_PFN_VALID
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	bool
 
+config ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	bool
+
 config ARCH_SPLIT_ARG64
 	bool
 	help
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
new file mode 100644
index 000000000000..38cace1da7b6
--- /dev/null
+++ b/include/linux/page_table_check.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2021, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef __LINUX_PAGE_TABLE_CHECK_H
+#define __LINUX_PAGE_TABLE_CHECK_H
+
+#ifdef CONFIG_PAGE_TABLE_CHECK
+#include <linux/jump_label.h>
+
+extern struct static_key_true page_table_check_disabled;
+extern struct page_ext_operations page_table_check_ops;
+
+void __page_table_check_zero(struct page *page, unsigned int order);
+void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
+				  pte_t pte);
+void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
+				  pmd_t pmd);
+void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
+				  pud_t pud);
+void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte);
+void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmdp, pmd_t pmd);
+void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
+				pud_t *pudp, pud_t pud);
+
+static inline void page_table_check_alloc(struct page *page, unsigned int order)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_zero(page, order);
+}
+
+static inline void page_table_check_free(struct page *page, unsigned int order)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_zero(page, order);
+}
+
+static inline void page_table_check_pte_clear(struct mm_struct *mm,
+					      unsigned long addr, pte_t pte)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pte_clear(mm, addr, pte);
+}
+
+static inline void page_table_check_pmd_clear(struct mm_struct *mm,
+					      unsigned long addr, pmd_t pmd)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pmd_clear(mm, addr, pmd);
+}
+
+static inline void page_table_check_pud_clear(struct mm_struct *mm,
+					      unsigned long addr, pud_t pud)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pud_clear(mm, addr, pud);
+}
+
+static inline void page_table_check_pte_set(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    pte_t pte)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pte_set(mm, addr, ptep, pte);
+}
+
+static inline void page_table_check_pmd_set(struct mm_struct *mm,
+					    unsigned long addr, pmd_t *pmdp,
+					    pmd_t pmd)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pmd_set(mm, addr, pmdp, pmd);
+}
+
+static inline void page_table_check_pud_set(struct mm_struct *mm,
+					    unsigned long addr, pud_t *pudp,
+					    pud_t pud)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pud_set(mm, addr, pudp, pud);
+}
+
+#else
+
+static inline void page_table_check_alloc(struct page *page, unsigned int order)
+{
+}
+
+static inline void page_table_check_free(struct page *page, unsigned int order)
+{
+}
+
+static inline void page_table_check_pte_clear(struct mm_struct *mm,
+					      unsigned long addr, pte_t pte)
+{
+}
+
+static inline void page_table_check_pmd_clear(struct mm_struct *mm,
+					      unsigned long addr, pmd_t pmd)
+{
+}
+
+static inline void page_table_check_pud_clear(struct mm_struct *mm,
+					      unsigned long addr, pud_t pud)
+{
+}
+
+static inline void page_table_check_pte_set(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    pte_t pte)
+{
+}
+
+static inline void page_table_check_pmd_set(struct mm_struct *mm,
+					    unsigned long addr, pmd_t *pmdp,
+					    pmd_t pmd)
+{
+}
+
+static inline void page_table_check_pud_set(struct mm_struct *mm,
+					    unsigned long addr, pud_t *pudp,
+					    pud_t pud)
+{
+}
+
+#endif /* CONFIG_PAGE_TABLE_CHECK */
+#endif /* __LINUX_PAGE_TABLE_CHECK_H */
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 1e73717802f8..5bd5bb097252 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -62,6 +62,30 @@ config PAGE_OWNER
 
 	  If unsure, say N.
 
+config PAGE_TABLE_CHECK
+	bool "Check for invalid mappings in user page tables"
+	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	select PAGE_EXTENSION
+	help
+	  Check that anonymous page is not being mapped twice with read write
+	  permissions. Check that anonymous and file pages are not being
+	  erroneously shared. Since the checking is performed at the time
+	  entries are added and removed to user page tables, leaking, corruption
+	  and double mapping problems are detected synchronously.
+
+	  If unsure say "n".
+
+config PAGE_TABLE_CHECK_ENFORCED
+	bool "Enforce the page table checking by default"
+	depends on PAGE_TABLE_CHECK
+	help
+	  Always enable page table checking.  By default the page table checking
+	  is disabled, and can be optionally enabled via page_table_check=on
+	  kernel parameter. This config enforces that page table check is always
+	  enabled.
+
+	  If unsure say "n".
+
 config PAGE_POISONING
 	bool "Poison pages after freeing"
 	help
diff --git a/mm/Makefile b/mm/Makefile
index 7919cd7f13f2..588d3113f3b0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
+obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
 obj-$(CONFIG_SECRETMEM) += secretmem.o
 obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 77253ea6031e..edfd6c81af82 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -64,6 +64,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/mm.h>
 #include <linux/page_owner.h>
+#include <linux/page_table_check.h>
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/ftrace.h>
@@ -1308,6 +1309,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		if (memcg_kmem_enabled() && PageMemcgKmem(page))
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
+		page_table_check_free(page, order);
 		return false;
 	}
 
@@ -1347,6 +1349,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
+	page_table_check_free(page, order);
 
 	if (!PageHighMem(page)) {
 		debug_check_no_locks_freed(page_address(page),
@@ -2421,6 +2424,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	}
 
 	set_page_owner(page, order, gfp_flags);
+	page_table_check_alloc(page, order);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 6242afb24d84..bee3240604dc 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -8,6 +8,7 @@
 #include <linux/kmemleak.h>
 #include <linux/page_owner.h>
 #include <linux/page_idle.h>
+#include <linux/page_table_check.h>
 
 /*
  * struct page extension
@@ -75,6 +76,9 @@ static struct page_ext_operations *page_ext_ops[] = {
 #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
 #endif
+#ifdef CONFIG_PAGE_TABLE_CHECK
+	&page_table_check_ops,
+#endif
 };
 
 unsigned long page_ext_size = sizeof(struct page_ext);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
new file mode 100644
index 000000000000..7504e7caa2a1
--- /dev/null
+++ b/mm/page_table_check.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2021, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <linux/mm.h>
+#include <linux/page_table_check.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"page_table_check: " fmt
+
+struct page_table_check {
+	atomic_t anon_map_count;
+	atomic_t file_map_count;
+};
+
+static bool __page_table_check_enabled __initdata =
+				IS_ENABLED(CONFIG_PAGE_TABLE_CHECK_ENFORCED);
+
+DEFINE_STATIC_KEY_TRUE(page_table_check_disabled);
+EXPORT_SYMBOL(page_table_check_disabled);
+
+static int __init early_page_table_check_param(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	if (strcmp(buf, "on") == 0)
+		__page_table_check_enabled = true;
+	else if (strcmp(buf, "off") == 0)
+		__page_table_check_enabled = false;
+
+	return 0;
+}
+
+early_param("page_table_check", early_page_table_check_param);
+
+static bool __init need_page_table_check(void)
+{
+	return __page_table_check_enabled;
+}
+
+static void __init init_page_table_check(void)
+{
+	if (!__page_table_check_enabled)
+		return;
+	static_branch_disable(&page_table_check_disabled);
+}
+
+struct page_ext_operations page_table_check_ops = {
+	.size = sizeof(struct page_table_check),
+	.need = need_page_table_check,
+	.init = init_page_table_check,
+};
+
+static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
+{
+	BUG_ON(!page_ext);
+	return (void *)(page_ext) + page_table_check_ops.offset;
+}
+
+static inline bool pte_user_accessible_page(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
+}
+
+static inline bool pmd_user_accessible_page(pmd_t pmd)
+{
+	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) &&
+		(pmd_val(pmd) & _PAGE_USER);
+}
+
+static inline bool pud_user_accessible_page(pud_t pud)
+{
+	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) &&
+		(pud_val(pud) & _PAGE_USER);
+}
+
+/*
+ * An enty is removed from the page table, decrement the counters for that page
+ * verify that it is of correct type and counters do not become negative.
+ */
+static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
+				   unsigned long pfn, unsigned long pgcnt)
+{
+	struct page_ext *page_ext;
+	struct page *page;
+	bool anon;
+	int i;
+
+	if (!pfn_valid(pfn))
+		return;
+
+	page = pfn_to_page(pfn);
+	page_ext = lookup_page_ext(page);
+	anon = PageAnon(page);
+
+	for (i = 0; i < pgcnt; i++) {
+		struct page_table_check *ptc = get_page_table_check(page_ext);
+
+		if (anon) {
+			BUG_ON(atomic_read(&ptc->file_map_count));
+			BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);
+		} else {
+			BUG_ON(atomic_read(&ptc->anon_map_count));
+			BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
+		}
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+/*
+ * A new enty is added to the page table, increment the counters for that page
+ * verify that it is of correct type and is not being mapped with a different
+ * type to a different process.
+ */
+static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
+				 unsigned long pfn, unsigned long pgcnt,
+				 bool rw)
+{
+	struct page_ext *page_ext;
+	struct page *page;
+	bool anon;
+	int i;
+
+	if (!pfn_valid(pfn))
+		return;
+
+	page = pfn_to_page(pfn);
+	page_ext = lookup_page_ext(page);
+	anon = PageAnon(page);
+
+	for (i = 0; i < pgcnt; i++) {
+		struct page_table_check *ptc = get_page_table_check(page_ext);
+
+		if (anon) {
+			BUG_ON(atomic_read(&ptc->file_map_count));
+			BUG_ON(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
+		} else {
+			BUG_ON(atomic_read(&ptc->anon_map_count));
+			BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
+		}
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+/*
+ * page is on free list, or is being allocated, verify that counters are zeroes
+ * crash if they are not.
+ */
+void __page_table_check_zero(struct page *page, unsigned int order)
+{
+	struct page_ext *page_ext = lookup_page_ext(page);
+	int i;
+
+	BUG_ON(!page_ext);
+	for (i = 0; i < (1 << order); i++) {
+		struct page_table_check *ptc = get_page_table_check(page_ext);
+
+		BUG_ON(atomic_read(&ptc->anon_map_count));
+		BUG_ON(atomic_read(&ptc->file_map_count));
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
+				  pte_t pte)
+{
+	if (&init_mm == mm)
+		return;
+
+	if (pte_user_accessible_page(pte)) {
+		page_table_check_clear(mm, addr, pte_pfn(pte),
+				       PAGE_SIZE >> PAGE_SHIFT);
+	}
+}
+EXPORT_SYMBOL(__page_table_check_pte_clear);
+
+void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
+				  pmd_t pmd)
+{
+	if (&init_mm == mm)
+		return;
+
+	if (pmd_user_accessible_page(pmd)) {
+		page_table_check_clear(mm, addr, pmd_pfn(pmd),
+				       PMD_PAGE_SIZE >> PAGE_SHIFT);
+	}
+}
+EXPORT_SYMBOL(__page_table_check_pmd_clear);
+
+void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
+				  pud_t pud)
+{
+	if (&init_mm == mm)
+		return;
+
+	if (pud_user_accessible_page(pud)) {
+		page_table_check_clear(mm, addr, pud_pfn(pud),
+				       PUD_PAGE_SIZE >> PAGE_SHIFT);
+	}
+}
+EXPORT_SYMBOL(__page_table_check_pud_clear);
+
+void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte)
+{
+	pte_t old_pte;
+
+	if (&init_mm == mm)
+		return;
+
+	old_pte = *ptep;
+	if (pte_user_accessible_page(old_pte)) {
+		page_table_check_clear(mm, addr, pte_pfn(old_pte),
+				       PAGE_SIZE >> PAGE_SHIFT);
+	}
+
+	if (pte_user_accessible_page(pte)) {
+		page_table_check_set(mm, addr, pte_pfn(pte),
+				     PAGE_SIZE >> PAGE_SHIFT,
+				     pte_write(pte));
+	}
+}
+EXPORT_SYMBOL(__page_table_check_pte_set);
+
+void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old_pmd;
+
+	if (&init_mm == mm)
+		return;
+
+	old_pmd = *pmdp;
+	if (pmd_user_accessible_page(old_pmd)) {
+		page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
+				       PMD_PAGE_SIZE >> PAGE_SHIFT);
+	}
+
+	if (pmd_user_accessible_page(pmd)) {
+		page_table_check_set(mm, addr, pmd_pfn(pmd),
+				     PMD_PAGE_SIZE >> PAGE_SHIFT,
+				     pmd_write(pmd));
+	}
+}
+EXPORT_SYMBOL(__page_table_check_pmd_set);
+
+void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
+				pud_t *pudp, pud_t pud)
+{
+	pud_t old_pud;
+
+	if (&init_mm == mm)
+		return;
+
+	old_pud = *pudp;
+	if (pud_user_accessible_page(old_pud)) {
+		page_table_check_clear(mm, addr, pud_pfn(old_pud),
+				       PUD_PAGE_SIZE >> PAGE_SHIFT);
+	}
+
+	if (pud_user_accessible_page(pud)) {
+		page_table_check_set(mm, addr, pud_pfn(pud),
+				     PUD_PAGE_SIZE >> PAGE_SHIFT,
+				     pud_write(pud));
+	}
+}
+EXPORT_SYMBOL(__page_table_check_pud_set);
-- 
2.34.1.307.g9b7440fafd-goog

