Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8366E493B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354919AbiASNza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiASNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:55:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453CC061574;
        Wed, 19 Jan 2022 05:55:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 566026128D;
        Wed, 19 Jan 2022 13:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD27C004E1;
        Wed, 19 Jan 2022 13:55:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aX2pw9mN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642600523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVLlEq/NVqn71IeXBS7gWbZgsEB+7ur+0OXQEYCjiyc=;
        b=aX2pw9mNODlEQE36AFSyNIcCNWw59qX8/iB/ZM0jNJV9byC6xerslmiXZYt1k6d030UWEX
        UsYa6QKxzlUVXrpARKHn2e0uPxRE0BLlXp68JlVxHDZp0RgwNHkP38KhevQEZAPhGCMWAW
        6CWH1OUTL+wC9NvQSMOqFEefxhSdo1c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 77f1b5b1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 13:55:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Miles Chen <miles.chen@mediatek.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH] lib/crypto: blake2s: avoid indirect calls to compression function for Clang CFI
Date:   Wed, 19 Jan 2022 14:54:50 +0100
Message-Id: <20220119135450.564115-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
References: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blake2s_compress_generic is weakly aliased to blake2s_generic. The
current harness for function selection uses a function pointer, which is
ordinarily inlined and resolved at compile time. But when Clang's CFI is
enabled, CFI still triggers when making an indirect call via a weak
symbol. This seems like a bug in Clang's CFI, as though it's bucketing
weak symbols and strong symbols differently. It also only seems to
trigger when "full LTO" mode is used, rather than "thin LTO".

[    0.000000][    T0] Kernel panic - not syncing: CFI failure (target: blake2s_compress_generic+0x0/0x1444)
[    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-mainline-06981-g076c855b846e #1
[    0.000000][    T0] Hardware name: MT6873 (DT)
[    0.000000][    T0] Call trace:
[    0.000000][    T0]  dump_backtrace+0xfc/0x1dc
[    0.000000][    T0]  dump_stack_lvl+0xa8/0x11c
[    0.000000][    T0]  panic+0x194/0x464
[    0.000000][    T0]  __cfi_check_fail+0x54/0x58
[    0.000000][    T0]  __cfi_slowpath_diag+0x354/0x4b0
[    0.000000][    T0]  blake2s_update+0x14c/0x178
[    0.000000][    T0]  _extract_entropy+0xf4/0x29c
[    0.000000][    T0]  crng_initialize_primary+0x24/0x94
[    0.000000][    T0]  rand_initialize+0x2c/0x6c
[    0.000000][    T0]  start_kernel+0x2f8/0x65c
[    0.000000][    T0]  __primary_switched+0xc4/0x7be4
[    0.000000][    T0] Rebooting in 5 seconds..

Nonetheless, the function pointer method isn't so terrific anyway, so
this patch replaces it with a simple boolean, which also gets inlined
away. This successfully works around the Clang bug.

In general, I'm not too keen on all of the indirection involved here; it
clearly does more harm than good. Hopefully the whole thing can get
cleaned up down the road when lib/crypto is overhauled more
comprehensively. But for now, we go with a simple bandaid.

Fixes: 6048fdcc5f26 ("lib/crypto: blake2s: include as built-in")
Reported-by: Miles Chen <miles.chen@mediatek.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm/crypto/blake2s-shash.c   |  4 ++--
 arch/x86/crypto/blake2s-shash.c   |  4 ++--
 crypto/blake2s_generic.c          |  4 ++--
 include/crypto/internal/blake2s.h | 36 ++++++++++++++++++-------------
 lib/crypto/blake2s.c              |  4 ++--
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/arm/crypto/blake2s-shash.c b/arch/arm/crypto/blake2s-shash.c
index 17c1c3bfe2f5..763c73beea2d 100644
--- a/arch/arm/crypto/blake2s-shash.c
+++ b/arch/arm/crypto/blake2s-shash.c
@@ -13,12 +13,12 @@
 static int crypto_blake2s_update_arm(struct shash_desc *desc,
 				     const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2s_update(desc, in, inlen, blake2s_compress);
+	return crypto_blake2s_update(desc, in, inlen, false);
 }
 
 static int crypto_blake2s_final_arm(struct shash_desc *desc, u8 *out)
 {
-	return crypto_blake2s_final(desc, out, blake2s_compress);
+	return crypto_blake2s_final(desc, out, false);
 }
 
 #define BLAKE2S_ALG(name, driver_name, digest_size)			\
diff --git a/arch/x86/crypto/blake2s-shash.c b/arch/x86/crypto/blake2s-shash.c
index f9e2fecdb761..59ae28abe35c 100644
--- a/arch/x86/crypto/blake2s-shash.c
+++ b/arch/x86/crypto/blake2s-shash.c
@@ -18,12 +18,12 @@
 static int crypto_blake2s_update_x86(struct shash_desc *desc,
 				     const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2s_update(desc, in, inlen, blake2s_compress);
+	return crypto_blake2s_update(desc, in, inlen, false);
 }
 
 static int crypto_blake2s_final_x86(struct shash_desc *desc, u8 *out)
 {
-	return crypto_blake2s_final(desc, out, blake2s_compress);
+	return crypto_blake2s_final(desc, out, false);
 }
 
 #define BLAKE2S_ALG(name, driver_name, digest_size)			\
diff --git a/crypto/blake2s_generic.c b/crypto/blake2s_generic.c
index 72fe480f9bd6..5f96a21f8788 100644
--- a/crypto/blake2s_generic.c
+++ b/crypto/blake2s_generic.c
@@ -15,12 +15,12 @@
 static int crypto_blake2s_update_generic(struct shash_desc *desc,
 					 const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2s_update(desc, in, inlen, blake2s_compress_generic);
+	return crypto_blake2s_update(desc, in, inlen, true);
 }
 
 static int crypto_blake2s_final_generic(struct shash_desc *desc, u8 *out)
 {
-	return crypto_blake2s_final(desc, out, blake2s_compress_generic);
+	return crypto_blake2s_final(desc, out, true);
 }
 
 #define BLAKE2S_ALG(name, driver_name, digest_size)			\
diff --git a/include/crypto/internal/blake2s.h b/include/crypto/internal/blake2s.h
index d39cfa0d333e..e2da9b413d44 100644
--- a/include/crypto/internal/blake2s.h
+++ b/include/crypto/internal/blake2s.h
@@ -24,14 +24,11 @@ static inline void blake2s_set_lastblock(struct blake2s_state *state)
 	state->f[0] = -1;
 }
 
-typedef void (*blake2s_compress_t)(struct blake2s_state *state,
-				   const u8 *block, size_t nblocks, u32 inc);
-
 /* Helper functions for BLAKE2s shared by the library and shash APIs */
 
-static inline void __blake2s_update(struct blake2s_state *state,
-				    const u8 *in, size_t inlen,
-				    blake2s_compress_t compress)
+static __always_inline void __blake2s_update(struct blake2s_state *state,
+					     const u8 *in, size_t inlen,
+					     bool force_generic)
 {
 	const size_t fill = BLAKE2S_BLOCK_SIZE - state->buflen;
 
@@ -39,7 +36,10 @@ static inline void __blake2s_update(struct blake2s_state *state,
 		return;
 	if (inlen > fill) {
 		memcpy(state->buf + state->buflen, in, fill);
-		(*compress)(state, state->buf, 1, BLAKE2S_BLOCK_SIZE);
+		if (force_generic)
+			blake2s_compress_generic(state, state->buf, 1, BLAKE2S_BLOCK_SIZE);
+		else
+			blake2s_compress(state, state->buf, 1, BLAKE2S_BLOCK_SIZE);
 		state->buflen = 0;
 		in += fill;
 		inlen -= fill;
@@ -47,7 +47,10 @@ static inline void __blake2s_update(struct blake2s_state *state,
 	if (inlen > BLAKE2S_BLOCK_SIZE) {
 		const size_t nblocks = DIV_ROUND_UP(inlen, BLAKE2S_BLOCK_SIZE);
 		/* Hash one less (full) block than strictly possible */
-		(*compress)(state, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
+		if (force_generic)
+			blake2s_compress_generic(state, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
+		else
+			blake2s_compress(state, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
 		in += BLAKE2S_BLOCK_SIZE * (nblocks - 1);
 		inlen -= BLAKE2S_BLOCK_SIZE * (nblocks - 1);
 	}
@@ -55,13 +58,16 @@ static inline void __blake2s_update(struct blake2s_state *state,
 	state->buflen += inlen;
 }
 
-static inline void __blake2s_final(struct blake2s_state *state, u8 *out,
-				   blake2s_compress_t compress)
+static __always_inline void __blake2s_final(struct blake2s_state *state, u8 *out,
+					    bool force_generic)
 {
 	blake2s_set_lastblock(state);
 	memset(state->buf + state->buflen, 0,
 	       BLAKE2S_BLOCK_SIZE - state->buflen); /* Padding */
-	(*compress)(state, state->buf, 1, state->buflen);
+	if (force_generic)
+		blake2s_compress_generic(state, state->buf, 1, state->buflen);
+	else
+		blake2s_compress(state, state->buf, 1, state->buflen);
 	cpu_to_le32_array(state->h, ARRAY_SIZE(state->h));
 	memcpy(out, state->h, state->outlen);
 }
@@ -99,20 +105,20 @@ static inline int crypto_blake2s_init(struct shash_desc *desc)
 
 static inline int crypto_blake2s_update(struct shash_desc *desc,
 					const u8 *in, unsigned int inlen,
-					blake2s_compress_t compress)
+					bool force_generic)
 {
 	struct blake2s_state *state = shash_desc_ctx(desc);
 
-	__blake2s_update(state, in, inlen, compress);
+	__blake2s_update(state, in, inlen, force_generic);
 	return 0;
 }
 
 static inline int crypto_blake2s_final(struct shash_desc *desc, u8 *out,
-				       blake2s_compress_t compress)
+				       bool force_generic)
 {
 	struct blake2s_state *state = shash_desc_ctx(desc);
 
-	__blake2s_final(state, out, compress);
+	__blake2s_final(state, out, force_generic);
 	return 0;
 }
 
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 9364f79937b8..c71c09621c09 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -18,14 +18,14 @@
 
 void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
 {
-	__blake2s_update(state, in, inlen, blake2s_compress);
+	__blake2s_update(state, in, inlen, false);
 }
 EXPORT_SYMBOL(blake2s_update);
 
 void blake2s_final(struct blake2s_state *state, u8 *out)
 {
 	WARN_ON(IS_ENABLED(DEBUG) && !out);
-	__blake2s_final(state, out, blake2s_compress);
+	__blake2s_final(state, out, false);
 	memzero_explicit(state, sizeof(*state));
 }
 EXPORT_SYMBOL(blake2s_final);
-- 
2.34.1

