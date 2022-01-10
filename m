Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDF5489DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbiAJRDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:03:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57352 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiAJRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:03:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B85E26133E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2325FC36AE5;
        Mon, 10 Jan 2022 17:03:53 +0000 (UTC)
Date:   Mon, 10 Jan 2022 12:03:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migration: Add trace events for THP migrations
Message-ID: <20220110120351.44e60aed@gandalf.local.home>
In-Reply-To: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
References: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jan 2022 10:29:35 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> This adds two trace events for PMD based THP migration without split. These
> events closely follow the implementation details like setting and removing
> of PMD migration entries, which are essential operations for THP migration.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.16-rc8
> 
> Changes in V1:
> 
> - Dropped mm, pmdp, page arguments from trace
> - Updated trace argument names and output format
> 
> Changes in RFC:
> 
> https://lore.kernel.org/all/1640328398-20698-1-git-send-email-anshuman.khandual@arm.com/
> 
>  include/trace/events/thp.h | 37 +++++++++++++++++++++++++++++++++++++
>  mm/huge_memory.c           |  5 +++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
> index d7fbbe551841..193a555aa2ea 100644
> --- a/include/trace/events/thp.h
> +++ b/include/trace/events/thp.h
> @@ -83,6 +83,43 @@ TRACE_EVENT(hugepage_splitting,
>  		      __entry->addr, __entry->pte)
>  );
>  
> +TRACE_EVENT(set_migration_pmd,
> +
> +	TP_PROTO(unsigned long addr, unsigned long pmd),
> +
> +	TP_ARGS(addr, pmd),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, addr)
> +		__field(unsigned long, pmd)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->addr = addr;
> +		__entry->pmd = pmd;
> +	),
> +
> +	TP_printk("create pmd migration entry addr=%lx, pmd=%lx", __entry->addr, __entry->pmd)
> +);
> +
> +TRACE_EVENT(remove_migration_pmd,
> +
> +	TP_PROTO(unsigned long addr, unsigned long pmd),
> +
> +	TP_ARGS(addr, pmd),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, addr)
> +		__field(unsigned long, pmd)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->addr = addr;
> +		__entry->pmd = pmd;
> +	),
> +
> +	TP_printk("remove pmd migration entry addr=%lx, val=%lx", __entry->addr, __entry->pmd)

The two above are pretty much identical, except the first one has "pmd=%lx"
for the pmd, and the second has "val=%lx" for the pmd. I'd suggest they
both be the same, and then you could save memory by combining the two into
DECLARE_EVENT_CLASS() / DEFINE_EVENT() macros:

DECLARE_EVENT_CLASS(migration_pmd,

	TP_PROTO(unsigned long addr, unsigned long pmd),

	TP_ARGS(addr, pmd),

	TP_STRUCT__entry(
		__field(unsigned long, addr)
		__field(unsigned long, pmd)
	),

	TP_fast_assign(
		__entry->addr = addr;
		__entry->pmd = pmd;
	),

	TP_printk("create pmd migration entry addr=%lx, pmd=%lx", __entry->addr, __entry->pmd)
);

DEFINE_EVENT(migration_pmd, set_migration_pmd,
	TP_PROTO(unsigned long addr, unsigned long pmd),
	TP_ARGS(addr, pmd)
);

DEFINE_EVENT(migration_pmd, remove_migration_pmd,
	TP_PROTO(unsigned long addr, unsigned long pmd),
	TP_ARGS(addr, pmd)
);

And then you have the same thing, but it combines the code which saves both
data and text.

-- Steve

> +);
>  #endif /* _TRACE_THP_H */
>  
>  /* This part must be outside protection */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e5483347291c..d0adc019afe0 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -39,6 +39,9 @@
>  #include <asm/pgalloc.h>
>  #include "internal.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/thp.h>
> +
>  /*
>   * By default, transparent hugepage support is disabled in order to avoid
>   * risking an increased memory footprint for applications that are not
> @@ -3173,6 +3176,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
>  	page_remove_rmap(page, true);
>  	put_page(page);
> +	trace_set_migration_pmd(address, pmd_val(pmdswp));
>  }
>  
>  void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
> @@ -3206,5 +3210,6 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
>  		mlock_vma_page(new);
>  	update_mmu_cache_pmd(vma, address, pvmw->pmd);
> +	trace_remove_migration_pmd(address, pmd_val(pmde));
>  }
>  #endif

