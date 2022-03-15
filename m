Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE24D964E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbiCOIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbiCOIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F464C781;
        Tue, 15 Mar 2022 01:31:01 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4SQfnyKRH2aoTVNEuheWRpZBUbdeJu9QhE6mbfGbRsc=;
        b=f84HL8MnV5HJD1DznK5i8P/AOSUvV9cflbDGeRqp5gJLMOshE4VRgry7LheEuZCr39TxfR
        BX89rboaZjiBaXWr5sx7X8DMcKiwFFXci5EDAvEtNFAmn0oRw7eHA8hyTYJIX+LuicdgTo
        pI8fqfzioJ56qStPqd8QFLCmssGy6sbiLKq0VGDzcxGPyGLpF9aU1ZK2744H7syDU4EaMi
        58bkj+w4D+9VG6Ew6pRU2gzc1K3093xGTJb7U09ZFnGzuJElJ4iVwLV3xVaxUCFvMnR/f6
        z5wdjVq+yJm9a63ceFPE/I34ZG96W3f+aAoqZbMaWe3Nr53ufHHXmIy1SA8Fiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4SQfnyKRH2aoTVNEuheWRpZBUbdeJu9QhE6mbfGbRsc=;
        b=Qhd9GtmR4T7zJCl7wp0YRmTPYBD1rW4hprfSOHfsh4635AWsTOyrB8ag8ZN90UGp1z84yb
        701e4gXoxMCyvRDA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Introduce
 kernel/sched/build_policy.c and build multiple .c files there
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733305807.16921.4885277987837934842.tip-bot2@tip-bot2>
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

Commit-ID:     f96eca432015ddc1b621632488ebc345bca06791
Gitweb:        https://git.kernel.org/tip/f96eca432015ddc1b621632488ebc345bca06791
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 22 Feb 2022 13:46:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:33 +01:00

sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there

Similarly to kernel/sched/build_utility.c, collect all 'scheduling policy' related
source code files into kernel/sched/build_policy.c:

    kernel/sched/idle.c

    kernel/sched/rt.c

    kernel/sched/cpudeadline.c
    kernel/sched/pelt.c

    kernel/sched/cputime.c
    kernel/sched/deadline.c

With the exception of fair.c, which we continue to build as a separate file
for build efficiency and parallelism reasons.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/Makefile       |  2 +-
 kernel/sched/build_policy.c | 29 +++++++++++++++++++++++++++++
 kernel/sched/cpudeadline.c  |  1 -
 kernel/sched/cputime.c      |  1 -
 kernel/sched/deadline.c     |  2 --
 kernel/sched/idle.c         |  3 ---
 kernel/sched/pelt.c         |  4 ----
 kernel/sched/rt.c           |  3 ---
 kernel/sched/sched.h        |  8 ++++++++
 9 files changed, 38 insertions(+), 15 deletions(-)
 create mode 100644 kernel/sched/build_policy.c

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 4a4785c..976092b 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -30,5 +30,5 @@ endif
 #
 obj-y += core.o
 obj-y += fair.o
+obj-y += build_policy.o
 obj-y += build_utility.o
-obj-y += idle.o rt.o deadline.o cputime.o cpudeadline.o pelt.o
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
new file mode 100644
index 0000000..6bb384d
--- /dev/null
+++ b/kernel/sched/build_policy.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * These are the scheduling policy related scheduler files, built
+ * in a single compilation unit for build efficiency reasons.
+ *
+ * ( Incidentally, the size of the compilation unit is roughly
+ *   comparable to core.c and fair.c, the other two big
+ *   compilation units. This helps balance build time, while
+ *   coalescing source files to amortize header inclusion
+ *   cost. )
+ *
+ * core.c and fair.c are built separately.
+ */
+
+#include "sched.h"
+#include "pelt.h"
+
+#include "idle.c"
+
+#include "rt.c"
+
+#ifdef CONFIG_SMP
+# include "cpudeadline.c"
+# include "pelt.c"
+#endif
+
+#include "cputime.c"
+#include "deadline.c"
+
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 0e196f0..02d970a 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -6,7 +6,6 @@
  *
  *  Author: Juri Lelli <j.lelli@sssup.it>
  */
-#include "sched.h"
 
 static inline int parent(int i)
 {
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index b7ec427..78a233d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -2,7 +2,6 @@
 /*
  * Simple CPU accounting cgroup controller
  */
-#include "sched.h"
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b..fca2d7d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -15,8 +15,6 @@
  *                    Michael Trimarchi <michael@amarulasolutions.com>,
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
-#include "sched.h"
-#include "pelt.h"
 
 struct dl_bandwidth def_dl_bandwidth;
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d17b0a5..8f8b502 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -6,9 +6,6 @@
  * (NOTE: these are not related to SCHED_IDLE batch scheduled
  *        tasks which are handled in sched/fair.c )
  */
-#include "sched.h"
-
-#include <trace/events/power.h>
 
 /* Linker adds these: start and end of __cpuidle functions */
 extern char __cpuidle_text_start[], __cpuidle_text_end[];
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a554e3b..0f31076 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -24,10 +24,6 @@
  *  Author: Vincent Guittot <vincent.guittot@linaro.org>
  */
 
-#include <linux/sched.h>
-#include "sched.h"
-#include "pelt.h"
-
 /*
  * Approximate:
  *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fb..ff4c044 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -3,9 +3,6 @@
  * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR
  * policies)
  */
-#include "sched.h"
-
-#include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
 int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 79c7a8a..f7d10b9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -13,6 +13,7 @@
 #include <linux/prctl.h>
 #include <linux/ptrace_api.h>
 #include <linux/gfp_api.h>
+#include <linux/posix-timers.h>
 #include <linux/sched/clock.h>
 #include <linux/workqueue_api.h>
 #include <linux/tick.h>
@@ -113,8 +114,11 @@
 #include <linux/cpumask_api.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
+#include <linux/hrtimer_api.h>
+#include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/kref_api.h>
+#include <linux/ktime_api.h>
 #include <linux/lockdep_api.h>
 #include <linux/module.h>
 #include <linux/mutex_api.h>
@@ -126,12 +130,16 @@
 #include <linux/sched/loadavg.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/rseq_api.h>
+#include <linux/sched/signal.h>
 #include <linux/seq_file.h>
 #include <linux/seqlock.h>
+#include <linux/softirq.h>
+#include <linux/spinlock_api.h>
 #include <linux/syscalls_api.h>
 #include <linux/syscalls.h>
 #include <linux/topology.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync_api.h>
 #include <linux/uaccess.h>
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
