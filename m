Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0851EF33
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiEHTIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiEHRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:40:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D262E023
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7F71B80E42
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED89AC385AC;
        Sun,  8 May 2022 17:36:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FTkZe9z0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652031391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mACRmOl58U9SO4gJQqVdbRM/DbDb3TktaxEm7VJe80w=;
        b=FTkZe9z0ZKjdh/5f0w3LGQngFA8AbInq0NIWgDVJ1iOnBFWU78Pj13GWf9/uMx3dVkm/8/
        lliDsL/U5rNtXapxsZQd8OUvQEju40dj5pzwLHccEFWzFbGrPS53REvej4G5xDmtCwaPh/
        Q/KwGFkMjUFKX/JcVYgD2qXn8B+6+f4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3cfeec18 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 8 May 2022 17:36:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] random: use symbolic constants for crng_init states
Date:   Sun,  8 May 2022 19:36:10 +0200
Message-Id: <20220508173610.151998-1-Jason@zx2c4.com>
In-Reply-To: <Ynf8qMmN+AAofKMy@zx2c4.com>
References: <Ynf8qMmN+AAofKMy@zx2c4.com>
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

crng_init represents a state machine, with three states, and various
rules for transitions. For the longest time, we've been managing these
with "0", "1", and "2", and expecting people to figure it out. To make
the code more obvious, replace these with proper enum values
representing the transition, and then redocument what each of these
states mean.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2af7a755d632..8af29507ae0d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -72,16 +72,16 @@
  *********************************************************************/
 
 /*
- * crng_init =  0 --> Uninitialized
- *		1 --> Initialized
- *		2 --> Initialized from input_pool
- *
  * crng_init is protected by base_crng->lock, and only increases
- * its value (from 0->1->2).
+ * its value (from empty->early->ready).
  */
-static int crng_init = 0;
-#define crng_ready() (likely(crng_init > 1))
-/* Various types of waiters for crng_init->2 transition. */
+static enum {
+	CRNG_EMPTY = 0, /* Little to no entropy collected */
+	CRNG_EARLY = 1, /* At least POOL_EARLY_BITS collected */
+	CRNG_READY = 2  /* Fully initialized with POOL_READY_BITS collected */
+} crng_init = CRNG_EMPTY;
+#define crng_ready() (likely(crng_init >= CRNG_READY))
+/* Various types of waiters for crng_init->CRNG_READY transition. */
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
 static DEFINE_SPINLOCK(random_ready_chain_lock);
@@ -284,7 +284,7 @@ static void crng_reseed(void)
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
 	if (!crng_ready()) {
-		crng_init = 2;
+		crng_init = CRNG_READY;
 		finalize_init = true;
 	}
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -378,7 +378,7 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	 * For the fast path, we check whether we're ready, unlocked first, and
 	 * then re-check once locked later. In the case where we're really not
 	 * ready, we do fast key erasure with the base_crng directly, extracting
-	 * when crng_init==0.
+	 * when crng_init==CRNG_EMPTY.
 	 */
 	if (!crng_ready()) {
 		bool ready;
@@ -386,7 +386,7 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 		spin_lock_irqsave(&base_crng.lock, flags);
 		ready = crng_ready();
 		if (!ready) {
-			if (crng_init == 0)
+			if (crng_init == CRNG_EMPTY)
 				extract_entropy(base_crng.key, sizeof(base_crng.key));
 			crng_fast_key_erasure(base_crng.key, chacha_state,
 					      random_data, random_data_len);
@@ -740,8 +740,8 @@ EXPORT_SYMBOL(get_random_bytes_arch);
 
 enum {
 	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
-	POOL_INIT_BITS = POOL_BITS, /* No point in settling for less. */
-	POOL_FAST_INIT_BITS = POOL_INIT_BITS / 2
+	POOL_READY_BITS = POOL_BITS, /* When crng_init->CRNG_READY */
+	POOL_EARLY_BITS = POOL_READY_BITS / 2 /* When crng_init->CRNG_EARLY */
 };
 
 static struct {
@@ -836,13 +836,13 @@ static void credit_init_bits(size_t nbits)
 		init_bits = min_t(unsigned int, POOL_BITS, orig + add);
 	} while (cmpxchg(&input_pool.init_bits, orig, init_bits) != orig);
 
-	if (!crng_ready() && init_bits >= POOL_INIT_BITS)
+	if (!crng_ready() && init_bits >= POOL_READY_BITS)
 		crng_reseed();
-	else if (unlikely(crng_init == 0 && init_bits >= POOL_FAST_INIT_BITS)) {
+	else if (unlikely(crng_init == CRNG_EMPTY && init_bits >= POOL_EARLY_BITS)) {
 		spin_lock_irqsave(&base_crng.lock, flags);
-		if (crng_init == 0) {
+		if (crng_init == CRNG_EMPTY) {
 			extract_entropy(base_crng.key, sizeof(base_crng.key));
-			crng_init = 1;
+			crng_init = CRNG_EARLY;
 		}
 		spin_unlock_irqrestore(&base_crng.lock, flags);
 	}
@@ -1595,7 +1595,7 @@ const struct file_operations urandom_fops = {
  *
  * - write_wakeup_threshold - the amount of entropy in the input pool
  *   below which write polls to /dev/random will unblock, requesting
- *   more entropy, tied to the POOL_INIT_BITS constant. It is writable
+ *   more entropy, tied to the POOL_READY_BITS constant. It is writable
  *   to avoid breaking old userspaces, but writing to it does not
  *   change any behavior of the RNG.
  *
@@ -1610,7 +1610,7 @@ const struct file_operations urandom_fops = {
 #include <linux/sysctl.h>
 
 static int sysctl_random_min_urandom_seed = CRNG_RESEED_INTERVAL / HZ;
-static int sysctl_random_write_wakeup_bits = POOL_INIT_BITS;
+static int sysctl_random_write_wakeup_bits = POOL_READY_BITS;
 static int sysctl_poolsize = POOL_BITS;
 static u8 sysctl_bootid[UUID_SIZE];
 
-- 
2.35.1

