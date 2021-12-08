Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4A46DB6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhLHSqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhLHSqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:46:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83042C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:42:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so4977598pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DX9hf+OjdJtlPfBR2tm+NSKSw+9zwSIfkws7TsDo/I4=;
        b=LOlH4+2GpMbnb2wMMmAXNxTAQoiIBJXrB30m7qik/pP6zL0YtdaoiCY8uflal8hEb8
         TreAa2ckcjrsVbU6vHd2pc0t1fiJVQg8z5wgtVhJ/LzaLzALblHiwBMNUswlipeP3K9g
         L8GQlKFzA3CDMvObTmN9Vst5WU89xj7B5r4m9on2TaWjdzAlBY+N0RXGqJqLeEsM3Y0f
         61zS1poZ3YTYU+38VZCQ3jC8xBOngFgOvsOjFaADEKCKSylefiyEcxmH1eieG9tA0oQx
         xKBH5K8OKfJPTgn4CtTyTthvrxJYTq5Gl2ObHFylni5gKYToVyw1B8qUqjlimagBZBCs
         WYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DX9hf+OjdJtlPfBR2tm+NSKSw+9zwSIfkws7TsDo/I4=;
        b=PXxk3veTF+aQiPn+wICuFpuEWjNGow2bMzJp2OEk22TJl8hgTwqw1bpDd8GA7R/YdP
         LfbQvrglONw3wrwATtTWsRsB3ulfAnV16FP8FrR3IDafL/Y0B+Aw8ebIubNr6FlVGOhj
         c51VAaaOBGaYVvzQoyE9s3ncwDdsH/Qkn3IUhHlD29/4+n5Eee9op9yffjwaIEUcyvAD
         nnF2I1yzp7qgLP6S7xoThbwIDM4vg0TErKTSNTsr0BbQbp/wHWgg8pJqxYu6u/Y97nTQ
         PPbpsv8G+tC/fqnSJ+cNy4ye0cED8AogX5S9blewFeVktDNvKK7Cd6StjHfzhzyN2J6B
         uvFA==
X-Gm-Message-State: AOAM531GAsmw05/16o59bJelOxhvpA/R0Li86LRwhpYK/rd+rUS4yqvo
        1Z1JGid881XQXtf+U56LbNI=
X-Google-Smtp-Source: ABdhPJzzTF4tmU/ZvtvoOBGB269ShJ/AjmRFpk5Fo8bbrZWJL4n9ho92LnxW4V2TDyJtPptSJebOZQ==
X-Received: by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id j5-20020a170902690500b001429e19702emr62807024plk.34.1638988959815;
        Wed, 08 Dec 2021 10:42:39 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9d08:cdd5:7aba:16bf])
        by smtp.gmail.com with ESMTPSA id oa2sm6747403pjb.53.2021.12.08.10.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:42:39 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 8 Dec 2021 10:42:37 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RFC] mm: introduce page pinner
Message-ID: <YbD8naaJrZQANahP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211208115250.GA17274@DESKTOP-N4CECTO.huww98.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:54:35PM +0800, 胡玮文 wrote:
> On Mon, Dec 06, 2021 at 10:47:30AM -0800, Minchan Kim wrote:
> > The contiguous memory allocation fails if one of the pages in
> > requested range has unexpected elevated reference count since
> > VM couldn't migrate the page out. It's very common pattern for
> > CMA allocation failure. The temporal elevated page refcount
> > could happen from various places and it's really hard to chase
> > who held the temporal page refcount at that time, which is the
> > vital information to debug the allocation failure.

Hi,

Please don't cut down original Cc list without special reason.

> 
> Hi Minchan,
> 
> I'm a newbie here. We are debugging a problem where every CPU core is doing
> compaction but making no progress, because of the unexpected page refcount. I'm
> interested in your approach, but this patch seems only to cover the CMA
> allocation path. So could it be extended to debugging migrate failure during
> compaction?  I'm not familiar with the kernel codebase, here is my untested
> thought:

The compaction failure will produce a lot events I wanted to avoid
in my system but I think your case is reasonable if you doesn't
mind the large events.

> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index cf25b00f03c8..85dacbca8fa0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -46,6 +46,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/page_idle.h>
>  #include <linux/page_owner.h>
> +#include <linux/page_pinner.h>
>  #include <linux/sched/mm.h>
>  #include <linux/ptrace.h>
>  #include <linux/oom.h>
> @@ -388,8 +389,10 @@ int folio_migrate_mapping(struct address_space *mapping,
>  
>         if (!mapping) {
>                 /* Anonymous page without mapping */
> -               if (folio_ref_count(folio) != expected_count)
> +               if (folio_ref_count(folio) != expected_count) {
> +                       page_pinner_failure(&folio->page);
>                         return -EAGAIN;
> +               }
>  
>                 /* No turning back from here */
>                 newfolio->index = folio->index;
> @@ -406,6 +409,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>         xas_lock_irq(&xas);
>         if (!folio_ref_freeze(folio, expected_count)) {
>                 xas_unlock_irq(&xas);
> +               page_pinner_failure(&folio->page);
>                 return -EAGAIN;
>         }
> 
> I'm not sure what to do with the new folio, it seems using folio->page in new
> codes is not correct.

If you want to cover compaction only, maybe this one:

diff --git a/mm/compaction.c b/mm/compaction.c
index bfc93da1c2c7..7bfbf7205fb8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2400,6 +2400,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
                /* All pages were either migrated or will be released */
                cc->nr_migratepages = 0;
                if (err) {
+                       struct page *failed_page;
+
+                       list_for_each_entry(failed_page, &cc->migratepages, lru)
+                               page_pinner_failure(failed_page);
+
                        putback_movable_pages(&cc->migratepages);
                        /*
                         * migrate_pages() may return -ENOMEM when scanners meet

However, for the case, I want to introduce some filter options like
failure reason(?)

    page_pinner_failure(pfn, reason)

So,  I could keep getting only CMA allocation failure events, not
compaction failure.

>  
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
> >            <...>-498     [006] .... 33306.301621: page_pinner_failure: pfn=0x9f0bb0 flags=uptodate|lru|swapbacked count=1 mapcount=0 mapping=00000000aec7812a mt=5
> >            <...>-498     [006] .... 33306.301625: <stack trace>
> >  => __page_pinner_failure
> >  => test_pages_isolated
> >  => alloc_contig_range
> >  => cma_alloc
> >  => cma_heap_allocate
> >  => dma_heap_ioctl
> >  => __arm64_sys_ioctl
> >  => el0_svc_common
> >  => do_el0_svc
> >  => el0_svc
> >  => el0_sync_handler
> >  => el0_sync
> >            <...>-24965   [001] .... 33306.392836: page_pinner_put: pfn=0x9f0bb0 flags=uptodate|lru|swapbacked count=0 mapcount=0 mapping=00000000aec7812a mt=5
> >            <...>-24965   [001] .... 33306.392846: <stack trace>
> >  => __page_pinner_put
> >  => release_pages
> >  => free_pages_and_swap_cache
> >  => tlb_flush_mmu_free
> >  => tlb_flush_mmu
> >  => zap_pte_range
> >  => unmap_page_range
> >  => unmap_vmas
> >  => exit_mmap
> >  => __mmput
> >  => mmput
> >  => exit_mm
> >  => do_exit
> >  => do_group_exit
> >  => get_signal
> >  => do_signal
> >  => do_notify_resume
> >  => work_pending
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > The PagePinner named after PageOwner since I wanted to keep track of
> > page refcount holder. Feel free to suggest better names.
> > Actually, I had alloc_contig_failure tracker as a candidate.
> > 
> >  include/linux/mm.h                 |  7 ++-
> >  include/linux/page_ext.h           |  3 +
> >  include/linux/page_pinner.h        | 47 ++++++++++++++++
> >  include/trace/events/page_pinner.h | 60 ++++++++++++++++++++
> >  mm/Kconfig.debug                   | 13 +++++
> >  mm/Makefile                        |  1 +
> >  mm/page_alloc.c                    |  3 +
> >  mm/page_ext.c                      |  4 ++
> >  mm/page_isolation.c                |  3 +
> >  mm/page_pinner.c                   | 90 ++++++++++++++++++++++++++++++
> >  10 files changed, 230 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/page_pinner.h
> >  create mode 100644 include/trace/events/page_pinner.h
> >  create mode 100644 mm/page_pinner.c

< snip>

> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index 1e73717802f8..0ad4a3b8f4eb 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -62,6 +62,19 @@ config PAGE_OWNER
> >  
> >  	  If unsure, say N.
> >  
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
> I'm a bit confused. It seems page pinner does not allocate any additional
> memory if you enable it by boot parameter. So the description seems inaccurate.

It will allocate page_ext descriptors so consumes the memory.

> 
> > +
> > +	  If unsure, say N.
> > +
> >  config PAGE_POISONING
> >  	bool "Poison pages after freeing"
> >  	help
> > diff --git a/mm/Makefile b/mm/Makefile
> > index fc60a40ce954..0c9b78b15070 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -102,6 +102,7 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
> >  obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
> >  obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
> >  obj-$(CONFIG_PAGE_OWNER) += page_owner.o
> > +obj-$(CONFIG_PAGE_PINNER) += page_pinner.o
> >  obj-$(CONFIG_CLEANCACHE) += cleancache.o
> >  obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
> >  obj-$(CONFIG_ZPOOL)	+= zpool.o
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index f41a5e990ac0..6e3a6f875a40 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -63,6 +63,7 @@
> >  #include <linux/sched/rt.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/page_owner.h>
> > +#include <linux/page_pinner.h>
> >  #include <linux/kthread.h>
> >  #include <linux/memcontrol.h>
> >  #include <linux/ftrace.h>
> > @@ -1299,6 +1300,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >  		if (memcg_kmem_enabled() && PageMemcgKmem(page))
> >  			__memcg_kmem_uncharge_page(page, order);
> >  		reset_page_owner(page, order);
> > +		reset_page_pinner(page, order);
> >  		return false;
> >  	}
> >  
> > @@ -1338,6 +1340,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >  	page_cpupid_reset_last(page);
> >  	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> >  	reset_page_owner(page, order);
> > +	reset_page_pinner(page, order);
> >  
> >  	if (!PageHighMem(page)) {
> >  		debug_check_no_locks_freed(page_address(page),
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index 2a52fd9ed464..0dafe968b212 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/kmemleak.h>
> >  #include <linux/page_owner.h>
> >  #include <linux/page_idle.h>
> > +#include <linux/page_pinner.h>
> >  
> >  /*
> >   * struct page extension
> > @@ -75,6 +76,9 @@ static struct page_ext_operations *page_ext_ops[] = {
> >  #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
> >  	&page_idle_ops,
> >  #endif
> > +#ifdef CONFIG_PAGE_PINNER
> > +	&page_pinner_ops,
> > +#endif
> >  };
> >  
> >  unsigned long page_ext_size = sizeof(struct page_ext);
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index a95c2c6562d0..a9ddea1c9166 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/memory.h>
> >  #include <linux/hugetlb.h>
> >  #include <linux/page_owner.h>
> > +#include <linux/page_pinner.h>
> >  #include <linux/migrate.h>
> >  #include "internal.h"
> >  
> > @@ -310,6 +311,8 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
> >  
> >  out:
> >  	trace_test_pages_isolated(start_pfn, end_pfn, pfn);
> > +	if (ret < 0)
> > +		page_pinner_failure(pfn_to_page(pfn));
> >  
> >  	return ret;
> >  }
> > diff --git a/mm/page_pinner.c b/mm/page_pinner.c
> > new file mode 100644
> > index 000000000000..300a90647557
> > --- /dev/null
> > +++ b/mm/page_pinner.c
> > @@ -0,0 +1,90 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/mm.h>
> > +#include <linux/page_pinner.h>
> > +
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/page_pinner.h>
> > +
> > +static bool page_pinner_enabled;
> > +DEFINE_STATIC_KEY_FALSE(page_pinner_inited);
> > +EXPORT_SYMBOL(page_pinner_inited);
> > +
> > +static int __init early_page_pinner_param(char *buf)
> > +{
> > +	return kstrtobool(buf, &page_pinner_enabled);
> > +}
> > +early_param("page_pinner", early_page_pinner_param);
> > +
> > +static bool need_page_pinner(void)
> > +{
> > +	return page_pinner_enabled;
> > +}
> > +
> > +static void init_page_pinner(void)
> > +{
> > +	if (!page_pinner_enabled)
> > +		return;
> > +
> > +	static_branch_enable(&page_pinner_inited);
> > +}
> > +
> > +struct page_ext_operations page_pinner_ops = {
> > +	.need = need_page_pinner,
> > +	.init = init_page_pinner,
> > +};
> > +
> > +void __reset_page_pinner(struct page *page, unsigned int order)
> > +{
> > +	struct page_ext *page_ext;
> > +	int i;
> > +
> > +	page_ext = lookup_page_ext(page);
> > +	if (unlikely(!page_ext))
> > +		return;
> > +
> > +	for (i = 0; i < (1 << order); i++) {
> > +		if (!test_bit(PAGE_EXT_PINNER, &page_ext->flags))
> > +			break;
> > +
> > +		clear_bit(PAGE_EXT_PINNER, &page_ext->flags);
> > +		page_ext = page_ext_next(page_ext);
> > +	}
> > +}
> > +
> > +void __page_pinner_failure(struct page *page)
> > +{
> > +	struct page_ext *page_ext = lookup_page_ext(page);
> > +
> > +	if (unlikely(!page_ext))
> > +		return;
> > +
> > +	trace_page_pinner_failure(page);
> > +	test_and_set_bit(PAGE_EXT_PINNER, &page_ext->flags);
> > +}
> > +
> > +void __page_pinner_put(struct page *page)
> > +{
> > +	struct page_ext *page_ext = lookup_page_ext(page);
> > +
> > +	if (unlikely(!page_ext))
> > +		return;
> > +
> > +	if (!test_bit(PAGE_EXT_PINNER, &page_ext->flags))
> > +		return;
> > +
> > +	trace_page_pinner_put(page);
> > +}
> > +EXPORT_SYMBOL(__page_pinner_put);
> > +
> > +
> > +static int __init page_pinner_init(void)
> > +{
> > +	if (!static_branch_unlikely(&page_pinner_inited)) {
> > +		pr_info("page_pinner is disabled\n");
> > +		return 0;
> > +	}
> > +
> > +	pr_info("page_pinner is enabled\n");
> > +	return 0;
> > +}
> > +late_initcall(page_pinner_init)
> > -- 
> > 2.34.1.400.ga245620fadb-goog
> > 
> 
> More info about my compaction issue:
> 
> This call stack returns -EAGAIN in 99.9% cases on the problematic host
> (Ubuntu 20.04 with kernel 5.11.0-40):
> 
> migrate_page_move_mapping (now folio_migrate_mapping) <- returns -EAGAIN
> migrate_page
> fallback_migrate_page
> move_to_new_page
> migrate_pages
> compact_zone
> compact_zone_order
> try_to_compact_pages
> __alloc_pages_direct_compact
> __alloc_pages_slowpath.constprop.0
> __alloc_pages_nodemask
> alloc_pages_vma
> do_huge_pmd_anonymous_page
> __handle_mm_fault
> handle_mm_fault
> do_user_addr_fault
> exc_page_fault
> asm_exc_page_fault
> 
> The offending pages are from shm, allocated by mmap() with MAP_SHARED by a
> machine learning program. They may have relationships with NVIDIA CUDA, but I
> want to confirm this, and make improvements if possible.

So you are suspecting some kernel driver hold a addtional refcount
using get_user_pages or page get API?

> 
> When the issue reproduce, a single page fault that triggers a sync compaction
> can take tens of seconds. Then all 40 CPU threads are doing compaction, and
> application runs several order of magnitude slower.
> 
> Disabling sync compaction is a workaround (the default is "madvise"):
> 
> echo never > /sys/kernel/mm/transparent_hugepage/defrag
> 
> Previously I asked for help at https://lore.kernel.org/linux-mm/20210516085644.13800-1-hdanton@sina.com/
> Now I have more information but still cannot pinpoint the root cause.
> 
> Thanks,
> Hu Weiwen
> 
> 
