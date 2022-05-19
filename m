Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB752DD96
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbiESTQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244564AbiESTQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82AC1ED0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDADE61B94
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527F9C385AA;
        Thu, 19 May 2022 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652987725;
        bh=s4/8PEowr6J9A6sMspKv3h/ZQDfdqAPMOk72yIHs8DI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WQo18kYgKjIv52aKNQmzdItSAoKI4qvfucCXcuS+LiC/YZikUd/HQvCUE6onKUDbG
         SYeXULY2oFnED+53NJBGd7juszKwkW347uuoIgXnefv6X/g3SjiLoAxUkv5lwjxo2B
         iOcgPb6hAs9KDM72KByPIzPauJ92PCZsp6LC7NrNiKsI9COtpUtdzHaXAa35mjGa2O
         fIAxN+lOp1sC4c3qvhaR8aA+ObHLgreRlMDuoM7veoEGX6cS0Suupkic65p4nA/+sT
         loXdLlOj5YzOijZRHxJ5zpRH1hf39OMDoFr3ot5z+M1ggAfEIKclNTFXH00DXb7496
         MH3AezsAwteIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DBBF25C04E0; Thu, 19 May 2022 12:15:24 -0700 (PDT)
Date:   Thu, 19 May 2022 12:15:24 -0700
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
Message-ID: <20220519191524.GC1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220517233507.GA423@qian>
 <20220518125152.GQ3441@techsingularity.net>
 <YoUealVA1bMaSH2l@qian>
 <20220518171503.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YoZGSd6yQL3EP8tk@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZGSd6yQL3EP8tk@qian>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:29:45AM -0400, Qian Cai wrote:
> On Wed, May 18, 2022 at 10:15:03AM -0700, Paul E. McKenney wrote:
> > So does this python script somehow change the tracing state?  (It does
> > not look to me like it does, but I could easily be missing something.)
> 
> No, I don't think so either. It pretty much just offline memory sections
> one at a time.

No idea.

> > Either way, is there something else waiting for these RCU flavors?
> > (There should not be.)  Nevertheless, if so, there should be
> > a synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), or
> > synchronize_rcu_tasks_trace() on some other blocked task's stack
> > somewhere.
> 
> There are only three blocked tasks when this happens. The kmemleak_scan()
> is just the victim waiting for the locks taken by the stucking
> offline_pages()->synchronize_rcu() task.

OK, then I believe that the RCU Tasks flavors were innocent bystanders.

Is the task doing offline_pages()->synchronize_rcu() doing this
repeatedly?  Or is there a stalled RCU grace period?  (From what
I can see, offline_pages() is not doing huge numbers of calls to
synchronize_rcu() in any of its loops, but I freely admit that I do not
know this code.)

If repeatedly, one workaround is to use synchronize_rcu_expedited()
instead of synchronize_rcu().  A better fix might be to batch the
grace periods, so that one RCU grace period serves several page
offline operations.  An alternative better fix might be to use
call_rcu() instead of synchronize_rcu().

>  task:kmemleak        state:D stack:25824 pid: 1033 ppid:     2 flags:0x00000008
>  Call trace:
>   __switch_to
>   __schedule
>   schedule
>   percpu_rwsem_wait
>   __percpu_down_read
>   percpu_down_read.constprop.0
>   get_online_mems

This is read-acquiring the mem_hotplug_lock.  It looks like offline_pages()
write-acquires this same lock.

>   kmemleak_scan
>   kmemleak_scan_thread
>   kthread
>   ret_from_fork
> 
>  task:cppc_fie        state:D stack:23472 pid: 1848 ppid:     2 flags:0x00000008
>  Call trace:
>   __switch_to
>   __schedule
>   lockdep_recursion
> 
>  task:tee             state:D stack:24816 pid:16733 ppid: 16732 flags:0x0000020c
>  Call trace:
>   __switch_to
>   __schedule
>   schedule
>   schedule_timeout
>   __wait_for_common
>   wait_for_completion
>   __wait_rcu_gp
>   synchronize_rcu

So, yes, this is sleeping holding the lock that kmemleak_scan wants to
acquire.

>   lru_cache_disable
>   __alloc_contig_migrate_range
>   isolate_single_pageblock
>   start_isolate_page_range
>   offline_pages
>   memory_subsys_offline
>   device_offline
>   online_store
>   dev_attr_store
>   sysfs_kf_write
>   kernfs_fop_write_iter
>   new_sync_write
>   vfs_write
>   ksys_write
>   __arm64_sys_write
>   invoke_syscall
>   el0_svc_common.constprop.0
>   do_el0_svc
>   el0_svc
>   el0t_64_sync_handler
>   el0t_64_sync
>  
> > Or maybe something sleeps waiting for an RCU Tasks * callback to
> > be invoked.  In that case (and in the above case, for that matter),
> > at least one of these pointers would be non-NULL on some CPU:
> > 
> > 1.	rcu_tasks__percpu.cblist.head
> > 2.	rcu_tasks_rude__percpu.cblist.head
> > 3.	rcu_tasks_trace__percpu.cblist.head
> > 
> > The ->func field of the pointed-to structure contains a pointer to
> > the callback function, which will help work out what is going on.
> > (Most likely a wakeup being lost or not provided.)
> 
> What would be some of the easy ways to find out those? I can't see anything
> interesting from the output of sysrq-t.

Again, I believe that these are victims of circumstance.  Though that does
not explain why revertin those three patches makes things work better.

Or is it possible that reverting those three patches simply decreases
the probability of failure, rather than eliminating the failure?
Such a decrease could be due to many things, for example, changes to
offsets and sizes of data structures.

> > Alternatively, if your system has hundreds of thousands of tasks and
> > you have attached BPF programs to short-lived socket structures and you
> > don't yet have the workaround, then you can see hangs.  (I am working on a
> > longer-term fix.)  In the short term, applying the workaround is the right
> > thing to do.  (Adding a couple of the BPF guys on CC for their thoughts.)
> 
> The system is pretty much idle after a fresh reboot. The only workload is
> to run the script.

Do you ever see RCU CPU stall warnings?

Could you please trace the offline_pages() function?  Is it really stuck,
or is it being invoked periodically during the hang?

							Thanx, Paul
