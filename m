Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2974C8EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiCAPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiCAPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:25:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E748AE6A;
        Tue,  1 Mar 2022 07:24:44 -0800 (PST)
Date:   Tue, 01 Mar 2022 15:24:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646148283;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hd7tXxubAvDRFWkEM5saPUusFfGJxYdpuYbN9VmGSls=;
        b=q/T3tpMIR+haeZEP6OOIVUp1atGeX715n3DmaXQyWQA5dH/abc9MnRW5bvEF+ImptPR28S
        kTw6hwQ+snJsA0xwkcdaiXVhf5j7kkLkhA0nc+Kvut2IwZHVE3GvhKbLOYqTRB0GE7wiPm
        OtSv42VulVcwKXHMpFZyiSK0GyKjnht470r9nPLdpkNORoz7t8mfpC62vgs8II/H9C0P5a
        66AgASJ/lOrhmK9QpsOovQA2bg+DOXWeLiyO24/3GIGc3ZblvHiErsCV+DBQgDRXnXKltP
        qembwS4d6oPoNwa16UpxXuwFFwHIgpMuhKoppdqNMVMSdydAi2JPfsxg1P9A/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646148283;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hd7tXxubAvDRFWkEM5saPUusFfGJxYdpuYbN9VmGSls=;
        b=P5tYTrBvIPxZz6qWpH8M/zUh1qtF5WPO1XoHOdjWKNz2Qv1iPAZZKj3NUcOw+fBCAeYAAK
        SFEUKRxaF8iobvCg==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpuacct: Optimize away RCU read lock
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220220051426.5274-2-zhouchengming@bytedance.com>
References: <20220220051426.5274-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <164614828189.16921.12676564993932566366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dc6e0818bc9a0336d9accf3ea35d146d72aa7a18
Gitweb:        https://git.kernel.org/tip/dc6e0818bc9a0336d9accf3ea35d146d72aa7a18
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Sun, 20 Feb 2022 13:14:25 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Mar 2022 16:18:38 +01:00

sched/cpuacct: Optimize away RCU read lock

Since cpuacct_charge() is called from the scheduler update_curr(),
we must already have rq lock held, then the RCU read lock can
be optimized away.

And do the same thing in it's wrapper cgroup_account_cputime(),
but we can't use lockdep_assert_rq_held() there, which defined
in kernel/sched/sched.h.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220220051426.5274-2-zhouchengming@bytedance.com
---
 include/linux/cgroup.h | 2 --
 kernel/sched/cpuacct.c | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 75c1514..9a109c6 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -791,11 +791,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
 
 	cpuacct_charge(task, delta_exec);
 
-	rcu_read_lock();
 	cgrp = task_dfl_cgroup(task);
 	if (cgroup_parent(cgrp))
 		__cgroup_account_cputime(cgrp, delta_exec);
-	rcu_read_unlock();
 }
 
 static inline void cgroup_account_cputime_field(struct task_struct *task,
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 3078005..f79f884 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -337,12 +337,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
 
-	rcu_read_lock();
+	lockdep_assert_rq_held(cpu_rq(cpu));
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
 		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
-
-	rcu_read_unlock();
 }
 
 /*
