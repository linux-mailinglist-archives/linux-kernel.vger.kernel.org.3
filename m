Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AECB4BFB26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiBVOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiBVOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:51:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE1CAD763D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645541458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=7WV77HW5M6CROwiJ0BSz+RTajSYIi+veJzymkdBI5Hs=;
        b=EzynaGteJGQfEJ9xrdNZgj/vfHq+rSf7ihARZ3urCNym4I4mT8feZ8m7tFr3LBolajhKxW
        BAlNyODygFvJG5U52WtkZ1Y2NhG4vrQLcA8YrQmmcdJtf6IAOB2rgumcQNC/j0Kk0JmBL3
        e58aM0DAZDxrIC4FOujxWi+B+kpArc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-e3If2tB2PRGbciPPG0_j3w-1; Tue, 22 Feb 2022 09:50:55 -0500
X-MC-Unique: e3If2tB2PRGbciPPG0_j3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B8511091DA2;
        Tue, 22 Feb 2022 14:50:54 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F6547DE23;
        Tue, 22 Feb 2022 14:50:31 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 07506416D862; Tue, 22 Feb 2022 11:49:40 -0300 (-03)
Message-ID: <20220222144706.937848439@redhat.com>
User-Agent: quilt/0.66
Date:   Tue, 22 Feb 2022 11:47:06 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juril@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 0/2] replace work queue synchronization with synchronize_rcu
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
guarantees:

    * synchronize_rcu() waits for preemption disabled
    * and RCU read side critical sections
    * For the users of lru_disable_count:
    *
    * preempt_disable, local_irq_disable() [bh_lru_lock()]
    * rcu_read_lock                        [lru_pvecs CONFIG_PREEMPT_RT]
    * preempt_disable                      [lru_pvecs !CONFIG_PREEMPT_RT]
    *
    *
    * so any calls of lru_cache_disabled wrapped by
    * local_lock+rcu_read_lock or preemption disabled would be
    * ordered by that. 


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

diffstat:

 swap.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 30 deletions(-)



