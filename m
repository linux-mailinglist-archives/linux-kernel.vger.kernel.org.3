Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10451E6DB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446356AbiEGMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiEGMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:23:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08A1A05F;
        Sat,  7 May 2022 05:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A53961195;
        Sat,  7 May 2022 12:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A89C385A5;
        Sat,  7 May 2022 12:19:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AABRZPsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651925964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fm20dKFLEN95Lca30SmFVNz0iun9FaCevlUQohqkehk=;
        b=AABRZPsadmgcOUHlhsQtnOsFYvo6elhzEDB1GJ3/M1m7WXOGSBHZA3DR19O8+oASRouYm+
        VrtK23nkdFwg9JsngQnRf47Smq/dJ0JpnTOcoFEg6lpoAGgruhvu9xRd5b/kEagFtaQ2/3
        ZxD5m3l4Zh3WUGxQIWCA5ywDviCeo4I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 25d93b7a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 7 May 2022 12:19:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] siphash: use one source of truth for siphash permutations
Date:   Sat,  7 May 2022 14:19:09 +0200
Message-Id: <20220507121909.974453-1-Jason@zx2c4.com>
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

The SipHash family of permutations is currently used in three places:

- siphash.c itself, used in the ordinary way it was intended to use.
- random32.c, in a construction from an anonymous contributor.
- random.c, as part of its fast_mix function.

Each one of these places reinvents the wheel with the same C code, same
rotation constants, and same symmetry-breaking constants.

This commit tidies things up a bit by placing macros for the
permutations and constants into siphash.h, where each of the three .c
users can access them. It also leaves a note dissuading more users of
them from emerging.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c   | 30 +++++++-----------------------
 include/linux/prandom.h | 23 +++++++----------------
 include/linux/siphash.h | 28 ++++++++++++++++++++++++++++
 lib/siphash.c           | 32 ++++++++++----------------------
 4 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a04ecfcb4f1e..87cf739929be 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -53,6 +53,7 @@
 #include <linux/uuid.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/siphash.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
 #include <asm/processor.h>
@@ -1086,12 +1087,11 @@ struct fast_pool {
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
 #ifdef CONFIG_64BIT
-	/* SipHash constants */
-	.pool = { 0x736f6d6570736575UL, 0x646f72616e646f6dUL,
-		  0x6c7967656e657261UL, 0x7465646279746573UL }
+#define FASTMIX_PERM SIPHASH_PERMUTATION
+	.pool = { SIPHASH_CONST_0, SIPHASH_CONST_1, SIPHASH_CONST_2, SIPHASH_CONST_3 }
 #else
-	/* HalfSipHash constants */
-	.pool = { 0, 0, 0x6c796765U, 0x74656462U }
+#define FASTMIX_PERM HSIPHASH_PERMUTATION
+	.pool = { HSIPHASH_CONST_0, HSIPHASH_CONST_1, HSIPHASH_CONST_2, HSIPHASH_CONST_3 }
 #endif
 };
 
@@ -1103,27 +1103,11 @@ static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
  */
 static void fast_mix(unsigned long s[4], unsigned long v1, unsigned long v2)
 {
-#ifdef CONFIG_64BIT
-#define PERM() do { \
-	s[0] += s[1]; s[1] = rol64(s[1], 13); s[1] ^= s[0]; s[0] = rol64(s[0], 32); \
-	s[2] += s[3]; s[3] = rol64(s[3], 16); s[3] ^= s[2]; \
-	s[0] += s[3]; s[3] = rol64(s[3], 21); s[3] ^= s[0]; \
-	s[2] += s[1]; s[1] = rol64(s[1], 17); s[1] ^= s[2]; s[2] = rol64(s[2], 32); \
-} while (0)
-#else
-#define PERM() do { \
-	s[0] += s[1]; s[1] = rol32(s[1],  5); s[1] ^= s[0]; s[0] = rol32(s[0], 16); \
-	s[2] += s[3]; s[3] = rol32(s[3],  8); s[3] ^= s[2]; \
-	s[0] += s[3]; s[3] = rol32(s[3],  7); s[3] ^= s[0]; \
-	s[2] += s[1]; s[1] = rol32(s[1], 13); s[1] ^= s[2]; s[2] = rol32(s[2], 16); \
-} while (0)
-#endif
-
 	s[3] ^= v1;
-	PERM();
+	FASTMIX_PERM(s[0], s[1], s[2], s[3]);
 	s[0] ^= v1;
 	s[3] ^= v2;
-	PERM();
+	FASTMIX_PERM(s[0], s[1], s[2], s[3]);
 	s[0] ^= v2;
 }
 
diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index 056d31317e49..a4aadd2dc153 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/percpu.h>
+#include <linux/siphash.h>
 
 u32 prandom_u32(void);
 void prandom_bytes(void *buf, size_t nbytes);
@@ -27,15 +28,10 @@ DECLARE_PER_CPU(unsigned long, net_rand_noise);
  * The core SipHash round function.  Each line can be executed in
  * parallel given enough CPU resources.
  */
-#define PRND_SIPROUND(v0, v1, v2, v3) ( \
-	v0 += v1, v1 = rol64(v1, 13),  v2 += v3, v3 = rol64(v3, 16), \
-	v1 ^= v0, v0 = rol64(v0, 32),  v3 ^= v2,                     \
-	v0 += v3, v3 = rol64(v3, 21),  v2 += v1, v1 = rol64(v1, 17), \
-	v3 ^= v0,                      v1 ^= v2, v2 = rol64(v2, 32)  \
-)
+#define PRND_SIPROUND(v0, v1, v2, v3) SIPHASH_PERMUTATION(v0, v1, v2, v3)
 
-#define PRND_K0 (0x736f6d6570736575 ^ 0x6c7967656e657261)
-#define PRND_K1 (0x646f72616e646f6d ^ 0x7465646279746573)
+#define PRND_K0 (SIPHASH_CONST_0 ^ SIPHASH_CONST_2)
+#define PRND_K1 (SIPHASH_CONST_1 ^ SIPHASH_CONST_3)
 
 #elif BITS_PER_LONG == 32
 /*
@@ -43,14 +39,9 @@ DECLARE_PER_CPU(unsigned long, net_rand_noise);
  * This is weaker, but 32-bit machines are not used for high-traffic
  * applications, so there is less output for an attacker to analyze.
  */
-#define PRND_SIPROUND(v0, v1, v2, v3) ( \
-	v0 += v1, v1 = rol32(v1,  5),  v2 += v3, v3 = rol32(v3,  8), \
-	v1 ^= v0, v0 = rol32(v0, 16),  v3 ^= v2,                     \
-	v0 += v3, v3 = rol32(v3,  7),  v2 += v1, v1 = rol32(v1, 13), \
-	v3 ^= v0,                      v1 ^= v2, v2 = rol32(v2, 16)  \
-)
-#define PRND_K0 0x6c796765
-#define PRND_K1 0x74656462
+#define PRND_SIPROUND(v0, v1, v2, v3) HSIPHASH_PERMUTATION(v0, v1, v2, v3)
+#define PRND_K0 (HSIPHASH_CONST_0 ^ HSIPHASH_CONST_2)
+#define PRND_K1 (HSIPHASH_CONST_1 ^ HSIPHASH_CONST_3)
 
 #else
 #error Unsupported BITS_PER_LONG
diff --git a/include/linux/siphash.h b/include/linux/siphash.h
index cce8a9acc76c..3af1428da559 100644
--- a/include/linux/siphash.h
+++ b/include/linux/siphash.h
@@ -138,4 +138,32 @@ static inline u32 hsiphash(const void *data, size_t len,
 	return ___hsiphash_aligned(data, len, key);
 }
 
+/*
+ * These macros expose the raw SipHash and HalfSipHash permutations.
+ * Do not use them directly! If you think you have a use for them,
+ * be sure to CC the maintainer of this file explaining why.
+ */
+
+#define SIPHASH_PERMUTATION(a, b, c, d) ( \
+	(a) += (b), (b) = rol64((b), 13), (b) ^= (a), (a) = rol64((a), 32), \
+	(c) += (d), (d) = rol64((d), 16), (d) ^= (c), \
+	(a) += (d), (d) = rol64((d), 21), (d) ^= (a), \
+	(c) += (b), (b) = rol64((b), 17), (b) ^= (c), (c) = rol64((c), 32))
+
+#define SIPHASH_CONST_0 0x736f6d6570736575ULL
+#define SIPHASH_CONST_1 0x646f72616e646f6dULL
+#define SIPHASH_CONST_2 0x6c7967656e657261ULL
+#define SIPHASH_CONST_3 0x7465646279746573ULL
+
+#define HSIPHASH_PERMUTATION(a, b, c, d) ( \
+	(a) += (b), (b) = rol32((b), 5), (b) ^= (a), (a) = rol32((a), 16), \
+	(c) += (d), (d) = rol32((d), 8), (d) ^= (c), \
+	(a) += (d), (d) = rol32((d), 7), (d) ^= (a), \
+	(c) += (b), (b) = rol32((b), 13), (b) ^= (c), (c) = rol32((c), 16))
+
+#define HSIPHASH_CONST_0 0U
+#define HSIPHASH_CONST_1 0U
+#define HSIPHASH_CONST_2 0x6c796765U
+#define HSIPHASH_CONST_3 0x74656462U
+
 #endif /* _LINUX_SIPHASH_H */
diff --git a/lib/siphash.c b/lib/siphash.c
index 72b9068ab57b..71d315a6ad62 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -18,19 +18,13 @@
 #include <asm/word-at-a-time.h>
 #endif
 
-#define SIPROUND \
-	do { \
-	v0 += v1; v1 = rol64(v1, 13); v1 ^= v0; v0 = rol64(v0, 32); \
-	v2 += v3; v3 = rol64(v3, 16); v3 ^= v2; \
-	v0 += v3; v3 = rol64(v3, 21); v3 ^= v0; \
-	v2 += v1; v1 = rol64(v1, 17); v1 ^= v2; v2 = rol64(v2, 32); \
-	} while (0)
+#define SIPROUND SIPHASH_PERMUTATION(v0, v1, v2, v3)
 
 #define PREAMBLE(len) \
-	u64 v0 = 0x736f6d6570736575ULL; \
-	u64 v1 = 0x646f72616e646f6dULL; \
-	u64 v2 = 0x6c7967656e657261ULL; \
-	u64 v3 = 0x7465646279746573ULL; \
+	u64 v0 = SIPHASH_CONST_0; \
+	u64 v1 = SIPHASH_CONST_1; \
+	u64 v2 = SIPHASH_CONST_2; \
+	u64 v3 = SIPHASH_CONST_3; \
 	u64 b = ((u64)(len)) << 56; \
 	v3 ^= key->key[1]; \
 	v2 ^= key->key[0]; \
@@ -389,19 +383,13 @@ u32 hsiphash_4u32(const u32 first, const u32 second, const u32 third,
 }
 EXPORT_SYMBOL(hsiphash_4u32);
 #else
-#define HSIPROUND \
-	do { \
-	v0 += v1; v1 = rol32(v1, 5); v1 ^= v0; v0 = rol32(v0, 16); \
-	v2 += v3; v3 = rol32(v3, 8); v3 ^= v2; \
-	v0 += v3; v3 = rol32(v3, 7); v3 ^= v0; \
-	v2 += v1; v1 = rol32(v1, 13); v1 ^= v2; v2 = rol32(v2, 16); \
-	} while (0)
+#define HSIPROUND HSIPHASH_PERMUTATION(v0, v1, v2, v3)
 
 #define HPREAMBLE(len) \
-	u32 v0 = 0; \
-	u32 v1 = 0; \
-	u32 v2 = 0x6c796765U; \
-	u32 v3 = 0x74656462U; \
+	u32 v0 = HSIPHASH_CONST_0; \
+	u32 v1 = HSIPHASH_CONST_1; \
+	u32 v2 = HSIPHASH_CONST_2; \
+	u32 v3 = HSIPHASH_CONST_3; \
 	u32 b = ((u32)(len)) << 24; \
 	v3 ^= key->key[1]; \
 	v2 ^= key->key[0]; \
-- 
2.35.1

