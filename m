Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5157597C56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbiHRDqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbiHRDqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:46:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F6895680
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:46:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 81so418268pfz.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w96IsTb3GQtW46GghcS8avnysfYYRuHuTPsKLYARCUM=;
        b=Lbo0sm4b3VCe1e81KQcnj0Uo8jxOJvs0JV470Z7MXEVfLFKMrGFdXzPO3wtGUc1Vx2
         McH+g/o4Tt0J36WdBLo8DKhUTxYyXD0zOxeutkn8tjXdTcpOAOy0RpLbThn/bq3BECcU
         VxjKDNQDmf8jxjNSkytt+ogUAeQjXFOKiR3/N77b2q57XTHF63vFfOcOc2hNzni0JzCb
         VU7fNDPNef766Zf9+1vBgfmsUsjghjrfwp7uAC7rAfRREK6gOu/jgjLGcLEVcy+0Zp/Z
         bO+waBUkH5gohM068ET0g1BkRYrdyY28Dd8Zrzte81IkRG1dXGRQSu2RuE6BN1bdo77S
         MvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w96IsTb3GQtW46GghcS8avnysfYYRuHuTPsKLYARCUM=;
        b=c5xeKkx0XR9cu/ObnTexd5vqgx0Dl7ayDQbJ6mekQxGVnpWUsSMDaJN4ipixH/2lJK
         SDijyXxYUiqS2Cb45XjWYQ2t4rXZPGX0s1iKlGGUq6o4BAkZODjXXBBS+ArTdLT1LL2O
         MQ8lPrzhiuYDdUfcLPdcFklAua3vvH15A3phvSDn9NvjIDPpT2DScfzSD1PIkm/6MljK
         bnE8XUuRSUYHpaEPzcadDIJ5xbq47veHpKZN6rD5qU1Geqqk3KllwqR7iGHuunw8XL10
         EZF9aWba9LrpoKakkqWhOc3zgxV8LF7DSDNMDHWi80zGCE2ZKahFF//t8cGEjKj5MQV3
         tkTg==
X-Gm-Message-State: ACgBeo2ml8eeDcg9V/CTKhrUdzpbxGWaIrZyvCZabL8u2eTUBOOwnESw
        O3m7jNUkn2uztj4owECmHJpyhg==
X-Google-Smtp-Source: AA6agR6a7JJX+IywiQrBnUNjn49NfgqaXo2Uaudj+SXY+rDDEYMjstMBGpLSoxX4YsRpnauagG6law==
X-Received: by 2002:a05:6a00:21c5:b0:52b:fc9c:295b with SMTP id t5-20020a056a0021c500b0052bfc9c295bmr1201176pfj.56.1660794368842;
        Wed, 17 Aug 2022 20:46:08 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:46:08 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 7/9] sched/fair: allow changing cgroup of new forked task
Date:   Thu, 18 Aug 2022 11:43:41 +0800
Message-Id: <20220818034343.87625-8-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818034343.87625-1-zhouchengming@bytedance.com>
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
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
 include/linux/sched.h |  5 ++---
 kernel/sched/core.c   | 30 +++++++-----------------------
 kernel/sched/fair.c   |  7 +++++++
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..0b296e855dee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -96,10 +96,9 @@ struct task_group;
 #define TASK_WAKEKILL			0x0100
 #define TASK_WAKING			0x0200
 #define TASK_NOLOAD			0x0400
-#define TASK_NEW			0x0800
 /* RT specific auxilliary flag to mark RT lock waiters */
-#define TASK_RTLOCK_WAIT		0x1000
-#define TASK_STATE_MAX			0x2000
+#define TASK_RTLOCK_WAIT		0x0800
+#define TASK_STATE_MAX			0x1000
 
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8e3f1c3f0b2c..157f7461a08a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4550,11 +4550,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	__sched_fork(clone_flags, p);
 	/*
-	 * We mark the process as NEW here. This guarantees that
+	 * We mark the process as running here. This guarantees that
 	 * nobody will actually run it, and a signal or other external
 	 * event cannot wake it up and insert it on the runqueue either.
 	 */
-	p->__state = TASK_NEW;
+	p->__state = TASK_RUNNING;
 
 	/*
 	 * Make sure we do not leak PI boosting priority to the child.
@@ -4672,7 +4672,6 @@ void wake_up_new_task(struct task_struct *p)
 	struct rq *rq;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	WRITE_ONCE(p->__state, TASK_RUNNING);
 #ifdef CONFIG_SMP
 	/*
 	 * Fork balancing, do it here and not earlier because:
@@ -10290,36 +10289,19 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
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
@@ -11155,7 +11137,9 @@ struct cgroup_subsys cpu_cgrp_subsys = {
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
index eba8a64f905a..e0d34ecdabae 100644
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
+	if (!p->on_rq && !p->se.sum_exec_runtime)
+		return;
+
 	detach_task_cfs_rq(p);
 
 #ifdef CONFIG_SMP
-- 
2.37.2

