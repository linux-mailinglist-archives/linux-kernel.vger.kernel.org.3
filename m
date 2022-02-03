Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB204A8B72
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353356AbiBCSVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiBCSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:21:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D04DC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:21:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFCA2B8339B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 18:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F8AC340E8;
        Thu,  3 Feb 2022 18:21:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hutNA+nf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643912459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PBLkGsV5oBDgmW5D8NYF1kyoXifEMiFttT9CWhIEpPg=;
        b=hutNA+nfvbXGWnR1ZGULkd8AZPl2FSwZQ1USgekYlgJ9GaNADy0uj/YxfXTd9phN/0sG22
        ve0m4JojnJPJ3ZM/c/XGGjUsFxsPBVMBDQeqPAFlfi50BWOFCcm9aoag5mGiubSdeIkEM6
        xf7X5Et9FG/cboB0lpXV4ACgnRNGS9U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c0ecda08 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 3 Feb 2022 18:20:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] random: simplify entropy debiting
Date:   Thu,  3 Feb 2022 19:20:44 +0100
Message-Id: <20220203182045.35904-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our pool is 256 bits, and we only ever use all of it or don't use it at
all, which is decided by whether or not it has 128 bits in it. So we can
drastically simplify the accounting and cmpxchg loop to do exactly this.
While we're at it, we move the minimum bit size into a constant so it
can be shared between the two places where it matters.

The reason we want any of this is for the case in which an attacker has
compromised the current state, and then bruteforces small amounts of
entropy added to it. By demanding a particular minimum amount of entropy
be present before reseeding, we make that bruteforcing difficult.

Note that this rationale no longer includes anything about /dev/random
blocking at the right moment, since /dev/random no longer blocks (except
for at ~boot), but rather uses the crng. In a former life, /dev/random
was different and therefore required a more nuanced account(), but this
is no longer.

Behaviorally, nothing changes here. This is just a simplification of
the code.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c         | 91 ++++++++---------------------------
 include/trace/events/random.h | 30 +++---------
 2 files changed, 27 insertions(+), 94 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1295ba8ba0c8..260ef3d18846 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -361,12 +361,14 @@
 enum poolinfo {
 	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
 	POOL_BITSHIFT = ilog2(POOL_BITS),
+	POOL_MIN_BITS = POOL_BITS / 2,
 
 	/* To allow fractional bits to be tracked, the entropy_count field is
 	 * denominated in units of 1/8th bits. */
 	POOL_ENTROPY_SHIFT = 3,
 #define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)
-	POOL_FRACBITS = POOL_BITS << POOL_ENTROPY_SHIFT
+	POOL_FRACBITS = POOL_BITS << POOL_ENTROPY_SHIFT,
+	POOL_MIN_FRACBITS = POOL_MIN_BITS << POOL_ENTROPY_SHIFT
 };
 
 /*
@@ -447,8 +449,7 @@ static struct {
 	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
 };
 
-static bool extract_entropy(void *buf, size_t nbytes, int min);
-static void _extract_entropy(void *buf, size_t nbytes);
+static void extract_entropy(void *buf, size_t nbytes);
 
 static void crng_reseed(struct crng_state *crng, bool use_input_pool);
 
@@ -539,7 +540,7 @@ static void process_random_ready_list(void)
  */
 static void credit_entropy_bits(int nbits)
 {
-	int entropy_count, entropy_bits, orig;
+	int entropy_count, orig;
 	int nfrac = nbits << POOL_ENTROPY_SHIFT;
 
 	/* Ensure that the multiplication can avoid being 64 bits wide. */
@@ -599,8 +600,7 @@ static void credit_entropy_bits(int nbits)
 
 	trace_credit_entropy_bits(nbits, entropy_count >> POOL_ENTROPY_SHIFT, _RET_IP_);
 
-	entropy_bits = entropy_count >> POOL_ENTROPY_SHIFT;
-	if (crng_init < 2 && entropy_bits >= 128)
+	if (crng_init < 2 && entropy_count >= POOL_MIN_FRACBITS)
 		crng_reseed(&primary_crng, true);
 }
 
@@ -690,7 +690,7 @@ static void crng_initialize_secondary(struct crng_state *crng)
 
 static void __init crng_initialize_primary(void)
 {
-	_extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
+	extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
 	if (crng_init_try_arch_early() && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
 		numa_crng_init();
@@ -860,8 +860,17 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 	} buf;
 
 	if (use_input_pool) {
-		if (!extract_entropy(&buf, 32, 16))
-			return;
+		int entropy_count;
+		do {
+			entropy_count = READ_ONCE(input_pool.entropy_count);
+			if (entropy_count < POOL_MIN_FRACBITS)
+				return;
+		} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
+		extract_entropy(buf.key, sizeof(buf.key));
+		if (random_write_wakeup_bits) {
+			wake_up_interruptible(&random_write_wait);
+			kill_fasync(&fasync, SIGIO, POLL_OUT);
+		}
 	} else {
 		_extract_crng(&primary_crng, buf.block);
 		_crng_backtrack_protect(&primary_crng, buf.block,
@@ -1186,52 +1195,11 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
  *
  *********************************************************************/
 
-/*
- * This function decides how many bytes to actually take from the
- * given pool, and also debits the entropy count accordingly.
- */
-static size_t account(size_t nbytes, int min)
-{
-	int entropy_count, orig;
-	size_t ibytes, nfrac;
-
-	BUG_ON(input_pool.entropy_count > POOL_FRACBITS);
-
-	/* Can we pull enough? */
-retry:
-	entropy_count = orig = READ_ONCE(input_pool.entropy_count);
-	if (WARN_ON(entropy_count < 0)) {
-		pr_warn("negative entropy count: count %d\n", entropy_count);
-		entropy_count = 0;
-	}
-
-	/* never pull more than available */
-	ibytes = min_t(size_t, nbytes, entropy_count >> (POOL_ENTROPY_SHIFT + 3));
-	if (ibytes < min)
-		ibytes = 0;
-	nfrac = ibytes << (POOL_ENTROPY_SHIFT + 3);
-	if ((size_t)entropy_count > nfrac)
-		entropy_count -= nfrac;
-	else
-		entropy_count = 0;
-
-	if (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig)
-		goto retry;
-
-	trace_debit_entropy(8 * ibytes);
-	if (ibytes && POOL_ENTROPY_BITS() < random_write_wakeup_bits) {
-		wake_up_interruptible(&random_write_wait);
-		kill_fasync(&fasync, SIGIO, POLL_OUT);
-	}
-
-	return ibytes;
-}
-
 /*
  * This is an HKDF-like construction for using the hashed collected entropy
  * as a PRF key, that's then expanded block-by-block.
  */
-static void _extract_entropy(void *buf, size_t nbytes)
+static void extract_entropy(void *buf, size_t nbytes)
 {
 	unsigned long flags;
 	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
@@ -1241,6 +1209,8 @@ static void _extract_entropy(void *buf, size_t nbytes)
 	} block;
 	size_t i;
 
+	trace_extract_entropy(nbytes, POOL_ENTROPY_BITS());
+
 	for (i = 0; i < ARRAY_SIZE(block.rdrand); ++i) {
 		if (!arch_get_random_long(&block.rdrand[i]))
 			block.rdrand[i] = random_get_entropy();
@@ -1272,25 +1242,6 @@ static void _extract_entropy(void *buf, size_t nbytes)
 	memzero_explicit(&block, sizeof(block));
 }
 
-/*
- * This function extracts randomness from the "entropy pool", and
- * returns it in a buffer.
- *
- * The min parameter specifies the minimum amount we can pull before
- * failing to avoid races that defeat catastrophic reseeding. If we
- * have less than min entropy available, we return false and buf is
- * not filled.
- */
-static bool extract_entropy(void *buf, size_t nbytes, int min)
-{
-	trace_extract_entropy(nbytes, POOL_ENTROPY_BITS(), _RET_IP_);
-	if (account(nbytes, min)) {
-		_extract_entropy(buf, nbytes);
-		return true;
-	}
-	return false;
-}
-
 #define warn_unseeded_randomness(previous) \
 	_warn_unseeded_randomness(__func__, (void *)_RET_IP_, (previous))
 
diff --git a/include/trace/events/random.h b/include/trace/events/random.h
index a2d9aa16a5d7..ad149aeaf42c 100644
--- a/include/trace/events/random.h
+++ b/include/trace/events/random.h
@@ -79,22 +79,6 @@ TRACE_EVENT(credit_entropy_bits,
 		  __entry->bits, __entry->entropy_count, (void *)__entry->IP)
 );
 
-TRACE_EVENT(debit_entropy,
-	TP_PROTO(int debit_bits),
-
-	TP_ARGS( debit_bits),
-
-	TP_STRUCT__entry(
-		__field(	  int,	debit_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->debit_bits	= debit_bits;
-	),
-
-	TP_printk("input pool: debit_bits %d", __entry->debit_bits)
-);
-
 TRACE_EVENT(add_input_randomness,
 	TP_PROTO(int input_bits),
 
@@ -161,31 +145,29 @@ DEFINE_EVENT(random__get_random_bytes, get_random_bytes_arch,
 );
 
 DECLARE_EVENT_CLASS(random__extract_entropy,
-	TP_PROTO(int nbytes, int entropy_count, unsigned long IP),
+	TP_PROTO(int nbytes, int entropy_count),
 
-	TP_ARGS(nbytes, entropy_count, IP),
+	TP_ARGS(nbytes, entropy_count),
 
 	TP_STRUCT__entry(
 		__field(	  int,	nbytes			)
 		__field(	  int,	entropy_count		)
-		__field(unsigned long,	IP			)
 	),
 
 	TP_fast_assign(
 		__entry->nbytes		= nbytes;
 		__entry->entropy_count	= entropy_count;
-		__entry->IP		= IP;
 	),
 
-	TP_printk("input pool: nbytes %d entropy_count %d caller %pS",
-		  __entry->nbytes, __entry->entropy_count, (void *)__entry->IP)
+	TP_printk("input pool: nbytes %d entropy_count %d",
+		  __entry->nbytes, __entry->entropy_count)
 );
 
 
 DEFINE_EVENT(random__extract_entropy, extract_entropy,
-	TP_PROTO(int nbytes, int entropy_count, unsigned long IP),
+	TP_PROTO(int nbytes, int entropy_count),
 
-	TP_ARGS(nbytes, entropy_count, IP)
+	TP_ARGS(nbytes, entropy_count)
 );
 
 TRACE_EVENT(urandom_read,
-- 
2.35.0

