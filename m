Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DFF56C415
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiGHVSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiGHVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:18:47 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0232A73F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:18:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b24so16721688qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4qwJ3oH3c96s2+W+UPsxF8YxUBe2XAcgFyN/VJQi4o=;
        b=Rs4+WNVg7uXE9Tw/n8Z+70CqyKSO2A4ndXvYqdEYdc/X8DQyO9fJmbmzrDqhdjIIw2
         5bcGT1d4AmyiBNNX5SvPKHMeMr1M8aNS5RjaWapahVPMK83ibkzoXh3CMjCzQrFHODl5
         0WPp7AubZ1+Rk61AhRJjlqefOZj5EfAZZXmbUmCXCheOPd0ZrPGwgW96ImAoZ2aavMMd
         unhMX8z+l9BlNyT143K5tIfjkasmVrB6ggq47sBRVRSXyU3qAeSBx5Oe+KaR5oomVRaQ
         ihe0iVkLAaMnzgULpDw856lQt21i4UV+mJ1UaOyXjFEX/AZePel3TryhmRxedJkTxCez
         6kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4qwJ3oH3c96s2+W+UPsxF8YxUBe2XAcgFyN/VJQi4o=;
        b=jZoVNb4Wj8nu7i97tRuhI3ZYqoacGumBiUtxcNw66kWAXPxHeTV4uReyVrhh9d4gtg
         ctZJXQz6PmcWNCrmXcReS7UZBODm0dVX3vgyufap/504mRxIp6MY7+JWWc86U3+3lbsa
         rzjSXg6hLZq7yB6KNv0c9BcVmMqnu/SF1YgYzS3bysRBrX7VZHs0ayAplOrVPW/uwhoQ
         bEZWD+5wI66acLB/FJnH+Au8RihMvsWnAE9+E8LFGrhQ5GzxQYX11zYl1r5BHgsX2/AN
         TBKgMTZU9MabD2EyKAvW8isVX9742XXvTqTVkbQ1kNijPE4r1+CTwuaqIhLywh5kRhcY
         78hQ==
X-Gm-Message-State: AJIora8KirSZUSwuBXeLEIiWI9IJPlCnmgXO7iekit0xj9GdoH5eAJwD
        949OzaI7Bds9gThACU/46WI=
X-Google-Smtp-Source: AGRyM1ur/HI9IvmtO0cpRDLwlzQlAkuVmkBnkENvXklYyEVvcCGc/auoaPylbekK9J++hlI6GeKXtQ==
X-Received: by 2002:a37:69c6:0:b0:6b4:7c2b:d54c with SMTP id e189-20020a3769c6000000b006b47c2bd54cmr3934586qkc.474.1657315124780;
        Fri, 08 Jul 2022 14:18:44 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id ew7-20020a05622a514700b0031e9d9635d4sm3659728qtb.23.2022.07.08.14.18.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2022 14:18:39 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v4 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Sat,  9 Jul 2022 05:17:54 +0800
Message-Id: <20220708211755.73637-1-schspa@gmail.com>
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
        necessary check when task rq is not released as Steven adviced.
---
 kernel/sched/deadline.c | 1 +
 kernel/sched/rt.c       | 3 +++
 2 files changed, 4 insertions(+)

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
index 8c9ed96648409..0e0bc9aeaa394 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1998,11 +1998,14 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task has running for a while,
+			 * And we check task migration disable flag here.
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

