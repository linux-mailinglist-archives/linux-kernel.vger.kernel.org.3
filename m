Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78325473843
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbhLMXKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhLMXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:10:17 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA42C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 15:10:17 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id k4so15845407pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 15:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hlws1zMw9wHi7CNKFaKNRX5/ztQ0Z9NsaIRaYv+oMhE=;
        b=Cg8M/DuOxnE2u8Y+rDmOu0ZGouHQWTOqOPmBw91qtdemJDzaJqG+1sI0AAmEvsn/uP
         m25UCZnUf/MzRHG+w7/sw99ljtL3+qInHuEa16F7XVIBqHfD710M4FVOYeeKwG/hMrUh
         mJc4EB+IxJyjt0HDV4k7VF9pml34/5jzv6aFd7PnW65gC/haZ2C2PrHVf0+HbpK/nygC
         nRV5hGPev0cwvxhSPks1NoQMPJWqbALvTkuJAly1OkhfEq+gXXhzPC/l7SHVYLTHdEj9
         /8gEwSrAey2pOpbEj+Ck7mRw2OEOz42TKrkB1m7IwB/T6GMbXe/z21mvv85+RbCsvUKc
         +SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Hlws1zMw9wHi7CNKFaKNRX5/ztQ0Z9NsaIRaYv+oMhE=;
        b=UTFY7I89dG7n+M3meLPkFwf/YjRyQH7fFmSCiJdimMIuiz+TIiZwRGX0awNCzriQuf
         TdqDifLvqdSdk1wje2SYo5xiihvXChxF8i97g5b+XDB0VS1PgmxhzZoEsQ5Ouhpvykvh
         Zr3kMR73LSkpJh2oNu8OBIkMSttj+mHlbiPbsePuc2kkfsp1sIXWlN4OK+kTnzzTItaS
         cFNqp84Cjv8j97Y+CbPzTFWS1N9aMgQyrRcMrC8oJAPw5l4QQH/GESJa74fCHfthxHSi
         9y47JPZsZPjVN5bSFYGa57HFPxJ188sPh8R0Z/PEFmqcrPh5sodf3n2iAi18LHfiFFQj
         wN4A==
X-Gm-Message-State: AOAM532TXQWg5AMgQw2kdZTm5erejbuOHz6wFKG4VNAz3PNUFS8+unGB
        NZ7qBMrFbd+qP+vUVJexrpk=
X-Google-Smtp-Source: ABdhPJzpcsVenddlc8xXJLoezcvkQlgYQHISxn2tPeUEOs16n48IkB8zz2tYzLZw+HNFJZOjNltP6Q==
X-Received: by 2002:a63:2212:: with SMTP id i18mr1158339pgi.586.1639437016545;
        Mon, 13 Dec 2021 15:10:16 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7fed:4a3e:d021:bbd0])
        by smtp.gmail.com with ESMTPSA id q17sm15011555pfu.117.2021.12.13.15.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:10:16 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 13 Dec 2021 15:10:14 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RFC] mm: introduce page pinner
Message-ID: <YbfS1m9tBwYMnRqJ@google.com>
References: <20211206184730.858850-1-minchan@kernel.org>
 <78b01f68-ffe7-378b-fcaf-0bd3140da088@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b01f68-ffe7-378b-fcaf-0bd3140da088@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 05:56:35PM -0800, John Hubbard wrote:
> On 12/6/21 10:47, Minchan Kim wrote:
> > The contiguous memory allocation fails if one of the pages in
> > requested range has unexpected elevated reference count since
> > VM couldn't migrate the page out. It's very common pattern for
> > CMA allocation failure. The temporal elevated page refcount
> > could happen from various places and it's really hard to chase
> > who held the temporal page refcount at that time, which is the
> > vital information to debug the allocation failure.
> > 
> > This patch introduces page pinner to keep track of Page Pinner
> > who caused the CMA allocation failure. How page pinner work is
> > once VM found the non-migrated page after trying migration
> > during contiguos allocation, it marks the page and every page-put
> > operation on the page since then will have event trace. Since
> > page-put is always with page-get, the page-put event trace helps
> > to deduce where the pair page-get originated from.
> > 
> > The reason why the feature tracks page-put instead of page-get
> > indirectly is that since VM couldn't expect when page migration
> > fails, it should keep track of every page-get for migratable page
> > to dump information at failure. Considering backtrace as vitial
> > information as well as page's get/put is one of hottest path,
> > it's too heavy approach. Thus, to minimize runtime overhead,
> > this feature adds a new PAGE_EXT_PINNER flag under PAGE_EXT
> > debugging option to indicate migration-failed page and only
> > tracks every page-put operation for the page since the failure.
> 

Hi John,

> Hi Minchan,
> 
> This looks very useful, so I have a bunch of hopefully very
> easy-to-deal-with naming and documentation comments that are intended to
> tighten it up and get it ready for merging.
> 
> Starting with the subject line and commit description: rather than
> nitpick on these, I've studied the patch and written up a proposed
> replacement for the subject line and the lines above this comment.
> Please see if you like it:
> 
> 
> mm: introduce page pin reporter
> 
> A Contiguous Memory Allocator (CMA) allocation can fail if any page
> within the requested range has an elevated refcount (a pinned page).
> 
> Debugging such failures is difficult, because the struct pages only show
> a combined refcount, and do not show the callstacks or backtraces of the
> code that acquired each refcount. So the source of the page pins remains
> a mystery, at the time of CMA failure.
> 
> In order to solve this without adding too much overhead, just do nothing
> most of the time, which is pretty low overhead. :) However, once a CMA
> failure occurs, then mark the page (this requires a pointer's worth of
> space in struct page, but it uses page extensions to get that), and
> start tracing the subsequent put_page() calls. As the program finishes
> up, each page pin will be undone, and traced with a backtrace. The
> programmer reads the trace output and sees the list of all page pinning
> code paths.
> 
> This will consume an additional 8 bytes per 4KB page, or an additional
> 0.2% of RAM. In addition to the storage space, it will have some
> performance cost, due to increasing the size of struct page so that it
> is greater than the cacheline size (or multiples thereof) of popular
> (x86, ...) CPUs.

Perfect. Let me take your wording. And the next version, I might append
a little bit more and hope you will correct them once I screw it up
with poor wording again. :) Thank, John!

> 
> 
> > 
> > usage:
> > 
> > trace_dir="/sys/kernel/tracing"
> > echo 1 > $trace_dir/events/page_pinner/enable
> > echo 1 > $trace_dir/options/stacktrace
> > ..
> > run workload
> > ..
> > ..
> > 
> > cat $trace_dir/trace
> > 
> >             <...>-498     [006] .... 33306.301621: page_pinner_failure: pfn=0x9f0bb0 flags=uptodate|lru|swapbacked count=1 mapcount=0 mapping=00000000aec7812a mt=5
> >             <...>-498     [006] .... 33306.301625: <stack trace>
> >   => __page_pinner_failure
> >   => test_pages_isolated
> >   => alloc_contig_range
> >   => cma_alloc
> >   => cma_heap_allocate
> >   => dma_heap_ioctl
> >   => __arm64_sys_ioctl
> >   => el0_svc_common
> >   => do_el0_svc
> >   => el0_svc
> >   => el0_sync_handler
> >   => el0_sync
> >             <...>-24965   [001] .... 33306.392836: page_pinner_put: pfn=0x9f0bb0 flags=uptodate|lru|swapbacked count=0 mapcount=0 mapping=00000000aec7812a mt=5
> >             <...>-24965   [001] .... 33306.392846: <stack trace>
> >   => __page_pinner_put
> >   => release_pages
> >   => free_pages_and_swap_cache
> >   => tlb_flush_mmu_free
> >   => tlb_flush_mmu
> >   => zap_pte_range
> >   => unmap_page_range
> >   => unmap_vmas
> >   => exit_mmap
> >   => __mmput
> >   => mmput
> >   => exit_mm
> >   => do_exit
> >   => do_group_exit
> >   => get_signal
> >   => do_signal
> >   => do_notify_resume
> >   => work_pending
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > The PagePinner named after PageOwner since I wanted to keep track of
> > page refcount holder. Feel free to suggest better names.
> 
> 
> I understand how you arrived at the name, and it makes sense from that
> perspective. However, from an "I just read this code" perspective, it
> sounds like:
> 
> a) This is a tool to pin pages, and
> 
> b) It has a key API call to help report when it *fails* to pin pages.
> 
> ...both of which are completely wrong statements, of course. :)

Fair enough. I also thought but couldn't come up with better naming.

> 
> So, I'd recommend renaming:
> 
>     page_pinner --> page_pin_owner (and all variations of the name)
> 
>     page_pinner_failure --> report_page_pinners

Surely it's better naming.

> 
> 
> > Actually, I had alloc_contig_failure tracker as a candidate.
> > 
> >   include/linux/mm.h                 |  7 ++-
> >   include/linux/page_ext.h           |  3 +
> >   include/linux/page_pinner.h        | 47 ++++++++++++++++
> >   include/trace/events/page_pinner.h | 60 ++++++++++++++++++++
> >   mm/Kconfig.debug                   | 13 +++++
> >   mm/Makefile                        |  1 +
> >   mm/page_alloc.c                    |  3 +
> >   mm/page_ext.c                      |  4 ++
> >   mm/page_isolation.c                |  3 +
> >   mm/page_pinner.c                   | 90 ++++++++++++++++++++++++++++++
> >   10 files changed, 230 insertions(+), 1 deletion(-)
> >   create mode 100644 include/linux/page_pinner.h
> >   create mode 100644 include/trace/events/page_pinner.h
> >   create mode 100644 mm/page_pinner.c
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 73a52aba448f..a640cae593f9 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -26,6 +26,7 @@
> >   #include <linux/err.h>
> >   #include <linux/page-flags.h>
> >   #include <linux/page_ref.h>
> > +#include <linux/page_pinner.h>
> >   #include <linux/memremap.h>
> >   #include <linux/overflow.h>
> >   #include <linux/sizes.h>
> > @@ -744,8 +745,12 @@ struct inode;
> >    */
> >   static inline int put_page_testzero(struct page *page)
> >   {
> > +	int ret;
> > +
> >   	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
> > -	return page_ref_dec_and_test(page);
> > +	ret = page_ref_dec_and_test(page);
> > +	page_pinner_put(page);
> > +	return ret;
> >   }
> >   /*
> > diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> > index fabb2e1e087f..561d8458dc5a 100644
> > --- a/include/linux/page_ext.h
> > +++ b/include/linux/page_ext.h
> > @@ -23,6 +23,9 @@ enum page_ext_flags {
> >   	PAGE_EXT_YOUNG,
> >   	PAGE_EXT_IDLE,
> >   #endif
> > +#if defined(CONFIG_PAGE_PINNER)
> > +	PAGE_EXT_PINNER,
> > +#endif
> >   };
> >   /*
> > diff --git a/include/linux/page_pinner.h b/include/linux/page_pinner.h
> > new file mode 100644
> > index 000000000000..3f93a753b8e0
> > --- /dev/null
> > +++ b/include/linux/page_pinner.h
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_PAGE_PINNER_H
> > +#define __LINUX_PAGE_PINNER_H
> > +
> > +#include <linux/jump_label.h>
> > +
> > +#ifdef CONFIG_PAGE_PINNER
> > +extern struct static_key_false page_pinner_inited;
> > +extern struct page_ext_operations page_pinner_ops;
> > +
> > +void __page_pinner_failure(struct page *page);
> > +void __page_pinner_put(struct page *page);
> > +void __reset_page_pinner(struct page *page, unsigned int order);
> > +
> > +static inline void reset_page_pinner(struct page *page, unsigned int order)
> > +{
> > +	if (static_branch_unlikely(&page_pinner_inited))
> > +		__reset_page_pinner(page, order);
> > +}
> > +
> > +static inline void page_pinner_failure(struct page *page)
> > +{
> > +	if (!static_branch_unlikely(&page_pinner_inited))
> > +		return;
> > +
> > +	__page_pinner_failure(page);
> > +}
> > +
> > +static inline void page_pinner_put(struct page *page)
> > +{
> > +	if (!static_branch_unlikely(&page_pinner_inited))
> > +		return;
> > +
> > +	__page_pinner_put(page);
> > +}
> > +#else
> > +static inline void reset_page_pinner(struct page *page, unsigned int order)
> > +{
> > +}
> > +static inline void page_pinner_failure(struct page *page)
> > +{
> > +}
> > +static inline void page_pinner_put(struct page *page)
> > +{
> > +}
> > +#endif /* CONFIG_PAGE_PINNER */
> > +#endif /* __LINUX_PAGE_PINNER_H */
> > diff --git a/include/trace/events/page_pinner.h b/include/trace/events/page_pinner.h
> > new file mode 100644
> > index 000000000000..69ccd5c30f66
> > --- /dev/null
> > +++ b/include/trace/events/page_pinner.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM page_pinner
> > +
> > +#if !defined(_TRACE_PAGE_PINNER_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_PAGE_PINNER_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/tracepoint.h>
> > +#include <trace/events/mmflags.h>
> > +
> > +DECLARE_EVENT_CLASS(page_pinner_template,
> > +
> > +	TP_PROTO(struct page *page),
> > +
> > +	TP_ARGS(page),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(unsigned long, pfn)
> > +		__field(unsigned long, flags)
> > +		__field(int, count)
> > +		__field(int, mapcount)
> > +		__field(void *, mapping)
> > +		__field(int, mt)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->pfn = page_to_pfn(page);
> > +		__entry->flags = page->flags;
> > +		__entry->count = page_ref_count(page);
> > +		__entry->mapcount = page_mapcount(page);
> > +		__entry->mapping = page->mapping;
> > +		__entry->mt = get_pageblock_migratetype(page);
> > +	),
> > +
> > +	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d",
> > +		__entry->pfn,
> > +		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> > +		__entry->count,
> > +		__entry->mapcount, __entry->mapping, __entry->mt)
> > +);
> > +
> > +DEFINE_EVENT(page_pinner_template, page_pinner_failure,
> > +
> > +	TP_PROTO(struct page *page),
> > +
> > +	TP_ARGS(page)
> > +);
> > +
> > +DEFINE_EVENT(page_pinner_template, page_pinner_put,
> > +
> > +	TP_PROTO(struct page *page),
> > +
> > +	TP_ARGS(page)
> > +);
> > +
> > +#endif /* _TRACE_PAGE_PINNER_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index 1e73717802f8..0ad4a3b8f4eb 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -62,6 +62,19 @@ config PAGE_OWNER
> >   	  If unsure, say N.
> > +config PAGE_PINNER
> > +	bool "Track page pinner"
> > +	select PAGE_EXTENSION
> > +	depends on DEBUG_KERNEL && TRACEPOINTS
> > +	help
> > +	  This keeps track of what call chain is the pinner of a page, may
> > +	  help to find contiguos page allocation failure. Even if you include
> > +	  this feature in your build, it is disabled by default. You should
> > +	  pass "page_pinner=on" to boot parameter in order to enable it. Eats
> > +	  a fair amount of memory if enabled.
> 
> 
> We can do a *lot* better in documenting this, than "a fair bit of
> memory". How about something more like this (borrowing from the updated
> commit description):
> 
>   This keeps track of what call chain is the pinner of a page. That may
>   help to debug Contiguous Memory Allocator (CMA) allocation failures.

https://lore.kernel.org/lkml/YbfQJ0eTkkImUQ%2Fx@google.com/

I need to rephrase this one to cover other sites not only CMA since other
reviewer also want to see the failure from compaction.
If you are interested in, please chime in in the thread.

>   Even if you include this feature in your build, it is disabled by
>   default. In order to enable the feature, you must pass
>   "page_pinner=on" as a boot parameter.
> 
>   When enabled, this will consume an additional 8 bytes per 4KB page, or
>   an additional 0.2% of RAM. In addition to the storage space, it will
>   have some performance cost, due to increasing the size of struct page
>   so that it is greater than the cacheline size (or multiples thereof)
>   of popular (x86, ...) CPUs.


Definitely, it looks much better.
Thanks for the review, John!
