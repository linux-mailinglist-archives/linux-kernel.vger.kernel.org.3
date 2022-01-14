Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733C048ED29
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiANPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiANPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:33:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31021C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:33:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E5061F10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9F4C36AE5;
        Fri, 14 Jan 2022 15:33:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iTu4Hxjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642174389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAAyyceIFMPc5B1he6/mvraGi9qhHcMaex54ykhE1r8=;
        b=iTu4HxjsDehk5oqgazHDhMt2Cly9gFmvU7wSlTxkKdJof2rMCPkSajvhd5OunrOkEndYU2
        XwJDKJ4NiixSmYT5WqpayjWIqz88UM7R36rE+f/6g49ansZfdkVl9C07f26Nn96W+ugH1M
        ja0Js839hSoZTUo5p5h/m+YuXvzQuMM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 452f4a8e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 14 Jan 2022 15:33:09 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: cleanup fractional entropy shift constants
Date:   Fri, 14 Jan 2022 16:33:05 +0100
Message-Id: <20220114153305.98505-1-Jason@zx2c4.com>
In-Reply-To: <20220113154413.29513-1-Jason@zx2c4.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entropy estimator is calculated in terms of 1/8 bits, which means
there are various constants where things are shifted by 3. Move these
into our pool info enum with the other relevant constants, and normalize
the name a bit, prepending a POOL_ like the rest. While we're at it,
move an English assertion about sizes into a proper BUILD_BUG_ON so
that the compiler can ensure this invariant.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 04b7efb034f7..1ca6d9c6d768 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -358,16 +358,6 @@
 
 /* #define ADD_INTERRUPT_BENCH */
 
-/*
- * To allow fractional bits to be tracked, the entropy_count field is
- * denominated in units of 1/8th bits.
- *
- * 2*(ENTROPY_SHIFT + poolbitshift) must <= 31, or the multiply in
- * credit_entropy_bits() needs to be 64 bits wide.
- */
-#define ENTROPY_SHIFT 3
-#define ENTROPY_BITS() (input_pool.entropy_count >> ENTROPY_SHIFT)
-
 /*
  * If the entropy count falls under this number of bits, then we
  * should wake up processes which are selecting or polling on write
@@ -425,8 +415,13 @@ enum poolinfo {
 	POOL_WORDMASK = POOL_WORDS - 1,
 	POOL_BYTES = POOL_WORDS * sizeof(u32),
 	POOL_BITS = POOL_BYTES * 8,
-	POOL_BITSHIFT = ilog2(POOL_WORDS) + 5,
-	POOL_FRACBITS = POOL_WORDS << (ENTROPY_SHIFT + 5),
+	POOL_BITSHIFT = ilog2(POOL_BITS),
+
+	/* To allow fractional bits to be tracked, the entropy_count field is
+	 * denominated in units of 1/8th bits. */
+	POOL_ENTROPY_SHIFT = 3,
+#define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)
+	POOL_FRACBITS = POOL_BITS << POOL_ENTROPY_SHIFT,
 
 	/* x^128 + x^104 + x^76 + x^51 +x^25 + x + 1 */
 	POOL_TAP1 = 104,
@@ -650,7 +645,10 @@ static void process_random_ready_list(void)
 static void credit_entropy_bits(int nbits)
 {
 	int entropy_count, entropy_bits, orig;
-	int nfrac = nbits << ENTROPY_SHIFT;
+	int nfrac = nbits << POOL_ENTROPY_SHIFT;
+
+	/* Ensure that the multiplication can avoid being 64 bits wide. */
+	BUILD_BUG_ON(2 * (POOL_ENTROPY_SHIFT + POOL_BITSHIFT) > 31);
 
 	if (!nbits)
 		return;
@@ -683,17 +681,17 @@ static void credit_entropy_bits(int nbits)
 		 * turns no matter how large nbits is.
 		 */
 		int pnfrac = nfrac;
-		const int s = POOL_BITSHIFT + ENTROPY_SHIFT + 2;
+		const int s = POOL_BITSHIFT + POOL_ENTROPY_SHIFT + 2;
 		/* The +2 corresponds to the /4 in the denominator */
 
 		do {
-			unsigned int anfrac = min(pnfrac, POOL_FRACBITS/2);
+			unsigned int anfrac = min(pnfrac, POOL_FRACBITS / 2);
 			unsigned int add =
-				((POOL_FRACBITS - entropy_count)*anfrac*3) >> s;
+				((POOL_FRACBITS - entropy_count) * anfrac * 3) >> s;
 
 			entropy_count += add;
 			pnfrac -= anfrac;
-		} while (unlikely(entropy_count < POOL_FRACBITS-2 && pnfrac));
+		} while (unlikely(entropy_count < POOL_FRACBITS - 2 && pnfrac));
 	}
 
 	if (WARN_ON(entropy_count < 0)) {
@@ -704,9 +702,9 @@ static void credit_entropy_bits(int nbits)
 	if (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
-	trace_credit_entropy_bits(nbits, entropy_count >> ENTROPY_SHIFT, _RET_IP_);
+	trace_credit_entropy_bits(nbits, entropy_count >> POOL_ENTROPY_SHIFT, _RET_IP_);
 
-	entropy_bits = entropy_count >> ENTROPY_SHIFT;
+	entropy_bits = entropy_count >> POOL_ENTROPY_SHIFT;
 	if (crng_init < 2 && entropy_bits >= 128)
 		crng_reseed(&primary_crng, true);
 }
@@ -1187,7 +1185,7 @@ void add_input_randomness(unsigned int type, unsigned int code,
 	last_value = value;
 	add_timer_randomness(&input_timer_state,
 			     (type << 4) ^ code ^ (code >> 4) ^ value);
-	trace_add_input_randomness(ENTROPY_BITS());
+	trace_add_input_randomness(POOL_ENTROPY_BITS());
 }
 EXPORT_SYMBOL_GPL(add_input_randomness);
 
@@ -1286,7 +1284,7 @@ void add_disk_randomness(struct gendisk *disk)
 		return;
 	/* first major is 1, so we get >= 0x200 here */
 	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
-	trace_add_disk_randomness(disk_devt(disk), ENTROPY_BITS());
+	trace_add_disk_randomness(disk_devt(disk), POOL_ENTROPY_BITS());
 }
 EXPORT_SYMBOL_GPL(add_disk_randomness);
 #endif
@@ -1313,7 +1311,7 @@ static size_t account(size_t nbytes, int min)
 	entropy_count = orig = READ_ONCE(input_pool.entropy_count);
 	ibytes = nbytes;
 	/* never pull more than available */
-	have_bytes = entropy_count >> (ENTROPY_SHIFT + 3);
+	have_bytes = entropy_count >> (POOL_ENTROPY_SHIFT + 3);
 
 	if (have_bytes < 0)
 		have_bytes = 0;
@@ -1325,7 +1323,7 @@ static size_t account(size_t nbytes, int min)
 		pr_warn("negative entropy count: count %d\n", entropy_count);
 		entropy_count = 0;
 	}
-	nfrac = ibytes << (ENTROPY_SHIFT + 3);
+	nfrac = ibytes << (POOL_ENTROPY_SHIFT + 3);
 	if ((size_t) entropy_count > nfrac)
 		entropy_count -= nfrac;
 	else
@@ -1335,7 +1333,7 @@ static size_t account(size_t nbytes, int min)
 		goto retry;
 
 	trace_debit_entropy(8 * ibytes);
-	if (ibytes && ENTROPY_BITS() < random_write_wakeup_bits) {
+	if (ibytes && POOL_ENTROPY_BITS() < random_write_wakeup_bits) {
 		wake_up_interruptible(&random_write_wait);
 		kill_fasync(&fasync, SIGIO, POLL_OUT);
 	}
@@ -1423,7 +1421,7 @@ static ssize_t _extract_entropy(void *buf, size_t nbytes)
  */
 static ssize_t extract_entropy(void *buf, size_t nbytes, int min)
 {
-	trace_extract_entropy(nbytes, ENTROPY_BITS(), _RET_IP_);
+	trace_extract_entropy(nbytes, POOL_ENTROPY_BITS(), _RET_IP_);
 	nbytes = account(nbytes, min);
 	return _extract_entropy(buf, nbytes);
 }
@@ -1749,9 +1747,9 @@ urandom_read_nowarn(struct file *file, char __user *buf, size_t nbytes,
 {
 	int ret;
 
-	nbytes = min_t(size_t, nbytes, INT_MAX >> (ENTROPY_SHIFT + 3));
+	nbytes = min_t(size_t, nbytes, INT_MAX >> (POOL_ENTROPY_SHIFT + 3));
 	ret = extract_crng_user(buf, nbytes);
-	trace_urandom_read(8 * nbytes, 0, ENTROPY_BITS());
+	trace_urandom_read(8 * nbytes, 0, POOL_ENTROPY_BITS());
 	return ret;
 }
 
@@ -1791,7 +1789,7 @@ random_poll(struct file *file, poll_table * wait)
 	mask = 0;
 	if (crng_ready())
 		mask |= EPOLLIN | EPOLLRDNORM;
-	if (ENTROPY_BITS() < random_write_wakeup_bits)
+	if (POOL_ENTROPY_BITS() < random_write_wakeup_bits)
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	return mask;
 }
@@ -1847,7 +1845,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	case RNDGETENTCNT:
 		/* inherently racy, no point locking */
-		ent_count = ENTROPY_BITS();
+		ent_count = POOL_ENTROPY_BITS();
 		if (put_user(ent_count, p))
 			return -EFAULT;
 		return 0;
@@ -2005,7 +2003,7 @@ static int proc_do_entropy(struct ctl_table *table, int write,
 	struct ctl_table fake_table;
 	int entropy_count;
 
-	entropy_count = *(int *)table->data >> ENTROPY_SHIFT;
+	entropy_count = *(int *)table->data >> POOL_ENTROPY_SHIFT;
 
 	fake_table.data = &entropy_count;
 	fake_table.maxlen = sizeof(entropy_count);
@@ -2224,7 +2222,7 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	 */
 	wait_event_interruptible(random_write_wait,
 			!system_wq || kthread_should_stop() ||
-			ENTROPY_BITS() <= random_write_wakeup_bits);
+			POOL_ENTROPY_BITS() <= random_write_wakeup_bits);
 	mix_pool_bytes(buffer, count);
 	credit_entropy_bits(entropy);
 }
-- 
2.34.1

