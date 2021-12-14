Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B662E4739FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbhLNBAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:00:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:21433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244636AbhLNBAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443604; x=1670979604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GmaQ68RTl7VL76UT8mmoKUdTZDmSkxRTA4AlBaQ9ayo=;
  b=VLCriPLjkElz+aCFah36jP0XgsjwHDjQKCzNr17xez9bpG252mP4q8Xp
   ftBTJWBlvNfeKlRYOdhx4WPzD+haUOyJH2bWwKYLr0+IeRc7rp+gGATe0
   lK8stkt764GWSegfbm6PTUGi5Vy2hkycKoV9/e0lzTyeiKfEdyY0s2W4l
   c7GRCWvhnZkwsr9PBch7ibjvuCialAjPulkaz2o8esWtD/3x62VtwCo5N
   cGT+G5xywp9WmwjiYFjApsmWtwxxBnrzpIlc/JbIWw5ehmhIEtWvBhXaF
   3PywcwYqvkEroC5KuFuZsdyUJhyaSX+NQQsli/J5z2XzcHPwqyBYUyxpJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325139643"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325139643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505148627"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 16:59:42 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v4 12/13] crypto: x86/aes-kl - Support CBC mode
Date:   Mon, 13 Dec 2021 16:52:11 -0800
Message-Id: <20211214005212.20588-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214005212.20588-1-chang.seok.bae@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement CBC using AES-KL. Export the methods with a lower priority than
AES-NI to avoid from selected by default.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: x86@kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Adjust the code as ECB mode was dropped. (Eric Biggers)

Changes from RFC v2:
* Separate out the code as a new patch.
---
 arch/x86/crypto/aeskl-intel_asm.S  | 381 +++++++++++++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c | 101 +++++++-
 2 files changed, 479 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
index d56ec8dd6644..5ee7b24ee3c8 100644
--- a/arch/x86/crypto/aeskl-intel_asm.S
+++ b/arch/x86/crypto/aeskl-intel_asm.S
@@ -182,3 +182,384 @@ SYM_FUNC_START(_aeskl_dec)
 	ret
 SYM_FUNC_END(_aeskl_dec)
 
+/*
+ * int _aeskl_ecb_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
+ *		      size_t len)
+ */
+SYM_FUNC_START(_aeskl_ecb_enc)
+	FRAME_BEGIN
+#ifndef __x86_64__
+	pushl LEN
+	pushl HANDLEP
+	pushl KLEN
+	movl (FRAME_OFFSET+16)(%esp), HANDLEP	# ctx
+	movl (FRAME_OFFSET+20)(%esp), OUTP	# dst
+	movl (FRAME_OFFSET+24)(%esp), INP	# src
+	movl (FRAME_OFFSET+28)(%esp), LEN	# len
+#endif
+	test LEN, LEN
+	jz .Lecb_enc_noerr
+	mov 480(HANDLEP), KLEN
+	cmp $16, LEN
+	jb .Lecb_enc_noerr
+	cmp $128, LEN
+	jb .Lecb_enc1
+
+.align 4
+.Lecb_enc8:
+	movdqu (INP), STATE1
+	movdqu 0x10(INP), STATE2
+	movdqu 0x20(INP), STATE3
+	movdqu 0x30(INP), STATE4
+	movdqu 0x40(INP), STATE5
+	movdqu 0x50(INP), STATE6
+	movdqu 0x60(INP), STATE7
+	movdqu 0x70(INP), STATE8
+
+	cmp $16, KLEN
+	je .Lecb_enc8_128
+	aesencwide256kl (HANDLEP)
+	jz .Lecb_enc_err
+	jmp .Lecb_enc8_end
+.Lecb_enc8_128:
+	aesencwide128kl (HANDLEP)
+	jz .Lecb_enc_err
+
+.Lecb_enc8_end:
+	movdqu STATE1, (OUTP)
+	movdqu STATE2, 0x10(OUTP)
+	movdqu STATE3, 0x20(OUTP)
+	movdqu STATE4, 0x30(OUTP)
+	movdqu STATE5, 0x40(OUTP)
+	movdqu STATE6, 0x50(OUTP)
+	movdqu STATE7, 0x60(OUTP)
+	movdqu STATE8, 0x70(OUTP)
+
+	sub $128, LEN
+	add $128, INP
+	add $128, OUTP
+	cmp $128, LEN
+	jge .Lecb_enc8
+	cmp $16, LEN
+	jb .Lecb_enc_noerr
+
+.align 4
+.Lecb_enc1:
+	movdqu (INP), STATE1
+	cmp $16, KLEN
+	je .Lecb_enc1_128
+	aesenc256kl (HANDLEP), STATE
+	jz .Lecb_enc_err
+	jmp .Lecb_enc1_end
+.Lecb_enc1_128:
+	aesenc128kl (HANDLEP), STATE
+	jz .Lecb_enc_err
+
+.Lecb_enc1_end:
+	movdqu STATE1, (OUTP)
+	sub $16, LEN
+	add $16, INP
+	add $16, OUTP
+	cmp $16, LEN
+	jge .Lecb_enc1
+
+.Lecb_enc_noerr:
+	xor AREG, AREG
+	jmp .Lecb_enc_end
+.Lecb_enc_err:
+	mov $1, AREG
+.Lecb_enc_end:
+#ifndef __x86_64__
+	popl KLEN
+	popl HANDLEP
+	popl LEN
+#endif
+	FRAME_END
+	ret
+SYM_FUNC_END(_aeskl_ecb_enc)
+
+/*
+ * int _aeskl_ecb_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
+ *		      size_t len)
+ */
+SYM_FUNC_START(_aeskl_ecb_dec)
+	FRAME_BEGIN
+#ifndef __x86_64__
+	pushl LEN
+	pushl HANDLEP
+	pushl KLEN
+	movl (FRAME_OFFSET+16)(%esp), HANDLEP	# ctx
+	movl (FRAME_OFFSET+20)(%esp), OUTP	# dst
+	movl (FRAME_OFFSET+24)(%esp), INP	# src
+	movl (FRAME_OFFSET+28)(%esp), LEN	# len
+#endif
+
+	test LEN, LEN
+	jz .Lecb_dec_noerr
+	mov 480(HANDLEP), KLEN
+	cmp $16, LEN
+	jb .Lecb_dec_noerr
+	cmp $128, LEN
+	jb .Lecb_dec1
+
+.align 4
+.Lecb_dec8:
+	movdqu (INP), STATE1
+	movdqu 0x10(INP), STATE2
+	movdqu 0x20(INP), STATE3
+	movdqu 0x30(INP), STATE4
+	movdqu 0x40(INP), STATE5
+	movdqu 0x50(INP), STATE6
+	movdqu 0x60(INP), STATE7
+	movdqu 0x70(INP), STATE8
+
+	cmp $16, KLEN
+	je .Lecb_dec8_128
+	aesdecwide256kl (HANDLEP)
+	jz .Lecb_dec_err
+	jmp .Lecb_dec8_end
+.Lecb_dec8_128:
+	aesdecwide128kl (HANDLEP)
+	jz .Lecb_dec_err
+
+.Lecb_dec8_end:
+	movdqu STATE1, (OUTP)
+	movdqu STATE2, 0x10(OUTP)
+	movdqu STATE3, 0x20(OUTP)
+	movdqu STATE4, 0x30(OUTP)
+	movdqu STATE5, 0x40(OUTP)
+	movdqu STATE6, 0x50(OUTP)
+	movdqu STATE7, 0x60(OUTP)
+	movdqu STATE8, 0x70(OUTP)
+
+	sub $128, LEN
+	add $128, INP
+	add $128, OUTP
+	cmp $128, LEN
+	jge .Lecb_dec8
+	cmp $16, LEN
+	jb .Lecb_dec_noerr
+
+.align 4
+.Lecb_dec1:
+	movdqu (INP), STATE1
+	cmp $16, KLEN
+	je .Lecb_dec1_128
+	aesdec256kl (HANDLEP), STATE
+	jz .Lecb_dec_err
+	jmp .Lecb_dec1_end
+.Lecb_dec1_128:
+	aesdec128kl (HANDLEP), STATE
+	jz .Lecb_dec_err
+
+.Lecb_dec1_end:
+	movdqu STATE1, (OUTP)
+	sub $16, LEN
+	add $16, INP
+	add $16, OUTP
+	cmp $16, LEN
+	jge .Lecb_dec1
+
+.Lecb_dec_noerr:
+	xor AREG, AREG
+	jmp .Lecb_dec_end
+.Lecb_dec_err:
+	mov $1, AREG
+.Lecb_dec_end:
+#ifndef __x86_64__
+	popl KLEN
+	popl HANDLEP
+	popl LEN
+#endif
+	FRAME_END
+	ret
+SYM_FUNC_END(_aeskl_ecb_dec)
+
+/*
+ * int _aeskl_cbc_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
+ *		      size_t len, u8 *iv)
+ */
+SYM_FUNC_START(_aeskl_cbc_enc)
+	FRAME_BEGIN
+#ifndef __x86_64__
+	pushl IVP
+	pushl LEN
+	pushl HANDLEP
+	pushl KLEN
+	movl (FRAME_OFFSET+20)(%esp), HANDLEP	# ctx
+	movl (FRAME_OFFSET+24)(%esp), OUTP	# dst
+	movl (FRAME_OFFSET+28)(%esp), INP	# src
+	movl (FRAME_OFFSET+32)(%esp), LEN	# len
+	movl (FRAME_OFFSET+36)(%esp), IVP	# iv
+#endif
+
+	cmp $16, LEN
+	jb .Lcbc_enc_noerr
+	mov 480(HANDLEP), KLEN
+	movdqu (IVP), STATE
+
+.align 4
+.Lcbc_enc1:
+	movdqu (INP), IN
+	pxor IN, STATE
+
+	cmp $16, KLEN
+	je .Lcbc_enc1_128
+	aesenc256kl (HANDLEP), STATE
+	jz .Lcbc_enc_err
+	jmp .Lcbc_enc1_end
+.Lcbc_enc1_128:
+	aesenc128kl (HANDLEP), STATE
+	jz .Lcbc_enc_err
+
+.Lcbc_enc1_end:
+	movdqu STATE, (OUTP)
+	sub $16, LEN
+	add $16, INP
+	add $16, OUTP
+	cmp $16, LEN
+	jge .Lcbc_enc1
+	movdqu STATE, (IVP)
+
+.Lcbc_enc_noerr:
+	xor AREG, AREG
+	jmp .Lcbc_enc_end
+.Lcbc_enc_err:
+	mov $1, AREG
+.Lcbc_enc_end:
+#ifndef __x86_64__
+	popl KLEN
+	popl HANDLEP
+	popl LEN
+	popl IVP
+#endif
+	FRAME_END
+	ret
+SYM_FUNC_END(_aeskl_cbc_enc)
+
+/*
+ * int _aeskl_cbc_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
+ *		      size_t len, u8 *iv)
+ */
+SYM_FUNC_START(_aeskl_cbc_dec)
+	FRAME_BEGIN
+#ifndef __x86_64__
+	pushl IVP
+	pushl LEN
+	pushl HANDLEP
+	pushl KLEN
+	movl (FRAME_OFFSET+20)(%esp), HANDLEP	# ctx
+	movl (FRAME_OFFSET+24)(%esp), OUTP	# dst
+	movl (FRAME_OFFSET+28)(%esp), INP	# src
+	movl (FRAME_OFFSET+32)(%esp), LEN	# len
+	movl (FRAME_OFFSET+36)(%esp), IVP	# iv
+#endif
+
+	cmp $16, LEN
+	jb .Lcbc_dec_noerr
+	mov 480(HANDLEP), KLEN
+#ifdef __x86_64__
+	cmp $128, LEN
+	jb .Lcbc_dec1_pre
+
+.align 4
+.Lcbc_dec8:
+	movdqu 0x0(INP), STATE1
+	movdqu 0x10(INP), STATE2
+	movdqu 0x20(INP), STATE3
+	movdqu 0x30(INP), STATE4
+	movdqu 0x40(INP), STATE5
+	movdqu 0x50(INP), STATE6
+	movdqu 0x60(INP), STATE7
+	movdqu 0x70(INP), STATE8
+
+	movdqu (IVP), IN1
+	movdqa STATE1, IN2
+	movdqa STATE2, IN3
+	movdqa STATE3, IN4
+	movdqa STATE4, IN5
+	movdqa STATE5, IN6
+	movdqa STATE6, IN7
+	movdqa STATE7, IN8
+	movdqu STATE8, (IVP)
+
+	cmp $16, KLEN
+	je .Lcbc_dec8_128
+	aesdecwide256kl (HANDLEP)
+	jz .Lcbc_dec_err
+	jmp .Lcbc_dec8_end
+.Lcbc_dec8_128:
+	aesdecwide128kl (HANDLEP)
+	jz .Lcbc_dec_err
+
+.Lcbc_dec8_end:
+	pxor IN1, STATE1
+	pxor IN2, STATE2
+	pxor IN3, STATE3
+	pxor IN4, STATE4
+	pxor IN5, STATE5
+	pxor IN6, STATE6
+	pxor IN7, STATE7
+	pxor IN8, STATE8
+
+	movdqu STATE1, 0x0(OUTP)
+	movdqu STATE2, 0x10(OUTP)
+	movdqu STATE3, 0x20(OUTP)
+	movdqu STATE4, 0x30(OUTP)
+	movdqu STATE5, 0x40(OUTP)
+	movdqu STATE6, 0x50(OUTP)
+	movdqu STATE7, 0x60(OUTP)
+	movdqu STATE8, 0x70(OUTP)
+
+	sub $128, LEN
+	add $128, INP
+	add $128, OUTP
+	cmp $128, LEN
+	jge .Lcbc_dec8
+	cmp $16, LEN
+	jb .Lcbc_dec_noerr
+#endif
+
+.align 4
+.Lcbc_dec1_pre:
+	movdqu (IVP), STATE3
+.Lcbc_dec1:
+	movdqu (INP), STATE2
+	movdqa STATE2, STATE1
+
+	cmp $16, KLEN
+	je .Lcbc_dec1_128
+	aesdec256kl (HANDLEP), STATE1
+	jz .Lcbc_dec_err
+	jmp .Lcbc_dec1_end
+.Lcbc_dec1_128:
+	aesdec128kl (HANDLEP), STATE1
+	jz .Lcbc_dec_err
+
+.Lcbc_dec1_end:
+	pxor STATE3, STATE1
+	movdqu STATE1, (OUTP)
+	movdqa STATE2, STATE3
+	sub $16, LEN
+	add $16, INP
+	add $16, OUTP
+	cmp $16, LEN
+	jge .Lcbc_dec1
+	movdqu STATE3, (IVP)
+
+.Lcbc_dec_noerr:
+	xor AREG, AREG
+	jmp .Lcbc_dec_end
+.Lcbc_dec_err:
+	mov $1, AREG
+.Lcbc_dec_end:
+#ifndef __x86_64__
+	popl KLEN
+	popl HANDLEP
+	popl LEN
+	popl IVP
+#endif
+	FRAME_END
+	ret
+SYM_FUNC_END(_aeskl_cbc_dec)
+
diff --git a/arch/x86/crypto/aeskl-intel_glue.c b/arch/x86/crypto/aeskl-intel_glue.c
index 0062baaaf7b2..22b74d13150c 100644
--- a/arch/x86/crypto/aeskl-intel_glue.c
+++ b/arch/x86/crypto/aeskl-intel_glue.c
@@ -27,8 +27,13 @@ asmlinkage int aeskl_setkey(struct crypto_aes_ctx *ctx, const u8 *in_key, unsign
 asmlinkage int _aeskl_enc(const void *ctx, u8 *out, const u8 *in);
 asmlinkage int _aeskl_dec(const void *ctx, u8 *out, const u8 *in);
 
-static int __maybe_unused aeskl_setkey_common(struct crypto_tfm *tfm, void *raw_ctx,
-					      const u8 *in_key, unsigned int key_len)
+asmlinkage int _aeskl_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in, unsigned int len,
+			      u8 *iv);
+asmlinkage int _aeskl_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in, unsigned int len,
+			      u8 *iv);
+
+static int aeskl_setkey_common(struct crypto_tfm *tfm, void *raw_ctx, const u8 *in_key,
+			       unsigned int key_len)
 {
 	struct crypto_aes_ctx *ctx = aes_ctx(raw_ctx);
 	int err;
@@ -86,11 +91,95 @@ static inline int aeskl_dec(const void *ctx, u8 *out, const u8 *in)
 		return 0;
 }
 
+static int aeskl_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in, unsigned int len,
+			 u8 *iv)
+{
+	if (unlikely(ctx->key_length == AES_KEYSIZE_192))
+		return -EINVAL;
+	else if (!valid_keylocker())
+		return -ENODEV;
+	else if (_aeskl_cbc_enc(ctx, out, in, len, iv))
+		return -EINVAL;
+	else
+		return 0;
+}
+
+static int aeskl_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in, unsigned int len,
+			 u8 *iv)
+{
+	if (unlikely(ctx->key_length == AES_KEYSIZE_192))
+		return -EINVAL;
+	else if (!valid_keylocker())
+		return -ENODEV;
+	else if (_aeskl_cbc_dec(ctx, out, in, len, iv))
+		return -EINVAL;
+	else
+		return 0;
+}
+
+static int aeskl_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
+				 unsigned int len)
+{
+	struct crypto_tfm *crypto_tfm = crypto_skcipher_tfm(tfm);
+	void *raw_ctx = crypto_skcipher_ctx(tfm);
+
+	return aeskl_setkey_common(crypto_tfm, raw_ctx, key, len);
+}
+
+static int cbc_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	if (likely(keylength(crypto_skcipher_ctx(tfm)) != AES_KEYSIZE_192))
+		return cbc_crypt_common(req, aeskl_cbc_enc);
+	else
+		return cbc_crypt_common(req, aesni_cbc_enc);
+}
+
+static int cbc_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	if (likely(keylength(crypto_skcipher_ctx(tfm)) != AES_KEYSIZE_192))
+		return cbc_crypt_common(req, aeskl_cbc_dec);
+	else
+		return cbc_crypt_common(req, aesni_cbc_dec);
+}
+
+static struct skcipher_alg aeskl_skciphers[] = {
+	{
+		.base = {
+			.cra_name		= "__cbc(aes)",
+			.cra_driver_name	= "__cbc-aes-aeskl",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= AES_BLOCK_SIZE,
+			.cra_ctxsize		= CRYPTO_AES_CTX_SIZE,
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= AES_MIN_KEY_SIZE,
+		.max_keysize	= AES_MAX_KEY_SIZE,
+		.ivsize		= AES_BLOCK_SIZE,
+		.setkey		= aeskl_skcipher_setkey,
+		.encrypt	= cbc_encrypt,
+		.decrypt	= cbc_decrypt,
+	}
+};
+
+static struct simd_skcipher_alg *aeskl_simd_skciphers[ARRAY_SIZE(aeskl_skciphers)];
+
 static int __init aeskl_init(void)
 {
+	u32 eax, ebx, ecx, edx;
+	int err;
+
 	if (!valid_keylocker())
 		return -ENODEV;
 
+	cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	if (!(ebx & KEYLOCKER_CPUID_EBX_WIDE))
+		return -ENODEV;
+
 	/*
 	 * AES-KL itself does not depend on AES-NI. But AES-KL does not
 	 * support 192-bit keys. To make itself AES-compliant, it falls
@@ -99,12 +188,18 @@ static int __init aeskl_init(void)
 	if (!boot_cpu_has(X86_FEATURE_AES))
 		return -ENODEV;
 
+	err = simd_register_skciphers_compat(aeskl_skciphers, ARRAY_SIZE(aeskl_skciphers),
+					     aeskl_simd_skciphers);
+	if (err)
+		return err;
+
 	return 0;
 }
 
 static void __exit aeskl_exit(void)
 {
-	return;
+	simd_unregister_skciphers(aeskl_skciphers, ARRAY_SIZE(aeskl_skciphers),
+				  aeskl_simd_skciphers);
 }
 
 late_initcall(aeskl_init);
-- 
2.17.1

