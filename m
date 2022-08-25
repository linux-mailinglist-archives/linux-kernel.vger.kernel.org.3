Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A725A1065
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiHYM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiHYM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:27:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B4B2874
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d16so19114746wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=ey0d/hNz+WJSmxzAyykGWkMsVcT2Dh56xgrxsVx/5u8=;
        b=x+8Ga+cmw96a9rXHj/vdfDsewY1McTjVu5a/ii18p2qC2Pq9XcWL4OIh1ECiJDonQp
         vFddVMFtvuQ69H7C3grF/mZsTuVHt8RLBvpOwCvmQQJKP2K4Kqnj0aLg6DiW+NxAXofd
         kt/TG4d77cNkhHEpax3zYH4rlxGAzlmu4f9hZ1VkQQ2irQZ0SrxYCYlp7G0mwzahFC8U
         OI8KPAEF8TMyd/2pTrOI7fN+YlizmG4H58ZQpsnvCFsrhHP94/NddDSBBhbfZB8F1k2e
         +9WMx6JsXxBLJfoc1oUGYfOsuX1JnvBep7o0E99E83Wo8oTjymiGCUMxK7ajgyJ6F2n/
         bc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ey0d/hNz+WJSmxzAyykGWkMsVcT2Dh56xgrxsVx/5u8=;
        b=uK/PMTzTfHhWtd+4mW7pcCjoJY4LI54/nM5zhVXGpE3yFlyg7MUnVXWs0aU7B054F1
         GHJzGIxh8iYG4SxvqPHPnX3UTbkuZKpgYqC8AwBGTtma/CJPhe2Ab5WSsUMtAJF+FEg8
         Is0Lk8s64Xqxp1C52UhqaagQhiqzC4FxvFVIlNgMrlEmwqCg0sBlZ/0rA8szTEKj+xUY
         qv7NxviJU5GuOjnScGg9yrY80o4okUwnfr7lhbjVj3HtbVIcuD79pBrPe7NL9KijRwLQ
         8SWAX0RTjApG3+9j7ZiDq7vHfTaTPRWEmDihybneqzRsUQXfV8To4sFYtD/+7JtUpngc
         89uA==
X-Gm-Message-State: ACgBeo3xun2G8q8o8pFOpcIVuhsDpg+lYBF6wN0RV2KIGDxwx/rEf/r0
        xRrs5oaYKxtQkpP7tU0m4LWBqQ==
X-Google-Smtp-Source: AA6agR4vV6U5GvuBop4sIQKJT1oVJBqezBH/HO9I94/Eal3M/oIedxhbm1wwynBeZ5iZK5AqkrnF2g==
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3f5 with SMTP id y14-20020a056000168e00b0022087dac3f5mr2126988wrd.166.1661430454594;
        Thu, 25 Aug 2022 05:27:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:55dd:3519:10d3:b07b])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003a5ee64cc98sm5417809wmr.33.2022.08.25.05.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 05:27:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/4] sched/fair: cleanup loop_max and loop_break
Date:   Thu, 25 Aug 2022 14:27:24 +0200
Message-Id: <20220825122726.20819-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825122726.20819-1-vincent.guittot@linaro.org>
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_nr_migrate_break is set to a fix value and never changes so we can
replace it by a define SCHED_NR_MIGRATE_BREAK.

Also, we adjust SCHED_NR_MIGRATE_BREAK to be aligned with the init value
of sysctl_sched_nr_migrate which can be init to different values.

Then, use SCHED_NR_MIGRATE_BREAK to init sysctl_sched_nr_migrate.

The behavior stays unchanged unless you modify sysctl_sched_nr_migrate
trough debugfs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  6 +-----
 kernel/sched/fair.c  | 11 ++++-------
 kernel/sched/sched.h |  6 ++++++
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 64c08993221b..a21e817bdd1c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -142,11 +142,7 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  * Number of tasks to iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
  */
-#ifdef CONFIG_PREEMPT_RT
-const_debug unsigned int sysctl_sched_nr_migrate = 8;
-#else
-const_debug unsigned int sysctl_sched_nr_migrate = 32;
-#endif
+const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
 __read_mostly int scheduler_running;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02b7b808e186..6972a1a29a48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8012,8 +8012,6 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 	return NULL;
 }
 
-static const unsigned int sched_nr_migrate_break = 32;
-
 /*
  * detach_tasks() -- tries to detach up to imbalance load/util/tasks from
  * busiest_rq, as part of a balancing operation within domain "sd".
@@ -8062,7 +8060,7 @@ static int detach_tasks(struct lb_env *env)
 
 		/* take a breather every nr_migrate tasks */
 		if (env->loop > env->loop_break) {
-			env->loop_break += sched_nr_migrate_break;
+			env->loop_break += SCHED_NR_MIGRATE_BREAK;
 			env->flags |= LBF_NEED_BREAK;
 			break;
 		}
@@ -10103,14 +10101,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	struct rq *busiest;
 	struct rq_flags rf;
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
-
 	struct lb_env env = {
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
 		.dst_rq		= this_rq,
 		.dst_grpmask    = sched_group_span(sd->groups),
 		.idle		= idle,
-		.loop_break	= sched_nr_migrate_break,
+		.loop_break	= SCHED_NR_MIGRATE_BREAK,
 		.cpus		= cpus,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
@@ -10219,7 +10216,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			env.dst_cpu	 = env.new_dst_cpu;
 			env.flags	&= ~LBF_DST_PINNED;
 			env.loop	 = 0;
-			env.loop_break	 = sched_nr_migrate_break;
+			env.loop_break	 = SCHED_NR_MIGRATE_BREAK;
 
 			/*
 			 * Go back to "more_balance" rather than "redo" since we
@@ -10251,7 +10248,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 */
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
-				env.loop_break = sched_nr_migrate_break;
+				env.loop_break = SCHED_NR_MIGRATE_BREAK;
 				goto redo;
 			}
 			goto out_all_pinned;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3ccd35c22f0f..d5cfd1b5bfe9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2423,6 +2423,12 @@ extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
+#ifdef CONFIG_PREEMPT_RT
+#define SCHED_NR_MIGRATE_BREAK 8
+#else
+#define SCHED_NR_MIGRATE_BREAK 32
+#endif
+
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-- 
2.17.1

