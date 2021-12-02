Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E7466CD5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350043AbhLBWgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:36:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:32107 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239088AbhLBWgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:36:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="216877417"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="216877417"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="541402378"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 02 Dec 2021 14:33:00 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B2MWmYW028552;
        Thu, 2 Dec 2021 22:32:57 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v8 05/14] x86: conditionally place regular ASM functions into separate sections
Date:   Thu,  2 Dec 2021 23:32:05 +0100
Message-Id: <20211202223214.72888-6-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202223214.72888-1-alexandr.lobakin@intel.com>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduces macros to create unique separate sections
for (almost) every "regular" ASM function (i.e. for those which
aren't explicitly put into a specific one).
There should be no leftovers as input .text will be size-asserted
in the LD script generated for FG-KASLR.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/crypto/aegis128-aesni-asm.S          |  36 +++---
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S       |  12 +-
 arch/x86/crypto/aesni-intel_asm.S             | 116 +++++++++---------
 arch/x86/crypto/aesni-intel_avx-x86_64.S      |  32 ++---
 arch/x86/crypto/blake2s-core.S                |   8 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S      |  16 +--
 arch/x86/crypto/camellia-aesni-avx-asm_64.S   |  28 ++---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S  |  28 ++---
 arch/x86/crypto/camellia-x86_64-asm_64.S      |  16 +--
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S     |  24 ++--
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S     |  20 +--
 arch/x86/crypto/chacha-avx2-x86_64.S          |  12 +-
 arch/x86/crypto/chacha-avx512vl-x86_64.S      |  12 +-
 arch/x86/crypto/chacha-ssse3-x86_64.S         |  16 +--
 arch/x86/crypto/crc32-pclmul_asm.S            |   4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S     |   4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S        |   4 +-
 arch/x86/crypto/des3_ede-asm_64.S             |   8 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S     |  12 +-
 arch/x86/crypto/nh-avx2-x86_64.S              |   4 +-
 arch/x86/crypto/nh-sse2-x86_64.S              |   4 +-
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl |   8 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S   |  20 +--
 arch/x86/crypto/serpent-avx2-asm_64.S         |  20 +--
 arch/x86/crypto/serpent-sse2-i586-asm_32.S    |   8 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S  |   8 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S        |   4 +-
 arch/x86/crypto/sha1_ni_asm.S                 |   4 +-
 arch/x86/crypto/sha1_ssse3_asm.S              |   4 +-
 arch/x86/crypto/sha256-avx-asm.S              |   4 +-
 arch/x86/crypto/sha256-avx2-asm.S             |   4 +-
 arch/x86/crypto/sha256-ssse3-asm.S            |   4 +-
 arch/x86/crypto/sha256_ni_asm.S               |   4 +-
 arch/x86/crypto/sha512-avx-asm.S              |   4 +-
 arch/x86/crypto/sha512-avx2-asm.S             |   4 +-
 arch/x86/crypto/sha512-ssse3-asm.S            |   4 +-
 arch/x86/crypto/sm4-aesni-avx-asm_64.S        |  24 ++--
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S       |  16 +--
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S   |  20 +--
 arch/x86/crypto/twofish-i586-asm_32.S         |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S  |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S       |   8 +-
 arch/x86/entry/entry_32.S                     |  24 ++--
 arch/x86/entry/entry_64.S                     |  18 +--
 arch/x86/entry/thunk_32.S                     |   4 +-
 arch/x86/entry/thunk_64.S                     |   8 +-
 arch/x86/include/asm/paravirt.h               |   5 +-
 arch/x86/include/asm/qspinlock_paravirt.h     |   2 +-
 arch/x86/kernel/acpi/wakeup_32.S              |   9 +-
 arch/x86/kernel/acpi/wakeup_64.S              |  10 +-
 arch/x86/kernel/ftrace_32.S                   |  19 +--
 arch/x86/kernel/ftrace_64.S                   |  24 ++--
 arch/x86/kernel/kprobes/core.c                |   3 +-
 arch/x86/kernel/kvm.c                         |   2 +-
 arch/x86/kernel/relocate_kernel_32.S          |   2 +
 arch/x86/kernel/relocate_kernel_64.S          |   2 +
 arch/x86/kvm/emulate.c                        |   2 +-
 arch/x86/kvm/vmx/vmenter.S                    |   8 +-
 arch/x86/lib/clear_page_64.S                  |  12 +-
 arch/x86/lib/cmpxchg16b_emu.S                 |   4 +-
 arch/x86/lib/copy_mc_64.S                     |   8 +-
 arch/x86/lib/copy_page_64.S                   |   7 +-
 arch/x86/lib/copy_user_64.S                   |  18 +--
 arch/x86/lib/csum-copy_64.S                   |   4 +-
 arch/x86/lib/error-inject.c                   |   3 +-
 arch/x86/lib/getuser.S                        |  37 +++---
 arch/x86/lib/hweight.S                        |   9 +-
 arch/x86/lib/iomap_copy_64.S                  |   4 +-
 arch/x86/lib/memmove_64.S                     |   4 +-
 arch/x86/lib/memset_64.S                      |  12 +-
 arch/x86/lib/msr-reg.S                        |   8 +-
 arch/x86/lib/putuser.S                        |  18 +--
 arch/x86/mm/mem_encrypt_boot.S                |   8 +-
 arch/x86/platform/efi/efi_stub_64.S           |   4 +-
 arch/x86/platform/efi/efi_thunk_64.S          |   4 +-
 arch/x86/power/hibernate_asm_32.S             |  14 ++-
 arch/x86/power/hibernate_asm_64.S             |  14 ++-
 arch/x86/xen/xen-asm.S                        |  24 ++--
 arch/x86/xen/xen-head.S                       |   6 +-
 79 files changed, 486 insertions(+), 482 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 51d46d93efbc..0f2d5d77fc6e 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -71,7 +71,7 @@
  *   %r8
  *   %r9
  */
-SYM_FUNC_START_LOCAL(__load_partial)
+SYM_FUNC_START_LOCAL_SECTION(__load_partial)
 	xor %r9d, %r9d
 	pxor MSG, MSG
 
@@ -123,7 +123,7 @@ SYM_FUNC_START_LOCAL(__load_partial)
 
 .Lld_partial_8:
 	ret
-SYM_FUNC_END(__load_partial)
+SYM_FUNC_END_SECTION(__load_partial)
 
 /*
  * __store_partial: internal ABI
@@ -137,7 +137,7 @@ SYM_FUNC_END(__load_partial)
  *   %r9
  *   %r10
  */
-SYM_FUNC_START_LOCAL(__store_partial)
+SYM_FUNC_START_LOCAL_SECTION(__store_partial)
 	mov LEN, %r8
 	mov DST, %r9
 
@@ -181,12 +181,12 @@ SYM_FUNC_START_LOCAL(__store_partial)
 
 .Lst_partial_1:
 	ret
-SYM_FUNC_END(__store_partial)
+SYM_FUNC_END_SECTION(__store_partial)
 
 /*
  * void crypto_aegis128_aesni_init(void *state, const void *key, const void *iv);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_init)
+SYM_FUNC_START_SECTION(crypto_aegis128_aesni_init)
 	FRAME_BEGIN
 
 	/* load IV: */
@@ -226,13 +226,13 @@ SYM_FUNC_START(crypto_aegis128_aesni_init)
 
 	FRAME_END
 	ret
-SYM_FUNC_END(crypto_aegis128_aesni_init)
+SYM_FUNC_END_SECTION(crypto_aegis128_aesni_init)
 
 /*
  * void crypto_aegis128_aesni_ad(void *state, unsigned int length,
  *                               const void *data);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_ad)
+SYM_FUNC_START_SECTION(crypto_aegis128_aesni_ad)
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -378,7 +378,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_ad)
 .Lad_out:
 	FRAME_END
 	ret
-SYM_FUNC_END(crypto_aegis128_aesni_ad)
+SYM_FUNC_END_SECTION(crypto_aegis128_aesni_ad)
 
 .macro encrypt_block a s0 s1 s2 s3 s4 i
 	movdq\a (\i * 0x10)(SRC), MSG
@@ -402,7 +402,7 @@ SYM_FUNC_END(crypto_aegis128_aesni_ad)
  * void crypto_aegis128_aesni_enc(void *state, unsigned int length,
  *                                const void *src, void *dst);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_enc)
+SYM_FUNC_START_SECTION(crypto_aegis128_aesni_enc)
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -493,13 +493,13 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc)
 .Lenc_out:
 	FRAME_END
 	ret
-SYM_FUNC_END(crypto_aegis128_aesni_enc)
+SYM_FUNC_END_SECTION(crypto_aegis128_aesni_enc)
 
 /*
  * void crypto_aegis128_aesni_enc_tail(void *state, unsigned int length,
  *                                     const void *src, void *dst);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_enc_tail)
+SYM_FUNC_START_SECTION(crypto_aegis128_aesni_enc_tail)
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -533,7 +533,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc_tail)
 
 	FRAME_END
 	ret
-SYM_FUNC_END(crypto_aegis128_aesni_enc_tail)
+SYM_FUNC_END_SECTION(crypto_aegis128_aesni_enc_tail)
 
 .macro decrypt_block a s0 s1 s2 s3 s4 i
 	movdq\a (\i * 0x10)(SRC), MSG
@@ -556,7 +556,7 @@ SYM_FUNC_END(crypto_aegis128_aesni_enc_tail)
  * void crypto_aegis128_aesni_dec(void *state, unsigned int length,
  *                                const void *src, void *dst);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_dec)
+SYM_FUNC_START_SECTION(crypto_aegis128_aesni_dec)
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -647,13 +647,13 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec)
 .Ldec_out:
 	FRAME_END
 	ret
-SYM_FUNC_END(crypto_aegis128_aesni_dec)
+SYM_FUNC_END_SECTION(crypto_aegis128_aesni_dec)
 
 /*
  * void crypto_aegis128_aesni_dec_tail(void *state, unsigned int length,
  *                                     const void *src, void *dst);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_dec_tail)
+SYM_FUNC_START_SECTION(crypto_aegis128_aesni_dec_tail)
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -697,13 +697,13 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec_tail)
 
 	FRAME_END
 	ret
-SYM_FUNC_END(crypto_aegis128_aesni_dec_tail)
+SYM_FUNC_END_SECTION(crypto_aegis128_aesni_dec_tail)
 
 /*
  * void crypto_aegis128_aesni_final(void *state, void *tag_xor,
  *                                  u64 assoclen, u64 cryptlen);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_final)
+SYM_FUNC_START_SECTION(crypto_aegis128_aesni_final)
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -744,4 +744,4 @@ SYM_FUNC_START(crypto_aegis128_aesni_final)
 
 	FRAME_END
 	ret
-SYM_FUNC_END(crypto_aegis128_aesni_final)
+SYM_FUNC_END_SECTION(crypto_aegis128_aesni_final)
diff --git a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
index 3f0fc7dd87d7..b9968403c05c 100644
--- a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
+++ b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
@@ -535,11 +535,11 @@ ddq_add_8:
  * aes_ctr_enc_128_avx_by8(void *in, void *iv, void *keys, void *out,
  *			unsigned int num_bytes)
  */
-SYM_FUNC_START(aes_ctr_enc_128_avx_by8)
+SYM_FUNC_START_SECTION(aes_ctr_enc_128_avx_by8)
 	/* call the aes main loop */
 	do_aes_ctrmain KEY_128
 
-SYM_FUNC_END(aes_ctr_enc_128_avx_by8)
+SYM_FUNC_END_SECTION(aes_ctr_enc_128_avx_by8)
 
 /*
  * routine to do AES192 CTR enc/decrypt "by8"
@@ -548,11 +548,11 @@ SYM_FUNC_END(aes_ctr_enc_128_avx_by8)
  * aes_ctr_enc_192_avx_by8(void *in, void *iv, void *keys, void *out,
  *			unsigned int num_bytes)
  */
-SYM_FUNC_START(aes_ctr_enc_192_avx_by8)
+SYM_FUNC_START_SECTION(aes_ctr_enc_192_avx_by8)
 	/* call the aes main loop */
 	do_aes_ctrmain KEY_192
 
-SYM_FUNC_END(aes_ctr_enc_192_avx_by8)
+SYM_FUNC_END_SECTION(aes_ctr_enc_192_avx_by8)
 
 /*
  * routine to do AES256 CTR enc/decrypt "by8"
@@ -561,8 +561,8 @@ SYM_FUNC_END(aes_ctr_enc_192_avx_by8)
  * aes_ctr_enc_256_avx_by8(void *in, void *iv, void *keys, void *out,
  *			unsigned int num_bytes)
  */
-SYM_FUNC_START(aes_ctr_enc_256_avx_by8)
+SYM_FUNC_START_SECTION(aes_ctr_enc_256_avx_by8)
 	/* call the aes main loop */
 	do_aes_ctrmain KEY_256
 
-SYM_FUNC_END(aes_ctr_enc_256_avx_by8)
+SYM_FUNC_END_SECTION(aes_ctr_enc_256_avx_by8)
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 4e3972570916..5c1076b12df8 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1587,7 +1587,7 @@ _esb_loop_\@:
 * poly = x^128 + x^127 + x^126 + x^121 + 1
 *
 *****************************************************************************/
-SYM_FUNC_START(aesni_gcm_dec)
+SYM_FUNC_START_SECTION(aesni_gcm_dec)
 	FUNC_SAVE
 
 	GCM_INIT %arg6, arg7, arg8, arg9
@@ -1595,8 +1595,7 @@ SYM_FUNC_START(aesni_gcm_dec)
 	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
 	ret
-SYM_FUNC_END(aesni_gcm_dec)
-
+SYM_FUNC_END_SECTION(aesni_gcm_dec)
 
 /*****************************************************************************
 * void aesni_gcm_enc(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1675,7 +1674,7 @@ SYM_FUNC_END(aesni_gcm_dec)
 *
 * poly = x^128 + x^127 + x^126 + x^121 + 1
 ***************************************************************************/
-SYM_FUNC_START(aesni_gcm_enc)
+SYM_FUNC_START_SECTION(aesni_gcm_enc)
 	FUNC_SAVE
 
 	GCM_INIT %arg6, arg7, arg8, arg9
@@ -1684,7 +1683,7 @@ SYM_FUNC_START(aesni_gcm_enc)
 	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
 	ret
-SYM_FUNC_END(aesni_gcm_enc)
+SYM_FUNC_END_SECTION(aesni_gcm_enc)
 
 /*****************************************************************************
 * void aesni_gcm_init(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1697,12 +1696,12 @@ SYM_FUNC_END(aesni_gcm_enc)
 *                     const u8 *aad,      // Additional Authentication Data (AAD)
 *                     u64 aad_len)        // Length of AAD in bytes.
 */
-SYM_FUNC_START(aesni_gcm_init)
+SYM_FUNC_START_SECTION(aesni_gcm_init)
 	FUNC_SAVE
 	GCM_INIT %arg3, %arg4,%arg5, %arg6
 	FUNC_RESTORE
 	ret
-SYM_FUNC_END(aesni_gcm_init)
+SYM_FUNC_END_SECTION(aesni_gcm_init)
 
 /*****************************************************************************
 * void aesni_gcm_enc_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1712,12 +1711,12 @@ SYM_FUNC_END(aesni_gcm_init)
 *                    const u8 *in,       // Plaintext input
 *                    u64 plaintext_len,  // Length of data in bytes for encryption.
 */
-SYM_FUNC_START(aesni_gcm_enc_update)
+SYM_FUNC_START_SECTION(aesni_gcm_enc_update)
 	FUNC_SAVE
 	GCM_ENC_DEC enc
 	FUNC_RESTORE
 	ret
-SYM_FUNC_END(aesni_gcm_enc_update)
+SYM_FUNC_END_SECTION(aesni_gcm_enc_update)
 
 /*****************************************************************************
 * void aesni_gcm_dec_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1727,12 +1726,12 @@ SYM_FUNC_END(aesni_gcm_enc_update)
 *                    const u8 *in,       // Plaintext input
 *                    u64 plaintext_len,  // Length of data in bytes for encryption.
 */
-SYM_FUNC_START(aesni_gcm_dec_update)
+SYM_FUNC_START_SECTION(aesni_gcm_dec_update)
 	FUNC_SAVE
 	GCM_ENC_DEC dec
 	FUNC_RESTORE
 	ret
-SYM_FUNC_END(aesni_gcm_dec_update)
+SYM_FUNC_END_SECTION(aesni_gcm_dec_update)
 
 /*****************************************************************************
 * void aesni_gcm_finalize(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1742,17 +1741,15 @@ SYM_FUNC_END(aesni_gcm_dec_update)
 *                    u64 auth_tag_len);  // Authenticated Tag Length in bytes. Valid values are 16 (most likely),
 *                                        // 12 or 8.
 */
-SYM_FUNC_START(aesni_gcm_finalize)
+SYM_FUNC_START_SECTION(aesni_gcm_finalize)
 	FUNC_SAVE
 	GCM_COMPLETE %arg3 %arg4
 	FUNC_RESTORE
 	ret
-SYM_FUNC_END(aesni_gcm_finalize)
-
+SYM_FUNC_END_SECTION(aesni_gcm_finalize)
 #endif
 
-
-SYM_FUNC_START_LOCAL_ALIAS(_key_expansion_128)
+SYM_FUNC_START_LOCAL_ALIAS_SECTION(_key_expansion_128)
 SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	pshufd $0b11111111, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
@@ -1764,9 +1761,9 @@ SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	add $0x10, TKEYP
 	ret
 SYM_FUNC_END(_key_expansion_256a)
-SYM_FUNC_END_ALIAS(_key_expansion_128)
+SYM_FUNC_END_ALIAS_SECTION(_key_expansion_128)
 
-SYM_FUNC_START_LOCAL(_key_expansion_192a)
+SYM_FUNC_START_LOCAL_SECTION(_key_expansion_192a)
 	pshufd $0b01010101, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
 	pxor %xmm4, %xmm0
@@ -1788,9 +1785,9 @@ SYM_FUNC_START_LOCAL(_key_expansion_192a)
 	movaps %xmm1, 0x10(TKEYP)
 	add $0x20, TKEYP
 	ret
-SYM_FUNC_END(_key_expansion_192a)
+SYM_FUNC_END_SECTION(_key_expansion_192a)
 
-SYM_FUNC_START_LOCAL(_key_expansion_192b)
+SYM_FUNC_START_LOCAL_SECTION(_key_expansion_192b)
 	pshufd $0b01010101, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
 	pxor %xmm4, %xmm0
@@ -1807,9 +1804,9 @@ SYM_FUNC_START_LOCAL(_key_expansion_192b)
 	movaps %xmm0, (TKEYP)
 	add $0x10, TKEYP
 	ret
-SYM_FUNC_END(_key_expansion_192b)
+SYM_FUNC_END_SECTION(_key_expansion_192b)
 
-SYM_FUNC_START_LOCAL(_key_expansion_256b)
+SYM_FUNC_START_LOCAL_SECTION(_key_expansion_256b)
 	pshufd $0b10101010, %xmm1, %xmm1
 	shufps $0b00010000, %xmm2, %xmm4
 	pxor %xmm4, %xmm2
@@ -1819,13 +1816,13 @@ SYM_FUNC_START_LOCAL(_key_expansion_256b)
 	movaps %xmm2, (TKEYP)
 	add $0x10, TKEYP
 	ret
-SYM_FUNC_END(_key_expansion_256b)
+SYM_FUNC_END_SECTION(_key_expansion_256b)
 
 /*
  * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
  *                   unsigned int key_len)
  */
-SYM_FUNC_START(aesni_set_key)
+SYM_FUNC_START_SECTION(aesni_set_key)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1934,12 +1931,12 @@ SYM_FUNC_START(aesni_set_key)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_set_key)
+SYM_FUNC_END_SECTION(aesni_set_key)
 
 /*
  * void aesni_enc(const void *ctx, u8 *dst, const u8 *src)
  */
-SYM_FUNC_START(aesni_enc)
+SYM_FUNC_START_SECTION(aesni_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1958,7 +1955,7 @@ SYM_FUNC_START(aesni_enc)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_enc)
+SYM_FUNC_END_SECTION(aesni_enc)
 
 /*
  * _aesni_enc1:		internal ABI
@@ -1972,7 +1969,7 @@ SYM_FUNC_END(aesni_enc)
  *	KEY
  *	TKEYP (T1)
  */
-SYM_FUNC_START_LOCAL(_aesni_enc1)
+SYM_FUNC_START_LOCAL_SECTION(_aesni_enc1)
 	movaps (KEYP), KEY		# key
 	mov KEYP, TKEYP
 	pxor KEY, STATE		# round 0
@@ -2015,7 +2012,7 @@ SYM_FUNC_START_LOCAL(_aesni_enc1)
 	movaps 0x70(TKEYP), KEY
 	aesenclast KEY, STATE
 	ret
-SYM_FUNC_END(_aesni_enc1)
+SYM_FUNC_END_SECTION(_aesni_enc1)
 
 /*
  * _aesni_enc4:	internal ABI
@@ -2035,7 +2032,7 @@ SYM_FUNC_END(_aesni_enc1)
  *	KEY
  *	TKEYP (T1)
  */
-SYM_FUNC_START_LOCAL(_aesni_enc4)
+SYM_FUNC_START_LOCAL_SECTION(_aesni_enc4)
 	movaps (KEYP), KEY		# key
 	mov KEYP, TKEYP
 	pxor KEY, STATE1		# round 0
@@ -2123,12 +2120,12 @@ SYM_FUNC_START_LOCAL(_aesni_enc4)
 	aesenclast KEY, STATE3
 	aesenclast KEY, STATE4
 	ret
-SYM_FUNC_END(_aesni_enc4)
+SYM_FUNC_END_SECTION(_aesni_enc4)
 
 /*
  * void aesni_dec (const void *ctx, u8 *dst, const u8 *src)
  */
-SYM_FUNC_START(aesni_dec)
+SYM_FUNC_START_SECTION(aesni_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -2148,7 +2145,7 @@ SYM_FUNC_START(aesni_dec)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_dec)
+SYM_FUNC_END_SECTION(aesni_dec)
 
 /*
  * _aesni_dec1:		internal ABI
@@ -2162,7 +2159,7 @@ SYM_FUNC_END(aesni_dec)
  *	KEY
  *	TKEYP (T1)
  */
-SYM_FUNC_START_LOCAL(_aesni_dec1)
+SYM_FUNC_START_LOCAL_SECTION(_aesni_dec1)
 	movaps (KEYP), KEY		# key
 	mov KEYP, TKEYP
 	pxor KEY, STATE		# round 0
@@ -2205,7 +2202,7 @@ SYM_FUNC_START_LOCAL(_aesni_dec1)
 	movaps 0x70(TKEYP), KEY
 	aesdeclast KEY, STATE
 	ret
-SYM_FUNC_END(_aesni_dec1)
+SYM_FUNC_END_SECTION(_aesni_dec1)
 
 /*
  * _aesni_dec4:	internal ABI
@@ -2225,7 +2222,7 @@ SYM_FUNC_END(_aesni_dec1)
  *	KEY
  *	TKEYP (T1)
  */
-SYM_FUNC_START_LOCAL(_aesni_dec4)
+SYM_FUNC_START_LOCAL_SECTION(_aesni_dec4)
 	movaps (KEYP), KEY		# key
 	mov KEYP, TKEYP
 	pxor KEY, STATE1		# round 0
@@ -2313,13 +2310,13 @@ SYM_FUNC_START_LOCAL(_aesni_dec4)
 	aesdeclast KEY, STATE3
 	aesdeclast KEY, STATE4
 	ret
-SYM_FUNC_END(_aesni_dec4)
+SYM_FUNC_END_SECTION(_aesni_dec4)
 
 /*
  * void aesni_ecb_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len)
  */
-SYM_FUNC_START(aesni_ecb_enc)
+SYM_FUNC_START_SECTION(aesni_ecb_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl LEN
@@ -2373,13 +2370,13 @@ SYM_FUNC_START(aesni_ecb_enc)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_ecb_enc)
+SYM_FUNC_END_SECTION(aesni_ecb_enc)
 
 /*
  * void aesni_ecb_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len);
  */
-SYM_FUNC_START(aesni_ecb_dec)
+SYM_FUNC_START_SECTION(aesni_ecb_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl LEN
@@ -2434,13 +2431,13 @@ SYM_FUNC_START(aesni_ecb_dec)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_ecb_dec)
+SYM_FUNC_END_SECTION(aesni_ecb_dec)
 
 /*
  * void aesni_cbc_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len, u8 *iv)
  */
-SYM_FUNC_START(aesni_cbc_enc)
+SYM_FUNC_START_SECTION(aesni_cbc_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2478,13 +2475,13 @@ SYM_FUNC_START(aesni_cbc_enc)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_cbc_enc)
+SYM_FUNC_END_SECTION(aesni_cbc_enc)
 
 /*
  * void aesni_cbc_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len, u8 *iv)
  */
-SYM_FUNC_START(aesni_cbc_dec)
+SYM_FUNC_START_SECTION(aesni_cbc_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2571,13 +2568,13 @@ SYM_FUNC_START(aesni_cbc_dec)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_cbc_dec)
+SYM_FUNC_END_SECTION(aesni_cbc_dec)
 
 /*
  * void aesni_cts_cbc_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *			  size_t len, u8 *iv)
  */
-SYM_FUNC_START(aesni_cts_cbc_enc)
+SYM_FUNC_START_SECTION(aesni_cts_cbc_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2628,13 +2625,13 @@ SYM_FUNC_START(aesni_cts_cbc_enc)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_cts_cbc_enc)
+SYM_FUNC_END_SECTION(aesni_cts_cbc_enc)
 
 /*
  * void aesni_cts_cbc_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *			  size_t len, u8 *iv)
  */
-SYM_FUNC_START(aesni_cts_cbc_dec)
+SYM_FUNC_START_SECTION(aesni_cts_cbc_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2689,7 +2686,7 @@ SYM_FUNC_START(aesni_cts_cbc_dec)
 #endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_cts_cbc_dec)
+SYM_FUNC_END_SECTION(aesni_cts_cbc_dec)
 
 .pushsection .rodata
 .align 16
@@ -2718,7 +2715,7 @@ SYM_FUNC_END(aesni_cts_cbc_dec)
  *	INC:	== 1, in little endian
  *	BSWAP_MASK == endian swapping mask
  */
-SYM_FUNC_START_LOCAL(_aesni_inc_init)
+SYM_FUNC_START_LOCAL_SECTION(_aesni_inc_init)
 	movaps .Lbswap_mask, BSWAP_MASK
 	movaps IV, CTR
 	pshufb BSWAP_MASK, CTR
@@ -2726,7 +2723,7 @@ SYM_FUNC_START_LOCAL(_aesni_inc_init)
 	movq TCTR_LOW, INC
 	movq CTR, TCTR_LOW
 	ret
-SYM_FUNC_END(_aesni_inc_init)
+SYM_FUNC_END_SECTION(_aesni_inc_init)
 
 /*
  * _aesni_inc:		internal ABI
@@ -2743,7 +2740,7 @@ SYM_FUNC_END(_aesni_inc_init)
  *	CTR:	== output IV, in little endian
  *	TCTR_LOW: == lower qword of CTR
  */
-SYM_FUNC_START_LOCAL(_aesni_inc)
+SYM_FUNC_START_LOCAL_SECTION(_aesni_inc)
 	paddq INC, CTR
 	add $1, TCTR_LOW
 	jnc .Linc_low
@@ -2754,13 +2751,13 @@ SYM_FUNC_START_LOCAL(_aesni_inc)
 	movaps CTR, IV
 	pshufb BSWAP_MASK, IV
 	ret
-SYM_FUNC_END(_aesni_inc)
+SYM_FUNC_END_SECTION(_aesni_inc)
 
 /*
  * void aesni_ctr_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len, u8 *iv)
  */
-SYM_FUNC_START(aesni_ctr_enc)
+SYM_FUNC_START_SECTION(aesni_ctr_enc)
 	FRAME_BEGIN
 	cmp $16, LEN
 	jb .Lctr_enc_just_ret
@@ -2817,8 +2814,7 @@ SYM_FUNC_START(aesni_ctr_enc)
 .Lctr_enc_just_ret:
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_ctr_enc)
-
+SYM_FUNC_END_SECTION(aesni_ctr_enc)
 #endif
 
 .section	.rodata.cst16.gf128mul_x_ble_mask, "aM", @progbits, 16
@@ -2849,7 +2845,7 @@ SYM_FUNC_END(aesni_ctr_enc)
  * void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
  *			  const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_encrypt)
+SYM_FUNC_START_SECTION(aesni_xts_encrypt)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2998,13 +2994,13 @@ SYM_FUNC_START(aesni_xts_encrypt)
 
 	movups STATE, (OUTP)
 	jmp .Lxts_enc_ret
-SYM_FUNC_END(aesni_xts_encrypt)
+SYM_FUNC_END_SECTION(aesni_xts_encrypt)
 
 /*
  * void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
  *			  const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_decrypt)
+SYM_FUNC_START_SECTION(aesni_xts_decrypt)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -3160,4 +3156,4 @@ SYM_FUNC_START(aesni_xts_decrypt)
 
 	movups STATE, (OUTP)
 	jmp .Lxts_dec_ret
-SYM_FUNC_END(aesni_xts_decrypt)
+SYM_FUNC_END_SECTION(aesni_xts_decrypt)
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 98e3552b6e03..1a116980d273 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -1763,12 +1763,12 @@ _initial_blocks_done\@:
 #        const   u8 *aad, /* Additional Authentication Data (AAD)*/
 #        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is going to be 8 or 12 Bytes */
 #############################################################
-SYM_FUNC_START(aesni_gcm_init_avx_gen2)
+SYM_FUNC_START_SECTION(aesni_gcm_init_avx_gen2)
         FUNC_SAVE
         INIT GHASH_MUL_AVX, PRECOMPUTE_AVX
         FUNC_RESTORE
         ret
-SYM_FUNC_END(aesni_gcm_init_avx_gen2)
+SYM_FUNC_END_SECTION(aesni_gcm_init_avx_gen2)
 
 ###############################################################################
 #void   aesni_gcm_enc_update_avx_gen2(
@@ -1778,7 +1778,7 @@ SYM_FUNC_END(aesni_gcm_init_avx_gen2)
 #        const   u8 *in, /* Plaintext input */
 #        u64     plaintext_len) /* Length of data in Bytes for encryption. */
 ###############################################################################
-SYM_FUNC_START(aesni_gcm_enc_update_avx_gen2)
+SYM_FUNC_START_SECTION(aesni_gcm_enc_update_avx_gen2)
         FUNC_SAVE
         mov     keysize, %eax
         cmp     $32, %eax
@@ -1797,7 +1797,7 @@ key_256_enc_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 13
         FUNC_RESTORE
         ret
-SYM_FUNC_END(aesni_gcm_enc_update_avx_gen2)
+SYM_FUNC_END_SECTION(aesni_gcm_enc_update_avx_gen2)
 
 ###############################################################################
 #void   aesni_gcm_dec_update_avx_gen2(
@@ -1807,7 +1807,7 @@ SYM_FUNC_END(aesni_gcm_enc_update_avx_gen2)
 #        const   u8 *in, /* Ciphertext input */
 #        u64     plaintext_len) /* Length of data in Bytes for encryption. */
 ###############################################################################
-SYM_FUNC_START(aesni_gcm_dec_update_avx_gen2)
+SYM_FUNC_START_SECTION(aesni_gcm_dec_update_avx_gen2)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
@@ -1826,7 +1826,7 @@ key_256_dec_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 13
         FUNC_RESTORE
         ret
-SYM_FUNC_END(aesni_gcm_dec_update_avx_gen2)
+SYM_FUNC_END_SECTION(aesni_gcm_dec_update_avx_gen2)
 
 ###############################################################################
 #void   aesni_gcm_finalize_avx_gen2(
@@ -1836,7 +1836,7 @@ SYM_FUNC_END(aesni_gcm_dec_update_avx_gen2)
 #        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
 #				Valid values are 16 (most likely), 12 or 8. */
 ###############################################################################
-SYM_FUNC_START(aesni_gcm_finalize_avx_gen2)
+SYM_FUNC_START_SECTION(aesni_gcm_finalize_avx_gen2)
         FUNC_SAVE
         mov	keysize,%eax
         cmp     $32, %eax
@@ -1855,7 +1855,7 @@ key_256_finalize:
         GCM_COMPLETE GHASH_MUL_AVX, 13, arg3, arg4
         FUNC_RESTORE
         ret
-SYM_FUNC_END(aesni_gcm_finalize_avx_gen2)
+SYM_FUNC_END_SECTION(aesni_gcm_finalize_avx_gen2)
 
 ###############################################################################
 # GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
@@ -2731,12 +2731,12 @@ _initial_blocks_done\@:
 #        const   u8 *aad, /* Additional Authentication Data (AAD)*/
 #        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is going to be 8 or 12 Bytes */
 #############################################################
-SYM_FUNC_START(aesni_gcm_init_avx_gen4)
+SYM_FUNC_START_SECTION(aesni_gcm_init_avx_gen4)
         FUNC_SAVE
         INIT GHASH_MUL_AVX2, PRECOMPUTE_AVX2
         FUNC_RESTORE
         ret
-SYM_FUNC_END(aesni_gcm_init_avx_gen4)
+SYM_FUNC_END_SECTION(aesni_gcm_init_avx_gen4)
 
 ###############################################################################
 #void   aesni_gcm_enc_avx_gen4(
@@ -2746,7 +2746,7 @@ SYM_FUNC_END(aesni_gcm_init_avx_gen4)
 #        const   u8 *in, /* Plaintext input */
 #        u64     plaintext_len) /* Length of data in Bytes for encryption. */
 ###############################################################################
-SYM_FUNC_START(aesni_gcm_enc_update_avx_gen4)
+SYM_FUNC_START_SECTION(aesni_gcm_enc_update_avx_gen4)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
@@ -2765,7 +2765,7 @@ key_256_enc_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 13
         FUNC_RESTORE
 	ret
-SYM_FUNC_END(aesni_gcm_enc_update_avx_gen4)
+SYM_FUNC_END_SECTION(aesni_gcm_enc_update_avx_gen4)
 
 ###############################################################################
 #void   aesni_gcm_dec_update_avx_gen4(
@@ -2775,7 +2775,7 @@ SYM_FUNC_END(aesni_gcm_enc_update_avx_gen4)
 #        const   u8 *in, /* Ciphertext input */
 #        u64     plaintext_len) /* Length of data in Bytes for encryption. */
 ###############################################################################
-SYM_FUNC_START(aesni_gcm_dec_update_avx_gen4)
+SYM_FUNC_START_SECTION(aesni_gcm_dec_update_avx_gen4)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
@@ -2794,7 +2794,7 @@ key_256_dec_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 13
         FUNC_RESTORE
         ret
-SYM_FUNC_END(aesni_gcm_dec_update_avx_gen4)
+SYM_FUNC_END_SECTION(aesni_gcm_dec_update_avx_gen4)
 
 ###############################################################################
 #void   aesni_gcm_finalize_avx_gen4(
@@ -2804,7 +2804,7 @@ SYM_FUNC_END(aesni_gcm_dec_update_avx_gen4)
 #        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
 #                              Valid values are 16 (most likely), 12 or 8. */
 ###############################################################################
-SYM_FUNC_START(aesni_gcm_finalize_avx_gen4)
+SYM_FUNC_START_SECTION(aesni_gcm_finalize_avx_gen4)
         FUNC_SAVE
         mov	keysize,%eax
         cmp     $32, %eax
@@ -2823,4 +2823,4 @@ key_256_finalize4:
         GCM_COMPLETE GHASH_MUL_AVX2, 13, arg3, arg4
         FUNC_RESTORE
         ret
-SYM_FUNC_END(aesni_gcm_finalize_avx_gen4)
+SYM_FUNC_END_SECTION(aesni_gcm_finalize_avx_gen4)
diff --git a/arch/x86/crypto/blake2s-core.S b/arch/x86/crypto/blake2s-core.S
index 2ca79974f819..557169b98d3d 100644
--- a/arch/x86/crypto/blake2s-core.S
+++ b/arch/x86/crypto/blake2s-core.S
@@ -46,7 +46,7 @@ SIGMA2:
 #endif /* CONFIG_AS_AVX512 */
 
 .text
-SYM_FUNC_START(blake2s_compress_ssse3)
+SYM_FUNC_START_SECTION(blake2s_compress_ssse3)
 	testq		%rdx,%rdx
 	je		.Lendofloop
 	movdqu		(%rdi),%xmm0
@@ -172,10 +172,10 @@ SYM_FUNC_START(blake2s_compress_ssse3)
 	movdqu		%xmm14,0x20(%rdi)
 .Lendofloop:
 	ret
-SYM_FUNC_END(blake2s_compress_ssse3)
+SYM_FUNC_END_SECTION(blake2s_compress_ssse3)
 
 #ifdef CONFIG_AS_AVX512
-SYM_FUNC_START(blake2s_compress_avx512)
+SYM_FUNC_START_SECTION(blake2s_compress_avx512)
 	vmovdqu		(%rdi),%xmm0
 	vmovdqu		0x10(%rdi),%xmm1
 	vmovdqu		0x20(%rdi),%xmm4
@@ -252,5 +252,5 @@ SYM_FUNC_START(blake2s_compress_avx512)
 	vmovdqu		%xmm4,0x20(%rdi)
 	vzeroupper
 	retq
-SYM_FUNC_END(blake2s_compress_avx512)
+SYM_FUNC_END_SECTION(blake2s_compress_avx512)
 #endif /* CONFIG_AS_AVX512 */
diff --git a/arch/x86/crypto/blowfish-x86_64-asm_64.S b/arch/x86/crypto/blowfish-x86_64-asm_64.S
index 4222ac6d6584..d95e7bbd4d6c 100644
--- a/arch/x86/crypto/blowfish-x86_64-asm_64.S
+++ b/arch/x86/crypto/blowfish-x86_64-asm_64.S
@@ -103,7 +103,7 @@
 	bswapq 			RX0; \
 	xorq RX0, 		(RIO);
 
-SYM_FUNC_START(__blowfish_enc_blk)
+SYM_FUNC_START_SECTION(__blowfish_enc_blk)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -139,9 +139,9 @@ SYM_FUNC_START(__blowfish_enc_blk)
 .L__enc_xor:
 	xor_block();
 	ret;
-SYM_FUNC_END(__blowfish_enc_blk)
+SYM_FUNC_END_SECTION(__blowfish_enc_blk)
 
-SYM_FUNC_START(blowfish_dec_blk)
+SYM_FUNC_START_SECTION(blowfish_dec_blk)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -171,7 +171,7 @@ SYM_FUNC_START(blowfish_dec_blk)
 	movq %r11, %r12;
 
 	ret;
-SYM_FUNC_END(blowfish_dec_blk)
+SYM_FUNC_END_SECTION(blowfish_dec_blk)
 
 /**********************************************************************
   4-way blowfish, four blocks parallel
@@ -283,7 +283,7 @@ SYM_FUNC_END(blowfish_dec_blk)
 	bswapq 			RX3; \
 	xorq RX3,		24(RIO);
 
-SYM_FUNC_START(__blowfish_enc_blk_4way)
+SYM_FUNC_START_SECTION(__blowfish_enc_blk_4way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -330,9 +330,9 @@ SYM_FUNC_START(__blowfish_enc_blk_4way)
 	popq %rbx;
 	popq %r12;
 	ret;
-SYM_FUNC_END(__blowfish_enc_blk_4way)
+SYM_FUNC_END_SECTION(__blowfish_enc_blk_4way)
 
-SYM_FUNC_START(blowfish_dec_blk_4way)
+SYM_FUNC_START_SECTION(blowfish_dec_blk_4way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -365,4 +365,4 @@ SYM_FUNC_START(blowfish_dec_blk_4way)
 	popq %r12;
 
 	ret;
-SYM_FUNC_END(blowfish_dec_blk_4way)
+SYM_FUNC_END_SECTION(blowfish_dec_blk_4way)
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index e2a0e0f4bf9d..33f0ae08bf88 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -187,21 +187,21 @@
  * Size optimization... with inlined roundsm16, binary would be over 5 times
  * larger and would only be 0.5% faster (on sandy-bridge).
  */
+SYM_FUNC_START_LOCAL_SECTION(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 .align 8
-SYM_FUNC_START_LOCAL(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 	roundsm16(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		  %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm15,
 		  %rcx, (%r9));
 	ret;
-SYM_FUNC_END(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
+SYM_FUNC_END_SECTION(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 
+SYM_FUNC_START_LOCAL_SECTION(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 .align 8
-SYM_FUNC_START_LOCAL(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	roundsm16(%xmm4, %xmm5, %xmm6, %xmm7, %xmm0, %xmm1, %xmm2, %xmm3,
 		  %xmm12, %xmm13, %xmm14, %xmm15, %xmm8, %xmm9, %xmm10, %xmm11,
 		  %rax, (%r9));
 	ret;
-SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
+SYM_FUNC_END_SECTION(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 
 /*
  * IN/OUT:
@@ -712,8 +712,8 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 
 .text
 
+SYM_FUNC_START_LOCAL_SECTION(__camellia_enc_blk16)
 .align 8
-SYM_FUNC_START_LOCAL(__camellia_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rax: temporary storage, 256 bytes
@@ -797,10 +797,10 @@ SYM_FUNC_START_LOCAL(__camellia_enc_blk16)
 		     %xmm15, %rax, %rcx, 24);
 
 	jmp .Lenc_done;
-SYM_FUNC_END(__camellia_enc_blk16)
+SYM_FUNC_END_SECTION(__camellia_enc_blk16)
 
+SYM_FUNC_START_LOCAL_SECTION(__camellia_dec_blk16)
 .align 8
-SYM_FUNC_START_LOCAL(__camellia_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rax: temporary storage, 256 bytes
@@ -882,9 +882,9 @@ SYM_FUNC_START_LOCAL(__camellia_dec_blk16)
 	      ((key_table + (24) * 8) + 4)(CTX));
 
 	jmp .Ldec_max24;
-SYM_FUNC_END(__camellia_dec_blk16)
+SYM_FUNC_END_SECTION(__camellia_dec_blk16)
 
-SYM_FUNC_START(camellia_ecb_enc_16way)
+SYM_FUNC_START_SECTION(camellia_ecb_enc_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -907,9 +907,9 @@ SYM_FUNC_START(camellia_ecb_enc_16way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(camellia_ecb_enc_16way)
+SYM_FUNC_END_SECTION(camellia_ecb_enc_16way)
 
-SYM_FUNC_START(camellia_ecb_dec_16way)
+SYM_FUNC_START_SECTION(camellia_ecb_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -937,9 +937,9 @@ SYM_FUNC_START(camellia_ecb_dec_16way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(camellia_ecb_dec_16way)
+SYM_FUNC_END_SECTION(camellia_ecb_dec_16way)
 
-SYM_FUNC_START(camellia_cbc_dec_16way)
+SYM_FUNC_START_SECTION(camellia_cbc_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -988,4 +988,4 @@ SYM_FUNC_START(camellia_cbc_dec_16way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(camellia_cbc_dec_16way)
+SYM_FUNC_END_SECTION(camellia_cbc_dec_16way)
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 706f70829a07..d2cd829cd1c1 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -221,21 +221,21 @@
  * Size optimization... with inlined roundsm32 binary would be over 5 times
  * larger and would only marginally faster.
  */
+SYM_FUNC_START_LOCAL_SECTION(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 .align 8
-SYM_FUNC_START_LOCAL(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 	roundsm32(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %ymm5, %ymm6, %ymm7,
 		  %ymm8, %ymm9, %ymm10, %ymm11, %ymm12, %ymm13, %ymm14, %ymm15,
 		  %rcx, (%r9));
 	ret;
-SYM_FUNC_END(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
+SYM_FUNC_END_SECTION(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 
+SYM_FUNC_START_LOCAL_SECTION(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 .align 8
-SYM_FUNC_START_LOCAL(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	roundsm32(%ymm4, %ymm5, %ymm6, %ymm7, %ymm0, %ymm1, %ymm2, %ymm3,
 		  %ymm12, %ymm13, %ymm14, %ymm15, %ymm8, %ymm9, %ymm10, %ymm11,
 		  %rax, (%r9));
 	ret;
-SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
+SYM_FUNC_END_SECTION(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 
 /*
  * IN/OUT:
@@ -748,8 +748,8 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 
 .text
 
+SYM_FUNC_START_LOCAL_SECTION(__camellia_enc_blk32)
 .align 8
-SYM_FUNC_START_LOCAL(__camellia_enc_blk32)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rax: temporary storage, 512 bytes
@@ -833,10 +833,10 @@ SYM_FUNC_START_LOCAL(__camellia_enc_blk32)
 		     %ymm15, %rax, %rcx, 24);
 
 	jmp .Lenc_done;
-SYM_FUNC_END(__camellia_enc_blk32)
+SYM_FUNC_END_SECTION(__camellia_enc_blk32)
 
+SYM_FUNC_START_LOCAL_SECTION(__camellia_dec_blk32)
 .align 8
-SYM_FUNC_START_LOCAL(__camellia_dec_blk32)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rax: temporary storage, 512 bytes
@@ -918,9 +918,9 @@ SYM_FUNC_START_LOCAL(__camellia_dec_blk32)
 	      ((key_table + (24) * 8) + 4)(CTX));
 
 	jmp .Ldec_max24;
-SYM_FUNC_END(__camellia_dec_blk32)
+SYM_FUNC_END_SECTION(__camellia_dec_blk32)
 
-SYM_FUNC_START(camellia_ecb_enc_32way)
+SYM_FUNC_START_SECTION(camellia_ecb_enc_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -947,9 +947,9 @@ SYM_FUNC_START(camellia_ecb_enc_32way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(camellia_ecb_enc_32way)
+SYM_FUNC_END_SECTION(camellia_ecb_enc_32way)
 
-SYM_FUNC_START(camellia_ecb_dec_32way)
+SYM_FUNC_START_SECTION(camellia_ecb_dec_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -981,9 +981,9 @@ SYM_FUNC_START(camellia_ecb_dec_32way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(camellia_ecb_dec_32way)
+SYM_FUNC_END_SECTION(camellia_ecb_dec_32way)
 
-SYM_FUNC_START(camellia_cbc_dec_32way)
+SYM_FUNC_START_SECTION(camellia_cbc_dec_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -1048,4 +1048,4 @@ SYM_FUNC_START(camellia_cbc_dec_32way)
 	addq $(16 * 32), %rsp;
 	FRAME_END
 	ret;
-SYM_FUNC_END(camellia_cbc_dec_32way)
+SYM_FUNC_END_SECTION(camellia_cbc_dec_32way)
diff --git a/arch/x86/crypto/camellia-x86_64-asm_64.S b/arch/x86/crypto/camellia-x86_64-asm_64.S
index 1372e6408850..8b4dd32b752d 100644
--- a/arch/x86/crypto/camellia-x86_64-asm_64.S
+++ b/arch/x86/crypto/camellia-x86_64-asm_64.S
@@ -175,7 +175,7 @@
 	bswapq				RAB0; \
 	movq RAB0,			4*2(RIO);
 
-SYM_FUNC_START(__camellia_enc_blk)
+SYM_FUNC_START_SECTION(__camellia_enc_blk)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -220,9 +220,9 @@ SYM_FUNC_START(__camellia_enc_blk)
 
 	movq RR12, %r12;
 	ret;
-SYM_FUNC_END(__camellia_enc_blk)
+SYM_FUNC_END_SECTION(__camellia_enc_blk)
 
-SYM_FUNC_START(camellia_dec_blk)
+SYM_FUNC_START_SECTION(camellia_dec_blk)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -258,7 +258,7 @@ SYM_FUNC_START(camellia_dec_blk)
 
 	movq RR12, %r12;
 	ret;
-SYM_FUNC_END(camellia_dec_blk)
+SYM_FUNC_END_SECTION(camellia_dec_blk)
 
 /**********************************************************************
   2-way camellia
@@ -409,7 +409,7 @@ SYM_FUNC_END(camellia_dec_blk)
 		bswapq				RAB1; \
 		movq RAB1,			12*2(RIO);
 
-SYM_FUNC_START(__camellia_enc_blk_2way)
+SYM_FUNC_START_SECTION(__camellia_enc_blk_2way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -456,9 +456,9 @@ SYM_FUNC_START(__camellia_enc_blk_2way)
 	movq RR12, %r12;
 	popq %rbx;
 	ret;
-SYM_FUNC_END(__camellia_enc_blk_2way)
+SYM_FUNC_END_SECTION(__camellia_enc_blk_2way)
 
-SYM_FUNC_START(camellia_dec_blk_2way)
+SYM_FUNC_START_SECTION(camellia_dec_blk_2way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -496,4 +496,4 @@ SYM_FUNC_START(camellia_dec_blk_2way)
 	movq RR12, %r12;
 	movq RXOR, %rbx;
 	ret;
-SYM_FUNC_END(camellia_dec_blk_2way)
+SYM_FUNC_END_SECTION(camellia_dec_blk_2way)
diff --git a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
index 8a6181b08b59..971bd5e2f13d 100644
--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -208,8 +208,8 @@
 
 .text
 
+SYM_FUNC_START_LOCAL_SECTION(__cast5_enc_blk16)
 .align 16
-SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	/* input:
 	 *	%rdi: ctx
 	 *	RL1: blocks 1 and 2
@@ -280,10 +280,10 @@ SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	outunpack_blocks(RR4, RL4, RTMP, RX, RKM);
 
 	ret;
-SYM_FUNC_END(__cast5_enc_blk16)
+SYM_FUNC_END_SECTION(__cast5_enc_blk16)
 
+SYM_FUNC_START_LOCAL_SECTION(__cast5_dec_blk16)
 .align 16
-SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 	/* input:
 	 *	%rdi: ctx
 	 *	RL1: encrypted blocks 1 and 2
@@ -357,9 +357,9 @@ SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 .L__skip_dec:
 	vpsrldq $4, RKR, RKR;
 	jmp .L__dec_tail;
-SYM_FUNC_END(__cast5_dec_blk16)
+SYM_FUNC_END_SECTION(__cast5_dec_blk16)
 
-SYM_FUNC_START(cast5_ecb_enc_16way)
+SYM_FUNC_START_SECTION(cast5_ecb_enc_16way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -394,9 +394,9 @@ SYM_FUNC_START(cast5_ecb_enc_16way)
 	popq %r15;
 	FRAME_END
 	ret;
-SYM_FUNC_END(cast5_ecb_enc_16way)
+SYM_FUNC_END_SECTION(cast5_ecb_enc_16way)
 
-SYM_FUNC_START(cast5_ecb_dec_16way)
+SYM_FUNC_START_SECTION(cast5_ecb_dec_16way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -432,9 +432,9 @@ SYM_FUNC_START(cast5_ecb_dec_16way)
 	popq %r15;
 	FRAME_END
 	ret;
-SYM_FUNC_END(cast5_ecb_dec_16way)
+SYM_FUNC_END_SECTION(cast5_ecb_dec_16way)
 
-SYM_FUNC_START(cast5_cbc_dec_16way)
+SYM_FUNC_START_SECTION(cast5_cbc_dec_16way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -484,9 +484,9 @@ SYM_FUNC_START(cast5_cbc_dec_16way)
 	popq %r12;
 	FRAME_END
 	ret;
-SYM_FUNC_END(cast5_cbc_dec_16way)
+SYM_FUNC_END_SECTION(cast5_cbc_dec_16way)
 
-SYM_FUNC_START(cast5_ctr_16way)
+SYM_FUNC_START_SECTION(cast5_ctr_16way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -560,4 +560,4 @@ SYM_FUNC_START(cast5_ctr_16way)
 	popq %r12;
 	FRAME_END
 	ret;
-SYM_FUNC_END(cast5_ctr_16way)
+SYM_FUNC_END_SECTION(cast5_ctr_16way)
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index fbddcecc3e3f..0da62a1c5159 100644
--- a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
@@ -244,8 +244,8 @@
 
 .text
 
+SYM_FUNC_START_LOCAL_SECTION(__cast6_enc_blk8)
 .align 8
-SYM_FUNC_START_LOCAL(__cast6_enc_blk8)
 	/* input:
 	 *	%rdi: ctx
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: blocks
@@ -290,10 +290,10 @@ SYM_FUNC_START_LOCAL(__cast6_enc_blk8)
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
 	ret;
-SYM_FUNC_END(__cast6_enc_blk8)
+SYM_FUNC_END_SECTION(__cast6_enc_blk8)
 
+SYM_FUNC_START_LOCAL_SECTION(__cast6_dec_blk8)
 .align 8
-SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 	/* input:
 	 *	%rdi: ctx
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: encrypted blocks
@@ -337,9 +337,9 @@ SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
 	ret;
-SYM_FUNC_END(__cast6_dec_blk8)
+SYM_FUNC_END_SECTION(__cast6_dec_blk8)
 
-SYM_FUNC_START(cast6_ecb_enc_8way)
+SYM_FUNC_START_SECTION(cast6_ecb_enc_8way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -360,9 +360,9 @@ SYM_FUNC_START(cast6_ecb_enc_8way)
 	popq %r15;
 	FRAME_END
 	ret;
-SYM_FUNC_END(cast6_ecb_enc_8way)
+SYM_FUNC_END_SECTION(cast6_ecb_enc_8way)
 
-SYM_FUNC_START(cast6_ecb_dec_8way)
+SYM_FUNC_START_SECTION(cast6_ecb_dec_8way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -383,9 +383,9 @@ SYM_FUNC_START(cast6_ecb_dec_8way)
 	popq %r15;
 	FRAME_END
 	ret;
-SYM_FUNC_END(cast6_ecb_dec_8way)
+SYM_FUNC_END_SECTION(cast6_ecb_dec_8way)
 
-SYM_FUNC_START(cast6_cbc_dec_8way)
+SYM_FUNC_START_SECTION(cast6_cbc_dec_8way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -409,4 +409,4 @@ SYM_FUNC_START(cast6_cbc_dec_8way)
 	popq %r12;
 	FRAME_END
 	ret;
-SYM_FUNC_END(cast6_cbc_dec_8way)
+SYM_FUNC_END_SECTION(cast6_cbc_dec_8way)
diff --git a/arch/x86/crypto/chacha-avx2-x86_64.S b/arch/x86/crypto/chacha-avx2-x86_64.S
index ee9a40ab4109..1e66a2d462c4 100644
--- a/arch/x86/crypto/chacha-avx2-x86_64.S
+++ b/arch/x86/crypto/chacha-avx2-x86_64.S
@@ -34,7 +34,7 @@ CTR4BL:	.octa 0x00000000000000000000000000000002
 
 .text
 
-SYM_FUNC_START(chacha_2block_xor_avx2)
+SYM_FUNC_START_SECTION(chacha_2block_xor_avx2)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 2 data blocks output, o
 	# %rdx: up to 2 data blocks input, i
@@ -224,9 +224,9 @@ SYM_FUNC_START(chacha_2block_xor_avx2)
 	lea		-8(%r10),%rsp
 	jmp		.Ldone2
 
-SYM_FUNC_END(chacha_2block_xor_avx2)
+SYM_FUNC_END_SECTION(chacha_2block_xor_avx2)
 
-SYM_FUNC_START(chacha_4block_xor_avx2)
+SYM_FUNC_START_SECTION(chacha_4block_xor_avx2)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 4 data blocks output, o
 	# %rdx: up to 4 data blocks input, i
@@ -529,9 +529,9 @@ SYM_FUNC_START(chacha_4block_xor_avx2)
 	lea		-8(%r10),%rsp
 	jmp		.Ldone4
 
-SYM_FUNC_END(chacha_4block_xor_avx2)
+SYM_FUNC_END_SECTION(chacha_4block_xor_avx2)
 
-SYM_FUNC_START(chacha_8block_xor_avx2)
+SYM_FUNC_START_SECTION(chacha_8block_xor_avx2)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 8 data blocks output, o
 	# %rdx: up to 8 data blocks input, i
@@ -1018,4 +1018,4 @@ SYM_FUNC_START(chacha_8block_xor_avx2)
 
 	jmp		.Ldone8
 
-SYM_FUNC_END(chacha_8block_xor_avx2)
+SYM_FUNC_END_SECTION(chacha_8block_xor_avx2)
diff --git a/arch/x86/crypto/chacha-avx512vl-x86_64.S b/arch/x86/crypto/chacha-avx512vl-x86_64.S
index bb193fde123a..da5ab2897d80 100644
--- a/arch/x86/crypto/chacha-avx512vl-x86_64.S
+++ b/arch/x86/crypto/chacha-avx512vl-x86_64.S
@@ -24,7 +24,7 @@ CTR8BL:	.octa 0x00000003000000020000000100000000
 
 .text
 
-SYM_FUNC_START(chacha_2block_xor_avx512vl)
+SYM_FUNC_START_SECTION(chacha_2block_xor_avx512vl)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 2 data blocks output, o
 	# %rdx: up to 2 data blocks input, i
@@ -187,9 +187,9 @@ SYM_FUNC_START(chacha_2block_xor_avx512vl)
 
 	jmp		.Ldone2
 
-SYM_FUNC_END(chacha_2block_xor_avx512vl)
+SYM_FUNC_END_SECTION(chacha_2block_xor_avx512vl)
 
-SYM_FUNC_START(chacha_4block_xor_avx512vl)
+SYM_FUNC_START_SECTION(chacha_4block_xor_avx512vl)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 4 data blocks output, o
 	# %rdx: up to 4 data blocks input, i
@@ -453,9 +453,9 @@ SYM_FUNC_START(chacha_4block_xor_avx512vl)
 
 	jmp		.Ldone4
 
-SYM_FUNC_END(chacha_4block_xor_avx512vl)
+SYM_FUNC_END_SECTION(chacha_4block_xor_avx512vl)
 
-SYM_FUNC_START(chacha_8block_xor_avx512vl)
+SYM_FUNC_START_SECTION(chacha_8block_xor_avx512vl)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 8 data blocks output, o
 	# %rdx: up to 8 data blocks input, i
@@ -833,4 +833,4 @@ SYM_FUNC_START(chacha_8block_xor_avx512vl)
 
 	jmp		.Ldone8
 
-SYM_FUNC_END(chacha_8block_xor_avx512vl)
+SYM_FUNC_END_SECTION(chacha_8block_xor_avx512vl)
diff --git a/arch/x86/crypto/chacha-ssse3-x86_64.S b/arch/x86/crypto/chacha-ssse3-x86_64.S
index ca1788bfee16..4c66f51dfd61 100644
--- a/arch/x86/crypto/chacha-ssse3-x86_64.S
+++ b/arch/x86/crypto/chacha-ssse3-x86_64.S
@@ -33,7 +33,7 @@ CTRINC:	.octa 0x00000003000000020000000100000000
  *
  * Clobbers: %r8d, %xmm4-%xmm7
  */
-SYM_FUNC_START_LOCAL(chacha_permute)
+SYM_FUNC_START_LOCAL_SECTION(chacha_permute)
 
 	movdqa		ROT8(%rip),%xmm4
 	movdqa		ROT16(%rip),%xmm5
@@ -109,9 +109,9 @@ SYM_FUNC_START_LOCAL(chacha_permute)
 	jnz		.Ldoubleround
 
 	ret
-SYM_FUNC_END(chacha_permute)
+SYM_FUNC_END_SECTION(chacha_permute)
 
-SYM_FUNC_START(chacha_block_xor_ssse3)
+SYM_FUNC_START_SECTION(chacha_block_xor_ssse3)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 1 data block output, o
 	# %rdx: up to 1 data block input, i
@@ -197,9 +197,9 @@ SYM_FUNC_START(chacha_block_xor_ssse3)
 	lea		-8(%r10),%rsp
 	jmp		.Ldone
 
-SYM_FUNC_END(chacha_block_xor_ssse3)
+SYM_FUNC_END_SECTION(chacha_block_xor_ssse3)
 
-SYM_FUNC_START(hchacha_block_ssse3)
+SYM_FUNC_START_SECTION(hchacha_block_ssse3)
 	# %rdi: Input state matrix, s
 	# %rsi: output (8 32-bit words)
 	# %edx: nrounds
@@ -218,9 +218,9 @@ SYM_FUNC_START(hchacha_block_ssse3)
 
 	FRAME_END
 	ret
-SYM_FUNC_END(hchacha_block_ssse3)
+SYM_FUNC_END_SECTION(hchacha_block_ssse3)
 
-SYM_FUNC_START(chacha_4block_xor_ssse3)
+SYM_FUNC_START_SECTION(chacha_4block_xor_ssse3)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 4 data blocks output, o
 	# %rdx: up to 4 data blocks input, i
@@ -788,4 +788,4 @@ SYM_FUNC_START(chacha_4block_xor_ssse3)
 
 	jmp		.Ldone4
 
-SYM_FUNC_END(chacha_4block_xor_ssse3)
+SYM_FUNC_END_SECTION(chacha_4block_xor_ssse3)
diff --git a/arch/x86/crypto/crc32-pclmul_asm.S b/arch/x86/crypto/crc32-pclmul_asm.S
index 6e7d4c4d3208..21b19a2f4556 100644
--- a/arch/x86/crypto/crc32-pclmul_asm.S
+++ b/arch/x86/crypto/crc32-pclmul_asm.S
@@ -102,7 +102,7 @@
  *	                     size_t len, uint crc32)
  */
 
-SYM_FUNC_START(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
+SYM_FUNC_START_SECTION(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
 	movdqa  (BUF), %xmm1
 	movdqa  0x10(BUF), %xmm2
 	movdqa  0x20(BUF), %xmm3
@@ -237,4 +237,4 @@ fold_64:
 	pextrd  $0x01, %xmm1, %eax
 
 	ret
-SYM_FUNC_END(crc32_pclmul_le_16)
+SYM_FUNC_END_SECTION(crc32_pclmul_le_16)
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index ac1f303eed0f..342f09adf41c 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -73,7 +73,7 @@
 # unsigned int crc_pcl(u8 *buffer, int len, unsigned int crc_init);
 
 .text
-SYM_FUNC_START(crc_pcl)
+SYM_FUNC_START_SECTION(crc_pcl)
 #define    bufp		rdi
 #define    bufp_dw	%edi
 #define    bufp_w	%di
@@ -307,7 +307,7 @@ do_return:
 	popq    %rdi
 	popq    %rbx
         ret
-SYM_FUNC_END(crc_pcl)
+SYM_FUNC_END_SECTION(crc_pcl)
 
 .section	.rodata, "a", @progbits
         ################################################################
diff --git a/arch/x86/crypto/crct10dif-pcl-asm_64.S b/arch/x86/crypto/crct10dif-pcl-asm_64.S
index b2533d63030e..b6d35088fbfc 100644
--- a/arch/x86/crypto/crct10dif-pcl-asm_64.S
+++ b/arch/x86/crypto/crct10dif-pcl-asm_64.S
@@ -94,8 +94,8 @@
 #
 # Assumes len >= 16.
 #
+SYM_FUNC_START_SECTION(crc_t10dif_pcl)
 .align 16
-SYM_FUNC_START(crc_t10dif_pcl)
 
 	movdqa	.Lbswap_mask(%rip), BSWAP_MASK
 
@@ -280,7 +280,7 @@ SYM_FUNC_START(crc_t10dif_pcl)
 	jge	.Lfold_16_bytes_loop		# 32 <= len <= 255
 	add	$16, len
 	jmp	.Lhandle_partial_segment	# 17 <= len <= 31
-SYM_FUNC_END(crc_t10dif_pcl)
+SYM_FUNC_END_SECTION(crc_t10dif_pcl)
 
 .section	.rodata, "a", @progbits
 .align 16
diff --git a/arch/x86/crypto/des3_ede-asm_64.S b/arch/x86/crypto/des3_ede-asm_64.S
index fac0fdc3f25d..116947d2e097 100644
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -162,7 +162,7 @@
 	movl   left##d,   (io); \
 	movl   right##d, 4(io);
 
-SYM_FUNC_START(des3_ede_x86_64_crypt_blk)
+SYM_FUNC_START_SECTION(des3_ede_x86_64_crypt_blk)
 	/* input:
 	 *	%rdi: round keys, CTX
 	 *	%rsi: dst
@@ -244,7 +244,7 @@ SYM_FUNC_START(des3_ede_x86_64_crypt_blk)
 	popq %rbx;
 
 	ret;
-SYM_FUNC_END(des3_ede_x86_64_crypt_blk)
+SYM_FUNC_END_SECTION(des3_ede_x86_64_crypt_blk)
 
 /***********************************************************************
  * 3-way 3DES
@@ -418,7 +418,7 @@ SYM_FUNC_END(des3_ede_x86_64_crypt_blk)
 #define __movq(src, dst) \
 	movq src, dst;
 
-SYM_FUNC_START(des3_ede_x86_64_crypt_blk_3way)
+SYM_FUNC_START_SECTION(des3_ede_x86_64_crypt_blk_3way)
 	/* input:
 	 *	%rdi: ctx, round keys
 	 *	%rsi: dst (3 blocks)
@@ -529,7 +529,7 @@ SYM_FUNC_START(des3_ede_x86_64_crypt_blk_3way)
 	popq %rbx;
 
 	ret;
-SYM_FUNC_END(des3_ede_x86_64_crypt_blk_3way)
+SYM_FUNC_END_SECTION(des3_ede_x86_64_crypt_blk_3way)
 
 .section	.rodata, "a", @progbits
 .align 16
diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 99ac25e18e09..719cb550ed7a 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -43,7 +43,7 @@
  *	T2
  *	T3
  */
-SYM_FUNC_START_LOCAL(__clmul_gf128mul_ble)
+SYM_FUNC_START_LOCAL_SECTION(__clmul_gf128mul_ble)
 	movaps DATA, T1
 	pshufd $0b01001110, DATA, T2
 	pshufd $0b01001110, SHASH, T3
@@ -86,10 +86,10 @@ SYM_FUNC_START_LOCAL(__clmul_gf128mul_ble)
 	pxor T2, T1
 	pxor T1, DATA
 	ret
-SYM_FUNC_END(__clmul_gf128mul_ble)
+SYM_FUNC_END_SECTION(__clmul_gf128mul_ble)
 
 /* void clmul_ghash_mul(char *dst, const u128 *shash) */
-SYM_FUNC_START(clmul_ghash_mul)
+SYM_FUNC_START_SECTION(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
 	movups (%rsi), SHASH
@@ -100,13 +100,13 @@ SYM_FUNC_START(clmul_ghash_mul)
 	movups DATA, (%rdi)
 	FRAME_END
 	ret
-SYM_FUNC_END(clmul_ghash_mul)
+SYM_FUNC_END_SECTION(clmul_ghash_mul)
 
 /*
  * void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
  *			   const u128 *shash);
  */
-SYM_FUNC_START(clmul_ghash_update)
+SYM_FUNC_START_SECTION(clmul_ghash_update)
 	FRAME_BEGIN
 	cmp $16, %rdx
 	jb .Lupdate_just_ret	# check length
@@ -129,4 +129,4 @@ SYM_FUNC_START(clmul_ghash_update)
 .Lupdate_just_ret:
 	FRAME_END
 	ret
-SYM_FUNC_END(clmul_ghash_update)
+SYM_FUNC_END_SECTION(clmul_ghash_update)
diff --git a/arch/x86/crypto/nh-avx2-x86_64.S b/arch/x86/crypto/nh-avx2-x86_64.S
index b22c7b936272..6df795f28706 100644
--- a/arch/x86/crypto/nh-avx2-x86_64.S
+++ b/arch/x86/crypto/nh-avx2-x86_64.S
@@ -69,7 +69,7 @@
  *
  * It's guaranteed that message_len % 16 == 0.
  */
-SYM_FUNC_START(nh_avx2)
+SYM_FUNC_START_SECTION(nh_avx2)
 
 	vmovdqu		0x00(KEY), K0
 	vmovdqu		0x10(KEY), K1
@@ -154,4 +154,4 @@ SYM_FUNC_START(nh_avx2)
 	vpaddq		T4, T0, T0
 	vmovdqu		T0, (HASH)
 	ret
-SYM_FUNC_END(nh_avx2)
+SYM_FUNC_END_SECTION(nh_avx2)
diff --git a/arch/x86/crypto/nh-sse2-x86_64.S b/arch/x86/crypto/nh-sse2-x86_64.S
index d7ae22dd6683..5113a5a081fd 100644
--- a/arch/x86/crypto/nh-sse2-x86_64.S
+++ b/arch/x86/crypto/nh-sse2-x86_64.S
@@ -71,7 +71,7 @@
  *
  * It's guaranteed that message_len % 16 == 0.
  */
-SYM_FUNC_START(nh_sse2)
+SYM_FUNC_START_SECTION(nh_sse2)
 
 	movdqu		0x00(KEY), K0
 	movdqu		0x10(KEY), K1
@@ -120,4 +120,4 @@ SYM_FUNC_START(nh_sse2)
 	movdqu		T0, 0x00(HASH)
 	movdqu		T1, 0x10(HASH)
 	ret
-SYM_FUNC_END(nh_sse2)
+SYM_FUNC_END_SECTION(nh_sse2)
diff --git a/arch/x86/crypto/poly1305-x86_64-cryptogams.pl b/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
index 71fae5a09e56..c8797e902793 100644
--- a/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
+++ b/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
@@ -108,8 +108,8 @@ if (!$kernel) {
 sub declare_function() {
 	my ($name, $align, $nargs) = @_;
 	if($kernel) {
+		$code .= "SYM_FUNC_START_SECTION($name)\n";
 		$code .= ".align $align\n";
-		$code .= "SYM_FUNC_START($name)\n";
 		$code .= ".L$name:\n";
 	} else {
 		$code .= ".globl	$name\n";
@@ -122,7 +122,7 @@ sub declare_function() {
 sub end_function() {
 	my ($name) = @_;
 	if($kernel) {
-		$code .= "SYM_FUNC_END($name)\n";
+		$code .= "SYM_FUNC_END_SECTION($name)\n";
 	} else {
 		$code .= ".size   $name,.-$name\n";
 	}
@@ -421,6 +421,7 @@ my ($H0,$H1,$H2,$H3,$H4, $T0,$T1,$T2,$T3,$T4, $D0,$D1,$D2,$D3,$D4, $MASK) =
     map("%xmm$_",(0..15));
 
 $code.=<<___;
+SYM_TEXT_SECTION(__poly1305_block)
 .type	__poly1305_block,\@abi-omnipotent
 .align	32
 __poly1305_block:
@@ -431,7 +432,9 @@ $code.=<<___;
 	pop $ctx
 	ret
 .size	__poly1305_block,.-__poly1305_block
+SYM_TEXT_END_SECTION
 
+SYM_TEXT_SECTION(__poly1305_init_avx)
 .type	__poly1305_init_avx,\@abi-omnipotent
 .align	32
 __poly1305_init_avx:
@@ -596,6 +599,7 @@ __poly1305_init_avx:
 	pop %rbp
 	ret
 .size	__poly1305_init_avx,.-__poly1305_init_avx
+SYM_TEXT_END_SECTION
 ___
 
 &declare_function("poly1305_blocks_avx", 32, 4);
diff --git a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
index b7ee24df7fba..072f26f4bc9b 100644
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -550,8 +550,8 @@
 #define write_blocks(x0, x1, x2, x3, t0, t1, t2) \
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
+SYM_FUNC_START_LOCAL_SECTION(__serpent_enc_blk8_avx)
 .align 8
-SYM_FUNC_START_LOCAL(__serpent_enc_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: blocks
@@ -602,10 +602,10 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk8_avx)
 	write_blocks(RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
 	ret;
-SYM_FUNC_END(__serpent_enc_blk8_avx)
+SYM_FUNC_END_SECTION(__serpent_enc_blk8_avx)
 
+SYM_FUNC_START_LOCAL_SECTION(__serpent_dec_blk8_avx)
 .align 8
-SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: encrypted blocks
@@ -656,9 +656,9 @@ SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	write_blocks(RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
 	ret;
-SYM_FUNC_END(__serpent_dec_blk8_avx)
+SYM_FUNC_END_SECTION(__serpent_dec_blk8_avx)
 
-SYM_FUNC_START(serpent_ecb_enc_8way_avx)
+SYM_FUNC_START_SECTION(serpent_ecb_enc_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -674,9 +674,9 @@ SYM_FUNC_START(serpent_ecb_enc_8way_avx)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(serpent_ecb_enc_8way_avx)
+SYM_FUNC_END_SECTION(serpent_ecb_enc_8way_avx)
 
-SYM_FUNC_START(serpent_ecb_dec_8way_avx)
+SYM_FUNC_START_SECTION(serpent_ecb_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -692,9 +692,9 @@ SYM_FUNC_START(serpent_ecb_dec_8way_avx)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(serpent_ecb_dec_8way_avx)
+SYM_FUNC_END_SECTION(serpent_ecb_dec_8way_avx)
 
-SYM_FUNC_START(serpent_cbc_dec_8way_avx)
+SYM_FUNC_START_SECTION(serpent_cbc_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -710,4 +710,4 @@ SYM_FUNC_START(serpent_cbc_dec_8way_avx)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(serpent_cbc_dec_8way_avx)
+SYM_FUNC_END_SECTION(serpent_cbc_dec_8way_avx)
diff --git a/arch/x86/crypto/serpent-avx2-asm_64.S b/arch/x86/crypto/serpent-avx2-asm_64.S
index 9161b6e441f3..57b25c3ab45b 100644
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -550,8 +550,8 @@
 #define write_blocks(x0, x1, x2, x3, t0, t1, t2) \
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
+SYM_FUNC_START_LOCAL_SECTION(__serpent_enc_blk16)
 .align 8
-SYM_FUNC_START_LOCAL(__serpent_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: plaintext
@@ -602,10 +602,10 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk16)
 	write_blocks(RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
 	ret;
-SYM_FUNC_END(__serpent_enc_blk16)
+SYM_FUNC_END_SECTION(__serpent_enc_blk16)
 
+SYM_FUNC_START_LOCAL_SECTION(__serpent_dec_blk16)
 .align 8
-SYM_FUNC_START_LOCAL(__serpent_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: ciphertext
@@ -656,9 +656,9 @@ SYM_FUNC_START_LOCAL(__serpent_dec_blk16)
 	write_blocks(RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
 	ret;
-SYM_FUNC_END(__serpent_dec_blk16)
+SYM_FUNC_END_SECTION(__serpent_dec_blk16)
 
-SYM_FUNC_START(serpent_ecb_enc_16way)
+SYM_FUNC_START_SECTION(serpent_ecb_enc_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -678,9 +678,9 @@ SYM_FUNC_START(serpent_ecb_enc_16way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(serpent_ecb_enc_16way)
+SYM_FUNC_END_SECTION(serpent_ecb_enc_16way)
 
-SYM_FUNC_START(serpent_ecb_dec_16way)
+SYM_FUNC_START_SECTION(serpent_ecb_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -700,9 +700,9 @@ SYM_FUNC_START(serpent_ecb_dec_16way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(serpent_ecb_dec_16way)
+SYM_FUNC_END_SECTION(serpent_ecb_dec_16way)
 
-SYM_FUNC_START(serpent_cbc_dec_16way)
+SYM_FUNC_START_SECTION(serpent_cbc_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -723,4 +723,4 @@ SYM_FUNC_START(serpent_cbc_dec_16way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(serpent_cbc_dec_16way)
+SYM_FUNC_END_SECTION(serpent_cbc_dec_16way)
diff --git a/arch/x86/crypto/serpent-sse2-i586-asm_32.S b/arch/x86/crypto/serpent-sse2-i586-asm_32.S
index 6379b99cb722..c74cfb225d81 100644
--- a/arch/x86/crypto/serpent-sse2-i586-asm_32.S
+++ b/arch/x86/crypto/serpent-sse2-i586-asm_32.S
@@ -497,7 +497,7 @@
 	pxor t0,		x3; \
 	movdqu x3,		(3*4*4)(out);
 
-SYM_FUNC_START(__serpent_enc_blk_4way)
+SYM_FUNC_START_SECTION(__serpent_enc_blk_4way)
 	/* input:
 	 *	arg_ctx(%esp): ctx, CTX
 	 *	arg_dst(%esp): dst
@@ -559,9 +559,9 @@ SYM_FUNC_START(__serpent_enc_blk_4way)
 	xor_blocks(%eax, RA, RB, RC, RD, RT0, RT1, RE);
 
 	ret;
-SYM_FUNC_END(__serpent_enc_blk_4way)
+SYM_FUNC_END_SECTION(__serpent_enc_blk_4way)
 
-SYM_FUNC_START(serpent_dec_blk_4way)
+SYM_FUNC_START_SECTION(serpent_dec_blk_4way)
 	/* input:
 	 *	arg_ctx(%esp): ctx, CTX
 	 *	arg_dst(%esp): dst
@@ -613,4 +613,4 @@ SYM_FUNC_START(serpent_dec_blk_4way)
 	write_blocks(%eax, RC, RD, RB, RE, RT0, RT1, RA);
 
 	ret;
-SYM_FUNC_END(serpent_dec_blk_4way)
+SYM_FUNC_END_SECTION(serpent_dec_blk_4way)
diff --git a/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S b/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
index efb6dc17dc90..772b3ddfe0f2 100644
--- a/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
@@ -619,7 +619,7 @@
 	pxor t0,		x3; \
 	movdqu x3,		(3*4*4)(out);
 
-SYM_FUNC_START(__serpent_enc_blk_8way)
+SYM_FUNC_START_SECTION(__serpent_enc_blk_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -682,9 +682,9 @@ SYM_FUNC_START(__serpent_enc_blk_8way)
 	xor_blocks(%rax, RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
 	ret;
-SYM_FUNC_END(__serpent_enc_blk_8way)
+SYM_FUNC_END_SECTION(__serpent_enc_blk_8way)
 
-SYM_FUNC_START(serpent_dec_blk_8way)
+SYM_FUNC_START_SECTION(serpent_dec_blk_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -736,4 +736,4 @@ SYM_FUNC_START(serpent_dec_blk_8way)
 	write_blocks(%rax, RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
 	ret;
-SYM_FUNC_END(serpent_dec_blk_8way)
+SYM_FUNC_END_SECTION(serpent_dec_blk_8way)
diff --git a/arch/x86/crypto/sha1_avx2_x86_64_asm.S b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
index 5eed620f4676..b3f2b06121f5 100644
--- a/arch/x86/crypto/sha1_avx2_x86_64_asm.S
+++ b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
@@ -634,7 +634,7 @@ _loop3:
  * param: function's name
  */
 .macro SHA1_VECTOR_ASM  name
-	SYM_FUNC_START(\name)
+	SYM_FUNC_START_SECTION(\name)
 
 	push	%rbx
 	push	%r12
@@ -676,7 +676,7 @@ _loop3:
 
 	ret
 
-	SYM_FUNC_END(\name)
+	SYM_FUNC_END_SECTION(\name)
 .endm
 
 .section .rodata
diff --git a/arch/x86/crypto/sha1_ni_asm.S b/arch/x86/crypto/sha1_ni_asm.S
index 5d8415f482bd..55fdacd4931f 100644
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@ -92,8 +92,8 @@
  * numBlocks: Number of blocks to process
  */
 .text
+SYM_FUNC_START_SECTION(sha1_ni_transform)
 .align 32
-SYM_FUNC_START(sha1_ni_transform)
 	push		%rbp
 	mov		%rsp, %rbp
 	sub		$FRAME_SIZE, %rsp
@@ -291,7 +291,7 @@ SYM_FUNC_START(sha1_ni_transform)
 	pop		%rbp
 
 	ret
-SYM_FUNC_END(sha1_ni_transform)
+SYM_FUNC_END_SECTION(sha1_ni_transform)
 
 .section	.rodata.cst16.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 16
 .align 16
diff --git a/arch/x86/crypto/sha1_ssse3_asm.S b/arch/x86/crypto/sha1_ssse3_asm.S
index d25668d2a1e9..936cba71c6ee 100644
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -67,7 +67,7 @@
  * param: function's name
  */
 .macro SHA1_VECTOR_ASM  name
-	SYM_FUNC_START(\name)
+	SYM_FUNC_START_SECTION(\name)
 
 	push	%rbx
 	push	%r12
@@ -101,7 +101,7 @@
 	pop	%rbx
 	ret
 
-	SYM_FUNC_END(\name)
+	SYM_FUNC_END_SECTION(\name)
 .endm
 
 /*
diff --git a/arch/x86/crypto/sha256-avx-asm.S b/arch/x86/crypto/sha256-avx-asm.S
index 4739cd31b9db..cfa45b4319c0 100644
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/crypto/sha256-avx-asm.S
@@ -346,7 +346,7 @@ a = TMP_
 ## arg 3 : Num blocks
 ########################################################################
 .text
-SYM_FUNC_START(sha256_transform_avx)
+SYM_FUNC_START_SECTION(sha256_transform_avx)
 .align 32
 	pushq   %rbx
 	pushq   %r12
@@ -459,7 +459,7 @@ done_hash:
 	popq	%r12
 	popq    %rbx
 	ret
-SYM_FUNC_END(sha256_transform_avx)
+SYM_FUNC_END_SECTION(sha256_transform_avx)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
 .align 64
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 4087f7432a7e..84b4f0bcc5a4 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -523,7 +523,7 @@ STACK_SIZE	= _CTX      + _CTX_SIZE
 ## arg 3 : Num blocks
 ########################################################################
 .text
-SYM_FUNC_START(sha256_transform_rorx)
+SYM_FUNC_START_SECTION(sha256_transform_rorx)
 .align 32
 	pushq	%rbx
 	pushq	%r12
@@ -711,7 +711,7 @@ done_hash:
 	popq	%r12
 	popq	%rbx
 	ret
-SYM_FUNC_END(sha256_transform_rorx)
+SYM_FUNC_END_SECTION(sha256_transform_rorx)
 
 .section	.rodata.cst512.K256, "aM", @progbits, 512
 .align 64
diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/crypto/sha256-ssse3-asm.S
index ddfa863b4ee3..cc70ae3d02c0 100644
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/crypto/sha256-ssse3-asm.S
@@ -355,7 +355,7 @@ a = TMP_
 ## arg 3 : Num blocks
 ########################################################################
 .text
-SYM_FUNC_START(sha256_transform_ssse3)
+SYM_FUNC_START_SECTION(sha256_transform_ssse3)
 .align 32
 	pushq   %rbx
 	pushq   %r12
@@ -473,7 +473,7 @@ done_hash:
 	popq    %rbx
 
 	ret
-SYM_FUNC_END(sha256_transform_ssse3)
+SYM_FUNC_END_SECTION(sha256_transform_ssse3)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
 .align 64
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index 7abade04a3a3..c4049c4a4ef7 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -96,8 +96,8 @@
  */
 
 .text
+SYM_FUNC_START_SECTION(sha256_ni_transform)
 .align 32
-SYM_FUNC_START(sha256_ni_transform)
 
 	shl		$6, NUM_BLKS		/*  convert to bytes */
 	jz		.Ldone_hash
@@ -327,7 +327,7 @@ SYM_FUNC_START(sha256_ni_transform)
 .Ldone_hash:
 
 	ret
-SYM_FUNC_END(sha256_ni_transform)
+SYM_FUNC_END_SECTION(sha256_ni_transform)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
 .align 64
diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index 3d8f0fd4eea8..ab128785d19d 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -273,7 +273,7 @@ frame_size = frame_WK + WK_SIZE
 # of SHA512 message blocks.
 # "blocks" is the message length in SHA512 blocks
 ########################################################################
-SYM_FUNC_START(sha512_transform_avx)
+SYM_FUNC_START_SECTION(sha512_transform_avx)
 	test msglen, msglen
 	je nowork
 
@@ -362,7 +362,7 @@ updateblock:
 
 nowork:
 	ret
-SYM_FUNC_END(sha512_transform_avx)
+SYM_FUNC_END_SECTION(sha512_transform_avx)
 
 ########################################################################
 ### Binary Data
diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index 072cb0f0deae..e0b2faa3eac7 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -565,7 +565,7 @@ frame_size = frame_CTX + CTX_SIZE
 # of SHA512 message blocks.
 # "blocks" is the message length in SHA512 blocks
 ########################################################################
-SYM_FUNC_START(sha512_transform_rorx)
+SYM_FUNC_START_SECTION(sha512_transform_rorx)
 	# Save GPRs
 	push	%rbx
 	push	%r12
@@ -680,7 +680,7 @@ done_hash:
 	pop	%rbx
 
 	ret
-SYM_FUNC_END(sha512_transform_rorx)
+SYM_FUNC_END_SECTION(sha512_transform_rorx)
 
 ########################################################################
 ### Binary Data
diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
index bd51c9070bed..a3d7c69b8085 100644
--- a/arch/x86/crypto/sha512-ssse3-asm.S
+++ b/arch/x86/crypto/sha512-ssse3-asm.S
@@ -274,7 +274,7 @@ frame_size = frame_WK + WK_SIZE
 # of SHA512 message blocks.
 # "blocks" is the message length in SHA512 blocks.
 ########################################################################
-SYM_FUNC_START(sha512_transform_ssse3)
+SYM_FUNC_START_SECTION(sha512_transform_ssse3)
 
 	test msglen, msglen
 	je nowork
@@ -364,7 +364,7 @@ updateblock:
 
 nowork:
 	ret
-SYM_FUNC_END(sha512_transform_ssse3)
+SYM_FUNC_END_SECTION(sha512_transform_ssse3)
 
 ########################################################################
 ### Binary Data
diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
index 1cc72b4804fa..021064aa0d2e 100644
--- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
@@ -145,8 +145,8 @@
  * void sm4_aesni_avx_crypt4(const u32 *rk, u8 *dst,
  *                           const u8 *src, int nblocks)
  */
+SYM_FUNC_START_SECTION(sm4_aesni_avx_crypt4)
 .align 8
-SYM_FUNC_START(sm4_aesni_avx_crypt4)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	%rsi: dst (1..4 blocks)
@@ -247,10 +247,10 @@ SYM_FUNC_START(sm4_aesni_avx_crypt4)
 	vzeroall;
 	FRAME_END
 	ret;
-SYM_FUNC_END(sm4_aesni_avx_crypt4)
+SYM_FUNC_END_SECTION(sm4_aesni_avx_crypt4)
 
+SYM_FUNC_START_LOCAL_SECTION(__sm4_crypt_blk8)
 .align 8
-SYM_FUNC_START_LOCAL(__sm4_crypt_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	RA0, RA1, RA2, RA3, RB0, RB1, RB2, RB3: eight parallel
@@ -357,14 +357,14 @@ SYM_FUNC_START_LOCAL(__sm4_crypt_blk8)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(__sm4_crypt_blk8)
+SYM_FUNC_END_SECTION(__sm4_crypt_blk8)
 
 /*
  * void sm4_aesni_avx_crypt8(const u32 *rk, u8 *dst,
  *                           const u8 *src, int nblocks)
  */
+SYM_FUNC_START_SECTION(sm4_aesni_avx_crypt8)
 .align 8
-SYM_FUNC_START(sm4_aesni_avx_crypt8)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	%rsi: dst (1..8 blocks)
@@ -413,14 +413,14 @@ SYM_FUNC_START(sm4_aesni_avx_crypt8)
 	vzeroall;
 	FRAME_END
 	ret;
-SYM_FUNC_END(sm4_aesni_avx_crypt8)
+SYM_FUNC_END_SECTION(sm4_aesni_avx_crypt8)
 
 /*
  * void sm4_aesni_avx_ctr_enc_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
+SYM_FUNC_START_SECTION(sm4_aesni_avx_ctr_enc_blk8)
 .align 8
-SYM_FUNC_START(sm4_aesni_avx_ctr_enc_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	%rsi: dst (8 blocks)
@@ -488,14 +488,14 @@ SYM_FUNC_START(sm4_aesni_avx_ctr_enc_blk8)
 	vzeroall;
 	FRAME_END
 	ret;
-SYM_FUNC_END(sm4_aesni_avx_ctr_enc_blk8)
+SYM_FUNC_END_SECTION(sm4_aesni_avx_ctr_enc_blk8)
 
 /*
  * void sm4_aesni_avx_cbc_dec_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
+SYM_FUNC_START_SECTION(sm4_aesni_avx_cbc_dec_blk8)
 .align 8
-SYM_FUNC_START(sm4_aesni_avx_cbc_dec_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	%rsi: dst (8 blocks)
@@ -538,14 +538,14 @@ SYM_FUNC_START(sm4_aesni_avx_cbc_dec_blk8)
 	vzeroall;
 	FRAME_END
 	ret;
-SYM_FUNC_END(sm4_aesni_avx_cbc_dec_blk8)
+SYM_FUNC_END_SECTION(sm4_aesni_avx_cbc_dec_blk8)
 
 /*
  * void sm4_aesni_avx_cfb_dec_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
+SYM_FUNC_START_SECTION(sm4_aesni_avx_cfb_dec_blk8)
 .align 8
-SYM_FUNC_START(sm4_aesni_avx_cfb_dec_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	%rsi: dst (8 blocks)
@@ -591,4 +591,4 @@ SYM_FUNC_START(sm4_aesni_avx_cfb_dec_blk8)
 	vzeroall;
 	FRAME_END
 	ret;
-SYM_FUNC_END(sm4_aesni_avx_cfb_dec_blk8)
+SYM_FUNC_END_SECTION(sm4_aesni_avx_cfb_dec_blk8)
diff --git a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
index 9c5d3f3ad45a..3cc3116815f1 100644
--- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
@@ -155,8 +155,8 @@
 .text
 .align 16
 
+SYM_FUNC_START_LOCAL_SECTION(__sm4_crypt_blk16)
 .align 8
-SYM_FUNC_START_LOCAL(__sm4_crypt_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	RA0, RA1, RA2, RA3, RB0, RB1, RB2, RB3: sixteen parallel
@@ -269,7 +269,7 @@ SYM_FUNC_START_LOCAL(__sm4_crypt_blk16)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(__sm4_crypt_blk16)
+SYM_FUNC_END_SECTION(__sm4_crypt_blk16)
 
 #define inc_le128(x, minus_one, tmp) \
 	vpcmpeqq minus_one, x, tmp;  \
@@ -281,8 +281,8 @@ SYM_FUNC_END(__sm4_crypt_blk16)
  * void sm4_aesni_avx2_ctr_enc_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
+SYM_FUNC_START_SECTION(sm4_aesni_avx2_ctr_enc_blk16)
 .align 8
-SYM_FUNC_START(sm4_aesni_avx2_ctr_enc_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	%rsi: dst (16 blocks)
@@ -388,14 +388,14 @@ SYM_FUNC_START(sm4_aesni_avx2_ctr_enc_blk16)
 	vzeroall;
 	FRAME_END
 	ret;
-SYM_FUNC_END(sm4_aesni_avx2_ctr_enc_blk16)
+SYM_FUNC_END_SECTION(sm4_aesni_avx2_ctr_enc_blk16)
 
 /*
  * void sm4_aesni_avx2_cbc_dec_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
+SYM_FUNC_START_SECTION(sm4_aesni_avx2_cbc_dec_blk16)
 .align 8
-SYM_FUNC_START(sm4_aesni_avx2_cbc_dec_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	%rsi: dst (16 blocks)
@@ -442,14 +442,14 @@ SYM_FUNC_START(sm4_aesni_avx2_cbc_dec_blk16)
 	vzeroall;
 	FRAME_END
 	ret;
-SYM_FUNC_END(sm4_aesni_avx2_cbc_dec_blk16)
+SYM_FUNC_END_SECTION(sm4_aesni_avx2_cbc_dec_blk16)
 
 /*
  * void sm4_aesni_avx2_cfb_dec_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
+SYM_FUNC_START_SECTION(sm4_aesni_avx2_cfb_dec_blk16)
 .align 8
-SYM_FUNC_START(sm4_aesni_avx2_cfb_dec_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
 	 *	%rsi: dst (16 blocks)
@@ -498,4 +498,4 @@ SYM_FUNC_START(sm4_aesni_avx2_cfb_dec_blk16)
 	vzeroall;
 	FRAME_END
 	ret;
-SYM_FUNC_END(sm4_aesni_avx2_cfb_dec_blk16)
+SYM_FUNC_END_SECTION(sm4_aesni_avx2_cfb_dec_blk16)
diff --git a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
index 37e63b3c664e..b3808a5c9003 100644
--- a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
@@ -228,8 +228,8 @@
 	vpxor		x2, wkey, x2; \
 	vpxor		x3, wkey, x3;
 
+SYM_FUNC_START_LOCAL_SECTION(__twofish_enc_blk8)
 .align 8
-SYM_FUNC_START_LOCAL(__twofish_enc_blk8)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: blocks
@@ -268,10 +268,10 @@ SYM_FUNC_START_LOCAL(__twofish_enc_blk8)
 	outunpack_blocks(RC2, RD2, RA2, RB2, RK1, RX0, RY0, RK2);
 
 	ret;
-SYM_FUNC_END(__twofish_enc_blk8)
+SYM_FUNC_END_SECTION(__twofish_enc_blk8)
 
+SYM_FUNC_START_LOCAL_SECTION(__twofish_dec_blk8)
 .align 8
-SYM_FUNC_START_LOCAL(__twofish_dec_blk8)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RC1, RD1, RA1, RB1, RC2, RD2, RA2, RB2: encrypted blocks
@@ -308,9 +308,9 @@ SYM_FUNC_START_LOCAL(__twofish_dec_blk8)
 	outunpack_blocks(RA2, RB2, RC2, RD2, RK1, RX0, RY0, RK2);
 
 	ret;
-SYM_FUNC_END(__twofish_dec_blk8)
+SYM_FUNC_END_SECTION(__twofish_dec_blk8)
 
-SYM_FUNC_START(twofish_ecb_enc_8way)
+SYM_FUNC_START_SECTION(twofish_ecb_enc_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -328,9 +328,9 @@ SYM_FUNC_START(twofish_ecb_enc_8way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(twofish_ecb_enc_8way)
+SYM_FUNC_END_SECTION(twofish_ecb_enc_8way)
 
-SYM_FUNC_START(twofish_ecb_dec_8way)
+SYM_FUNC_START_SECTION(twofish_ecb_dec_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -348,9 +348,9 @@ SYM_FUNC_START(twofish_ecb_dec_8way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(twofish_ecb_dec_8way)
+SYM_FUNC_END_SECTION(twofish_ecb_dec_8way)
 
-SYM_FUNC_START(twofish_cbc_dec_8way)
+SYM_FUNC_START_SECTION(twofish_cbc_dec_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -373,4 +373,4 @@ SYM_FUNC_START(twofish_cbc_dec_8way)
 
 	FRAME_END
 	ret;
-SYM_FUNC_END(twofish_cbc_dec_8way)
+SYM_FUNC_END_SECTION(twofish_cbc_dec_8way)
diff --git a/arch/x86/crypto/twofish-i586-asm_32.S b/arch/x86/crypto/twofish-i586-asm_32.S
index a6f09e4f2e46..cf633600ed20 100644
--- a/arch/x86/crypto/twofish-i586-asm_32.S
+++ b/arch/x86/crypto/twofish-i586-asm_32.S
@@ -207,7 +207,7 @@
 	xor	%esi,		d ## D;\
 	ror	$1,		d ## D;
 
-SYM_FUNC_START(twofish_enc_blk)
+SYM_FUNC_START_SECTION(twofish_enc_blk)
 	push	%ebp			/* save registers according to calling convention*/
 	push    %ebx
 	push    %esi
@@ -261,9 +261,9 @@ SYM_FUNC_START(twofish_enc_blk)
 	pop	%ebp
 	mov	$1,	%eax
 	ret
-SYM_FUNC_END(twofish_enc_blk)
+SYM_FUNC_END_SECTION(twofish_enc_blk)
 
-SYM_FUNC_START(twofish_dec_blk)
+SYM_FUNC_START_SECTION(twofish_dec_blk)
 	push	%ebp			/* save registers according to calling convention*/
 	push    %ebx
 	push    %esi
@@ -318,4 +318,4 @@ SYM_FUNC_START(twofish_dec_blk)
 	pop	%ebp
 	mov	$1,	%eax
 	ret
-SYM_FUNC_END(twofish_dec_blk)
+SYM_FUNC_END_SECTION(twofish_dec_blk)
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
index bca4cea757ce..1878b26473fb 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
@@ -220,7 +220,7 @@
 	rorq $32,			RAB2; \
 	outunpack3(mov, RIO, 2, RAB, 2);
 
-SYM_FUNC_START(__twofish_enc_blk_3way)
+SYM_FUNC_START_SECTION(__twofish_enc_blk_3way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -267,9 +267,9 @@ SYM_FUNC_START(__twofish_enc_blk_3way)
 	popq %r12;
 	popq %r13;
 	ret;
-SYM_FUNC_END(__twofish_enc_blk_3way)
+SYM_FUNC_END_SECTION(__twofish_enc_blk_3way)
 
-SYM_FUNC_START(twofish_dec_blk_3way)
+SYM_FUNC_START_SECTION(twofish_dec_blk_3way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -302,4 +302,4 @@ SYM_FUNC_START(twofish_dec_blk_3way)
 	popq %r12;
 	popq %r13;
 	ret;
-SYM_FUNC_END(twofish_dec_blk_3way)
+SYM_FUNC_END_SECTION(twofish_dec_blk_3way)
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64.S b/arch/x86/crypto/twofish-x86_64-asm_64.S
index d2e56232494a..87013b60e9d1 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64.S
@@ -202,7 +202,7 @@
 	xor	%r8d,		d ## D;\
 	ror	$1,		d ## D;
 
-SYM_FUNC_START(twofish_enc_blk)
+SYM_FUNC_START_SECTION(twofish_enc_blk)
 	pushq    R1
 
 	/* %rdi contains the ctx address */
@@ -253,9 +253,9 @@ SYM_FUNC_START(twofish_enc_blk)
 	popq	R1
 	movl	$1,%eax
 	ret
-SYM_FUNC_END(twofish_enc_blk)
+SYM_FUNC_END_SECTION(twofish_enc_blk)
 
-SYM_FUNC_START(twofish_dec_blk)
+SYM_FUNC_START_SECTION(twofish_dec_blk)
 	pushq    R1
 
 	/* %rdi contains the ctx address */
@@ -305,4 +305,4 @@ SYM_FUNC_START(twofish_dec_blk)
 	popq	R1
 	movl	$1,%eax
 	ret
-SYM_FUNC_END(twofish_dec_blk)
+SYM_FUNC_END_SECTION(twofish_dec_blk)
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ccb9d32768f3..0447fac4e558 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -675,8 +675,7 @@ __irqentry_text_end:
  * %eax: prev task
  * %edx: next task
  */
-.pushsection .text, "ax"
-SYM_CODE_START(__switch_to_asm)
+SYM_CODE_START_SECTION(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
 	 * This must match the order in struct inactive_task_frame
@@ -721,8 +720,7 @@ SYM_CODE_START(__switch_to_asm)
 	popl	%ebp
 
 	jmp	__switch_to
-SYM_CODE_END(__switch_to_asm)
-.popsection
+SYM_CODE_END_SECTION(__switch_to_asm)
 
 /*
  * The unwinder expects the last frame on the stack to always be at the same
@@ -731,8 +729,7 @@ SYM_CODE_END(__switch_to_asm)
  * asmlinkage function so its argument has to be pushed on the stack.  This
  * wrapper creates a proper "end of stack" frame header before the call.
  */
-.pushsection .text, "ax"
-SYM_FUNC_START(schedule_tail_wrapper)
+SYM_FUNC_START_SECTION(schedule_tail_wrapper)
 	FRAME_BEGIN
 
 	pushl	%eax
@@ -741,8 +738,7 @@ SYM_FUNC_START(schedule_tail_wrapper)
 
 	FRAME_END
 	ret
-SYM_FUNC_END(schedule_tail_wrapper)
-.popsection
+SYM_FUNC_END_SECTION(schedule_tail_wrapper)
 
 /*
  * A newly forked process directly context switches into this address.
@@ -751,8 +747,7 @@ SYM_FUNC_END(schedule_tail_wrapper)
  * ebx: kernel thread func (NULL for user thread)
  * edi: kernel thread arg
  */
-.pushsection .text, "ax"
-SYM_CODE_START(ret_from_fork)
+SYM_CODE_START_SECTION(ret_from_fork)
 	call	schedule_tail_wrapper
 
 	testl	%ebx, %ebx
@@ -774,8 +769,7 @@ SYM_CODE_START(ret_from_fork)
 	 */
 	movl	$0, PT_EAX(%esp)
 	jmp	2b
-SYM_CODE_END(ret_from_fork)
-.popsection
+SYM_CODE_END_SECTION(ret_from_fork)
 
 SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
 /*
@@ -1247,8 +1241,7 @@ SYM_CODE_START(asm_exc_nmi)
 #endif
 SYM_CODE_END(asm_exc_nmi)
 
-.pushsection .text, "ax"
-SYM_CODE_START(rewind_stack_do_exit)
+SYM_CODE_START_SECTION(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
@@ -1257,5 +1250,4 @@ SYM_CODE_START(rewind_stack_do_exit)
 
 	call	do_exit
 1:	jmp 1b
-SYM_CODE_END(rewind_stack_do_exit)
-.popsection
+SYM_CODE_END_SECTION(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..815e9f979467 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -221,8 +221,7 @@ SYM_CODE_END(entry_SYSCALL_64)
  * %rdi: prev task
  * %rsi: next task
  */
-.pushsection .text, "ax"
-SYM_FUNC_START(__switch_to_asm)
+SYM_FUNC_START_SECTION(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
 	 * This must match the order in inactive_task_frame
@@ -263,8 +262,7 @@ SYM_FUNC_START(__switch_to_asm)
 	popq	%rbp
 
 	jmp	__switch_to
-SYM_FUNC_END(__switch_to_asm)
-.popsection
+SYM_FUNC_END_SECTION(__switch_to_asm)
 
 /*
  * A newly forked process directly context switches into this address.
@@ -273,8 +271,7 @@ SYM_FUNC_END(__switch_to_asm)
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
  */
-.pushsection .text, "ax"
-SYM_CODE_START(ret_from_fork)
+SYM_CODE_START_SECTION(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
@@ -300,8 +297,7 @@ SYM_CODE_START(ret_from_fork)
 	 */
 	movq	$0, RAX(%rsp)
 	jmp	2b
-SYM_CODE_END(ret_from_fork)
-.popsection
+SYM_CODE_END_SECTION(ret_from_fork)
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
@@ -1428,8 +1424,7 @@ SYM_CODE_START(ignore_sysret)
 SYM_CODE_END(ignore_sysret)
 #endif
 
-.pushsection .text, "ax"
-SYM_CODE_START(rewind_stack_do_exit)
+SYM_CODE_START_SECTION(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
@@ -1439,5 +1434,4 @@ SYM_CODE_START(rewind_stack_do_exit)
 	UNWIND_HINT_REGS
 
 	call	do_exit
-SYM_CODE_END(rewind_stack_do_exit)
-.popsection
+SYM_CODE_END_SECTION(rewind_stack_do_exit)
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index f1f96d4d8cd6..0149feb5d7a4 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -10,7 +10,7 @@
 
 	/* put return address in eax (arg1) */
 	.macro THUNK name, func, put_ret_addr_in_eax=0
-SYM_CODE_START_NOALIGN(\name)
+SYM_CODE_START_NOALIGN_SECTION(\name)
 	pushl %eax
 	pushl %ecx
 	pushl %edx
@@ -26,7 +26,7 @@ SYM_CODE_START_NOALIGN(\name)
 	popl %eax
 	ret
 	_ASM_NOKPROBE(\name)
-SYM_CODE_END(\name)
+SYM_CODE_END_SECTION(\name)
 	.endm
 
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 496b11ec469d..04c495e06020 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -11,7 +11,7 @@
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func
-SYM_FUNC_START_NOALIGN(\name)
+SYM_FUNC_START_NOALIGN_SECTION(\name)
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -27,7 +27,7 @@ SYM_FUNC_START_NOALIGN(\name)
 
 	call \func
 	jmp  __thunk_restore
-SYM_FUNC_END(\name)
+SYM_FUNC_END_SECTION(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
@@ -39,7 +39,7 @@ SYM_FUNC_END(\name)
 #endif
 
 #ifdef CONFIG_PREEMPTION
-SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
+SYM_CODE_START_LOCAL_NOALIGN_SECTION(__thunk_restore)
 	popq %r11
 	popq %r10
 	popq %r9
@@ -52,5 +52,5 @@ SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %rbp
 	ret
 	_ASM_NOKPROBE(__thunk_restore)
-SYM_CODE_END(__thunk_restore)
+SYM_CODE_END_SECTION(__thunk_restore)
 #endif
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 21c4a694ca11..9c16fa753b46 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -675,8 +675,9 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
 
-#define PV_CALLEE_SAVE_REGS_THUNK(func)			\
-	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
+#define PV_CALLEE_SAVE_REGS_THUNK(func)					\
+	__PV_CALLEE_SAVE_REGS_THUNK(func,				\
+				    ASM_TEXT_SECTION(__raw_callee_save_##func))
 
 /* Get a reference to a callee-save function */
 #define PV_CALLEE_SAVE(func)						\
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 159622ee0674..29558fff2453 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -34,7 +34,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
  *   rsi = lockval           (second argument)
  *   rdx = internal variable (set to 0)
  */
-asm    (".pushsection .text;"
+asm    (ASM_PUSH_SECTION(__raw_callee_save___pv_queued_spin_unlock) ";"
 	".globl " PV_UNLOCK ";"
 	".type " PV_UNLOCK ", @function;"
 	".align 4,0x90;"
diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index daf88f8143c5..4553c09bb891 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -7,9 +7,9 @@
 # Copyright 2003, 2008 Pavel Machek <pavel@suse.cz
 
 	.code32
+SYM_CODE_START_SECTION(wakeup_pmode_return)
 	ALIGN
 
-SYM_CODE_START(wakeup_pmode_return)
 	movw	$__KERNEL_DS, %ax
 	movw	%ax, %ss
 	movw	%ax, %fs
@@ -42,9 +42,9 @@ SYM_CODE_END(wakeup_pmode_return)
 
 bogus_magic:
 	jmp	bogus_magic
+SYM_TEXT_END_SECTION
 
-
-
+SYM_TEXT_SECTION(do_suspend_lowlevel)
 save_registers:
 	sidt	saved_idt
 	sldt	saved_ldt
@@ -87,7 +87,7 @@ ret_point:
 	call	restore_registers
 	call	restore_processor_state
 	ret
-SYM_CODE_END(do_suspend_lowlevel)
+SYM_CODE_END_SECTION(do_suspend_lowlevel)
 
 .data
 ALIGN
@@ -98,4 +98,3 @@ saved_eip:		.long 0
 saved_idt:	.long	0,0
 saved_ldt:	.long	0
 saved_tss:	.long	0
-
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index d5d8a352eafa..0a0e42e45d7a 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -16,7 +16,7 @@
 	/*
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
-SYM_FUNC_START(wakeup_long64)
+SYM_FUNC_START_SECTION(wakeup_long64)
 	movq	saved_magic, %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
@@ -28,7 +28,7 @@ SYM_FUNC_START(wakeup_long64)
 	jmp 1b
 2:
 	movw	$__KERNEL_DS, %ax
-	movw	%ax, %ss	
+	movw	%ax, %ss
 	movw	%ax, %ds
 	movw	%ax, %es
 	movw	%ax, %fs
@@ -43,9 +43,9 @@ SYM_FUNC_START(wakeup_long64)
 	movq	saved_rip, %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
-SYM_FUNC_END(wakeup_long64)
+SYM_FUNC_END_SECTION(wakeup_long64)
 
-SYM_FUNC_START(do_suspend_lowlevel)
+SYM_FUNC_START_SECTION(do_suspend_lowlevel)
 	FRAME_BEGIN
 	subq	$8, %rsp
 	xorl	%eax, %eax
@@ -128,7 +128,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	addq	$8, %rsp
 	FRAME_END
 	jmp	restore_processor_state
-SYM_FUNC_END(do_suspend_lowlevel)
+SYM_FUNC_END_SECTION(do_suspend_lowlevel)
 STACK_FRAME_NON_STANDARD do_suspend_lowlevel
 
 .data
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index e405fe1a8bf4..f79b2f436fde 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -18,13 +18,12 @@
 # define MCOUNT_FRAME			0	/* using frame = false */
 #endif
 
-SYM_FUNC_START(__fentry__)
+SYM_FUNC_START_SECTION(__fentry__)
 	ret
-SYM_FUNC_END(__fentry__)
+SYM_FUNC_END_SECTION(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 
-SYM_CODE_START(ftrace_caller)
-
+SYM_CODE_START_SECTION(ftrace_caller)
 #ifdef CONFIG_FRAME_POINTER
 	/*
 	 * Frame pointers are of ip followed by bp.
@@ -85,9 +84,9 @@ ftrace_graph_call:
 /* This is weak to keep gas from relaxing the jumps */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	ret
-SYM_CODE_END(ftrace_caller)
+SYM_CODE_END_SECTION(ftrace_caller)
 
-SYM_CODE_START(ftrace_regs_caller)
+SYM_CODE_START_SECTION(ftrace_regs_caller)
 	/*
 	 * We're here from an mcount/fentry CALL, and the stack frame looks like:
 	 *
@@ -161,10 +160,10 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	popl	%eax
 
 	jmp	.Lftrace_ret
-SYM_CODE_END(ftrace_regs_caller)
+SYM_CODE_END_SECTION(ftrace_regs_caller)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_CODE_START(ftrace_graph_caller)
+SYM_CODE_START_SECTION(ftrace_graph_caller)
 	pushl	%eax
 	pushl	%ecx
 	pushl	%edx
@@ -178,8 +177,9 @@ SYM_CODE_START(ftrace_graph_caller)
 	popl	%ecx
 	popl	%eax
 	ret
-SYM_CODE_END(ftrace_graph_caller)
+SYM_CODE_END_SECTION(ftrace_graph_caller)
 
+SYM_TEXT_SECTION(return_to_handler)
 .globl return_to_handler
 return_to_handler:
 	pushl	%eax
@@ -190,4 +190,5 @@ return_to_handler:
 	popl	%edx
 	popl	%eax
 	JMP_NOSPEC ecx
+SYM_TEXT_END_SECTION
 #endif
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 7a879901f103..703b6abc4948 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -131,12 +131,12 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-SYM_FUNC_START(__fentry__)
+SYM_FUNC_START_SECTION(__fentry__)
 	retq
-SYM_FUNC_END(__fentry__)
+SYM_FUNC_END_SECTION(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 
-SYM_FUNC_START(ftrace_caller)
+SYM_FUNC_START_SECTION(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
@@ -171,9 +171,9 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 
 	jmp ftrace_epilogue
-SYM_FUNC_END(ftrace_caller);
+SYM_FUNC_END_SECTION(ftrace_caller)
 
-SYM_FUNC_START(ftrace_epilogue)
+SYM_FUNC_START_SECTION(ftrace_epilogue)
 /*
  * This is weak to keep gas from relaxing the jumps.
  * It is also used to copy the retq for trampolines.
@@ -181,9 +181,9 @@ SYM_FUNC_START(ftrace_epilogue)
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	UNWIND_HINT_FUNC
 	retq
-SYM_FUNC_END(ftrace_epilogue)
+SYM_FUNC_END_SECTION(ftrace_epilogue)
 
-SYM_FUNC_START(ftrace_regs_caller)
+SYM_FUNC_START_SECTION(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
@@ -274,12 +274,12 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	UNWIND_HINT_FUNC
 	jmp	ftrace_epilogue
 
-SYM_FUNC_END(ftrace_regs_caller)
+SYM_FUNC_END_SECTION(ftrace_regs_caller)
 
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
-SYM_FUNC_START(__fentry__)
+SYM_FUNC_START_SECTION(__fentry__)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -301,12 +301,12 @@ trace:
 	restore_mcount_regs
 
 	jmp ftrace_stub
-SYM_FUNC_END(__fentry__)
+SYM_FUNC_END_SECTION(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_FUNC_START(return_to_handler)
+SYM_FUNC_START_SECTION(return_to_handler)
 	subq  $24, %rsp
 
 	/* Save the return values */
@@ -321,5 +321,5 @@ SYM_FUNC_START(return_to_handler)
 	movq (%rsp), %rax
 	addq $24, %rsp
 	JMP_NOSPEC rdi
-SYM_FUNC_END(return_to_handler)
+SYM_FUNC_END_SECTION(return_to_handler)
 #endif
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index fce99e249d61..f7b044ecd449 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1018,7 +1018,7 @@ NOKPROBE_SYMBOL(kprobe_int3_handler);
  * calls trampoline_handler() runs, which calls the kretprobe's handler.
  */
 asm(
-	".text\n"
+	ASM_PUSH_SECTION(__kretprobe_trampoline) "\n"
 	".global __kretprobe_trampoline\n"
 	".type __kretprobe_trampoline, @function\n"
 	"__kretprobe_trampoline:\n"
@@ -1053,6 +1053,7 @@ asm(
 #endif
 	"	ret\n"
 	".size __kretprobe_trampoline, .-__kretprobe_trampoline\n"
+	".popsection\n"
 );
 NOKPROBE_SYMBOL(__kretprobe_trampoline);
 /*
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 59abbdad7729..6119c4d8807c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1020,7 +1020,7 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
  * restoring to/from the stack.
  */
 asm(
-".pushsection .text;"
+ASM_PUSH_SECTION(__raw_callee_save___kvm_vcpu_is_preempted) ";"
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
 "__raw_callee_save___kvm_vcpu_is_preempted:"
diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index f469153eca8a..541f28254fa4 100644
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -35,6 +35,7 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x1c)
 
 	.text
+SYM_TEXT_SECTION(kexec_control_code)
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save the CPU context, used for jumping back */
 
@@ -276,3 +277,4 @@ SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel
+SYM_TEXT_END_SECTION
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c8fe74a28143..3f68fb738385 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -38,6 +38,7 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
 
 	.text
+SYM_TEXT_SECTION(kexec_control_code)
 	.align PAGE_SIZE
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
@@ -293,3 +294,4 @@ SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel
+SYM_TEXT_END_SECTION
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 28b1a4e57827..9000242f23b4 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -323,7 +323,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 
 #define FOP_START(op) \
 	extern void em_##op(struct fastop *fake); \
-	asm(".pushsection .text, \"ax\" \n\t" \
+	asm(ASM_PUSH_SECTION(em_##op) "\n\t" \
 	    ".global em_" #op " \n\t" \
 	    ".align " __stringify(FASTOP_SIZE) " \n\t" \
 	    "em_" #op ":\n\t"
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 3a6461694fc2..06f4f77d9ca5 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -246,7 +246,7 @@ SYM_FUNC_END(__vmx_vcpu_run)
  * Save and restore volatile registers across a call to vmread_error().  Note,
  * all parameters are passed on the stack.
  */
-SYM_FUNC_START(vmread_error_trampoline)
+SYM_FUNC_START_SECTION(vmread_error_trampoline)
 	push %_ASM_BP
 	mov  %_ASM_SP, %_ASM_BP
 
@@ -294,9 +294,9 @@ SYM_FUNC_START(vmread_error_trampoline)
 	pop %_ASM_BP
 
 	ret
-SYM_FUNC_END(vmread_error_trampoline)
+SYM_FUNC_END_SECTION(vmread_error_trampoline)
 
-SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
+SYM_FUNC_START_SECTION(vmx_do_interrupt_nmi_irqoff)
 	/*
 	 * Unconditionally create a stack frame, getting the correct RSP on the
 	 * stack (for x86-64) would take two instructions anyways, and RBP can
@@ -327,4 +327,4 @@ SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
 	mov %_ASM_BP, %_ASM_SP
 	pop %_ASM_BP
 	ret
-SYM_FUNC_END(vmx_do_interrupt_nmi_irqoff)
+SYM_FUNC_END_SECTION(vmx_do_interrupt_nmi_irqoff)
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index c4c7dd115953..64e0e5c3528d 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -13,15 +13,15 @@
  * Zero a page.
  * %rdi	- page
  */
-SYM_FUNC_START(clear_page_rep)
+SYM_FUNC_START_SECTION(clear_page_rep)
 	movl $4096/8,%ecx
 	xorl %eax,%eax
 	rep stosq
 	ret
-SYM_FUNC_END(clear_page_rep)
+SYM_FUNC_END_SECTION(clear_page_rep)
 EXPORT_SYMBOL_GPL(clear_page_rep)
 
-SYM_FUNC_START(clear_page_orig)
+SYM_FUNC_START_SECTION(clear_page_orig)
 	xorl   %eax,%eax
 	movl   $4096/64,%ecx
 	.p2align 4
@@ -40,13 +40,13 @@ SYM_FUNC_START(clear_page_orig)
 	jnz	.Lloop
 	nop
 	ret
-SYM_FUNC_END(clear_page_orig)
+SYM_FUNC_END_SECTION(clear_page_orig)
 EXPORT_SYMBOL_GPL(clear_page_orig)
 
-SYM_FUNC_START(clear_page_erms)
+SYM_FUNC_START_SECTION(clear_page_erms)
 	movl $4096,%ecx
 	xorl %eax,%eax
 	rep stosb
 	ret
-SYM_FUNC_END(clear_page_erms)
+SYM_FUNC_END_SECTION(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu.S
index 3542502faa3b..0ee7b541f39e 100644
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -13,7 +13,7 @@
  * %rcx : high 64 bits of new value
  * %al  : Operation successful
  */
-SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
+SYM_FUNC_START_SECTION(this_cpu_cmpxchg16b_emu)
 
 #
 # Emulate 'cmpxchg16b %gs:(%rsi)' except we return the result in %al not
@@ -44,4 +44,4 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 	xor %al,%al
 	ret
 
-SYM_FUNC_END(this_cpu_cmpxchg16b_emu)
+SYM_FUNC_END_SECTION(this_cpu_cmpxchg16b_emu)
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index 7334055157ba..aeea772b5d5f 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -17,7 +17,7 @@
  * boundary. The non-fragile version is equivalent to memcpy()
  * regardless of CPU machine-check-recovery capability.
  */
-SYM_FUNC_START(copy_mc_fragile)
+SYM_FUNC_START_SECTION(copy_mc_fragile)
 	cmpl $8, %edx
 	/* Less than 8 bytes? Go to byte copy loop */
 	jb .L_no_whole_words
@@ -78,7 +78,7 @@ SYM_FUNC_START(copy_mc_fragile)
 	xorl %eax, %eax
 .L_done:
 	ret
-SYM_FUNC_END(copy_mc_fragile)
+SYM_FUNC_END_SECTION(copy_mc_fragile)
 
 	.section .fixup, "ax"
 	/*
@@ -125,7 +125,7 @@ SYM_FUNC_END(copy_mc_fragile)
  * machine check recovery support this version should be no slower than
  * standard memcpy.
  */
-SYM_FUNC_START(copy_mc_enhanced_fast_string)
+SYM_FUNC_START_SECTION(copy_mc_enhanced_fast_string)
 	movq %rdi, %rax
 	movq %rdx, %rcx
 .L_copy:
@@ -133,7 +133,7 @@ SYM_FUNC_START(copy_mc_enhanced_fast_string)
 	/* Copy successful. Return zero */
 	xorl %eax, %eax
 	ret
-SYM_FUNC_END(copy_mc_enhanced_fast_string)
+SYM_FUNC_END_SECTION(copy_mc_enhanced_fast_string)
 
 	.section .fixup, "ax"
 .E_copy:
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index db4b4f9197c7..f212b9dfd469 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -12,6 +12,8 @@
  * copy unless the CPU indicates X86_FEATURE_REP_GOOD. Could vary the
  * prefetch distance based on SMP/UP.
  */
+
+SYM_TEXT_SECTION(copy_page)
 	ALIGN
 SYM_FUNC_START(copy_page)
 	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
@@ -19,9 +21,10 @@ SYM_FUNC_START(copy_page)
 	rep	movsq
 	ret
 SYM_FUNC_END(copy_page)
+SYM_TEXT_END_SECTION
 EXPORT_SYMBOL(copy_page)
 
-SYM_FUNC_START_LOCAL(copy_page_regs)
+SYM_FUNC_START_LOCAL_SECTION(copy_page_regs)
 	subq	$2*8,	%rsp
 	movq	%rbx,	(%rsp)
 	movq	%r12,	1*8(%rsp)
@@ -86,4 +89,4 @@ SYM_FUNC_START_LOCAL(copy_page_regs)
 	movq	1*8(%rsp), %r12
 	addq	$2*8, %rsp
 	ret
-SYM_FUNC_END(copy_page_regs)
+SYM_FUNC_END_SECTION(copy_page_regs)
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 2797e630b9b1..dbd9382e54d8 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -54,7 +54,7 @@
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-SYM_FUNC_START(copy_user_generic_unrolled)
+SYM_FUNC_START_SECTION(copy_user_generic_unrolled)
 	ASM_STAC
 	cmpl $8,%edx
 	jb 20f		/* less then 8 bytes, go to byte copy loop */
@@ -137,7 +137,7 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 	_ASM_EXTABLE_CPY(19b, 40b)
 	_ASM_EXTABLE_CPY(21b, 50b)
 	_ASM_EXTABLE_CPY(22b, 50b)
-SYM_FUNC_END(copy_user_generic_unrolled)
+SYM_FUNC_END_SECTION(copy_user_generic_unrolled)
 EXPORT_SYMBOL(copy_user_generic_unrolled)
 
 /* Some CPUs run faster using the string copy instructions.
@@ -158,7 +158,7 @@ EXPORT_SYMBOL(copy_user_generic_unrolled)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-SYM_FUNC_START(copy_user_generic_string)
+SYM_FUNC_START_SECTION(copy_user_generic_string)
 	ASM_STAC
 	cmpl $8,%edx
 	jb 2f		/* less than 8 bytes, go to byte copy loop */
@@ -183,7 +183,7 @@ SYM_FUNC_START(copy_user_generic_string)
 
 	_ASM_EXTABLE_CPY(1b, 11b)
 	_ASM_EXTABLE_CPY(3b, 12b)
-SYM_FUNC_END(copy_user_generic_string)
+SYM_FUNC_END_SECTION(copy_user_generic_string)
 EXPORT_SYMBOL(copy_user_generic_string)
 
 /*
@@ -198,7 +198,7 @@ EXPORT_SYMBOL(copy_user_generic_string)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-SYM_FUNC_START(copy_user_enhanced_fast_string)
+SYM_FUNC_START_SECTION(copy_user_enhanced_fast_string)
 	ASM_STAC
 	cmpl $64,%edx
 	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
@@ -215,7 +215,7 @@ SYM_FUNC_START(copy_user_enhanced_fast_string)
 	.previous
 
 	_ASM_EXTABLE_CPY(1b, 12b)
-SYM_FUNC_END(copy_user_enhanced_fast_string)
+SYM_FUNC_END_SECTION(copy_user_enhanced_fast_string)
 EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
 /*
@@ -232,6 +232,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
+SYM_TEXT_SECTION(copy_user_handle_tail)
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	movl %edx,%ecx
 1:	rep movsb
@@ -241,6 +242,7 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
+SYM_TEXT_END_SECTION
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
@@ -251,7 +253,7 @@ SYM_CODE_END(.Lcopy_user_handle_tail)
  *  - Require 8-byte alignment when size is 8 bytes or larger.
  *  - Require 4-byte alignment when size is 4 bytes.
  */
-SYM_FUNC_START(__copy_user_nocache)
+SYM_FUNC_START_SECTION(__copy_user_nocache)
 	ASM_STAC
 
 	/* If size is less than 8 bytes, go to 4-byte copy */
@@ -390,5 +392,5 @@ SYM_FUNC_START(__copy_user_nocache)
 	_ASM_EXTABLE_CPY(31b, .L_fixup_4b_copy)
 	_ASM_EXTABLE_CPY(40b, .L_fixup_1b_copy)
 	_ASM_EXTABLE_CPY(41b, .L_fixup_1b_copy)
-SYM_FUNC_END(__copy_user_nocache)
+SYM_FUNC_END_SECTION(__copy_user_nocache)
 EXPORT_SYMBOL(__copy_user_nocache)
diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index 1fbd8ee9642d..051e043df32a 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -36,7 +36,7 @@
 	_ASM_EXTABLE_UA(20b, .Lfault)
 	.endm
 
-SYM_FUNC_START(csum_partial_copy_generic)
+SYM_FUNC_START_SECTION(csum_partial_copy_generic)
 	subq  $5*8, %rsp
 	movq  %rbx, 0*8(%rsp)
 	movq  %r12, 1*8(%rsp)
@@ -253,4 +253,4 @@ SYM_FUNC_START(csum_partial_copy_generic)
 .Lfault:
 	xorl %eax, %eax
 	jmp  .Lout
-SYM_FUNC_END(csum_partial_copy_generic)
+SYM_FUNC_END_SECTION(csum_partial_copy_generic)
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index be5b5fb1598b..eddc8ab73a98 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -6,12 +6,13 @@
 asmlinkage void just_return_func(void);
 
 asm(
-	".text\n"
+	ASM_PUSH_SECTION(just_return_func) "\n"
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
 	"just_return_func:\n"
 	"	ret\n"
 	".size just_return_func, .-just_return_func\n"
+	".popsection\n"
 );
 
 void override_function_with_return(struct pt_regs *regs)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index fa1bc2104b32..d8a98dbcb310 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -47,7 +47,7 @@
 #endif
 
 	.text
-SYM_FUNC_START(__get_user_1)
+SYM_FUNC_START_SECTION(__get_user_1)
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
@@ -58,10 +58,10 @@ SYM_FUNC_START(__get_user_1)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__get_user_1)
+SYM_FUNC_END_SECTION(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
-SYM_FUNC_START(__get_user_2)
+SYM_FUNC_START_SECTION(__get_user_2)
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
@@ -72,10 +72,10 @@ SYM_FUNC_START(__get_user_2)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__get_user_2)
+SYM_FUNC_END_SECTION(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
-SYM_FUNC_START(__get_user_4)
+SYM_FUNC_START_SECTION(__get_user_4)
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
@@ -86,10 +86,10 @@ SYM_FUNC_START(__get_user_4)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__get_user_4)
+SYM_FUNC_END_SECTION(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
-SYM_FUNC_START(__get_user_8)
+SYM_FUNC_START_SECTION(__get_user_8)
 #ifdef CONFIG_X86_64
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_DX,%_ASM_AX
@@ -114,41 +114,41 @@ SYM_FUNC_START(__get_user_8)
 	ASM_CLAC
 	ret
 #endif
-SYM_FUNC_END(__get_user_8)
+SYM_FUNC_END_SECTION(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
 /* .. and the same for __get_user, just without the range checks */
-SYM_FUNC_START(__get_user_nocheck_1)
+SYM_FUNC_START_SECTION(__get_user_nocheck_1)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 6:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__get_user_nocheck_1)
+SYM_FUNC_END_SECTION(__get_user_nocheck_1)
 EXPORT_SYMBOL(__get_user_nocheck_1)
 
-SYM_FUNC_START(__get_user_nocheck_2)
+SYM_FUNC_START_SECTION(__get_user_nocheck_2)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 7:	movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__get_user_nocheck_2)
+SYM_FUNC_END_SECTION(__get_user_nocheck_2)
 EXPORT_SYMBOL(__get_user_nocheck_2)
 
-SYM_FUNC_START(__get_user_nocheck_4)
+SYM_FUNC_START_SECTION(__get_user_nocheck_4)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 8:	movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__get_user_nocheck_4)
+SYM_FUNC_END_SECTION(__get_user_nocheck_4)
 EXPORT_SYMBOL(__get_user_nocheck_4)
 
-SYM_FUNC_START(__get_user_nocheck_8)
+SYM_FUNC_START_SECTION(__get_user_nocheck_8)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 #ifdef CONFIG_X86_64
@@ -160,10 +160,10 @@ SYM_FUNC_START(__get_user_nocheck_8)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__get_user_nocheck_8)
+SYM_FUNC_END_SECTION(__get_user_nocheck_8)
 EXPORT_SYMBOL(__get_user_nocheck_8)
 
-
+SYM_TEXT_SECTION(bad_get_user)
 SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
 	ASM_CLAC
 bad_get_user:
@@ -171,8 +171,10 @@ bad_get_user:
 	mov $(-EFAULT),%_ASM_AX
 	ret
 SYM_CODE_END(.Lbad_get_user_clac)
+SYM_TEXT_END_SECTION
 
 #ifdef CONFIG_X86_32
+SYM_TEXT_SECTION(bad_get_user_8)
 SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
 	ASM_CLAC
 bad_get_user_8:
@@ -181,6 +183,7 @@ bad_get_user_8:
 	mov $(-EFAULT),%_ASM_AX
 	ret
 SYM_CODE_END(.Lbad_get_user_8_clac)
+SYM_TEXT_END_SECTION
 #endif
 
 /* get_user */
diff --git a/arch/x86/lib/hweight.S b/arch/x86/lib/hweight.S
index dbf8cc97b7f5..679afb4ccee0 100644
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -8,8 +8,7 @@
  * unsigned int __sw_hweight32(unsigned int w)
  * %rdi: w
  */
-SYM_FUNC_START(__sw_hweight32)
-
+SYM_FUNC_START_SECTION(__sw_hweight32)
 #ifdef CONFIG_X86_64
 	movl %edi, %eax				# w
 #endif
@@ -33,10 +32,10 @@ SYM_FUNC_START(__sw_hweight32)
 	shrl $24, %eax				# w = w_tmp >> 24
 	__ASM_SIZE(pop,) %__ASM_REG(dx)
 	ret
-SYM_FUNC_END(__sw_hweight32)
+SYM_FUNC_END_SECTION(__sw_hweight32)
 EXPORT_SYMBOL(__sw_hweight32)
 
-SYM_FUNC_START(__sw_hweight64)
+SYM_FUNC_START_SECTION(__sw_hweight64)
 #ifdef CONFIG_X86_64
 	pushq   %rdi
 	pushq   %rdx
@@ -79,5 +78,5 @@ SYM_FUNC_START(__sw_hweight64)
 	popl    %ecx
 	ret
 #endif
-SYM_FUNC_END(__sw_hweight64)
+SYM_FUNC_END_SECTION(__sw_hweight64)
 EXPORT_SYMBOL(__sw_hweight64)
diff --git a/arch/x86/lib/iomap_copy_64.S b/arch/x86/lib/iomap_copy_64.S
index cb5a1964506b..0b96616a6f13 100644
--- a/arch/x86/lib/iomap_copy_64.S
+++ b/arch/x86/lib/iomap_copy_64.S
@@ -8,8 +8,8 @@
 /*
  * override generic version in lib/iomap_copy.c
  */
-SYM_FUNC_START(__iowrite32_copy)
+SYM_FUNC_START_SECTION(__iowrite32_copy)
 	movl %edx,%ecx
 	rep movsd
 	ret
-SYM_FUNC_END(__iowrite32_copy)
+SYM_FUNC_END_SECTION(__iowrite32_copy)
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 64801010d312..ae41caf90afd 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -24,7 +24,7 @@
  * Output:
  * rax: dest
  */
-SYM_FUNC_START_WEAK(memmove)
+SYM_FUNC_START_WEAK_SECTION(memmove)
 SYM_FUNC_START(__memmove)
 
 	mov %rdi, %rax
@@ -207,6 +207,6 @@ SYM_FUNC_START(__memmove)
 13:
 	retq
 SYM_FUNC_END(__memmove)
-SYM_FUNC_END_ALIAS(memmove)
+SYM_FUNC_END_ALIAS_SECTION(memmove)
 EXPORT_SYMBOL(__memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9827ae267f96..466e943d363f 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -17,7 +17,7 @@
  *
  * rax   original destination
  */
-SYM_FUNC_START_WEAK(memset)
+SYM_FUNC_START_WEAK_SECTION(memset)
 SYM_FUNC_START(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
@@ -42,7 +42,7 @@ SYM_FUNC_START(__memset)
 	movq %r9,%rax
 	ret
 SYM_FUNC_END(__memset)
-SYM_FUNC_END_ALIAS(memset)
+SYM_FUNC_END_ALIAS_SECTION(memset)
 EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(__memset)
 
@@ -57,16 +57,16 @@ EXPORT_SYMBOL(__memset)
  *
  * rax   original destination
  */
-SYM_FUNC_START_LOCAL(memset_erms)
+SYM_FUNC_START_LOCAL_SECTION(memset_erms)
 	movq %rdi,%r9
 	movb %sil,%al
 	movq %rdx,%rcx
 	rep stosb
 	movq %r9,%rax
 	ret
-SYM_FUNC_END(memset_erms)
+SYM_FUNC_END_SECTION(memset_erms)
 
-SYM_FUNC_START_LOCAL(memset_orig)
+SYM_FUNC_START_LOCAL_SECTION(memset_orig)
 	movq %rdi,%r10
 
 	/* expand byte value  */
@@ -137,4 +137,4 @@ SYM_FUNC_START_LOCAL(memset_orig)
 	subq %r8,%rdx
 	jmp .Lafter_bad_alignment
 .Lfinal:
-SYM_FUNC_END(memset_orig)
+SYM_FUNC_END_SECTION(memset_orig)
diff --git a/arch/x86/lib/msr-reg.S b/arch/x86/lib/msr-reg.S
index a2b9caa5274c..7e17eba68445 100644
--- a/arch/x86/lib/msr-reg.S
+++ b/arch/x86/lib/msr-reg.S
@@ -12,7 +12,7 @@
  *
  */
 .macro op_safe_regs op
-SYM_FUNC_START(\op\()_safe_regs)
+SYM_FUNC_START_SECTION(\op\()_safe_regs)
 	pushq %rbx
 	pushq %r12
 	movq	%rdi, %r10	/* Save pointer */
@@ -41,13 +41,13 @@ SYM_FUNC_START(\op\()_safe_regs)
 	jmp     2b
 
 	_ASM_EXTABLE(1b, 3b)
-SYM_FUNC_END(\op\()_safe_regs)
+SYM_FUNC_END_SECTION(\op\()_safe_regs)
 .endm
 
 #else /* X86_32 */
 
 .macro op_safe_regs op
-SYM_FUNC_START(\op\()_safe_regs)
+SYM_FUNC_START_SECTION(\op\()_safe_regs)
 	pushl %ebx
 	pushl %ebp
 	pushl %esi
@@ -83,7 +83,7 @@ SYM_FUNC_START(\op\()_safe_regs)
 	jmp     2b
 
 	_ASM_EXTABLE(1b, 3b)
-SYM_FUNC_END(\op\()_safe_regs)
+SYM_FUNC_END_SECTION(\op\()_safe_regs)
 .endm
 
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 0ea344c5ea43..2f0281d57ef7 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -43,7 +43,7 @@
 #endif
 
 .text
-SYM_FUNC_START(__put_user_1)
+SYM_FUNC_START_SECTION(__put_user_1)
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
@@ -53,11 +53,11 @@ SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
 	xor %ecx,%ecx
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__put_user_1)
+SYM_FUNC_END_SECTION(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
-SYM_FUNC_START(__put_user_2)
+SYM_FUNC_START_SECTION(__put_user_2)
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
@@ -67,11 +67,11 @@ SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
 	xor %ecx,%ecx
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__put_user_2)
+SYM_FUNC_END_SECTION(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
-SYM_FUNC_START(__put_user_4)
+SYM_FUNC_START_SECTION(__put_user_4)
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
@@ -81,11 +81,11 @@ SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
 	xor %ecx,%ecx
 	ASM_CLAC
 	ret
-SYM_FUNC_END(__put_user_4)
+SYM_FUNC_END_SECTION(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
-SYM_FUNC_START(__put_user_8)
+SYM_FUNC_START_SECTION(__put_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
@@ -98,16 +98,18 @@ SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
-SYM_FUNC_END(__put_user_8)
+SYM_FUNC_END_SECTION(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 EXPORT_SYMBOL(__put_user_nocheck_8)
 
+SYM_TEXT_SECTION(bad_put_user)
 SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
 	ASM_CLAC
 .Lbad_put_user:
 	movl $-EFAULT,%ecx
 	RET
 SYM_CODE_END(.Lbad_put_user_clac)
+SYM_TEXT_END_SECTION
 
 	_ASM_EXTABLE_UA(1b, .Lbad_put_user_clac)
 	_ASM_EXTABLE_UA(2b, .Lbad_put_user_clac)
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index 17d292b7072f..58ff3fd7f65c 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -16,7 +16,7 @@
 
 	.text
 	.code64
-SYM_FUNC_START(sme_encrypt_execute)
+SYM_FUNC_START_SECTION(sme_encrypt_execute)
 
 	/*
 	 * Entry parameters:
@@ -66,9 +66,9 @@ SYM_FUNC_START(sme_encrypt_execute)
 	pop	%rbp
 
 	ret
-SYM_FUNC_END(sme_encrypt_execute)
+SYM_FUNC_END_SECTION(sme_encrypt_execute)
 
-SYM_FUNC_START(__enc_copy)
+SYM_FUNC_START_SECTION(__enc_copy)
 /*
  * Routine used to encrypt memory in place.
  *   This routine must be run outside of the kernel proper since
@@ -153,4 +153,4 @@ SYM_FUNC_START(__enc_copy)
 
 	ret
 .L__enc_copy_end:
-SYM_FUNC_END(__enc_copy)
+SYM_FUNC_END_SECTION(__enc_copy)
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
index 90380a17ab23..8841e757e11b 100644
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -10,7 +10,7 @@
 #include <linux/linkage.h>
 #include <asm/nospec-branch.h>
 
-SYM_FUNC_START(__efi_call)
+SYM_FUNC_START_SECTION(__efi_call)
 	pushq %rbp
 	movq %rsp, %rbp
 	and $~0xf, %rsp
@@ -24,4 +24,4 @@ SYM_FUNC_START(__efi_call)
 	CALL_NOSPEC rdi
 	leave
 	ret
-SYM_FUNC_END(__efi_call)
+SYM_FUNC_END_SECTION(__efi_call)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index fd3dd1708eba..a9d0f5be37ac 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -25,7 +25,7 @@
 
 	.text
 	.code64
-SYM_CODE_START(__efi64_thunk)
+SYM_CODE_START_SECTION(__efi64_thunk)
 	push	%rbp
 	push	%rbx
 
@@ -69,7 +69,7 @@ SYM_CODE_START(__efi64_thunk)
 2:	pushl	$__KERNEL_CS
 	pushl	%ebp
 	lret
-SYM_CODE_END(__efi64_thunk)
+SYM_CODE_END_SECTION(__efi64_thunk)
 
 	.bss
 	.balign 8
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 8786653ad3c0..37c5df83b629 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -16,7 +16,7 @@
 
 .text
 
-SYM_FUNC_START(swsusp_arch_suspend)
+SYM_FUNC_START_SECTION(swsusp_arch_suspend)
 	movl %esp, saved_context_esp
 	movl %ebx, saved_context_ebx
 	movl %ebp, saved_context_ebp
@@ -33,9 +33,9 @@ SYM_FUNC_START(swsusp_arch_suspend)
 	call swsusp_save
 	FRAME_END
 	ret
-SYM_FUNC_END(swsusp_arch_suspend)
+SYM_FUNC_END_SECTION(swsusp_arch_suspend)
 
-SYM_CODE_START(restore_image)
+SYM_CODE_START_SECTION(restore_image)
 	/* prepare to jump to the image kernel */
 	movl	restore_jump_address, %ebx
 	movl	restore_cr3, %ebp
@@ -45,10 +45,10 @@ SYM_CODE_START(restore_image)
 	/* jump to relocated restore code */
 	movl	relocated_restore_code, %eax
 	jmpl	*%eax
-SYM_CODE_END(restore_image)
+SYM_CODE_END_SECTION(restore_image)
 
 /* code below has been relocated to a safe page */
-SYM_CODE_START(core_restore_code)
+SYM_CODE_START_SECTION(core_restore_code)
 	movl	temp_pgt, %eax
 	movl	%eax, %cr3
 
@@ -78,8 +78,9 @@ copy_loop:
 
 done:
 	jmpl	*%ebx
-SYM_CODE_END(core_restore_code)
+SYM_CODE_END_SECTION(core_restore_code)
 
+SYM_TEXT_SECTION(restore_registers)
 	/* code below belongs to the image kernel */
 	.align PAGE_SIZE
 SYM_FUNC_START(restore_registers)
@@ -110,3 +111,4 @@ SYM_FUNC_START(restore_registers)
 
 	ret
 SYM_FUNC_END(restore_registers)
+SYM_TEXT_END_SECTION
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index d9bed596d849..1318c660215b 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -23,6 +23,7 @@
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
 
+SYM_TEXT_SECTION(restore_registers)
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
 SYM_FUNC_START(restore_registers)
@@ -68,8 +69,9 @@ SYM_FUNC_START(restore_registers)
 
 	ret
 SYM_FUNC_END(restore_registers)
+SYM_TEXT_END_SECTION
 
-SYM_FUNC_START(swsusp_arch_suspend)
+SYM_FUNC_START_SECTION(swsusp_arch_suspend)
 	movq	$saved_context, %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
@@ -97,9 +99,9 @@ SYM_FUNC_START(swsusp_arch_suspend)
 	call swsusp_save
 	FRAME_END
 	ret
-SYM_FUNC_END(swsusp_arch_suspend)
+SYM_FUNC_END_SECTION(swsusp_arch_suspend)
 
-SYM_FUNC_START(restore_image)
+SYM_FUNC_START_SECTION(restore_image)
 	/* prepare to jump to the image kernel */
 	movq	restore_jump_address(%rip), %r8
 	movq	restore_cr3(%rip), %r9
@@ -115,10 +117,10 @@ SYM_FUNC_START(restore_image)
 	movq	relocated_restore_code(%rip), %rcx
 	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%rcx
-SYM_FUNC_END(restore_image)
+SYM_FUNC_END_SECTION(restore_image)
 
 	/* code below has been relocated to a safe page */
-SYM_FUNC_START(core_restore_code)
+SYM_FUNC_START_SECTION(core_restore_code)
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
@@ -147,4 +149,4 @@ SYM_FUNC_START(core_restore_code)
 	/* jump to the restore_registers address from the image header */
 	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%r8
-SYM_FUNC_END(core_restore_code)
+SYM_FUNC_END_SECTION(core_restore_code)
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 220dd9678494..e123e8d4babc 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -119,12 +119,12 @@ SYM_FUNC_END(xen_read_cr2_direct);
 .popsection
 
 .macro xen_pv_trap name
-SYM_CODE_START(xen_\name)
+SYM_CODE_START_SECTION(xen_\name)
 	UNWIND_HINT_EMPTY
 	pop %rcx
 	pop %r11
 	jmp  \name
-SYM_CODE_END(xen_\name)
+SYM_CODE_END_SECTION(xen_\name)
 _ASM_NOKPROBE(xen_\name)
 .endm
 
@@ -186,11 +186,11 @@ hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
  *	r11		}<-- pushed by hypercall page
  * rsp->rax		}
  */
-SYM_CODE_START(xen_iret)
+SYM_CODE_START_SECTION(xen_iret)
 	UNWIND_HINT_EMPTY
 	pushq $0
 	jmp hypercall_iret
-SYM_CODE_END(xen_iret)
+SYM_CODE_END_SECTION(xen_iret)
 
 /*
  * Xen handles syscall callbacks much like ordinary exceptions, which
@@ -208,7 +208,7 @@ SYM_CODE_END(xen_iret)
  */
 
 /* Normal 64-bit system call target */
-SYM_CODE_START(xen_syscall_target)
+SYM_CODE_START_SECTION(xen_syscall_target)
 	UNWIND_HINT_EMPTY
 	popq %rcx
 	popq %r11
@@ -222,12 +222,12 @@ SYM_CODE_START(xen_syscall_target)
 	movq $__USER_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_64_after_hwframe
-SYM_CODE_END(xen_syscall_target)
+SYM_CODE_END_SECTION(xen_syscall_target)
 
 #ifdef CONFIG_IA32_EMULATION
 
 /* 32-bit compat syscall target */
-SYM_CODE_START(xen_syscall32_target)
+SYM_CODE_START_SECTION(xen_syscall32_target)
 	UNWIND_HINT_EMPTY
 	popq %rcx
 	popq %r11
@@ -241,10 +241,10 @@ SYM_CODE_START(xen_syscall32_target)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_compat_after_hwframe
-SYM_CODE_END(xen_syscall32_target)
+SYM_CODE_END_SECTION(xen_syscall32_target)
 
 /* 32-bit compat sysenter target */
-SYM_CODE_START(xen_sysenter_target)
+SYM_CODE_START_SECTION(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
 	/*
 	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
@@ -262,11 +262,11 @@ SYM_CODE_START(xen_sysenter_target)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSENTER_compat_after_hwframe
-SYM_CODE_END(xen_sysenter_target)
+SYM_CODE_END_SECTION(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
 
-SYM_CODE_START(xen_syscall32_target)
+SYM_CODE_START_SECTION(xen_syscall32_target)
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
@@ -274,6 +274,6 @@ SYM_CODE_START(xen_sysenter_target)
 	pushq $0
 	jmp hypercall_iret
 SYM_CODE_END(xen_sysenter_target)
-SYM_CODE_END(xen_syscall32_target)
+SYM_CODE_END_SECTION(xen_syscall32_target)
 
 #endif	/* CONFIG_IA32_EMULATION */
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 6a64496edefb..6cb0ffb02670 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -71,13 +71,11 @@ SYM_CODE_END(startup_xen)
 	__FINIT
 
 #ifdef CONFIG_XEN_PV_SMP
-.pushsection .text
-SYM_CODE_START(asm_cpu_bringup_and_idle)
+SYM_CODE_START_SECTION(asm_cpu_bringup_and_idle)
 	UNWIND_HINT_EMPTY
 
 	call cpu_bringup_and_idle
-SYM_CODE_END(asm_cpu_bringup_and_idle)
-.popsection
+SYM_CODE_END_SECTION(asm_cpu_bringup_and_idle)
 #endif
 #endif
 
-- 
2.33.1

