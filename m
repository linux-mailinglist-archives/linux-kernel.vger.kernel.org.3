Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7740848CDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiALVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:22:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:1421 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231868AbiALVVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642022471; x=1673558471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SgY03+iH24E8Z7oIl3ISKIyDvatgdF91hmWdlwkvKhE=;
  b=apn1LSNMKpeZ/EH3p/zrpjRUQ5siTDotsNJ02cpYQ3gABGWvOQGHQMUe
   i4xUX2lxjzSx48yRkUw/06zh0G/Qm2iMQfJxL2T4W34ZNtI4G2XTAJa6v
   iRXiEW2pvLazu+Z3whXV9YwYXmW7giaNtPORIBEzo+QHEip8FbCVDgObO
   G/9PVsFiKEfk14PLZoBm4lP5QqQiA1VPZdPjzeaCl5YW6nEkH/xyEWOmT
   5FlioHkXa3ZSXYHewqgG792iUU572h19Bo4MSGQx4dnhHtcSNNd7jzF1i
   16utKstMN5QhimLlkZIdjxfjKRir7NRoB7FhTmfLmATQFkuLM6O9pk+Si
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243810803"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243810803"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:20:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529378303"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 13:20:42 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, ebiggers@kernel.org, ardb@kernel.org,
        x86@kernel.org, luto@kernel.org, tglx@linutronix.de, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v5 12/12] crypto: x86/aes-kl - Support XTS mode
Date:   Wed, 12 Jan 2022 13:12:58 -0800
Message-Id: <20220112211258.21115-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112211258.21115-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement XTS mode using AES-KL. Export the methods with a lower priority
than AES-NI to avoid from selected by default.

The assembly code clobbers more than eight 128-bit registers to make use of
performant wide instructions that process eight 128-bit blocks at once.
But that many 128-bit registers are not available in 32-bit mode, so
support 64-bit mode only.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: x86@kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Separate out the code as a new patch.
---
 arch/x86/crypto/aeskl-intel_asm.S  | 449 +++++++++++++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c | 107 ++++++-
 2 files changed, 553 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
index d56ec8dd6644..cb4680461f25 100644
--- a/arch/x86/crypto/aeskl-intel_asm.S
+++ b/arch/x86/crypto/aeskl-intel_asm.S
@@ -182,3 +182,452 @@ SYM_FUNC_START(_aeskl_dec)
 	ret
 SYM_FUNC_END(_aeskl_dec)
 
+#ifdef __x86_64__
+
+/*
+ * XTS implementation
+ */
+
+/*
+ * _aeskl_gf128mul_x_ble: 	internal ABI
+ *	Multiply in GF(2^128) for XTS IVs
+ * input:
+ *	IV:	current IV
+ *	GF128MUL_MASK == mask with 0x87 and 0x01
+ * output:
+ *	IV:	next IV
+ * changed:
+ *	CTR:	== temporary value
+ */
+#define _aeskl_gf128mul_x_ble() \
+	pshufd $0x13, IV, KEY; \
+	paddq IV, IV; \
+	psrad $31, KEY; \
+	pand GF128MUL_MASK, KEY; \
+	pxor KEY, IV;
+
+/*
+ * int _aeskl_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			  const u8 *src, unsigned int len, le128 *iv)
+ */
+SYM_FUNC_START(_aeskl_xts_encrypt)
+	FRAME_BEGIN
+	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
+	movups (IVP), IV
+
+	mov 480(HANDLEP), KLEN
+
+.Lxts_enc8:
+	sub $128, LEN
+	jl .Lxts_enc1_pre
+
+	movdqa IV, STATE1
+	movdqu (INP), INC
+	pxor INC, STATE1
+	movdqu IV, (OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE2
+	movdqu 0x10(INP), INC
+	pxor INC, STATE2
+	movdqu IV, 0x10(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE3
+	movdqu 0x20(INP), INC
+	pxor INC, STATE3
+	movdqu IV, 0x20(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE4
+	movdqu 0x30(INP), INC
+	pxor INC, STATE4
+	movdqu IV, 0x30(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE5
+	movdqu 0x40(INP), INC
+	pxor INC, STATE5
+	movdqu IV, 0x40(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE6
+	movdqu 0x50(INP), INC
+	pxor INC, STATE6
+	movdqu IV, 0x50(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE7
+	movdqu 0x60(INP), INC
+	pxor INC, STATE7
+	movdqu IV, 0x60(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE8
+	movdqu 0x70(INP), INC
+	pxor INC, STATE8
+	movdqu IV, 0x70(OUTP)
+
+	cmp $16, KLEN
+	je .Lxts_enc8_128
+	aesencwide256kl (%rdi)
+	jz .Lxts_enc_ret_err
+	jmp .Lxts_enc8_end
+.Lxts_enc8_128:
+	aesencwide128kl (%rdi)
+	jz .Lxts_enc_ret_err
+
+.Lxts_enc8_end:
+	movdqu 0x00(OUTP), INC
+	pxor INC, STATE1
+	movdqu STATE1, 0x00(OUTP)
+
+	movdqu 0x10(OUTP), INC
+	pxor INC, STATE2
+	movdqu STATE2, 0x10(OUTP)
+
+	movdqu 0x20(OUTP), INC
+	pxor INC, STATE3
+	movdqu STATE3, 0x20(OUTP)
+
+	movdqu 0x30(OUTP), INC
+	pxor INC, STATE4
+	movdqu STATE4, 0x30(OUTP)
+
+	movdqu 0x40(OUTP), INC
+	pxor INC, STATE5
+	movdqu STATE5, 0x40(OUTP)
+
+	movdqu 0x50(OUTP), INC
+	pxor INC, STATE6
+	movdqu STATE6, 0x50(OUTP)
+
+	movdqu 0x60(OUTP), INC
+	pxor INC, STATE7
+	movdqu STATE7, 0x60(OUTP)
+
+	movdqu 0x70(OUTP), INC
+	pxor INC, STATE8
+	movdqu STATE8, 0x70(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+
+	add $128, INP
+	add $128, OUTP
+	test LEN, LEN
+	jnz .Lxts_enc8
+
+.Lxts_enc_ret_iv:
+	movups IV, (IVP)
+.Lxts_enc_ret_noerr:
+	xor AREG, AREG
+	jmp .Lxts_enc_ret
+.Lxts_enc_ret_err:
+	mov $1, AREG
+.Lxts_enc_ret:
+	FRAME_END
+	ret
+
+.Lxts_enc1_pre:
+	add $128, LEN
+	jz .Lxts_enc_ret_iv
+	sub $16, LEN
+	jl .Lxts_enc_cts4
+
+.Lxts_enc1:
+	movdqu (INP), STATE1
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_enc1_128
+	aesenc256kl (HANDLEP), STATE1
+	jz .Lxts_enc_ret_err
+	jmp .Lxts_enc1_end
+.Lxts_enc1_128:
+	aesenc128kl (HANDLEP), STATE1
+	jz .Lxts_enc_ret_err
+
+.Lxts_enc1_end:
+	pxor IV, STATE1
+	_aeskl_gf128mul_x_ble()
+
+	test LEN, LEN
+	jz .Lxts_enc1_out
+
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_enc_cts1
+
+	movdqu STATE1, (OUTP)
+	add $16, OUTP
+	jmp .Lxts_enc1
+
+.Lxts_enc1_out:
+	movdqu STATE1, (OUTP)
+	jmp .Lxts_enc_ret_iv
+
+.Lxts_enc_cts4:
+	movdqu STATE8, STATE1
+	sub $16, OUTP
+
+.Lxts_enc_cts1:
+	lea .Lcts_permute_table(%rip), T1
+	add LEN, INP		/* rewind input pointer */
+	add $16, LEN		/* # bytes in final block */
+	movups (INP), IN1
+
+	mov T1, IVP
+	add $32, IVP
+	add LEN, T1
+	sub LEN, IVP
+	add OUTP, LEN
+
+	movups (T1), STATE2
+	movaps STATE1, STATE3
+	pshufb STATE2, STATE1
+	movups STATE1, (LEN)
+
+	movups (IVP), STATE1
+	pshufb STATE1, IN1
+	pblendvb STATE3, IN1
+	movaps IN1, STATE1
+
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_enc1_cts_128
+	aesenc256kl (HANDLEP), STATE1
+	jz .Lxts_enc_ret_err
+	jmp .Lxts_enc1_cts_end
+.Lxts_enc1_cts_128:
+	aesenc128kl (HANDLEP), STATE1
+	jz .Lxts_enc_ret_err
+
+.Lxts_enc1_cts_end:
+	pxor IV, STATE1
+	movups STATE1, (OUTP)
+	jmp .Lxts_enc_ret_noerr
+SYM_FUNC_END(_aeskl_xts_encrypt)
+
+/*
+ * int _aeskl_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			  const u8 *src, unsigned int len, le128 *iv)
+ */
+SYM_FUNC_START(_aeskl_xts_decrypt)
+	FRAME_BEGIN
+	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
+	movups (IVP), IV
+
+	mov 480(HANDLEP), KLEN
+
+	test $15, LEN
+	jz .Lxts_dec8
+	sub $16, LEN
+
+.Lxts_dec8:
+	sub $128, LEN
+	jl .Lxts_dec1_pre
+
+	movdqa IV, STATE1
+	movdqu (INP), INC
+	pxor INC, STATE1
+	movdqu IV, (OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE2
+	movdqu 0x10(INP), INC
+	pxor INC, STATE2
+	movdqu IV, 0x10(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE3
+	movdqu 0x20(INP), INC
+	pxor INC, STATE3
+	movdqu IV, 0x20(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE4
+	movdqu 0x30(INP), INC
+	pxor INC, STATE4
+	movdqu IV, 0x30(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE5
+	movdqu 0x40(INP), INC
+	pxor INC, STATE5
+	movdqu IV, 0x40(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE6
+	movdqu 0x50(INP), INC
+	pxor INC, STATE6
+	movdqu IV, 0x50(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE7
+	movdqu 0x60(INP), INC
+	pxor INC, STATE7
+	movdqu IV, 0x60(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE8
+	movdqu 0x70(INP), INC
+	pxor INC, STATE8
+	movdqu IV, 0x70(OUTP)
+
+	cmp $16, KLEN
+	je .Lxts_dec8_128
+	aesdecwide256kl (%rdi)
+	jz .Lxts_dec_ret_err
+	jmp .Lxts_dec8_end
+.Lxts_dec8_128:
+	aesdecwide128kl (%rdi)
+	jz .Lxts_dec_ret_err
+
+.Lxts_dec8_end:
+	movdqu 0x00(OUTP), INC
+	pxor INC, STATE1
+	movdqu STATE1, 0x00(OUTP)
+
+	movdqu 0x10(OUTP), INC
+	pxor INC, STATE2
+	movdqu STATE2, 0x10(OUTP)
+
+	movdqu 0x20(OUTP), INC
+	pxor INC, STATE3
+	movdqu STATE3, 0x20(OUTP)
+
+	movdqu 0x30(OUTP), INC
+	pxor INC, STATE4
+	movdqu STATE4, 0x30(OUTP)
+
+	movdqu 0x40(OUTP), INC
+	pxor INC, STATE5
+	movdqu STATE5, 0x40(OUTP)
+
+	movdqu 0x50(OUTP), INC
+	pxor INC, STATE6
+	movdqu STATE6, 0x50(OUTP)
+
+	movdqu 0x60(OUTP), INC
+	pxor INC, STATE7
+	movdqu STATE7, 0x60(OUTP)
+
+	movdqu 0x70(OUTP), INC
+	pxor INC, STATE8
+	movdqu STATE8, 0x70(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+
+	add $128, INP
+	add $128, OUTP
+	test LEN, LEN
+	jnz .Lxts_dec8
+
+.Lxts_dec_ret_iv:
+	movups IV, (IVP)
+.Lxts_dec_ret_noerr:
+	xor AREG, AREG
+	jmp .Lxts_dec_ret
+.Lxts_dec_ret_err:
+	mov $1, AREG
+.Lxts_dec_ret:
+	FRAME_END
+	ret
+
+.Lxts_dec1_pre:
+	add $128, LEN
+	jz .Lxts_dec_ret_iv
+
+.Lxts_dec1:
+	movdqu (INP), STATE1
+
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_dec_cts1
+
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_dec1_128
+	aesdec256kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+	jmp .Lxts_dec1_end
+.Lxts_dec1_128:
+	aesdec128kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+
+.Lxts_dec1_end:
+	pxor IV, STATE1
+	_aeskl_gf128mul_x_ble()
+
+	test LEN, LEN
+	jz .Lxts_dec1_out
+
+	movdqu STATE1, (OUTP)
+	add $16, OUTP
+	jmp .Lxts_dec1
+
+.Lxts_dec1_out:
+	movdqu STATE1, (OUTP)
+	jmp .Lxts_dec_ret_iv
+
+.Lxts_dec_cts1:
+	movdqa IV, STATE5
+	_aeskl_gf128mul_x_ble()
+
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_dec1_cts_pre_128
+	aesdec256kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+	jmp .Lxts_dec1_cts_pre_end
+.Lxts_dec1_cts_pre_128:
+	aesdec128kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+
+.Lxts_dec1_cts_pre_end:
+	pxor IV, STATE1
+
+	lea .Lcts_permute_table(%rip), T1
+	add LEN, INP		/* rewind input pointer */
+	add $16, LEN		/* # bytes in final block */
+	movups (INP), IN1
+
+	mov T1, IVP
+	add $32, IVP
+	add LEN, T1
+	sub LEN, IVP
+	add OUTP, LEN
+
+	movups (T1), STATE2
+	movaps STATE1, STATE3
+	pshufb STATE2, STATE1
+	movups STATE1, (LEN)
+
+	movups (IVP), STATE1
+	pshufb STATE1, IN1
+	pblendvb STATE3, IN1
+	movaps IN1, STATE1
+
+	pxor STATE5, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_dec1_cts_128
+	aesdec256kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+	jmp .Lxts_dec1_cts_end
+.Lxts_dec1_cts_128:
+	aesdec128kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+
+.Lxts_dec1_cts_end:
+	pxor STATE5, STATE1
+
+	movups STATE1, (OUTP)
+	jmp .Lxts_dec_ret_noerr
+
+SYM_FUNC_END(_aeskl_xts_decrypt)
+
+#endif
diff --git a/arch/x86/crypto/aeskl-intel_glue.c b/arch/x86/crypto/aeskl-intel_glue.c
index 0062baaaf7b2..6616a2fc6f04 100644
--- a/arch/x86/crypto/aeskl-intel_glue.c
+++ b/arch/x86/crypto/aeskl-intel_glue.c
@@ -27,8 +27,15 @@ asmlinkage int aeskl_setkey(struct crypto_aes_ctx *ctx, const u8 *in_key, unsign
 asmlinkage int _aeskl_enc(const void *ctx, u8 *out, const u8 *in);
 asmlinkage int _aeskl_dec(const void *ctx, u8 *out, const u8 *in);
 
-static int __maybe_unused aeskl_setkey_common(struct crypto_tfm *tfm, void *raw_ctx,
-					      const u8 *in_key, unsigned int key_len)
+#ifdef CONFIG_X86_64
+asmlinkage int _aeskl_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				  unsigned int len, u8 *iv);
+asmlinkage int _aeskl_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				  unsigned int len, u8 *iv);
+#endif
+
+static int aeskl_setkey_common(struct crypto_tfm *tfm, void *raw_ctx, const u8 *in_key,
+			       unsigned int key_len)
 {
 	struct crypto_aes_ctx *ctx = aes_ctx(raw_ctx);
 	int err;
@@ -86,11 +93,99 @@ static inline int aeskl_dec(const void *ctx, u8 *out, const u8 *in)
 		return 0;
 }
 
+#ifdef CONFIG_X86_64
+
+static inline int aeskl_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				    unsigned int len, u8 *iv)
+{
+	if (unlikely(ctx->key_length == AES_KEYSIZE_192))
+		return -EINVAL;
+	else if (!valid_keylocker())
+		return -ENODEV;
+	else if (_aeskl_xts_encrypt(ctx, out, in, len, iv))
+		return -EINVAL;
+	else
+		return 0;
+}
+
+static inline int aeskl_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				    unsigned int len, u8 *iv)
+{
+	if (unlikely(ctx->key_length == AES_KEYSIZE_192))
+		return -EINVAL;
+	else if (!valid_keylocker())
+		return -ENODEV;
+	else if (_aeskl_xts_decrypt(ctx, out, in, len, iv))
+		return -EINVAL;
+	else
+		return 0;
+}
+
+static int aeskl_xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			    unsigned int keylen)
+{
+	return xts_setkey_common(tfm, key, keylen, aeskl_setkey_common);
+}
+
+static int xts_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	if (likely(keylength(crypto_skcipher_ctx(tfm)) != AES_KEYSIZE_192))
+		return xts_crypt_common(req, aeskl_xts_encrypt, aeskl_enc);
+	else
+		return xts_crypt_common(req, aesni_xts_encrypt, aesni_enc);
+}
+
+static int xts_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	if (likely(keylength(crypto_skcipher_ctx(tfm)) != AES_KEYSIZE_192))
+		return xts_crypt_common(req, aeskl_xts_decrypt, aeskl_enc);
+	else
+		return xts_crypt_common(req, aesni_xts_decrypt, aesni_enc);
+}
+
+#endif /* CONFIG_X86_64 */
+
+static struct skcipher_alg aeskl_skciphers[] = {
+	{
+#ifdef CONFIG_X86_64
+		.base = {
+			.cra_name		= "__xts(aes)",
+			.cra_driver_name	= "__xts-aes-aeskl",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= AES_BLOCK_SIZE,
+			.cra_ctxsize		= XTS_AES_CTX_SIZE,
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= 2 * AES_MIN_KEY_SIZE,
+		.max_keysize	= 2 * AES_MAX_KEY_SIZE,
+		.ivsize		= AES_BLOCK_SIZE,
+		.walksize	= 2 * AES_BLOCK_SIZE,
+		.setkey		= aeskl_xts_setkey,
+		.encrypt	= xts_encrypt,
+		.decrypt	= xts_decrypt,
+#endif
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
@@ -99,12 +194,18 @@ static int __init aeskl_init(void)
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

