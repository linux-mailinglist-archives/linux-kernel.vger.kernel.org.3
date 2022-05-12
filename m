Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95902524C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353643AbiELMXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353633AbiELMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE714041C;
        Thu, 12 May 2022 05:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4094661F30;
        Thu, 12 May 2022 12:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05754C385B8;
        Thu, 12 May 2022 12:22:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="egsZHHrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652358177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZ27B8hsz9tVbAMPDD/9EhCZBnpt47KSJ6fj2jvnUyA=;
        b=egsZHHrEnxvYuuCTUo56RjndyQ1RIPC4RRQ8j4cj1jsvpcAcBog4kA8E0/s5JPIhiwP33i
        YNhuju/6LiSrhfBoEeGcHtWXmGJQVanUbIfneSWcRWtrD6jvHcOiLHadn8mxZu2MNH0Brd
        djXEm9edbqqug4mthZWNM53lLQODJDM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 80d2beca (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 12:22:57 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] random: use static branch for crng_ready()
Date:   Thu, 12 May 2022 14:22:44 +0200
Message-Id: <20220512122244.2805-1-Jason@zx2c4.com>
In-Reply-To: <Ynzs/TDjALqfD9vN@zx2c4.com>
References: <Ynzs/TDjALqfD9vN@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since crng_ready() is only false briefly during initialization and then
forever after becomes true, we don't need to evaluate it after, making
it a prime candidate for a static branch.

One complication, however, is that it changes state in a particular call
to credit_init_bits(), which might be made from atomic context, which
means we must kick off a workqueue to change the static key.

Further complicating things, credit_init_bits() may be called
sufficiently early on in system initialization such that system_wq is
NULL. In that case, we skip scheduling the work item from
credit_init_bits(), but check to see if the rng is already initialized
by the time it hits rand_initialize(), in which case we assume that
there was no crediting event between system_wq becoming non-NULL and
rand_initialize() being called, so we schedule the work then.

We make that assumption because this is still being called in an early
boot environement in which IRQs are disabled. To understand more
clearly, the two flows are as follows.

First possibility, in which credit_init_bits() is called relatively late
in boot:

  - workqueue_init_early()
  - ...
  - rand_initialize()
    * crng_ready()==false → do nothing
  - ...
  - credit_init_bits(256)
    * system_wq!=NULL → schedule_work()

Second possibility, in which credit_init_bits() is called by the super
early EFI-handling code:

  - credit_init_bits(256)
    * system_wq==NULL → do nothing
  - workqueue_init_early()
  - rcu_init(), trace_init(), initcall_debug_enable(),
    context_tracking_init(), early_irq_init(), init_IRQ(), tick_init(),
    rcu_init_nohz(), init_timers(), srcu_init(), hrtimers_init(),
    softirq_init(), timekeeping_init(), kfence_init(), time_init()
    * We assume that none of these call credit_init_bits(). Since IRQs
      are still off, we don't have to worry about other code preempting
      these.
  - rand_initialize()
    * crng_ready()==true → schedule_work()

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Dominik - this is somewhat reminiscent of the misery we went through
with the NUMA node workqueue situation, which I was pretty happy about
removing. Hopefully recent other simplifications make adding something
similar back in not quite as bad, but if you've got the bandwidth, this
could use another pair of eyes. -Jason

 drivers/char/random.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8fa7a5b9aa93..d4bc9beaed2c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -79,7 +79,8 @@ static enum {
 	CRNG_EARLY = 1, /* At least POOL_EARLY_BITS collected */
 	CRNG_READY = 2  /* Fully initialized with POOL_READY_BITS collected */
 } crng_init = CRNG_EMPTY;
-#define crng_ready() (likely(crng_init >= CRNG_READY))
+static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
+#define crng_ready() (static_branch_likely(&crng_is_ready) || crng_init >= CRNG_READY)
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
+		 * If this function is called with the crng already
+		 * initialized, then it means it was done so prior to
+		 * system_wq being available, which means we should now
+		 * schedule the work to change the static key from here.
+		 */
+		schedule_work(&crng_set_ready_work);
+
+		/* Immediately use the above architectural contributions. */
 		crng_reseed();
-	else if (arch_init && trust_cpu)
+	} else if (arch_init && trust_cpu)
 		credit_init_bits(BLAKE2S_BLOCK_SIZE * 8);
 
 	WARN_ON(register_pm_notifier(&pm_notifier));
-- 
2.35.1

