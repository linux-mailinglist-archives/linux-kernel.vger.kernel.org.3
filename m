Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323944CD921
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiCDQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiCDQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:30:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4958B148937
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646411406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xv2/sRhNziwPgVlcororfSR3ylmU1ZdZfltQ24OShvQ=;
        b=ZnldfquYo24IpPiCT04z89bqSOCVPBGqtejwcRc0AfQ6yqGN4HhHDNKbOPO28rlZsBodgv
        O0JBmGzUH0y3oVXg6DHL13t5RG32p8Ivu//MJYQgSbvz249RJlx0eBi2dg0xBpTrEYqr7N
        WAjthTjOZUDGJvLxBZmIyiLgY7WONeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-8ABN0QEoP-2-6DOk8DD8bQ-1; Fri, 04 Mar 2022 11:30:03 -0500
X-MC-Unique: 8ABN0QEoP-2-6DOk8DD8bQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93A7F1006AA6;
        Fri,  4 Mar 2022 16:30:01 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D206686B92;
        Fri,  4 Mar 2022 16:29:51 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EAFAF416D862; Fri,  4 Mar 2022 13:29:31 -0300 (-03)
Date:   Fri, 4 Mar 2022 13:29:31 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [patch v4] mm: lru_cache_disable: replace work queue synchronization
 with synchronize_rcu
Message-ID: <YiI+a9gTr/UBCf0X@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhUKRzEKxMvlGQ5n@fuller.cnet>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
On systems that run FIFO:1 applications that busy loop 
on isolated CPUs, executing tasks on such CPUs under
lower priority is undesired (since that will either
hang the system, or cause longer interruption to the
FIFO task due to execution of lower priority task 
with very small sched slices).

Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU 
pagevec during the migration temporarily") relies on 
queueing work items on all online CPUs to ensure visibility
of lru_disable_count.

However, its possible to use synchronize_rcu which will provide the same
guarantees (see comment this patch modifies on lru_cache_disable).

Fixes:

[ 1873.243925] INFO: task kworker/u160:0:9 blocked for more than 622 seconds.
[ 1873.243927]       Tainted: G          I      --------- ---  5.14.0-31.rt21.31.el9.x86_64 #1
[ 1873.243929] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1873.243929] task:kworker/u160:0  state:D stack:    0 pid:    9 ppid:     2 flags:0x00004000
[ 1873.243932] Workqueue: cpuset_migrate_mm cpuset_migrate_mm_workfn
[ 1873.243936] Call Trace:
[ 1873.243938]  __schedule+0x21b/0x5b0
[ 1873.243941]  schedule+0x43/0xe0
[ 1873.243943]  schedule_timeout+0x14d/0x190
[ 1873.243946]  ? resched_curr+0x20/0xe0
[ 1873.243953]  ? __prepare_to_swait+0x4b/0x70
[ 1873.243958]  wait_for_completion+0x84/0xe0
[ 1873.243962]  __flush_work.isra.0+0x146/0x200
[ 1873.243966]  ? flush_workqueue_prep_pwqs+0x130/0x130
[ 1873.243971]  __lru_add_drain_all+0x158/0x1f0
[ 1873.243978]  do_migrate_pages+0x3d/0x2d0
[ 1873.243985]  ? pick_next_task_fair+0x39/0x3b0
[ 1873.243989]  ? put_prev_task_fair+0x1e/0x30
[ 1873.243992]  ? pick_next_task+0xb30/0xbd0
[ 1873.243995]  ? __tick_nohz_task_switch+0x1e/0x70
[ 1873.244000]  ? raw_spin_rq_unlock+0x18/0x60
[ 1873.244002]  ? finish_task_switch.isra.0+0xc1/0x2d0
[ 1873.244005]  ? __switch_to+0x12f/0x510
[ 1873.244013]  cpuset_migrate_mm_workfn+0x22/0x40
[ 1873.244016]  process_one_work+0x1e0/0x410
[ 1873.244019]  worker_thread+0x50/0x3b0
[ 1873.244022]  ? process_one_work+0x410/0x410
[ 1873.244024]  kthread+0x173/0x190
[ 1873.244027]  ? set_kthread_struct+0x40/0x40
[ 1873.244031]  ret_from_fork+0x1f/0x30

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
 
 ---
 
 v4: improve comment clarify, mention synchronize_rcu guarantees
     on v5.1				(Andrew Morton /
						 Paul E. McKenney)
 v3: update stale comment			(Nicolas Saenz Julienne)
 v2: rt_spin_lock calls rcu_read_lock, no need
 to add it before local_lock on swap.c		(Nicolas Saenz Julienne) 

diff --git a/mm/swap.c b/mm/swap.c
index bcf3ac288b56..b5ee163daa66 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -831,8 +831,7 @@ inline void __lru_add_drain_all(bool force_all_cpus)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (force_all_cpus ||
-		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
 		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
@@ -876,15 +875,21 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
 void lru_cache_disable(void)
 {
 	atomic_inc(&lru_disable_count);
-#ifdef CONFIG_SMP
 	/*
-	 * lru_add_drain_all in the force mode will schedule draining on
-	 * all online CPUs so any calls of lru_cache_disabled wrapped by
-	 * local_lock or preemption disabled would be ordered by that.
-	 * The atomic operation doesn't need to have stronger ordering
-	 * requirements because that is enforced by the scheduling
-	 * guarantees.
+	 * Readers of lru_disable_count are protected by either disabling
+	 * preemption or rcu_read_lock:
+	 *
+	 * preempt_disable, local_irq_disable  [bh_lru_lock()]
+	 * rcu_read_lock		       [rt_spin_lock CONFIG_PREEMPT_RT]
+	 * preempt_disable		       [local_lock !CONFIG_PREEMPT_RT]
+	 *
+	 * Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
+	 * preempt_disable() regions of code. So any CPU which sees
+	 * lru_disable_count = 0 will have exited the critical
+	 * section when synchronize_rcu() returns.
 	 */
+	synchronize_rcu();
+#ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else
 	lru_add_and_bh_lrus_drain();

