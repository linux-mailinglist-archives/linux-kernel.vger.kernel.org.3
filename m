Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F7353463C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiEYWLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiEYWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:11:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6EA13CEC;
        Wed, 25 May 2022 15:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96382B81EA6;
        Wed, 25 May 2022 22:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEAC34119;
        Wed, 25 May 2022 22:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653516665;
        bh=v6Wgx/GpjWpLSumr/2ZJN5dax3uTKAPTl+nT8m7pWNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFu7TlrMa1UEzJ9OqxeR/6DSEgim3ARu6FiaoIH4GfsZWjBHSXyqsXoGzkKUb3uvR
         WlRgNKwag2/RlYHsk4/Gy5hRVh7VubNF9A+qNFFnvvHnvLWXmppEheL2hCiUBmMahE
         hbFWfOEUhvpzYf3IvpyWT/m3ghKgc2FVxvwPZrS/KwEYFkLliwSU9Fw7qRbNcN6iup
         Qklx/g+s64OnGZy2Mldguh+5rRXC7xhPgvyZe9yZvResztQmhLz/YZGXzd5ecbDwnZ
         fNlim4wMeU1kZdSvC52C/S37oST9Ibr3/yxNibVYcS1StlD7r7+6mmt4XUdFXHrGQx
         Efd7QYfrPwe0A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: [PATCH 1/4] rcu/nocb: Pass a cpumask instead of a single CPU to offload/deoffload
Date:   Thu, 26 May 2022 00:10:52 +0200
Message-Id: <20220525221055.1152307-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525221055.1152307-1-frederic@kernel.org>
References: <20220525221055.1152307-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the interface to toggle callbacks offloading state only takes
a single CPU per call. Now driving RCU NOCB through cpusets requires
to be able to change the offloading state of a whole set of CPUs.

To make it easier, extend the (de-)offloading interface to support a
cpumask.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/rcupdate.h |   9 ++--
 kernel/rcu/rcutorture.c  |   4 +-
 kernel/rcu/tree_nocb.h   | 102 ++++++++++++++++++++++++++-------------
 3 files changed, 76 insertions(+), 39 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f9f75a3cfeb8..dc8bb7cc893a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -114,13 +114,14 @@ static inline void rcu_user_exit(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
-int rcu_nocb_cpu_offload(int cpu);
-int rcu_nocb_cpu_deoffload(int cpu);
+int rcu_nocb_cpumask_update(struct cpumask *cpumask, bool offload);
 void rcu_nocb_flush_deferred_wakeup(void);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
-static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
-static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
+static inline int rcu_nocb_cpumask_update(struct cpumask *cpumask, bool offload)
+{
+	return -EINVAL;
+}
 static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index faf6b4c7a757..f912ff4869b3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1887,10 +1887,10 @@ static int rcu_nocb_toggle(void *arg)
 		r = torture_random(&rand);
 		cpu = (r >> 4) % (maxcpu + 1);
 		if (r & 0x1) {
-			rcu_nocb_cpu_offload(cpu);
+			rcu_nocb_cpumask_update(cpumask_of(cpu), true);
 			atomic_long_inc(&n_nocb_offload);
 		} else {
-			rcu_nocb_cpu_deoffload(cpu);
+			rcu_nocb_cpumask_update(cpumask_of(cpu), false);
 			atomic_long_inc(&n_nocb_deoffload);
 		}
 		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c..428571ad11e3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1084,29 +1084,23 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	return 0;
 }
 
-int rcu_nocb_cpu_deoffload(int cpu)
+static int rcu_nocb_cpu_deoffload(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	cpus_read_lock();
-	mutex_lock(&rcu_state.barrier_mutex);
-	if (rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu)) {
-			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
-			if (!ret)
-				cpumask_clear_cpu(cpu, rcu_nocb_mask);
-		} else {
-			pr_info("NOCB: Can't CB-deoffload an offline CPU\n");
-			ret = -EINVAL;
-		}
-	}
-	mutex_unlock(&rcu_state.barrier_mutex);
-	cpus_read_unlock();
+	if (cpu_is_offline(cpu))
+		return -EINVAL;
+
+	if (!rcu_rdp_is_offloaded(rdp))
+		return 0;
+
+	ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
+	if (!ret)
+		cpumask_clear_cpu(cpu, rcu_nocb_mask);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
 static long rcu_nocb_rdp_offload(void *arg)
 {
@@ -1117,12 +1111,6 @@ static long rcu_nocb_rdp_offload(void *arg)
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
-	/*
-	 * For now we only support re-offload, ie: the rdp must have been
-	 * offloaded on boot first.
-	 */
-	if (!rdp->nocb_gp_rdp)
-		return -EINVAL;
 
 	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
 		return -EINVAL;
@@ -1169,29 +1157,77 @@ static long rcu_nocb_rdp_offload(void *arg)
 	return 0;
 }
 
-int rcu_nocb_cpu_offload(int cpu)
+static int rcu_nocb_cpu_offload(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	int ret = 0;
+	int ret;
+
+	if (cpu_is_offline(cpu))
+		return -EINVAL;
+
+	if (rcu_rdp_is_offloaded(rdp))
+		return 0;
+
+	ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
+	if (!ret)
+		cpumask_set_cpu(cpu, rcu_nocb_mask);
+
+	return ret;
+}
+
+int rcu_nocb_cpumask_update(struct cpumask *cpumask, bool offload)
+{
+	int cpu;
+	int err = 0;
+	int err_cpu;
+	cpumask_var_t saved_nocb_mask;
+
+	if (!alloc_cpumask_var(&saved_nocb_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(saved_nocb_mask, rcu_nocb_mask);
 
 	cpus_read_lock();
 	mutex_lock(&rcu_state.barrier_mutex);
-	if (!rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu)) {
-			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
-			if (!ret)
-				cpumask_set_cpu(cpu, rcu_nocb_mask);
+	for_each_cpu(cpu, cpumask) {
+		if (offload) {
+			err = rcu_nocb_cpu_offload(cpu);
+			if (err < 0) {
+				err_cpu = cpu;
+				pr_err("NOCB: offload cpu %d failed (%d)\n", cpu, err);
+				break;
+			}
 		} else {
-			pr_info("NOCB: Can't CB-offload an offline CPU\n");
-			ret = -EINVAL;
+			err = rcu_nocb_cpu_deoffload(cpu);
+			if (err < 0) {
+				err_cpu = cpu;
+				pr_err("NOCB: deoffload cpu %d failed (%d)\n", cpu, err);
+				break;
+			}
 		}
 	}
+
+	/* Rollback in case of error */
+	if (err < 0) {
+		err_cpu = cpu;
+		for_each_cpu(cpu, cpumask) {
+			if (err_cpu == cpu)
+				break;
+			if (cpumask_test_cpu(cpu, saved_nocb_mask))
+				WARN_ON_ONCE(rcu_nocb_cpu_offload(cpu));
+			else
+				WARN_ON_ONCE(rcu_nocb_cpu_deoffload(cpu));
+		}
+	}
+
 	mutex_unlock(&rcu_state.barrier_mutex);
 	cpus_read_unlock();
 
-	return ret;
+	free_cpumask_var(saved_nocb_mask);
+
+	return err;
 }
-EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
+EXPORT_SYMBOL_GPL(rcu_nocb_cpumask_update);
 
 void __init rcu_init_nohz(void)
 {
-- 
2.25.1

