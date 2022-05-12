Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716665252BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356560AbiELQiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbiELQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:38:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FAF7C78B;
        Thu, 12 May 2022 09:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88CD6B82A02;
        Thu, 12 May 2022 16:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62DFC385B8;
        Thu, 12 May 2022 16:38:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z6KAmAk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652373490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2D/pEhTU/+V82CjpEsLBKB8+2YAiMBZc9DPAa+vQgNs=;
        b=Z6KAmAk0DaDniCQ3cIldb6U8p1i2feTgcYZYEIPxLuk/58yNQvaXh05H2khOMNCXhdSxQ/
        bq46wE+AZ02Avfh0v5/l743+OJdS2O2/BOFoNhRVABZaYtVyxP6h69PIrI8+6eNLuGUKMJ
        1qgr4ejTYe66r0RWYbJ2XjqWxiTvwOE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f2863515 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 16:38:09 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v4] random: use static branch for crng_ready()
Date:   Thu, 12 May 2022 18:37:48 +0200
Message-Id: <20220512163748.3477-1-Jason@zx2c4.com>
In-Reply-To: <20220512144235.2466-1-Jason@zx2c4.com>
References: <20220512144235.2466-1-Jason@zx2c4.com>
MIME-Version: 1.0
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
means we must kick off a workqueue to change the static key. Further
complicating things, credit_init_bits() may be called sufficiently early
on in system initialization such that system_wq is NULL.

Fortunately, there exists the nice function execute_in_process_context(),
which will immediately execute the function if !in_interrupt(), and
otherwise defer it to a workqueue. During early init, before workqueues
are available, in_interrupt() is always false, because interrupts
haven't even been enabled yet, which means the function in that case
executes immediately. Later on, after workqueues are available,
in_interrupt() might be true, but in that case, the work is queued in
system_wq and all goes well.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Sorry for all the churn. execute_in_process_context() appeared out of
the blue and so clearly represents the better option, so happily going
with that now, making this patch finally tiny.

Changes v3->v4:
- Use execute_in_process_context() to resolve quandries.

Changes v2->v3:
- Call schedule_work() outside of the lock.

Changes v1->v2:
- Use a workqueue instead of doing it on-demand.

 drivers/char/random.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2f5460edba28..ec4e8c2657fb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -78,8 +78,9 @@ static enum {
 	CRNG_EMPTY = 0, /* Little to no entropy collected */
 	CRNG_EARLY = 1, /* At least POOL_EARLY_BITS collected */
 	CRNG_READY = 2  /* Fully initialized with POOL_READY_BITS collected */
-} crng_init = CRNG_EMPTY;
-#define crng_ready() (likely(crng_init >= CRNG_READY))
+} crng_init __read_mostly = CRNG_EMPTY;
+static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
+#define crng_ready() (static_branch_likely(&crng_is_ready) || crng_init >= CRNG_READY)
 /* Various types of waiters for crng_init->CRNG_READY transition. */
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
@@ -109,6 +110,11 @@ bool rng_is_initialized(void)
 }
 EXPORT_SYMBOL(rng_is_initialized);
 
+static void crng_set_ready(struct work_struct *work)
+{
+	static_branch_enable(&crng_is_ready);
+}
+
 /* Used by wait_for_random_bytes(), and considered an entropy collector, below. */
 static void try_to_generate_entropy(void);
 
@@ -268,7 +274,8 @@ static void crng_reseed(void)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
-	crng_init = CRNG_READY;
+	if (!static_branch_likely(&crng_is_ready))
+		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
 	memzero_explicit(key, sizeof(key));
 }
@@ -785,6 +792,7 @@ static void extract_entropy(void *buf, size_t nbytes)
 
 static void credit_init_bits(size_t nbits)
 {
+	static struct execute_work set_ready;
 	unsigned int new, orig, add;
 	unsigned long flags;
 
@@ -800,6 +808,7 @@ static void credit_init_bits(size_t nbits)
 
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
+		execute_in_process_context(crng_set_ready, &set_ready);
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
-- 
2.35.1

