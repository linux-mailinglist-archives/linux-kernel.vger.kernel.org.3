Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2AC53463E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbiEYWLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345363AbiEYWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:11:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA5A2CDEE;
        Wed, 25 May 2022 15:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DC94B81EA6;
        Wed, 25 May 2022 22:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2ABC34117;
        Wed, 25 May 2022 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653516675;
        bh=LBhBMs9GjOEfhBJWzPUCF+VTJhGM8NlzVA+cHXKdExE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrST2hlRULgNwKOnE+rzfebGkrbckmwSLNUEBXotFa7TOPGyuoo4Us8v62Bq0PgEN
         7DHRYL5D/qVplGyjwRMY1yJMkYVB7A8wO0sIV6GoumB3CoJQCB5n11SnBqvAn85QEZ
         kHNvFhCcFs7LgfL+XjC+B8tg9nQKN55mNVXfvbxOLNryRKbUoIJOypYqiq9FzVFq88
         axLHeKiaZDEDeYANqGTcm93UWsVpw9Eu/8ivjYRAyVzeK2LsPo6MaFgw5UDEC3Wx8s
         5hYnSkXpT8VMIc4G4jUO8qDHU/0CTPd58Ljqz9R7sYVC4owkEf62cenPTw+wC0C2uF
         iiN5HCZM/KGIQ==
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
Subject: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root partitions
Date:   Thu, 26 May 2022 00:10:55 +0200
Message-Id: <20220525221055.1152307-5-frederic@kernel.org>
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

Introduce a new "isolation.rcu_nocb" file within a cgroup2/cpuset
directory which provides support for a set of CPUs to either enable ("1")
or disable ("0") RCU callbacks offloading (aka. RCU NOCB). This can
overwrite previous boot settings towards "rcu_nocbs=" kernel parameter.

The file is only writeable on "root" type partitions to exclude any
overlap. The deepest root type partition has the highest priority.
This means that given the following setting:

                    Top cpuset (CPUs: 0-7)
                    cpuset.isolation.rcu_nocb = 0
                              |
                              |
                    Subdirectory A (CPUs: 5-7)
                    cpuset.cpus.partition = root
                    cpuset.isolation.rcu_nocb = 0
                              |
                              |
                    Subdirectory B (CPUs: 7)
                    cpuset.cpus.partition = root
                    cpuset.isolation.rcu_nocb = 1

the result is that only CPU 7 is in rcu_nocb mode.

Note that "rcu_nocbs" kernel parameter must be passed on boot, even
without a cpulist, so that nocb support is enabled.

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
 kernel/cgroup/cpuset.c | 95 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9390bfd9f1cd..2d9f019bb590 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -225,6 +225,7 @@ typedef enum {
 	CS_SCHED_LOAD_BALANCE,
 	CS_SPREAD_PAGE,
 	CS_SPREAD_SLAB,
+	CS_RCU_NOCB,
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -268,6 +269,11 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+static inline int is_rcu_nocb(const struct cpuset *cs)
+{
+	return test_bit(CS_RCU_NOCB, &cs->flags);
+}
+
 static inline int is_partition_root(const struct cpuset *cs)
 {
 	return cs->partition_root_state > 0;
@@ -590,6 +596,62 @@ static inline void free_cpuset(struct cpuset *cs)
 	kfree(cs);
 }
 
+#ifdef CONFIG_RCU_NOCB_CPU
+static int cpuset_rcu_nocb_apply(struct cpuset *root)
+{
+	int err;
+
+	if (is_rcu_nocb(root))
+		err = housekeeping_cpumask_set(root->effective_cpus, HK_TYPE_RCU);
+	else
+		err = housekeeping_cpumask_clear(root->effective_cpus, HK_TYPE_RCU);
+
+	return err;
+}
+
+static int cpuset_rcu_nocb_update(struct cpuset *cur, struct cpuset *trialcs)
+{
+	struct cgroup_subsys_state *des_css;
+	struct cpuset *des;
+	int err;
+
+	if (cur->partition_root_state != PRS_ENABLED)
+		return -EINVAL;
+
+	err = cpuset_rcu_nocb_apply(trialcs);
+	if (err < 0)
+		return err;
+
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(des, des_css, cur) {
+		if (des == cur)
+			continue;
+		if (des->partition_root_state == PRS_ENABLED)
+			break;
+		spin_lock_irq(&callback_lock);
+		if (is_rcu_nocb(trialcs))
+			set_bit(CS_RCU_NOCB, &des->flags);
+		else
+			clear_bit(CS_RCU_NOCB, &des->flags);
+		spin_unlock_irq(&callback_lock);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+#else
+static inline int cpuset_rcu_nocb_apply(struct cpuset *root)
+{
+	return 0;
+}
+
+static inline int cpuset_rcu_nocb_update(struct cpuset *cur,
+					 struct cpuset *trialcs)
+{
+	return 0;
+}
+#endif /* #ifdef CONFIG_RCU_NOCB_CPU */
+
 /*
  * validate_change_legacy() - Validate conditions specific to legacy (v1)
  *                            behavior.
@@ -1655,6 +1717,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cs->partition_root_state) {
 		struct cpuset *parent = parent_cs(cs);
 
+		WARN_ON_ONCE(cpuset_rcu_nocb_apply(parent) < 0);
+		WARN_ON_ONCE(cpuset_rcu_nocb_apply(cs) < 0);
+
 		/*
 		 * For partition root, update the cpumasks of sibling
 		 * cpusets if they use parent's effective_cpus.
@@ -2012,6 +2077,12 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
+	if (is_rcu_nocb(cs) != is_rcu_nocb(trialcs)) {
+		err = cpuset_rcu_nocb_update(cs, trialcs);
+		if (err < 0)
+			goto out;
+	}
+
 	spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
 	spin_unlock_irq(&callback_lock);
@@ -2365,6 +2436,7 @@ typedef enum {
 	FILE_MEMORY_PRESSURE,
 	FILE_SPREAD_PAGE,
 	FILE_SPREAD_SLAB,
+	FILE_RCU_NOCB,
 } cpuset_filetype_t;
 
 static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
@@ -2406,6 +2478,9 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	case FILE_SPREAD_SLAB:
 		retval = update_flag(CS_SPREAD_SLAB, cs, val);
 		break;
+	case FILE_RCU_NOCB:
+		retval = update_flag(CS_RCU_NOCB, cs, val);
+		break;
 	default:
 		retval = -EINVAL;
 		break;
@@ -2573,6 +2648,8 @@ static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 		return is_spread_page(cs);
 	case FILE_SPREAD_SLAB:
 		return is_spread_slab(cs);
+	case FILE_RCU_NOCB:
+		return is_rcu_nocb(cs);
 	default:
 		BUG();
 	}
@@ -2803,7 +2880,14 @@ static struct cftype dfl_files[] = {
 		.private = FILE_SUBPARTS_CPULIST,
 		.flags = CFTYPE_DEBUG,
 	},
-
+#ifdef CONFIG_RCU_NOCB_CPU
+	{
+		.name = "isolation.rcu_nocb",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_RCU_NOCB,
+	},
+#endif
 	{ }	/* terminate */
 };
 
@@ -2861,6 +2945,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
 	if (is_spread_slab(parent))
 		set_bit(CS_SPREAD_SLAB, &cs->flags);
+	if (is_rcu_nocb(parent))
+		set_bit(CS_RCU_NOCB, &cs->flags);
 
 	cpuset_inc();
 
@@ -3227,12 +3313,15 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (mems_updated)
 		check_insane_mems_config(&new_mems);
 
-	if (is_in_v2_mode())
+	if (is_in_v2_mode()) {
 		hotplug_update_tasks(cs, &new_cpus, &new_mems,
 				     cpus_updated, mems_updated);
-	else
+		if (cpus_updated)
+			WARN_ON_ONCE(cpuset_rcu_nocb_apply(cs) < 0);
+	} else {
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
+	}
 
 	percpu_up_write(&cpuset_rwsem);
 }
-- 
2.25.1

