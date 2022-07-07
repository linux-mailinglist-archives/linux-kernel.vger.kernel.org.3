Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A5156A89C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiGGQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiGGQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:50:28 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D22B193
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:50:27 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id bs20so23587155qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeoVWyPwz07I1Nnl+i5YaHasVV89GCVp9lVH7dgFfZI=;
        b=OjqVvRiVRowBZwupb4NlAztpG6HNYwWnsO7LCVOXX4ya4p6OQXqlTgmqeeoVkAPcwH
         Sr6IlnQMvf3pyZmfgUXn5ML7PPPr2bRJZkd7d5PgTSHYO8YleLCKsCXo7w5vQwcPuOxw
         Vw6S+g1DUYdE4m53IUoa+ifXUqFDyTL1o6CA6LNWKNVWskuf2II/KLBoEToNHo8QmMgZ
         2JqBudIH2nwMKFx8PQW3r5F8Zs+ZeHeLr54qQFJ5EptiQ/tScZR3bMdQIVHhxBXQMJB+
         DDEo61htHR4MRoI6oMxdst2vH4tuACf7RWlWDjekFKnPFPq35kuXzz1Nuu+JSysoCaQD
         eFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeoVWyPwz07I1Nnl+i5YaHasVV89GCVp9lVH7dgFfZI=;
        b=ifosHTPHSun0ibGHry3aTdDFGUscsUztA3rlwSru08gQm+Y0ghUVofF09QUkBQ6Bem
         NbI0fLa1u2nvKDOfmhZXwucDa+70KeyRnvlLypYgrGm/KcNHBgfWaZ2FOxT9uNCsrLC4
         JlwbTVuxwju0zy+7zRWb+qVnndBnS5/Ed+5qxzH+qxX57nxXayJTgBtgSs8EI1vgBkBZ
         Fevy0VN+XdpUs46NuW1mB++mPAaR5Coxh/5dlisMqZcpoqUJxG12CHO3dUiR/KL91PVW
         31FFJl7ikQanTs2F/B9QKV+WcGijWfUBdb6W0BoYzndB7soKzKTq524WmgeSA8AbMHry
         bKIw==
X-Gm-Message-State: AJIora81JHEvo9g6UD2ef6nFjf+eBJVte2kMVgV0tIbbe1TsbwuLsCvX
        mXprdAlGRz0JfsRizkSPkfE=
X-Google-Smtp-Source: AGRyM1twDaEtb0efCyo0nv2A1ZhFcHGO7F4Hv+XMGFBXaLbdmRg7pk2Mwix2+6/nBPTpCMGRRCCS8A==
X-Received: by 2002:a05:6214:500e:b0:473:2eec:3633 with SMTP id jo14-20020a056214500e00b004732eec3633mr3269042qvb.106.1657212626649;
        Thu, 07 Jul 2022 09:50:26 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a290e00b006b46ad28ba7sm10565856qkp.84.2022.07.07.09.50.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:50:25 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Date:   Fri,  8 Jul 2022 00:50:14 +0800
Message-Id: <20220707165014.77127-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
allow find_lock_lowest_rq to pick a task with migration disabled.
This commit is intended to push the current running task on this CPU
away.

There is a race scenarios, which allows a migration disabled task to
be migrated to another CPU.

When there is a RT task with higher priority, rt sched class was
intended to migrate higher priority task to lowest rq via push_rt_tasks,
this BUG will happen here.

With the system running on PREEMPT_RT, rt_spin_lock will disable
migration, this will make the problem easier to reproduce.

I have seen this crash on PREEMPT_RT, from the logs, there is a race
when trying to migrate higher priority tasks to the lowest rq.

Please refer to the following scenarios.

           CPU0                                  CPU1
------------------------------------------------------------------
push_rt_task
  check is_migration_disabled(next_task)
                                        task not running and
                                        migration_disabled == 0
  find_lock_lowest_rq(next_task, rq);
    _double_lock_balance(this_rq, busiest);
      raw_spin_rq_unlock(this_rq);
      double_rq_lock(this_rq, busiest);
        <<wait for busiest rq>>
                                            <wakeup>
                                        task become running
                                        migrate_disable();
                                          <context out>
  deactivate_task(rq, next_task, 0);
  set_task_cpu(next_task, lowest_rq->cpu);
    WARN_ON_ONCE(is_migration_disabled(p));
      ---------OOPS-------------

Crash logs as fellowing:
[123671.996430] WARNING: CPU: 2 PID: 13470 at kernel/sched/core.c:2485
set_task_cpu+0x8c/0x108
[123671.996800] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[123671.996811] pc : set_task_cpu+0x8c/0x108
[123671.996820] lr : set_task_cpu+0x7c/0x108
[123671.996828] sp : ffff80001268bd30
[123671.996832] pmr_save: 00000060
[123671.996835] x29: ffff80001268bd30 x28: ffff0001a3d68e80
[123671.996844] x27: ffff80001225f4a8 x26: ffff800010ab62cb
[123671.996854] x25: ffff80026d95e000 x24: 0000000000000005
[123671.996864] x23: ffff00019746c1b0 x22: 0000000000000000
[123671.996873] x21: ffff00027ee33a80 x20: 0000000000000000
[123671.996882] x19: ffff00019746ba00 x18: 0000000000000000
[123671.996890] x17: 0000000000000000 x16: 0000000000000000
[123671.996899] x15: 000000000000000a x14: 000000000000349e
[123671.996908] x13: ffff800012f4503d x12: 0000000000000001
[123671.996916] x11: 0000000000000000 x10: 0000000000000000
[123671.996925] x9 : 00000000000c0000 x8 : ffff00027ee58700
[123671.996933] x7 : ffff00027ee8da80 x6 : ffff00027ee8e580
[123671.996942] x5 : ffff00027ee8dcc0 x4 : 0000000000000005
[123671.996951] x3 : ffff00027ee8e338 x2 : 0000000000000000
[123671.996959] x1 : 00000000000000ff x0 : 0000000000000002
[123671.996969] Call trace:
[123671.996975]  set_task_cpu+0x8c/0x108
[123671.996984]  push_rt_task.part.0+0x144/0x184
[123671.996995]  push_rt_tasks+0x28/0x3c
[123671.997002]  task_woken_rt+0x58/0x68
[123671.997009]  ttwu_do_wakeup+0x5c/0xd0
[123671.997019]  ttwu_do_activate+0xc0/0xd4
[123671.997028]  try_to_wake_up+0x244/0x288
[123671.997036]  wake_up_process+0x18/0x24
[123671.997045]  __irq_wake_thread+0x64/0x80
[123671.997056]  __handle_irq_event_percpu+0x110/0x124
[123671.997064]  handle_irq_event_percpu+0x50/0xac
[123671.997072]  handle_irq_event+0x84/0xfc

To fix it, we need to check migration_disabled flag again and retry
to retry to push the current running task on this CPU away.

Fixes: 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")

Signed-off-by: Schspa Shi <schspa@gmail.com>

--

Changelog:
v1 -> v2:
        - Modify commit message to add fixed commit information.
        - Going to retry to push the current running task on this CPU
          away, instead doing nothing for this migrate disabled task.
v2 -> v3:
        - Change migration disabled check to the correct position
---
 kernel/sched/core.c |  6 ++++++
 kernel/sched/rt.c   | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecdc..3003baa28d2d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2512,6 +2512,11 @@ int push_cpu_stop(void *arg)
 	if (!lowest_rq)
 		goto out_unlock;
 
+	if (unlikely(is_migration_disabled(p))) {
+		p->migration_flags |= MDF_PUSH;
+		goto out_double_unlock;
+	}
+
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
 		deactivate_task(rq, p, 0);
@@ -2520,6 +2525,7 @@ int push_cpu_stop(void *arg)
 		resched_curr(lowest_rq);
 	}
 
+out_double_unlock:
 	double_unlock_balance(rq, lowest_rq);
 
 out_unlock:
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed96648409..7948c9cfb472d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2153,6 +2153,17 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
+	/*
+	 * It is possible the task has running for a while, we need to check
+	 * task migration disable flag again. If task migration is disabled,
+	 * the retry code will retry to push the current running task on this
+	 * CPU away.
+	 */
+	if (unlikely(is_migration_disabled(next_task))) {
+		put_task_struct(next_task);
+		goto retry;
+	}
+
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
-- 
2.37.0

