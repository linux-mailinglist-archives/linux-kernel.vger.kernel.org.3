Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD746D312
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhLHMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:16:45 -0500
Received: from aliyun-cloud.icoremail.net ([47.90.88.91]:64955 "HELO
        aliyun-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S231674AbhLHMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:16:44 -0500
X-Greylist: delayed 721 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2021 07:16:43 EST
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [125.216.246.30])
        by main (Coremail) with SMTP id AQAAfwCHZ+DXnLBhMXZfAg--.5086S3;
        Wed, 08 Dec 2021 19:54:00 +0800 (CST)
Date:   Wed, 8 Dec 2021 19:54:35 +0800
From:   =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm: introduce page pinner
Message-ID: <20211208115250.GA17274@DESKTOP-N4CECTO.huww98.cn>
References: <20211206184730.858850-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206184730.858850-1-minchan@kernel.org>
X-CM-TRANSID: AQAAfwCHZ+DXnLBhMXZfAg--.5086S3
X-Coremail-Antispam: 1UD129KBjvAXoW3tFy7Zr17Jr47uw47WFyUWrg_yoW8Ar1kGo
        Z7tF4IgF4xJr1DZ3W7Cr12y3WDXa4qgFWfJr15Zr4DGF9Fv34UCa42ka1qqa4UGF4rtrWr
        G34xZ3yjqayjqr93n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUY17k0a2IF6w4kM7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
        1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0
        I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW8KwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUyb_TUUUUU
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAGBlepTBsvXgAHse
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:47:30AM -0800, Minchan Kim wrote:
> The contiguous memory allocation fails if one of the pages in
> requested range has unexpected elevated reference count since
> VM couldn't migrate the page out. It's very common pattern for
> CMA allocation failure. The temporal elevated page refcount
> could happen from various places and it's really hard to chase
> who held the temporal page refcount at that time, which is the
> vital information to debug the allocation failure.

Hi Minchan,

I'm a newbie here. We are debugging a problem where every CPU core is doing
compaction but making no progress, because of the unexpected page refcount. I'm
interested in your approach, but this patch seems only to cover the CMA
allocation path. So could it be extended to debugging migrate failure during
compaction?  I'm not familiar with the kernel codebase, here is my untested
thought:

diff --git a/mm/migrate.c b/mm/migrate.c
index cf25b00f03c8..85dacbca8fa0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -46,6 +46,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/page_owner.h>
+#include <linux/page_pinner.h>
 #include <linux/sched/mm.h>
 #include <linux/ptrace.h>
 #include <linux/oom.h>
@@ -388,8 +389,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 
        if (!mapping) {
                /* Anonymous page without mapping */
-               if (folio_ref_count(folio) != expected_count)
+               if (folio_ref_count(folio) != expected_count) {
+                       page_pinner_failure(&folio->page);
                        return -EAGAIN;
+               }
 
                /* No turning back from here */
                newfolio->index = folio->index;
@@ -406,6 +409,7 @@ int folio_migrate_mapping(struct address_space *mapping,
        xas_lock_irq(&xas);
        if (!folio_ref_freeze(folio, expected_count)) {
                xas_unlock_irq(&xas);
+               page_pinner_failure(&folio->page);
                return -EAGAIN;
        }

I'm not sure what to do with the new folio, it seems using folio->page in new
codes is not correct.
 
> This patch introduces page pinner to keep track of Page Pinner
> who caused the CMA allocation failure. How page pinner work is
> once VM found the non-migrated page after trying migration
> during contiguos allocation, it marks the page and every page-put
> operation on the page since then will have event trace. Since
> page-put is always with page-get, the page-put event trace helps
> to deduce where the pair page-get originated from.
> 
> The reason why the feature tracks page-put instead of page-get
> indirectly is that since VM couldn't expect when page migration
> fails, it should keep track of every page-get for migratable page
> to dump information at failure. Considering backtrace as vitial
> information as well as page's get/put is one of hottest path,
> it's too heavy approach. Thus, to minimize runtime overhead,
> this feature adds a new PAGE_EXT_PINNER flag under PAGE_EXT
> debugging option to indicate migration-failed page and only
> tracks every page-put operation for the page since the failure.
> 
> usage:
> 
> trace_dir="/sys/kernel/tracing"
> echo 1 > $trace_dir/events/page_pinner/enable
> echo 1 > $trace_dir/options/stacktrace
> ..
> run workload
> ..
> ..
> 
> cat $trace_dir/trace
> 
>            <...>-498     [006] .... 33306.301621: page_pinner_failure: pfn=0x9f0bb0 flags=uptodate|lru|swapbacked count=1 mapcount=0 mapping=00000000aec7812a mt=5
>            <...>-498     [006] .... 33306.301625: <stack trace>
>  => __page_pinner_failure
>  => test_pages_isolated
>  => alloc_contig_range
>  => cma_alloc
>  => cma_heap_allocate
>  => dma_heap_ioctl
>  => __arm64_sys_ioctl
>  => el0_svc_common
>  => do_el0_svc
>  => el0_svc
>  => el0_sync_handler
>  => el0_sync
>            <...>-24965   [001] .... 33306.392836: page_pinner_put: pfn=0x9f0bb0 flags=uptodate|lru|swapbacked count=0 mapcount=0 mapping=00000000aec7812a mt=5
>            <...>-24965   [001] .... 33306.392846: <stack trace>
>  => __page_pinner_put
>  => release_pages
>  => free_pages_and_swap_cache
>  => tlb_flush_mmu_free
>  => tlb_flush_mmu
>  => zap_pte_range
>  => unmap_page_range
>  => unmap_vmas
>  => exit_mmap
>  => __mmput
>  => mmput
>  => exit_mm
>  => do_exit
>  => do_group_exit
>  => get_signal
>  => do_signal
>  => do_notify_resume
>  => work_pending
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> The PagePinner named after PageOwner since I wanted to keep track of
> page refcount holder. Feel free to suggest better names.
> Actually, I had alloc_contig_failure tracker as a candidate.
> 
>  include/linux/mm.h                 |  7 ++-
>  include/linux/page_ext.h           |  3 +
>  include/linux/page_pinner.h        | 47 ++++++++++++++++
>  include/trace/events/page_pinner.h | 60 ++++++++++++++++++++
>  mm/Kconfig.debug                   | 13 +++++
>  mm/Makefile                        |  1 +
>  mm/page_alloc.c                    |  3 +
>  mm/page_ext.c                      |  4 ++
>  mm/page_isolation.c                |  3 +
>  mm/page_pinner.c                   | 90 ++++++++++++++++++++++++++++++
>  10 files changed, 230 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/page_pinner.h
>  create mode 100644 include/trace/events/page_pinner.h
>  create mode 100644 mm/page_pinner.c
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 73a52aba448f..a640cae593f9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -26,6 +26,7 @@
>  #include <linux/err.h>
>  #include <linux/page-flags.h>
>  #include <linux/page_ref.h>
> +#include <linux/page_pinner.h>
>  #include <linux/memremap.h>
>  #include <linux/overflow.h>
>  #include <linux/sizes.h>
> @@ -744,8 +745,12 @@ struct inode;
>   */
>  static inline int put_page_testzero(struct page *page)
>  {
> +	int ret;
> +
>  	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
> -	return page_ref_dec_and_test(page);
> +	ret = page_ref_dec_and_test(page);
> +	page_pinner_put(page);
> +	return ret;
>  }
>  
>  /*
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index fabb2e1e087f..561d8458dc5a 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -23,6 +23,9 @@ enum page_ext_flags {
>  	PAGE_EXT_YOUNG,
>  	PAGE_EXT_IDLE,
>  #endif
> +#if defined(CONFIG_PAGE_PINNER)
> +	PAGE_EXT_PINNER,
> +#endif
>  };
>  
>  /*
> diff --git a/include/linux/page_pinner.h b/include/linux/page_pinner.h
> new file mode 100644
> index 000000000000..3f93a753b8e0
> --- /dev/null
> +++ b/include/linux/page_pinner.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_PAGE_PINNER_H
> +#define __LINUX_PAGE_PINNER_H
> +
> +#include <linux/jump_label.h>
> +
> +#ifdef CONFIG_PAGE_PINNER
> +extern struct static_key_false page_pinner_inited;
> +extern struct page_ext_operations page_pinner_ops;
> +
> +void __page_pinner_failure(struct page *page);
> +void __page_pinner_put(struct page *page);
> +void __reset_page_pinner(struct page *page, unsigned int order);
> +
> +static inline void reset_page_pinner(struct page *page, unsigned int order)
> +{
> +	if (static_branch_unlikely(&page_pinner_inited))
> +		__reset_page_pinner(page, order);
> +}
> +
> +static inline void page_pinner_failure(struct page *page)
> +{
> +	if (!static_branch_unlikely(&page_pinner_inited))
> +		return;
> +
> +	__page_pinner_failure(page);
> +}
> +
> +static inline void page_pinner_put(struct page *page)
> +{
> +	if (!static_branch_unlikely(&page_pinner_inited))
> +		return;
> +
> +	__page_pinner_put(page);
> +}
> +#else
> +static inline void reset_page_pinner(struct page *page, unsigned int order)
> +{
> +}
> +static inline void page_pinner_failure(struct page *page)
> +{
> +}
> +static inline void page_pinner_put(struct page *page)
> +{
> +}
> +#endif /* CONFIG_PAGE_PINNER */
> +#endif /* __LINUX_PAGE_PINNER_H */
> diff --git a/include/trace/events/page_pinner.h b/include/trace/events/page_pinner.h
> new file mode 100644
> index 000000000000..69ccd5c30f66
> --- /dev/null
> +++ b/include/trace/events/page_pinner.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM page_pinner
> +
> +#if !defined(_TRACE_PAGE_PINNER_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PAGE_PINNER_H
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +#include <trace/events/mmflags.h>
> +
> +DECLARE_EVENT_CLASS(page_pinner_template,
> +
> +	TP_PROTO(struct page *page),
> +
> +	TP_ARGS(page),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, pfn)
> +		__field(unsigned long, flags)
> +		__field(int, count)
> +		__field(int, mapcount)
> +		__field(void *, mapping)
> +		__field(int, mt)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pfn = page_to_pfn(page);
> +		__entry->flags = page->flags;
> +		__entry->count = page_ref_count(page);
> +		__entry->mapcount = page_mapcount(page);
> +		__entry->mapping = page->mapping;
> +		__entry->mt = get_pageblock_migratetype(page);
> +	),
> +
> +	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d",
> +		__entry->pfn,
> +		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> +		__entry->count,
> +		__entry->mapcount, __entry->mapping, __entry->mt)
> +);
> +
> +DEFINE_EVENT(page_pinner_template, page_pinner_failure,
> +
> +	TP_PROTO(struct page *page),
> +
> +	TP_ARGS(page)
> +);
> +
> +DEFINE_EVENT(page_pinner_template, page_pinner_put,
> +
> +	TP_PROTO(struct page *page),
> +
> +	TP_ARGS(page)
> +);
> +
> +#endif /* _TRACE_PAGE_PINNER_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 1e73717802f8..0ad4a3b8f4eb 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -62,6 +62,19 @@ config PAGE_OWNER
>  
>  	  If unsure, say N.
>  
> +config PAGE_PINNER
> +	bool "Track page pinner"
> +	select PAGE_EXTENSION
> +	depends on DEBUG_KERNEL && TRACEPOINTS
> +	help
> +	  This keeps track of what call chain is the pinner of a page, may
> +	  help to find contiguos page allocation failure. Even if you include
> +	  this feature in your build, it is disabled by default. You should
> +	  pass "page_pinner=on" to boot parameter in order to enable it. Eats
> +	  a fair amount of memory if enabled.

I'm a bit confused. It seems page pinner does not allocate any additional
memory if you enable it by boot parameter. So the description seems inaccurate.

> +
> +	  If unsure, say N.
> +
>  config PAGE_POISONING
>  	bool "Poison pages after freeing"
>  	help
> diff --git a/mm/Makefile b/mm/Makefile
> index fc60a40ce954..0c9b78b15070 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
>  obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
>  obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
>  obj-$(CONFIG_PAGE_OWNER) += page_owner.o
> +obj-$(CONFIG_PAGE_PINNER) += page_pinner.o
>  obj-$(CONFIG_CLEANCACHE) += cleancache.o
>  obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
>  obj-$(CONFIG_ZPOOL)	+= zpool.o
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f41a5e990ac0..6e3a6f875a40 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -63,6 +63,7 @@
>  #include <linux/sched/rt.h>
>  #include <linux/sched/mm.h>
>  #include <linux/page_owner.h>
> +#include <linux/page_pinner.h>
>  #include <linux/kthread.h>
>  #include <linux/memcontrol.h>
>  #include <linux/ftrace.h>
> @@ -1299,6 +1300,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  		if (memcg_kmem_enabled() && PageMemcgKmem(page))
>  			__memcg_kmem_uncharge_page(page, order);
>  		reset_page_owner(page, order);
> +		reset_page_pinner(page, order);
>  		return false;
>  	}
>  
> @@ -1338,6 +1340,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	page_cpupid_reset_last(page);
>  	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>  	reset_page_owner(page, order);
> +	reset_page_pinner(page, order);
>  
>  	if (!PageHighMem(page)) {
>  		debug_check_no_locks_freed(page_address(page),
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 2a52fd9ed464..0dafe968b212 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -8,6 +8,7 @@
>  #include <linux/kmemleak.h>
>  #include <linux/page_owner.h>
>  #include <linux/page_idle.h>
> +#include <linux/page_pinner.h>
>  
>  /*
>   * struct page extension
> @@ -75,6 +76,9 @@ static struct page_ext_operations *page_ext_ops[] = {
>  #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
>  	&page_idle_ops,
>  #endif
> +#ifdef CONFIG_PAGE_PINNER
> +	&page_pinner_ops,
> +#endif
>  };
>  
>  unsigned long page_ext_size = sizeof(struct page_ext);
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index a95c2c6562d0..a9ddea1c9166 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -9,6 +9,7 @@
>  #include <linux/memory.h>
>  #include <linux/hugetlb.h>
>  #include <linux/page_owner.h>
> +#include <linux/page_pinner.h>
>  #include <linux/migrate.h>
>  #include "internal.h"
>  
> @@ -310,6 +311,8 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  
>  out:
>  	trace_test_pages_isolated(start_pfn, end_pfn, pfn);
> +	if (ret < 0)
> +		page_pinner_failure(pfn_to_page(pfn));
>  
>  	return ret;
>  }
> diff --git a/mm/page_pinner.c b/mm/page_pinner.c
> new file mode 100644
> index 000000000000..300a90647557
> --- /dev/null
> +++ b/mm/page_pinner.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/mm.h>
> +#include <linux/page_pinner.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/page_pinner.h>
> +
> +static bool page_pinner_enabled;
> +DEFINE_STATIC_KEY_FALSE(page_pinner_inited);
> +EXPORT_SYMBOL(page_pinner_inited);
> +
> +static int __init early_page_pinner_param(char *buf)
> +{
> +	return kstrtobool(buf, &page_pinner_enabled);
> +}
> +early_param("page_pinner", early_page_pinner_param);
> +
> +static bool need_page_pinner(void)
> +{
> +	return page_pinner_enabled;
> +}
> +
> +static void init_page_pinner(void)
> +{
> +	if (!page_pinner_enabled)
> +		return;
> +
> +	static_branch_enable(&page_pinner_inited);
> +}
> +
> +struct page_ext_operations page_pinner_ops = {
> +	.need = need_page_pinner,
> +	.init = init_page_pinner,
> +};
> +
> +void __reset_page_pinner(struct page *page, unsigned int order)
> +{
> +	struct page_ext *page_ext;
> +	int i;
> +
> +	page_ext = lookup_page_ext(page);
> +	if (unlikely(!page_ext))
> +		return;
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		if (!test_bit(PAGE_EXT_PINNER, &page_ext->flags))
> +			break;
> +
> +		clear_bit(PAGE_EXT_PINNER, &page_ext->flags);
> +		page_ext = page_ext_next(page_ext);
> +	}
> +}
> +
> +void __page_pinner_failure(struct page *page)
> +{
> +	struct page_ext *page_ext = lookup_page_ext(page);
> +
> +	if (unlikely(!page_ext))
> +		return;
> +
> +	trace_page_pinner_failure(page);
> +	test_and_set_bit(PAGE_EXT_PINNER, &page_ext->flags);
> +}
> +
> +void __page_pinner_put(struct page *page)
> +{
> +	struct page_ext *page_ext = lookup_page_ext(page);
> +
> +	if (unlikely(!page_ext))
> +		return;
> +
> +	if (!test_bit(PAGE_EXT_PINNER, &page_ext->flags))
> +		return;
> +
> +	trace_page_pinner_put(page);
> +}
> +EXPORT_SYMBOL(__page_pinner_put);
> +
> +
> +static int __init page_pinner_init(void)
> +{
> +	if (!static_branch_unlikely(&page_pinner_inited)) {
> +		pr_info("page_pinner is disabled\n");
> +		return 0;
> +	}
> +
> +	pr_info("page_pinner is enabled\n");
> +	return 0;
> +}
> +late_initcall(page_pinner_init)
> -- 
> 2.34.1.400.ga245620fadb-goog
> 

More info about my compaction issue:

This call stack returns -EAGAIN in 99.9% cases on the problematic host
(Ubuntu 20.04 with kernel 5.11.0-40):

migrate_page_move_mapping (now folio_migrate_mapping) <- returns -EAGAIN
migrate_page
fallback_migrate_page
move_to_new_page
migrate_pages
compact_zone
compact_zone_order
try_to_compact_pages
__alloc_pages_direct_compact
__alloc_pages_slowpath.constprop.0
__alloc_pages_nodemask
alloc_pages_vma
do_huge_pmd_anonymous_page
__handle_mm_fault
handle_mm_fault
do_user_addr_fault
exc_page_fault
asm_exc_page_fault

The offending pages are from shm, allocated by mmap() with MAP_SHARED by a
machine learning program. They may have relationships with NVIDIA CUDA, but I
want to confirm this, and make improvements if possible.

When the issue reproduce, a single page fault that triggers a sync compaction
can take tens of seconds. Then all 40 CPU threads are doing compaction, and
application runs several order of magnitude slower.

Disabling sync compaction is a workaround (the default is "madvise"):

echo never > /sys/kernel/mm/transparent_hugepage/defrag

Previously I asked for help at https://lore.kernel.org/linux-mm/20210516085644.13800-1-hdanton@sina.com/
Now I have more information but still cannot pinpoint the root cause.

Thanks,
Hu Weiwen

