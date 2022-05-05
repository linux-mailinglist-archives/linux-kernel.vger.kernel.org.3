Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A151BDA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356373AbiEELF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356362AbiEELFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963BB47AE8;
        Thu,  5 May 2022 04:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0354861BEC;
        Thu,  5 May 2022 11:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4FDC385A4;
        Thu,  5 May 2022 11:02:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h0bSE84+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651748528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w66ItAgT5NMOeGXzvBnEtBD/csHTCnRqMMsL/3iYAvg=;
        b=h0bSE84+8RVin308iX0H/iKq7dL+Ojk7E0WxeIaCEP9cgvRp3m8DB5hW1yV8y9bmnSkJZm
        jqpKlAUFo4zoTq7tZP8c49SeiRja2UPqgTmoNAtUG03if4gx9PDIlYUqSpaubMWB0ZbY3q
        cyFYpz2TzHCZsQxDFyfKMbmJVrd+VUc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4aea3e4b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 5 May 2022 11:02:08 +0000 (UTC)
Date:   Thu, 5 May 2022 13:02:02 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnOuqh4YZT8ww96W@zx2c4.com>
References: <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx>
 <YnKh96isoB7jiFrv@zx2c4.com>
 <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com>
 <87wnf1huwj.ffs@tglx>
 <YnMRwPFfvB0RlBow@zx2c4.com>
 <87mtfwiyqp.ffs@tglx>
 <YnMkRLcxczMxdE5z@zx2c4.com>
 <87h764ixjs.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h764ixjs.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

On Thu, May 05, 2022 at 03:21:43AM +0200, Thomas Gleixner wrote:
> > Thanks, I'll give it a shot in the morning (3am) when trying to do a
> > more realistic benchmark. But just as a synthetic thing, I ran the
> > numbers in kBench900 and am getting:
> >
> >      generic:    430 cycles per call
> >        ssse3:    315 cycles per call
> >       avx512:    277 cycles per call
> >
> > for a single call to the compression function, which is the most any of
> > those mix_pool_bytes() calls do from add_{input,disk}_randomness(), on
> > Tiger Lake, using RDPMC from kernel space.
> 
> I'm well aware of the difference between synthetic benchmarks and real
> world scenarios and with the more in depth instrumentation of these
> things I'm even more concerned that the difference is underestimated.
> 
> > This _doesn't_ take into account the price of calling kernel_fpu_begin().
> > That's a little hard to bench synthetically by running it in a loop and
> > taking medians because of the lazy restoration. But that's an indication
> > anyway that I should be looking at the cost of the actual function as
> > its running in random.c, rather than the synthetic test. Will keep this
> > thread updated.
> 
> Appreciated.

Interestingly, disabling the simd paths makes things around 283 cycles
slower on my Tiger Lake laptop, just doing ordinary things. I'm actually
slightly surprised, so I'll probably keep playing with this. My patch
for this is attached. Let me know if you have a different methodology in
mind...

Jason

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bd292927654c..7a70a186c26b 100644
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
@@ -755,9 +756,48 @@ static struct {
 	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
 };

+struct {
+	u32 durations[1 << 20];
+	u32 pos, len;
+} irqbench;
+
 static void _mix_pool_bytes(const void *in, size_t nbytes)
 {
+	u32 ctr = input_pool.hash.t[0];
+	cycles_t end, start = get_cycles();
 	blake2s_update(&input_pool.hash, in, nbytes);
+	end = get_cycles();
+
+	if (ctr == input_pool.hash.t[0] || !in_hardirq())
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
@@ -1709,6 +1749,18 @@ static struct ctl_table random_table[] = {
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


