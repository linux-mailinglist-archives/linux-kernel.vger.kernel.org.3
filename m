Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1352151C159
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245639AbiEENwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiEENwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A81357B13;
        Thu,  5 May 2022 06:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E912761EA1;
        Thu,  5 May 2022 13:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68828C385A4;
        Thu,  5 May 2022 13:49:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OoBA75oD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651758547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcYjK1pB4trYMEK7Jg+WFSNQr3tC4Ghpb0u1HgTVVCs=;
        b=OoBA75oDsRoDieLgtuW7alWNT5/odoKZW2NCx4PzT2OBe01vwUzxaEWwzX07MLErTfTahr
        yqlCZlL8hPmNY6FSZgJfRmDgUVOhIIm87rlu3GPCqXfjAPVyFzelPrbvjMz9oeqpOwMUVL
        WTjfYzN6a+YpFPgZzVz3b81iIvAXRb0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a05ca93b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 5 May 2022 13:49:07 +0000 (UTC)
Date:   Thu, 5 May 2022 15:48:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnPVx3epmwUWKfvl@zx2c4.com>
References: <87fslpjomx.ffs@tglx>
 <YnKh96isoB7jiFrv@zx2c4.com>
 <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com>
 <87wnf1huwj.ffs@tglx>
 <YnMRwPFfvB0RlBow@zx2c4.com>
 <87mtfwiyqp.ffs@tglx>
 <YnMkRLcxczMxdE5z@zx2c4.com>
 <87h764ixjs.ffs@tglx>
 <YnOuqh4YZT8ww96W@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnOuqh4YZT8ww96W@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again Thomas,

On Thu, May 05, 2022 at 01:02:02PM +0200, Jason A. Donenfeld wrote:
> Interestingly, disabling the simd paths makes things around 283 cycles
> slower on my Tiger Lake laptop, just doing ordinary things. I'm actually
> slightly surprised, so I'll probably keep playing with this. My patch
> for this is attached. Let me know if you have a different methodology in
> mind...

Using RDPMC/perf, the performance is shown to be even closer for real
world cases, with the simd code only ~80 cycles faster. Bench code
follows below. If the observation on this hardware holds for other
hardware, we can probably improve the performance of the generic code a
bit, and then the difference really won't matter. Any thoughts about
this and the test code?

Jason

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bd292927654c..6577e9f2f3b7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -53,6 +53,7 @@
 #include <linux/uuid.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/sort.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
 #include <asm/processor.h>
@@ -755,9 +756,54 @@ static struct {
 	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
 };
 
+static DEFINE_PER_CPU(int, pmc_index) = -1;
+static struct {
+	u32 durations[1 << 20];
+	u32 pos, len;
+} irqbench;
+
 static void _mix_pool_bytes(const void *in, size_t nbytes)
 {
+	int idx = *this_cpu_ptr(&pmc_index);
+	u32 ctr = input_pool.hash.t[0], reg = 0;
+	cycles_t end, start;
+
+
+	native_cpuid(&reg, &reg, &reg, &reg);
+	start = idx == -1 ? 0 : native_read_pmc(idx);
 	blake2s_update(&input_pool.hash, in, nbytes);
+	end = idx == -1 ? 0 : native_read_pmc(idx);
+
+	if (ctr == input_pool.hash.t[0] || !in_hardirq() || idx == -1)
+		return;
+
+	irqbench.durations[irqbench.pos++ % ARRAY_SIZE(irqbench.durations)] = end - start;
+	irqbench.len = min_t(u32, irqbench.len + 1, ARRAY_SIZE(irqbench.durations));
+}
+
+static int cmp_u32(const void *a, const void *b)
+{
+	return *(const u32 *)a - *(const u32 *)b;
+}
+
+static int proc_do_irqbench_median(struct ctl_table *table, int write, void *buffer,
+				   size_t *lenp, loff_t *ppos)
+{
+	u32 len = READ_ONCE(irqbench.len), median, *sorted;
+	struct ctl_table fake_table = {
+		.data = &median,
+		.maxlen = sizeof(median)
+	};
+	if (!len)
+		return -ENODATA;
+	sorted = kmalloc_array(len, sizeof(*sorted), GFP_KERNEL);
+	if (!sorted)
+		return -ENOMEM;
+	memcpy(sorted, irqbench.durations, len * sizeof(*sorted));
+	sort(sorted, len, sizeof(*sorted), cmp_u32, NULL);
+	median = sorted[len / 2];
+	kfree(sorted);
+	return write ? 0 : proc_douintvec(&fake_table, 0, buffer, lenp, ppos);
 }
 
 /*
@@ -1709,6 +1755,18 @@ static struct ctl_table random_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
+	{
+		.procname	= "irqbench_median",
+		.mode		= 0444,
+		.proc_handler	= proc_do_irqbench_median,
+	},
+	{
+		.procname	= "irqbench_count",
+		.data		= &irqbench.len,
+		.maxlen		= sizeof(irqbench.len),
+		.mode		= 0444,
+		.proc_handler	= proc_douintvec,
+	},
 	{ }
 };
 
@@ -1718,6 +1776,21 @@ static struct ctl_table random_table[] = {
  */
 static int __init random_sysctls_init(void)
 {
+	int i;
+	struct perf_event *cycles_event;
+	struct perf_event_attr perf_cycles_attr = {
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.size = sizeof(struct perf_event_attr),
+		.pinned = true
+	};
+	for_each_possible_cpu(i) {
+		cycles_event = perf_event_create_kernel_counter(&perf_cycles_attr, i, NULL, NULL, NULL);
+		if (IS_ERR(cycles_event))
+			pr_err("unable to create perf counter on cpu %d: %ld\n", i, PTR_ERR(cycles_event));
+		else
+			*per_cpu_ptr(&pmc_index, i) = cycles_event->hw.event_base_rdpmc;
+	}
 	register_sysctl_init("kernel/random", random_table);
 	return 0;
 }
 
