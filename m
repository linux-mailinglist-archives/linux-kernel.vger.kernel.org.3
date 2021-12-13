Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7943547382A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbhLMW6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbhLMW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:58:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0FC061751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:58:51 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id m15so15801029pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mEeeqeZ1pW2X5fSLHF8m+94TiEKeCgEAUB2QLiOFCBQ=;
        b=ndX8rDBVJOzwfAQdj5jnpFVau17tt9xqqrPU4W9GJ2yxT3HmIfSQV7q1QTiafqBERy
         aNWY27yX9xmvjfccIwxC7X2JCaKtQk3pjwgdn2BSIVNf+dcKM1vpvjKl7nmzStfBYpUp
         w3YOAHKb8SI/enYR1qyDvBnnJmdpmImqKZeoC+fKmS7c/aopIvUyimmTZ0+krlZBvaDH
         3FcOArumDlBm34LwUDHo9bzEBgEdtshSNfyENGa3fZSVNkeZi5q06DzJ6EYF07Z31ziQ
         B/Zr8D8Sb6A+YET9k5yX1JEpmjSHt1I44Tw+rJbdkT1AauGmjBel9g/lCY0EDal9pJSc
         Ln1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=mEeeqeZ1pW2X5fSLHF8m+94TiEKeCgEAUB2QLiOFCBQ=;
        b=66l3T40D6108kWDbOCMxT9/I6KZYs5Wayp7WB/Fp2dEPi4d8TU5WNSN3kVviO7M1nI
         IvYaFOuTLsALeYBgP4KiE1kpx2BBk5Xc+p2ubpg0z63E/5IqWMioKNv6BwmgnQdYay/B
         wEr6/aj/lwNRDuFQl/ThoaT7MGg5CfUo18tHMeZzbA07NHK/e0fzlH2ebKJqelOS+6Jn
         uSuTup0qdQasDdL4DGNMNOR2/9Olsm5bcsJU9pZaN0sNXcHy1ap8PK9jPCygFHYxwQXz
         30hFh5JtRx59BDvSdtmGO2rAnuSv+igGdvJG3ojmnG6J8EkFMrs5eoUNp4IndH9m0Ep4
         WYAg==
X-Gm-Message-State: AOAM532447ENDNJMT+JHOkFyqKjDmKCiLgrrq+ejv4DCA0kZWqmkDAPJ
        ia1tWCrGJ3iMeu4vs4ZEH2s=
X-Google-Smtp-Source: ABdhPJw+ZvORX8PLG4RG7NdakTOSMJX8wvyPxI4s0GIBYiYZ9vg3yOgZPLmgKlZa6cXkhiSjtrJNTg==
X-Received: by 2002:a62:7c4b:0:b0:494:66ab:ae0a with SMTP id x72-20020a627c4b000000b0049466abae0amr986549pfc.18.1639436330485;
        Mon, 13 Dec 2021 14:58:50 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7fed:4a3e:d021:bbd0])
        by smtp.gmail.com with ESMTPSA id 145sm8107574pgd.0.2021.12.13.14.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:58:49 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 13 Dec 2021 14:58:47 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     =?utf-8?B?6IOh546u5paH?= <huww98@outlook.com>
Cc:     =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RFC] mm: introduce page pinner
Message-ID: <YbfQJ0eTkkImUQ/x@google.com>
References: <20211208115250.GA17274@DESKTOP-N4CECTO.huww98.cn>
 <YbD8naaJrZQANahP@google.com>
 <TYCP286MB2066003B2045AD6ABE4C0295C0719@TYCP286MB2066.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCP286MB2066003B2045AD6ABE4C0295C0719@TYCP286MB2066.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:54:24PM +0800, 胡玮文 wrote:
> On Wed, Dec 08, 2021 at 10:42:37AM -0800, Minchan Kim wrote:
> > On Wed, Dec 08, 2021 at 07:54:35PM +0800, 胡玮文 wrote:
> > > On Mon, Dec 06, 2021 at 10:47:30AM -0800, Minchan Kim wrote:
> > > > The contiguous memory allocation fails if one of the pages in
> > > > requested range has unexpected elevated reference count since
> > > > VM couldn't migrate the page out. It's very common pattern for
> > > > CMA allocation failure. The temporal elevated page refcount
> > > > could happen from various places and it's really hard to chase
> > > > who held the temporal page refcount at that time, which is the
> > > > vital information to debug the allocation failure.
> > 
> > Hi,
> > 
> > Please don't cut down original Cc list without special reason.
> 
> Sorry, my school SMTP server does not allow that much recipients. I haved
> changed to outlook.
>  
> > > Hi Minchan,
> > > 
> > > I'm a newbie here. We are debugging a problem where every CPU core is doing
> > > compaction but making no progress, because of the unexpected page refcount. I'm
> > > interested in your approach, but this patch seems only to cover the CMA
> > > allocation path. So could it be extended to debugging migrate failure during
> > > compaction?  I'm not familiar with the kernel codebase, here is my untested
> > > thought:
> > 
> > The compaction failure will produce a lot events I wanted to avoid
> > in my system but I think your case is reasonable if you doesn't
> > mind the large events.
> > 
> > > 
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index cf25b00f03c8..85dacbca8fa0 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -46,6 +46,7 @@
> > >  #include <linux/mmu_notifier.h>
> > >  #include <linux/page_idle.h>
> > >  #include <linux/page_owner.h>
> > > +#include <linux/page_pinner.h>
> > >  #include <linux/sched/mm.h>
> > >  #include <linux/ptrace.h>
> > >  #include <linux/oom.h>
> > > @@ -388,8 +389,10 @@ int folio_migrate_mapping(struct address_space *mapping,
> > >  
> > >         if (!mapping) {
> > >                 /* Anonymous page without mapping */
> > > -               if (folio_ref_count(folio) != expected_count)
> > > +               if (folio_ref_count(folio) != expected_count) {
> > > +                       page_pinner_failure(&folio->page);
> > >                         return -EAGAIN;
> > > +               }
> > >  
> > >                 /* No turning back from here */
> > >                 newfolio->index = folio->index;
> > > @@ -406,6 +409,7 @@ int folio_migrate_mapping(struct address_space *mapping,
> > >         xas_lock_irq(&xas);
> > >         if (!folio_ref_freeze(folio, expected_count)) {
> > >                 xas_unlock_irq(&xas);
> > > +               page_pinner_failure(&folio->page);
> > >                 return -EAGAIN;
> > >         }
> > > 
> > > I'm not sure what to do with the new folio, it seems using folio->page in new
> > > codes is not correct.
> 
> I tested the above proposed patch, it works in my case. But it produces a lot of
> redundant page_pinner_put events. Before the true pinner reveals, the traced
> pages are get and put multiple times. Besides, when passed to
> page_pinner_failure(), the "count" is 3 in my case, any of the 3 holders could
> be the interested pinner. I think this is hard to avoid, and we can just let the
> users distinguish which is the interested pinner. Maybe we need some docs about
> this.

If you run experiement a bit more, you can find what's the most interesting
callsites because usually the other two are would be common path like lru
drainnig or rmap for page migration. Maybe you don't want to pay attention
for them. If they are too nosiy we may introduce some annotation to not
produce events on such callsites optinally. However, let's do not make
thing too complicated from the beginning.

> 
> > If you want to cover compaction only, maybe this one:
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index bfc93da1c2c7..7bfbf7205fb8 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -2400,6 +2400,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
> >                 /* All pages were either migrated or will be released */
> >                 cc->nr_migratepages = 0;
> >                 if (err) {
> > +                       struct page *failed_page;
> > +
> > +                       list_for_each_entry(failed_page, &cc->migratepages, lru)
> > +                               page_pinner_failure(failed_page);
> > +
> >                         putback_movable_pages(&cc->migratepages);
> >                         /*
> >                          * migrate_pages() may return -ENOMEM when scanners meet
> 
> Maybe we should put the page_pinner_failure() calls as close to the real
> refcount check as possible to avoid protential racing and loss some
> page_pinner_put events? Besides, migrate_pages() will retry for 10 times, and I
> image that someone may want to find out who is causing the retry. And migration
> may fail for a number of reason, not only unexpected refcount.

Yeah, I encountered couple of different reasons when I chased down CMA
issues(e.gl., LRU isolation failure) but I wanted to focus page refcount
issue with this page_pinner. I thought each subsystem(cma, compaction,
memory-hotplug, or something of migration users) would have different
requirements/stategey so they would provide their own trace events
for other failure purposes unless it's related to page pinning.

And the page_pinner is already racy since it doesn't take any lock
to mark the failure. So I thought it's not a problem not to close
trigger the trace event from the real refcount check. Since the work
is based on deduction, user should catch it up. Yeah, instead, we could
warn about the race issue into doc for user.

> 
> I image that enabling page pinner for migration senarios other than compaction
> could be helpful for others.

It's not too hard to add new tracepoint in the general migrate_pages so
I want to keep it leave for only alloc_contig user and compaction until
we hear usecases from real users.

> 
> > However, for the case, I want to introduce some filter options like
> > failure reason(?)
> > 
> >     page_pinner_failure(pfn, reason)
> > 
> > So,  I could keep getting only CMA allocation failure events, not
> > compaction failure.
> 
> This is a good idea to me. But how can we implement the filter? Can we reuse the
> trace event filter? i.e., if the page_pinner_failure event is filtered out, then
> we don't set the PAGE_EXT_PINNER flag and effectively also filter the
> corresponding page_pinner_put event out. I can't see whether it is possible now.
> trace_page_pinner_failure() returns void, so it seems we cannot know whether the
> event got through.

We can introduce mutiple failure reports something like debug_page_ref.c

void page_pinner_alloc_contig_failure(struct *page)
{
    if (page_pinner_tracepoint_active(pp_fail_alloc_contig))
        __page_pinner_aloc_contig_failure(page);
}

void __page_pinner_aloc_contig_failure(struct page *page)
{
    trace_pp_alloc_contig_failure(page);
}

void page_pinner_compaction_failure(struct *page)
{
    if (page_pinner_tracepoint_active(pp_fail_compacion))
        __page_pinner_compaction_failure(page);
}

void __page_pinner_compaction_failure(struct page *page)
{
    trace_pp_compaction_failure(page);
}

So admin can enable interested events only.

> 
> If this is not possible, we may need to allocate additional space to store the
> reason for each traced page, and also pass the reason to trace_page_pinner_put().
> 

< snip>

> > > > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > > > index 1e73717802f8..0ad4a3b8f4eb 100644
> > > > --- a/mm/Kconfig.debug
> > > > +++ b/mm/Kconfig.debug
> > > > @@ -62,6 +62,19 @@ config PAGE_OWNER
> > > >  
> > > >  	  If unsure, say N.
> > > >  
> > > > +config PAGE_PINNER
> > > > +	bool "Track page pinner"
> > > > +	select PAGE_EXTENSION
> > > > +	depends on DEBUG_KERNEL && TRACEPOINTS
> > > > +	help
> > > > +	  This keeps track of what call chain is the pinner of a page, may
> > > > +	  help to find contiguos page allocation failure. Even if you include
> > > > +	  this feature in your build, it is disabled by default. You should
> > > > +	  pass "page_pinner=on" to boot parameter in order to enable it. Eats
> > > > +	  a fair amount of memory if enabled.
> > > 
> > > I'm a bit confused. It seems page pinner does not allocate any additional
> > > memory if you enable it by boot parameter. So the description seems inaccurate.
> > 
> > It will allocate page_ext descriptors so consumes the memory.
> 
> Thanks, I see. So it is 8 bytes for each 4k page. Not much I think.

Yub but for someone it's not too small, either considering how often
the problem happen. ;-)

> > > More info about my compaction issue:
> > > 
> > > This call stack returns -EAGAIN in 99.9% cases on the problematic host
> > > (Ubuntu 20.04 with kernel 5.11.0-40):
> > > 
> > > migrate_page_move_mapping (now folio_migrate_mapping) <- returns -EAGAIN
> > > migrate_page
> > > fallback_migrate_page
> > > move_to_new_page
> > > migrate_pages
> > > compact_zone
> > > compact_zone_order
> > > try_to_compact_pages
> > > __alloc_pages_direct_compact
> > > __alloc_pages_slowpath.constprop.0
> > > __alloc_pages_nodemask
> > > alloc_pages_vma
> > > do_huge_pmd_anonymous_page
> > > __handle_mm_fault
> > > handle_mm_fault
> > > do_user_addr_fault
> > > exc_page_fault
> > > asm_exc_page_fault
> > > 
> > > The offending pages are from shm, allocated by mmap() with MAP_SHARED by a
> > > machine learning program. They may have relationships with NVIDIA CUDA, but I
> > > want to confirm this, and make improvements if possible.
> > 
> > So you are suspecting some kernel driver hold a addtional refcount
> > using get_user_pages or page get API?
> 
> Yes. By using the trace events in this patch, I have confirmed it is nvidia
> kernel module that holds the refcount. I got the stacktrace like this (from
> "perf script"):
> 
> cuda-EvtHandlr 31023 [000]  3244.976411:                   page_pinner:page_pinner_put: pfn=0x13e473 flags=0x8001e count=0 mapcount=0 mapping=(nil) mt=1
>         ffffffff82511be4 __page_pinner_put+0x54 (/lib/modules/5.15.6+/build/vmlinux)
>         ffffffff82511be4 __page_pinner_put+0x54 (/lib/modules/5.15.6+/build/vmlinux)
>         ffffffffc0b71e1f os_unlock_user_pages+0xbf ([nvidia])
>         ffffffffc14a4546 _nv032165rm+0x96 ([nvidia])
> 
> Still not much information. NVIDIA does not want me to debug its module. Maybe
> the only thing I can do is reporting this to NVIDIA.

I'm glad that you found the problem using page_pinner and the trace
could help to move them to dig in it. Looks like that it is already
happening.

> 
> > > When the issue reproduce, a single page fault that triggers a sync compaction
> > > can take tens of seconds. Then all 40 CPU threads are doing compaction, and
> > > application runs several order of magnitude slower.
> > > 
> > > Disabling sync compaction is a workaround (the default is "madvise"):
> > > 
> > > echo never > /sys/kernel/mm/transparent_hugepage/defrag
> > > 
> > > Previously I asked for help at https://lore.kernel.org/linux-mm/20210516085644.13800-1-hdanton@sina.com/
> > > Now I have more information but still cannot pinpoint the root cause.
> > > 
> > > Thanks,
> > > Hu Weiwen

Thanks for commenting and shaing your experience, Hu.
