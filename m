Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B818B58212B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiG0Hel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiG0Heh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:34:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E77422DD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658907273; x=1690443273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zkWtaFjvHO+h70yxBl/vZPnpQu6YsT2P4TacQ7mT4kI=;
  b=qjwkT5uE55ieyqyxLlLQ8iXkc0fR6Bm3+Y+ODnGQDCHJtt+SbdgZvm2W
   oJ6ya3N1kp0fGil7YBoT1RvYjt+CPquyFSc6svBJOkjONFQhCeN/nw7EX
   QCy/Ct5EN2aFsHiq04bvnbxwXgXy8k2heRX1oRvgouhg0m78GcTXEeQSl
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 27 Jul 2022 00:34:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:34:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 00:34:31 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 00:34:24 -0700
Date:   Wed, 27 Jul 2022 13:04:20 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Michel Lespinasse <michel@lespinasse.org>
CC:     Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>, <kernel-team@fb.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Andy Lutomirski" <luto@kernel.org>
Subject: Re: [PATCH v2 23/35] mm: add mmu_notifier_lock
Message-ID: <20220727073420.GA8985@hu-pkondeti-hyd.qualcomm.com>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-24-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220128131006.67712-24-michel@lespinasse.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:09:54AM -0800, Michel Lespinasse wrote:
> Introduce mmu_notifier_lock as a per-mm percpu_rw_semaphore,
> as well as the code to initialize and destroy it together with the mm.
> 
> This lock will be used to prevent races between mmu_notifier_register()
> and speculative fault handlers that need to fire MMU notifications
> without holding any of the mmap or rmap locks.
> 
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  include/linux/mm_types.h     |  6 +++++-
>  include/linux/mmu_notifier.h | 27 +++++++++++++++++++++++++--
>  kernel/fork.c                |  3 ++-
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 305f05d2a4bc..f77e2dec038d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -462,6 +462,7 @@ struct vm_area_struct {
>  } __randomize_layout;
>  
>  struct kioctx_table;
> +struct percpu_rw_semaphore;
>  struct mm_struct {
>  	struct {
>  		struct vm_area_struct *mmap;		/* list of VMAs */
> @@ -608,7 +609,10 @@ struct mm_struct {
>  		struct file __rcu *exe_file;
>  #ifdef CONFIG_MMU_NOTIFIER
>  		struct mmu_notifier_subscriptions *notifier_subscriptions;
> -#endif
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +		struct percpu_rw_semaphore *mmu_notifier_lock;
> +#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
> +#endif	/* CONFIG_MMU_NOTIFIER */
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
>  		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
>  #endif
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 45fc2c81e370..ace76fe91c0c 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -6,6 +6,8 @@
>  #include <linux/spinlock.h>
>  #include <linux/mm_types.h>
>  #include <linux/mmap_lock.h>
> +#include <linux/percpu-rwsem.h>
> +#include <linux/slab.h>
>  #include <linux/srcu.h>
>  #include <linux/interval_tree.h>
>  
> @@ -499,15 +501,35 @@ static inline void mmu_notifier_invalidate_range(struct mm_struct *mm,
>  		__mmu_notifier_invalidate_range(mm, start, end);
>  }
>  
> -static inline void mmu_notifier_subscriptions_init(struct mm_struct *mm)
> +static inline bool mmu_notifier_subscriptions_init(struct mm_struct *mm)
>  {
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	mm->mmu_notifier_lock = kzalloc(sizeof(struct percpu_rw_semaphore), GFP_KERNEL);
> +	if (!mm->mmu_notifier_lock)
> +		return false;
> +	if (percpu_init_rwsem(mm->mmu_notifier_lock)) {
> +		kfree(mm->mmu_notifier_lock);
> +		return false;
> +	}
> +#endif
> +
>  	mm->notifier_subscriptions = NULL;
> +	return true;
>  }
>  
>  static inline void mmu_notifier_subscriptions_destroy(struct mm_struct *mm)
>  {
>  	if (mm_has_notifiers(mm))
>  		__mmu_notifier_subscriptions_destroy(mm);
> +
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	if (!in_atomic()) {
> +		percpu_free_rwsem(mm->mmu_notifier_lock);
> +		kfree(mm->mmu_notifier_lock);
> +	} else {
> +		percpu_rwsem_async_destroy(mm->mmu_notifier_lock);
> +	}
> +#endif
>  }
>  

We have received a bug report from our customer running Android GKI kernel
android-13-5.15 branch where this series is included. As the callstack [1]
indicates, the non-atomic test it self is not sufficient to free the percpu
rwsem. 

The scenario deduced from the callstack:

- context switch on CPU#0 from 'A' to idle. idle thread took A's mm

- 'A' later ran on another CPU and exited. A's mm has still reference.

- Now CPU#0 is being hotplugged out. As part of this, idle thread's
mm is switched (in idle_task_exit()) but its active_mm freeing is
deferred to finish_cpu() which gets called later from the control processor
(the thread which initiated the CPU hotplug). Please see the reasoning
on why mmdrop() is not called in idle_task_exit() at
commit bf2c59fce4074('sched/core: Fix illegal RCU from offline CPUs')

- Now when finish_cpu() tries call percpu_free_rwsem() directly since we are
not in atomic path but hotplug path where cpus_write_lock() called is causing
the deadlock.

I am not sure if there is a clean way other than freeing the per-cpu
rwsemaphore asynchronously all the time.

[1]

-001|context_switch(inline)
-001|__schedule()
-002|__preempt_count_sub(inline)
-002|schedule()
-003|_raw_spin_unlock_irq(inline)
-003|spin_unlock_irq(inline)
-003|percpu_rwsem_wait()
-004|__preempt_count_add(inline)
-004|__percpu_down_read()
-005|percpu_down_read(inline)
-005|cpus_read_lock() // trying to get cpu_hotplug_lock again
-006|rcu_barrier()
-007|rcu_sync_dtor()
-008|mmu_notifier_subscriptions_destroy(inline)
-008|__mmdrop()
-009|mmdrop(inline)
-009|finish_cpu()
-010|cpuhp_invoke_callback()
-011|cpuhp_invoke_callback_range(inline)
-011|cpuhp_down_callbacks()
-012|_cpu_down() // acquired cpu_hotplug_lock (write lock)

Thanks,
Pavan
