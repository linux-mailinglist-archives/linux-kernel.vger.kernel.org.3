Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7530F511936
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiD0OAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiD0N72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF92A3CA40;
        Wed, 27 Apr 2022 06:56:13 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbmMa8IRO58yoJ+jpagSzKX8hH9P8l0eYx7lYCvOUaQ=;
        b=HK7xjey6sZEsPr2QSRj1GXX4qUs2pSO10CEYy+AWV4mHeWShEZ426eHJTKnvMfr7bNbmDg
        SiAV9r7E1MpVczFK+SUCr4nOD87ocm0LKWGwmOBNtqbSOtYnaVlUO1kCmRqs9EsSpFeqQD
        rwS6nIdZIMPu4rVyMBJjZ95ys930GUgNiBBRREBcn9OFQlm0j2f6ub+UnAQBEpJn47XqAd
        bAq+ZYJCLnz7ZyYpvg2A7LR0c+FY9CMeCobwJQJ8O8yd/Hl+/D1E4yPPesJgW0Pg5gBRWy
        h8jwNIgEvGUDAEX1vSczThwOGcggqF1OE40awcCsrddS0BH0TI2GMtjD7lJaGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbmMa8IRO58yoJ+jpagSzKX8hH9P8l0eYx7lYCvOUaQ=;
        b=adu6ajAKW6CVVpnRFWOYOipIPNQGGku04rCaL2EbHCyyVa8ddmMG5kNT0RMlffuxVrn6eZ
        t3YQVfdzEA/qWoBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Put frequency invariance
 aperf/mperf data into a struct
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.648485667@linutronix.de>
References: <20220415161206.648485667@linutronix.de>
MIME-Version: 1.0
Message-ID: <165106777053.4207.14279415952007074632.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d512d9a127285226c370ec7e92efb9ef61a6515b
Gitweb:        https://git.kernel.org/tip/d512d9a127285226c370ec7e92efb9ef61a6515b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:19:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:08 +02:00

x86/aperfmperf: Put frequency invariance aperf/mperf data into a struct

Preparation for sharing code with the CPU frequency portion of the
aperf/mperf code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.648485667@linutronix.de

---
 arch/x86/kernel/cpu/aperfmperf.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index b4f4ea5..6922c77 100644
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
@@ -194,8 +201,6 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 
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
@@ -474,9 +479,8 @@ DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
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
