Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26150E4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbiDYPsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242922AbiDYPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:48:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE7E38DA8;
        Mon, 25 Apr 2022 08:45:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650901543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNGctTg/goq7Sq7mhvnKDj6DW5mQC3xi+xtGEu902nA=;
        b=4xclg1i0WuE8vnC7DCY7BDKUs0sa9ICOfob622p9cPKMqYo82Q+LT0u3zRDY1fN5eQmqpN
        PHyf9DbhGeTFbOjdXV/2jgPJvuJGITk74JvaK3LEd7Xfmq+ry9w4bEMkwt911F05SeQIDr
        5+ojkalAzhgfFjtLJ+LYPV6/BCwtxEt81mgEsze8moUjbItQEXCsCaloJODdA6AGm16YCF
        GpYcPf7OuIcXTH2onSMRtlasOEAlUVX67kn6WzlH7ngXsBJTf1M0Y4/SPZt5K+4JeusTQv
        VLiBXEjmlsKuzYJaByi8ZHSEOqbPoYeKrMomPenDjMViVLVytvjvI5ljN/ebdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650901543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNGctTg/goq7Sq7mhvnKDj6DW5mQC3xi+xtGEu902nA=;
        b=0pVlce+Q0osyO+0+0QOLt0JFlGwYK41Pr49WOEDLlNVNHac4paS0C7dge9bywRCmYoneCP
        RLdUK+tUk8BxS5AQ==
To:     Doug Smythies <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     'the arch/x86 maintainers' <x86@kernel.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        'Eric Dumazet' <edumazet@google.com>,
        "'Paul E. McKenney'" <paulmck@kernel.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: RE: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
In-Reply-To: <005501d85503$3b00ca40$b1025ec0$@telus.net>
References: <20220415133356.179706384@linutronix.de>
 <005001d85413$75e5dce0$61b196a0$@telus.net>
 <CAJZ5v0jf-NGa4-xaNaxehkLGPVqwhZrUhLXw2cJ1avtjgT5yPA@mail.gmail.com>
 <87bkwwvkwa.ffs@tglx> <005501d85503$3b00ca40$b1025ec0$@telus.net>
Date:   Mon, 25 Apr 2022 17:45:42 +0200
Message-ID: <87pml5180p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20 2022 at 15:08, Doug Smythies wrote:
> On 2022.04.19 14:11 Thomas Gleixner wrote:
>>> That's because after the changes in this series scaling_cur_freq
>>> returns 0 if the given CPU is idle.
>>
>> Which is sensible IMO as there is really no point in waking an idle CPU
>> just to read those MSRs, then wait 20ms wake it up again to read those
>> MSRs again.
>
> I totally agree.
> It is the inconsistency for what is displayed as a function of driver/governor
> that is my concern.

Raphael suggested to move the show_cpuinfo() logic into the a/mperf
code. See below.

Thanks,

        tglx
---
Subject: x86/aperfmperf: Integrate the fallback code from show_cpuinfo()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 25 Apr 2022 15:19:29 +0200

Due to the avoidance of IPIs to idle CPUs arch_freq_get_on_cpu() can return
0 when the last sample was too long ago.

show_cpuinfo() has a fallback to cpufreq_quick_get() and if that fails to
return cpu_khz, but the readout code for the per CPU scaling frequency in
sysfs does not.

Move that fallback into arch_freq_get_on_cpu() so the behaviour is the same
when reading /proc/cpuinfo and /sys/..../cur_scaling_freq.

Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/aperfmperf.c |   10 +++++++---
 arch/x86/kernel/cpu/proc.c       |    7 +------
 2 files changed, 8 insertions(+), 9 deletions(-)

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
@@ -424,9 +424,13 @@ unsigned int arch_freq_get_on_cpu(int cp
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
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -86,12 +86,7 @@ static int show_cpuinfo(struct seq_file
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
