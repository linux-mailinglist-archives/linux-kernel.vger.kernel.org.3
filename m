Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9224E92FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiC1LKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiC1LKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:10:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F9A19C2E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:09:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u22so12283887pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ysOm8PgGtjqQhy6MYxQBZHkMDtCGlto+4XRTR7NrZo=;
        b=BvvMGaVU+RwwGmIs+EBVwwfXLNB6uQBxOfQ0rvHdrxZgUibgOSQuJttPLCkfI405oc
         AzmuZwNY4u1PSPLBBtUvqh7tIE3yuIspXwrhEt8uEld45FuWtJ+TG5MmX7ZiCY+31hjJ
         iE4b8Dpr1wQaJRxpdG04xMZFQ5Py507AxaweEcTKnGJlDCiU4OmxqLGXclnxiuiGJoR1
         fBi+Nl3N30xYClFDwWDTEZ4tSJhNU8BGFfozqDr9mqyeCbV1K3FzC0knO9hJ4X0wUHGZ
         t1sfsxMgUzicUrPsj5PPZ1bq7weIX+OD8uYfNCnSo012pIok9/QSfYCzwIS8tm3e1MqS
         vy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ysOm8PgGtjqQhy6MYxQBZHkMDtCGlto+4XRTR7NrZo=;
        b=6yCszfg4LWDpTE7dmUE4dwRnnLF6qd0PyeldMYTkvfDFURQLzGmcLbrXTTNysJTJgR
         /FBdFdedJ6c7h66z8tEuDgqDgxCYeMViia/z45voRGfQn8XLMgQZiK3Qrv5FV0GF7iq1
         2nF6BosWJGYbcxSWmLI8CRcUHDJYJiLUubCAz9Y3iiIRTvisQZtOCVB7e5pzP26v7CTW
         u3JL1oZpGGkxkDf3KnPQjzQxrDds57XJpMpEO1foOVQE1TW+XakG9jo5i4KXPP3ToBdF
         hBPQ7Y9kDEREZNCtT0SkLz4JETWu+glrHDQfAvfpAFyijbLRn+i7MAvZylUuVXR2XrNG
         fCZg==
X-Gm-Message-State: AOAM531QAECSxDAyw4vNisZBWo3+jfDyF3iu1CrLERaVlB2mK/qPKY2s
        nSIErf/CmLOFv0hUMww1OxBK3g==
X-Google-Smtp-Source: ABdhPJwpfSSijLhJvlpMEWIqrE0NRUHF88WKE6gGLEYEjb5lXjxJ6iETlzqNsMetKNJ1zzRcLBqfhA==
X-Received: by 2002:a63:416:0:b0:386:66e:33d9 with SMTP id 22-20020a630416000000b00386066e33d9mr10037505pge.146.1648465743251;
        Mon, 28 Mar 2022 04:09:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:aaa0:b49b:a46e:8f1f:6bcd])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a000cd000b004fadb6f0290sm15794968pfv.11.2022.03.28.04.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:09:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/fair: fix broken bandwidth control with nohz_full
Date:   Mon, 28 Mar 2022 19:07:51 +0800
Message-Id: <20220328110751.39987-1-zhouchengming@bytedance.com>
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

With nohz_full enabled on cpu, the scheduler_tick() will be stopped
when only one CFS task left on rq.

scheduler_tick()
  task_tick_fair()
    entity_tick()
      update_curr()
        account_cfs_rq_runtime(cfs_rq, delta_exec) --> stopped

So that running task can't account its runtime periodically, but
the cfs_bandwidth hrtimer still __refill_cfs_bandwidth_runtime()
periodically. Later in one period, the task would account very
big delta_exec, which cause the cfs_rq to be throttled for a
long time.

There are two solutions for the problem, the first is that we
can check in sched_can_stop_tick() if current task's cfs_rq
have runtime_enabled, in which case we don't stop tick. But
it will make nohz_full almost useless in cloud environment
that every container has the cpu bandwidth control setting.

The other is what this patch implemented, cfs_bandwidth hrtimer
would sync unaccounted runtime from all running cfs_rqs with
tick stopped, just before __refill_cfs_bandwidth_runtime().
Also do the same thing in tg_set_cfs_bandwidth().

A testcase to reproduce:
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
only see nr_throttled > 0 on nohz_full system. The problem
is gone in test with this patch.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/core.c  |  4 ++++
 kernel/sched/fair.c  | 30 ++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  3 +++
 3 files changed, 37 insertions(+)

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
index ee0664c9d291..ebda70a0e3a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5339,6 +5339,34 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
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
@@ -5350,6 +5378,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
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

