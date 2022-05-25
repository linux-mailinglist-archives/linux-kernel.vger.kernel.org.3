Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC7C53463D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbiEYWLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241245AbiEYWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D285E11175;
        Wed, 25 May 2022 15:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38FA161AC3;
        Wed, 25 May 2022 22:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF32BC34117;
        Wed, 25 May 2022 22:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653516668;
        bh=l+U+3vUv8PFPM6xouiNpdZzkfzghAf+GVYpk33ixy3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IungJCUJSyEmeFEddWMdpfXZJiNj46GYKCCM61F8vs2ByYOLp6o5YHEHBH7Jh9u/j
         GRkUNevXlUiBoASF4dH4cjM0rwI097quqixRhTqJ5WbIrHdorMItafK7oRHEc3TS4V
         Gf0xZYnLQCzk7sEFlVcJqHVeW/RhTCdBDgHX19xTjLVyHsOrYWLutvgB8l6gDyu55w
         iAPqWp3a5f+W29epwd0Pej40GNf+eGGMfZ5NvTJVWSapSYACEG772YB6pYbr4y5r1S
         TGSTl5uT2tpfrjgn+0+hWyO9UiE8FX/ThCK7sGLGvCSTLfXVyEaPiXE94Cw4re7xS+
         cPeaoZtJCYMBQ==
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
Subject: [PATCH 2/4] rcu/nocb: Prepare to change nocb cpumask from CPU-hotplug protected cpuset caller
Date:   Thu, 26 May 2022 00:10:53 +0200
Message-Id: <20220525221055.1152307-3-frederic@kernel.org>
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

cpusets is going to use the NOCB (de-)offloading interface while
holding hotplug lock. Therefore pull out the responsibility of protecting
against concurrent CPU-hotplug changes to the callers of
rcu_nocb_cpumask_update().

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
 kernel/rcu/rcutorture.c | 2 ++
 kernel/rcu/tree_nocb.h  | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f912ff4869b3..5a3029550e83 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1886,6 +1886,7 @@ static int rcu_nocb_toggle(void *arg)
 	do {
 		r = torture_random(&rand);
 		cpu = (r >> 4) % (maxcpu + 1);
+		cpus_read_lock();
 		if (r & 0x1) {
 			rcu_nocb_cpumask_update(cpumask_of(cpu), true);
 			atomic_long_inc(&n_nocb_offload);
@@ -1893,6 +1894,7 @@ static int rcu_nocb_toggle(void *arg)
 			rcu_nocb_cpumask_update(cpumask_of(cpu), false);
 			atomic_long_inc(&n_nocb_deoffload);
 		}
+		cpus_read_unlock();
 		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 428571ad11e3..6396af6c765a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1182,12 +1182,13 @@ int rcu_nocb_cpumask_update(struct cpumask *cpumask, bool offload)
 	int err_cpu;
 	cpumask_var_t saved_nocb_mask;
 
+	lockdep_assert_cpus_held();
+
 	if (!alloc_cpumask_var(&saved_nocb_mask, GFP_KERNEL))
 		return -ENOMEM;
 
 	cpumask_copy(saved_nocb_mask, rcu_nocb_mask);
 
-	cpus_read_lock();
 	mutex_lock(&rcu_state.barrier_mutex);
 	for_each_cpu(cpu, cpumask) {
 		if (offload) {
@@ -1221,7 +1222,6 @@ int rcu_nocb_cpumask_update(struct cpumask *cpumask, bool offload)
 	}
 
 	mutex_unlock(&rcu_state.barrier_mutex);
-	cpus_read_unlock();
 
 	free_cpumask_var(saved_nocb_mask);
 
-- 
2.25.1

