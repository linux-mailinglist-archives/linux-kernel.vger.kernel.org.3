Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319C1483CF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiADHeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:34:06 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:56494 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbiADHeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:34:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0V0ssPZI_1641281638;
Received: from 30.21.164.217(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0V0ssPZI_1641281638)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 15:33:59 +0800
Message-ID: <98f41efd-74b2-198a-839c-51b785b748a6@linux.alibaba.com>
Date:   Tue, 4 Jan 2022 15:33:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Content-Language: en-US
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: [RFC PATCH] sched: introduce group balancer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern platform are growing fast on CPU numbers, multiple
apps sharing one box are very common, they used to have
exclusive cpu setting but nowadays things are changing.

To achieve better utility of CPU resource, multiple apps
are starting to sharing the CPUs. The CPU resources usually
overcommitted since app's workload are undulated.

This introduced problems on performance when share mode vs
exclusive mode, for eg with cgroup A,B and C deployed in
exclusive mode, it will be:

   CPU_X (100%)     CPU_Y (100%)     CPU_Z (50%)
   T_1_CG_A         T_1_CG_B         T_1_CG_C
   T_2_CG_A         T_2_CG_B         T_2_CG_C
   T_3_CG_A         T_3_CG_B
   T_4_CG_A         T_4_CG_B

while the share mode will be:

   CPU_X (100%)     CPU_Y (75%)     CPU_Z (75%)
   T_1_CG_A         T_2_CG_A         T_1_CG_B
   T_2_CG_B         T_3_CG_B         T_2_CG_C
   T_4_CG_B         T_4_CG_A         T_3_CG_A
   T_1_CG_C

As we can see, the confliction between groups on CPU
resources are now happening all over the CPUs.

The testing on sysbench-memory show 30+% drop on share
mode, and redis-benchmark show 10+% drop too, compared
to the exclusive mode.

However, despite of the performance drop, in real world
we still prefer share mode. The undulated workload can
make the exclusive mode so unefficient on CPU utilization,
for eg the next period, when CG_A become 'idle', exclusive
mode will like:

   CPU_X (0%)     CPU_Y (100%)     CPU_Z (50%)
                  T_1_CG_B         T_1_CG_C
                  T_2_CG_B         T_2_CG_C
                  T_3_CG_B
                  T_4_CG_B

while share mode like:

   CPU_X (50%)     CPU_Y (50%)     CPU_Z (50%)
   T_2_CG_B         T_1_CG_C        T_3_CG_B
   T_4_CG_B         T_1_CG_B        T_2_CG_C

The CPU_X is totally wasted in exclusive mode, the resource
efficiency are really poor.

Thus what we need, is a way to ease confliction in share mode,
make groups as exclusive as possible, to gain both performance
and resource efficiency.

The main idea of group balancer is to fulfill this requirement
by balancing groups of tasks among groups of CPUs, consider this
as a dynamic demi-exclusive mode.

Just like balance the task among CPUs, now with GB a user can
put CPU X,Y,Z into three partitions, and balance group A,B,C
into these partition, to make them as exclusive as possible.

The design is very likely to the numa balancing, task trigger
work to settle it's group into a proper partition (minimum
predicted load), then try migrate itself into it. To gradually
settle groups into the most exclusively partition.

How To Use:

To create partition, for example run:
   echo disable > /proc/gb_ctrl
   echo "0-15;16-31;32-47;48-63;" > /proc/gb_ctrl
   echo enable > /proc/gb_ctrl

this will create 4 partitions contain CPUs 0-15,16-31,32-47 and
48-63 separately.

Then enable GB for your cgroup, run
   $CPU_CGROUP_PATH/cpu.gb_period_ms

And you can check:
   $CPU_CGROUP_PATH/cpu.gb_stat

which give output as:
   PART-0 0-15 1008 1086  *
   PART-1 16-31 0 2
   PART-2 32-47 0 0
   PART-3 48-63 0 1024

The partition ID followed by it's CPUs range, load of group, load
of partition and a star mark as preferred.

Testing Results:
   In order to enlarge the differences, we do testing on ARM platform
   with 128 CPUs, create 8 partition according to cluster info.

   Since we pick benchmark which can gain benefit from exclusive mode,
   this is more like a functional testing rather than performance, to
   show that GB help winback the performance.

   Create 8 cgroup each running 'sysbench memory --threads=16 run',
   the output of share mode is:
     events/s (eps):                      4181233.4646
     events/s (eps):                      3548328.2346
     events/s (eps):                      4578816.2412
     events/s (eps):                      4761797.3932
     events/s (eps):                      3486703.0455
     events/s (eps):                      3474920.9803
     events/s (eps):                      3604632.7799
     events/s (eps):                      3149506.7001
   the output of gb mode is:
     events/s (eps):                      5472334.9313
     events/s (eps):                      4085399.1606
     events/s (eps):                      4398122.2170
     events/s (eps):                      6180233.6766
     events/s (eps):                      4299784.2742
     events/s (eps):                      4914813.6847
     events/s (eps):                      3675395.1191
     events/s (eps):                      6767666.6229

   Create 4 cgroup each running redis-server with 16 io threads,
   4 redis-benchmark per each server show average rps as:

                     share mode       gb mode

   PING_INLINE     : 41154.84         42229.27               2.61%
   PING_MBULK      : 43042.07         44907.10               4.33%
   SET             : 34502.00         37374.58               8.33%
   GET             : 41713.47         45257.68               8.50%
   INCR            : 41533.26         44259.31               6.56%
   LPUSH           : 36541.23         39417.84               7.87%
   RPUSH           : 39059.26         42075.32               7.72%
   LPOP            : 36978.73         39903.15               7.91%
   RPOP            : 39553.32         42071.53               6.37%
   SADD            : 40614.30         44693.33              10.04%
   HSET            : 39101.93         42401.16               8.44%
   SPOP            : 42838.90         46560.46               8.69%
   ZADD            : 38346.80         41685.46               8.71%
   ZPOPMIN         : 41952.26         46138.14               9.98%
   LRANGE_100      : 19364.66         20251.56               4.58%
   LRANGE_300      : 9699.57          9935.86                2.44%
   LRANGE_500      : 6291.76          6512.48                3.51%
   LRANGE_600      : 5619.13          5658.31                0.70%
   MSET            : 24432.78         26517.63               8.53%

Signed-off-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
  include/linux/sched.h |   5 +
  init/Kconfig          |  12 +
  kernel/sched/Makefile |   1 +
  kernel/sched/core.c   |  44 +++
  kernel/sched/fair.c   |  22 +-
  kernel/sched/gb.c     | 767 
++++++++++++++++++++++++++++++++++++++++++++++++++
  kernel/sched/sched.h  |  24 ++
  7 files changed, 874 insertions(+), 1 deletion(-)
  create mode 100644 kernel/sched/gb.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cd3d9c..efabfb1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1284,6 +1284,11 @@ struct task_struct {
  	unsigned long			numa_pages_migrated;
  #endif /* CONFIG_NUMA_BALANCING */

+#ifdef CONFIG_GROUP_BALANCER
+	unsigned long			gb_stamp;
+	struct callback_head		gb_work;
+#endif
+
  #ifdef CONFIG_RSEQ
  	struct rseq __user *rseq;
  	u32 rseq_sig;
diff --git a/init/Kconfig b/init/Kconfig
index 41a728d..32131af 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1021,6 +1021,18 @@ config RT_GROUP_SCHED
  	  realtime bandwidth for them.
  	  See Documentation/scheduler/sched-rt-group.rst for more information.

+config GROUP_BALANCER
+	bool "Group balancer support for SCHED_OTHER"
+	depends on (CGROUP_SCHED && SMP)
+	default CGROUP_SCHED
+	help
+	  This feature allow you to do load balance in group mode. In other
+	  word, balance groups of tasks among groups of CPUs.
+
+	  This can reduce the conflict between task groups and gain benefit
+	  from hot cache, usually for the cases when there are multiple apps
+	  sharing the same CPUs.
+
  endif #CGROUP_SCHED

  config UCLAMP_TASK_GROUP
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c7421f2..e24d645 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_MEMBARRIER) += membarrier.o
  obj-$(CONFIG_CPU_ISOLATION) += isolation.o
  obj-$(CONFIG_PSI) += psi.o
  obj-$(CONFIG_SCHED_CORE) += core_sched.o
+obj-$(CONFIG_GROUP_BALANCER) += gb.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83872f9..e3675a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4436,6 +4436,10 @@ int sched_fork(unsigned long clone_flags, struct 
task_struct *p)
  	plist_node_init(&p->pushable_tasks, MAX_PRIO);
  	RB_CLEAR_NODE(&p->pushable_dl_tasks);
  #endif
+#ifdef CONFIG_GROUP_BALANCER
+	p->gb_stamp = 0;
+	init_task_work(&p->gb_work, group_balancing_work);
+#endif
  	return 0;
  }

@@ -10554,6 +10558,35 @@ static int cpu_cfs_stat_show(struct seq_file 
*sf, void *v)
  #endif /* CONFIG_CFS_BANDWIDTH */
  #endif /* CONFIG_FAIR_GROUP_SCHED */

+#ifdef CONFIG_GROUP_BALANCER
+int cpu_cfs_gb_stat_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	if (gb_enabled() && tg != &root_task_group)
+		gb_stat_show(tg, sf);
+
+	return 0;
+}
+
+static int cpu_gb_period_write(struct cgroup_subsys_state *css,
+				    struct cftype *cftype, u64 period_ms)
+{
+	struct task_group *tg = css_tg(css);
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	return set_gb_period(tg, period_ms);
+}
+
+static u64 cpu_gb_period_read(struct cgroup_subsys_state *css,
+				   struct cftype *cft)
+{
+	return get_gb_period(css_tg(css));
+}
+#endif
+
  #ifdef CONFIG_RT_GROUP_SCHED
  static int cpu_rt_runtime_write(struct cgroup_subsys_state *css,
  				struct cftype *cft, s64 val)
@@ -10628,6 +10661,17 @@ static int cpu_idle_write_s64(struct 
cgroup_subsys_state *css,
  		.seq_show = cpu_cfs_stat_show,
  	},
  #endif
+#ifdef CONFIG_GROUP_BALANCER
+	{
+		.name = "gb_stat",
+		.seq_show = cpu_cfs_gb_stat_show,
+	},
+	{
+		.name = "gb_period_ms",
+		.read_u64 = cpu_gb_period_read,
+		.write_u64 = cpu_gb_period_write,
+	},
+#endif
  #ifdef CONFIG_RT_GROUP_SCHED
  	{
  		.name = "rt_runtime_us",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa..80f5038 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1577,6 +1577,9 @@ static void update_numa_stats(struct task_numa_env 
*env,
  			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
  				continue;

+			if (group_hot(env->p, env->src_cpu, cpu) == 0)
+				continue;
+
  			if (ns->idle_cpu == -1)
  				ns->idle_cpu = cpu;

@@ -1912,6 +1915,9 @@ static void task_numa_find_cpu(struct 
task_numa_env *env,
  		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
  			continue;

+		if (group_hot(env->p, env->src_cpu, cpu) == 0)
+			continue;
+
  		env->dst_cpu = cpu;
  		if (task_numa_compare(env, taskimp, groupimp, maymove))
  			break;
@@ -5965,8 +5971,11 @@ static int wake_affine(struct sched_domain *sd, 
struct task_struct *p,
  		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);

  	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
-	if (target == nr_cpumask_bits)
+	if (target == nr_cpumask_bits) {
+		if (group_hot(p, prev_cpu, this_cpu) == 1)
+			return this_cpu;
  		return prev_cpu;
+	}

  	schedstat_inc(sd->ttwu_move_affine);
  	schedstat_inc(p->stats.nr_wakeups_affine);
@@ -7761,6 +7770,12 @@ int can_migrate_task(struct task_struct *p, 
struct lb_env *env)
  		return 0;
  	}

+	if (gb_enabled()) {
+		tsk_cache_hot = group_hot(p, env->src_cpu, env->dst_cpu);
+		if (tsk_cache_hot != -1)
+			return tsk_cache_hot;
+	}
+
  	/*
  	 * Aggressive migration if:
  	 * 1) active balance
@@ -11125,6 +11140,9 @@ static void task_tick_fair(struct rq *rq, struct 
task_struct *curr, int queued)
  	if (static_branch_unlikely(&sched_numa_balancing))
  		task_tick_numa(rq, curr);

+	if (gb_enabled())
+		task_tick_gb(rq, curr);
+
  	update_misfit_status(curr, rq);
  	update_overutilized_status(task_rq(curr));

@@ -11453,6 +11471,8 @@ int alloc_fair_sched_group(struct task_group 
*tg, struct task_group *parent)
  		init_entity_runnable_average(se);
  	}

+	init_cfs_gb(tg);
+
  	return 1;

  err_free_rq:
diff --git a/kernel/sched/gb.c b/kernel/sched/gb.c
new file mode 100644
index 0000000..e7195c6
--- /dev/null
+++ b/kernel/sched/gb.c
@@ -0,0 +1,767 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Group Balancer code
+ *
+ *  Copyright (C) 2021 Alibaba, Inc., Michael Wang 
<yun.wang@linux.alibaba.com>
+ */
+#include "sched.h"
+
+#define GB_IMBALANCE_MIN	32
+#define CPU_PART_MAX		32
+#define DECAY_PERIOD		HZ
+#define for_each_part(pi, x)	\
+	for (x = 0; x < pi->nr_part; x++)
+#define for_each_part_but(pi, x, y)	\
+	for (x = (y + 1) % pi->nr_part; x != y; x = (x + 1) % pi->nr_part)
+
+struct gb_part {
+	int id;
+	unsigned int mgrt_on;
+	u64 predict_load;
+	struct cpumask cpus;
+};
+
+struct gb_part_info {
+	int nr_part;
+	struct rcu_head rcu_head;
+	struct gb_part parts[CPU_PART_MAX];
+	int ctop[NR_CPUS];
+};
+
+static unsigned long tg_settle_period = HZ/5;
+static unsigned long tg_settle_period_max = HZ*10;
+static unsigned long global_settle_period = HZ/5;
+
+static unsigned long global_settle_next;
+static unsigned long predict_period_stamp;
+
+DEFINE_STATIC_KEY_FALSE(sched_group_balancer);
+DEFINE_MUTEX(gb_mutex);
+DEFINE_SPINLOCK(settle_lock);
+
+static struct gb_part_info *part_info;
+
+static inline int ctop(struct gb_part_info *pi, int cpu)
+{
+	return pi->ctop[cpu];
+}
+
+static inline struct cpumask *part_cpus(struct gb_part_info *pi, int id)
+{
+	return &pi->parts[id].cpus;
+}
+
+static inline int part_mgrt_lock(struct gb_part_info *pi, int src, int dst)
+{
+	struct gb_part *src_part, *dst_part;
+
+	/*
+	 * The target partition number must be
+	 * nonnegative.
+	 */
+	if (dst == -1)
+		return 0;
+
+	dst_part = &pi->parts[dst];
+	if (READ_ONCE(dst_part->mgrt_on))
+		return 0;
+
+	/*
+	 * The source partition number can be -1
+	 * when from cpus that out of any partitions.
+	 */
+	if (src != -1) {
+		src_part = &pi->parts[src];
+		if (READ_ONCE(src_part->mgrt_on))
+			return 0;
+	}
+
+	if (xchg(&dst_part->mgrt_on, 1))
+		return 0;
+
+	if (src != -1 && xchg(&src_part->mgrt_on, 1)) {
+		WRITE_ONCE(dst_part->mgrt_on, 0);
+		return 0;
+	}
+
+	return 1;
+}
+
+static inline void part_mgrt_unlock(struct gb_part_info *pi, int src, 
int dst)
+{
+	struct gb_part *src_part, *dst_part;
+
+	if (src != -1) {
+		src_part = &pi->parts[src];
+		WRITE_ONCE(src_part->mgrt_on, 0);
+	}
+
+	if (dst != -1) {
+		dst_part = &pi->parts[dst];
+		WRITE_ONCE(dst_part->mgrt_on, 0);
+	}
+}
+
+static u64 cfs_h_load(struct sched_entity *se)
+{
+	u64 load = se->avg.load_avg;
+
+	se = se->parent;
+	while (se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		load = div64_ul(load * se->avg.load_avg,
+				cfs_rq->avg.runnable_avg + 1);
+		se = se->parent;
+	}
+
+	return load;
+}
+
+static u64 tg_load_of_part(struct gb_part_info *pi, struct task_group 
*tg, int id)
+{
+	int i;
+	u64 load = 0;
+
+	for_each_cpu(i, part_cpus(pi, id))
+		load += cfs_h_load(tg->se[i]);
+
+	return load;
+}
+
+static u64 load_of_part(struct gb_part_info *pi, int id)
+{
+	int i;
+	u64 load = 0;
+
+	for_each_cpu(i, part_cpus(pi, id))
+		load += cpu_rq(i)->cfs.avg.load_avg;
+
+	return load;
+}
+
+static u64 cap_of_part(struct gb_part_info *pi, int id)
+{
+	int i;
+	u64 cap = 0;
+
+	for_each_cpu(i, part_cpus(pi, id))
+		cap += cpu_rq(i)->cpu_capacity;
+
+	return cap;
+}
+
+static void free_gb_part_info(struct rcu_head *rcu_head)
+{
+	struct gb_part_info *pi = container_of(rcu_head, struct gb_part_info, 
rcu_head);
+
+	kfree(pi);
+}
+
+static inline void predict_load_add(struct gb_part_info *pi, int id, 
u64 load)
+{
+	pi->parts[id].predict_load += load;
+}
+
+static void predict_load_decay(struct gb_part_info *pi)
+{
+	int i, fact, passed;
+
+	passed = jiffies - global_settle_next + predict_period_stamp;
+	predict_period_stamp = passed % DECAY_PERIOD;
+	fact = passed / DECAY_PERIOD;
+
+	if (!fact)
+		return;
+
+	for_each_part(pi, i) {
+		struct gb_part *part = &pi->parts[i];
+
+		/*
+		 * Decay NICE_0_LOAD into zero after 10 seconds
+		 */
+		if (fact > 10)
+			part->predict_load = 0;
+		else
+			part->predict_load >>= fact;
+	}
+}
+
+static noinline int try_to_settle(struct gb_part_info *pi, struct 
task_group *tg)
+{
+	int i, src, dst, ret;
+	u64 mgrt_load, tg_load, min_load, src_load, dst_load;
+
+	src = dst = -1;
+	min_load = U64_MAX;
+	tg_load = 0;
+	for_each_part(pi, i) {
+		u64 mgrt = tg_load_of_part(pi, tg, i);
+		u64 load = load_of_part(pi, i);
+
+		/* load after migration */
+		if (load > mgrt)
+			load -= mgrt;
+		else
+			load = 0;
+
+		/*
+		 * Try to find out the partition contain
+		 * minimum load, and the load of this task
+		 * group is excluded on comparison.
+		 *
+		 * This help to prevent that a partition
+		 * full of the tasks from this task group was
+		 * considered as busy.
+		 *
+		 * As for the prediction load, the partition
+		 * this group preferred will be excluded, since
+		 * these prediction load could be introduced by
+		 * itself.
+		 *
+		 * This is not precise, but it serves the idea
+		 * to prefer a partition as long as possible,
+		 * to save the cost of resettle as much as
+		 * possible.
+		 */
+		if (i == tg->gb_prefer) {
+			src = i;
+			src_load = load + mgrt;
+			mgrt_load = mgrt;
+		} else
+			load += pi->parts[i].predict_load;
+
+		if (load < min_load) {
+			dst = i;
+			min_load = load;
+			dst_load = load + mgrt;
+		}
+
+		tg_load += mgrt;
+	}
+
+	if (!tg_load)
+		return 0;
+
+	ret = 0;
+	tg->settle_period *= 2;
+	if (src == -1) {
+		/* First settle */
+		tg->gb_prefer = dst;
+		predict_load_add(pi, dst, tg_load);
+		ret = 1;
+	} else if (src != dst) {
+		/* Resettle will cost, be careful */
+		long dst_imb, src_imb, dst_cap, src_cap;
+
+		src_cap = cap_of_part(pi, src);
+		dst_cap = cap_of_part(pi, dst);
+
+		/*
+		 * src_load        dst_load
+		 * ------------ vs ---------
+		 * src_capacity    dst_capacity
+		 *
+		 * Should not cause further imbalancing after
+		 * resettle.
+		 */
+		src_imb = abs(src_load * dst_cap - dst_load * src_cap);
+		dst_imb = abs((src_load - mgrt_load) * dst_cap - (dst_load + 
mgrt_load) * src_cap);
+
+		if (dst_imb <= src_imb) {
+			tg->gb_prefer = dst;
+			predict_load_add(pi, dst, tg_load);
+			tg->settle_period = tg_settle_period * 2;
+			ret = 1;
+		}
+	}
+
+	if (tg->settle_period > tg_settle_period_max)
+		tg->settle_period = tg_settle_period_max;
+
+	return ret;
+}
+
+/*
+ * group_hot() will tell us which cpu is contained in the
+ * preferred CPU partition of the task group of a task.
+ *
+ * return 1 if prefer dst_cpu
+ * return 0 if prefer src_cpu
+ * return -1 if prefer either or neither
+ */
+int group_hot(struct task_struct *p, int src_cpu, int dst_cpu)
+{
+	int ret = -1;
+	struct task_group *tg;
+	struct gb_part_info *pi;
+
+	rcu_read_lock();
+
+	pi = part_info;
+	tg = task_group(p);
+	if (pi && tg->gb_prefer != -1 &&
+	    ctop(pi, src_cpu) != ctop(pi, dst_cpu))
+		ret = (tg->gb_prefer == ctop(pi, dst_cpu));
+
+	rcu_read_unlock();
+	return ret;
+}
+
+void task_tick_gb(struct rq *rq, struct task_struct *curr)
+{
+	struct callback_head *work = &curr->gb_work;
+	struct task_group *tg = task_group(curr);
+	struct gb_part_info *pi = part_info;
+
+	if ((curr->flags & (PF_EXITING | PF_KTHREAD)))
+		return;
+
+	if (!tg->gb_period || !pi)
+		return;
+
+	/* Save it when already satisfied */
+	if (tg->gb_prefer != -1 &&
+	    tg->gb_prefer == ctop(pi, task_cpu(curr)))
+		return;
+
+	/* Try to settle the active group */
+	curr->gb_stamp++;
+	if (curr->gb_stamp > tg->gb_period) {
+		curr->gb_stamp = 0;
+		task_work_add(curr, work, TWA_RESUME);
+	}
+}
+
+void group_balancing_work(struct callback_head *work)
+{
+	int cpu, this_cpu, this_part, this_prefer, best_cpu;
+	struct task_group *this_tg;
+	struct gb_part_info *pi;
+	struct task_struct *best_task;
+	struct cpumask cpus;
+
+	SCHED_WARN_ON(current != container_of(work, struct task_struct, gb_work));
+
+	rcu_read_lock();
+
+	pi = part_info;
+	this_tg = task_group(current);
+	if (!this_tg->gb_period || !pi) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/*
+	 * Settle task group one-by-one help prevent the
+	 * situation when multiple group try to settle the
+	 * same partition at the same time.
+	 *
+	 * However, when bunch of groups trying to settle at
+	 * the same time, there are no guarantee on the
+	 * fairness, some of them may get more chances and
+	 * settle sooner than the others.
+	 *
+	 * So one trick here is to grow the tg_settle_period
+	 * of settled group, to make sure they yield the
+	 * next chances to others.
+	 *
+	 * Another trick here is about prediction, as settle
+	 * group will followed by bunch of task migration,
+	 * the current load of CPU partition can't imply it's
+	 * busyness in future, and we may pick a busy one in
+	 * the end.
+	 *
+	 * Thus we maintain the predict load after each settle,
+	 * so next try will be able to do the prediction and
+	 * avoid to pick those which is already busy enough.
+	 */
+	if (spin_trylock(&settle_lock)) {
+		if (time_after(jiffies, global_settle_next) &&
+		    time_after(jiffies, this_tg->settle_next)) {
+			predict_load_decay(pi);
+
+			global_settle_next = jiffies;
+			if (try_to_settle(pi, this_tg))
+				global_settle_next += global_settle_period;
+
+			this_tg->settle_next = jiffies + this_tg->settle_period;
+		}
+		spin_unlock(&settle_lock);
+	}
+
+	this_cpu = task_cpu(current);
+	this_prefer = this_tg->gb_prefer;
+	this_part = ctop(pi, this_cpu);
+	if (this_prefer == -1 ||
+	    this_part == this_prefer ||
+	    !part_mgrt_lock(pi, this_part, this_prefer)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	cpumask_copy(&cpus, part_cpus(pi, this_prefer));
+
+	/*
+	 * We arrived here when current task A don't prefer
+	 * it's current CPU, but prefer CPUs of partition Y.
+	 *
+	 * In other word, if task A could run on CPUs of
+	 * partition Y, it have good chance to reduce conflict
+	 * with the tasks from other groups, and share hot
+	 * cache with the tasks from the same group.
+	 *
+	 * So here is the main logical of group balancer to
+	 * achieve it's purpose, make sure groups of tasks
+	 * are balanced into groups of CPUs.
+	 *
+	 * If A's current CPU belong to CPU partition X,
+	 * try to find a CPU from partition Y, which is
+	 * running a task prefer partition X, and swap them.
+	 *
+	 * Otherwise, or if can't find such CPU and task,
+	 * just find an idle CPU from partition Y, and do
+	 * migration.
+	 *
+	 * Ideally the migration and swap work will finally
+	 * put the tasks into right places, but the wakeup
+	 * stuff can easily break that by locate an idle CPU
+	 * out of the range.
+	 *
+	 * However, since the whole idea is to gain cache
+	 * benefit and reduce conflict between groups, if
+	 * there are enough idle CPU out there then every
+	 * thing just fine, so let it go.
+	 */
+
+	best_cpu = -1;
+	best_task = NULL;
+	for_each_cpu_and(cpu, &cpus, current->cpus_ptr) {
+		struct task_struct *p;
+		struct task_group *tg;
+
+		WARN_ON(cpu == this_cpu);
+
+		if (cpu == smp_processor_id())
+			continue;
+
+		if (available_idle_cpu(cpu)) {
+			best_cpu = cpu;
+			continue;
+		}
+
+		if (this_part == -1)
+			continue;
+
+		p = rcu_dereference(cpu_rq(cpu)->curr);
+		tg = task_group(p);
+
+		if (!p || (p->flags & PF_EXITING) || is_idle_task(p))
+			continue;
+
+		if (task_cpu(p) == cpu &&
+		    this_part == tg->gb_prefer &&
+		    cpumask_test_cpu(this_cpu, p->cpus_ptr)) {
+			get_task_struct(p);
+			best_task = p;
+			best_cpu = cpu;
+			break;
+		}
+	}
+
+	part_mgrt_unlock(pi, this_part, this_prefer);
+
+	rcu_read_unlock();
+
+	if (best_task) {
+		migrate_swap(current, best_task, best_cpu, this_cpu);
+		put_task_struct(best_task);
+	} else if (best_cpu != -1)
+		migrate_task_to(current, best_cpu);
+}
+
+void gb_stat_show(struct task_group *tg, struct seq_file *sf)
+{
+	int i;
+	struct gb_part_info *pi;
+
+	rcu_read_lock();
+
+	pi = part_info;
+	if (!tg->gb_period || !pi)
+		goto out;
+
+	for_each_part(pi, i) {
+		seq_printf(sf, "PART-%d ", i);
+		seq_printf(sf, "%*pbl ", cpumask_pr_args(part_cpus(pi, i)));
+		seq_printf(sf, "%llu ", tg_load_of_part(pi, tg, i));
+		seq_printf(sf, "%llu ", load_of_part(pi, i));
+		if (tg->gb_prefer == i)
+			seq_printf(sf, " *");
+		seq_putc(sf, '\n');
+	}
+out:
+	rcu_read_unlock();
+}
+
+int set_gb_period(struct task_group *tg, unsigned long period_ms)
+{
+	tg->gb_period = msecs_to_jiffies(period_ms);
+
+	return 0;
+}
+
+unsigned long get_gb_period(struct task_group *tg)
+{
+	return jiffies_to_msecs(tg->gb_period);
+}
+
+void init_cfs_gb(struct task_group *tg)
+{
+	tg->gb_prefer = -1;
+	tg->settle_period = tg_settle_period;
+	tg->settle_next = jiffies + tg->settle_period;
+}
+
+static int build_gb_partition(char *buf, struct gb_part_info *pi, int id)
+{
+	int i, ret;
+	struct cpumask cpus_allowed;
+	struct gb_part *part = &pi->parts[id];
+
+	ret = cpulist_parse(buf, &cpus_allowed);
+	if (ret || cpumask_empty(&cpus_allowed))
+		return -1;
+
+	part->id = id;
+	part->mgrt_on = 0;
+	part->predict_load = 0;
+	cpumask_copy(&part->cpus, &cpus_allowed);
+
+	for_each_cpu(i, &part->cpus)
+		pi->ctop[i] = id;
+
+	return 0;
+}
+
+static inline int start_group_balancer(void)
+{
+	mutex_lock(&gb_mutex);
+	if (!part_info) {
+		mutex_unlock(&gb_mutex);
+		return -1;
+	}
+
+	static_branch_enable(&sched_group_balancer);
+
+	mutex_unlock(&gb_mutex);
+	return 0;
+}
+
+static int gb_prefer_reset(struct task_group *tg, void *data)
+{
+	tg->gb_prefer = -1;
+
+	return 0;
+}
+
+static inline void stop_group_balancer(void)
+{
+	bool reset = false;
+
+	mutex_lock(&gb_mutex);
+	if (gb_enabled()) {
+		reset = true;
+		static_branch_disable(&sched_group_balancer);
+	}
+	mutex_unlock(&gb_mutex);
+
+	if (!reset)
+		return;
+
+	synchronize_rcu();
+
+	rcu_read_lock();
+	walk_tg_tree(gb_prefer_reset, tg_nop, NULL);
+	rcu_read_unlock();
+}
+
+static ssize_t gb_write(struct file *file, const char __user *buffer,
+		       size_t count, loff_t *ppos)
+{
+	int id;
+	size_t ret;
+	unsigned long val;
+	char *kbuf, *start, *end;
+	struct gb_part_info *new, *old;
+
+	if (count < 2)
+		return -EINVAL;
+
+	ret = -ENOMEM;
+	kbuf = kzalloc(count + 2, GFP_KERNEL);
+	if (!kbuf)
+		return ret;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		goto out;
+
+	if (copy_from_user(kbuf, buffer, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	kbuf[count - 1] = ';';
+	kbuf[count] = '\0';
+
+	ret = count;
+	if (!strcmp(kbuf, "enable;")) {
+		if (start_group_balancer())
+			ret = -EINVAL;
+		goto out;
+	} else if (!strcmp(kbuf, "disable;")) {
+		stop_group_balancer();
+		goto out;
+	} else if (sscanf(kbuf, "tg_settle_period=%lu;", &val) == 1) {
+		val = msecs_to_jiffies(val);
+		if (val > tg_settle_period_max)
+			ret = -EINVAL;
+		else
+			tg_settle_period = val;
+		goto out;
+	} else if (sscanf(kbuf, "tg_settle_period_max=%lu;", &val) == 1) {
+		val = msecs_to_jiffies(val);
+		if (val < tg_settle_period)
+			ret = -EINVAL;
+		else
+			tg_settle_period_max = val;
+		goto out;
+	} else if (sscanf(kbuf, "global_settle_period=%lu;", &val) == 1) {
+		global_settle_period = msecs_to_jiffies(val);
+		goto out;
+	}
+
+	if (gb_enabled()) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memset(new->ctop, -1, sizeof(int) * num_possible_cpus());
+
+	id = 0;
+	start = kbuf;
+	end = strchr(start, ';');
+
+	while (end && *end != '\0') {
+		*end = '\0';
+
+		if (new->nr_part >= CPU_PART_MAX)
+			goto out;
+
+		if (!build_gb_partition(start, new, id)) {
+			id++;
+			new->nr_part++;
+		}
+
+		start = end + 1;
+		end = strchr(start, ';');
+	};
+
+	if (new->nr_part < 2)
+		goto out;
+
+	mutex_lock(&gb_mutex);
+	old = part_info;
+	part_info = new;
+	mutex_unlock(&gb_mutex);
+
+	if (old)
+		call_rcu(&old->rcu_head, free_gb_part_info);
+
+	kfree(kbuf);
+	return count;
+
+out:
+	kfree(kbuf);
+	kfree(new);
+	return ret;
+}
+
+static void *gb_start(struct seq_file *s, loff_t *pos)
+{
+	mutex_lock(&gb_mutex);
+	if (!part_info || *pos != 0)
+		return NULL;
+
+	return (void *)&part_info->parts[0];
+}
+
+static void *gb_next(struct seq_file *s, void *p, loff_t *pos)
+{
+	if (++(*pos) >= part_info->nr_part)
+		return NULL;
+
+	return (void *)&part_info->parts[*pos];
+}
+
+static void gb_stop(struct seq_file *s, void *p)
+{
+	mutex_unlock(&gb_mutex);
+}
+
+static int gb_show(struct seq_file *s, void *p)
+{
+	struct gb_part *part = (struct gb_part *)p;
+	u64 load = load_of_part(part_info, part->id);
+
+	if (part->id == 0) {
+		seq_printf(s, "Group Balancer %s\n",
+				gb_enabled() ? "Enabled" : "Disabled");
+		seq_printf(s, "Group Settle Period %u\n",
+				jiffies_to_msecs(tg_settle_period));
+		seq_printf(s, "Group Settle Period Maximum %u\n",
+				jiffies_to_msecs(tg_settle_period_max));
+		seq_printf(s, "Global Settle Period %u\n",
+				jiffies_to_msecs(global_settle_period));
+	}
+
+	seq_printf(s, "PART-%d: ", part->id);
+	seq_printf(s, "%*pbl ", cpumask_pr_args(&part->cpus));
+	seq_printf(s, "load=%llu ", load);
+	seq_putc(s, '\n');
+
+	return 0;
+}
+
+static const struct seq_operations gb_op = {
+	.start = gb_start,
+	.next = gb_next,
+	.stop = gb_stop,
+	.show = gb_show,
+};
+
+static int gb_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &gb_op);
+}
+
+static const struct proc_ops gb_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
+	.proc_open	= gb_open,
+	.proc_read	= seq_read,
+	.proc_write	= gb_write,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release,
+};
+
+static int __init gb_init(void)
+{
+	root_task_group.gb_period = 0;
+	root_task_group.gb_prefer = -1;
+
+	proc_create("gb_ctrl", 0600, NULL, &gb_proc_ops);
+
+	return 0;
+}
+core_initcall(gb_init);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be9..d80f872 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -440,6 +440,12 @@ struct task_group {
  	struct uclamp_se	uclamp[UCLAMP_CNT];
  #endif

+#ifdef CONFIG_GROUP_BALANCER
+	int			gb_prefer;
+	unsigned long		gb_period;
+	unsigned long		settle_period;
+	unsigned long		settle_next;
+#endif
  };

  #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -3118,3 +3124,21 @@ static inline bool is_per_cpu_kthread(struct 
task_struct *p)
  extern void sched_dynamic_update(int mode);
  #endif

+#ifdef CONFIG_GROUP_BALANCER
+extern struct static_key_false sched_group_balancer;
+#define gb_enabled() static_branch_unlikely(&sched_group_balancer)
+extern void init_cfs_gb(struct task_group *tg);
+extern int group_hot(struct task_struct *p, int src_cpu, int dst_cpu);
+extern void task_tick_gb(struct rq *rq, struct task_struct *curr);
+extern void group_balancing_work(struct callback_head *work);
+
+extern void gb_stat_show(struct task_group *tg, struct seq_file *sf);
+extern int set_gb_period(struct task_group *tg, unsigned long period_ms);
+extern unsigned long get_gb_period(struct task_group *tg);
+#else
+#define gb_enabled() (false)
+static inline void init_cfs_gb(struct task_group *tg) { return 0; }
+static inline int group_hot(struct task_struct *p, int src_cpu, int 
dst_cpu) { return -1; }
+static inline void task_tick_gb(struct rq *rq, struct task_struct 
*curr) {};
+static inline void group_balancing_work(struct callback_head *work) {};
+#endif
-- 
1.8.3.1

