Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA134981C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiAXOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiAXOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:06:33 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF12C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:06:32 -0800 (PST)
Date:   Mon, 24 Jan 2022 23:06:22 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643033190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PItVHezFV7jSSsF+Ov3kXBUk2buI7VDpDDF5A9TULwE=;
        b=H2oTHK4qVXV+lJmRIPDzP+Vr04WbD02RlJKjjhIIhnGe0gZYnnIeldXIWR03tYugcKYYLc
        29eT83I1Uw9+C3EHMkdin7vor9WKseWzfLMJcEXyCp4ZxslX0kRr7MQlWqOH0XI23LnuxM
        /uhFdOscnj6H2wjxOjygqa9ieZeD7rI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migration: Add trace events for THP migrations
Message-ID: <20220124140622.GA2955982@u2004>
References: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
 <20220111015822.GA799985@u2004>
 <ee99799c-4e88-a7f5-0ec2-64cd710051e5@arm.com>
 <20220111065756.GA808887@u2004>
 <61c7552c-f9e3-19a7-2d1f-8085c615a661@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61c7552c-f9e3-19a7-2d1f-8085c615a661@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 12:08:14PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/11/22 12:27 PM, Naoya Horiguchi wrote:
> > On Tue, Jan 11, 2022 at 10:31:21AM +0530, Anshuman Khandual wrote:
> >>
> >>
> >> On 1/11/22 7:28 AM, Naoya Horiguchi wrote:
> >>> Hi Anshuman,
> >>>
> >>> On Fri, Jan 07, 2022 at 10:29:35AM +0530, Anshuman Khandual wrote:
> >>>> This adds two trace events for PMD based THP migration without split. These
> >>>> events closely follow the implementation details like setting and removing
> >>>> of PMD migration entries, which are essential operations for THP migration.
> >>>
> >>> I often want to check which individual pages are migrated to which places
> >>> (or not migrated) for testing, so these new tracepoints could help me.
> >>> Maybe these can be much greater if they can handle other types of page
> >>> migration for raw pages and hugetlb pages.  Is it hard to cover all such
> >>> page migration events?
> >>
> >> Are you suggesting to cover all migration entry transitions for normal
> >> and HugeTLB pages as well ?
> > 
> > Yes if you like the idea. I think that some events listed below can be grouped
> > into one tracepoint event with showing args like pgsize or read/write flags
> > (or implementation detail is up to you).
> 
> In its simplest form, something like this will work ? Although the THP migration
> patch still remains (almost) unchanged.
> 
>  include/trace/events/migrate.h | 38 ++++++++++++++++++++++++++++++++++
>  mm/migrate.c                   | 10 +++++++--
>  mm/rmap.c                      |  3 +++
>  3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 779f3fad9ecd..b66652fcc8af 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -105,6 +105,44 @@ TRACE_EVENT(mm_migrate_pages_start,
>  		  __print_symbolic(__entry->reason, MIGRATE_REASON))
>  );
>  
> +TRACE_EVENT(set_migration_pte,
> +
> +	TP_PROTO(unsigned long addr, unsigned long pte),
> +
> +	TP_ARGS(addr, pte),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, addr)
> +		__field(unsigned long, pte)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->addr = addr;
> +		__entry->pte = pte;
> +	),
> +
> +	TP_printk("create pte migration entry addr=%lx, pte=%lx", __entry->addr, __entry->pte)
> +);
> +
> +TRACE_EVENT(remove_migration_ptes,
> +
> +	TP_PROTO(struct page *old_page, struct page *new_page),
> +
> +	TP_ARGS(old_page, new_page),
> +
> +	TP_STRUCT__entry(
> +		__field(struct page *, old_page)
> +		__field(struct page *, new_page)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->old_page = old_page;
> +		__entry->new_page = new_page;
> +	),
> +
> +	TP_printk("remove pte migration entry old_page=%lx new_page=%lx", __entry->old_page, __entry->new_page);

Thank you for the work, Anshuman. I have a few comments:

- the format string in TP_printk has prefix like "remove pte migration entry",
  but it seems to me redundant because each trace event name is also printed
  out like below:

     bash-2611  [001]   272.952419: mm_migrate_pages_start: mode=MIGRATE_SYNC reason=mempolicy_mbind
     bash-2611  [001]   272.952439: set_migration_pte:    create pte migration entry addr=700000000000, pte=dfffffffdf478602
     bash-2611  [001]   272.952466: remove_migration_ptes: remove pte migration entry old_pfn=0x105c3c new_pfn=0x15e8d8

  Maybe trace events for THP migration can be more compact too.

- TP_ARGS for remove_migration_ptes() are inconsistent with those of
  set_migration_pte and {set,remove}_migration_pmd, so how about putting
  trace_remove_migration_pte() within remove_migration_ptes() instead of
  after remove_migration_ptes().

- I think page order is also important to tell hugetlb migration events
  from normal page migration events.

I borrowed your diff and made testing patch like below. Feel free to
use/update it.

Thanks,
Naoya Horiguchi
---
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 779f3fad9ecd..f025e80bd5b9 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -105,6 +105,48 @@ TRACE_EVENT(mm_migrate_pages_start,
 		  __print_symbolic(__entry->reason, MIGRATE_REASON))
 );
 
+TRACE_EVENT(set_migration_pte,
+
+	TP_PROTO(unsigned long addr, unsigned long pte, int order),
+
+	TP_ARGS(addr, pte, order),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, addr)
+		__field(unsigned long, pte)
+		__field(int, order)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->pte = pte;
+		__entry->order = order;
+	),
+
+	TP_printk("addr=%lx, pte=%lx, order=%d", __entry->addr, __entry->pte, __entry->order)
+);
+
+TRACE_EVENT(remove_migration_pte,
+
+	TP_PROTO(unsigned long addr, unsigned long pte, int order),
+
+	TP_ARGS(addr, pte, order),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, addr)
+		__field(unsigned long, pte)
+		__field(int, order)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->pte = pte;
+		__entry->order = order;
+	),
+
+	TP_printk("addr=%lx, pte=%lx, order=%d", __entry->addr, __entry->pte, __entry->order)
+);
+
 #endif /* _TRACE_MIGRATE_H */
 
 /* This part must be outside protection */
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..0f9fb8813301 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -257,6 +257,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		if (PageTransHuge(page) && PageMlocked(page))
 			clear_page_mlock(page);
 
+		trace_remove_migration_pte(pvmw.address, pte_val(pte), compound_order(new));
+
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
 	}
diff --git a/mm/rmap.c b/mm/rmap.c
index b0fd9dc19eba..e089cbb9ef97 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -77,6 +77,7 @@
 #include <asm/tlbflush.h>
 
 #include <trace/events/tlb.h>
+#include <trace/events/migrate.h>
 
 #include "internal.h"
 
@@ -1872,6 +1873,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			if (pte_swp_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
+			trace_set_migration_pte(pvmw.address, pte_val(swp_pte), compound_order(page));
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
@@ -1940,6 +1942,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			if (pte_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
+			trace_set_migration_pte(address, pte_val(swp_pte), compound_order(page));
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
-- 
2.25.1
