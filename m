Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE478570F81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiGLBcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGLBcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:32:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BA8CCAD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:32:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w185so6223592pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aa5j25jT4Uqb2OEMzZj8xdN7H3n4MSoIOnv9qtsL8wk=;
        b=dSfoa7uO6D1Qr94dvLkTsvmTTE7f7g+MHABM+g3nUPpNox199nf6TN4aRAH251E5NL
         GYKJCb6wUPE+mNkC27tzStPjq8o4ZpdI/rOjBt+J9dvVW16fwN+xOE10s534xCQP8rgM
         zPshw6y2ULXjQhIVCkjUeMTGEQLEImomP/zhPABGOSwbYjOCghI/N9H41ApuqMOX6gyK
         t2QEJZKKNxrNgIM2vZDpdFyt8ROpFDCeTDZbEOcwRBsaApFT4fc8eoMV/Zc5IpJPBU4K
         G52PMZwRO15shdTTEvSkJZOFoLgy43tyu/N/V2w8HhKQ4JCl7j5QlG/u6GsMqP2dcDBK
         CB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aa5j25jT4Uqb2OEMzZj8xdN7H3n4MSoIOnv9qtsL8wk=;
        b=tUoc3ncx7sQ5PzSizu9xEpiogiLLjhFd64lOSZyCvX++2aLzqibJC0jbXv/qF1pCjU
         R712/b/gIc9RICTjVnmhCASFNMuZmZ9k6/xmmDgtW+6olA8XJGrDrGAzaB5/bdElVdXA
         lSgnreGjwTl66p0Su8M+aWGJhxxoQ9JWXmFBCoYcgxXOwNdZUcf/bh/l6Xc5yzsdxYyp
         CHFxO+jnR/IcK/sJYJHfgGuWWLe7QMkZTGsUqq05JCELrCaIZaM9iVEPNlZD/csr89un
         avwi4RSobthOTideX+oXDTM3aPc/29+caD9mMJQdEfrEoQ4pCITp7GNBqb28nSvLCjkj
         enxA==
X-Gm-Message-State: AJIora9sfiRuem10CA8M0ITNYEL44Uo6Obhdg/wXdeFybIJb9G1RWqXH
        nrqksccd3qNrnIJ1wTaXy8M=
X-Google-Smtp-Source: AGRyM1ubeYpLWaP9Hr1UZvjnXJKc/Fv/+PBmZdhtpRIOYzkGCNOPvnsAEUGIN5+0pI3YBpXz3xXNfQ==
X-Received: by 2002:a63:244:0:b0:412:a3c3:3ebe with SMTP id 65-20020a630244000000b00412a3c33ebemr17555704pgc.185.1657589539472;
        Mon, 11 Jul 2022 18:32:19 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id g124-20020a625282000000b00518e1251197sm5539620pfb.148.2022.07.11.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:32:18 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v5 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Tue, 12 Jul 2022 09:31:24 +0800
Message-Id: <20220712013125.623338-1-schspa@gmail.com>
X-Mailer: git-send-email 2.37.0
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

To fix it, we need to check migration_disabled flag again to avoid
bad migration.

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
v3 -> v4:
        - Check migrate disabled in find_lock_lowest_rq to avoid not
        necessary check when task rq is not released as Steven advised.
v4 -> v5:
        - Adjust the comment as Steve advised to make it clear.
---
 kernel/sched/deadline.c | 1 +
 kernel/sched/rt.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b5152961b7432..cb3b886a081c3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2238,6 +2238,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed96648409..7c32ba51b6d85 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1998,11 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task was scheduled, set
+			 * "migrate_disabled" and then got preempted, And we
+			 * check task migration disable flag here too.
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
-- 
2.37.0

