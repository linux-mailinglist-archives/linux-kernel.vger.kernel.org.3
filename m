Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0134D4D80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiCJPoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiCJPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:44:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1230B159286
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646927010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMyajQDSkp6YalzQfQ6wdQt14hBp4G+RbVV9rQvsjRE=;
        b=dc9naEyCP3Wqgdgg83GASrf/BLMqmlMKwDXlYh3Ei9esClJHx9AHVNZ6KfTPW3bTNpYiK/
        19oVong1y5NGFKiIBxzQ8JKv8IunVIDvMwAc2Dwlrac+qKX+tC/nYSqxCwlDl5DSPS15aV
        BXckt21p4O7Vn7IPHGhBA/BH9Hlu/0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-p86hZfsrOQCzHfygGHy-RA-1; Thu, 10 Mar 2022 10:43:26 -0500
X-MC-Unique: p86hZfsrOQCzHfygGHy-RA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D46A1091DA0;
        Thu, 10 Mar 2022 15:43:24 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7073B7C037;
        Thu, 10 Mar 2022 15:43:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2215C416CE5D; Thu, 10 Mar 2022 10:22:13 -0300 (-03)
Date:   Thu, 10 Mar 2022 10:22:12 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch v5] mm: lru_cache_disable: replace work queue synchronization
 with synchronize_rcu
Message-ID: <Yin7hDxdt0s/x+fp@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
 <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On systems that run FIFO:1 applications that busy loop,
any SCHED_OTHER task that attempts to execute
on such a CPU (such as work threads) will not
be scheduled, which leads to system hangs.

Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU
pagevec during the migration temporarily") relies on
queueing work items on all online CPUs to ensure visibility
of lru_disable_count.

To fix this, replace the usage of work items with synchronize_rcu,
which provides the same guarantees.

Readers of lru_disable_count are protected by either disabling
preemption or rcu_read_lock:

preempt_disable, local_irq_disable  [bh_lru_lock()]
rcu_read_lock                       [rt_spin_lock CONFIG_PREEMPT_RT]
preempt_disable                     [local_lock !CONFIG_PREEMPT_RT]

Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
preempt_disable() regions of code. So any CPU which sees
lru_disable_count = 0 will have exited the critical
section when synchronize_rcu() returns.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Acked-by: Minchan Kim <minchan@kernel.org>

---
 
 v5: changelog improvements  		(Andrew Morton)
 v4: improve comment clarity, mention synchronize_rcu guarantees
     on v5.1				(Andrew Morton /
						 Paul E. McKenney)
 v3: update stale comment		(Nicolas Saenz Julienne)
 v2: rt_spin_lock calls rcu_read_lock, no need
 to add it before local_lock on swap.c	(Nicolas Saenz Julienne) 

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



