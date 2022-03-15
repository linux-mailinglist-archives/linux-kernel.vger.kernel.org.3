Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB62F4D965F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbiCOIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbiCOIcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27D64C40F;
        Tue, 15 Mar 2022 01:30:58 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:30:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9aTs/P1+obr23x07/kcEyux4yGJ7VgnSTxRlcS8hX9Q=;
        b=A9UGIW+ApAy1QcmZhZm40EDkx568H5c6Nf8it0/z0Eb4XpfoRf0TZiHw5n95aPNnaVqyxB
        3FJSLSixjZwhkrgeTma1Wmy4PM7mX0sfBGKuGpP3mm2j4f7jTIosNdwf4mVPPzXwaoZ6y4
        F0xeZ0xngiVwG56/RLz66bSAXpnGCI36DepC7afToqJm3hKHcs7Rj3vmC43Uk85CxQ3Mpo
        H9wdDQ7FqdJjDJajzdwjT7rpgW/WSbl7PQvpSuoa6KABbSUBn8b/QnMzGaeuI/P/PEJRbE
        6/5tRw5y/7uLozRYqvZdnNsEqM9YabZbXrNqXHNmmTnmLwLQjic82rMf2vE2hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9aTs/P1+obr23x07/kcEyux4yGJ7VgnSTxRlcS8hX9Q=;
        b=a3nqu/M0fNK2YQmIZt1aEx91Kzh+qMEeaf7uYGQMNsyhKezwOPirJ+6DfoZVkANlRFT6XT
        GmOt1mPfT/TudVBQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Reorganize, clean up and optimize
 kernel/sched/core.c dependencies
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733305635.16921.864659737535928482.tip-bot2@tip-bot2>
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

Commit-ID:     e66f6481a8c748ce2d4b37a3d5e10c4dd0d65e80
Gitweb:        https://git.kernel.org/tip/e66f6481a8c748ce2d4b37a3d5e10c4dd0d65e80
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 23 Feb 2022 08:17:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:33 +01:00

sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies

Use all generic headers from kernel/sched/sched.h that are required
for it to build.

Sort the sections alphabetically.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 81 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 22de537..5eaa421 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6,7 +6,73 @@
  *
  *  Copyright (C) 1991-2002  Linus Torvalds
  */
+#include <linux/highmem.h>
+#include <linux/hrtimer_api.h>
+#include <linux/ktime_api.h>
+#include <linux/sched/signal.h>
+#include <linux/syscalls_api.h>
+#include <linux/debug_locks.h>
+#include <linux/prefetch.h>
+#include <linux/capability.h>
+#include <linux/pgtable_api.h>
+#include <linux/wait_bit.h>
+#include <linux/jiffies.h>
+#include <linux/spinlock_api.h>
+#include <linux/cpumask_api.h>
+#include <linux/lockdep_api.h>
+#include <linux/hardirq.h>
+#include <linux/softirq.h>
+#include <linux/refcount_api.h>
+#include <linux/topology.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/cond_resched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/nohz.h>
+#include <linux/sched/rseq_api.h>
+#include <linux/sched/rt.h>
+
+#include <linux/blkdev.h>
+#include <linux/context_tracking.h>
+#include <linux/cpuset.h>
+#include <linux/delayacct.h>
+#include <linux/init_task.h>
+#include <linux/interrupt.h>
+#include <linux/ioprio.h>
+#include <linux/kallsyms.h>
+#include <linux/kcov.h>
+#include <linux/kprobes.h>
+#include <linux/llist_api.h>
+#include <linux/mmu_context.h>
+#include <linux/mmzone.h>
+#include <linux/mutex_api.h>
+#include <linux/nmi.h>
+#include <linux/nospec.h>
+#include <linux/perf_event_api.h>
+#include <linux/profile.h>
+#include <linux/psi.h>
+#include <linux/rcuwait_api.h>
+#include <linux/sched/wake_q.h>
+#include <linux/scs.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/vtime.h>
+#include <linux/wait_api.h>
+#include <linux/workqueue_api.h>
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+# include <linux/entry-common.h>
+#endif
+
+#include <uapi/linux/sched/types.h>
+
+#include <asm/switch_to.h>
+#include <asm/tlb.h>
+
 #define CREATE_TRACE_POINTS
+#include <linux/sched/rseq_api.h>
 #include <trace/events/sched.h>
 #undef CREATE_TRACE_POINTS
 
@@ -14,22 +80,15 @@
 #include "stats.h"
 #include "autogroup.h"
 
-#include <linux/nospec.h>
-#include <linux/blkdev.h>
-#include <linux/jump_label.h>
-#include <linux/kcov.h>
-#include <linux/scs.h>
-
-#include <asm/switch_to.h>
-#include <asm/tlb.h>
+#include "autogroup.h"
+#include "pelt.h"
+#include "smp.h"
+#include "stats.h"
 
 #include "../workqueue_internal.h"
 #include "../../fs/io-wq.h"
 #include "../smpboot.h"
 
-#include "pelt.h"
-#include "smp.h"
-
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
