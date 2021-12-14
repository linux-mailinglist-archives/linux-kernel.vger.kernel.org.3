Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000784739FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244687AbhLNBAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:00:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:21433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244627AbhLNBAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443601; x=1670979601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RwjvKKHQ02rvrTTx+OGrcLBSlByDLmeRBT+6TGEQEAo=;
  b=WzkazXKGrjKZah93Gt4FpnNHGuoQaAy8JhF5T2yiRLCu/TZ9WZLLoBW2
   dG34DkeOCUXLF5osodPIBNSbLWdSwqm2SyDCzIOF3ooWaj7YxTttdLGyc
   F/M2OYgUB0SaWwp0jskZJ6Gx4OBoRNZ31L0fku8O8BoBw0En4V6RjLADR
   ZguJ3TVSSox0GJxwqMj97Nb91+0sNsJlraSEgL73JiPAF00ptltGZEO3H
   sc60GEzPYB8VCAwYEdI0Rs0UPVcW+6qi86y1XBusjNyyHT2sLOAETAk5C
   wOD+/VY299FyodTbn+CjstKqFol6yZLiXRYg3FSrGfdmD5eTk4tJnuuds
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325139638"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325139638"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505148613"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 16:59:41 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 10/13] crypto: x86/aes - Prepare for a new AES implementation
Date:   Mon, 13 Dec 2021 16:52:09 -0800
Message-Id: <20211214005212.20588-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214005212.20588-1-chang.seok.bae@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Key Locker's AES instruction set ('AES-KL') has a similar programming
interface to AES-NI. The internal ABI in the assembly code will have the
same prototype as AES-NI. Then, the glue code will be the same as AES-NI's.

Refactor the common C code to avoid code duplication. The AES-NI code uses
it with a function pointer argument to call back the AES-NI assembly code.
So will the AES-KL code.

Introduce wrappers for data transformation functions to return an error
code. AES-KL may populate an error during data transformation.

Export those refactored functions and new wrappers that the AES-KL code
will reference.

Also move some constant values to a common assembly code.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Drop ECB and CTR mode changes. (Eric Biggers)
* Export symbols. (Eric Biggers)

Changes from RFC v2:
* Massage the changelog. (Dan Williams)

Changes from RFC v1:
* Added as a new patch. (Ard Biesheuvel)
  Link: https://lore.kernel.org/lkml/CAMj1kXGa4f21eH0mdxd1pQsZMUjUr1Btq+Dgw-gC=O-yYft7xw@mail.gmail.com/
---
 arch/x86/crypto/Makefile           |   2 +-
 arch/x86/crypto/aes-intel_asm.S    |  26 +++
 arch/x86/crypto/aes-intel_glue.c   | 153 +++++++++++++++
 arch/x86/crypto/aes-intel_glue.h   |  48 +++++
 arch/x86/crypto/aesni-intel_asm.S  |  74 +++----
 arch/x86/crypto/aesni-intel_glue.c | 301 +++++++++--------------------
 arch/x86/crypto/aesni-intel_glue.h |  22 +++
 7 files changed, 372 insertions(+), 254 deletions(-)
 create mode 100644 arch/x86/crypto/aes-intel_asm.S
 create mode 100644 arch/x86/crypto/aes-intel_glue.c
 create mode 100644 arch/x86/crypto/aes-intel_glue.h
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index f307c93fc90a..ef6c0b9f69c6 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -47,7 +47,7 @@ chacha-x86_64-y := chacha-avx2-x86_64.o chacha-ssse3-x86_64.o chacha_glue.o
 chacha-x86_64-$(CONFIG_AS_AVX512) += chacha-avx512vl-x86_64.o
 
 obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
-aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
+aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o aes-intel_glue.o
 aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o aes_ctrby8_avx-x86_64.o
 
 obj-$(CONFIG_CRYPTO_SHA1_SSSE3) += sha1-ssse3.o
diff --git a/arch/x86/crypto/aes-intel_asm.S b/arch/x86/crypto/aes-intel_asm.S
new file mode 100644
index 000000000000..98abf875af79
--- /dev/null
+++ b/arch/x86/crypto/aes-intel_asm.S
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Constant values shared between AES implementations:
+ */
+
+.pushsection .rodata
+.align 16
+.Lcts_permute_table:
+	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
+	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
+	.byte		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
+	.byte		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
+	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
+	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
+#ifdef __x86_64__
+.Lbswap_mask:
+	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
+#endif
+.popsection
+
+.section	.rodata.cst16.gf128mul_x_ble_mask, "aM", @progbits, 16
+.align 16
+.Lgf128mul_x_ble_mask:
+	.octa 0x00000000000000010000000000000087
+.previous
diff --git a/arch/x86/crypto/aes-intel_glue.c b/arch/x86/crypto/aes-intel_glue.c
new file mode 100644
index 000000000000..e7f90897653d
--- /dev/null
+++ b/arch/x86/crypto/aes-intel_glue.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/err.h>
+#include <crypto/algapi.h>
+#include <crypto/aes.h>
+#include <crypto/xts.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/simd.h>
+#include "aes-intel_glue.h"
+
+int cbc_crypt_common(struct skcipher_request *req,
+		     int (*fn)(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+			       unsigned int len, u8 *iv))
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_aes_ctx *ctx = aes_ctx(crypto_skcipher_ctx(tfm));
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes)) {
+		kernel_fpu_begin();
+		err = fn(ctx, walk.dst.virt.addr, walk.src.virt.addr, nbytes & AES_BLOCK_MASK,
+			 walk.iv);
+		kernel_fpu_end();
+		if (err)
+			return err;
+
+		nbytes &= AES_BLOCK_SIZE - 1;
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(cbc_crypt_common);
+
+int xts_setkey_common(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen,
+		      int (*fn)(struct crypto_tfm *tfm, void *raw_ctx,
+				const u8 *in_key, unsigned int key_len))
+{
+	struct aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int err;
+
+	err = xts_verify_key(tfm, key, keylen);
+	if (err)
+		return err;
+
+	keylen /= 2;
+
+	/* first half of xts-key is for crypt */
+	err = fn(crypto_skcipher_tfm(tfm), ctx->raw_crypt_ctx, key, keylen);
+	if (err)
+		return err;
+
+	/* second half of xts-key is for tweak */
+	return fn(crypto_skcipher_tfm(tfm), ctx->raw_tweak_ctx, key + keylen, keylen);
+}
+EXPORT_SYMBOL_GPL(xts_setkey_common);
+
+int xts_crypt_common(struct skcipher_request *req,
+		     int (*crypt_fn)(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				     unsigned int len, u8 *iv),
+		     int (*crypt1_fn)(const void *ctx, u8 *out, const u8 *in))
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int tail = req->cryptlen % AES_BLOCK_SIZE;
+	struct skcipher_request subreq;
+	struct skcipher_walk walk;
+	int err;
+
+	if (req->cryptlen < AES_BLOCK_SIZE)
+		return -EINVAL;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	if (!walk.nbytes)
+		return err;
+
+	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
+		int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(&subreq,
+					      skcipher_request_flags(req),
+					      NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst,
+					   blocks * AES_BLOCK_SIZE, req->iv);
+		req = &subreq;
+
+		err = skcipher_walk_virt(&walk, req, false);
+		if (!walk.nbytes)
+			return err;
+	} else {
+		tail = 0;
+	}
+
+	kernel_fpu_begin();
+
+	/* calculate first value of T */
+	err = crypt1_fn(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
+	if (err)
+		return err;
+
+	while (walk.nbytes > 0) {
+		int nbytes = walk.nbytes;
+
+		if (nbytes < walk.total)
+			nbytes &= ~(AES_BLOCK_SIZE - 1);
+
+		err = crypt_fn(aes_ctx(ctx->raw_crypt_ctx), walk.dst.virt.addr, walk.src.virt.addr,
+			       nbytes, walk.iv);
+		kernel_fpu_end();
+		if (err)
+			return err;
+
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+
+		if (walk.nbytes > 0)
+			kernel_fpu_begin();
+	}
+
+	if (unlikely(tail > 0 && !err)) {
+		struct scatterlist sg_src[2], sg_dst[2];
+		struct scatterlist *src, *dst;
+
+		dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+		if (req->dst != req->src)
+			dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
+
+		skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
+					   req->iv);
+
+		err = skcipher_walk_virt(&walk, &subreq, false);
+		if (err)
+			return err;
+
+		kernel_fpu_begin();
+		err = crypt_fn(aes_ctx(ctx->raw_crypt_ctx), walk.dst.virt.addr, walk.src.virt.addr,
+			       walk.nbytes, walk.iv);
+		kernel_fpu_end();
+		if (err)
+			return err;
+
+		err = skcipher_walk_done(&walk, 0);
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(xts_crypt_common);
diff --git a/arch/x86/crypto/aes-intel_glue.h b/arch/x86/crypto/aes-intel_glue.h
new file mode 100644
index 000000000000..c8bd783fa787
--- /dev/null
+++ b/arch/x86/crypto/aes-intel_glue.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Shared glue code between AES implementations, refactored from the AES-NI's.
+ */
+
+#ifndef _AES_INTEL_GLUE_H
+#define _AES_INTEL_GLUE_H
+
+#include <crypto/aes.h>
+
+#define AES_ALIGN			16
+#define AES_ALIGN_ATTR			__attribute__((__aligned__(AES_ALIGN)))
+#define AES_BLOCK_MASK			(~(AES_BLOCK_SIZE - 1))
+#define AES_ALIGN_EXTRA			((AES_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
+#define CRYPTO_AES_CTX_SIZE		(sizeof(struct crypto_aes_ctx) + AES_ALIGN_EXTRA)
+#define XTS_AES_CTX_SIZE		(sizeof(struct aes_xts_ctx) + AES_ALIGN_EXTRA)
+
+struct aes_xts_ctx {
+	u8 raw_tweak_ctx[sizeof(struct crypto_aes_ctx)] AES_ALIGN_ATTR;
+	u8 raw_crypt_ctx[sizeof(struct crypto_aes_ctx)] AES_ALIGN_ATTR;
+};
+
+static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
+{
+	unsigned long addr = (unsigned long)raw_ctx;
+	unsigned long align = AES_ALIGN;
+
+	if (align <= crypto_tfm_ctx_alignment())
+		align = 1;
+
+	return (struct crypto_aes_ctx *)ALIGN(addr, align);
+}
+
+int cbc_crypt_common(struct skcipher_request *req,
+		     int (*fn)(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+			       unsigned int len, u8 *iv));
+
+int xts_setkey_common(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen,
+		      int (*fn)(struct crypto_tfm *tfm, void *raw_ctx,
+				const u8 *in_key, unsigned int key_len));
+
+int xts_crypt_common(struct skcipher_request *req,
+		     int (*crypt_fn)(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				     unsigned int len, u8 *iv),
+		     int (*crypt1_fn)(const void *ctx, u8 *out, const u8 *in));
+
+#endif /* _AES_INTEL_GLUE_H */
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 4e3972570916..695093a3c4aa 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -28,6 +28,7 @@
 #include <linux/linkage.h>
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
+#include "aes-intel_asm.S"
 
 /*
  * The following macros are used to move an (un)aligned 16 byte value to/from
@@ -1822,10 +1823,10 @@ SYM_FUNC_START_LOCAL(_key_expansion_256b)
 SYM_FUNC_END(_key_expansion_256b)
 
 /*
- * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
- *                   unsigned int key_len)
+ * int _aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+ *                    unsigned int key_len)
  */
-SYM_FUNC_START(aesni_set_key)
+SYM_FUNC_START(_aesni_set_key)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1934,12 +1935,12 @@ SYM_FUNC_START(aesni_set_key)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_set_key)
+SYM_FUNC_END(_aesni_set_key)
 
 /*
- * void aesni_enc(const void *ctx, u8 *dst, const u8 *src)
+ * void _aesni_enc(const void *ctx, u8 *dst, const u8 *src)
  */
-SYM_FUNC_START(aesni_enc)
+SYM_FUNC_START(_aesni_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1958,7 +1959,7 @@ SYM_FUNC_START(aesni_enc)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_enc)
+SYM_FUNC_END(_aesni_enc)
 
 /*
  * _aesni_enc1:		internal ABI
@@ -2126,9 +2127,9 @@ SYM_FUNC_START_LOCAL(_aesni_enc4)
 SYM_FUNC_END(_aesni_enc4)
 
 /*
- * void aesni_dec (const void *ctx, u8 *dst, const u8 *src)
+ * void _aesni_dec (const void *ctx, u8 *dst, const u8 *src)
  */
-SYM_FUNC_START(aesni_dec)
+SYM_FUNC_START(_aesni_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -2148,7 +2149,7 @@ SYM_FUNC_START(aesni_dec)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_dec)
+SYM_FUNC_END(_aesni_dec)
 
 /*
  * _aesni_dec1:		internal ABI
@@ -2437,10 +2438,10 @@ SYM_FUNC_START(aesni_ecb_dec)
 SYM_FUNC_END(aesni_ecb_dec)
 
 /*
- * void aesni_cbc_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
- *		      size_t len, u8 *iv)
+ * void _aesni_cbc_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
+ *		       size_t len, u8 *iv)
  */
-SYM_FUNC_START(aesni_cbc_enc)
+SYM_FUNC_START(_aesni_cbc_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2478,13 +2479,13 @@ SYM_FUNC_START(aesni_cbc_enc)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_cbc_enc)
+SYM_FUNC_END(_aesni_cbc_enc)
 
 /*
- * void aesni_cbc_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
- *		      size_t len, u8 *iv)
+ * void _aesni_cbc_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
+ *		       size_t len, u8 *iv)
  */
-SYM_FUNC_START(aesni_cbc_dec)
+SYM_FUNC_START(_aesni_cbc_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2571,7 +2572,7 @@ SYM_FUNC_START(aesni_cbc_dec)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_cbc_dec)
+SYM_FUNC_END(_aesni_cbc_dec)
 
 /*
  * void aesni_cts_cbc_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
@@ -2691,21 +2692,6 @@ SYM_FUNC_START(aesni_cts_cbc_dec)
 	ret
 SYM_FUNC_END(aesni_cts_cbc_dec)
 
-.pushsection .rodata
-.align 16
-.Lcts_permute_table:
-	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
-	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
-	.byte		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
-	.byte		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
-	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
-	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
-#ifdef __x86_64__
-.Lbswap_mask:
-	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
-#endif
-.popsection
-
 #ifdef __x86_64__
 /*
  * _aesni_inc_init:	internal ABI
@@ -2821,12 +2807,6 @@ SYM_FUNC_END(aesni_ctr_enc)
 
 #endif
 
-.section	.rodata.cst16.gf128mul_x_ble_mask, "aM", @progbits, 16
-.align 16
-.Lgf128mul_x_ble_mask:
-	.octa 0x00000000000000010000000000000087
-.previous
-
 /*
  * _aesni_gf128mul_x_ble:		internal ABI
  *	Multiply in GF(2^128) for XTS IVs
@@ -2846,10 +2826,10 @@ SYM_FUNC_END(aesni_ctr_enc)
 	pxor KEY, IV;
 
 /*
- * void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
- *			  const u8 *src, unsigned int len, le128 *iv)
+ * void _aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			   const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_encrypt)
+SYM_FUNC_START(_aesni_xts_encrypt)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2998,13 +2978,13 @@ SYM_FUNC_START(aesni_xts_encrypt)
 
 	movups STATE, (OUTP)
 	jmp .Lxts_enc_ret
-SYM_FUNC_END(aesni_xts_encrypt)
+SYM_FUNC_END(_aesni_xts_encrypt)
 
 /*
- * void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
- *			  const u8 *src, unsigned int len, le128 *iv)
+ * void _aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			   const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_decrypt)
+SYM_FUNC_START(_aesni_xts_decrypt)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -3160,4 +3140,4 @@ SYM_FUNC_START(aesni_xts_decrypt)
 
 	movups STATE, (OUTP)
 	jmp .Lxts_dec_ret
-SYM_FUNC_END(aesni_xts_decrypt)
+SYM_FUNC_END(_aesni_xts_decrypt)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index e09f4672dd38..24d97de6b9e2 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -36,33 +36,24 @@
 #include <linux/spinlock.h>
 #include <linux/static_call.h>
 
+#include "aes-intel_glue.h"
+#include "aesni-intel_glue.h"
 
-#define AESNI_ALIGN	16
-#define AESNI_ALIGN_ATTR __attribute__ ((__aligned__(AESNI_ALIGN)))
-#define AES_BLOCK_MASK	(~(AES_BLOCK_SIZE - 1))
 #define RFC4106_HASH_SUBKEY_SIZE 16
-#define AESNI_ALIGN_EXTRA ((AESNI_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
-#define CRYPTO_AES_CTX_SIZE (sizeof(struct crypto_aes_ctx) + AESNI_ALIGN_EXTRA)
-#define XTS_AES_CTX_SIZE (sizeof(struct aesni_xts_ctx) + AESNI_ALIGN_EXTRA)
 
 /* This data is stored at the end of the crypto_tfm struct.
  * It's a type of per "session" data storage location.
  * This needs to be 16 byte aligned.
  */
 struct aesni_rfc4106_gcm_ctx {
-	u8 hash_subkey[16] AESNI_ALIGN_ATTR;
-	struct crypto_aes_ctx aes_key_expanded AESNI_ALIGN_ATTR;
+	u8 hash_subkey[16] AES_ALIGN_ATTR;
+	struct crypto_aes_ctx aes_key_expanded AES_ALIGN_ATTR;
 	u8 nonce[4];
 };
 
 struct generic_gcmaes_ctx {
-	u8 hash_subkey[16] AESNI_ALIGN_ATTR;
-	struct crypto_aes_ctx aes_key_expanded AESNI_ALIGN_ATTR;
-};
-
-struct aesni_xts_ctx {
-	u8 raw_tweak_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
-	u8 raw_crypt_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
+	u8 hash_subkey[16] AES_ALIGN_ATTR;
+	struct crypto_aes_ctx aes_key_expanded AES_ALIGN_ATTR;
 };
 
 #define GCM_BLOCK_LEN 16
@@ -80,31 +71,84 @@ struct gcm_context_data {
 	u8 hash_keys[GCM_BLOCK_LEN * 16];
 };
 
-asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-			     unsigned int key_len);
-asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
-asmlinkage void aesni_dec(const void *ctx, u8 *out, const u8 *in);
+asmlinkage int _aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+			      unsigned int key_len);
+asmlinkage void _aesni_enc(const void *ctx, u8 *out, const u8 *in);
+asmlinkage void _aesni_dec(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len);
 asmlinkage void aesni_ecb_dec(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len);
-asmlinkage void aesni_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
-			      const u8 *in, unsigned int len, u8 *iv);
-asmlinkage void aesni_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
-			      const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void _aesni_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
+			       const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void _aesni_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
+			       const u8 *in, unsigned int len, u8 *iv);
 asmlinkage void aesni_cts_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
 				  const u8 *in, unsigned int len, u8 *iv);
 asmlinkage void aesni_cts_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
 				  const u8 *in, unsigned int len, u8 *iv);
 
+int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+		  unsigned int key_len)
+{
+	return _aesni_set_key(ctx, in_key, key_len);
+}
+EXPORT_SYMBOL_GPL(aesni_set_key);
+
+int aesni_enc(const void *ctx, u8 *out, const u8 *in)
+{
+	_aesni_enc(ctx, out, in);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_enc);
+
+int aesni_dec(const void *ctx, u8 *out, const u8 *in)
+{
+	_aesni_dec(ctx, out, in);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_dec);
+
+int aesni_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		  unsigned int len, u8 *iv)
+{
+	_aesni_cbc_enc(ctx, out, in, len, iv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_cbc_enc);
+
+int aesni_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		  unsigned int len, u8 *iv)
+{
+	_aesni_cbc_dec(ctx, out, in, len, iv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_cbc_dec);
+
 #define AVX_GEN2_OPTSIZE 640
 #define AVX_GEN4_OPTSIZE 4096
 
-asmlinkage void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
-				  const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void _aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
+				   const u8 *in, unsigned int len, u8 *iv);
 
-asmlinkage void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
-				  const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void _aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
+				   const u8 *in, unsigned int len, u8 *iv);
+
+int aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv)
+{
+	_aesni_xts_encrypt(ctx, out, in, len, iv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_xts_encrypt);
+
+int aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv)
+{
+	_aesni_xts_decrypt(ctx, out, in, len, iv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_xts_decrypt);
 
 #ifdef CONFIG_X86_64
 
@@ -187,7 +231,7 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx2);
 static inline struct
 aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
+	unsigned long align = AES_ALIGN;
 
 	if (align <= crypto_tfm_ctx_alignment())
 		align = 1;
@@ -197,7 +241,7 @@ aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
 static inline struct
 generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
+	unsigned long align = AES_ALIGN;
 
 	if (align <= crypto_tfm_ctx_alignment())
 		align = 1;
@@ -205,16 +249,6 @@ generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
 }
 #endif
 
-static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
-{
-	unsigned long addr = (unsigned long)raw_ctx;
-	unsigned long align = AESNI_ALIGN;
-
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return (struct crypto_aes_ctx *)ALIGN(addr, align);
-}
-
 static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
 			      const u8 *in_key, unsigned int key_len)
 {
@@ -229,7 +263,7 @@ static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
 		err = aes_expandkey(ctx, in_key, key_len);
 	else {
 		kernel_fpu_begin();
-		err = aesni_set_key(ctx, in_key, key_len);
+		err = _aesni_set_key(ctx, in_key, key_len);
 		kernel_fpu_end();
 	}
 
@@ -250,7 +284,7 @@ static void aesni_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 		aes_encrypt(ctx, dst, src);
 	} else {
 		kernel_fpu_begin();
-		aesni_enc(ctx, dst, src);
+		_aesni_enc(ctx, dst, src);
 		kernel_fpu_end();
 	}
 }
@@ -263,7 +297,7 @@ static void aesni_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 		aes_decrypt(ctx, dst, src);
 	} else {
 		kernel_fpu_begin();
-		aesni_dec(ctx, dst, src);
+		_aesni_dec(ctx, dst, src);
 		kernel_fpu_end();
 	}
 }
@@ -321,46 +355,12 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct crypto_aes_ctx *ctx = aes_ctx(crypto_skcipher_ctx(tfm));
-	struct skcipher_walk walk;
-	unsigned int nbytes;
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while ((nbytes = walk.nbytes)) {
-		kernel_fpu_begin();
-		aesni_cbc_enc(ctx, walk.dst.virt.addr, walk.src.virt.addr,
-			      nbytes & AES_BLOCK_MASK, walk.iv);
-		kernel_fpu_end();
-		nbytes &= AES_BLOCK_SIZE - 1;
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-
-	return err;
+	return cbc_crypt_common(req, aesni_cbc_enc);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct crypto_aes_ctx *ctx = aes_ctx(crypto_skcipher_ctx(tfm));
-	struct skcipher_walk walk;
-	unsigned int nbytes;
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while ((nbytes = walk.nbytes)) {
-		kernel_fpu_begin();
-		aesni_cbc_dec(ctx, walk.dst.virt.addr, walk.src.virt.addr,
-			      nbytes & AES_BLOCK_MASK, walk.iv);
-		kernel_fpu_end();
-		nbytes &= AES_BLOCK_SIZE - 1;
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-
-	return err;
+	return cbc_crypt_common(req, aesni_cbc_dec);
 }
 
 static int cts_cbc_encrypt(struct skcipher_request *req)
@@ -477,7 +477,7 @@ static int cts_cbc_decrypt(struct skcipher_request *req)
 
 #ifdef CONFIG_X86_64
 static void aesni_ctr_enc_avx_tfm(struct crypto_aes_ctx *ctx, u8 *out,
-			      const u8 *in, unsigned int len, u8 *iv)
+				 const u8 *in, unsigned int len, u8 *iv)
 {
 	/*
 	 * based on key length, override with the by8 version
@@ -514,7 +514,7 @@ static int ctr_crypt(struct skcipher_request *req)
 		nbytes &= ~AES_BLOCK_MASK;
 
 		if (walk.nbytes == walk.total && nbytes > 0) {
-			aesni_enc(ctx, keystream, walk.iv);
+			_aesni_enc(ctx, keystream, walk.iv);
 			crypto_xor_cpy(walk.dst.virt.addr + walk.nbytes - nbytes,
 				       walk.src.virt.addr + walk.nbytes - nbytes,
 				       keystream, nbytes);
@@ -606,8 +606,8 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
 			      u8 *iv, void *aes_ctx, u8 *auth_tag,
 			      unsigned long auth_tag_len)
 {
-	u8 databuf[sizeof(struct gcm_context_data) + (AESNI_ALIGN - 8)] __aligned(8);
-	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AESNI_ALIGN);
+	u8 databuf[sizeof(struct gcm_context_data) + (AES_ALIGN - 8)] __aligned(8);
+	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AES_ALIGN);
 	unsigned long left = req->cryptlen;
 	struct scatter_walk assoc_sg_walk;
 	struct skcipher_walk walk;
@@ -762,8 +762,8 @@ static int helper_rfc4106_encrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
+	u8 ivbuf[16 + (AES_ALIGN - 8)] __aligned(8);
+	u8 *iv = PTR_ALIGN(&ivbuf[0], AES_ALIGN);
 	unsigned int i;
 	__be32 counter = cpu_to_be32(1);
 
@@ -790,8 +790,8 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
+	u8 ivbuf[16 + (AES_ALIGN - 8)] __aligned(8);
+	u8 *iv = PTR_ALIGN(&ivbuf[0], AES_ALIGN);
 	unsigned int i;
 
 	if (unlikely(req->assoclen != 16 && req->assoclen != 20))
@@ -816,128 +816,17 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			    unsigned int keylen)
 {
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int err;
-
-	err = xts_verify_key(tfm, key, keylen);
-	if (err)
-		return err;
-
-	keylen /= 2;
-
-	/* first half of xts-key is for crypt */
-	err = aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_crypt_ctx,
-				 key, keylen);
-	if (err)
-		return err;
-
-	/* second half of xts-key is for tweak */
-	return aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_tweak_ctx,
-				  key + keylen, keylen);
-}
-
-static int xts_crypt(struct skcipher_request *req, bool encrypt)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int tail = req->cryptlen % AES_BLOCK_SIZE;
-	struct skcipher_request subreq;
-	struct skcipher_walk walk;
-	int err;
-
-	if (req->cryptlen < AES_BLOCK_SIZE)
-		return -EINVAL;
-
-	err = skcipher_walk_virt(&walk, req, false);
-	if (!walk.nbytes)
-		return err;
-
-	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
-		int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
-
-		skcipher_walk_abort(&walk);
-
-		skcipher_request_set_tfm(&subreq, tfm);
-		skcipher_request_set_callback(&subreq,
-					      skcipher_request_flags(req),
-					      NULL, NULL);
-		skcipher_request_set_crypt(&subreq, req->src, req->dst,
-					   blocks * AES_BLOCK_SIZE, req->iv);
-		req = &subreq;
-
-		err = skcipher_walk_virt(&walk, req, false);
-		if (!walk.nbytes)
-			return err;
-	} else {
-		tail = 0;
-	}
-
-	kernel_fpu_begin();
-
-	/* calculate first value of T */
-	aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
-
-	while (walk.nbytes > 0) {
-		int nbytes = walk.nbytes;
-
-		if (nbytes < walk.total)
-			nbytes &= ~(AES_BLOCK_SIZE - 1);
-
-		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  nbytes, walk.iv);
-		else
-			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  nbytes, walk.iv);
-		kernel_fpu_end();
-
-		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
-
-		if (walk.nbytes > 0)
-			kernel_fpu_begin();
-	}
-
-	if (unlikely(tail > 0 && !err)) {
-		struct scatterlist sg_src[2], sg_dst[2];
-		struct scatterlist *src, *dst;
-
-		dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
-		if (req->dst != req->src)
-			dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
-
-		skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
-					   req->iv);
-
-		err = skcipher_walk_virt(&walk, &subreq, false);
-		if (err)
-			return err;
-
-		kernel_fpu_begin();
-		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  walk.nbytes, walk.iv);
-		else
-			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  walk.nbytes, walk.iv);
-		kernel_fpu_end();
-
-		err = skcipher_walk_done(&walk, 0);
-	}
-	return err;
+	return xts_setkey_common(tfm, key, keylen, aes_set_key_common);
 }
 
 static int xts_encrypt(struct skcipher_request *req)
 {
-	return xts_crypt(req, true);
+	return xts_crypt_common(req, aesni_xts_encrypt, aesni_enc);
 }
 
 static int xts_decrypt(struct skcipher_request *req)
 {
-	return xts_crypt(req, false);
+	return xts_crypt_common(req, aesni_xts_decrypt, aesni_enc);
 }
 
 static struct crypto_alg aesni_cipher_alg = {
@@ -1066,8 +955,8 @@ static int generic_gcmaes_encrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
+	u8 ivbuf[16 + (AES_ALIGN - 8)] __aligned(8);
+	u8 *iv = PTR_ALIGN(&ivbuf[0], AES_ALIGN);
 	__be32 counter = cpu_to_be32(1);
 
 	memcpy(iv, req->iv, 12);
@@ -1083,8 +972,8 @@ static int generic_gcmaes_decrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
+	u8 ivbuf[16 + (AES_ALIGN - 8)] __aligned(8);
+	u8 *iv = PTR_ALIGN(&ivbuf[0], AES_ALIGN);
 
 	memcpy(iv, req->iv, 12);
 	*((__be32 *)(iv+12)) = counter;
@@ -1107,7 +996,7 @@ static struct aead_alg aesni_aeads[] = { {
 		.cra_flags		= CRYPTO_ALG_INTERNAL,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct aesni_rfc4106_gcm_ctx),
-		.cra_alignmask		= AESNI_ALIGN - 1,
+		.cra_alignmask		= AES_ALIGN - 1,
 		.cra_module		= THIS_MODULE,
 	},
 }, {
@@ -1124,7 +1013,7 @@ static struct aead_alg aesni_aeads[] = { {
 		.cra_flags		= CRYPTO_ALG_INTERNAL,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct generic_gcmaes_ctx),
-		.cra_alignmask		= AESNI_ALIGN - 1,
+		.cra_alignmask		= AES_ALIGN - 1,
 		.cra_module		= THIS_MODULE,
 	},
 } };
diff --git a/arch/x86/crypto/aesni-intel_glue.h b/arch/x86/crypto/aesni-intel_glue.h
new file mode 100644
index 000000000000..ca202063f760
--- /dev/null
+++ b/arch/x86/crypto/aesni-intel_glue.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Support for Intel AES-NI instructions. This file contains function
+ * prototypes to be referenced for other AES implementations
+ */
+
+int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key, unsigned int key_len);
+
+int aesni_enc(const void *ctx, u8 *out, const u8 *in);
+int aesni_dec(const void *ctx, u8 *out, const u8 *in);
+
+int aesni_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		  unsigned int len, u8 *iv);
+int aesni_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		  unsigned int len, u8 *iv);
+
+int aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv);
+int aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv);
+
-- 
2.17.1

