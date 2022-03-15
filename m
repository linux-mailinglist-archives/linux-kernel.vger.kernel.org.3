Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1927B4D9697
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbiCOIpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbiCOIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3924D249
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b19so5449786wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gcx72MWyHSTXBVR1A78iWYLCJOULLztlK07nPk9XqZs=;
        b=C4QpuENnEqCSz5KbPLEsz8To46CB3xmUDuzUFipxwL4OkU9JEhZz6BHzAEju9lMirx
         WHe5ahaq5vwvlnf5AWOdK2I6Pbyws7DM+iFBJ2c+FPAJMYS3LjyMWrNOvA3gzQvwPAOX
         lU8nsYZU76W3OYgfHLh+uFN5Jv1vPOREEq65D/vjogPcF4zDav+TDr/QhXuxS/xTrwmj
         pXgm12P1UTpqPeKYAzBCfU2AVpK23ZgNzvj150D29o1bLblGAZvr6pwj1Otz9oJKKOhX
         Gj/BfzBglGpvgxIj1gTLVeTcZWOEy0Dw9klJ+G7J2ZFxUGqp6tAqZOAchDjxFpN6mYgn
         LhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Gcx72MWyHSTXBVR1A78iWYLCJOULLztlK07nPk9XqZs=;
        b=hiq+dGsKvnm5axTwRnYkRRwSrEWmr/zgUWo8c0LFQDkB0eEygq9ncFyhmfvP662POD
         ugJ6V7g9zhNRBkMn0e19LmgGNVYPngqNuyRL3SvKYaPsCTLk6Q2hI7oPlYG61b5OuTPj
         AmK8M+hDodQ4KT50Fl2daxa1d9C30XqUMRp1y9TPKQ13rZsj8F4E5DDhwlUfgdrRtj3F
         /qCE75qI4cIKPKKrPEwUDCp9muee3NnLNNWoYmGXfvRk+bNZF2sFVxyMTCIWnReV26Z1
         M0Nx3S0sI/UMd41JCj8spYKNwOsJr5zBt8z4Dem0WOVwmkn77InftAJZxBTdSldbQcb6
         2z0A==
X-Gm-Message-State: AOAM532QBABkuwSnbdU8ql9iQfBHzvM5hZYmFMKlxnfHSjqaxp9KUg4T
        VUtgXNpQ9kZ5xXxLmPv45JH18t0AmWc=
X-Google-Smtp-Source: ABdhPJx5/3utrKW8NsI2O5aGMeGwKB/PwTw9WVSyv5oi47Wjc3gVslIFp7A3gkkL5wfyILjZSKJIdw==
X-Received: by 2002:a5d:4392:0:b0:1f1:e683:de90 with SMTP id i18-20020a5d4392000000b001f1e683de90mr20138928wrq.551.1647333832882;
        Tue, 15 Mar 2022 01:43:52 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:52 -0700 (PDT)
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
Subject: [PATCH 04/15] sched/headers: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry
Date:   Tue, 15 Mar 2022 09:42:36 +0100
Message-Id: <20220315084247.40783-5-mingo@kernel.org>
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

Mark all non-init functions in kernel/sched.c as 'notrace', instead of
turning them all off via CC_FLAGS_FTRACE.

This is going to allow the treatment of this file as any other scheduler
file, and it can be #include-ed in compound compilation units as well.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/Makefile |  3 ---
 kernel/sched/clock.c  | 42 +++++++++++++++++++++---------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c83b37af155b..c0c52026ad0d 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_clock.o = $(CC_FLAGS_FTRACE)
-endif
 
 # The compilers are complaining about unused variables inside an if(0) scope
 # block. This is daft, shut them up.
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c2b2859ddd82..540d0e50e31c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -61,7 +61,7 @@
  * This is default implementation.
  * Architectures and sub-architectures can override this.
  */
-unsigned long long __weak sched_clock(void)
+notrace unsigned long long __weak sched_clock(void)
 {
 	return (unsigned long long)(jiffies - INITIAL_JIFFIES)
 					* (NSEC_PER_SEC / HZ);
@@ -95,28 +95,28 @@ struct sched_clock_data {
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct sched_clock_data, sched_clock_data);
 
-static inline struct sched_clock_data *this_scd(void)
+notrace static inline struct sched_clock_data *this_scd(void)
 {
 	return this_cpu_ptr(&sched_clock_data);
 }
 
-static inline struct sched_clock_data *cpu_sdc(int cpu)
+notrace static inline struct sched_clock_data *cpu_sdc(int cpu)
 {
 	return &per_cpu(sched_clock_data, cpu);
 }
 
-int sched_clock_stable(void)
+notrace int sched_clock_stable(void)
 {
 	return static_branch_likely(&__sched_clock_stable);
 }
 
-static void __scd_stamp(struct sched_clock_data *scd)
+notrace static void __scd_stamp(struct sched_clock_data *scd)
 {
 	scd->tick_gtod = ktime_get_ns();
 	scd->tick_raw = sched_clock();
 }
 
-static void __set_sched_clock_stable(void)
+notrace static void __set_sched_clock_stable(void)
 {
 	struct sched_clock_data *scd;
 
@@ -151,7 +151,7 @@ static void __set_sched_clock_stable(void)
  * The only way to fully avoid random clock jumps is to boot with:
  * "tsc=unstable".
  */
-static void __sched_clock_work(struct work_struct *work)
+notrace static void __sched_clock_work(struct work_struct *work)
 {
 	struct sched_clock_data *scd;
 	int cpu;
@@ -177,7 +177,7 @@ static void __sched_clock_work(struct work_struct *work)
 
 static DECLARE_WORK(sched_clock_work, __sched_clock_work);
 
-static void __clear_sched_clock_stable(void)
+notrace static void __clear_sched_clock_stable(void)
 {
 	if (!sched_clock_stable())
 		return;
@@ -186,7 +186,7 @@ static void __clear_sched_clock_stable(void)
 	schedule_work(&sched_clock_work);
 }
 
-void clear_sched_clock_stable(void)
+notrace void clear_sched_clock_stable(void)
 {
 	__sched_clock_stable_early = 0;
 
@@ -196,7 +196,7 @@ void clear_sched_clock_stable(void)
 		__clear_sched_clock_stable();
 }
 
-static void __sched_clock_gtod_offset(void)
+notrace static void __sched_clock_gtod_offset(void)
 {
 	struct sched_clock_data *scd = this_scd();
 
@@ -246,12 +246,12 @@ late_initcall(sched_clock_init_late);
  * min, max except they take wrapping into account
  */
 
-static inline u64 wrap_min(u64 x, u64 y)
+notrace static inline u64 wrap_min(u64 x, u64 y)
 {
 	return (s64)(x - y) < 0 ? x : y;
 }
 
-static inline u64 wrap_max(u64 x, u64 y)
+notrace static inline u64 wrap_max(u64 x, u64 y)
 {
 	return (s64)(x - y) > 0 ? x : y;
 }
@@ -262,7 +262,7 @@ static inline u64 wrap_max(u64 x, u64 y)
  *  - filter out backward motion
  *  - use the GTOD tick value to create a window to filter crazy TSC values
  */
-static u64 sched_clock_local(struct sched_clock_data *scd)
+notrace static u64 sched_clock_local(struct sched_clock_data *scd)
 {
 	u64 now, clock, old_clock, min_clock, max_clock, gtod;
 	s64 delta;
@@ -295,7 +295,7 @@ static u64 sched_clock_local(struct sched_clock_data *scd)
 	return clock;
 }
 
-static u64 sched_clock_remote(struct sched_clock_data *scd)
+notrace static u64 sched_clock_remote(struct sched_clock_data *scd)
 {
 	struct sched_clock_data *my_scd = this_scd();
 	u64 this_clock, remote_clock;
@@ -362,7 +362,7 @@ static u64 sched_clock_remote(struct sched_clock_data *scd)
  *
  * See cpu_clock().
  */
-u64 sched_clock_cpu(int cpu)
+notrace u64 sched_clock_cpu(int cpu)
 {
 	struct sched_clock_data *scd;
 	u64 clock;
@@ -386,7 +386,7 @@ u64 sched_clock_cpu(int cpu)
 }
 EXPORT_SYMBOL_GPL(sched_clock_cpu);
 
-void sched_clock_tick(void)
+notrace void sched_clock_tick(void)
 {
 	struct sched_clock_data *scd;
 
@@ -403,7 +403,7 @@ void sched_clock_tick(void)
 	sched_clock_local(scd);
 }
 
-void sched_clock_tick_stable(void)
+notrace void sched_clock_tick_stable(void)
 {
 	if (!sched_clock_stable())
 		return;
@@ -423,7 +423,7 @@ void sched_clock_tick_stable(void)
 /*
  * We are going deep-idle (irqs are disabled):
  */
-void sched_clock_idle_sleep_event(void)
+notrace void sched_clock_idle_sleep_event(void)
 {
 	sched_clock_cpu(smp_processor_id());
 }
@@ -432,7 +432,7 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_sleep_event);
 /*
  * We just idled; resync with ktime.
  */
-void sched_clock_idle_wakeup_event(void)
+notrace void sched_clock_idle_wakeup_event(void)
 {
 	unsigned long flags;
 
@@ -458,7 +458,7 @@ void __init sched_clock_init(void)
 	local_irq_enable();
 }
 
-u64 sched_clock_cpu(int cpu)
+notrace u64 sched_clock_cpu(int cpu)
 {
 	if (!static_branch_likely(&sched_clock_running))
 		return 0;
@@ -476,7 +476,7 @@ u64 sched_clock_cpu(int cpu)
  * On bare metal this function should return the same as local_clock.
  * Architectures and sub-architectures can override this.
  */
-u64 __weak running_clock(void)
+notrace u64 __weak running_clock(void)
 {
 	return local_clock();
 }
-- 
2.32.0

