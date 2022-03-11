Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DB4D5CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiCKIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbiCKIAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:00:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981CE17B88B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:59:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n15so7085158plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:from:subject
         :content-transfer-encoding;
        bh=vOvJ37zIB8haVkp6mIWofU75Y97TlQR4WzbbVcTkV7c=;
        b=V6eMIFiq3cIct16aAM7FIgMNKIddsQWb+nPzHJcHoSAfHaO8oe3c7IUUeCYI/zxwCQ
         7YanKap5vi+nocTahP4VcTrsMhbXVn3JX2TYXDUy77n4TmJg9UxoSY3F4p27r5S1tYWQ
         NpaPDegr4+xHTkgKtRbw7l8N3BnV2xScm5nw5BKA96aFzf9LBXu/0qxtft7eh/7LKNw7
         PjMbvoxBv/uv5fu4V5OXNnlUNgNjv7fYe0/u4PclwavodvIINLZUbL3LyaSph0o4c0iR
         Ly/pIQ7SwOSrNxe1AacwaL8xygstfAhsGWyghnA6LjIZqE67wTA3HuLuCf3LwLfWLn9w
         QeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :from:subject:content-transfer-encoding;
        bh=vOvJ37zIB8haVkp6mIWofU75Y97TlQR4WzbbVcTkV7c=;
        b=Hz7lAahxuLtzM7fxQBaKtZrjnhAsclTzshTQr+XOoiOuxYjBhxDRTcBX5IBotP/J4d
         rfaWoStGf2mmmZWfKFmYiKFwy40rrMruIuK1eKJZMS8eFgAXAetcRgZD7MVUi552/Ph0
         ZfkmU0BYINPSl6yXT+9nZi51LeYbMlyp/XtrylziFrcOB6dKCrwGmGH1YyBequl7/TvG
         7KFfN8K7brq3TX00PJ3UHqbEgNlbGqU1ANPnT4oigyMFXMybpB0DlBv9tkCG5jMmXN1a
         aGj2ao0ZbPRrXxIjQC/gch8bWgfsTQvMqquSrGrd1UmLy32dwibG/ycl46Y7jyLHnZJ8
         EQdQ==
X-Gm-Message-State: AOAM530Q5IJe5JdpJw7H7iyocvv0QZRhcPotGJCKX60elc0NKK3kpWm/
        EieMB7e4/9vBXTxMhc3sYeIWAycvs/CzHMUQg/w=
X-Google-Smtp-Source: ABdhPJzzpFyOwFq1qgBy3euWMg57cvYBS0U+JOlgHH06GZyrZ4kYZvaRHDz4kcSO3gPIfUHiIERxzA==
X-Received: by 2002:a17:902:9682:b0:153:2b0b:298f with SMTP id n2-20020a170902968200b001532b0b298fmr4795793plp.70.1646985557407;
        Thu, 10 Mar 2022 23:59:17 -0800 (PST)
Received: from [10.255.146.103] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a191900b001bf53bab69dsm8145637pjg.35.2022.03.10.23.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 23:59:16 -0800 (PST)
Message-ID: <f87a8c0d-527d-a9bc-9653-ff955e0e95b4@bytedance.com>
Date:   Fri, 11 Mar 2022 15:58:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        bsegall@google.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        zhouchengming@bytedance.com, songmuchun@bytedance.com,
        zhengqi.arch@bytedance.com, zhoufeng.zf@bytedance.com,
        ligang.bdlg@bytedance.com
From:   chenying <chenying.kernel@bytedance.com>
Subject: Subject: [PATCH] sched/fair: prioritize normal task over sched_idle
 task with vruntime offset
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a time offset to the se->vruntime when the idle sched_entity
is enqueued, so that the idle entity will always be on the right of
the non-idle in the runqueue. This can allow non-idle tasks to be
selected and run before the idle.

A use-case is that sched_idle for background tasks and non-idle
for foreground. The foreground tasks are latency sensitive and do
not want to be disturbed by the background. It is well known that
the idle tasks can be preempted by the non-idle tasks when waking up,
but will not distinguish between idle and non-idle when pick the next
entity. This may cause background tasks to disturb the foreground.

Test results as below:

~$ ./loop.sh &
[1] 764
~$ chrt -i 0 ./loop.sh &
[2] 765
~$ taskset -p 04 764
~$ taskset -p 04 765

~$ top -p 764 -p 765
top - 13:10:01 up 1 min,  2 users,  load average: 1.30, 0.38, 0.13
Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
%Cpu(s): 12.5 us,  0.0 sy,  0.0 ni, 87.4 id,  0.0 wa,  0.0 hi, 0.0 si,  
0.0 st
KiB Mem : 16393492 total, 16142256 free,   111028 used,   140208 buff/cache
KiB Swap:   385836 total,   385836 free,        0 used. 16037992 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM TIME+ COMMAND
   764 chenyin+  20   0   12888   1144   1004 R 100.0  0.0 1:05.12 loop.sh
   765 chenyin+  20   0   12888   1224   1080 R   0.0  0.0 0:16.21 loop.sh

The non-idle process (764) can run at 100% and without being disturbed by
the idle process (765).

~$ cat /sys/fs/cgroup/cpu/background/cgroup.procs
765
~$ cat /sys/fs/cgroup/cpu/foreground/cgroup.procs
764
~$ top -p 764 -p 765
top - 13:17:19 up 9 min,  2 users,  load average: 2.00, 1.64, 0.86
Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
%Cpu(s): 12.5 us,  0.0 sy,  0.0 ni, 87.5 id,  0.0 wa,  0.0 hi, 0.0 si,  
0.0 st
KiB Mem : 16393492 total, 16139576 free,   112732 used,   141184 buff/cache
KiB Swap:   385836 total,   385836 free,        0 used. 16036236 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM TIME+ COMMAND
   764 chenyin+  20   0   12888   1144   1004 R 100.0  0.0 8:23.51 loop.sh
   765 chenyin+  20   0   12888   1224   1080 R   0.0  0.0 0:16.21 loop.sh

The non-idle group can run at 100% and without being disturbed by the
idle group.

Co-developed-by: chengming zhou <zhouchengming@bytedance.com>
Signed-off-by: chenying <chenying.kernel@bytedance.com>
---
  include/linux/sched.h   |  1 +
  kernel/sched/core.c     |  6 +++++-
  kernel/sched/debug.c    |  2 ++
  kernel/sched/fair.c     | 26 ++++++++++++++++++++++----
  kernel/sched/features.h |  2 ++
  kernel/sched/sched.h    |  1 +
  6 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..20412f353cad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -545,6 +545,7 @@ struct sched_entity {
      u64                exec_start;
      u64                sum_exec_runtime;
      u64                vruntime;
+    u64                vruntime_offset;
      u64                prev_sum_exec_runtime;

      u64                nr_migrations;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9745613d531c..beb9d6f54c52 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4239,6 +4239,7 @@ static void __sched_fork(unsigned long 
clone_flags, struct task_struct *p)
      p->se.prev_sum_exec_runtime    = 0;
      p->se.nr_migrations        = 0;
      p->se.vruntime            = 0;
+    p->se.vruntime_offset        = 0;
      INIT_LIST_HEAD(&p->se.group_node);

  #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -7211,8 +7212,11 @@ static void __setscheduler_params(struct 
task_struct *p,

      if (dl_policy(policy))
          __setparam_dl(p, attr);
-    else if (fair_policy(policy))
+    else if (fair_policy(policy)) {
          p->static_prio = NICE_TO_PRIO(attr->sched_nice);
+        p->se.vruntime_offset = 0;
+    } else if (idle_policy(policy))
+        p->se.vruntime_offset = sched_idle_vruntime_offset;

      /*
       * __sched_setscheduler() ensures attr->sched_priority == 0 when
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index aa29211de1bf..701496626830 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -460,6 +460,7 @@ static void print_cfs_group_stats(struct seq_file 
*m, int cpu, struct task_group

      PN(se->exec_start);
      PN(se->vruntime);
+    PN(se->vruntime_offset);
      PN(se->sum_exec_runtime);

      if (schedstat_enabled()) {
@@ -969,6 +970,7 @@ void proc_sched_show_task(struct task_struct *p, 
struct pid_namespace *ns,

      PN(se.exec_start);
      PN(se.vruntime);
+    PN(se.vruntime_offset);
      PN(se.sum_exec_runtime);

      nr_switches = p->nvcsw + p->nivcsw;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..6a2cba63b4a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -92,6 +92,8 @@ static unsigned int 
normalized_sysctl_sched_wakeup_granularity    = 1000000UL;

  const_debug unsigned int sysctl_sched_migration_cost    = 500000UL;

+unsigned long long sched_idle_vruntime_offset    = 2592000000000000; /* 
30 days */
+
  int sched_thermal_decay_shift;
  static int __init setup_sched_thermal_decay_shift(char *str)
  {
@@ -535,10 +537,19 @@ static inline u64 min_vruntime(u64 min_vruntime, 
u64 vruntime)
      return min_vruntime;
  }

+static inline s64  vtime_diff(struct sched_entity *a,
+                struct sched_entity *b)
+{
+    if (sched_feat(VRUNTIME_OFFSET))
+        return (s64)(a->vruntime_offset - b->vruntime_offset);
+    else
+        return 0;
+}
+
  static inline bool entity_before(struct sched_entity *a,
                  struct sched_entity *b)
  {
-    return (s64)(a->vruntime - b->vruntime) < 0;
+    return (s64)(a->vruntime - b->vruntime + vtime_diff(a, b)) < 0;
  }

  #define __node_2_se(node) \
@@ -4445,7 +4456,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct 
sched_entity *curr)
          return;

      se = __pick_first_entity(cfs_rq);
-    delta = curr->vruntime - se->vruntime;
+    delta = curr->vruntime - se->vruntime + vtime_diff(curr, se);

      if (delta < 0)
          return;
@@ -7036,7 +7047,7 @@ static unsigned long wakeup_gran(struct 
sched_entity *se)
  static int
  wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
  {
-    s64 gran, vdiff = curr->vruntime - se->vruntime;
+    s64 gran, vdiff = curr->vruntime - se->vruntime + vtime_diff(curr, se);

      if (vdiff <= 0)
          return -1;
@@ -11131,7 +11142,7 @@ bool cfs_prio_less(struct task_struct *a, struct 
task_struct *b, bool in_fi)
       * min_vruntime_fi, which would have been updated in prior calls
       * to se_fi_update().
       */
-    delta = (s64)(sea->vruntime - seb->vruntime) +
+    delta = (s64)(sea->vruntime - seb->vruntime + vtime_diff(sea, seb)) +
          (s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);

      return delta > 0;
@@ -11190,6 +11201,9 @@ static void task_fork_fair(struct task_struct *p)
      }
      place_entity(cfs_rq, se, 1);

+    if (task_has_idle_policy(p))
+        se->vruntime_offset = sched_idle_vruntime_offset;
+
      if (sysctl_sched_child_runs_first && curr && entity_before(curr, 
se)) {
          /*
           * Upon rescheduling, sched_class::put_prev_task() will place
@@ -11655,6 +11669,10 @@ int sched_group_set_idle(struct task_group *tg, 
long idle)
          rq_lock_irqsave(rq, &rf);

          grp_cfs_rq->idle = idle;
+        if (idle)
+            se->vruntime_offset = sched_idle_vruntime_offset;
+        else
+            se->vruntime_offset = 0;
          if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
              goto next_cpu;

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1cf435bbcd9c..f59f507e6dba 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -100,3 +100,5 @@ SCHED_FEAT(LATENCY_WARN, false)

  SCHED_FEAT(ALT_PERIOD, true)
  SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(VRUNTIME_OFFSET, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be905739..1bc0c0756fd4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -95,6 +95,7 @@ extern __read_mostly int scheduler_running;

  extern unsigned long calc_load_update;
  extern atomic_long_t calc_load_tasks;
+extern unsigned long long sched_idle_vruntime_offset;

  extern void calc_global_load_tick(struct rq *this_rq);
  extern long calc_load_fold_active(struct rq *this_rq, long adjust);
-- 
2.11.0

