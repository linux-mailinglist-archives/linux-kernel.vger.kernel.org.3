Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB55F4B1F08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbiBKHJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:09:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiBKHJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:09:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB0B1095;
        Thu, 10 Feb 2022 23:09:22 -0800 (PST)
Date:   Fri, 11 Feb 2022 08:09:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644563359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlM7+juu/GPPkJUBXHqWhJvR/J9vUiLmk2//gpgjumg=;
        b=NSoxX5tBnaniA9VTW+4GqLfOd3Qm6w1/OSJQgVMaaSXrHzQSh7Act3O8eiIjlUFDUKWw0s
        gssCKO4wfsALbNePhGN0SD4fg6JBLY/wETNzRKd3Ia8VX/hzVPqO2cACjU06kWFl3f0eM3
        YmJnVHg48ng6BumHeJUrQdQzoBCtLQp5of8GOHtdMmbq19rXoZQp+fd9fRk1r64LUQPw1r
        qvkOUJKMUwISTWsdvMxd3tdImmbWnLa4T8yrSqZFdOtMCJwSjYNXDt9cBPfRWE1kTkPixs
        8gYJIJYy7ocXdoDHsu9Wad9aHlxm+G927YZGAKC6KuutlBocdvgFVA08uEq22w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644563359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlM7+juu/GPPkJUBXHqWhJvR/J9vUiLmk2//gpgjumg=;
        b=ktp/FWSay7sm+Cfw4oHTRNST6Bmt22D8wC5MQwAdpn4e8DjKzSosGdjluYz2ghEGKuAEYP
        fQMUcY3Zv3AAIHAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v4 2/2] random: defer fast pool mixing to worker
Message-ID: <YgYLnspXs5bwfOiD@linutronix.de>
References: <20220209125644.533876-1-Jason@zx2c4.com>
 <20220209125644.533876-3-Jason@zx2c4.com>
 <YgVTpI/sYLecyWa3@linutronix.de>
 <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 01:42:56 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> Thanks for pointing this out. I'll actually fix this using atomics,
> and fix another minor issue at the same time the same way, and move to
> making sure the worker is running on the right CPU like we originally
> discussed. I'm going to send that as an additional patch so that we
> can narrow in on the issue there. It's a little bit involved but not
> too bad. I'll have that for you shortly.

oki.

> > crng_fast_load() does spin_trylock_irqsave() in hardirq context. It does
> > not produce any warning on RT but is still wrong IMHO:
> > If we just could move this, too.
> > I don't know how timing critical this is but the first backtrace from
> > crng_fast_load() came (to my surprise) from hwrng_fillfn() (a kthread)
> > and added 64bytes in one go.
> 
> I'll look into seeing if I can do it. On my first pass a few days ago,
> it seemed a bit too tricky, but I'll revisit after this part here
> settles. Thanks for your benchmarks, by the way. That's useful.

If you want me to do it again or another machines, just let me know.
That was from a bigger x86 machine. I added that series and the patch at
the bottom to my RT queue.

-------->8--------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 10 Feb 2022 18:22:05 +0100
Subject: [PATCH] random: Move crng_fast_load() to the worker.

crng_fast_load() is invoked from hard IRQ context and acquires a
spinlock_t via a trylock. If the lock is locked in hard IRQ context then
the following locking attempt (on another CPU) will PI-boost the wrong
task.

Move the crng_fast_load() invocation into the worker.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1047,6 +1047,17 @@ static void mix_interrupt_randomness(str
 	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
 	u8 pool[sizeof(fast_pool->pool)];
 
+	if (unlikely(crng_init == 0)) {
+		size_t ret;
+
+		ret = crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool));
+		if (ret) {
+			WRITE_ONCE(fast_pool->count, 0);
+			fast_pool->last = jiffies;
+			return;
+		}
+	}
+
 	/*
 	 * Since this is the result of a trip through the scheduler, xor in
 	 * a cycle counter. It can't hurt, and might help.
@@ -1089,11 +1100,17 @@ void add_interrupt_randomness(int irq)
 	new_count = ++fast_pool->count;
 
 	if (unlikely(crng_init == 0)) {
-		if (new_count >= 64 &&
-		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
-			fast_pool->count = 0;
-			fast_pool->last = now;
-		}
+		if (new_count & FAST_POOL_MIX_INFLIGHT)
+			return;
+
+		if (new_count < 64)
+			return;
+
+		fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
+		if (unlikely(!fast_pool->mix.func))
+			INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+		queue_work_on(raw_smp_processor_id(), system_highpri_wq,
+			      &fast_pool->mix);
 		return;
 	}
 

> Jason

Sebastian
