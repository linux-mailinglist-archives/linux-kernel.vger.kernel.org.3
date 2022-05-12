Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89E524B74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353133AbiELLV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353249AbiELLUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC414759F;
        Thu, 12 May 2022 04:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5D1961E01;
        Thu, 12 May 2022 11:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5024FC385CB;
        Thu, 12 May 2022 11:18:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DOtdzBWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652354305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7kV97GE6KvbTxeg4g8ZGCLUsajD85LWZd3vcEVao/RI=;
        b=DOtdzBWay8TSRugmWzLQxxci+LWJMuhkhqOdSi/hOLon8nYPW5O15DwPKwxcLmAdZq1wRu
        DenvstGoP3tpbRVJhCHtuD98NgbzGGLkWdHTE6Jl66dX+z7qH9cPAnmu7Hc7Sr0IQW2h8G
        Sqc10Y12DZpkXhjPz+Hho011bxjuz/I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 34fdf052 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 11:18:25 +0000 (UTC)
Date:   Thu, 12 May 2022 13:18:21 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tytso@mit.edu, linux@dominikbrodowski.net, rostedt@goodmis.org,
        ardb@kernel.org
Subject: Re: [PATCH RFC v1] random: use static branch for crng_ready()
Message-ID: <Ynzs/TDjALqfD9vN@zx2c4.com>
References: <Ynug580srdedsiY9@zx2c4.com>
 <YnyOp+8v6inyB0P/@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnyOp+8v6inyB0P/@gondor.apana.org.au>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Thu, May 12, 2022 at 12:35:51PM +0800, Herbert Xu wrote:
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > On Tue, May 03, 2022 at 03:40:52PM +0200, Jason A. Donenfeld wrote:
> >> +static bool crng_ready_slowpath(void)
> >> +{
> >> +     if (crng_init <= 1)
> >> +             return false;
> >> +     if (in_atomic() || irqs_disabled() || cmpxchg(&crng_init, 2, 3) != 2)
> >> +             return true;
> > 
> > Nobody chimed in here, but for posterity I thought I should point out
> > that this approach actually won't work, since in_atomic() doesn't work
> > with CONFIG_PREEMPT_COUNT=n kernels.
> > 
> > So back to the drawing board in trying to figure out the best way to do
> > this...
> 
> Well the standard solution to code paths that require sleeping is
> to use a work queue.  So any reason why you can't just schedule
> a work to do the static_branch_enable?

Yea, that would work but becomes kind of messier than most cases,
because the transition from not-init'd to init'd can happen before
workqueues are even initialized, which means some logic is necessary for
detecting this and then deferring that to happen later on in
initialization. I thought this was pretty "meh", hence looking for other
solutions. But maybe you're right and it's the best we can do here.

For the sake of discussion, below is what the code for that would
approximately look like, modulo whatever details I'm missing. I guess
it's not _that_ bad, if I just rely on the obscure property that
rand_initialize() is called before IRQs are enabled system-wide but
after system_wq has been initialized, but I just hate having the
deferred state be implicit like that. If we go that route, it'll need
comments I suppose.

Jason

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8fa7a5b9aa93..809ee3c1cf78 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -79,7 +79,8 @@ static enum {
 	CRNG_EARLY = 1, /* At least POOL_EARLY_BITS collected */
 	CRNG_READY = 2  /* Fully initialized with POOL_READY_BITS collected */
 } crng_init = CRNG_EMPTY;
-#define crng_ready() (likely(crng_init >= CRNG_READY))
+static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
+#define crng_ready() (static_branch_likely(&crng_is_ready) || unlikely(crng_init >= CRNG_READY))
 /* Various types of waiters for crng_init->CRNG_READY transition. */
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
@@ -109,6 +110,12 @@ bool rng_is_initialized(void)
 }
 EXPORT_SYMBOL(rng_is_initialized);

+static void crng_set_ready(struct work_struct *work)
+{
+	static_branch_enable(&crng_is_ready);
+}
+static DECLARE_WORK(crng_set_ready_work, crng_set_ready);
+
 /* Used by wait_for_random_bytes(), and considered an entropy collector, below. */
 static void try_to_generate_entropy(void);

@@ -268,6 +275,8 @@ static void crng_reseed(void)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
+	if (!crng_ready() && system_wq)
+		schedule_work(&crng_set_ready_work);
 	crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
 	memzero_explicit(key, sizeof(key));
@@ -945,9 +954,18 @@ int __init rand_initialize(void)
 	_mix_pool_bytes(&now, sizeof(now));
 	_mix_pool_bytes(utsname(), sizeof(*(utsname())));

-	if (crng_ready())
+	if (crng_ready()) {
+		/*
+		 * If rand_initialize() is called with the crng already
+		 * initialized, then it means it was done so prior to
+		 * system_wq being available, which means we should now
+		 * schedule the work to change the static key.
+		 */
+		schedule_work(&crng_set_ready_work);
+
+		/* Immediately use the above architectural contributions. */
 		crng_reseed();
-	else if (arch_init && trust_cpu)
+	} else if (arch_init && trust_cpu)
 		credit_init_bits(BLAKE2S_BLOCK_SIZE * 8);

 	WARN_ON(register_pm_notifier(&pm_notifier));
