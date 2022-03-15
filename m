Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650534D9698
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbiCOIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346127AbiCOIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2107B4D268
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r6so27369252wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jb1wu8pDJ30xgS1p+JPjCnyezWwWH0sm2Zu2NeRcVsA=;
        b=hiISU3x0fZ/PLJtBtmT6kraBpYArjPnEZTjKqMEXYBVi5vD1bSvfR0TaB/fakO7xaC
         308VW9fw5gqwyPOt5aALo93mgIX2QyXIYmVlguXGPRmUtqPYdoPgIFQ3y2HdVGLTloSq
         mTrKAnB7pyf9ve12QGtD8JzTa7Rz2+jfFaaQm+fGnqPJZDcsjGdBljgQX52NIurOofxF
         CYE7VD6o+kAqImxYsLZushXLomhlw1q9LKAR5WEBct8qmvRa9PlqHdla5JH2IEF1rvSj
         j8hOjMqI4sPov4P5YgjqR9KBmEi/YwYXac+uqVFkFO1Uh8fUd4C0YEw1KPBYGMaQ5awE
         6A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Jb1wu8pDJ30xgS1p+JPjCnyezWwWH0sm2Zu2NeRcVsA=;
        b=1o+dD1O8hAn1UX/sYpNcDQcJOXXQNudeVmdcvCQPTFIkvyvQxNUmStUKiQ5g6V/h7V
         /Vjp1QCFGfBZcWKO2OBR7VB/ExsoDOYWJRwk9UL24xLQAokKdIWtGlwOmDgMloJFrOuO
         YaaHL2PEvybW3BspH6j0lICdmkSc0i33GrqYqcXMVoBuosWUcTREgVTI1Uhix9fioMN3
         TWevK1UZk9pBmECzel7lQAiV9MFi5JsitwGrsHu1BZZMxBumRMoTk943A63IRYIuIKSX
         VdI/+BcVlaNvjGjB/LZmELvUmZxtPwDzJMb5Q8VxmLIGAWr+xBLT9bxA/VKpxoYz9kfY
         pkkQ==
X-Gm-Message-State: AOAM533zmksvC8PUSScDqIq8berkvhBJ765FeKMVPuMmIyZI2iZDgEG4
        LTVgKV4ZsLWh6Xs7WGmz5hd5kYm31DI=
X-Google-Smtp-Source: ABdhPJy1HhMqexQddfHuV8F1Eb/P08ZosKRgUc5SqbEdhbVmTksB7SahuD4T6EBfFmXjL6+Ok1+itA==
X-Received: by 2002:a5d:678f:0:b0:1f0:2471:5a93 with SMTP id v15-20020a5d678f000000b001f024715a93mr19670842wru.164.1647333839676;
        Tue, 15 Mar 2022 01:43:59 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:59 -0700 (PDT)
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
Subject: [PATCH 10/15] sched/headers: Standardize kernel/sched/sched.h header dependencies
Date:   Tue, 15 Mar 2022 09:42:42 +0100
Message-Id: <20220315084247.40783-11-mingo@kernel.org>
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
index 6bb384ddcfab..9a169b2f97e6 100644
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
index 31216ce0b4b3..8b2b199983bf 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -12,6 +12,8 @@
 
 #include "sched.h"
 #include "sched-pelt.h"
+#include "stats.h"
+#include "autogroup.h"
 
 #include <linux/sched_clock.h>
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef946123e9af..22de53710ee9 100644
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
index 16874e112fe6..7391c9287503 100644
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
index f7d10b98e911..f255ec2afeca 100644
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
index edc0d13fc61b..a0df79e6038c 100644
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
-- 
2.32.0

