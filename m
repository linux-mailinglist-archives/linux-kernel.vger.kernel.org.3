Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241FC465A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354265AbhLBAY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:24:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48364 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354205AbhLBAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:24:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6968CE212B;
        Thu,  2 Dec 2021 00:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9019C53FCF;
        Thu,  2 Dec 2021 00:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404456;
        bh=QeXSCeOdNUAQWw42Nc34qkMPjGdidFzPUhtw438HvQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PL517y4teSh4LYNHTykdZQGu52IoBbiJ5smuM7ZSJ1trQbS7WBGiTzgxhJ7m1I8/E
         GQFiLqS1FFMx39uB2D16szgHyGZVu2Mzlne5fyuZ6ZdG1G81rhG9tn6Joc15S6Y92O
         +IPjPecPmLc+3SYEZWUrpdyN/uAQELjxpLO/JDumHsX1/zXqiD1Qilouy0KPOjzKL1
         KYwgl49P213HCwGxSyvdznhN+o5aC6NqnxJdPBCwFjV0OYkl1l5CA0EscFjFfaKy2C
         kImMpqDpXMRZBdNiLwdB7s2QQ1icaYXciNjeAxvaAJOL5fD8nWfx8f2dmWtooLiejE
         oFnC4ytmD58Uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 88E025C1180; Wed,  1 Dec 2021 16:20:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jun Miao <jun.miao@intel.com>,
        Jianwei Hu <jianwei.hu@windriver.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Marco Elver <elver@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/6] rcu: Avoid alloc_pages() when recording stack
Date:   Wed,  1 Dec 2021 16:20:54 -0800
Message-Id: <20211202002055.3127133-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun Miao <jun.miao@intel.com>

The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).
Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
in case it runs out by using kasan_record_aux_stack_noalloc().

Jianwei Hu reported:
BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
INFO: lockdep is turned off.
irq event stamp: 0
  hardirqs last  enabled at (0): [<0000000000000000>] 0x0
  hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
  softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
  Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
  Call Trace:
    show_stack+0x52/0x58
    dump_stack+0xa1/0xd6
    ___might_sleep.cold+0x11c/0x12d
    rt_spin_lock+0x3f/0xc0
    rmqueue+0x100/0x1460
    rmqueue+0x100/0x1460
    mark_usage+0x1a0/0x1a0
    ftrace_graph_ret_addr+0x2a/0xb0
    rmqueue_pcplist.constprop.0+0x6a0/0x6a0
     __kasan_check_read+0x11/0x20
     __zone_watermark_ok+0x114/0x270
     get_page_from_freelist+0x148/0x630
     is_module_text_address+0x32/0xa0
     __alloc_pages_nodemask+0x2f6/0x790
     __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
     create_prof_cpu_mask+0x30/0x30
     alloc_pages_current+0xb1/0x150
     stack_depot_save+0x39f/0x490
     kasan_save_stack+0x42/0x50
     kasan_save_stack+0x23/0x50
     kasan_record_aux_stack+0xa9/0xc0
     __call_rcu+0xff/0x9c0
     call_rcu+0xe/0x10
     put_object+0x53/0x70
     __delete_object+0x7b/0x90
     kmemleak_free+0x46/0x70
     slab_free_freelist_hook+0xb4/0x160
     kfree+0xe5/0x420
     kfree_const+0x17/0x30
     kobject_cleanup+0xaa/0x230
     kobject_put+0x76/0x90
     netdev_queue_update_kobjects+0x17d/0x1f0
     ... ...
     ksys_write+0xd9/0x180
     __x64_sys_write+0x42/0x50
     do_syscall_64+0x38/0x50
     entry_SYSCALL_64_after_hwframe+0x44/0xa9

Links: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/kasan.h?id=7cb3007ce2da27ec02a1a3211941e7fe6875b642
Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Marco Elver <elver@google.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Jun Miao <jun.miao@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f0f19dc7f19ec..c8beea8dd3a05 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2982,7 +2982,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	head->func = func;
 	head->next = NULL;
 	local_irq_save(flags);
-	kasan_record_aux_stack(head);
+	kasan_record_aux_stack_noalloc(head);
 	rdp = this_cpu_ptr(&rcu_data);
 
 	/* Add the callback to our list. */
@@ -3547,7 +3547,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		return;
 	}
 
-	kasan_record_aux_stack(ptr);
+	kasan_record_aux_stack_noalloc(ptr);
 	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
-- 
2.31.1.189.g2e36527f23

