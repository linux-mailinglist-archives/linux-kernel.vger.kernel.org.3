Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A65A3EB5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiH1REI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH1REH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:04:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D8731DC7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:04:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 199so6078957pfz.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ZE+SLxr+8LZyiSvKI75oorN6G/xInkB8w/gwpmxDw80=;
        b=A/goGQcZRd0U1dY+gDnAX7JeBZhHbpdQHKgMYCKtBduxa4Lr0rhzfk4XK3bf9Zmd5u
         qzrGEHjsKaTG7m1d+HRjb8zZudBzRxyq7bzaWByTIDfmC1oF78DePrqC89Y0duEu2/mZ
         HXSfFfLS9mGc8OqGR87Re7wXoZ5bt5dW/CSex1GWmo5If0zu51f/ogBmBHaTmzGJIX9n
         OiXzrTCnjs1Nq2+t6NSqedSywW6cmAGyUvBWZGDZDSlG3+fDAUXhCIZfHB9Ou6FySpd+
         NrpmsiLpSVu6NgZZfS/aghFvO7mzQ900E3yaavVqftRUxBtVbu32GIfBTVWDE4hOqjZq
         JLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ZE+SLxr+8LZyiSvKI75oorN6G/xInkB8w/gwpmxDw80=;
        b=tp/wxTI9KB9OPb3vZxlrcJ8DpMgNvzzvKvX/AbRA5xYfjibLx8FOvFNohlmm66tKdj
         iEbeQnwMY1mKez5iUVFq0GvjczPsUQnsx2M4LMPBZ+kkuy7gdnvE6PzarhZ+Cz8XRvVm
         8BAaGecta55y7TeTnIbfdLQa7op1kkSe4O8JPP+UP3pRnxfQ69jC5qJn32J7iljbfd+S
         FdA436P444N+To3zJe3HJDxgRFRHaQ0y8vwraowKqlU6ss05UOwkWFLsOIjSR/919gR0
         zl1LGLwoPmMi5IO630N/5KDVGGclgiPMHPKn5960lWdnCig8qrQXsr5hBnGbBzLjcQMx
         n2Fw==
X-Gm-Message-State: ACgBeo0c8ojda80/kTqaOhfbciD2n2YJKXNQZJ/tsAAEkUXUI/7L+DAX
        EQLjEYE4H+jYRVJMeTQI/kQ=
X-Google-Smtp-Source: AA6agR4xwsE70KIzHg05GP02W5JcyIqqzD7dfVBuv36xIPUXEWPvR6pyFNehwu1P7pXMyNlJd2lWGQ==
X-Received: by 2002:a65:6bca:0:b0:420:712f:ab98 with SMTP id e10-20020a656bca000000b00420712fab98mr10852863pgw.350.1661706244670;
        Sun, 28 Aug 2022 10:04:04 -0700 (PDT)
Received: from localhost.localdomain (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id t6-20020aa79466000000b0053692028ec1sm5487446pfq.34.2022.08.28.10.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 10:04:04 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v8 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Mon, 29 Aug 2022 01:03:02 +0800
Message-Id: <20220828170303.171400-1-schspa@gmail.com>
X-Mailer: git-send-email 2.37.2
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

There is a race scenario, which allows a migration disabled task to
be migrated to another CPU.

When there is a RT task with higher priority, rt sched class was
intended to migrate higher priority task to lowest rq via push_rt_tasks,
this WARNING will happen here.

With the system running on PREEMPT_RT, rt_spin_lock will disable
migration, this will make the problem easier to reproduce.

I have seen this WARNING on PREEMPT_RT, from the logs, there is a race
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

Crash logs are as follows:
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

To fix it, we need to check migration_disabled flag again to avoid
bad migration.

Fixes: 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")

CC: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Schspa Shi <schspa@gmail.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

--

Changelog:
v1 -> v2:
        - Modify commit message to add fixed commit information.
        - Going to retry to push the current running task on this CPU
          away, instead doing nothing for this migrate disabled task.
v2 -> v3:
        - Change migration disabled check to the correct position
v3 -> v4:
        - Check migrate disabled in find_lock_lowest_rq to avoid not
        necessary check when task rq is not released as Steven advised.
v4 -> v5:
        - Adjust the comment as Steve advised to make it clear.
v5 -> v6:
        - Adjust the comment again as Steve advised.
v6 -> v7:
        - Add missing put_task_struct && add this task migration
        disable check to deadline scheduler too as Dietmar advised.
v7 -> v8:
        - Change the BUG on comments to WARN to avoid misunderstanding.
        - Change the comments on DL case for resched_curr rather than
        push the current task.
---
 kernel/sched/deadline.c | 1 +
 kernel/sched/rt.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0ab79d819a0d6..e7eea6cde5cb9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2243,6 +2243,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 55f39c8f42032..57e8cd5c9c267 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2001,11 +2001,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task was scheduled, set
+			 * "migrate_disabled" and then got preempted, so we must
+			 * check the task migration disable flag here too.
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
-- 
2.37.2

