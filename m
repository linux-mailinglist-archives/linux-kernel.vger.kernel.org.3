Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED949F7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348078AbiA1LJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:09:54 -0500
Received: from foss.arm.com ([217.140.110.172]:36970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348034AbiA1LJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:09:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B2F912FC;
        Fri, 28 Jan 2022 03:09:53 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.45.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85AC03F766;
        Fri, 28 Jan 2022 03:09:48 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] mm/migration: Add trace events for base page and HugeTLB migrations
Date:   Fri, 28 Jan 2022 16:39:42 +0530
Message-Id: <1643368182-9588-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643368182-9588-1-git-send-email-anshuman.khandual@arm.com>
References: <1643368182-9588-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two trace events for base page and HugeTLB page migrations. These
events, closely follow the implementation details like setting and removing
of PTE migration entries, which are essential operations for migration. The
new CREATE_TRACE_POINTS in <mm/rmap.c> covers both <events/migration.h> and
<events/tlb.h> based trace events. Hence drop redundant CREATE_TRACE_POINTS
from other places which could have otherwise conflicted during build.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/mm/init.c             |  1 -
 include/trace/events/migrate.h | 31 +++++++++++++++++++++++++++++++
 mm/migrate.c                   |  4 +++-
 mm/rmap.c                      |  6 ++++++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 4ba024d5b63a..d8cfce221275 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -31,7 +31,6 @@
  * We need to define the tracepoints somewhere, and tlb.c
  * is only compiled when SMP=y.
  */
-#define CREATE_TRACE_POINTS
 #include <trace/events/tlb.h>
 
 #include "mm_internal.h"
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 779f3fad9ecd..061b5128f335 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -105,6 +105,37 @@ TRACE_EVENT(mm_migrate_pages_start,
 		  __print_symbolic(__entry->reason, MIGRATE_REASON))
 );
 
+DECLARE_EVENT_CLASS(migration_pte,
+
+		TP_PROTO(unsigned long addr, unsigned long pte, int order),
+
+		TP_ARGS(addr, pte, order),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, addr)
+			__field(unsigned long, pte)
+			__field(int, order)
+		),
+
+		TP_fast_assign(
+			__entry->addr = addr;
+			__entry->pte = pte;
+			__entry->order = order;
+		),
+
+		TP_printk("addr=%lx, pte=%lx order=%d", __entry->addr, __entry->pte, __entry->order)
+);
+
+DEFINE_EVENT(migration_pte, set_migration_pte,
+	TP_PROTO(unsigned long addr, unsigned long pte, int order),
+	TP_ARGS(addr, pte, order)
+);
+
+DEFINE_EVENT(migration_pte, remove_migration_pte,
+	TP_PROTO(unsigned long addr, unsigned long pte, int order),
+	TP_ARGS(addr, pte, order)
+);
+
 #endif /* _TRACE_MIGRATE_H */
 
 /* This part must be outside protection */
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..79e3a553923a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -54,7 +54,6 @@
 
 #include <asm/tlbflush.h>
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/migrate.h>
 
 #include "internal.h"
@@ -257,6 +256,9 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		if (PageTransHuge(page) && PageMlocked(page))
 			clear_page_mlock(page);
 
+		trace_remove_migration_pte(pvmw.address, pte_val(pte),
+					   compound_order(new));
+
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
 	}
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..cae1c46440d6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -76,7 +76,9 @@
 
 #include <asm/tlbflush.h>
 
+#define CREATE_TRACE_POINTS
 #include <trace/events/tlb.h>
+#include <trace/events/migrate.h>
 
 #include "internal.h"
 
@@ -1861,6 +1863,8 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			if (pte_swp_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
+			trace_set_migration_pte(pvmw.address, pte_val(swp_pte),
+						compound_order(page));
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
@@ -1929,6 +1933,8 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			if (pte_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
+			trace_set_migration_pte(address, pte_val(swp_pte),
+						compound_order(page));
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
-- 
2.25.1

