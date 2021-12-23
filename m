Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91447DE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 05:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbhLWEgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 23:36:08 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44826 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346359AbhLWEf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 23:35:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V.ULz3c_1640234153;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.ULz3c_1640234153)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 12:35:54 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3 4/6] crypto: sm3 - make dependent on sm3 library
Date:   Thu, 23 Dec 2021 12:35:45 +0800
Message-Id: <20211223043547.32297-5-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
References: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM3 generic library is stand-alone implementation, it is necessary
making the sm3-generic implementation to depends on SM3 library.
The functions crypto_sm3_*() provided by sm3_generic is no longer
exported.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/Kconfig       |   1 +
 crypto/sm3_generic.c | 142 +++++--------------------------------------
 include/crypto/sm3.h |  10 ---
 3 files changed, 16 insertions(+), 137 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 60b252975dc4..8e780bf66c0a 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -999,6 +999,7 @@ config CRYPTO_SHA3
 config CRYPTO_SM3
 	tristate "SM3 digest algorithm"
 	select CRYPTO_HASH
+	select CRYPTO_LIB_SM3
 	help
 	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
 	  It is part of the Chinese Commercial Cryptography suite.
diff --git a/crypto/sm3_generic.c b/crypto/sm3_generic.c
index 193c4584bd00..a215c1c37e73 100644
--- a/crypto/sm3_generic.c
+++ b/crypto/sm3_generic.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2017 ARM Limited or its affiliates.
  * Written by Gilad Ben-Yossef <gilad@benyossef.com>
+ * Copyright (C) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
  */
 
 #include <crypto/internal/hash.h>
@@ -26,143 +27,29 @@ const u8 sm3_zero_message_hash[SM3_DIGEST_SIZE] = {
 };
 EXPORT_SYMBOL_GPL(sm3_zero_message_hash);
 
-static inline u32 p0(u32 x)
-{
-	return x ^ rol32(x, 9) ^ rol32(x, 17);
-}
-
-static inline u32 p1(u32 x)
-{
-	return x ^ rol32(x, 15) ^ rol32(x, 23);
-}
-
-static inline u32 ff(unsigned int n, u32 a, u32 b, u32 c)
-{
-	return (n < 16) ? (a ^ b ^ c) : ((a & b) | (a & c) | (b & c));
-}
-
-static inline u32 gg(unsigned int n, u32 e, u32 f, u32 g)
-{
-	return (n < 16) ? (e ^ f ^ g) : ((e & f) | ((~e) & g));
-}
-
-static inline u32 t(unsigned int n)
-{
-	return (n < 16) ? SM3_T1 : SM3_T2;
-}
-
-static void sm3_expand(u32 *t, u32 *w, u32 *wt)
-{
-	int i;
-	unsigned int tmp;
-
-	/* load the input */
-	for (i = 0; i <= 15; i++)
-		w[i] = get_unaligned_be32((__u32 *)t + i);
-
-	for (i = 16; i <= 67; i++) {
-		tmp = w[i - 16] ^ w[i - 9] ^ rol32(w[i - 3], 15);
-		w[i] = p1(tmp) ^ (rol32(w[i - 13], 7)) ^ w[i - 6];
-	}
-
-	for (i = 0; i <= 63; i++)
-		wt[i] = w[i] ^ w[i + 4];
-}
-
-static void sm3_compress(u32 *w, u32 *wt, u32 *m)
-{
-	u32 ss1;
-	u32 ss2;
-	u32 tt1;
-	u32 tt2;
-	u32 a, b, c, d, e, f, g, h;
-	int i;
-
-	a = m[0];
-	b = m[1];
-	c = m[2];
-	d = m[3];
-	e = m[4];
-	f = m[5];
-	g = m[6];
-	h = m[7];
-
-	for (i = 0; i <= 63; i++) {
-
-		ss1 = rol32((rol32(a, 12) + e + rol32(t(i), i & 31)), 7);
-
-		ss2 = ss1 ^ rol32(a, 12);
-
-		tt1 = ff(i, a, b, c) + d + ss2 + *wt;
-		wt++;
-
-		tt2 = gg(i, e, f, g) + h + ss1 + *w;
-		w++;
-
-		d = c;
-		c = rol32(b, 9);
-		b = a;
-		a = tt1;
-		h = g;
-		g = rol32(f, 19);
-		f = e;
-		e = p0(tt2);
-	}
-
-	m[0] = a ^ m[0];
-	m[1] = b ^ m[1];
-	m[2] = c ^ m[2];
-	m[3] = d ^ m[3];
-	m[4] = e ^ m[4];
-	m[5] = f ^ m[5];
-	m[6] = g ^ m[6];
-	m[7] = h ^ m[7];
-
-	a = b = c = d = e = f = g = h = ss1 = ss2 = tt1 = tt2 = 0;
-}
-
-static void sm3_transform(struct sm3_state *sst, u8 const *src)
-{
-	unsigned int w[68];
-	unsigned int wt[64];
-
-	sm3_expand((u32 *)src, w, wt);
-	sm3_compress(w, wt, sst->state);
-
-	memzero_explicit(w, sizeof(w));
-	memzero_explicit(wt, sizeof(wt));
-}
-
-static void sm3_generic_block_fn(struct sm3_state *sst, u8 const *src,
-				    int blocks)
-{
-	while (blocks--) {
-		sm3_transform(sst, src);
-		src += SM3_BLOCK_SIZE;
-	}
-}
-
-int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
+static int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len)
 {
-	return sm3_base_do_update(desc, data, len, sm3_generic_block_fn);
+	sm3_update(shash_desc_ctx(desc), data, len);
+	return 0;
 }
-EXPORT_SYMBOL(crypto_sm3_update);
 
-int crypto_sm3_final(struct shash_desc *desc, u8 *out)
+static int crypto_sm3_final(struct shash_desc *desc, u8 *out)
 {
-	sm3_base_do_finalize(desc, sm3_generic_block_fn);
-	return sm3_base_finish(desc, out);
+	sm3_final(shash_desc_ctx(desc), out);
+	return 0;
 }
-EXPORT_SYMBOL(crypto_sm3_final);
 
-int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
+static int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *hash)
 {
-	sm3_base_do_update(desc, data, len, sm3_generic_block_fn);
-	return crypto_sm3_final(desc, hash);
+	struct sm3_state *sctx = shash_desc_ctx(desc);
+
+	if (len)
+		sm3_update(sctx, data, len);
+	sm3_final(sctx, hash);
+	return 0;
 }
-EXPORT_SYMBOL(crypto_sm3_finup);
 
 static struct shash_alg sm3_alg = {
 	.digestsize	=	SM3_DIGEST_SIZE,
@@ -174,6 +61,7 @@ static struct shash_alg sm3_alg = {
 	.base		=	{
 		.cra_name	 =	"sm3",
 		.cra_driver_name =	"sm3-generic",
+		.cra_priority	=	100,
 		.cra_blocksize	 =	SM3_BLOCK_SIZE,
 		.cra_module	 =	THIS_MODULE,
 	}
diff --git a/include/crypto/sm3.h b/include/crypto/sm3.h
index b5fb6d1bf247..1f021ad0533f 100644
--- a/include/crypto/sm3.h
+++ b/include/crypto/sm3.h
@@ -35,16 +35,6 @@ struct sm3_state {
 	u8 buffer[SM3_BLOCK_SIZE];
 };
 
-struct shash_desc;
-
-extern int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
-			      unsigned int len);
-
-extern int crypto_sm3_final(struct shash_desc *desc, u8 *out);
-
-extern int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
-			     unsigned int len, u8 *hash);
-
 /*
  * Stand-alone implementation of the SM3 algorithm. It is designed to
  * have as little dependencies as possible so it can be used in the
-- 
2.32.0

