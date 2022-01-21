Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80DC495A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378750AbiAUGiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:38:18 -0500
Received: from foss.arm.com ([217.140.110.172]:39656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348774AbiAUGiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:38:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E31101E;
        Thu, 20 Jan 2022 22:38:14 -0800 (PST)
Received: from [10.163.74.170] (unknown [10.163.74.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A45F53F766;
        Thu, 20 Jan 2022 22:38:10 -0800 (PST)
Subject: Re: [PATCH] mm/migration: Add trace events for THP migrations
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
References: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
 <20220111015822.GA799985@u2004>
 <ee99799c-4e88-a7f5-0ec2-64cd710051e5@arm.com>
 <20220111065756.GA808887@u2004>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <61c7552c-f9e3-19a7-2d1f-8085c615a661@arm.com>
Date:   Fri, 21 Jan 2022 12:08:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220111065756.GA808887@u2004>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/22 12:27 PM, Naoya Horiguchi wrote:
> On Tue, Jan 11, 2022 at 10:31:21AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 1/11/22 7:28 AM, Naoya Horiguchi wrote:
>>> Hi Anshuman,
>>>
>>> On Fri, Jan 07, 2022 at 10:29:35AM +0530, Anshuman Khandual wrote:
>>>> This adds two trace events for PMD based THP migration without split. These
>>>> events closely follow the implementation details like setting and removing
>>>> of PMD migration entries, which are essential operations for THP migration.
>>>
>>> I often want to check which individual pages are migrated to which places
>>> (or not migrated) for testing, so these new tracepoints could help me.
>>> Maybe these can be much greater if they can handle other types of page
>>> migration for raw pages and hugetlb pages.  Is it hard to cover all such
>>> page migration events?
>>
>> Are you suggesting to cover all migration entry transitions for normal
>> and HugeTLB pages as well ?
> 
> Yes if you like the idea. I think that some events listed below can be grouped
> into one tracepoint event with showing args like pgsize or read/write flags
> (or implementation detail is up to you).

In its simplest form, something like this will work ? Although the THP migration
patch still remains (almost) unchanged.

 include/trace/events/migrate.h | 38 ++++++++++++++++++++++++++++++++++
 mm/migrate.c                   | 10 +++++++--
 mm/rmap.c                      |  3 +++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 779f3fad9ecd..b66652fcc8af 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -105,6 +105,44 @@ TRACE_EVENT(mm_migrate_pages_start,
 		  __print_symbolic(__entry->reason, MIGRATE_REASON))
 );
 
+TRACE_EVENT(set_migration_pte,
+
+	TP_PROTO(unsigned long addr, unsigned long pte),
+
+	TP_ARGS(addr, pte),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, addr)
+		__field(unsigned long, pte)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->pte = pte;
+	),
+
+	TP_printk("create pte migration entry addr=%lx, pte=%lx", __entry->addr, __entry->pte)
+);
+
+TRACE_EVENT(remove_migration_ptes,
+
+	TP_PROTO(struct page *old_page, struct page *new_page),
+
+	TP_ARGS(old_page, new_page),
+
+	TP_STRUCT__entry(
+		__field(struct page *, old_page)
+		__field(struct page *, new_page)
+	),
+
+	TP_fast_assign(
+		__entry->old_page = old_page;
+		__entry->new_page = new_page;
+	),
+
+	TP_printk("remove pte migration entry old_page=%lx new_page=%lx", __entry->old_page, __entry->new_page);
+);
+
 #endif /* _TRACE_MIGRATE_H */
 
 /* This part must be outside protection */
diff --git a/mm/migrate.c b/mm/migrate.c
index 18ce840914f0..271b1d565642 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1053,9 +1053,12 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	if (!page_mapped(page))
 		rc = move_to_new_page(newpage, page, mode);
 
-	if (page_was_mapped)
+	if (page_was_mapped) {
 		remove_migration_ptes(page,
 			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false);
+		trace_remove_migration_ptes(page,
+			rc == MIGRATEPAGE_SUCCESS ? newpage : page);
+	}
 
 out_unlock_both:
 	unlock_page(newpage);
@@ -1275,9 +1278,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	if (!page_mapped(hpage))
 		rc = move_to_new_page(new_hpage, hpage, mode);
 
-	if (page_was_mapped)
+	if (page_was_mapped) {
 		remove_migration_ptes(hpage,
 			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
+		trace_remove_migration_ptes(hpage,
+			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage);
+	}
 
 unlock_put_anon:
 	unlock_page(new_hpage);
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..cd373e378694 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -77,6 +77,7 @@
 #include <asm/tlbflush.h>
 
 #include <trace/events/tlb.h>
+#include <trace/events/migrate.h>
 
 #include "internal.h"
 
@@ -1861,6 +1862,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			if (pte_swp_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
+			trace_set_migration_pte(pvmw.address, pte_val(swp_pte));
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
@@ -1929,6 +1931,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			if (pte_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
+			trace_set_migration_pte(address, pte_val(swp_pte));
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
-- 
2.20.1


> 
>>
>> migrate_pages()
>> 	unmap_and_move_huge_page()
>> 		try_to_migrate()
>> 			make_writable_migration_entry() <---
>> 			make_readable_migration_entry() <---
>> 		remove_migration_ptes() <---
>> 	unmap_and_move()
>> 		__unmap_and_move()
>> 			try_to_migrate()
>> 				make_writable_migration_entry() <---
>> 				make_readable_migration_entry() <---
>> 			remove_migration_ptes() <---
> 
> Thanks,
> Naoya Horiguchi
> 
