Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D24D9653
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbiCOIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbiCOIcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9FA4C428;
        Tue, 15 Mar 2022 01:30:59 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kupy0Bc0ObB7ZHAcB3Ho+yjyamO78el+3D4x6h3kiFs=;
        b=2AQW/uIj4Do0OpB4N1+q7dKBWXkukaiYA+siuY1uKFe1b+hNIcNloAuoMh1xyX4sKVmOnA
        pS1+TM6J9Zd0m6UEwDWBHb1MpC5M1Ydm2VTlzYzdaHVzJSN8B/4RReA5atiC4V/BUSLyGL
        qqFSaliIMvJR2R1uXGRV79W03hHwaF772lFFLHYyZtAxGNmOBPDJP4B1RNLuzBEE/x/2c3
        Dx2Au1fXV/t7aiW6h2v4IstdDheN3pRX4JtqibEDcPo5D0xafTJ2GwwqMNQQUKF+l9MSgK
        +vSYABx2WCq6PJZgeUl4vIVhn0yit0ApL9/ZNJxSr02qE++OFNDmTQeJSJE8xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kupy0Bc0ObB7ZHAcB3Ho+yjyamO78el+3D4x6h3kiFs=;
        b=ERIowSrMFszmWjptSzu1qzsU1DJaVTAnqUHZ7eWgK9Eybw21hDQE4dPdQsiQW7rDUGYnQU
        mpB6sVOU1pWDkCDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Standardize kernel/sched/sched.h
 header dependencies
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733305721.16921.17375336826369599412.tip-bot2@tip-bot2>
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

Commit-ID:     b9e9c6ca6e54b5d58a57663f76c5cb33c12ea98f
Gitweb:        https://git.kernel.org/tip/b9e9c6ca6e54b5d58a57663f76c5cb33c12ea98f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 13 Feb 2022 08:19:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:33 +01:00

sched/headers: Standardize kernel/sched/sched.h header dependencies

kernel/sched/sched.h is a weird mix of ad-hoc headers included
in the middle of the header.

Two of them rely on being included in the middle of kernel/sched/sched.h,
due to definitions they require:

 - "stat.h" needs the rq definitions.
 - "autogroup.h" needs the task_group definition.

Move the inclusion of these two files out of kernel/sched/sched.h, and
include them in all files that require them.

Move of the rest of the header dependencies to the top of the
kernel/sched/sched.h file.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/build_policy.c  |  3 +++
 kernel/sched/build_utility.c |  2 ++
 kernel/sched/core.c          |  2 ++
 kernel/sched/fair.c          |  2 ++
 kernel/sched/sched.h         | 20 +++++++++++---------
 kernel/sched/stats.h         |  4 ++--
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 6bb384d..9a169b2 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -13,6 +13,9 @@
  */
 
 #include "sched.h"
+
+#include "autogroup.h"
+#include "stats.h"
 #include "pelt.h"
 
 #include "idle.c"
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 31216ce..8b2b199 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -12,6 +12,8 @@
 
 #include "sched.h"
 #include "sched-pelt.h"
+#include "stats.h"
+#include "autogroup.h"
 
 #include <linux/sched_clock.h>
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef94612..22de537 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11,6 +11,8 @@
 #undef CREATE_TRACE_POINTS
 
 #include "sched.h"
+#include "stats.h"
+#include "autogroup.h"
 
 #include <linux/nospec.h>
 #include <linux/blkdev.h>
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 16874e1..7391c92 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,6 +21,8 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include "sched.h"
+#include "stats.h"
+#include "autogroup.h"
 
 /*
  * Targeted preemption latency for CPU-bound tasks:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f7d10b9..f255ec2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -96,11 +96,20 @@
 # include <asm/paravirt.h>
 #endif
 
+#include <trace/events/sched.h>
+
+#ifdef CONFIG_CGROUP_SCHED
+#include <linux/cgroup.h>
+#include <linux/psi.h>
+#endif
+
+#ifdef CONFIG_SCHED_DEBUG
+# include <linux/static_key.h>
+#endif
+
 #include "cpupri.h"
 #include "cpudeadline.h"
 
-#include <trace/events/sched.h>
-
 #ifdef CONFIG_SCHED_DEBUG
 # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
 #else
@@ -417,9 +426,6 @@ extern bool dl_cpu_busy(unsigned int cpu);
 
 #ifdef CONFIG_CGROUP_SCHED
 
-#include <linux/cgroup.h>
-#include <linux/psi.h>
-
 struct cfs_rq;
 struct rt_rq;
 
@@ -1919,9 +1925,6 @@ extern void flush_smp_call_function_from_idle(void);
 static inline void flush_smp_call_function_from_idle(void) { }
 #endif
 
-#include "stats.h"
-#include "autogroup.h"
-
 #if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
 
 extern void __sched_core_account_forceidle(struct rq *rq);
@@ -2016,7 +2019,6 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
  * Tunables that become constants when CONFIG_SCHED_DEBUG is off:
  */
 #ifdef CONFIG_SCHED_DEBUG
-# include <linux/static_key.h>
 # define const_debug __read_mostly
 #else
 # define const_debug const
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index edc0d13..a0df79e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,10 +2,10 @@
 #ifndef _KERNEL_STATS_H
 #define _KERNEL_STATS_H
 
-#ifdef CONFIG_SCHEDSTATS
-
 #include "sched.h"
 
+#ifdef CONFIG_SCHEDSTATS
+
 extern struct static_key_false sched_schedstats;
 
 /*
