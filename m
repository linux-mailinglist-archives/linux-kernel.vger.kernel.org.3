Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB0F4EE9F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbiDAIv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAIv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:51:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ED21E6E9C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:49:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j8so1900881pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIGoUUuhF2trN+8s2IEJECJRPNl8iNJleJ9NeKUohCc=;
        b=6Gjdj2zA0RE3yi9pJlYumGW/qq/XisZb7XVABsK/oLvx028dXh2JXbA2ggbSgL6+AK
         1b0uC7oykM3gdgLKAnfpuZQw03/etEvgNWKQkPFnHodOlLNV09QQwiDdRHb5u0w+CLnv
         NiB2zKcUjnVKfcgaGa45K+wKxT9+EvMJDEX4LnDVLhmOIi9V4+7XdNUVBNxFokfO+8p+
         CrGT0rljSz4807n7w6jMNBePKeIkeJ5w7eGde90F2sPEx14pxWkHy6HjH7kJkgCp5kJB
         P4pI7J7/daHoqR7hqmPS3luZbydxYfC1m1CVOX2CsZqlB6FmqLJSuHbM1wdX0L9mcybe
         2DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIGoUUuhF2trN+8s2IEJECJRPNl8iNJleJ9NeKUohCc=;
        b=6106ujZRJ/hCJ1M9JauKa6+twxJEVjhotp/8yLWDZPFHKJtQxrb9nJnIWqtACPUpe9
         47QQHYXTmU/eLSKvjWS9juxyArWPdjNSps2mhCqneQmSe+MgPbsp+kmGR3EfkR3S21jE
         OQyhOGZUllf4Eox0ZHudMD2Y2k9lkIRnkct20KsGgi6U/UD2Nrl66XPd3xygHBxkF8pA
         pv0/KEUKPbcIDRa4EQz/t7ykiAzx1o4yKYD8OVz5nqFwLbqvlMPKUn+GDhryTtuu3EcM
         15fwt9ZlbVAXC0KlFZcg0oidh4DPSZ7Bm8anzb92/7tL+FwCpjpioRcSh4Lk4Yt9CbUM
         mpXw==
X-Gm-Message-State: AOAM533h5SFIxcDH4g8JmXIp0wr3Zpo3qfOpC6ON0uGnqrtHYBcpBR2k
        XAx2mf3rnBwDab+yPhe1FyMNig==
X-Google-Smtp-Source: ABdhPJxRVzAEPUB9Bv/yha6Je8TYom6mQvLD6fuOLojuv/Wa8e5sH/r8HWU0JxHhcmoLiCwETa58uw==
X-Received: by 2002:a17:902:c2d8:b0:154:b384:917b with SMTP id c24-20020a170902c2d800b00154b384917bmr9455436pla.58.1648802978077;
        Fri, 01 Apr 2022 01:49:38 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6d:3f10:69f0:2593:647c:15eb])
        by smtp.gmail.com with ESMTPSA id y9-20020a056a00180900b004faa45a2230sm2317408pfa.210.2022.04.01.01.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:49:37 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, pauld@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] sched/fair: fix broken bandwidth control with NOHZ_FULL
Date:   Fri,  1 Apr 2022 16:49:19 +0800
Message-Id: <20220401084919.76025-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With NOHZ_FULL enabled on cpu, the scheduler_tick() will be stopped
when only one CFS task left on rq.

scheduler_tick()
  task_tick_fair()
    entity_tick()
      update_curr()
        account_cfs_rq_runtime(cfs_rq, delta_exec) --> stopped

So that running task can't account its runtime periodically, but
the cfs_bandwidth hrtimer still __refill_cfs_bandwidth_runtime()
periodically. Later the task would accumulated a long delta_exec
and account in one period, which cause the cfs_rq to be throttled
for a long time.

There are real use-cases of group bandwidth control with NOHZ_FULL.
Like the container orchestration userspace code allocates a whole CPU
by setting quota == period, or 3 cpus as 3*period etc, in which cases
an isolated task is expected to run uninterrupted (only task in the
system affined to that cpu, nohz_full, nocbs etc). There are radio
network setups where the packet processing is isolated like this but
the system as a whole is managed by container orchestration so
everything has cfs bandwidth quotas set.

There are two solutions for the problem, the first is that we can
veto sched_can_stop_tick() if current task's task_group has bandwidth,
in which case we don't stop the tick.

The other is what this patch implemented, cfs_bandwidth hrtimer would
sync unaccounted runtime from all running cfs_rqs with tick stopped,
just before __refill_cfs_bandwidth_runtime(). Also do the same thing
in tg_set_cfs_bandwidth() before __refill_cfs_bandwidth_runtime().

This implementation has a flaw that it also won't throttle when it's
out of bandwidth. That is, 'echo "50000 100000" > test/cpu.max' would
not stop after 50ms of runtime is spent, it would only stop after 100ms.
But it should be no problem for normal use-case. If it used over quota,
it would need to repay that debt before it can run again, so it just
misbehave in that period. Also we shouldn't use bandwidth control with
NOHZ_FULL for CPU sharing (quota < period), which doesn't make much
sense and won't work right.

Append a testcase to reproduce:
```
cd /sys/fs/cgroup
echo "+cpu" > cgroup.subtree_control

mkdir test
echo "105000 100000" > test/cpu.max

echo $$ > test/cgroup.procs
taskset -c 1 bash -c "while true; do let i++; done"
```
Ctrl-C and cat test/cpu.stat to see if nr_throttled > 0.

The above testcase uses period 100ms and quota 105ms, would
only see nr_throttled > 0 on NOHZ_FULL system. The problem
is gone in test with this patch.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - add a use-case description shared by Phil in commit message, thanks Phil.
 - add description of this implementation's flaw pointed out by Benjamin.
 - change to use optimistic locking in for-each-nohz-cpu, thanks Benjamin.
---
 kernel/sched/core.c  |  4 ++++
 kernel/sched/fair.c  | 33 +++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d575b4914925..17b5e3d27401 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10443,6 +10443,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	 */
 	if (runtime_enabled && !runtime_was_enabled)
 		cfs_bandwidth_usage_inc();
+
+	if (runtime_was_enabled)
+		sync_cfs_bandwidth_runtime(cfs_b);
+
 	raw_spin_lock_irq(&cfs_b->lock);
 	cfs_b->period = ns_to_ktime(period);
 	cfs_b->quota = quota;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..6309ca6fdf05 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5340,6 +5340,37 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
+{
+	unsigned int cpu;
+	struct rq *rq;
+	struct rq_flags rf;
+	struct cfs_rq *cfs_rq;
+	struct task_group *tg;
+
+	tg = container_of(cfs_b, struct task_group, cfs_bandwidth);
+
+	for_each_online_cpu(cpu) {
+		if (!tick_nohz_tick_stopped_cpu(cpu))
+			continue;
+
+		rq = cpu_rq(cpu);
+		cfs_rq = tg->cfs_rq[cpu];
+
+		if (!READ_ONCE(cfs_rq->curr))
+			continue;
+
+		rq_lock_irqsave(rq, &rf);
+		if (cfs_rq->curr) {
+			update_rq_clock(rq);
+			update_curr(cfs_rq);
+		}
+		rq_unlock_irqrestore(rq, &rf);
+	}
+}
+#endif
+
 extern const u64 max_cfs_quota_period;
 
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
@@ -5351,6 +5382,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	int idle = 0;
 	int count = 0;
 
+	sync_cfs_bandwidth_runtime(cfs_b);
+
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58263f90c559..57f9da9c50c1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2351,9 +2351,12 @@ static inline void sched_update_tick_dependency(struct rq *rq)
 	else
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
 }
+
+extern void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 #else
 static inline int sched_tick_offload_init(void) { return 0; }
 static inline void sched_update_tick_dependency(struct rq *rq) { }
+static inline void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b) {}
 #endif
 
 static inline void add_nr_running(struct rq *rq, unsigned count)
-- 
2.35.1

