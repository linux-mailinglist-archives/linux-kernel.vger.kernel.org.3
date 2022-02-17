Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233A4BA765
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbiBQRo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:44:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiBQRoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:44:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C72B3ACF;
        Thu, 17 Feb 2022 09:44:40 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:44:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645119878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klnrdXNkE4iTB8LWDRvdFIKa60DiwM51hjznWkB1FRM=;
        b=p3SWTdA+XNwmH7If6aagbAIJNJw85AcnOr4h/b89lqUaUSXJxMEEyZtYUmU0hWLWYe8FfF
        DVzH+ZUSwkoMUFH3XOmeVz+r2WeYNx9hp6Fg6hSACaTsEGvV38pnA24MOkpio98V3vYFrb
        0OfSH54RQ2sRlMbrG6KD6qI9cdZlUrW3Go2b0POccWU9fdvJqYnxQgDGsZTJ3/8yFqCYYi
        YIeUa8FwsbC9mhzXB/0sFB1HqTXs8GuXsr7A9LbTyTMIFrCbAOWvobGrL59OMPyeoPNq0n
        T4libbm3jc6t8GClUFSKYzu89489KFpbhayjm+MgMf1taoQJUrGuDep13kzvQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645119878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klnrdXNkE4iTB8LWDRvdFIKa60DiwM51hjznWkB1FRM=;
        b=y/SJtntiY8PrRHpxPjsd1AV+OBXMPb1uBTfjoYpLFtyHKvYj7v5+RGxDK81ylmCkqA8viT
        L4iJxNtDW7E43UAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v5] random: clear fast pool, crng, and batches in cpuhp
 bring up
Message-ID: <Yg6JhauWYkazt1kJ@linutronix.de>
References: <20220217122729.227908-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217122729.227908-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-17 13:27:29 [+0100], Jason A. Donenfeld wrote:
> Sebastian - this v5 finally follows your suggestion about what
> operations to do at which phase. The only deviation from your exact
> suggestion is that I'm not checking for MIX_INFLIGHT in the online
> handler, and instead just unconditionally zero it out. I think that's an
> acceptable tradeoff to make for simplicity, and it just means we'll
> accumulate even more entropy, which is fine. Hopefully this is an easy
> ack and has no more pitfalls! -Jason

So I think this is the latest, right?

What do you think about this small comment update? :)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 373af789da7ab..3fb14ac1074c5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -698,10 +698,6 @@ u32 get_random_u32(void)
 EXPORT_SYMBOL(get_random_u32);
 
 #ifdef CONFIG_SMP
-/*
- * This function is called by the cpuhp system, wired up via the large
- * static array in kernel/cpu.c, with the entry CPUHP_RANDOM_PREPARE.
- */
 int random_prepare_cpu(unsigned int cpu)
 {
 	/*
@@ -1238,17 +1234,18 @@ static void fast_mix(u32 pool[4])
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
 #ifdef CONFIG_SMP
-/*
- * This function is called by the cpuhp system, wired up via the large
- * static array in kernel/cpu.c, with the entry CPUHP_AP_RANDOM_ONLINE.
- */
 int random_online_cpu(unsigned int cpu)
 {
 	/*
-	 * Set irq randomness count to zero so that new accumulated
-	 * irqs are fresh, and more importantly, so that its worker
-	 * is permitted to schedule again when it comes back online,
-	 * since the MIX_INFLIGHT flag will be cleared.
+	 * This function is invoked while the CPU is comming up, after workqueue
+	 * subsystem has been fully initialized for this CPU.
+	 *
+	 * During CPU bring up and shutdown way may schedule a worker
+	 * (and set MIX_INFLIGHT) which will run another CPU because workqueues
+	 * were not yet ready for this CPU. In this case the worker will
+	 * recognize that it runs on the wrong CPU and do nothing.
+	 * Therefore count is set unconditionally to zero which will permit
+	 * to schedule a new worker soon.
 	 */
 	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
 	return 0;


> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -697,6 +697,25 @@ u32 get_random_u32(void)
>  }
>  EXPORT_SYMBOL(get_random_u32);
>  
> +#ifdef CONFIG_SMP
> +/*
> + * This function is called by the cpuhp system, wired up via the large
> + * static array in kernel/cpu.c, with the entry CPUHP_RANDOM_PREPARE.
> + */
> +int random_prepare_cpu(unsigned int cpu)
> +{
> +	/*
> +	 * When the cpu comes back online, immediately invalidate both
> +	 * the per-cpu crng and all batches, so that we serve fresh
> +	 * randomness.
> +	 */
> +	per_cpu_ptr(&crngs, cpu)->generation = ULONG_MAX;
> +	per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
> +	per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;

This runs before the CPU is up. Could you do the initialisation right
now?
My problem here is that if this (get_random_u32()) is used between
CPUHP_AP_IDLE_DEAD and CPUHP_TEARDOWN_CPU then the initialisation will
happen on the target CPU with disabled interrupts. And will acquire a
sleeping lock (batched_entropy_u32.lock).

You could perform the initialization cross CPU without the lock because
the CPU itself isn't ready yet. Something like
	 batch = per_cpu_ptr(&batched_entropy_u32, cpu);
	 _get_random_bytes(batch->entropy_u32, sizeof(batch->entropy_u32));
	 batch->position = 0;
         batch->generation = next_gen;

should do the job. Plus u64 and I haven't figured out the generation
thingy but I suspect that a sleeping lock is involved.

I did not check if this is a problem on PREEMPT_RT yet but it may become
later one (if we get a user in the hotplug path).

Sebastian
