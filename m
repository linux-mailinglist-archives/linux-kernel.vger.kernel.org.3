Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E06495107
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376355AbiATPH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiATPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:07:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B79C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:07:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15E50B81D7F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B202C340E5;
        Thu, 20 Jan 2022 15:07:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="du+9EPhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642691272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cy4G1xwqxsSWWvVGbvG/Ej2dahjAM+uexUKu3EtqffE=;
        b=du+9EPhb3GRQ9fNA4vE3gbEwGmUdGKf7Io/VEiY+LpzFxy6TJRWksueQDNpkmHENJgbNFq
        Opgazdrvt6OpAfcTLBDHV9SSmynhtrOC8JioG1sfGFuH51EMWEA39fidhrb0R6a4xVwfgr
        QjIkCIb2NZDQTOMk2wW1vO/Uti/uQjQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e7aa1dbe (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 20 Jan 2022 15:07:51 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: use named fields for adjusting chacha state
Date:   Thu, 20 Jan 2022 16:07:34 +0100
Message-Id: <20220120150734.509125-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9pxJFBv-ZZ3bPMJdmxUO4oeY-wS4BtW34w1ncbeeU=MeA@mail.gmail.com>
References: <CAHmME9pxJFBv-ZZ3bPMJdmxUO4oeY-wS4BtW34w1ncbeeU=MeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than hard coding [4] and [12] and such in places, use an
anonymous struct where we can actually name the individual fields. In
the process, always extract to the key field and not into the
counter/nonce fields. We only need 256-bits anyway, and before those
extra bytes were only filled in at init time when there's not even any
entropy, so we're not losing anything substantial. We can then make the
nonce field into a u64 and increment it in the impossibly-likely event
that the counter wraps under the same key.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 49 ++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b411182df6f6..7413c55c7c5c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -443,17 +443,23 @@ static DEFINE_SPINLOCK(random_ready_list_lock);
 static LIST_HEAD(random_ready_list);
 
 struct crng_state {
-	u32 state[16];
+	union {
+		u32 state[CHACHA_STATE_WORDS];
+		struct {
+			u32 constants[4];
+			u32 key[CHACHA_KEY_SIZE / sizeof(u32)];
+			u32 counter[2];
+			u64 nonce;
+		};
+	};
 	unsigned long init_time;
 	spinlock_t lock;
 };
 
 static struct crng_state primary_crng = {
 	.lock = __SPIN_LOCK_UNLOCKED(primary_crng.lock),
-	.state[0] = CHACHA_CONSTANT_EXPA,
-	.state[1] = CHACHA_CONSTANT_ND_3,
-	.state[2] = CHACHA_CONSTANT_2_BY,
-	.state[3] = CHACHA_CONSTANT_TE_K,
+	.constants = { CHACHA_CONSTANT_EXPA, CHACHA_CONSTANT_ND_3,
+		       CHACHA_CONSTANT_2_BY, CHACHA_CONSTANT_TE_K }
 };
 
 /*
@@ -750,13 +756,13 @@ static bool crng_init_try_arch(struct crng_state *crng)
 	bool arch_init = true;
 	unsigned long rv;
 
-	for (i = 4; i < 16; i++) {
+	for (i = 0; i < ARRAY_SIZE(crng->key); i++) {
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv)) {
 			rv = random_get_entropy();
 			arch_init = false;
 		}
-		crng->state[i] ^= rv;
+		crng->key[i] ^= rv;
 	}
 
 	return arch_init;
@@ -768,13 +774,13 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
 	bool arch_init = true;
 	unsigned long rv;
 
-	for (i = 4; i < 16; i++) {
+	for (i = 0; i < ARRAY_SIZE(crng->key); i++) {
 		if (!arch_get_random_seed_long_early(&rv) &&
 		    !arch_get_random_long_early(&rv)) {
 			rv = random_get_entropy();
 			arch_init = false;
 		}
-		crng->state[i] ^= rv;
+		crng->key[i] ^= rv;
 	}
 
 	return arch_init;
@@ -783,14 +789,14 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
 static void crng_initialize_secondary(struct crng_state *crng)
 {
 	chacha_init_consts(crng->state);
-	_get_random_bytes(&crng->state[4], sizeof(u32) * 12);
+	_get_random_bytes(&crng->key, sizeof(crng->key));
 	crng_init_try_arch(crng);
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
 static void __init crng_initialize_primary(struct crng_state *crng)
 {
-	_extract_entropy(&crng->state[4], sizeof(u32) * 12);
+	_extract_entropy(&crng->key, sizeof(crng->key));
 	if (crng_init_try_arch_early(crng) && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
 		numa_crng_init();
@@ -892,7 +898,7 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 		return 0;
 	}
-	p = (u8 *)&primary_crng.state[4];
+	p = (u8 *)primary_crng.key;
 	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
 		p[crng_init_cnt % CHACHA_KEY_SIZE] ^= *cp;
 		cp++; crng_init_cnt++; len--; ret++;
@@ -927,7 +933,7 @@ static int crng_slow_load(const u8 *cp, size_t len)
 	u8 tmp;
 	unsigned int i, max = CHACHA_KEY_SIZE;
 	const u8 *src_buf = cp;
-	u8 *dest_buf = (u8 *)&primary_crng.state[4];
+	u8 *dest_buf = (u8 *)primary_crng.key;
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
@@ -970,12 +976,12 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 					CHACHA_KEY_SIZE);
 	}
 	spin_lock_irqsave(&crng->lock, flags);
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < ARRAY_SIZE(crng->key); i++) {
 		unsigned long rv;
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv))
 			rv = random_get_entropy();
-		crng->state[i + 4] ^= buf.key[i] ^ rv;
+		crng->key[i] ^= buf.key[i] ^ rv;
 	}
 	memzero_explicit(&buf, sizeof(buf));
 	WRITE_ONCE(crng->init_time, jiffies);
@@ -994,9 +1000,9 @@ static void _extract_crng(struct crng_state *crng, u8 out[CHACHA_BLOCK_SIZE])
 			crng_reseed(crng, crng == &primary_crng);
 	}
 	spin_lock_irqsave(&crng->lock, flags);
-	chacha20_block(&crng->state[0], out);
-	if (crng->state[12] == 0)
-		crng->state[13]++;
+	chacha20_block(crng->state, out);
+	if (unlikely(!crng->counter[0] && !++crng->counter[1]))
+		++crng->nonce;
 	spin_unlock_irqrestore(&crng->lock, flags);
 }
 
@@ -1013,7 +1019,7 @@ static void _crng_backtrack_protect(struct crng_state *crng,
 				    u8 tmp[CHACHA_BLOCK_SIZE], int used)
 {
 	unsigned long flags;
-	u32 *s, *d;
+	u32 *s;
 	int i;
 
 	used = round_up(used, sizeof(u32));
@@ -1023,9 +1029,8 @@ static void _crng_backtrack_protect(struct crng_state *crng,
 	}
 	spin_lock_irqsave(&crng->lock, flags);
 	s = (u32 *)&tmp[used];
-	d = &crng->state[4];
-	for (i = 0; i < 8; i++)
-		*d++ ^= *s++;
+	for (i = 0; i < ARRAY_SIZE(crng->key); i++)
+		crng->key[i] ^= s[i];
 	spin_unlock_irqrestore(&crng->lock, flags);
 }
 
-- 
2.34.1

