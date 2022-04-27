Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8874351216B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiD0SrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiD0SqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:46:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89327522C;
        Wed, 27 Apr 2022 11:27:22 -0700 (PDT)
Date:   Wed, 27 Apr 2022 18:27:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651084041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iIPFt3fKApC2NPRJ5BU2GAYeO/pyyhPu4W8hcSJa8g=;
        b=0KSiNe4suFMu52SkzV8jseuYiYH8K1W97+TjS+qjqAVv1pJuHDrbISOcqUBYKEBpmH074X
        U7UbUXElkMpRr455VhRL66F/B96h6wU8VV6zG2SlzlWG9cYwFOCUbBx9wWqwe4JQMdaqcw
        d3ArNvOP5GiGXTeDdI3U0TdBLd2q0iRY6WvVbqrV1TySTEXKnKcoVlBY+rxnXHWkX45IFF
        1xnKriEfcbgGi+919xtzvl1Ndt2gmk2EaVF+kafbUtXvBIsXx+5WQak/MEeieiNeRyScXX
        fsFtYdBp5Uyy4DnlpPN38UsdVU7rJGvN/TpHTsFngNYG6FmCR2gJ7LTKuLrRkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651084041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iIPFt3fKApC2NPRJ5BU2GAYeO/pyyhPu4W8hcSJa8g=;
        b=hH+y8TBnlyq2Jb8ptvlcYLKMz29QHRa1yUFApg5HMAIc32hABsszBv+XaHcp2iB0SDQKiK
        58jNlT0UsO/XflDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Integrate the fallback code from
 show_cpuinfo()
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Doug Smythies <dsmythies@telus.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87pml5180p.ffs@tglx>
References: <87pml5180p.ffs@tglx>
MIME-Version: 1.0
Message-ID: <165108404020.4207.6950218577466647606.tip-bot2@tip-bot2>
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

Commit-ID:     fb4c77c21aba03677f283acda3cae748ef866abf
Gitweb:        https://git.kernel.org/tip/fb4c77c21aba03677f283acda3cae748ef866abf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 25 Apr 2022 17:45:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 20:22:20 +02:00

x86/aperfmperf: Integrate the fallback code from show_cpuinfo()

Due to the avoidance of IPIs to idle CPUs arch_freq_get_on_cpu() can return
0 when the last sample was too long ago.

show_cpuinfo() has a fallback to cpufreq_quick_get() and if that fails to
return cpu_khz, but the readout code for the per CPU scaling frequency in
sysfs does not.

Move that fallback into arch_freq_get_on_cpu() so the behaviour is the same
when reading /proc/cpuinfo and /sys/..../cur_scaling_freq.

Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Doug Smythies <dsmythies@telus.net>
Link: https://lore.kernel.org/r/87pml5180p.ffs@tglx

---
 arch/x86/kernel/cpu/aperfmperf.c | 10 +++++++---
 arch/x86/kernel/cpu/proc.c       |  7 +------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index b15c884..1f60a2b 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -405,12 +405,12 @@ void arch_scale_freq_tick(void)
 unsigned int arch_freq_get_on_cpu(int cpu)
 {
 	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
+	unsigned int seq, freq;
 	unsigned long last;
-	unsigned int seq;
 	u64 acnt, mcnt;
 
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
-		return 0;
+		goto fallback;
 
 	do {
 		seq = raw_read_seqcount_begin(&s->seq);
@@ -424,9 +424,13 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	 * which covers idle and NOHZ full CPUs.
 	 */
 	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
-		return 0;
+		goto fallback;
 
 	return div64_u64((cpu_khz * acnt), mcnt);
+
+fallback:
+	freq = cpufreq_quick_get(cpu);
+	return freq ? freq : cpu_khz;
 }
 
 static int __init bp_init_aperfmperf(void)
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 0a0ee55..099b6f0 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -86,12 +86,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has(c, X86_FEATURE_TSC)) {
 		unsigned int freq = arch_freq_get_on_cpu(cpu);
 
-		if (!freq)
-			freq = cpufreq_quick_get(cpu);
-		if (!freq)
-			freq = cpu_khz;
-		seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
-			   freq / 1000, (freq % 1000));
+		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
 	}
 
 	/* Cache size */
