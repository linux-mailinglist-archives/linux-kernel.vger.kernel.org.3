Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72361480C42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhL1R7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbhL1R7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:59:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA834C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 09:59:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x15so14127011plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 09:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K11vhWxRB0aC1HEuET5i85pU2eg+T6SriyrdDtgpz2w=;
        b=icmaoouT8z7DHOG1gO0B2/celzGHuK0aEzegvJOY4ydMxmHpLH6uMe/6Ir7oC6YJkB
         cr1cGZ+cWSuTyros4PyXTZxOAFTfp0+opaZISQ7AeVLEmwYVMFB5PrRQ6GSKAHJ7vpvh
         0SWHOX6pFUuRV4mNMk8J8TFA/Qsnmx7iEKbiB8HiKsmYtO61CwhDIX3a0hubshXikQnM
         sDa46ZqDiHwH/6MfYOwyfXvNtqpIamHrxmC+5fRTzckY4OhQp9xrL3EDcw1ij9+pkx36
         553iEiSqAyS4ocG/l0GKvQaIL187Va95KukJ+iMgHZWuCC/fBeRgQJc6ywE47ejSJKh7
         gKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=K11vhWxRB0aC1HEuET5i85pU2eg+T6SriyrdDtgpz2w=;
        b=smBkpUsV8TD2Z6xmFEwWTBURrQvEhVj9Lm9yD+ZIgtlhmQz0mk031qx7ba/uAdy1oy
         Zl7fGScheQk1TBrS7e20/9PUv+snkY8o03KCKCkHB8ro9UAN9eNzwpKZGtgWMwJNkQah
         zS+WZ02rgo36nBtQdN51+Ws5zVntfHyJGg6PPvTlZz5H1mhDs5fHl203hugKlRBVDtBg
         ayBfVj0rpMixT/KF4t77tWb9/ZibKOvVWfBY8tk/gZZeNWpk7MeLJqtdfq/dMCUi/zPG
         H3/Xx9KdOz4urRjBscwkYZXjU/fjvjYS8UdhV2cberSS0PdVLLdrmqPIz3xV86PEgOnT
         q7jw==
X-Gm-Message-State: AOAM532jNvE96PP3X/pNV3ti2bvSpbSf/u6LFFJPvz2JA4DlzKXOEMWk
        3/zS1fykswG6+czqWZpgLuk=
X-Google-Smtp-Source: ABdhPJzeK+YSyJQqSE1fbeJ/lIhqrevNPugwGf52PBV5WDGL02RJbVJ2pL2Tu6zdpNjoutkO8sI+kQ==
X-Received: by 2002:a17:90b:4f4a:: with SMTP id pj10mr27367326pjb.112.1640714349319;
        Tue, 28 Dec 2021 09:59:09 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:ba6a:82d5:3926:d7b3])
        by smtp.gmail.com with ESMTPSA id n64sm5991408pfn.49.2021.12.28.09.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 09:59:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC v2] mm: introduce page pin owner
Date:   Tue, 28 Dec 2021 09:59:04 -0800
Message-Id: <20211228175904.3739751-1-minchan@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Contiguous Memory Allocator(CMA) allocation can fail if any page
within the requested range has an elevated refcount(a pinned page).

Debugging such failures is difficult, because the struct pages only
show a combined refcount, and do not show the callstacks or
backtraces of the code that acquired each refcount. So the source
of the page pins remains a mystery, at the time of CMA failure.

In order to solve this without adding too much overhead, just do
nothing most of the time, which is pretty low overhead. However,
once a CMA failure occurs, then mark the page (this requires a
pointer's worth of space in struct page, but it uses page extensions
to get that), and start tracing the subsequent put_page() calls.
As the program finishes up, each page pin will be undone, and
traced with a backtrace. The programmer reads the trace output and
sees the list of all page pinning code paths.

This will consume an additional 8 bytes per 4KB page, or an
additional 0.2% of RAM. In addition to the storage space, it will
have some performance cost, due to increasing the size of struct
page so that it is greater than the cacheline size (or multiples
thereof) of popular (x86, ...) CPUs.

The idea can apply every user of migrate_pages as well as CMA to
know the reason why the page migration failed. To support it,
the implementation takes "enum migrate_reason" string as filter
of the tracepoint(see below).

Usage)

trace_dir="/sys/kernel/tracing"
echo 1 > $trace_dir/options/stacktrace
echo 1 > $trace_dir/events/page_pin_owner/enable
echo "contig_range" > $trace_dir/events/page_pin_owner/report_page_pinners/filter

===
example:
If you are interested in compaction failure, you want to use
"compaction" as a filter instead of "contig_range".
For the other filter strings, you can refer migrate_reason_names
in mm/debug.c
===

..
run workload
..

cat $trace_dir/trace
..

            bash-7442    [007] ...1.   288.504690: report_page_pinners: pfn=0x91430 flags=uptodate|swapbacked count=2 mapcount=0 mapping=ffff88f5480a2709 mt=5 reason=contig_range err=-11
            bash-7442    [007] ...1.   288.504691: <stack trace>
 => trace_event_raw_event_report_page_pinners
 => __report_page_pinners
 => migrate_pages
 => alloc_contig_range
 => cma_alloc.cold
 => cma_alloc_write
 => simple_attr_write
 => debugfs_attr_write
 => full_proxy_write
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
..
..

            bash-7442    [007] ...1.   288.506426: page_pin_owner_put: pfn=0x91430 flags=uptodate|swapbacked count=2 mapcount=0 mapping=ffff88f5480a2709 mt=5
            bash-7442    [007] ...1.   288.506427: <stack trace>
 => trace_event_raw_event_page_pin_owner_put
 => __page_pin_owner_put
 => put_page
 => putback_movable_pages
 => alloc_contig_range
 => cma_alloc.cold
 => cma_alloc_write
 => simple_attr_write
 => debugfs_attr_write
 => full_proxy_write
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
..
             cc1-31104   [001] d..2.   288.507632: page_pin_owner_put: pfn=0x91430 flags=uptodate|swapbacked count=1 mapcount=0 mapping=ffff88f5480a2709 mt=4
             cc1-31104   [001] d..2.   288.507636: <stack trace>
 => trace_event_raw_event_page_pin_owner_put
 => __page_pin_owner_put
 => release_pages
 => tlb_flush_mmu
 => unmap_page_range
 => unmap_vmas
 => exit_mmap
 => mmput
 => do_exit
 => do_group_exit
 => __x64_sys_exit_group
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
..

            make-31157   [007] d..3.   288.508333: page_pin_owner_put: pfn=0x91430 flags=uptodate|lru|swapbacked count=0 mapcount=0 mapping=ffff88f5480a2709 mt=5
            make-31157   [007] d..3.   288.508335: <stack trace>
 => trace_event_raw_event_page_pin_owner_put
 => __page_pin_owner_put
 => release_pages
 => __pagevec_lru_add
 => lru_add_drain_cpu
 => lru_add_drain
 => exit_mmap
 => mmput
 => begin_new_exec
 => load_elf_binary
 => bprm_execve
 => do_execveat_common.isra.0
 => __x64_sys_execve
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v1 - https://lore.kernel.org/lkml/20211206184730.858850-1-minchan@kernel.org/
  * PagePinOwner naming suggestion - jhubbard@
  * Description/Kconfig suggestion - jhubbard@
  * General migrate_page supports - huww98@

 include/linux/mm.h                    |  7 ++-
 include/linux/page_ext.h              |  3 +
 include/linux/page_pin_owner.h        | 48 ++++++++++++++
 include/trace/events/page_pin_owner.h | 81 ++++++++++++++++++++++++
 mm/Kconfig.debug                      | 15 +++++
 mm/Makefile                           |  1 +
 mm/migrate.c                          |  5 +-
 mm/page_alloc.c                       |  3 +
 mm/page_ext.c                         |  4 ++
 mm/page_pin_owner.c                   | 91 +++++++++++++++++++++++++++
 10 files changed, 256 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/page_pin_owner.h
 create mode 100644 include/trace/events/page_pin_owner.h
 create mode 100644 mm/page_pin_owner.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 82be88c1fdbb..5c437faf129c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/page-flags.h>
 #include <linux/page_ref.h>
+#include <linux/page_pin_owner.h>
 #include <linux/memremap.h>
 #include <linux/overflow.h>
 #include <linux/sizes.h>
@@ -714,8 +715,12 @@ static inline unsigned int folio_order(struct folio *folio)
  */
 static inline int put_page_testzero(struct page *page)
 {
+	int ret;
+
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
-	return page_ref_dec_and_test(page);
+	ret = page_ref_dec_and_test(page);
+	page_pin_owner_put(page);
+	return ret;
 }
 
 static inline int folio_put_testzero(struct folio *folio)
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index fabb2e1e087f..3236efd5ab07 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -23,6 +23,9 @@ enum page_ext_flags {
 	PAGE_EXT_YOUNG,
 	PAGE_EXT_IDLE,
 #endif
+#if defined(CONFIG_PAGE_PIN_OWNER)
+	PAGE_EXT_PIN_OWNER,
+#endif
 };
 
 /*
diff --git a/include/linux/page_pin_owner.h b/include/linux/page_pin_owner.h
new file mode 100644
index 000000000000..e68adcdd6799
--- /dev/null
+++ b/include/linux/page_pin_owner.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PAGE_PIN_OWNER_H
+#define __LINUX_PAGE_PIN_OWNER_H
+
+#include <linux/jump_label.h>
+
+#ifdef CONFIG_PAGE_PIN_OWNER
+extern struct static_key_false page_pin_owner_inited;
+extern struct page_ext_operations page_pin_owner_ops;
+
+void __report_page_pinners(struct page *page, int reason, int err);
+void __page_pin_owner_put(struct page *page);
+void __reset_page_pin_owner(struct page *page, unsigned int order);
+
+static inline void reset_page_pin_owner(struct page *page, unsigned int order)
+{
+	if (static_branch_unlikely(&page_pin_owner_inited))
+		__reset_page_pin_owner(page, order);
+}
+
+static inline void report_page_pinners(struct page *page, int reason, int err)
+{
+	if (!static_branch_unlikely(&page_pin_owner_inited))
+		return;
+
+	__report_page_pinners(page, reason, err);
+}
+
+static inline void page_pin_owner_put(struct page *page)
+{
+	if (!static_branch_unlikely(&page_pin_owner_inited))
+		return;
+
+	__page_pin_owner_put(page);
+}
+
+#else
+static inline void reset_page_pin_owner(struct page *page, unsigned int order)
+{
+}
+static inline void report_page_pinners(struct page *page, int reason, int err)
+{
+}
+static inline void page_pin_owner_put(struct page *page)
+{
+}
+#endif /* CONFIG_PAGE_PIN_OWNER */
+#endif /*__LINUX_PAGE_PIN_OWNER_H */
diff --git a/include/trace/events/page_pin_owner.h b/include/trace/events/page_pin_owner.h
new file mode 100644
index 000000000000..0096297312f5
--- /dev/null
+++ b/include/trace/events/page_pin_owner.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM page_pin_owner
+
+#if !defined(_TRACE_PAGE_PIN_OWNER_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PAGE_PIN_OWNER_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+#include <trace/events/mmflags.h>
+
+TRACE_EVENT(page_pin_owner_put,
+
+	TP_PROTO(struct page *page),
+
+	TP_ARGS(page),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned long, flags)
+		__field(int, count)
+		__field(int, mapcount)
+		__field(void *, mapping)
+		__field(int, mt)
+		),
+
+	TP_fast_assign(
+		__entry->pfn = page_to_pfn(page);
+		__entry->flags = page->flags;
+		__entry->count = page_ref_count(page);
+		__entry->mapcount = page_mapcount(page);
+		__entry->mapping = page->mapping;
+		__entry->mt = get_pageblock_migratetype(page);
+		),
+
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d",
+			__entry->pfn,
+			show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
+			__entry->count,
+			__entry->mapcount, __entry->mapping, __entry->mt)
+);
+
+TRACE_EVENT(report_page_pinners,
+
+	TP_PROTO(struct page *page, const char *reason, int err),
+
+	TP_ARGS(page, reason, err),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned long, flags)
+		__field(int, count)
+		__field(int, mapcount)
+		__field(void *, mapping)
+		__field(int, mt)
+		__field(const char *, reason)
+		__field(int, err)
+		),
+
+	TP_fast_assign(
+		__entry->pfn = page_to_pfn(page);
+		__entry->flags = page->flags;
+		__entry->count = page_ref_count(page);
+		__entry->mapcount = page_mapcount(page);
+		__entry->mapping = page->mapping;
+		__entry->mt = get_pageblock_migratetype(page);
+		__entry->reason = reason;
+		__entry->err = err;
+		),
+
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d reason=%s err=%d",
+			__entry->pfn,
+			show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
+			__entry->count, __entry->mapcount, __entry->mapping,
+			__entry->mt, __entry->reason, __entry->err)
+);
+
+#endif /* _TRACE_PAGE_PIN_OWNER_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 5bd5bb097252..ed2d5e6450b7 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -86,6 +86,21 @@ config PAGE_TABLE_CHECK_ENFORCED
 
 	  If unsure say "n".
 
+config PAGE_PIN_OWNER
+	bool "Track page pinner"
+	depends on DEBUG_KERNEL && TRACEPOINTS && STACKTRACE_SUPPORT
+	select PAGE_EXTENSION
+	select STACKTRACE
+	help
+	  This keeps track of what call chain is the pinner of a page, may
+	  help to find contiguous page allocation(memory-hotplug, compaction,
+	  cma and so on) failure. Even if you include this feature in your
+	  build, it is disabled by default. You should pass "page_pin_owner=on"
+	  to boot parameter in order to enable it. Eats a fair amount of memory
+	  if enabled.
+
+	  If unsure, say N.
+
 config PAGE_POISONING
 	bool "Poison pages after freeing"
 	help
diff --git a/mm/Makefile b/mm/Makefile
index 588d3113f3b0..ca89f4fa38ce 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
 obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
 obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
+obj-$(CONFIG_PAGE_PIN_OWNER) += page_pin_owner.o
 obj-$(CONFIG_CLEANCACHE) += cleancache.o
 obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
 obj-$(CONFIG_ZPOOL)	+= zpool.o
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..aa8a2c21da8e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1105,6 +1105,8 @@ static int unmap_and_move(new_page_t get_new_page,
 	rc = __unmap_and_move(page, newpage, force, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		set_page_owner_migrate_reason(newpage, reason);
+	else
+		report_page_pinners(page, reason, rc);
 
 out:
 	if (rc != -EAGAIN) {
@@ -1273,7 +1275,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	if (rc == MIGRATEPAGE_SUCCESS) {
 		move_hugetlb_state(hpage, new_hpage, reason);
 		put_new_page = NULL;
-	}
+	} else
+		report_page_pinners(hpage, reason, rc);
 
 out_unlock:
 	unlock_page(hpage);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5d62e1c8d81..98125b1b6e7e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -64,6 +64,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/mm.h>
 #include <linux/page_owner.h>
+#include <linux/page_pin_owner.h>
 #include <linux/page_table_check.h>
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
@@ -1310,6 +1311,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		if (memcg_kmem_enabled() && PageMemcgKmem(page))
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
+		reset_page_pin_owner(page, order);
 		page_table_check_free(page, order);
 		return false;
 	}
@@ -1350,6 +1352,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
+	reset_page_pin_owner(page, order);
 	page_table_check_free(page, order);
 
 	if (!PageHighMem(page)) {
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 2e66d934d63f..3c0df97b9b8b 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -7,6 +7,7 @@
 #include <linux/vmalloc.h>
 #include <linux/kmemleak.h>
 #include <linux/page_owner.h>
+#include <linux/page_pin_owner.h>
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
 
@@ -79,6 +80,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #ifdef CONFIG_PAGE_TABLE_CHECK
 	&page_table_check_ops,
 #endif
+#ifdef CONFIG_PAGE_PIN_OWNER
+	&page_pin_owner_ops,
+#endif
 };
 
 unsigned long page_ext_size = sizeof(struct page_ext);
diff --git a/mm/page_pin_owner.c b/mm/page_pin_owner.c
new file mode 100644
index 000000000000..736617df093c
--- /dev/null
+++ b/mm/page_pin_owner.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/page_pin_owner.h>
+#include <linux/migrate.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/page_pin_owner.h>
+
+static bool page_pin_owner_enabled;
+DEFINE_STATIC_KEY_FALSE(page_pin_owner_inited);
+EXPORT_SYMBOL(page_pin_owner_inited);
+
+static int __init early_page_pin_owner_param(char *buf)
+{
+	return kstrtobool(buf, &page_pin_owner_enabled);
+}
+early_param("page_pin_owner", early_page_pin_owner_param);
+
+static bool need_page_pin_owner(void)
+{
+	return page_pin_owner_enabled;
+}
+
+static void init_page_pin_owner(void)
+{
+	if (!page_pin_owner_enabled)
+		return;
+
+	static_branch_enable(&page_pin_owner_inited);
+}
+
+struct page_ext_operations page_pin_owner_ops = {
+	.need = need_page_pin_owner,
+	.init = init_page_pin_owner,
+};
+
+void __reset_page_pin_owner(struct page *page, unsigned int order)
+{
+	struct page_ext *page_ext;
+	int i;
+
+	page_ext = lookup_page_ext(page);
+	if (unlikely(!page_ext))
+		return;
+
+	for (i = 0; i < (1 << order); i++) {
+		if (!test_bit(PAGE_EXT_PIN_OWNER, &page_ext->flags))
+			break;
+
+		clear_bit(PAGE_EXT_PIN_OWNER, &page_ext->flags);
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+void __report_page_pinners(struct page *page, int reason, int err)
+{
+	struct page_ext *page_ext;
+
+	page_ext = lookup_page_ext(page);
+	if (unlikely(!page_ext))
+		return;
+
+	test_and_set_bit(PAGE_EXT_PIN_OWNER, &page_ext->flags);
+	trace_report_page_pinners(page, migrate_reason_names[reason], err);
+}
+
+void __page_pin_owner_put(struct page *page)
+{
+	struct page_ext *page_ext = lookup_page_ext(page);
+
+	if (unlikely(!page_ext))
+		return;
+
+	if (!test_bit(PAGE_EXT_PIN_OWNER, &page_ext->flags))
+		return;
+
+	trace_page_pin_owner_put(page);
+}
+EXPORT_SYMBOL(__page_pin_owner_put);
+
+static int __init page_pin_owner_init(void)
+{
+	if (!static_branch_unlikely(&page_pin_owner_inited)) {
+		pr_info("page_pin_owner is disabled\n");
+		return 0;
+	}
+
+	pr_info("page_pin_owner is enabled\n");
+	return 0;
+}
+late_initcall(page_pin_owner_init)
-- 
2.34.1.448.ga2b2bfdf31-goog

