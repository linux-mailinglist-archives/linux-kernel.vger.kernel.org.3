Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308684D2432
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350762AbiCHW0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350729AbiCHW0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:26:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D34583B8;
        Tue,  8 Mar 2022 14:25:26 -0800 (PST)
Date:   Tue, 08 Mar 2022 22:25:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646778325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbuZJRANWRttBApNafCE2xDUdDf+IGSekYoAaklxqVI=;
        b=q4/ydDLeZivDwQG8us9T7amvz2C2q7u4afrCWR7HimWKLSwYzujJU4zoX7+IdR19mWDzo2
        hMWcXHhAzsEzzjGyy961mBi7Kv2H5CFDC9exm5hZH+P+CE7Ey3ly3WiciNffyfrYmTt56m
        U93pn9NBp+KBVaECkKdxN4DqAtJtYpeQWMGR9v1599MGcyx757Gdj586eAaJtOfeS4JSB1
        XjcaKZLbIuQ0V/szFw/xRehNxp+tdcZuKm3QLy1osBBSaC95+Xxx4wBYLoI7KUht7oWOlL
        md1TFOphziJPgsVEIsmz+AxKD2bvMpVC8QYti+W1y9f66ireiR42hsMhXvewDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646778325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbuZJRANWRttBApNafCE2xDUdDf+IGSekYoAaklxqVI=;
        b=8qJKZ7XJk3TMULsQ5d/rAZ2lE165UQSG4vLmfY6bcW99rILI57F5gw/Ae2nY5cHe8U7rEE
        MIUsuyZTKp/A9aAQ==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Remove unused def_dl_bandwidth
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220302183433.333029-2-dietmar.eggemann@arm.com>
References: <20220302183433.333029-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <164677832389.16921.264306598144344142.tip-bot2@tip-bot2>
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

Commit-ID:     eb77cf1c151c4a1c2147cbf24d84bcf0ba504e7c
Gitweb:        https://git.kernel.org/tip/eb77cf1c151c4a1c2147cbf24d84bcf0ba504e7c
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 02 Mar 2022 19:34:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 16:08:38 +01:00

sched/deadline: Remove unused def_dl_bandwidth

Since commit 1724813d9f2c ("sched/deadline: Remove the sysctl_sched_dl
knobs") the default deadline bandwidth control structure has no purpose.
Remove it.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20220302183433.333029-2-dietmar.eggemann@arm.com
---
 kernel/sched/core.c     | 1 -
 kernel/sched/deadline.c | 7 -------
 kernel/sched/sched.h    | 1 -
 3 files changed, 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3aafc15..d342c4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9420,7 +9420,6 @@ void __init sched_init(void)
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
 	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
-	init_dl_bandwidth(&def_dl_bandwidth, global_rt_period(), global_rt_runtime());
 
 #ifdef CONFIG_SMP
 	init_defrootdomain();
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 62f0cf8..ed4251f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -18,8 +18,6 @@
 #include "sched.h"
 #include "pelt.h"
 
-struct dl_bandwidth def_dl_bandwidth;
-
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
 	return container_of(dl_se, struct task_struct, dl);
@@ -423,12 +421,10 @@ void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
 void init_dl_bw(struct dl_bw *dl_b)
 {
 	raw_spin_lock_init(&dl_b->lock);
-	raw_spin_lock(&def_dl_bandwidth.dl_runtime_lock);
 	if (global_rt_runtime() == RUNTIME_INF)
 		dl_b->bw = -1;
 	else
 		dl_b->bw = to_ratio(global_rt_period(), global_rt_runtime());
-	raw_spin_unlock(&def_dl_bandwidth.dl_runtime_lock);
 	dl_b->total_bw = 0;
 }
 
@@ -2731,9 +2727,6 @@ void sched_dl_do_global(void)
 	int cpu;
 	unsigned long flags;
 
-	def_dl_bandwidth.dl_period = global_rt_period();
-	def_dl_bandwidth.dl_runtime = global_rt_runtime();
-
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3da5718..a8b8516 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2333,7 +2333,6 @@ extern void resched_cpu(int cpu);
 extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 
-extern struct dl_bandwidth def_dl_bandwidth;
 extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
 extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
