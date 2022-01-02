Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5046B482CBA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 21:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiABUmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 15:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiABUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 15:42:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE79C061761;
        Sun,  2 Jan 2022 12:42:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACD23B80E18;
        Sun,  2 Jan 2022 20:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EEAC36AEB;
        Sun,  2 Jan 2022 20:42:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Kj8/hOfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641156146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivPQ1nJAqDCUFO3os4uPrVwQF3x8O4Z5PJ1BEASox+U=;
        b=Kj8/hOfS7FHeMWaGZ5tK3wWp8zut4gVQzQTjDXgB9VilmWCR3Y1YbStsrj/BUCedZOCnWw
        HQk/1OJJeFhxHxQYbAXEFlBKeDzO3kI7QakHVjrWyUlzFDB+71LBkJXjsVoIhBzvXnc8Zc
        TFinSl9siYJnz5LKpzb3HibsmAmmgTY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id defc2ace (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 2 Jan 2022 20:42:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v6] lib/crypto: blake2s: include as built-in
Date:   Sun,  2 Jan 2022 21:42:03 +0100
Message-Id: <20220102204203.521148-1-Jason@zx2c4.com>
In-Reply-To: <20220101155937.381821-1-Jason@zx2c4.com>
References: <20220101155937.381821-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using blake2s in the RNG, we change the way that it
is wired-in to the build system. Instead of using ifdefs to select the
right symbol, we use weak symbols. And because ARM doesn't need the
generic implementation, we make the generic one default only if an arch
library doesn't need it already, and then have arch libraries that do
need it opt-in.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Herbert - As mentioned with the vPrev, I intend to take this via the
crng/random.git tree, since it forms a dependency and I'd like to send a
pull early in 5.17 cycle.

Changes v5->v6:
- Make accelerated versions bool instead of tristate.
Changes v4->v5:
- Move sourcing the lib/crypto Kconfig file outside of 'if CRYPTO'.

 arch/arm/crypto/Kconfig           |  2 +-
 arch/arm/crypto/blake2s-core.S    |  8 ++++----
 arch/arm/crypto/blake2s-glue.c    |  6 +++---
 arch/x86/crypto/blake2s-glue.c    | 11 +++++------
 crypto/Kconfig                    |  5 +++--
 drivers/net/Kconfig               |  1 -
 include/crypto/internal/blake2s.h |  6 +++---
 lib/crypto/Kconfig                | 13 ++-----------
 lib/crypto/Makefile               |  9 ++++-----
 lib/crypto/blake2s-generic.c      |  6 +++++-
 lib/crypto/blake2s.c              |  6 ------
 11 files changed, 30 insertions(+), 43 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 2b575792363e..f1bcf804b8b5 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -63,7 +63,7 @@ config CRYPTO_SHA512_ARM
 	  using optimized ARM assembler and NEON, when available.
 
 config CRYPTO_BLAKE2S_ARM
-	tristate "BLAKE2s digest algorithm (ARM)"
+	bool "BLAKE2s digest algorithm (ARM)"
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 	help
 	  BLAKE2s digest algorithm optimized with ARM scalar instructions.  This
diff --git a/arch/arm/crypto/blake2s-core.S b/arch/arm/crypto/blake2s-core.S
index 86345751bbf3..df40e46601f1 100644
--- a/arch/arm/crypto/blake2s-core.S
+++ b/arch/arm/crypto/blake2s-core.S
@@ -167,8 +167,8 @@
 .endm
 
 //
-// void blake2s_compress_arch(struct blake2s_state *state,
-//			      const u8 *block, size_t nblocks, u32 inc);
+// void blake2s_compress(struct blake2s_state *state,
+//			 const u8 *block, size_t nblocks, u32 inc);
 //
 // Only the first three fields of struct blake2s_state are used:
 //	u32 h[8];	(inout)
@@ -176,7 +176,7 @@
 //	u32 f[2];	(in)
 //
 	.align		5
-ENTRY(blake2s_compress_arch)
+ENTRY(blake2s_compress)
 	push		{r0-r2,r4-r11,lr}	// keep this an even number
 
 .Lnext_block:
@@ -303,4 +303,4 @@ ENTRY(blake2s_compress_arch)
 	str		r3, [r12], #4
 	bne		1b
 	b		.Lcopy_block_done
-ENDPROC(blake2s_compress_arch)
+ENDPROC(blake2s_compress)
diff --git a/arch/arm/crypto/blake2s-glue.c b/arch/arm/crypto/blake2s-glue.c
index f2cc1e5fc9ec..09d3a0cabd2c 100644
--- a/arch/arm/crypto/blake2s-glue.c
+++ b/arch/arm/crypto/blake2s-glue.c
@@ -11,17 +11,17 @@
 #include <linux/module.h>
 
 /* defined in blake2s-core.S */
-EXPORT_SYMBOL(blake2s_compress_arch);
+EXPORT_SYMBOL(blake2s_compress);
 
 static int crypto_blake2s_update_arm(struct shash_desc *desc,
 				     const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2s_update(desc, in, inlen, blake2s_compress_arch);
+	return crypto_blake2s_update(desc, in, inlen, blake2s_compress);
 }
 
 static int crypto_blake2s_final_arm(struct shash_desc *desc, u8 *out)
 {
-	return crypto_blake2s_final(desc, out, blake2s_compress_arch);
+	return crypto_blake2s_final(desc, out, blake2s_compress);
 }
 
 #define BLAKE2S_ALG(name, driver_name, digest_size)			\
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index a40365ab301e..ef91a3167d27 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -28,9 +28,8 @@ asmlinkage void blake2s_compress_avx512(struct blake2s_state *state,
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_ssse3);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_avx512);
 
-void blake2s_compress_arch(struct blake2s_state *state,
-			   const u8 *block, size_t nblocks,
-			   const u32 inc)
+void blake2s_compress(struct blake2s_state *state, const u8 *block,
+		      size_t nblocks, const u32 inc)
 {
 	/* SIMD disables preemption, so relax after processing each page. */
 	BUILD_BUG_ON(SZ_4K / BLAKE2S_BLOCK_SIZE < 8);
@@ -56,17 +55,17 @@ void blake2s_compress_arch(struct blake2s_state *state,
 		block += blocks * BLAKE2S_BLOCK_SIZE;
 	} while (nblocks);
 }
-EXPORT_SYMBOL(blake2s_compress_arch);
+EXPORT_SYMBOL(blake2s_compress);
 
 static int crypto_blake2s_update_x86(struct shash_desc *desc,
 				     const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2s_update(desc, in, inlen, blake2s_compress_arch);
+	return crypto_blake2s_update(desc, in, inlen, blake2s_compress);
 }
 
 static int crypto_blake2s_final_x86(struct shash_desc *desc, u8 *out)
 {
-	return crypto_blake2s_final(desc, out, blake2s_compress_arch);
+	return crypto_blake2s_final(desc, out, blake2s_compress);
 }
 
 #define BLAKE2S_ALG(name, driver_name, digest_size)			\
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 285f82647d2b..b7a2e50dcbc8 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -702,7 +702,7 @@ config CRYPTO_BLAKE2S
 	  See https://blake2.net for further information.
 
 config CRYPTO_BLAKE2S_X86
-	tristate "BLAKE2s digest algorithm (x86 accelerated version)"
+	bool "BLAKE2s digest algorithm (x86 accelerated version)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
@@ -1919,9 +1919,10 @@ config CRYPTO_STATS
 config CRYPTO_HASH_INFO
 	bool
 
-source "lib/crypto/Kconfig"
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
 
 endif	# if CRYPTO
+
+source "lib/crypto/Kconfig"
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 6cccc3dc00bc..b2a4f998c180 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -81,7 +81,6 @@ config WIREGUARD
 	select CRYPTO
 	select CRYPTO_LIB_CURVE25519
 	select CRYPTO_LIB_CHACHA20POLY1305
-	select CRYPTO_LIB_BLAKE2S
 	select CRYPTO_CHACHA20_X86_64 if X86 && 64BIT
 	select CRYPTO_POLY1305_X86_64 if X86 && 64BIT
 	select CRYPTO_BLAKE2S_X86 if X86 && 64BIT
diff --git a/include/crypto/internal/blake2s.h b/include/crypto/internal/blake2s.h
index 8e50d487500f..d39cfa0d333e 100644
--- a/include/crypto/internal/blake2s.h
+++ b/include/crypto/internal/blake2s.h
@@ -11,11 +11,11 @@
 #include <crypto/internal/hash.h>
 #include <linux/string.h>
 
-void blake2s_compress_generic(struct blake2s_state *state,const u8 *block,
+void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 			      size_t nblocks, const u32 inc);
 
-void blake2s_compress_arch(struct blake2s_state *state,const u8 *block,
-			   size_t nblocks, const u32 inc);
+void blake2s_compress(struct blake2s_state *state, const u8 *block,
+		      size_t nblocks, const u32 inc);
 
 bool blake2s_selftest(void);
 
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 545ccbddf6a1..0f27976b5038 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -9,14 +9,14 @@ config CRYPTO_LIB_ARC4
 	tristate
 
 config CRYPTO_ARCH_HAVE_LIB_BLAKE2S
-	tristate
+	bool
 	help
 	  Declares whether the architecture provides an arch-specific
 	  accelerated implementation of the Blake2s library interface,
 	  either builtin or as a module.
 
 config CRYPTO_LIB_BLAKE2S_GENERIC
-	tristate
+	def_bool !CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 	help
 	  This symbol can be depended upon by arch implementations of the
 	  Blake2s library interface that require the generic code as a
@@ -24,15 +24,6 @@ config CRYPTO_LIB_BLAKE2S_GENERIC
 	  implementation is enabled, this implementation serves the users
 	  of CRYPTO_LIB_BLAKE2S.
 
-config CRYPTO_LIB_BLAKE2S
-	tristate "BLAKE2s hash function library"
-	depends on CRYPTO_ARCH_HAVE_LIB_BLAKE2S || !CRYPTO_ARCH_HAVE_LIB_BLAKE2S
-	select CRYPTO_LIB_BLAKE2S_GENERIC if CRYPTO_ARCH_HAVE_LIB_BLAKE2S=n
-	help
-	  Enable the Blake2s library interface. This interface may be fulfilled
-	  by either the generic implementation or an arch-specific one, if one
-	  is available and enabled.
-
 config CRYPTO_ARCH_HAVE_LIB_CHACHA
 	tristate
 	help
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 73205ed269ba..ed43a41f2dcc 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -10,11 +10,10 @@ libaes-y					:= aes.o
 obj-$(CONFIG_CRYPTO_LIB_ARC4)			+= libarc4.o
 libarc4-y					:= arc4.o
 
-obj-$(CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC)	+= libblake2s-generic.o
-libblake2s-generic-y				+= blake2s-generic.o
-
-obj-$(CONFIG_CRYPTO_LIB_BLAKE2S)		+= libblake2s.o
-libblake2s-y					+= blake2s.o
+# blake2s is used by the /dev/random driver which is always builtin
+obj-y						+= libblake2s.o
+libblake2s-y					:= blake2s.o
+libblake2s-$(CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC)	+= blake2s-generic.o
 
 obj-$(CONFIG_CRYPTO_LIB_CHACHA20POLY1305)	+= libchacha20poly1305.o
 libchacha20poly1305-y				+= chacha20poly1305.o
diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
index 04ff8df24513..75ccb3e633e6 100644
--- a/lib/crypto/blake2s-generic.c
+++ b/lib/crypto/blake2s-generic.c
@@ -37,7 +37,11 @@ static inline void blake2s_increment_counter(struct blake2s_state *state,
 	state->t[1] += (state->t[0] < inc);
 }
 
-void blake2s_compress_generic(struct blake2s_state *state,const u8 *block,
+void blake2s_compress(struct blake2s_state *state, const u8 *block,
+		      size_t nblocks, const u32 inc)
+		      __weak __alias(blake2s_compress_generic);
+
+void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 			      size_t nblocks, const u32 inc)
 {
 	u32 m[16];
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 4055aa593ec4..93f2ae051370 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -16,12 +16,6 @@
 #include <linux/init.h>
 #include <linux/bug.h>
 
-#if IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S)
-#  define blake2s_compress blake2s_compress_arch
-#else
-#  define blake2s_compress blake2s_compress_generic
-#endif
-
 void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
 {
 	__blake2s_update(state, in, inlen, blake2s_compress);
-- 
2.34.1

