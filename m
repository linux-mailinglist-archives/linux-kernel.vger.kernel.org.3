Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55F947EC38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbhLXGq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:46:56 -0500
Received: from foss.arm.com ([217.140.110.172]:54572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhLXGqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:46:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 473421FB;
        Thu, 23 Dec 2021 22:46:53 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.70.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 946433F718;
        Thu, 23 Dec 2021 22:46:50 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] mm/migration: Add trace events for THP migrations
Date:   Fri, 24 Dec 2021 12:16:38 +0530
Message-Id: <1640328398-20698-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two trace events for PMD based THP migration without split. These
events closely follow the implementation details like setting and removing
of PMD migration entries, which are essential operations for THP migration.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.16-rc6

 include/trace/events/thp.h | 61 ++++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c           |  5 ++++
 2 files changed, 66 insertions(+)

diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
index d7fbbe551841..be5aeb783af1 100644
--- a/include/trace/events/thp.h
+++ b/include/trace/events/thp.h
@@ -83,6 +83,67 @@ TRACE_EVENT(hugepage_splitting,
 		      __entry->addr, __entry->pte)
 );
 
+TRACE_EVENT(set_migration_pmd,
+
+	TP_PROTO(struct mm_struct *mm, unsigned long address,
+		 pmd_t *pmdp, struct page *page, unsigned long pmdval),
+
+	TP_ARGS(mm, address, pmdp, page, pmdval),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(unsigned long, address)
+		__field(pmd_t *, pmdp)
+		__field(struct page *, page)
+		__field(unsigned long, pmdval)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->address = address;
+		__entry->pmdp = pmdp;
+		__entry->page = page;
+		__entry->pmdval = pmdval;
+	),
+
+	TP_printk("mm=%p, address=%lx, pmdp=%p, page=%p pmdval=%lx",
+		__entry->mm,
+		__entry->address,
+		__entry->pmdp,
+		__entry->page,
+		__entry->pmdval)
+);
+
+TRACE_EVENT(remove_migration_pmd,
+
+	TP_PROTO(struct mm_struct *mm, unsigned long address,
+		 pmd_t *pmdp, struct page *page, unsigned long pmdval),
+
+	TP_ARGS(mm, address, pmdp, page, pmdval),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(unsigned long, address)
+		__field(pmd_t *, pmdp)
+		__field(struct page *, page)
+		__field(unsigned long, pmdval)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->address = address;
+		__entry->pmdp = pmdp;
+		__entry->page = page;
+		__entry->pmdval = pmdval;
+	),
+
+	TP_printk("mm=%p, address=%lx, pmdp=%p, page=%p pmdval=%lx",
+		__entry->mm,
+		__entry->address,
+		__entry->pmdp,
+		__entry->page,
+		__entry->pmdval)
+);
 #endif /* _TRACE_THP_H */
 
 /* This part must be outside protection */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..611de486e095 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -39,6 +39,9 @@
 #include <asm/pgalloc.h>
 #include "internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/thp.h>
+
 /*
  * By default, transparent hugepage support is disabled in order to avoid
  * risking an increased memory footprint for applications that are not
@@ -3173,6 +3176,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
 	page_remove_rmap(page, true);
 	put_page(page);
+	trace_set_migration_pmd(mm, address, pvmw->pmd, page, pmd_val(pmdswp));
 }
 
 void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
@@ -3206,5 +3210,6 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
 		mlock_vma_page(new);
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
+	trace_remove_migration_pmd(mm, address, pvmw->pmd, new, pmd_val(pmde));
 }
 #endif
-- 
2.20.1

