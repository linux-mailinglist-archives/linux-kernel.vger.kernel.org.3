Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3987259836B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiHRMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244762AbiHRMsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9ED58DF2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 12so1233939pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bLfxQYzGYYYZqztSzkQL1RsyTc0N7Fycpp5UcJb0qUk=;
        b=X1/vaKItXFKta54D+wi+5fxJ0JfyZESqFx0GoacFTobNMSFq1Az+VhxFvpcXTG6LmX
         IUeM7yG2Lu3jshqDK4yU3rt8m9yIpJ4CYub41UU5be2jPD83VH5BGZdXZ5A1zVjsWcyN
         FqiiYgZ/cx+lTuDZxC0/Em5nZk4Ad0vXSxkdjGAHRFcPgPyFgiJ8yRyDLH2bGI1uAeel
         uLiGRAiK7yuB+++jxB6gQyvEyrWaOFax0mIkrs4x3cylJ8rqHdaIrAVhmznx95qEdP4u
         iK6xOrK9NjiZtXlst1/dS4CwQV5xEeW1HUtQVouW4dp3pUD2kr26Cd7HlTm+4WpOeGfE
         clhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bLfxQYzGYYYZqztSzkQL1RsyTc0N7Fycpp5UcJb0qUk=;
        b=5a0UIkkrdhcoLckSSsg6IDhushXhj/TfW5BBwWbTECukMw5dGXthO3dHCO/2uqTu8r
         bjW4GouW7DO3M+c79dnoF4QQXkL9ZkKAz+cJTwmkHDPHNbzzNMQM1SUzrKD6Y00BUPWR
         aWeBqXD7ufkMFu6VmIBgsSLvatDYgNivz1T7TLJdF8Ep5aQJ0I3+GBo8xpX+IBDfdm4L
         cgnePbpwmcyNU17JWdQcQ9y+8PU2O06N9wbKjyfGwJEJgHl41hpRgvAVp4cqCbWZ3XiM
         6rj0Tu84dNePYKy0Oh/TL6wkOTQgP9XxM3lUYfj5kHB0s3ihUwgwXjy8934oCavaq48E
         HU2w==
X-Gm-Message-State: ACgBeo1UYplJyoEsMlYrlkzMDgsbfcD1miCA1CGCAmzOWMLNFi9m6oZG
        V4pxtRngCcLzr91UmeGK/bh3bg==
X-Google-Smtp-Source: AA6agR4tiuEDH0g2Q+Xaa/VF3X8Bl4h3Xw2KDh5aV7UVX/4S8I7X8Sqo5JRDFsoB9fJ1fjv/Vv5Cog==
X-Received: by 2002:a05:6a00:174b:b0:52f:c4d1:d12d with SMTP id j11-20020a056a00174b00b0052fc4d1d12dmr2775939pfc.41.1660826928469;
        Thu, 18 Aug 2022 05:48:48 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:48 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 7/9] sched/fair: allow changing cgroup of new forked task
Date:   Thu, 18 Aug 2022 20:48:03 +0800
Message-Id: <20220818124805.601-8-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818124805.601-1-zhouchengming@bytedance.com>
References: <20220818124805.601-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
introduce a TASK_NEW state and an unnessary limitation that would fail
when changing cgroup of new forked task.

Because at that time, we can't handle task_change_group_fair() for new
forked fair task which hasn't been woken up by wake_up_new_task(),
which will cause detach on an unattached task sched_avg problem.

This patch delete this unnessary limitation by adding check before do
detach or attach in task_change_group_fair().

So cpu_cgrp_subsys.can_attach() has nothing to do for fair tasks,
only define it in #ifdef CONFIG_RT_GROUP_SCHED.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/core.c | 25 +++++--------------------
 kernel/sched/fair.c |  7 +++++++
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8e3f1c3f0b2c..14819bd66021 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10290,36 +10290,19 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	sched_unregister_group(tg);
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
-	int ret = 0;
 
 	cgroup_taskset_for_each(task, css, tset) {
-#ifdef CONFIG_RT_GROUP_SCHED
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
-#endif
-		/*
-		 * Serialize against wake_up_new_task() such that if it's
-		 * running, we're sure to observe its full state.
-		 */
-		raw_spin_lock_irq(&task->pi_lock);
-		/*
-		 * Avoid calling sched_move_task() before wake_up_new_task()
-		 * has happened. This would lead to problems with PELT, due to
-		 * move wanting to detach+attach while we're not attached yet.
-		 */
-		if (READ_ONCE(task->__state) == TASK_NEW)
-			ret = -EINVAL;
-		raw_spin_unlock_irq(&task->pi_lock);
-
-		if (ret)
-			break;
 	}
-	return ret;
+	return 0;
 }
+#endif
 
 static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 {
@@ -11155,7 +11138,9 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
+#ifdef CONFIG_RT_GROUP_SCHED
 	.can_attach	= cpu_cgroup_can_attach,
+#endif
 	.attach		= cpu_cgroup_attach,
 	.legacy_cftypes	= cpu_legacy_files,
 	.dfl_cftypes	= cpu_files,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eba8a64f905a..c319b0bd2bc1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11840,6 +11840,13 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_change_group_fair(struct task_struct *p)
 {
+	/*
+	 * We couldn't detach or attach a forked task which
+	 * hasn't been woken up by wake_up_new_task().
+	 */
+	if (READ_ONCE(p->__state) == TASK_NEW)
+		return;
+
 	detach_task_cfs_rq(p);
 
 #ifdef CONFIG_SMP
-- 
2.37.2

