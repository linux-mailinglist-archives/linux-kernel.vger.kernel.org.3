Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C740502F44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349446AbiDOTXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349044AbiDOTW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FE63EA8B;
        Fri, 15 Apr 2022 12:19:58 -0700 (PDT)
Message-ID: <20220415161206.648485667@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MF+qC2b0dJXg+oWZw84Sqe0wCeDxratrkAn7t5wMy58=;
        b=lN/Ir/t5CAtSnnNArbT4UHK+I31zNocAKQbzU6/XaqOweCDkAjninvFHeB7bqF09HE/T0W
        OaDAHd/bIYPu7GNcb4OD+k61SxNgwDtJAbMdpbQDbxWNRAekNkEskPQFs9Ln/EIU9A9RDl
        5F8Rb7nSmdQrowXLg+3N6wD5FyB8BQaPwTMw1rXjno2yVO7itltOnv9wwtqYj5TCPLIlvU
        EeSZ8iJOCncNDUO61Pcge6Y6upbt48DrEwzPymS44LUe3DnxbmowfsF6T4Gbw6EJIW00mn
        iqFoikvHHePXdoeGMjmwh+NnQALfUtZUa+7KqWOzRhHq6OMRUgF7MmC0kEmxTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MF+qC2b0dJXg+oWZw84Sqe0wCeDxratrkAn7t5wMy58=;
        b=erZk8fiVQlqE6cG6sr4GDcQgl/rSmofTc9yhYqX4/jlB0u/eLJN6chvug1bvG89nCXAMfW
        QXreSiOxq4uFB4Bg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 05/10] x86/aperfmperf: Put frequency invariance aperf/mperf
 data into a struct
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 21:19:56 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparation for sharing code with the CPU frequency portion of the
aperf/mperf code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/aperfmperf.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -22,6 +22,13 @@
 
 #include "cpu.h"
 
+struct aperfmperf {
+	u64		aperf;
+	u64		mperf;
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct aperfmperf, cpu_samples);
+
 struct aperfmperf_sample {
 	unsigned int	khz;
 	atomic_t	scfpending;
@@ -194,8 +201,6 @@ unsigned int arch_freq_get_on_cpu(int cp
 
 DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
 
-static DEFINE_PER_CPU(u64, arch_prev_aperf);
-static DEFINE_PER_CPU(u64, arch_prev_mperf);
 static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
 static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
 
@@ -407,8 +412,8 @@ static void init_counter_refs(void)
 	rdmsrl(MSR_IA32_APERF, aperf);
 	rdmsrl(MSR_IA32_MPERF, mperf);
 
-	this_cpu_write(arch_prev_aperf, aperf);
-	this_cpu_write(arch_prev_mperf, mperf);
+	this_cpu_write(cpu_samples.aperf, aperf);
+	this_cpu_write(cpu_samples.mperf, mperf);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -474,9 +479,8 @@ DEFINE_PER_CPU(unsigned long, arch_freq_
 
 void arch_scale_freq_tick(void)
 {
-	u64 freq_scale;
-	u64 aperf, mperf;
-	u64 acnt, mcnt;
+	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
+	u64 aperf, mperf, acnt, mcnt, freq_scale;
 
 	if (!arch_scale_freq_invariant())
 		return;
@@ -484,11 +488,11 @@ void arch_scale_freq_tick(void)
 	rdmsrl(MSR_IA32_APERF, aperf);
 	rdmsrl(MSR_IA32_MPERF, mperf);
 
-	acnt = aperf - this_cpu_read(arch_prev_aperf);
-	mcnt = mperf - this_cpu_read(arch_prev_mperf);
+	acnt = aperf - s->aperf;
+	mcnt = mperf - s->mperf;
 
-	this_cpu_write(arch_prev_aperf, aperf);
-	this_cpu_write(arch_prev_mperf, mperf);
+	s->aperf = aperf;
+	s->mperf = mperf;
 
 	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
 		goto error;

