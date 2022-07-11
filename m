Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE1566F13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiGENTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiGENTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:19:41 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413853AA61
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:41:38 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 265CbCDP028722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Tue, 5 Jul 2022 20:37:13 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from BJ10918PCW.spreadtrum.com (10.0.74.50) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 5 Jul 2022 20:37:13 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>
CC:     <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <xuewyan@foxmail.com>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu hotplug when using schedutil
Date:   Tue, 5 Jul 2022 20:37:05 +0800
Message-ID: <20220705123705.764-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.50]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 265CbCDP028722
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock between cpu_hotplug_lock sem and cgroup_threadgroup_rwsem.
And both cpu online and cpu offline scenarios will cause deadlock:

[1] cpu online:

1. first, thread-A get the cgroup_threadgroup_rwsem and waiting foe the cpu_hotplug_lock:

  [ffffffc00f9c3850] __switch_to at ffffffc0081229d4
  [ffffffc00f9c38b0] __schedule at ffffffc009c824f8
  [ffffffc00f9c3910] schedule at ffffffc009c82b50
  [ffffffc00f9c3970] percpu_rwsem_wait at ffffffc00828fbcc
  [ffffffc00f9c39b0] __percpu_down_read at ffffffc008290180     <<< try to get cpu_hotplug_lock
  [ffffffc00f9c39e0] cpus_read_lock at ffffffc0081dade8
  [ffffffc00f9c3a20] cpuset_attach at ffffffc008366ed4
  [ffffffc00f9c3a90] cgroup_migrate_execute at ffffffc00834f7d8
  [ffffffc00f9c3b60] cgroup_attach_task at ffffffc0083539b8
  [ffffffc00f9c3bd0] __cgroup1_procs_write at ffffffc00835f6ac   <<< get the cgroup_threadgroup_rwsem
  [ffffffc00f9c3c30] cgroup1_tasks_write at ffffffc00835f018
  [ffffffc00f9c3c60] cgroup_file_write at ffffffc008348b04
  [ffffffc00f9c3c90] kernfs_fop_write_iter at ffffffc0087544d8
  [ffffffc00f9c3d50] vfs_write at ffffffc008607a8c
  [ffffffc00f9c3db0] ksys_write at ffffffc0086076d8
  [ffffffc00f9c3df0] __arm64_sys_write at ffffffc008607640
  [ffffffc00f9c3e10] invoke_syscall at ffffffc00813dccc
  [ffffffc00f9c3e30] el0_svc_common at ffffffc00813dbe4
  [ffffffc00f9c3e70] do_el0_svc at ffffffc00813dac8
  [ffffffc00f9c3e80] el0_svc at ffffffc0098836c8
  [ffffffc00f9c3ea0] el0t_64_sync_handler at ffffffc00988363c
  [ffffffc00f9c3fe0] el0t_64_sync at ffffffc008091e44

2. Thread-B get the cpu_hotplug_lock and waiting for cpuhp/x:

  [ffffffc01245b740] __switch_to at ffffffc0081229d4
  [ffffffc01245b7a0] __schedule at ffffffc009c824f8
  [ffffffc01245b800] schedule at ffffffc009c82b50
  [ffffffc01245b880] schedule_timeout at ffffffc009c8a144
  [ffffffc01245b8e0] wait_for_common at ffffffc009c83dac     <<< waiting for cpuhp/x complete
  [ffffffc01245b940] cpuhp_kick_ap at ffffffc0081dc8ac       <<< wake up cpuhp/x
  [ffffffc01245b980] bringup_cpu at ffffffc0081db7f0
  [ffffffc01245ba00] cpuhp_invoke_callback at ffffffc0081dc000
  [ffffffc01245ba60] cpuhp_up_callbacks at ffffffc0081dd9b0
  [ffffffc01245bac0] _cpu_up at ffffffc0081dd844            <<< percpu_down_write(&cpu_hotplug_lock)
  [ffffffc01245bb40] cpu_up at ffffffc0081dd100
  [ffffffc01245bb80] cpu_subsys_online at ffffffc008d8ebe4
  [ffffffc01245bb90] device_online at ffffffc008d77dec
  [ffffffc01245bbd0] online_store at ffffffc008d77bb8
  [ffffffc01245bc30] dev_attr_store at ffffffc008d7c8b8
  [ffffffc01245bc60] sysfs_kf_write at ffffffc008757894
  [ffffffc01245bc90] kernfs_fop_write_iter at ffffffc0087544d8
  [ffffffc01245bd50] vfs_write at ffffffc008607a8c
  [ffffffc01245bdb0] ksys_write at ffffffc0086076d8
  [ffffffc01245bdf0] __arm64_sys_write at ffffffc008607640
  [ffffffc01245be10] invoke_syscall at ffffffc00813dccc
  [ffffffc01245be30] el0_svc_common at ffffffc00813dc14
  [ffffffc01245be70] do_el0_svc at ffffffc00813dac8
  [ffffffc01245be80] el0_svc at ffffffc0098836c8
  [ffffffc01245bea0] el0t_64_sync_handler at ffffffc00988363c
  [ffffffc01245bfe0] el0t_64_sync at ffffffc008091e44

3. cpuhp/x would call cpufreq_online and the schedutil need create kthread, as a result it need wait for kthreadd:

  [ffffffc00b653860] __switch_to at ffffffc0081229d4
  [ffffffc00b6538c0] __schedule at ffffffc009c824f8
  [ffffffc00b653920] schedule at ffffffc009c82b50
  [ffffffc00b6539a0] schedule_timeout at ffffffc009c8a144
  [ffffffc00b653a00] wait_for_common at ffffffc009c83dac     <<< wait for kthreadd
  [ffffffc00b653ad0] __kthread_create_on_node at ffffffc0082296b8
  [ffffffc00b653b90] kthread_create_on_node at ffffffc008229a58
  [ffffffc00b653bb0] sugov_init at ffffffc001d01414
  [ffffffc00b653c00] cpufreq_init_governor at ffffffc009179a48
  [ffffffc00b653c50] cpufreq_set_policy at ffffffc009179360
  [ffffffc00b653cb0] cpufreq_online at ffffffc00917c3e4
  [ffffffc00b653d10] cpuhp_cpufreq_online at ffffffc00917ee3c
  [ffffffc00b653d70] cpuhp_invoke_callback at ffffffc0081dc000
  [ffffffc00b653dd0] cpuhp_thread_fun at ffffffc0081df47c
  [ffffffc00b653e10] smpboot_thread_fn at ffffffc008234718
  [ffffffc00b653e70] kthread at ffffffc00822ac84

4. the kthreadd is trying to get cgroup_threadgroup_rwsem...

  [ffffffc008073a70] __switch_to at ffffffc0081229d4
  [ffffffc008073ad0] __schedule at ffffffc009c824f8
  [ffffffc008073b30] schedule at ffffffc009c82b50
  [ffffffc008073b90] percpu_rwsem_wait at ffffffc00828fbcc  <<< cgroup_threadgroup_rwsem
  [ffffffc008073bd0] __percpu_down_read at ffffffc008290180
  [ffffffc008073c00] cgroup_css_set_fork at ffffffc008357ecc
  [ffffffc008073c60] cgroup_can_fork at ffffffc008357bb4
  [ffffffc008073d00] copy_process at ffffffc0081d18c4
  [ffffffc008073d90] kernel_clone at ffffffc0081d088c
  [ffffffc008073e50] kthreadd at ffffffc00822a8e4

Finally, the Thread-A and Thread-B would be blockd forever.

[2]cpu_offline:

1. first, thread-A get the cgroup_threadgroup_rwsem and waiting foe the cpu_hotplug_lock:

  [ffffffc00f9c3850] __switch_to at ffffffc0081229d4
  [ffffffc00f9c38b0] __schedule at ffffffc009c824f8
  [ffffffc00f9c3910] schedule at ffffffc009c82b50
  [ffffffc00f9c3970] percpu_rwsem_wait at ffffffc00828fbcc
  [ffffffc00f9c39b0] __percpu_down_read at ffffffc008290180     <<< try to get cpu_hotplug_lock
  [ffffffc00f9c39e0] cpus_read_lock at ffffffc0081dade8
  [ffffffc00f9c3a20] cpuset_attach at ffffffc008366ed4
  [ffffffc00f9c3a90] cgroup_migrate_execute at ffffffc00834f7d8
  [ffffffc00f9c3b60] cgroup_attach_task at ffffffc0083539b8
  [ffffffc00f9c3bd0] __cgroup1_procs_write at ffffffc00835f6ac   <<< get the cgroup_threadgroup_rwsem
  [ffffffc00f9c3c30] cgroup1_tasks_write at ffffffc00835f018
  [ffffffc00f9c3c60] cgroup_file_write at ffffffc008348b04
  [ffffffc00f9c3c90] kernfs_fop_write_iter at ffffffc0087544d8
  [ffffffc00f9c3d50] vfs_write at ffffffc008607a8c
  [ffffffc00f9c3db0] ksys_write at ffffffc0086076d8
  [ffffffc00f9c3df0] __arm64_sys_write at ffffffc008607640
  [ffffffc00f9c3e10] invoke_syscall at ffffffc00813dccc
  [ffffffc00f9c3e30] el0_svc_common at ffffffc00813dbe4
  [ffffffc00f9c3e70] do_el0_svc at ffffffc00813dac8
  [ffffffc00f9c3e80] el0_svc at ffffffc0098836c8
  [ffffffc00f9c3ea0] el0t_64_sync_handler at ffffffc00988363c
  [ffffffc00f9c3fe0] el0t_64_sync at ffffffc008091e44

2. Thread-B get the cpu_hotplug_lock and waiting for cpuhp/x:

  [ffffffc01245b740] __switch_to at ffffffc0081229d4
  [ffffffc01245b7a0] __schedule at ffffffc009c824f8
  [ffffffc01245b800] schedule at ffffffc009c82b50
  [ffffffc01245b880] schedule_timeout at ffffffc009c8a144
  [ffffffc01245b8e0] wait_for_common at ffffffc009c83dac     <<< waiting for cpuhp/x complete
  [ffffffc01245b940] cpuhp_kick_ap at ffffffc0081dc8ac       <<< wake up cpuhp/x
  [ffffffc01245b980] bringup_cpu at ffffffc0081db7f0
  [ffffffc01245ba00] cpuhp_invoke_callback at ffffffc0081dc000
  [ffffffc01245ba60] cpuhp_up_callbacks at ffffffc0081dd9b0
  [ffffffc01245bac0] _cpu_up at ffffffc0081dd844            <<< percpu_down_write(&cpu_hotplug_lock)
  [ffffffc01245bb40] cpu_up at ffffffc0081dd100
  [ffffffc01245bb80] cpu_subsys_online at ffffffc008d8ebe4
  [ffffffc01245bb90] device_online at ffffffc008d77dec
  [ffffffc01245bbd0] online_store at ffffffc008d77bb8
  [ffffffc01245bc30] dev_attr_store at ffffffc008d7c8b8
  [ffffffc01245bc60] sysfs_kf_write at ffffffc008757894
  [ffffffc01245bc90] kernfs_fop_write_iter at ffffffc0087544d8
  [ffffffc01245bd50] vfs_write at ffffffc008607a8c
  [ffffffc01245bdb0] ksys_write at ffffffc0086076d8
  [ffffffc01245bdf0] __arm64_sys_write at ffffffc008607640
  [ffffffc01245be10] invoke_syscall at ffffffc00813dccc
  [ffffffc01245be30] el0_svc_common at ffffffc00813dc14
  [ffffffc01245be70] do_el0_svc at ffffffc00813dac8
  [ffffffc01245be80] el0_svc at ffffffc0098836c8
  [ffffffc01245bea0] el0t_64_sync_handler at ffffffc00988363c
  [ffffffc01245bfe0] el0t_64_sync at ffffffc008091e44

3.cpuhp/x would call cpufreq_offline and schedutil need stop_kthread:

  [ffffffc00b683a60] __switch_to at ffffffc0081229d4
  [ffffffc00b683ac0] __schedule at ffffffc009c824f8
  [ffffffc00b683b20] schedule at ffffffc009c82b50
  [ffffffc00b683ba0] schedule_timeout at ffffffc009c8a144
  [ffffffc00b683c00] wait_for_common at ffffffc009c83dac <<< waiting for sugov complete
  [ffffffc00b683c60] kthread_stop at ffffffc008228128   <<< wakeup sugov
  [ffffffc00b683c90] sugov_exit at ffffffc001d016a8
  [ffffffc00b683cc0] cpufreq_offline at ffffffc00917b4b8
  [ffffffc00b683d10] cpuhp_cpufreq_offline at ffffffc00917ee70
  [ffffffc00b683d70] cpuhp_invoke_callback at ffffffc0081dc000
  [ffffffc00b683dd0] cpuhp_thread_fun at ffffffc0081df47c
  [ffffffc00b683e10] smpboot_thread_fn at ffffffc008234718
  [ffffffc00b683e70] kthread at ffffffc00822ac84

4. the sugov thread is waiting cgroup_threadgroup_rwsem:

  [ffffffc01258bc10] __switch_to at ffffffc0081229d4
  [ffffffc01258bc70] __schedule at ffffffc009c824f8
  [ffffffc01258bcd0] schedule at ffffffc009c82b50
  [ffffffc01258bd30] percpu_rwsem_wait at ffffffc00828fbcc  <<< wait for cgroup_threadgroup_rwsem
  [ffffffc01258bd70] __percpu_down_read at ffffffc008290180
  [ffffffc01258bdb0] exit_signals at ffffffc0082074c8
  [ffffffc01258be10] do_exit at ffffffc0081e5130
  [ffffffc01258be70] kthread at ffffffc00822ac8c

Finally, the Thread-A and Thread-B would be blockd forever.

Combining the above two situations, the reason why Thread-A and Thread-B are blocked is because cpuhp/x is blocked.
If we can solve the problem that cpuhp is not blocked, Thread-A and Thread-B can run normally.
So we can let schedutil do not create or destory thread, so that the cpuhp/x would not be blocked.

So init the sugov thread just once to prevent the above deadlock.

Signed-off-by: Ke Wang <ke.wang@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/cpufreq_schedutil.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 285ad51caf0f..42d04a1eac20 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -8,6 +8,8 @@
 
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
+static LIST_HEAD(sugov_list);
+
 struct sugov_tunables {
 	struct gov_attr_set	attr_set;
 	unsigned int		rate_limit_us;
@@ -15,6 +17,7 @@ struct sugov_tunables {
 
 struct sugov_policy {
 	struct cpufreq_policy	*policy;
+	struct list_head	sg_policy_list;
 
 	struct sugov_tunables	*tunables;
 	struct list_head	tunables_hook;
@@ -659,6 +662,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	struct sugov_policy *sg_policy;
 	struct sugov_tunables *tunables;
 	int ret = 0;
+	int sugov_init = 0;
 
 	/* State should be equivalent to EXIT */
 	if (policy->governor_data)
@@ -666,6 +670,13 @@ static int sugov_init(struct cpufreq_policy *policy)
 
 	cpufreq_enable_fast_switch(policy);
 
+	list_for_each_entry(sg_policy, &sugov_list, sg_policy_list) {
+		if (sg_policy->policy == policy) {
+			sugov_init = 1;
+			goto tunables_lock;
+		}
+	}
+
 	sg_policy = sugov_policy_alloc(policy);
 	if (!sg_policy) {
 		ret = -ENOMEM;
@@ -676,6 +687,10 @@ static int sugov_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_sg_policy;
 
+	list_add(&sg_policy->sg_policy_list, &sugov_list);
+
+tunables_lock:
+
 	mutex_lock(&global_tunables_lock);
 
 	if (global_tunables) {
@@ -717,7 +732,8 @@ static int sugov_init(struct cpufreq_policy *policy)
 	sugov_clear_global_tunables();
 
 stop_kthread:
-	sugov_kthread_stop(sg_policy);
+	if (!sugov_init)
+		sugov_kthread_stop(sg_policy);
 	mutex_unlock(&global_tunables_lock);
 
 free_sg_policy:
@@ -745,8 +761,14 @@ static void sugov_exit(struct cpufreq_policy *policy)
 
 	mutex_unlock(&global_tunables_lock);
 
+	list_for_each_entry(sg_policy, &sugov_list, sg_policy_list) {
+		if (sg_policy->policy == policy) {
+			goto out;
+		}
+	}
 	sugov_kthread_stop(sg_policy);
 	sugov_policy_free(sg_policy);
+out:
 	cpufreq_disable_fast_switch(policy);
 }
 
-- 
2.25.1

