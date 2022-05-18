Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736AD52BC61
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiERMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbiERMwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:52:00 -0400
Received: from outbound-smtp25.blacknight.com (outbound-smtp25.blacknight.com [81.17.249.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB3218E19
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:51:57 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 90070CAB78
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:51:55 +0100 (IST)
Received: (qmail 19066 invoked from network); 18 May 2022 12:51:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 May 2022 12:51:54 -0000
Date:   Wed, 18 May 2022 13:51:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <20220518125152.GQ3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220517233507.GA423@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220517233507.GA423@qian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 07:35:07PM -0400, Qian Cai wrote:
> On Thu, May 12, 2022 at 09:50:37AM +0100, Mel Gorman wrote:
> > Changelog since v2
> > o More conversions from page->lru to page->[pcp_list|buddy_list]
> > o Additional test results in changelogs
> > 
> > Changelog since v1
> > o Fix unsafe RT locking scheme
> > o Use spin_trylock on UP PREEMPT_RT
> > 
> > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > per-cpu lists drain support" -- avoid interference of a high priority
> > task due to a workqueue item draining per-cpu page lists. While many
> > workloads can tolerate a brief interruption, it may be cause a real-time
> > task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> > the draining in non-deterministic.
> > 
> > Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> > The local_lock on its own prevents migration and the IRQ disabling protects
> > from corruption due to an interrupt arriving while a page allocation is
> > in progress. The locking is inherently unsafe for remote access unless
> > the CPU is hot-removed.
> > 
> > This series adjusts the locking. A spinlock is added to struct
> > per_cpu_pages to protect the list contents while local_lock_irq continues
> > to prevent migration and IRQ reentry. This allows a remote CPU to safely
> > drain a remote per-cpu list.
> > 
> > This series is a partial series. Follow-on work should allow the
> > local_irq_save to be converted to a local_irq to avoid IRQs being
> > disabled/enabled in most cases. Consequently, there are some TODO comments
> > highlighting the places that would change if local_irq was used. However,
> > there are enough corner cases that it deserves a series on its own
> > separated by one kernel release and the priority right now is to avoid
> > interference of high priority tasks.
> 
> Reverting the whole series fixed an issue that offlining a memory
> section blocking for hours on today's linux-next tree.
> 
>  __wait_rcu_gp
>  synchronize_rcu at kernel/rcu/tree.c:3915
>  lru_cache_disable at mm/swap.c:886
>  __alloc_contig_migrate_range at mm/page_alloc.c:9078
>  isolate_single_pageblock at mm/page_isolation.c:405
>  start_isolate_page_range
>  offline_pages
>  memory_subsys_offline
>  device_offline
>  online_store
>  dev_attr_store
>  sysfs_kf_write
>  kernfs_fop_write_iter
>  new_sync_write
>  vfs_write
>  ksys_write
>  __arm64_sys_write
>  invoke_syscall
>  el0_svc_common.constprop.0
>  do_el0_svc
>  el0_svc
>  el0t_64_sync_handler
>  el0t_64_sync
> 
> For full disclosure, I have also reverted the commit 0d523026abd4
> ("mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked()"), so the
> series can be reverted cleanly. But, I can't see how the commit
> 0d523026abd4 could cause this issue at all.

This is halting in __lru_add_drain_all where it calls synchronize_rcu
before the drain even happens. It's also an LRU drain and not PCP which
is what the series affects and the allocator doesn't use rcu. In a KVM
machine, I can do

$ for BANK in `(for i in {1..20}; do echo $((RANDOM%416)); done) | sort -n  | uniq`; do BEFORE=`cat /sys/devices/system/memory/memory$BANK/online`; echo 0 > /sys/devices/system/memory/memory$BANK/online; AFTER=`cat /sys/devices/system/memory/memory$BANK/online`; printf "%4d %d -> %d\n" $BANK $BEFORE $AFTER; done
   3 1 -> 0
  57 1 -> 0
  74 1 -> 0
  93 1 -> 0
 101 1 -> 0
 128 1 -> 0
 133 1 -> 0
 199 1 -> 0
 223 1 -> 0
 225 1 -> 0
 229 1 -> 0
 243 1 -> 0
 263 1 -> 0
 300 1 -> 0
 309 1 -> 0
 329 1 -> 0
 355 1 -> 0
 365 1 -> 0
 372 1 -> 0
 383 1 -> 0

It offlines 20 sections although after several attempts free -m starts
reporting negative used memory so there is a bug of some description.
How are you testing this exactly? Is it every time or intermittent? Are
you confident that reverting the series makes the problem go away?

-- 
Mel Gorman
SUSE Labs
