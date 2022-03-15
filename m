Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050E34D969B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbiCOIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbiCOIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F5A4D258
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l10so10789894wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlVYMMSP2xWTbAi9uYhO2iUBFbCtcGFMf2JOCAezQ90=;
        b=IwemIK41Dsrg8TVJykVmeoghF2X+0wRUO9JJOxfU2Eh0gRDPTr01b8s3rCY5Hz7uAE
         rKWfRZVFwvks/QaPbMjT8+iaja/udQUeDQe0vky3+MSFCqFoi9S3bIoZ6l5lZOgv85El
         rb/4zQjCnVLqsj0Si7Dv68hZdKaOzujj1CyIPfJE9su1+LpxjQKKm2H2xVDpLQSpvGQg
         XQnExKBdtWIWOc4C+ubXG4xFPOb8aUzkMmdD+XCiS2e1pU34CI6gJa3j4AwcLux/zp6j
         xPtlcIXnSIdAWY7CxsCzas/UFOaW3w6I2kuFH3MCBsIfEZh5rdtQJoL8P+FH+pBwj8xR
         uakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nlVYMMSP2xWTbAi9uYhO2iUBFbCtcGFMf2JOCAezQ90=;
        b=YxWixRXIywjDdtm34cVsLeFHJZB8mo9Dx61V5+RO3bCHoqTq5kup+NSuzeO3V7hmFX
         H63WLfVSZmPrZRcPio+VVYh4PRw8g11fowwudgChnwUG30+WQ+WF+8FixlcX0eZL13Cs
         PYD9qizyCMdg5w89ThaBiTb+u2Kv9ytwfpx0/8meIYk7RB1skaSH/vESDlv9IBkTwnqk
         sthu/DyOalHEODiyrGMTBdIo2mgOK1XADp3x5Hk+qz2ZFWmDN2O0snPWHtC58PhDp0n1
         LEEoRJ5ZwzqJkhz80CkSIxaNeDjrAPJMFwLaPg8/KYpDnKpYgHkM+pyBch4k4ZtK1UWD
         wHaQ==
X-Gm-Message-State: AOAM533R8elywXoUM+KNAcqOEwhzfv6QayRrUnQH5zdPnBQql9fbiYKf
        pFfxfOTbW+DLKy7cn2mGuNf0hw+AwZA=
X-Google-Smtp-Source: ABdhPJwjLwJ9GOzz9TxX9I/+xv9p8HLRvBvXZvoczTZgrEU+eh/1QkELA39vtewkcr28fiE3PnmwbQ==
X-Received: by 2002:a05:600c:3556:b0:389:f440:50e6 with SMTP id i22-20020a05600c355600b00389f44050e6mr2355961wmq.159.1647333838486;
        Tue, 15 Mar 2022 01:43:58 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/15] sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there
Date:   Tue, 15 Mar 2022 09:42:41 +0100
Message-Id: <20220315084247.40783-10-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315084247.40783-1-mingo@kernel.org>
References: <20220315084247.40783-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 4a4785cb3cd2..976092b7bd45 100644
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
index 000000000000..6bb384ddcfab
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
index 0e196f0de492..02d970a879ed 100644
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
index b7ec42732b28..78a233d43757 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -2,7 +2,6 @@
 /*
  * Simple CPU accounting cgroup controller
  */
-#include "sched.h"
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b0ef01..fca2d7de4d3d 100644
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
index d17b0a5ce6ac..8f8b5020e76a 100644
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
index a554e3bbab2b..0f310768260c 100644
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
index 7b4f4fbbb404..ff4c044aed12 100644
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
index 79c7a8a2be65..f7d10b98e911 100644
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
-- 
2.32.0

