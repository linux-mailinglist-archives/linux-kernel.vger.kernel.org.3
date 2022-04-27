Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FDA511AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiD0N7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiD0N70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218F23B3DC;
        Wed, 27 Apr 2022 06:56:07 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25HNO8Oxf0ggINk6FO02R9bvwdB5ZFJv7orgno++y5I=;
        b=y38fRutcN0wc2VtzjKROt97OZ3ct/68HypBN6k51mSRSDdpyRuO959tpnz/lKWmjdgioKB
        0gFpEPO1HcYinwbQWnCRcP8cZhX/rwvIkD4qu10Pc0dOkUd/ZfJsGW1OmXBgTAJEFVZQM+
        dIzTAzGGCy8z5fpxUFSH0XUuGUJMjRWaOjgg0zi53QnuVefRtocKDxnpGW3ex3uj9RJ9Hb
        aYmVrXZ3MbSNN7R8EGD2ANaum8eZgQKxAH6wI7DiZX3Id3R+3a9SRwwJdMgqWeV0PzZMnl
        8w/P+1QAuezcL1z7d2F7M/2HJM7WRa183apg7/RXdEfXer6KmE8XwwliQqiZtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25HNO8Oxf0ggINk6FO02R9bvwdB5ZFJv7orgno++y5I=;
        b=IlGR5Jlq6OfkgZv1jrIE9mARdcgxj7feLRx7mFvzHJ6W04JtL9ewM87LEDiDeHKQZa70gA
        CnW3hurLU+R7eqDw==
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
Message-ID: <165106776486.4207.10542512805446730601.tip-bot2@tip-bot2>
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

Commit-ID:     e696cabf5da2b4ed104508674de6125b860f3c9f
Gitweb:        https://git.kernel.org/tip/e696cabf5da2b4ed104508674de6125b860f3c9f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 25 Apr 2022 17:45:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:09 +02:00

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
