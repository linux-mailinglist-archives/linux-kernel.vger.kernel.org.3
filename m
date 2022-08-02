Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17450587B46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiHBLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiHBLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:03:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E044F656;
        Tue,  2 Aug 2022 04:03:18 -0700 (PDT)
Date:   Tue, 02 Aug 2022 11:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659438196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXNVaiJ88X6B9vRwZaMF5TykDK+rWRqoy9ICuls3qBo=;
        b=aULBAbB1vXGpHrNY36ZwgNYXJAqTJBVqQjxAsiFuvu716JerHD6DgOlm4cNfUF+3SRHuVs
        SDcWZYKyV3kxPdIK9xrAT9ds0JfrOA6SP02KXBBxGc0SuIdm9L9ObDJJ8SwmU/26M6vnKJ
        NbgvhJpQfh5IZRnCZxcOJaO4NfP6BVyHNZpvLZXJMis/ybgHUN0LRT20TXRQP4k/WjYPbi
        EV3IxudluJtebHD4bgEbVgmPzlAqv+LfO810FkICiWKdTMkT1q1Ir0+Vd0HS/NKl7k019H
        lqVrsPxPQgIn+207DN6UQvoOt1PMBSAjcAes4kDeCOKQ1Iiis5dwu2i8Tt3eUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659438196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXNVaiJ88X6B9vRwZaMF5TykDK+rWRqoy9ICuls3qBo=;
        b=msNAzvOUUHYeAdsyj+uVojfRIg+tYP3uaeXB4arIHLRLT9tlOCFa9s4RyAwSzi3CpWqfk/
        RLCI/ZkvrPOQ44Bg==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Use sched_dl_entity's dl_density in
 dl_task_fits_capacity()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220729111305.1275158-4-dietmar.eggemann@arm.com>
References: <20220729111305.1275158-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <165943819521.15455.1190018314589445418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b3f53daacc74c0ca0922e14a8cb793cb2db4c6d1
Gitweb:        https://git.kernel.org/tip/b3f53daacc74c0ca0922e14a8cb793cb2db4c6d1
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Fri, 29 Jul 2022 13:13:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 12:32:46 +02:00

sched/deadline: Use sched_dl_entity's dl_density in dl_task_fits_capacity()

Save a multiplication in dl_task_fits_capacity() by using already
maintained per-sched_dl_entity (i.e. per-task) `dl_runtime/dl_deadline`
(dl_density).

  cap_scale(dl_deadline, cap) >= dl_runtime

  dl_deadline * cap >> SCHED_CAPACITY_SHIFT >= dl_runtime

  cap >= dl_runtime << SCHED_CAPACITY_SHIFT / dl_deadline

  cap >= (dl_runtime << BW_SHIFT / dl_deadline) >>
				BW_SHIFT - SCHED_CAPACITY_SHIFT

  cap >= dl_density >> BW_SHIFT - SCHED_CAPACITY_SHIFT

__sched_setscheduler()->__checkparam_dl() ensures that the 2 corner
cases (if conditions) `runtime == RUNTIME_INF (-1)` and `period == 0`
of to_ratio(deadline, runtime) are not met when setting dl_density in
__sched_setscheduler()-> __setscheduler_params()->__setparam_dl().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220729111305.1275158-4-dietmar.eggemann@arm.com
---
 kernel/sched/sched.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 86fc360..3ccd35c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -320,21 +320,6 @@ struct dl_bw {
 	u64			total_bw;
 };
 
-/*
- * Verify the fitness of task @p to run on @cpu taking into account the
- * CPU original capacity and the runtime/deadline ratio of the task.
- *
- * The function will return true if the CPU original capacity of the
- * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
- * task and false otherwise.
- */
-static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
-{
-	unsigned long cap = arch_scale_cpu_capacity(cpu);
-
-	return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
-}
-
 extern void init_dl_bw(struct dl_bw *dl_b);
 extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
@@ -2899,6 +2884,21 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 enum cpu_util_type type,
 				 struct task_struct *p);
 
+/*
+ * Verify the fitness of task @p to run on @cpu taking into account the
+ * CPU original capacity and the runtime/deadline ratio of the task.
+ *
+ * The function will return true if the original capacity of @cpu is
+ * greater than or equal to task's deadline density right shifted by
+ * (BW_SHIFT - SCHED_CAPACITY_SHIFT) and false otherwise.
+ */
+static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
+{
+	unsigned long cap = arch_scale_cpu_capacity(cpu);
+
+	return cap >= p->dl.dl_density >> (BW_SHIFT - SCHED_CAPACITY_SHIFT);
+}
+
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
