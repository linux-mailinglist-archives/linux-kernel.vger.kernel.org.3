Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE555889E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiFWTXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWTWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:22:51 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF577073
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:29:49 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p69so261390iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KeJy/uJPlwSbFXm4rft8p7tFUfPIQLz3AgKIDbedi0=;
        b=VqArSnqz1ZQT9WPBUuINDS+yf1t0O6D4kiuHKGrF4UzGukVZleZWMedSbGpoF4oBSP
         kWAELyoNNdh6Nc3KWC6GRmDeHLjtueSiGntIDgL/DFlqu92CSwQTS0AKaToGqPACMjer
         1q0+89/YeL0R3iHStM7yDQ+bmzzAZ7Bw5AgTRVrBdT3T1fzrokZgxOOSI445zv2rNfqh
         eaTgT51leqnaoGgvnFOlFkv7gvTwTQ6GU7N48nwWq8r3W42VrmB/Hbkw+074KBEHJP1R
         hCEMKL1rWCPuOy0kHKBr6FhWvDlrFcNSe/qWyCBODS2yBYs74qMo+ncXdeviwP1z5ZjR
         crpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KeJy/uJPlwSbFXm4rft8p7tFUfPIQLz3AgKIDbedi0=;
        b=V2VMBJENcmu4PEo0gWrXnIgapRsmWQPkbLxdUvDOHV3NKYBnI3B56VCnGTLdnPnGKp
         2/wddFCaUaY7Eznq1PFlu0ph3+ZfiwfyLSvN87RXDxRl2o6AGfIu4CyAsM4joFybqnEO
         1G790ygeqzECuBCzyPaQF7q08zvXMex7Qh2BQ86NbtrPYBj63xo29DuTUw6D3HhZhmsU
         L8vx16SX+mAAUypiYSc48WrOHsEgRGCOijqCf/b5LM+LQRph05lTQRwROGWKhNNuJsa3
         xlLDSuU5tsTeKypYHD4yI1dsM93frdgz6AAeGjP/3pGAREk8BDq31mMKwGVgAIyjft0v
         GG/g==
X-Gm-Message-State: AJIora9P1V++cSOxtZTjE2x8K1nPQv9+7ZXdb1F7cmqTwVWijd1rtZ3B
        YrUpRfiG7fExAmShAlW9mq8=
X-Google-Smtp-Source: AGRyM1vzAsLQBWT5Zc27UxoJnvM8yhTJYr9GrtfGfso5rHLqe8Cc+Wpu1GebFKrbzzejACqaZ9CHzQ==
X-Received: by 2002:a05:6602:15c6:b0:66d:3c9:4d9d with SMTP id f6-20020a05660215c600b0066d03c94d9dmr5803616iow.140.1656008988305;
        Thu, 23 Jun 2022 11:29:48 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id y25-20020a027319000000b0032b5e78bfcbsm42578jab.135.2022.06.23.11.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 11:29:47 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH] sched: fix bad task migration for rt tasks
Date:   Fri, 24 Jun 2022 02:29:32 +0800
Message-Id: <20220623182932.58589-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 kernel/sched/deadline.c | 3 ++-
 kernel/sched/rt.c       | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b5152961b743..4424f799f6d3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2238,7 +2238,8 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
-				     !task_on_rq_queued(task))) {
+				     !task_on_rq_queued(task)) ||
+				     is_migration_disabled(task)) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..3bcd169fed0e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1998,12 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task has running for a while,
+			 * And we check task migration disable flag again.
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
-				     !task_on_rq_queued(task))) {
+				     !task_on_rq_queued(task) ||
+				     is_migration_disabled(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
-- 
2.24.3 (Apple Git-128)

