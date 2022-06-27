Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6D055CD33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiF0PlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiF0PlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:41:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8201619C3F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:41:11 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h85so9968358iof.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s00W1mDas2ROotCpuaXWz753ewwp+FXFxzVhVP96CWA=;
        b=a1S9kw2hWVIi1wNJDSadBp90D9+E1awUzKuvzbcboa4U0nPG0qViKbmK7hDv2aKEtO
         vyYcH8aXg2K+3fl61pUIMKJWTKYuJGk5A2Q/Kcow+m1EMx42501M42a91GjsN0nW+KIk
         N5ZN73a4FFsQWJ8fTGJe0+JCDB2PhFIcNI9gVs71z3d5viMbyGeBcud/NGH7ujsN4Zd4
         wVo6I7bJzTmehOZKgIXcK2bqV6Rve6bx33HSKOyMhEZ9D63Xfy0Y7U9RupxD3uy50a6b
         91wUfsgDfNUr66QoL+sEv7XbbV/lhmgOstZstW+g+T+gy4EidDWHTSKlFqzc9GNRRZKX
         /rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s00W1mDas2ROotCpuaXWz753ewwp+FXFxzVhVP96CWA=;
        b=n7aDyf00EKoWN5oxHpQppjSASIHZBwuONon0bmcxODTuGcw2wzZY8/zzFp9TrQiArr
         zyX7YiC91tJnQA3lZ+EZWAZQddqPLZEuZb0RLFFLDTozeugr5cMDrLqjESa9tIlS/x1o
         MQyjSn8zz0ouHIpM7CtN3PCr3/H2b8DHj0BlqTRe83JmRDN9xwqJj4NaT7zmfmr1hrgH
         EKJ5OOFCdlt0UIkdrYXwry0utf3Z8y+tQZs6cZ3XHj4zwn5lm+vb/N0Vqci9A4NA9eCx
         PP6wRh4q67dEhgt9fqF5qq+xHPMrZsRB9qo/arh2hvcvKgOdXFaSaRZK5p9gGXs+rTlQ
         lkgA==
X-Gm-Message-State: AJIora+Ji+98DAAb29gnJec2NN9EHwjwzhSUxu5WzT4uOkpeGWUrrPKH
        uWpZNcCTstOfrpDGygbcre8=
X-Google-Smtp-Source: AGRyM1vSZr7hfUk224TiOmG3VMbHGejpb+qqza+Cyxa61heehJtXTsclsb+jPd+S8vpRnaTo9M9DLQ==
X-Received: by 2002:a05:6602:883:b0:674:ed5d:c6f9 with SMTP id f3-20020a056602088300b00674ed5dc6f9mr6951479ioz.162.1656344470806;
        Mon, 27 Jun 2022 08:41:10 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id k9-20020a6b3c09000000b00669a3f60e99sm5336035iob.31.2022.06.27.08.41.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2022 08:41:10 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v2] sched/rt: fix bad task migration for rt tasks
Date:   Mon, 27 Jun 2022 23:40:51 +0800
Message-Id: <20220627154051.92599-1-schspa@gmail.com>
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

---
 kernel/sched/core.c | 6 ++++++
 kernel/sched/rt.c   | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecd..3003baa28d2d 100644
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
index 8c9ed9664840..6a1efccdc122 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2115,6 +2115,15 @@ static int push_rt_task(struct rq *rq, bool pull)
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
+	/*
+	 * It is possible the task has running for a while, we need to check
+	 * task migration disable flag again. If task migration is disabled,
+	 * the retry code will retry to push the current running task on this
+	 * CPU away.
+	 */
+	if (unlikely(is_migration_disabled(next_task)))
+		goto retry;
+
 	/* We might release rq lock */
 	get_task_struct(next_task);
 
-- 
2.24.3 (Apple Git-128)

