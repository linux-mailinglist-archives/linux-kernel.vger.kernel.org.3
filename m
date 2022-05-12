Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B18B525074
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355518AbiELOmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347679AbiELOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76912F1FB;
        Thu, 12 May 2022 07:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84A8D61D97;
        Thu, 12 May 2022 14:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4ABC385B8;
        Thu, 12 May 2022 14:42:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YtIeksBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652366563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWUocIy/tgF/SXusgcvVJW35oWk0cQUP/+N1/z9CBNw=;
        b=YtIeksBUETN9uqiHC+WHAR2AUffWn7s3lspdhayfH/lURWcApGU7n+UWXoYQEGs3kZ4zoF
        H4OwILjrOBkMhyABXI7OODln6F+0X71pGUT1IWTzO35rbEQ1SwMwTnpSk/00GslndzupZz
        ThMgpe6pEf1h5PtHPvFBcNHO1vT6zks=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3574667a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 14:42:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v3] random: use static branch for crng_ready()
Date:   Thu, 12 May 2022 16:42:35 +0200
Message-Id: <20220512144235.2466-1-Jason@zx2c4.com>
In-Reply-To: <20220512122244.2805-1-Jason@zx2c4.com>
References: <20220512122244.2805-1-Jason@zx2c4.com>
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
by the time it hits random_init(), in which case we assume that there
was no crediting event between system_wq becoming non-NULL and
random_init() being called, so we schedule the work then.

We make that assumption because this is still being called in an early
boot environement in which IRQs are disabled. To understand more
clearly, the two flows are as follows.

First possibility, in which credit_init_bits() is called relatively late
in boot:

  - workqueue_init_early()
  - ...
  - random_init()
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
  - random_init()
    * crng_ready()==true → schedule_work()

Finally, schedule_work() must be called outside of the base_crng.lock,
because it can call into get_random_u32() itself, which will in some
cases attempt to acquire that same lock. So we hoist it outside of the
locked region, and ensure that the branches for that complexity get
removed as well.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Dominik - this is somewhat reminiscent of the misery we went through
with the NUMA node workqueue situation, which I was pretty happy about
removing. Hopefully recent other simplifications make adding something
similar back in not quite as bad, but if you've got the bandwidth, this
could use another pair of eyes. -Jason

Changes v2->v3:
- Call schedule_work() outside of the lock.

Changes v1->v2:
- Use a workqueue instead of doing it on-demand.

 drivers/char/random.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2f5460edba28..ecf017ac5c3d 100644
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
 
@@ -252,6 +259,7 @@ static void crng_reseed(void)
 	unsigned long flags;
 	unsigned long next_gen;
 	u8 key[CHACHA_KEY_SIZE];
+	bool was_ready;
 
 	extract_entropy(key, sizeof(key));
 
@@ -268,9 +276,12 @@ static void crng_reseed(void)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
+	was_ready = crng_ready();
 	crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
 	memzero_explicit(key, sizeof(key));
+	if (!static_branch_likely(&crng_is_ready) && !was_ready && system_wq)
+		schedule_work(&crng_set_ready_work);
 }
 
 /*
@@ -948,9 +959,18 @@ int __init random_init(const char *command_line)
 	_mix_pool_bytes(command_line, strlen(command_line));
 	add_latent_entropy();
 
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
-	else if (trust_cpu)
+	} else if (trust_cpu)
 		credit_init_bits(arch_init * 8);
 
 	WARN_ON(register_pm_notifier(&pm_notifier));
-- 
2.35.1

