Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322144D573F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345303AbiCKBSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbiCKBSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:18:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488BF19D615
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:17:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m2so6468568pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KElSPNJYzvILCg6JxXncvsYAzmWx3Y+NRGQTldf42yk=;
        b=XCCJ12B+9aUeSntdUyOS920Wi0O1K57EDRVTQ23YbOuClgr1heJP6XFtIPf/qBgML8
         oKkDVosGAmS+r0/52kSb2MAAKe2BawqceLmA+4bHVcnecv4dfc7N97mILVp/Ps6ULMZ/
         ePB14WlIAKNltOjsi3QzI9Xbj73wsw3z56Jcn+NkkzLtPOgWuwwmWUw2AK6AzrN2xziy
         6uOiih6/wUevPUzSLCFF2SMRDCnHuFEK+jLTAMs8LMmHFdsczu9fnyfbn7g1Lsx7R73V
         R97k7FJdQATidor9QyQ+q6LahVze9c82CHbKsmmyY34aZ5Nq278QkL69ElISwKBeIFfS
         MXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KElSPNJYzvILCg6JxXncvsYAzmWx3Y+NRGQTldf42yk=;
        b=MFmvrRUExTd+mB0r84jFdqNMxaueC6+Rm/EQ6VxeoqIReK5jmtsCB/dgsLkCBPWW92
         a+TXImcMh2jdAa5T2tK1Lfz8k5XyviF4xgfElqyTJ62dNANpSwge+8CZzZVlDhuXGLgl
         UAmCzRsphLRJKQPPKvipcThKPuVQBnZj2iwHskbMDeIvex5YqSf6OecxQ6lPyKi4NHgW
         fFwQFKxXMvtCiOKenb+i9dr8IGfOWf33WTabDlImn4WojWy5nkY60qwqpIxhf4E+jbHu
         20lAa50gR3BslTeofpJqq2rD7imgd0sELauktifv4/DGHy2+5928CLs9cjqMDodHS6a5
         wmSQ==
X-Gm-Message-State: AOAM533ZR8OTc7Oz2sIrAmE8xXp8nrjD8kCyl2nPGTpMPkeXfdV3RBgP
        Mrm3x+H9+6QUqBE4HVtfJUI=
X-Google-Smtp-Source: ABdhPJw0wqajeF6392sKtMrifpqvHnFiEuNf6ZMx059eYQIMI7iJmKawkUSrH5SlAVnN/XHn8Sor0Q==
X-Received: by 2002:a17:902:e842:b0:151:eb05:7dc1 with SMTP id t2-20020a170902e84200b00151eb057dc1mr7985296plg.103.1646961439782;
        Thu, 10 Mar 2022 17:17:19 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:609f:ca32:f243:4dda])
        by smtp.gmail.com with ESMTPSA id u5-20020a056a00158500b004f745148736sm8783153pfk.179.2022.03.10.17.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 17:17:19 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86/cpu: use smp_call_function_many() in arch_freq_prepare_all()
Date:   Thu, 10 Mar 2022 17:17:15 -0800
Message-Id: <20220311011715.2440601-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Opening /proc/cpuinfo can have a big latency on hosts with many cpus,
mostly because it is essentially doing:

   for_each_online_cpu(cpu)
    smp_call_function_single(cpu, aperfmperf_snapshot_khz, ...)

smp_call_function_single() is reusing a common csd, meaning that
each invocation needs to wait for completion of the prior one.

Paul recent patches have lowered number of cpus receiving the IPI,
but there are still cases where the latency of the above loop can
reach 10 ms, then an extra msleep(10) is performed, for a total of 20ms.

Using smp_call_function_many() allows for full parallelism,
and latency is down to ~80 usec, on a host with 256 cpus.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/cpu/aperfmperf.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 22911deacb6e441ad60ddb57190ef3772afb3cf0..a305310ceb44784a0ad9be7c196061d98fa1adbc 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -67,7 +67,8 @@ static void aperfmperf_snapshot_khz(void *dummy)
 	atomic_set_release(&s->scfpending, 0);
 }
 
-static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
+static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait,
+				    struct cpumask *mask)
 {
 	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
 	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
@@ -76,9 +77,13 @@ static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
 	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
 		return true;
 
-	if (!atomic_xchg(&s->scfpending, 1) || wait)
-		smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
-
+	if (!atomic_xchg(&s->scfpending, 1) || wait) {
+		if (mask)
+			__cpumask_set_cpu(cpu, mask);
+		else
+			smp_call_function_single(cpu, aperfmperf_snapshot_khz,
+						 NULL, wait);
+	}
 	/* Return false if the previous iteration was too long ago. */
 	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
 }
@@ -97,13 +102,14 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (rcu_is_idle_cpu(cpu))
 		return 0; /* Idle CPUs are completely uninteresting. */
 
-	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
+	aperfmperf_snapshot_cpu(cpu, ktime_get(), true, NULL);
 	return per_cpu(samples.khz, cpu);
 }
 
 void arch_freq_prepare_all(void)
 {
 	ktime_t now = ktime_get();
+	cpumask_var_t mask;
 	bool wait = false;
 	int cpu;
 
@@ -113,17 +119,25 @@ void arch_freq_prepare_all(void)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return;
+
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
 			continue;
 		if (rcu_is_idle_cpu(cpu))
 			continue; /* Idle CPUs are completely uninteresting. */
-		if (!aperfmperf_snapshot_cpu(cpu, now, false))
+		if (!aperfmperf_snapshot_cpu(cpu, now, false, mask))
 			wait = true;
 	}
 
-	if (wait)
-		msleep(APERFMPERF_REFRESH_DELAY_MS);
+	preempt_disable();
+	smp_call_function_many(mask, aperfmperf_snapshot_khz, NULL, wait);
+	preempt_enable();
+	cpus_read_unlock();
+
+	free_cpumask_var(mask);
 }
 
 unsigned int arch_freq_get_on_cpu(int cpu)
@@ -139,7 +153,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
 		return 0;
 
-	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
+	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true, NULL))
 		return per_cpu(samples.khz, cpu);
 
 	msleep(APERFMPERF_REFRESH_DELAY_MS);
-- 
2.35.1.723.g4982287a31-goog

