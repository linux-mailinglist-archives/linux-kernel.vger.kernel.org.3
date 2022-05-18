Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5495A52C194
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiERRPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbiERRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DA1A359C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77D126176F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD96C385A5;
        Wed, 18 May 2022 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652894103;
        bh=6eLnhzSjpe2dnWiv6MP9U3c35Rk2zMADFitpVDWmurg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kYzs+A/4KS1hV3F3qZWcrmi9scPbnFJgD5z8UmSgEFpJciQhiE8fW2KVO2qWQu1as
         rGRRvmr6aiS3UjDjD3gdabSuR8DT6uoL+zLkYOJbfmE1qCydo3ogbwDZ1tXY6EE8P1
         Qy19MuTF+BxCfNvxXygGQgyRs0BLOjArBh8+Vs0vgOASCHg3S6/521p9595Z1RJga3
         NGqLXDgglpG0HvQXxfrSyESZvdaKCsj2kezszRLibXOa3NZNJPpMZo7BiGwvn0yTTo
         FlTwMV/60iDtj8hAcpK/XPYJcdBXBsqjzJd7Dwvnrt/2GlfgHitbO8v1P2PSPQc5ay
         SEBpL8ZvPGwVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7EBCF5C042D; Wed, 18 May 2022 10:15:03 -0700 (PDT)
Date:   Wed, 18 May 2022 10:15:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kafai@fb.com, kpsingh@kernel.org
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <20220518171503.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220517233507.GA423@qian>
 <20220518125152.GQ3441@techsingularity.net>
 <YoUealVA1bMaSH2l@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUealVA1bMaSH2l@qian>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:27:22PM -0400, Qian Cai wrote:
> On Wed, May 18, 2022 at 01:51:52PM +0100, Mel Gorman wrote:
> > On Tue, May 17, 2022 at 07:35:07PM -0400, Qian Cai wrote:
> > > On Thu, May 12, 2022 at 09:50:37AM +0100, Mel Gorman wrote:
> > > > Changelog since v2
> > > > o More conversions from page->lru to page->[pcp_list|buddy_list]
> > > > o Additional test results in changelogs
> > > > 
> > > > Changelog since v1
> > > > o Fix unsafe RT locking scheme
> > > > o Use spin_trylock on UP PREEMPT_RT
> > > > 
> > > > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > > > per-cpu lists drain support" -- avoid interference of a high priority
> > > > task due to a workqueue item draining per-cpu page lists. While many
> > > > workloads can tolerate a brief interruption, it may be cause a real-time
> > > > task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> > > > the draining in non-deterministic.
> > > > 
> > > > Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> > > > The local_lock on its own prevents migration and the IRQ disabling protects
> > > > from corruption due to an interrupt arriving while a page allocation is
> > > > in progress. The locking is inherently unsafe for remote access unless
> > > > the CPU is hot-removed.
> > > > 
> > > > This series adjusts the locking. A spinlock is added to struct
> > > > per_cpu_pages to protect the list contents while local_lock_irq continues
> > > > to prevent migration and IRQ reentry. This allows a remote CPU to safely
> > > > drain a remote per-cpu list.
> > > > 
> > > > This series is a partial series. Follow-on work should allow the
> > > > local_irq_save to be converted to a local_irq to avoid IRQs being
> > > > disabled/enabled in most cases. Consequently, there are some TODO comments
> > > > highlighting the places that would change if local_irq was used. However,
> > > > there are enough corner cases that it deserves a series on its own
> > > > separated by one kernel release and the priority right now is to avoid
> > > > interference of high priority tasks.
> > > 
> > > Reverting the whole series fixed an issue that offlining a memory
> > > section blocking for hours on today's linux-next tree.
> > > 
> > >  __wait_rcu_gp
> > >  synchronize_rcu at kernel/rcu/tree.c:3915
> > >  lru_cache_disable at mm/swap.c:886
> > >  __alloc_contig_migrate_range at mm/page_alloc.c:9078
> > >  isolate_single_pageblock at mm/page_isolation.c:405
> > >  start_isolate_page_range
> > >  offline_pages
> > >  memory_subsys_offline
> > >  device_offline
> > >  online_store
> > >  dev_attr_store
> > >  sysfs_kf_write
> > >  kernfs_fop_write_iter
> > >  new_sync_write
> > >  vfs_write
> > >  ksys_write
> > >  __arm64_sys_write
> > >  invoke_syscall
> > >  el0_svc_common.constprop.0
> > >  do_el0_svc
> > >  el0_svc
> > >  el0t_64_sync_handler
> > >  el0t_64_sync
> > > 
> > > For full disclosure, I have also reverted the commit 0d523026abd4
> > > ("mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked()"), so the
> > > series can be reverted cleanly. But, I can't see how the commit
> > > 0d523026abd4 could cause this issue at all.
> > 
> > This is halting in __lru_add_drain_all where it calls synchronize_rcu
> > before the drain even happens. It's also an LRU drain and not PCP which
> > is what the series affects and the allocator doesn't use rcu. In a KVM
> > machine, I can do
> > 
> > $ for BANK in `(for i in {1..20}; do echo $((RANDOM%416)); done) | sort -n  | uniq`; do BEFORE=`cat /sys/devices/system/memory/memory$BANK/online`; echo 0 > /sys/devices/system/memory/memory$BANK/online; AFTER=`cat /sys/devices/system/memory/memory$BANK/online`; printf "%4d %d -> %d\n" $BANK $BEFORE $AFTER; done
> >    3 1 -> 0
> >   57 1 -> 0
> >   74 1 -> 0
> >   93 1 -> 0
> >  101 1 -> 0
> >  128 1 -> 0
> >  133 1 -> 0
> >  199 1 -> 0
> >  223 1 -> 0
> >  225 1 -> 0
> >  229 1 -> 0
> >  243 1 -> 0
> >  263 1 -> 0
> >  300 1 -> 0
> >  309 1 -> 0
> >  329 1 -> 0
> >  355 1 -> 0
> >  365 1 -> 0
> >  372 1 -> 0
> >  383 1 -> 0
> > 
> > It offlines 20 sections although after several attempts free -m starts
> > reporting negative used memory so there is a bug of some description.
> > How are you testing this exactly? Is it every time or intermittent? Are
> > you confident that reverting the series makes the problem go away?
> 
> Cc'ing Paul. Either reverting this series or Paul's 3 patches below from
> today's linux-next tree fixed the issue.
> 
> ca52639daa5b rcu-tasks: Drive synchronous grace periods from calling task
> 89ad98e93ce8 rcu-tasks: Move synchronize_rcu_tasks_generic() down
> 0d90e7225fb1 rcu-tasks: Split rcu_tasks_one_gp() from rcu_tasks_kthread()
> 
> It was reproduced by running this script below on an arm64 server. I can
> reproduce it every time within 5 attempts. I noticed that when it happens,
> we have a few rcu kthreads all are stuck in this line,
> 
>         rcuwait_wait_event(&rtp->cbs_wait,
>                            (needgpcb = rcu_tasks_need_gpcb(rtp)),
>                            TASK_IDLE);
> 
> rcu_tasks_kthread
> rcu_tasks_rude_kthread
> [rcu_tasks_trace_kthread

This is the normal state of these kthreads when there is nothing for
them to do.

And unless you are removing tracing trampolines (kprobes, ftrace, BPF),
there should be nothing for them to do.

So does this python script somehow change the tracing state?  (It does
not look to me like it does, but I could easily be missing something.)

Either way, is there something else waiting for these RCU flavors?
(There should not be.)  Nevertheless, if so, there should be
a synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), or
synchronize_rcu_tasks_trace() on some other blocked task's stack
somewhere.

Or maybe something sleeps waiting for an RCU Tasks * callback to
be invoked.  In that case (and in the above case, for that matter),
at least one of these pointers would be non-NULL on some CPU:

1.	rcu_tasks__percpu.cblist.head
2.	rcu_tasks_rude__percpu.cblist.head
3.	rcu_tasks_trace__percpu.cblist.head

The ->func field of the pointed-to structure contains a pointer to
the callback function, which will help work out what is going on.
(Most likely a wakeup being lost or not provided.)

Alternatively, if your system has hundreds of thousands of tasks and
you have attached BPF programs to short-lived socket structures and you
don't yet have the workaround, then you can see hangs.  (I am working on a
longer-term fix.)  In the short term, applying the workaround is the right
thing to do.  (Adding a couple of the BPF guys on CC for their thoughts.)

Does any of that help?

							Thanx, Paul

> #!/usr/bin/env python3
> # SPDX-License-Identifier: GPL-2.0
> 
> import os
> import re
> import subprocess
> 
> 
> def mem_iter():
>     base_dir = '/sys/devices/system/memory/'
>     for curr_dir in os.listdir(base_dir):
>         if re.match(r'memory\d+', curr_dir):
>             yield base_dir + curr_dir
> 
> 
> if __name__ == '__main__':
>     print('- Try to remove each memory section and then add it back.')
>     for mem_dir in mem_iter():
>         status = f'{mem_dir}/online'
>         if open(status).read().rstrip() == '1':
>             # This could expectedly fail due to many reasons.
>             section = os.path.basename(mem_dir)
>             print(f'- Try to remove {section}.')
>             proc = subprocess.run([f'echo 0 | sudo tee {status}'], shell=True)
>             if proc.returncode == 0:
>                 print(f'- Try to add {section}.')
>                 subprocess.check_call([f'echo 1 | sudo tee {status}'], shell=True)
> 
