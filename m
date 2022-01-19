Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C054E493A23
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354343AbiASMPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiASMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:15:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED8C061574;
        Wed, 19 Jan 2022 04:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF3F46165D;
        Wed, 19 Jan 2022 12:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2F3C340E5;
        Wed, 19 Jan 2022 12:15:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LFmLzzaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642594499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oqPoURrh2OenrimngDds3Y6xfS7K9xZiRRRqbBfATI4=;
        b=LFmLzzaAdc/rt2IRy8viOkLqh2GecxQEPEXLnK6AdmXlSy1esKW0GB9UGBa1FcAojm/nBX
        B5ZmONTVZtoo0ubOWfeJET/rKUO2wWmLxvyScQ9RxbZMxLIsY0VWbe+EhnfsrHY6xmq47B
        X+S4WwxjsmB6cWsiWf4CZLQ+QLf5pGQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c9efe0b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 12:14:58 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id m6so6736964ybc.9;
        Wed, 19 Jan 2022 04:14:58 -0800 (PST)
X-Gm-Message-State: AOAM533sQRrVc0ifJKRCpRRF1KeGMfkMVpKtIUr4n7vuBWZFwoHZDbsJ
        470YFcSrLmh91+/tMbdVnsVVZtqdyBafWIAdAKs=
X-Google-Smtp-Source: ABdhPJzSX7aBj/gbCxLFExin+AjAF4ZjBoaf4z8ErS7FBy0lDfDOYEgjMLfMQwkQbzAXzxuso0K6P0YMHa/eszMttCc=
X-Received: by 2002:a25:e90a:: with SMTP id n10mr13207529ybd.245.1642594496777;
 Wed, 19 Jan 2022 04:14:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Wed, 19 Jan 2022
 04:14:56 -0800 (PST)
In-Reply-To: <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com>
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com> <CAHmME9pQcUxs87EwQwBZNDA4ZzqugTggH+uiNPh=mv5zjp3g3A@mail.gmail.com>
 <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 13:14:56 +0100
X-Gmail-Original-Message-ID: <CAHmME9oGTPS-gVyHQ4o=AxvMJrGH44_tyQ2KPQcfAKgcqC2SnA@mail.gmail.com>
Message-ID: <CAHmME9oGTPS-gVyHQ4o=AxvMJrGH44_tyQ2KPQcfAKgcqC2SnA@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     ardb@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below kludge of a patch fixes the issue. Still unclear whether we
should go with something like this or get clang fixed or what.

diff --git a/arch/arm/crypto/blake2s-shash.c b/arch/arm/crypto/blake2s-shash.c
index 17c1c3bfe2f5..be8cde5f1719 100644
--- a/arch/arm/crypto/blake2s-shash.c
+++ b/arch/arm/crypto/blake2s-shash.c
@@ -13,12 +13,12 @@
 static int crypto_blake2s_update_arm(struct shash_desc *desc,
 				     const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2s_update(desc, in, inlen, blake2s_compress);
+	return crypto_blake2s_update(desc, in, inlen);
 }

 static int crypto_blake2s_final_arm(struct shash_desc *desc, u8 *out)
 {
-	return crypto_blake2s_final(desc, out, blake2s_compress);
+	return crypto_blake2s_final(desc, out);
 }

 #define BLAKE2S_ALG(name, driver_name, digest_size)			\
diff --git a/arch/x86/crypto/blake2s-shash.c b/arch/x86/crypto/blake2s-shash.c
index f9e2fecdb761..c81ffedb4865 100644
--- a/arch/x86/crypto/blake2s-shash.c
+++ b/arch/x86/crypto/blake2s-shash.c
@@ -18,12 +18,12 @@
 static int crypto_blake2s_update_x86(struct shash_desc *desc,
 				     const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2s_update(desc, in, inlen, blake2s_compress);
+	return crypto_blake2s_update(desc, in, inlen);
 }

 static int crypto_blake2s_final_x86(struct shash_desc *desc, u8 *out)
 {
-	return crypto_blake2s_final(desc, out, blake2s_compress);
+	return crypto_blake2s_final(desc, out);
 }

 #define BLAKE2S_ALG(name, driver_name, digest_size)			\
diff --git a/crypto/blake2s_generic.c b/crypto/blake2s_generic.c
index 72fe480f9bd6..050874588a84 100644
--- a/crypto/blake2s_generic.c
+++ b/crypto/blake2s_generic.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All
Rights Reserved.
  */

+#define FORCE_BLAKE2S_GENERIC
 #include <crypto/internal/blake2s.h>
 #include <crypto/internal/hash.h>

@@ -15,12 +16,12 @@
 static int crypto_blake2s_update_generic(struct shash_desc *desc,
 					 const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2s_update(desc, in, inlen, blake2s_compress_generic);
+	return crypto_blake2s_update(desc, in, inlen);
 }

 static int crypto_blake2s_final_generic(struct shash_desc *desc, u8 *out)
 {
-	return crypto_blake2s_final(desc, out, blake2s_compress_generic);
+	return crypto_blake2s_final(desc, out);
 }

 #define BLAKE2S_ALG(name, driver_name, digest_size)			\
diff --git a/include/crypto/internal/blake2s.h
b/include/crypto/internal/blake2s.h
index d39cfa0d333e..fec7eead93fc 100644
--- a/include/crypto/internal/blake2s.h
+++ b/include/crypto/internal/blake2s.h
@@ -24,14 +24,14 @@ static inline void blake2s_set_lastblock(struct
blake2s_state *state)
 	state->f[0] = -1;
 }

-typedef void (*blake2s_compress_t)(struct blake2s_state *state,
-				   const u8 *block, size_t nblocks, u32 inc);
-
 /* Helper functions for BLAKE2s shared by the library and shash APIs */

+#ifdef FORCE_BLAKE2S_GENERIC
+#define blake2s_compress blake2s_compress_generic
+#endif
+
 static inline void __blake2s_update(struct blake2s_state *state,
-				    const u8 *in, size_t inlen,
-				    blake2s_compress_t compress)
+				    const u8 *in, size_t inlen)
 {
 	const size_t fill = BLAKE2S_BLOCK_SIZE - state->buflen;

@@ -39,7 +39,7 @@ static inline void __blake2s_update(struct
blake2s_state *state,
 		return;
 	if (inlen > fill) {
 		memcpy(state->buf + state->buflen, in, fill);
-		(*compress)(state, state->buf, 1, BLAKE2S_BLOCK_SIZE);
+		blake2s_compress(state, state->buf, 1, BLAKE2S_BLOCK_SIZE);
 		state->buflen = 0;
 		in += fill;
 		inlen -= fill;
@@ -47,7 +47,7 @@ static inline void __blake2s_update(struct
blake2s_state *state,
 	if (inlen > BLAKE2S_BLOCK_SIZE) {
 		const size_t nblocks = DIV_ROUND_UP(inlen, BLAKE2S_BLOCK_SIZE);
 		/* Hash one less (full) block than strictly possible */
-		(*compress)(state, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
+		blake2s_compress(state, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
 		in += BLAKE2S_BLOCK_SIZE * (nblocks - 1);
 		inlen -= BLAKE2S_BLOCK_SIZE * (nblocks - 1);
 	}
@@ -55,13 +55,12 @@ static inline void __blake2s_update(struct
blake2s_state *state,
 	state->buflen += inlen;
 }

-static inline void __blake2s_final(struct blake2s_state *state, u8 *out,
-				   blake2s_compress_t compress)
+static inline void __blake2s_final(struct blake2s_state *state, u8 *out)
 {
 	blake2s_set_lastblock(state);
 	memset(state->buf + state->buflen, 0,
 	       BLAKE2S_BLOCK_SIZE - state->buflen); /* Padding */
-	(*compress)(state, state->buf, 1, state->buflen);
+	blake2s_compress(state, state->buf, 1, state->buflen);
 	cpu_to_le32_array(state->h, ARRAY_SIZE(state->h));
 	memcpy(out, state->h, state->outlen);
 }
@@ -98,21 +97,19 @@ static inline int crypto_blake2s_init(struct
shash_desc *desc)
 }

 static inline int crypto_blake2s_update(struct shash_desc *desc,
-					const u8 *in, unsigned int inlen,
-					blake2s_compress_t compress)
+					const u8 *in, unsigned int inlen)
 {
 	struct blake2s_state *state = shash_desc_ctx(desc);

-	__blake2s_update(state, in, inlen, compress);
+	__blake2s_update(state, in, inlen);
 	return 0;
 }

-static inline int crypto_blake2s_final(struct shash_desc *desc, u8 *out,
-				       blake2s_compress_t compress)
+static inline int crypto_blake2s_final(struct shash_desc *desc, u8 *out)
 {
 	struct blake2s_state *state = shash_desc_ctx(desc);

-	__blake2s_final(state, out, compress);
+	__blake2s_final(state, out);
 	return 0;
 }

diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 9364f79937b8..a13f01ff53a7 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -18,14 +18,14 @@

 void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
 {
-	__blake2s_update(state, in, inlen, blake2s_compress);
+	__blake2s_update(state, in, inlen);
 }
 EXPORT_SYMBOL(blake2s_update);

 void blake2s_final(struct blake2s_state *state, u8 *out)
 {
 	WARN_ON(IS_ENABLED(DEBUG) && !out);
-	__blake2s_final(state, out, blake2s_compress);
+	__blake2s_final(state, out);
 	memzero_explicit(state, sizeof(*state));
 }
 EXPORT_SYMBOL(blake2s_final);
