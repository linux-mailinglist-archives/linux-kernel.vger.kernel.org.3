Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6884946FF65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhLJLJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbhLJLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DBAC061746;
        Fri, 10 Dec 2021 03:05:21 -0800 (PST)
Date:   Fri, 10 Dec 2021 11:05:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639134319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttgJUoVXMR6ibob+KtLxtiYZ61HDfqjYR3HOje14le8=;
        b=fDTKxP1FjhSD1QsG5zLg2YJHT3W2PpzWa6vZQ1LIuh9Sg66VUYPmjdY8BXgaMFEZtTgHEY
        jMA7wkiCKwDMf2AW/JFkiyFR65v6p4zECN3RgKLEvKJVLGsxGfPo6VQKeeU/oDtZte//wn
        GUQhpP8FCIJeWr9qdObS+a4dLSscomf9aBAuUsE+udzfBUfkZ6SguQ8Uh5OZHMq0gmyReU
        W0+0ndakAoXZVlETLilWNFKhTu9cCb8owLcVZdi0KhG4Wbr4VYOG/vI12vziywFwIz7d57
        GLqrryMjeBwaoSOZX2T3JrVyLZhstqNjDGqR1UfkHYeVCmNKjOfAg7lQ/juErw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639134319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttgJUoVXMR6ibob+KtLxtiYZ61HDfqjYR3HOje14le8=;
        b=+69GjsT6bUMa/RHk4r+o0SNnykXYgxdIewykN+ERMepxbd96/OawQNqVtGHbPjlWzC2OYL
        DG88Cw3T/Yhe9gDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Prepare asm files for straight-line-speculation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211204134907.905503893@infradead.org>
References: <20211204134907.905503893@infradead.org>
MIME-Version: 1.0
Message-ID: <163913431824.23020.8814094042788003648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f94909ceb1ed4bfdb2ada72f93236305e6d6951f
Gitweb:        https://git.kernel.org/tip/f94909ceb1ed4bfdb2ada72f93236305e6d6951f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Dec 2021 14:43:40 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 12:25:37 +01:00

x86: Prepare asm files for straight-line-speculation

Replace all ret/retq instructions with RET in preparation of making
RET a macro. Since AS is case insensitive it's a big no-op without
RET defined.

  find arch/x86/ -name \*.S | while read file
  do
	sed -i 's/\<ret[q]*\>/RET/' $file
  done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211204134907.905503893@infradead.org
---
 arch/x86/boot/compressed/efi_thunk_64.S      |  2 +-
 arch/x86/boot/compressed/head_64.S           |  8 +--
 arch/x86/boot/compressed/mem_encrypt.S       |  6 +-
 arch/x86/crypto/aegis128-aesni-asm.S         | 48 ++++++++--------
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S      |  2 +-
 arch/x86/crypto/aesni-intel_asm.S            | 56 +++++++++----------
 arch/x86/crypto/aesni-intel_avx-x86_64.S     | 40 +++++++-------
 arch/x86/crypto/blake2s-core.S               |  4 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S     | 12 ++--
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 14 ++---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 14 ++---
 arch/x86/crypto/camellia-x86_64-asm_64.S     | 12 ++--
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    | 12 ++--
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    | 10 +--
 arch/x86/crypto/chacha-avx2-x86_64.S         |  6 +-
 arch/x86/crypto/chacha-avx512vl-x86_64.S     |  6 +-
 arch/x86/crypto/chacha-ssse3-x86_64.S        |  8 +--
 arch/x86/crypto/crc32-pclmul_asm.S           |  2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |  2 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S       |  2 +-
 arch/x86/crypto/des3_ede-asm_64.S            |  4 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |  6 +-
 arch/x86/crypto/nh-avx2-x86_64.S             |  2 +-
 arch/x86/crypto/nh-sse2-x86_64.S             |  2 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S  | 10 +--
 arch/x86/crypto/serpent-avx2-asm_64.S        | 10 +--
 arch/x86/crypto/serpent-sse2-i586-asm_32.S   |  6 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S |  6 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S       |  2 +-
 arch/x86/crypto/sha1_ni_asm.S                |  2 +-
 arch/x86/crypto/sha1_ssse3_asm.S             |  2 +-
 arch/x86/crypto/sha256-avx-asm.S             |  2 +-
 arch/x86/crypto/sha256-avx2-asm.S            |  2 +-
 arch/x86/crypto/sha256-ssse3-asm.S           |  2 +-
 arch/x86/crypto/sha256_ni_asm.S              |  2 +-
 arch/x86/crypto/sha512-avx-asm.S             |  2 +-
 arch/x86/crypto/sha512-avx2-asm.S            |  2 +-
 arch/x86/crypto/sha512-ssse3-asm.S           |  2 +-
 arch/x86/crypto/sm4-aesni-avx-asm_64.S       | 12 ++--
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S      |  8 +--
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S  | 10 +--
 arch/x86/crypto/twofish-i586-asm_32.S        |  4 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S |  6 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S      |  4 +-
 arch/x86/entry/entry_32.S                    |  2 +-
 arch/x86/entry/entry_64.S                    | 10 +--
 arch/x86/entry/thunk_32.S                    |  2 +-
 arch/x86/entry/thunk_64.S                    |  2 +-
 arch/x86/entry/vdso/vdso32/system_call.S     |  2 +-
 arch/x86/entry/vdso/vsgx.S                   |  2 +-
 arch/x86/entry/vsyscall/vsyscall_emu_64.S    |  6 +-
 arch/x86/kernel/acpi/wakeup_32.S             |  6 +-
 arch/x86/kernel/ftrace_32.S                  |  6 +-
 arch/x86/kernel/ftrace_64.S                  |  8 +--
 arch/x86/kernel/head_32.S                    |  2 +-
 arch/x86/kernel/irqflags.S                   |  2 +-
 arch/x86/kernel/relocate_kernel_32.S         | 10 +--
 arch/x86/kernel/relocate_kernel_64.S         | 10 +--
 arch/x86/kernel/sev_verify_cbit.S            |  2 +-
 arch/x86/kernel/verify_cpu.S                 |  4 +-
 arch/x86/kvm/svm/vmenter.S                   |  4 +-
 arch/x86/kvm/vmx/vmenter.S                   | 14 ++---
 arch/x86/lib/atomic64_386_32.S               |  2 +-
 arch/x86/lib/atomic64_cx8_32.S               | 16 ++---
 arch/x86/lib/checksum_32.S                   |  8 +--
 arch/x86/lib/clear_page_64.S                 |  6 +-
 arch/x86/lib/cmpxchg16b_emu.S                |  4 +-
 arch/x86/lib/cmpxchg8b_emu.S                 |  4 +-
 arch/x86/lib/copy_mc_64.S                    |  6 +-
 arch/x86/lib/copy_page_64.S                  |  4 +-
 arch/x86/lib/copy_user_64.S                  | 10 +--
 arch/x86/lib/csum-copy_64.S                  |  2 +-
 arch/x86/lib/getuser.S                       | 22 +++----
 arch/x86/lib/hweight.S                       |  6 +-
 arch/x86/lib/iomap_copy_64.S                 |  2 +-
 arch/x86/lib/memcpy_64.S                     | 12 ++--
 arch/x86/lib/memmove_64.S                    |  4 +-
 arch/x86/lib/memset_64.S                     |  6 +-
 arch/x86/lib/msr-reg.S                       |  4 +-
 arch/x86/lib/putuser.S                       |  6 +-
 arch/x86/lib/retpoline.S                     |  2 +-
 arch/x86/math-emu/div_Xsig.S                 |  2 +-
 arch/x86/math-emu/div_small.S                |  2 +-
 arch/x86/math-emu/mul_Xsig.S                 |  6 +-
 arch/x86/math-emu/polynom_Xsig.S             |  2 +-
 arch/x86/math-emu/reg_norm.S                 |  6 +-
 arch/x86/math-emu/reg_round.S                |  2 +-
 arch/x86/math-emu/reg_u_add.S                |  2 +-
 arch/x86/math-emu/reg_u_div.S                |  2 +-
 arch/x86/math-emu/reg_u_mul.S                |  2 +-
 arch/x86/math-emu/reg_u_sub.S                |  2 +-
 arch/x86/math-emu/round_Xsig.S               |  4 +-
 arch/x86/math-emu/shr_Xsig.S                 |  8 +--
 arch/x86/math-emu/wm_shrx.S                  | 16 ++---
 arch/x86/mm/mem_encrypt_boot.S               |  4 +-
 arch/x86/platform/efi/efi_stub_32.S          |  2 +-
 arch/x86/platform/efi/efi_stub_64.S          |  2 +-
 arch/x86/platform/efi/efi_thunk_64.S         |  2 +-
 arch/x86/platform/olpc/xo1-wakeup.S          |  6 +-
 arch/x86/power/hibernate_asm_32.S            |  4 +-
 arch/x86/power/hibernate_asm_64.S            |  4 +-
 arch/x86/um/checksum_32.S                    |  4 +-
 arch/x86/um/setjmp_32.S                      |  2 +-
 arch/x86/um/setjmp_64.S                      |  2 +-
 arch/x86/xen/xen-asm.S                       | 12 ++--
 arch/x86/xen/xen-head.S                      |  2 +-
 106 files changed, 349 insertions(+), 349 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 8bb92e9..7005277 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -93,7 +93,7 @@ SYM_FUNC_START(__efi64_thunk)
 
 	pop	%rbx
 	pop	%rbp
-	ret
+	RET
 SYM_FUNC_END(__efi64_thunk)
 
 	.code32
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 572c535..fd9441f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -813,7 +813,7 @@ SYM_FUNC_START(efi32_pe_entry)
 2:	popl	%edi				// restore callee-save registers
 	popl	%ebx
 	leave
-	ret
+	RET
 SYM_FUNC_END(efi32_pe_entry)
 
 	.section ".rodata"
@@ -868,7 +868,7 @@ SYM_FUNC_START(startup32_set_idt_entry)
 
 	pop     %ecx
 	pop     %ebx
-	ret
+	RET
 SYM_FUNC_END(startup32_set_idt_entry)
 #endif
 
@@ -884,7 +884,7 @@ SYM_FUNC_START(startup32_load_idt)
 	movl	%eax, rva(boot32_idt_desc+2)(%ebp)
 	lidt    rva(boot32_idt_desc)(%ebp)
 #endif
-	ret
+	RET
 SYM_FUNC_END(startup32_load_idt)
 
 /*
@@ -954,7 +954,7 @@ SYM_FUNC_START(startup32_check_sev_cbit)
 	popl	%ebx
 	popl	%eax
 #endif
-	ret
+	RET
 SYM_FUNC_END(startup32_check_sev_cbit)
 
 /*
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index c1e81a8..a63424d 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -58,7 +58,7 @@ SYM_FUNC_START(get_sev_encryption_bit)
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
-	ret
+	RET
 SYM_FUNC_END(get_sev_encryption_bit)
 
 /**
@@ -92,7 +92,7 @@ SYM_CODE_START_LOCAL(sev_es_req_cpuid)
 	/* All good - return success */
 	xorl	%eax, %eax
 1:
-	ret
+	RET
 2:
 	movl	$-1, %eax
 	jmp	1b
@@ -221,7 +221,7 @@ SYM_FUNC_START(set_sev_encryption_mask)
 #endif
 
 	xor	%rax, %rax
-	ret
+	RET
 SYM_FUNC_END(set_sev_encryption_mask)
 
 	.data
diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 51d46d9..b48ddeb 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -122,7 +122,7 @@ SYM_FUNC_START_LOCAL(__load_partial)
 	pxor T0, MSG
 
 .Lld_partial_8:
-	ret
+	RET
 SYM_FUNC_END(__load_partial)
 
 /*
@@ -180,7 +180,7 @@ SYM_FUNC_START_LOCAL(__store_partial)
 	mov %r10b, (%r9)
 
 .Lst_partial_1:
-	ret
+	RET
 SYM_FUNC_END(__store_partial)
 
 /*
@@ -225,7 +225,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_init)
 	movdqu STATE4, 0x40(STATEP)
 
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(crypto_aegis128_aesni_init)
 
 /*
@@ -337,7 +337,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_ad)
 	movdqu STATE3, 0x30(STATEP)
 	movdqu STATE4, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lad_out_1:
 	movdqu STATE4, 0x00(STATEP)
@@ -346,7 +346,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_ad)
 	movdqu STATE2, 0x30(STATEP)
 	movdqu STATE3, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lad_out_2:
 	movdqu STATE3, 0x00(STATEP)
@@ -355,7 +355,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_ad)
 	movdqu STATE1, 0x30(STATEP)
 	movdqu STATE2, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lad_out_3:
 	movdqu STATE2, 0x00(STATEP)
@@ -364,7 +364,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_ad)
 	movdqu STATE0, 0x30(STATEP)
 	movdqu STATE1, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lad_out_4:
 	movdqu STATE1, 0x00(STATEP)
@@ -373,11 +373,11 @@ SYM_FUNC_START(crypto_aegis128_aesni_ad)
 	movdqu STATE4, 0x30(STATEP)
 	movdqu STATE0, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lad_out:
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(crypto_aegis128_aesni_ad)
 
 .macro encrypt_block a s0 s1 s2 s3 s4 i
@@ -452,7 +452,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc)
 	movdqu STATE2, 0x30(STATEP)
 	movdqu STATE3, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lenc_out_1:
 	movdqu STATE3, 0x00(STATEP)
@@ -461,7 +461,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc)
 	movdqu STATE1, 0x30(STATEP)
 	movdqu STATE2, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lenc_out_2:
 	movdqu STATE2, 0x00(STATEP)
@@ -470,7 +470,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc)
 	movdqu STATE0, 0x30(STATEP)
 	movdqu STATE1, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lenc_out_3:
 	movdqu STATE1, 0x00(STATEP)
@@ -479,7 +479,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc)
 	movdqu STATE4, 0x30(STATEP)
 	movdqu STATE0, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lenc_out_4:
 	movdqu STATE0, 0x00(STATEP)
@@ -488,11 +488,11 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc)
 	movdqu STATE3, 0x30(STATEP)
 	movdqu STATE4, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Lenc_out:
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(crypto_aegis128_aesni_enc)
 
 /*
@@ -532,7 +532,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc_tail)
 	movdqu STATE3, 0x40(STATEP)
 
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(crypto_aegis128_aesni_enc_tail)
 
 .macro decrypt_block a s0 s1 s2 s3 s4 i
@@ -606,7 +606,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec)
 	movdqu STATE2, 0x30(STATEP)
 	movdqu STATE3, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Ldec_out_1:
 	movdqu STATE3, 0x00(STATEP)
@@ -615,7 +615,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec)
 	movdqu STATE1, 0x30(STATEP)
 	movdqu STATE2, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Ldec_out_2:
 	movdqu STATE2, 0x00(STATEP)
@@ -624,7 +624,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec)
 	movdqu STATE0, 0x30(STATEP)
 	movdqu STATE1, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Ldec_out_3:
 	movdqu STATE1, 0x00(STATEP)
@@ -633,7 +633,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec)
 	movdqu STATE4, 0x30(STATEP)
 	movdqu STATE0, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Ldec_out_4:
 	movdqu STATE0, 0x00(STATEP)
@@ -642,11 +642,11 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec)
 	movdqu STATE3, 0x30(STATEP)
 	movdqu STATE4, 0x40(STATEP)
 	FRAME_END
-	ret
+	RET
 
 .Ldec_out:
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(crypto_aegis128_aesni_dec)
 
 /*
@@ -696,7 +696,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec_tail)
 	movdqu STATE3, 0x40(STATEP)
 
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(crypto_aegis128_aesni_dec_tail)
 
 /*
@@ -743,5 +743,5 @@ SYM_FUNC_START(crypto_aegis128_aesni_final)
 	movdqu MSG, (%rsi)
 
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(crypto_aegis128_aesni_final)
diff --git a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
index 3f0fc7d..c799838 100644
--- a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
+++ b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
@@ -525,7 +525,7 @@ ddq_add_8:
 	/* return updated IV */
 	vpshufb	xbyteswap, xcounter, xcounter
 	vmovdqu	xcounter, (p_iv)
-	ret
+	RET
 .endm
 
 /*
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 4e39725..363699d 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1594,7 +1594,7 @@ SYM_FUNC_START(aesni_gcm_dec)
 	GCM_ENC_DEC dec
 	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
-	ret
+	RET
 SYM_FUNC_END(aesni_gcm_dec)
 
 
@@ -1683,7 +1683,7 @@ SYM_FUNC_START(aesni_gcm_enc)
 
 	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
-	ret
+	RET
 SYM_FUNC_END(aesni_gcm_enc)
 
 /*****************************************************************************
@@ -1701,7 +1701,7 @@ SYM_FUNC_START(aesni_gcm_init)
 	FUNC_SAVE
 	GCM_INIT %arg3, %arg4,%arg5, %arg6
 	FUNC_RESTORE
-	ret
+	RET
 SYM_FUNC_END(aesni_gcm_init)
 
 /*****************************************************************************
@@ -1716,7 +1716,7 @@ SYM_FUNC_START(aesni_gcm_enc_update)
 	FUNC_SAVE
 	GCM_ENC_DEC enc
 	FUNC_RESTORE
-	ret
+	RET
 SYM_FUNC_END(aesni_gcm_enc_update)
 
 /*****************************************************************************
@@ -1731,7 +1731,7 @@ SYM_FUNC_START(aesni_gcm_dec_update)
 	FUNC_SAVE
 	GCM_ENC_DEC dec
 	FUNC_RESTORE
-	ret
+	RET
 SYM_FUNC_END(aesni_gcm_dec_update)
 
 /*****************************************************************************
@@ -1746,7 +1746,7 @@ SYM_FUNC_START(aesni_gcm_finalize)
 	FUNC_SAVE
 	GCM_COMPLETE %arg3 %arg4
 	FUNC_RESTORE
-	ret
+	RET
 SYM_FUNC_END(aesni_gcm_finalize)
 
 #endif
@@ -1762,7 +1762,7 @@ SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	pxor %xmm1, %xmm0
 	movaps %xmm0, (TKEYP)
 	add $0x10, TKEYP
-	ret
+	RET
 SYM_FUNC_END(_key_expansion_256a)
 SYM_FUNC_END_ALIAS(_key_expansion_128)
 
@@ -1787,7 +1787,7 @@ SYM_FUNC_START_LOCAL(_key_expansion_192a)
 	shufps $0b01001110, %xmm2, %xmm1
 	movaps %xmm1, 0x10(TKEYP)
 	add $0x20, TKEYP
-	ret
+	RET
 SYM_FUNC_END(_key_expansion_192a)
 
 SYM_FUNC_START_LOCAL(_key_expansion_192b)
@@ -1806,7 +1806,7 @@ SYM_FUNC_START_LOCAL(_key_expansion_192b)
 
 	movaps %xmm0, (TKEYP)
 	add $0x10, TKEYP
-	ret
+	RET
 SYM_FUNC_END(_key_expansion_192b)
 
 SYM_FUNC_START_LOCAL(_key_expansion_256b)
@@ -1818,7 +1818,7 @@ SYM_FUNC_START_LOCAL(_key_expansion_256b)
 	pxor %xmm1, %xmm2
 	movaps %xmm2, (TKEYP)
 	add $0x10, TKEYP
-	ret
+	RET
 SYM_FUNC_END(_key_expansion_256b)
 
 /*
@@ -1933,7 +1933,7 @@ SYM_FUNC_START(aesni_set_key)
 	popl KEYP
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_set_key)
 
 /*
@@ -1957,7 +1957,7 @@ SYM_FUNC_START(aesni_enc)
 	popl KEYP
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_enc)
 
 /*
@@ -2014,7 +2014,7 @@ SYM_FUNC_START_LOCAL(_aesni_enc1)
 	aesenc KEY, STATE
 	movaps 0x70(TKEYP), KEY
 	aesenclast KEY, STATE
-	ret
+	RET
 SYM_FUNC_END(_aesni_enc1)
 
 /*
@@ -2122,7 +2122,7 @@ SYM_FUNC_START_LOCAL(_aesni_enc4)
 	aesenclast KEY, STATE2
 	aesenclast KEY, STATE3
 	aesenclast KEY, STATE4
-	ret
+	RET
 SYM_FUNC_END(_aesni_enc4)
 
 /*
@@ -2147,7 +2147,7 @@ SYM_FUNC_START(aesni_dec)
 	popl KEYP
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_dec)
 
 /*
@@ -2204,7 +2204,7 @@ SYM_FUNC_START_LOCAL(_aesni_dec1)
 	aesdec KEY, STATE
 	movaps 0x70(TKEYP), KEY
 	aesdeclast KEY, STATE
-	ret
+	RET
 SYM_FUNC_END(_aesni_dec1)
 
 /*
@@ -2312,7 +2312,7 @@ SYM_FUNC_START_LOCAL(_aesni_dec4)
 	aesdeclast KEY, STATE2
 	aesdeclast KEY, STATE3
 	aesdeclast KEY, STATE4
-	ret
+	RET
 SYM_FUNC_END(_aesni_dec4)
 
 /*
@@ -2372,7 +2372,7 @@ SYM_FUNC_START(aesni_ecb_enc)
 	popl LEN
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_ecb_enc)
 
 /*
@@ -2433,7 +2433,7 @@ SYM_FUNC_START(aesni_ecb_dec)
 	popl LEN
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_ecb_dec)
 
 /*
@@ -2477,7 +2477,7 @@ SYM_FUNC_START(aesni_cbc_enc)
 	popl IVP
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_cbc_enc)
 
 /*
@@ -2570,7 +2570,7 @@ SYM_FUNC_START(aesni_cbc_dec)
 	popl IVP
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_cbc_dec)
 
 /*
@@ -2627,7 +2627,7 @@ SYM_FUNC_START(aesni_cts_cbc_enc)
 	popl IVP
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_cts_cbc_enc)
 
 /*
@@ -2688,7 +2688,7 @@ SYM_FUNC_START(aesni_cts_cbc_dec)
 	popl IVP
 #endif
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_cts_cbc_dec)
 
 .pushsection .rodata
@@ -2725,7 +2725,7 @@ SYM_FUNC_START_LOCAL(_aesni_inc_init)
 	mov $1, TCTR_LOW
 	movq TCTR_LOW, INC
 	movq CTR, TCTR_LOW
-	ret
+	RET
 SYM_FUNC_END(_aesni_inc_init)
 
 /*
@@ -2753,7 +2753,7 @@ SYM_FUNC_START_LOCAL(_aesni_inc)
 .Linc_low:
 	movaps CTR, IV
 	pshufb BSWAP_MASK, IV
-	ret
+	RET
 SYM_FUNC_END(_aesni_inc)
 
 /*
@@ -2816,7 +2816,7 @@ SYM_FUNC_START(aesni_ctr_enc)
 	movups IV, (IVP)
 .Lctr_enc_just_ret:
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(aesni_ctr_enc)
 
 #endif
@@ -2932,7 +2932,7 @@ SYM_FUNC_START(aesni_xts_encrypt)
 	popl IVP
 #endif
 	FRAME_END
-	ret
+	RET
 
 .Lxts_enc_1x:
 	add $64, LEN
@@ -3092,7 +3092,7 @@ SYM_FUNC_START(aesni_xts_decrypt)
 	popl IVP
 #endif
 	FRAME_END
-	ret
+	RET
 
 .Lxts_dec_1x:
 	add $64, LEN
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 98e3552..0852ab5 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -1767,7 +1767,7 @@ SYM_FUNC_START(aesni_gcm_init_avx_gen2)
         FUNC_SAVE
         INIT GHASH_MUL_AVX, PRECOMPUTE_AVX
         FUNC_RESTORE
-        ret
+        RET
 SYM_FUNC_END(aesni_gcm_init_avx_gen2)
 
 ###############################################################################
@@ -1788,15 +1788,15 @@ SYM_FUNC_START(aesni_gcm_enc_update_avx_gen2)
         # must be 192
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 11
         FUNC_RESTORE
-        ret
+        RET
 key_128_enc_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 9
         FUNC_RESTORE
-        ret
+        RET
 key_256_enc_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 13
         FUNC_RESTORE
-        ret
+        RET
 SYM_FUNC_END(aesni_gcm_enc_update_avx_gen2)
 
 ###############################################################################
@@ -1817,15 +1817,15 @@ SYM_FUNC_START(aesni_gcm_dec_update_avx_gen2)
         # must be 192
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 11
         FUNC_RESTORE
-        ret
+        RET
 key_128_dec_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 9
         FUNC_RESTORE
-        ret
+        RET
 key_256_dec_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 13
         FUNC_RESTORE
-        ret
+        RET
 SYM_FUNC_END(aesni_gcm_dec_update_avx_gen2)
 
 ###############################################################################
@@ -1846,15 +1846,15 @@ SYM_FUNC_START(aesni_gcm_finalize_avx_gen2)
         # must be 192
         GCM_COMPLETE GHASH_MUL_AVX, 11, arg3, arg4
         FUNC_RESTORE
-        ret
+        RET
 key_128_finalize:
         GCM_COMPLETE GHASH_MUL_AVX, 9, arg3, arg4
         FUNC_RESTORE
-        ret
+        RET
 key_256_finalize:
         GCM_COMPLETE GHASH_MUL_AVX, 13, arg3, arg4
         FUNC_RESTORE
-        ret
+        RET
 SYM_FUNC_END(aesni_gcm_finalize_avx_gen2)
 
 ###############################################################################
@@ -2735,7 +2735,7 @@ SYM_FUNC_START(aesni_gcm_init_avx_gen4)
         FUNC_SAVE
         INIT GHASH_MUL_AVX2, PRECOMPUTE_AVX2
         FUNC_RESTORE
-        ret
+        RET
 SYM_FUNC_END(aesni_gcm_init_avx_gen4)
 
 ###############################################################################
@@ -2756,15 +2756,15 @@ SYM_FUNC_START(aesni_gcm_enc_update_avx_gen4)
         # must be 192
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 11
         FUNC_RESTORE
-	ret
+	RET
 key_128_enc_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 9
         FUNC_RESTORE
-	ret
+	RET
 key_256_enc_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 13
         FUNC_RESTORE
-	ret
+	RET
 SYM_FUNC_END(aesni_gcm_enc_update_avx_gen4)
 
 ###############################################################################
@@ -2785,15 +2785,15 @@ SYM_FUNC_START(aesni_gcm_dec_update_avx_gen4)
         # must be 192
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 11
         FUNC_RESTORE
-        ret
+        RET
 key_128_dec_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 9
         FUNC_RESTORE
-        ret
+        RET
 key_256_dec_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 13
         FUNC_RESTORE
-        ret
+        RET
 SYM_FUNC_END(aesni_gcm_dec_update_avx_gen4)
 
 ###############################################################################
@@ -2814,13 +2814,13 @@ SYM_FUNC_START(aesni_gcm_finalize_avx_gen4)
         # must be 192
         GCM_COMPLETE GHASH_MUL_AVX2, 11, arg3, arg4
         FUNC_RESTORE
-        ret
+        RET
 key_128_finalize4:
         GCM_COMPLETE GHASH_MUL_AVX2, 9, arg3, arg4
         FUNC_RESTORE
-        ret
+        RET
 key_256_finalize4:
         GCM_COMPLETE GHASH_MUL_AVX2, 13, arg3, arg4
         FUNC_RESTORE
-        ret
+        RET
 SYM_FUNC_END(aesni_gcm_finalize_avx_gen4)
diff --git a/arch/x86/crypto/blake2s-core.S b/arch/x86/crypto/blake2s-core.S
index 2ca7997..b50b35f 100644
--- a/arch/x86/crypto/blake2s-core.S
+++ b/arch/x86/crypto/blake2s-core.S
@@ -171,7 +171,7 @@ SYM_FUNC_START(blake2s_compress_ssse3)
 	movdqu		%xmm1,0x10(%rdi)
 	movdqu		%xmm14,0x20(%rdi)
 .Lendofloop:
-	ret
+	RET
 SYM_FUNC_END(blake2s_compress_ssse3)
 
 #ifdef CONFIG_AS_AVX512
@@ -251,6 +251,6 @@ SYM_FUNC_START(blake2s_compress_avx512)
 	vmovdqu		%xmm1,0x10(%rdi)
 	vmovdqu		%xmm4,0x20(%rdi)
 	vzeroupper
-	retq
+	RET
 SYM_FUNC_END(blake2s_compress_avx512)
 #endif /* CONFIG_AS_AVX512 */
diff --git a/arch/x86/crypto/blowfish-x86_64-asm_64.S b/arch/x86/crypto/blowfish-x86_64-asm_64.S
index 4222ac6..802d715 100644
--- a/arch/x86/crypto/blowfish-x86_64-asm_64.S
+++ b/arch/x86/crypto/blowfish-x86_64-asm_64.S
@@ -135,10 +135,10 @@ SYM_FUNC_START(__blowfish_enc_blk)
 	jnz .L__enc_xor;
 
 	write_block();
-	ret;
+	RET;
 .L__enc_xor:
 	xor_block();
-	ret;
+	RET;
 SYM_FUNC_END(__blowfish_enc_blk)
 
 SYM_FUNC_START(blowfish_dec_blk)
@@ -170,7 +170,7 @@ SYM_FUNC_START(blowfish_dec_blk)
 
 	movq %r11, %r12;
 
-	ret;
+	RET;
 SYM_FUNC_END(blowfish_dec_blk)
 
 /**********************************************************************
@@ -322,14 +322,14 @@ SYM_FUNC_START(__blowfish_enc_blk_4way)
 
 	popq %rbx;
 	popq %r12;
-	ret;
+	RET;
 
 .L__enc_xor4:
 	xor_block4();
 
 	popq %rbx;
 	popq %r12;
-	ret;
+	RET;
 SYM_FUNC_END(__blowfish_enc_blk_4way)
 
 SYM_FUNC_START(blowfish_dec_blk_4way)
@@ -364,5 +364,5 @@ SYM_FUNC_START(blowfish_dec_blk_4way)
 	popq %rbx;
 	popq %r12;
 
-	ret;
+	RET;
 SYM_FUNC_END(blowfish_dec_blk_4way)
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index e2a0e0f..2e1658d 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -192,7 +192,7 @@ SYM_FUNC_START_LOCAL(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_c
 	roundsm16(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		  %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm15,
 		  %rcx, (%r9));
-	ret;
+	RET;
 SYM_FUNC_END(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 
 .align 8
@@ -200,7 +200,7 @@ SYM_FUNC_START_LOCAL(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_a
 	roundsm16(%xmm4, %xmm5, %xmm6, %xmm7, %xmm0, %xmm1, %xmm2, %xmm3,
 		  %xmm12, %xmm13, %xmm14, %xmm15, %xmm8, %xmm9, %xmm10, %xmm11,
 		  %rax, (%r9));
-	ret;
+	RET;
 SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 
 /*
@@ -778,7 +778,7 @@ SYM_FUNC_START_LOCAL(__camellia_enc_blk16)
 		    %xmm15, (key_table)(CTX, %r8, 8), (%rax), 1 * 16(%rax));
 
 	FRAME_END
-	ret;
+	RET;
 
 .align 8
 .Lenc_max32:
@@ -865,7 +865,7 @@ SYM_FUNC_START_LOCAL(__camellia_dec_blk16)
 		    %xmm15, (key_table)(CTX), (%rax), 1 * 16(%rax));
 
 	FRAME_END
-	ret;
+	RET;
 
 .align 8
 .Ldec_max32:
@@ -906,7 +906,7 @@ SYM_FUNC_START(camellia_ecb_enc_16way)
 		     %xmm8, %rsi);
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(camellia_ecb_enc_16way)
 
 SYM_FUNC_START(camellia_ecb_dec_16way)
@@ -936,7 +936,7 @@ SYM_FUNC_START(camellia_ecb_dec_16way)
 		     %xmm8, %rsi);
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(camellia_ecb_dec_16way)
 
 SYM_FUNC_START(camellia_cbc_dec_16way)
@@ -987,5 +987,5 @@ SYM_FUNC_START(camellia_cbc_dec_16way)
 		     %xmm8, %rsi);
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(camellia_cbc_dec_16way)
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 706f708..0e4e9ab 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -226,7 +226,7 @@ SYM_FUNC_START_LOCAL(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_c
 	roundsm32(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %ymm5, %ymm6, %ymm7,
 		  %ymm8, %ymm9, %ymm10, %ymm11, %ymm12, %ymm13, %ymm14, %ymm15,
 		  %rcx, (%r9));
-	ret;
+	RET;
 SYM_FUNC_END(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 
 .align 8
@@ -234,7 +234,7 @@ SYM_FUNC_START_LOCAL(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_a
 	roundsm32(%ymm4, %ymm5, %ymm6, %ymm7, %ymm0, %ymm1, %ymm2, %ymm3,
 		  %ymm12, %ymm13, %ymm14, %ymm15, %ymm8, %ymm9, %ymm10, %ymm11,
 		  %rax, (%r9));
-	ret;
+	RET;
 SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 
 /*
@@ -814,7 +814,7 @@ SYM_FUNC_START_LOCAL(__camellia_enc_blk32)
 		    %ymm15, (key_table)(CTX, %r8, 8), (%rax), 1 * 32(%rax));
 
 	FRAME_END
-	ret;
+	RET;
 
 .align 8
 .Lenc_max32:
@@ -901,7 +901,7 @@ SYM_FUNC_START_LOCAL(__camellia_dec_blk32)
 		    %ymm15, (key_table)(CTX), (%rax), 1 * 32(%rax));
 
 	FRAME_END
-	ret;
+	RET;
 
 .align 8
 .Ldec_max32:
@@ -946,7 +946,7 @@ SYM_FUNC_START(camellia_ecb_enc_32way)
 	vzeroupper;
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(camellia_ecb_enc_32way)
 
 SYM_FUNC_START(camellia_ecb_dec_32way)
@@ -980,7 +980,7 @@ SYM_FUNC_START(camellia_ecb_dec_32way)
 	vzeroupper;
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(camellia_ecb_dec_32way)
 
 SYM_FUNC_START(camellia_cbc_dec_32way)
@@ -1047,5 +1047,5 @@ SYM_FUNC_START(camellia_cbc_dec_32way)
 
 	addq $(16 * 32), %rsp;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(camellia_cbc_dec_32way)
diff --git a/arch/x86/crypto/camellia-x86_64-asm_64.S b/arch/x86/crypto/camellia-x86_64-asm_64.S
index 1372e64..347c059 100644
--- a/arch/x86/crypto/camellia-x86_64-asm_64.S
+++ b/arch/x86/crypto/camellia-x86_64-asm_64.S
@@ -213,13 +213,13 @@ SYM_FUNC_START(__camellia_enc_blk)
 	enc_outunpack(mov, RT1);
 
 	movq RR12, %r12;
-	ret;
+	RET;
 
 .L__enc_xor:
 	enc_outunpack(xor, RT1);
 
 	movq RR12, %r12;
-	ret;
+	RET;
 SYM_FUNC_END(__camellia_enc_blk)
 
 SYM_FUNC_START(camellia_dec_blk)
@@ -257,7 +257,7 @@ SYM_FUNC_START(camellia_dec_blk)
 	dec_outunpack();
 
 	movq RR12, %r12;
-	ret;
+	RET;
 SYM_FUNC_END(camellia_dec_blk)
 
 /**********************************************************************
@@ -448,14 +448,14 @@ SYM_FUNC_START(__camellia_enc_blk_2way)
 
 	movq RR12, %r12;
 	popq %rbx;
-	ret;
+	RET;
 
 .L__enc2_xor:
 	enc_outunpack2(xor, RT2);
 
 	movq RR12, %r12;
 	popq %rbx;
-	ret;
+	RET;
 SYM_FUNC_END(__camellia_enc_blk_2way)
 
 SYM_FUNC_START(camellia_dec_blk_2way)
@@ -495,5 +495,5 @@ SYM_FUNC_START(camellia_dec_blk_2way)
 
 	movq RR12, %r12;
 	movq RXOR, %rbx;
-	ret;
+	RET;
 SYM_FUNC_END(camellia_dec_blk_2way)
diff --git a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
index 8a6181b..b258af4 100644
--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -279,7 +279,7 @@ SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	outunpack_blocks(RR3, RL3, RTMP, RX, RKM);
 	outunpack_blocks(RR4, RL4, RTMP, RX, RKM);
 
-	ret;
+	RET;
 SYM_FUNC_END(__cast5_enc_blk16)
 
 .align 16
@@ -352,7 +352,7 @@ SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 	outunpack_blocks(RR3, RL3, RTMP, RX, RKM);
 	outunpack_blocks(RR4, RL4, RTMP, RX, RKM);
 
-	ret;
+	RET;
 
 .L__skip_dec:
 	vpsrldq $4, RKR, RKR;
@@ -393,7 +393,7 @@ SYM_FUNC_START(cast5_ecb_enc_16way)
 
 	popq %r15;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(cast5_ecb_enc_16way)
 
 SYM_FUNC_START(cast5_ecb_dec_16way)
@@ -431,7 +431,7 @@ SYM_FUNC_START(cast5_ecb_dec_16way)
 
 	popq %r15;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(cast5_ecb_dec_16way)
 
 SYM_FUNC_START(cast5_cbc_dec_16way)
@@ -483,7 +483,7 @@ SYM_FUNC_START(cast5_cbc_dec_16way)
 	popq %r15;
 	popq %r12;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(cast5_cbc_dec_16way)
 
 SYM_FUNC_START(cast5_ctr_16way)
@@ -559,5 +559,5 @@ SYM_FUNC_START(cast5_ctr_16way)
 	popq %r15;
 	popq %r12;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(cast5_ctr_16way)
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index fbddcec..82b716f 100644
--- a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
@@ -289,7 +289,7 @@ SYM_FUNC_START_LOCAL(__cast6_enc_blk8)
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
-	ret;
+	RET;
 SYM_FUNC_END(__cast6_enc_blk8)
 
 .align 8
@@ -336,7 +336,7 @@ SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
-	ret;
+	RET;
 SYM_FUNC_END(__cast6_dec_blk8)
 
 SYM_FUNC_START(cast6_ecb_enc_8way)
@@ -359,7 +359,7 @@ SYM_FUNC_START(cast6_ecb_enc_8way)
 
 	popq %r15;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(cast6_ecb_enc_8way)
 
 SYM_FUNC_START(cast6_ecb_dec_8way)
@@ -382,7 +382,7 @@ SYM_FUNC_START(cast6_ecb_dec_8way)
 
 	popq %r15;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(cast6_ecb_dec_8way)
 
 SYM_FUNC_START(cast6_cbc_dec_8way)
@@ -408,5 +408,5 @@ SYM_FUNC_START(cast6_cbc_dec_8way)
 	popq %r15;
 	popq %r12;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(cast6_cbc_dec_8way)
diff --git a/arch/x86/crypto/chacha-avx2-x86_64.S b/arch/x86/crypto/chacha-avx2-x86_64.S
index ee9a40a..f3d8fc0 100644
--- a/arch/x86/crypto/chacha-avx2-x86_64.S
+++ b/arch/x86/crypto/chacha-avx2-x86_64.S
@@ -193,7 +193,7 @@ SYM_FUNC_START(chacha_2block_xor_avx2)
 
 .Ldone2:
 	vzeroupper
-	ret
+	RET
 
 .Lxorpart2:
 	# xor remaining bytes from partial register into output
@@ -498,7 +498,7 @@ SYM_FUNC_START(chacha_4block_xor_avx2)
 
 .Ldone4:
 	vzeroupper
-	ret
+	RET
 
 .Lxorpart4:
 	# xor remaining bytes from partial register into output
@@ -992,7 +992,7 @@ SYM_FUNC_START(chacha_8block_xor_avx2)
 .Ldone8:
 	vzeroupper
 	lea		-8(%r10),%rsp
-	ret
+	RET
 
 .Lxorpart8:
 	# xor remaining bytes from partial register into output
diff --git a/arch/x86/crypto/chacha-avx512vl-x86_64.S b/arch/x86/crypto/chacha-avx512vl-x86_64.S
index bb193fd..946f74d 100644
--- a/arch/x86/crypto/chacha-avx512vl-x86_64.S
+++ b/arch/x86/crypto/chacha-avx512vl-x86_64.S
@@ -166,7 +166,7 @@ SYM_FUNC_START(chacha_2block_xor_avx512vl)
 
 .Ldone2:
 	vzeroupper
-	ret
+	RET
 
 .Lxorpart2:
 	# xor remaining bytes from partial register into output
@@ -432,7 +432,7 @@ SYM_FUNC_START(chacha_4block_xor_avx512vl)
 
 .Ldone4:
 	vzeroupper
-	ret
+	RET
 
 .Lxorpart4:
 	# xor remaining bytes from partial register into output
@@ -812,7 +812,7 @@ SYM_FUNC_START(chacha_8block_xor_avx512vl)
 
 .Ldone8:
 	vzeroupper
-	ret
+	RET
 
 .Lxorpart8:
 	# xor remaining bytes from partial register into output
diff --git a/arch/x86/crypto/chacha-ssse3-x86_64.S b/arch/x86/crypto/chacha-ssse3-x86_64.S
index ca1788b..7111949 100644
--- a/arch/x86/crypto/chacha-ssse3-x86_64.S
+++ b/arch/x86/crypto/chacha-ssse3-x86_64.S
@@ -108,7 +108,7 @@ SYM_FUNC_START_LOCAL(chacha_permute)
 	sub		$2,%r8d
 	jnz		.Ldoubleround
 
-	ret
+	RET
 SYM_FUNC_END(chacha_permute)
 
 SYM_FUNC_START(chacha_block_xor_ssse3)
@@ -166,7 +166,7 @@ SYM_FUNC_START(chacha_block_xor_ssse3)
 
 .Ldone:
 	FRAME_END
-	ret
+	RET
 
 .Lxorpart:
 	# xor remaining bytes from partial register into output
@@ -217,7 +217,7 @@ SYM_FUNC_START(hchacha_block_ssse3)
 	movdqu		%xmm3,0x10(%rsi)
 
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(hchacha_block_ssse3)
 
 SYM_FUNC_START(chacha_4block_xor_ssse3)
@@ -762,7 +762,7 @@ SYM_FUNC_START(chacha_4block_xor_ssse3)
 
 .Ldone4:
 	lea		-8(%r10),%rsp
-	ret
+	RET
 
 .Lxorpart4:
 	# xor remaining bytes from partial register into output
diff --git a/arch/x86/crypto/crc32-pclmul_asm.S b/arch/x86/crypto/crc32-pclmul_asm.S
index 6e7d4c4..c392a6e 100644
--- a/arch/x86/crypto/crc32-pclmul_asm.S
+++ b/arch/x86/crypto/crc32-pclmul_asm.S
@@ -236,5 +236,5 @@ fold_64:
 	pxor    %xmm2, %xmm1
 	pextrd  $0x01, %xmm1, %eax
 
-	ret
+	RET
 SYM_FUNC_END(crc32_pclmul_le_16)
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index ac1f303..80c0d22 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -306,7 +306,7 @@ do_return:
 	popq    %rsi
 	popq    %rdi
 	popq    %rbx
-        ret
+        RET
 SYM_FUNC_END(crc_pcl)
 
 .section	.rodata, "a", @progbits
diff --git a/arch/x86/crypto/crct10dif-pcl-asm_64.S b/arch/x86/crypto/crct10dif-pcl-asm_64.S
index b2533d6..721474a 100644
--- a/arch/x86/crypto/crct10dif-pcl-asm_64.S
+++ b/arch/x86/crypto/crct10dif-pcl-asm_64.S
@@ -257,7 +257,7 @@ SYM_FUNC_START(crc_t10dif_pcl)
 	# Final CRC value (x^16 * M(x)) mod G(x) is in low 16 bits of xmm0.
 
 	pextrw	$0, %xmm0, %eax
-	ret
+	RET
 
 .align 16
 .Lless_than_256_bytes:
diff --git a/arch/x86/crypto/des3_ede-asm_64.S b/arch/x86/crypto/des3_ede-asm_64.S
index fac0fdc..f4c760f 100644
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -243,7 +243,7 @@ SYM_FUNC_START(des3_ede_x86_64_crypt_blk)
 	popq %r12;
 	popq %rbx;
 
-	ret;
+	RET;
 SYM_FUNC_END(des3_ede_x86_64_crypt_blk)
 
 /***********************************************************************
@@ -528,7 +528,7 @@ SYM_FUNC_START(des3_ede_x86_64_crypt_blk_3way)
 	popq %r12;
 	popq %rbx;
 
-	ret;
+	RET;
 SYM_FUNC_END(des3_ede_x86_64_crypt_blk_3way)
 
 .section	.rodata, "a", @progbits
diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 99ac25e..2bf8718 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -85,7 +85,7 @@ SYM_FUNC_START_LOCAL(__clmul_gf128mul_ble)
 	psrlq $1, T2
 	pxor T2, T1
 	pxor T1, DATA
-	ret
+	RET
 SYM_FUNC_END(__clmul_gf128mul_ble)
 
 /* void clmul_ghash_mul(char *dst, const u128 *shash) */
@@ -99,7 +99,7 @@ SYM_FUNC_START(clmul_ghash_mul)
 	pshufb BSWAP, DATA
 	movups DATA, (%rdi)
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(clmul_ghash_mul)
 
 /*
@@ -128,5 +128,5 @@ SYM_FUNC_START(clmul_ghash_update)
 	movups DATA, (%rdi)
 .Lupdate_just_ret:
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(clmul_ghash_update)
diff --git a/arch/x86/crypto/nh-avx2-x86_64.S b/arch/x86/crypto/nh-avx2-x86_64.S
index b22c7b9..6a0b15e 100644
--- a/arch/x86/crypto/nh-avx2-x86_64.S
+++ b/arch/x86/crypto/nh-avx2-x86_64.S
@@ -153,5 +153,5 @@ SYM_FUNC_START(nh_avx2)
 	vpaddq		T1, T0, T0
 	vpaddq		T4, T0, T0
 	vmovdqu		T0, (HASH)
-	ret
+	RET
 SYM_FUNC_END(nh_avx2)
diff --git a/arch/x86/crypto/nh-sse2-x86_64.S b/arch/x86/crypto/nh-sse2-x86_64.S
index d7ae22d..34c567b 100644
--- a/arch/x86/crypto/nh-sse2-x86_64.S
+++ b/arch/x86/crypto/nh-sse2-x86_64.S
@@ -119,5 +119,5 @@ SYM_FUNC_START(nh_sse2)
 	paddq		PASS2_SUMS, T1
 	movdqu		T0, 0x00(HASH)
 	movdqu		T1, 0x10(HASH)
-	ret
+	RET
 SYM_FUNC_END(nh_sse2)
diff --git a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
index b7ee24d..82f2313 100644
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -601,7 +601,7 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk8_avx)
 	write_blocks(RA1, RB1, RC1, RD1, RK0, RK1, RK2);
 	write_blocks(RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
-	ret;
+	RET;
 SYM_FUNC_END(__serpent_enc_blk8_avx)
 
 .align 8
@@ -655,7 +655,7 @@ SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	write_blocks(RC1, RD1, RB1, RE1, RK0, RK1, RK2);
 	write_blocks(RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
-	ret;
+	RET;
 SYM_FUNC_END(__serpent_dec_blk8_avx)
 
 SYM_FUNC_START(serpent_ecb_enc_8way_avx)
@@ -673,7 +673,7 @@ SYM_FUNC_START(serpent_ecb_enc_8way_avx)
 	store_8way(%rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2);
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(serpent_ecb_enc_8way_avx)
 
 SYM_FUNC_START(serpent_ecb_dec_8way_avx)
@@ -691,7 +691,7 @@ SYM_FUNC_START(serpent_ecb_dec_8way_avx)
 	store_8way(%rsi, RC1, RD1, RB1, RE1, RC2, RD2, RB2, RE2);
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(serpent_ecb_dec_8way_avx)
 
 SYM_FUNC_START(serpent_cbc_dec_8way_avx)
@@ -709,5 +709,5 @@ SYM_FUNC_START(serpent_cbc_dec_8way_avx)
 	store_cbc_8way(%rdx, %rsi, RC1, RD1, RB1, RE1, RC2, RD2, RB2, RE2);
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(serpent_cbc_dec_8way_avx)
diff --git a/arch/x86/crypto/serpent-avx2-asm_64.S b/arch/x86/crypto/serpent-avx2-asm_64.S
index 9161b6e..8ea34c9 100644
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -601,7 +601,7 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk16)
 	write_blocks(RA1, RB1, RC1, RD1, RK0, RK1, RK2);
 	write_blocks(RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
-	ret;
+	RET;
 SYM_FUNC_END(__serpent_enc_blk16)
 
 .align 8
@@ -655,7 +655,7 @@ SYM_FUNC_START_LOCAL(__serpent_dec_blk16)
 	write_blocks(RC1, RD1, RB1, RE1, RK0, RK1, RK2);
 	write_blocks(RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
-	ret;
+	RET;
 SYM_FUNC_END(__serpent_dec_blk16)
 
 SYM_FUNC_START(serpent_ecb_enc_16way)
@@ -677,7 +677,7 @@ SYM_FUNC_START(serpent_ecb_enc_16way)
 	vzeroupper;
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(serpent_ecb_enc_16way)
 
 SYM_FUNC_START(serpent_ecb_dec_16way)
@@ -699,7 +699,7 @@ SYM_FUNC_START(serpent_ecb_dec_16way)
 	vzeroupper;
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(serpent_ecb_dec_16way)
 
 SYM_FUNC_START(serpent_cbc_dec_16way)
@@ -722,5 +722,5 @@ SYM_FUNC_START(serpent_cbc_dec_16way)
 	vzeroupper;
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(serpent_cbc_dec_16way)
diff --git a/arch/x86/crypto/serpent-sse2-i586-asm_32.S b/arch/x86/crypto/serpent-sse2-i586-asm_32.S
index 6379b99..8ccb03a 100644
--- a/arch/x86/crypto/serpent-sse2-i586-asm_32.S
+++ b/arch/x86/crypto/serpent-sse2-i586-asm_32.S
@@ -553,12 +553,12 @@ SYM_FUNC_START(__serpent_enc_blk_4way)
 
 	write_blocks(%eax, RA, RB, RC, RD, RT0, RT1, RE);
 
-	ret;
+	RET;
 
 .L__enc_xor4:
 	xor_blocks(%eax, RA, RB, RC, RD, RT0, RT1, RE);
 
-	ret;
+	RET;
 SYM_FUNC_END(__serpent_enc_blk_4way)
 
 SYM_FUNC_START(serpent_dec_blk_4way)
@@ -612,5 +612,5 @@ SYM_FUNC_START(serpent_dec_blk_4way)
 	movl arg_dst(%esp), %eax;
 	write_blocks(%eax, RC, RD, RB, RE, RT0, RT1, RA);
 
-	ret;
+	RET;
 SYM_FUNC_END(serpent_dec_blk_4way)
diff --git a/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S b/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
index efb6dc1..e0998a0 100644
--- a/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
@@ -675,13 +675,13 @@ SYM_FUNC_START(__serpent_enc_blk_8way)
 	write_blocks(%rsi, RA1, RB1, RC1, RD1, RK0, RK1, RK2);
 	write_blocks(%rax, RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
-	ret;
+	RET;
 
 .L__enc_xor8:
 	xor_blocks(%rsi, RA1, RB1, RC1, RD1, RK0, RK1, RK2);
 	xor_blocks(%rax, RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
-	ret;
+	RET;
 SYM_FUNC_END(__serpent_enc_blk_8way)
 
 SYM_FUNC_START(serpent_dec_blk_8way)
@@ -735,5 +735,5 @@ SYM_FUNC_START(serpent_dec_blk_8way)
 	write_blocks(%rsi, RC1, RD1, RB1, RE1, RK0, RK1, RK2);
 	write_blocks(%rax, RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
-	ret;
+	RET;
 SYM_FUNC_END(serpent_dec_blk_8way)
diff --git a/arch/x86/crypto/sha1_avx2_x86_64_asm.S b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
index 5eed620..a96b2fd 100644
--- a/arch/x86/crypto/sha1_avx2_x86_64_asm.S
+++ b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
@@ -674,7 +674,7 @@ _loop3:
 	pop	%r12
 	pop	%rbx
 
-	ret
+	RET
 
 	SYM_FUNC_END(\name)
 .endm
diff --git a/arch/x86/crypto/sha1_ni_asm.S b/arch/x86/crypto/sha1_ni_asm.S
index 5d8415f..2f94ec0 100644
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@ -290,7 +290,7 @@ SYM_FUNC_START(sha1_ni_transform)
 	mov		%rbp, %rsp
 	pop		%rbp
 
-	ret
+	RET
 SYM_FUNC_END(sha1_ni_transform)
 
 .section	.rodata.cst16.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 16
diff --git a/arch/x86/crypto/sha1_ssse3_asm.S b/arch/x86/crypto/sha1_ssse3_asm.S
index d25668d..263f916 100644
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -99,7 +99,7 @@
 	pop	%rbp
 	pop	%r12
 	pop	%rbx
-	ret
+	RET
 
 	SYM_FUNC_END(\name)
 .endm
diff --git a/arch/x86/crypto/sha256-avx-asm.S b/arch/x86/crypto/sha256-avx-asm.S
index 4739cd3..3baa1ec 100644
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/crypto/sha256-avx-asm.S
@@ -458,7 +458,7 @@ done_hash:
 	popq    %r13
 	popq	%r12
 	popq    %rbx
-	ret
+	RET
 SYM_FUNC_END(sha256_transform_avx)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 4087f74..9bcdbc4 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -710,7 +710,7 @@ done_hash:
 	popq	%r13
 	popq	%r12
 	popq	%rbx
-	ret
+	RET
 SYM_FUNC_END(sha256_transform_rorx)
 
 .section	.rodata.cst512.K256, "aM", @progbits, 512
diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/crypto/sha256-ssse3-asm.S
index ddfa863..c4a5db6 100644
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/crypto/sha256-ssse3-asm.S
@@ -472,7 +472,7 @@ done_hash:
 	popq    %r12
 	popq    %rbx
 
-	ret
+	RET
 SYM_FUNC_END(sha256_transform_ssse3)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index 7abade0..94d50dd 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -326,7 +326,7 @@ SYM_FUNC_START(sha256_ni_transform)
 
 .Ldone_hash:
 
-	ret
+	RET
 SYM_FUNC_END(sha256_ni_transform)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index 3d8f0fd..1fefe6d 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -361,7 +361,7 @@ updateblock:
 	pop	%rbx
 
 nowork:
-	ret
+	RET
 SYM_FUNC_END(sha512_transform_avx)
 
 ########################################################################
diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index 072cb0f..5cdaab7 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -679,7 +679,7 @@ done_hash:
 	pop	%r12
 	pop	%rbx
 
-	ret
+	RET
 SYM_FUNC_END(sha512_transform_rorx)
 
 ########################################################################
diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
index bd51c90..b84c22e 100644
--- a/arch/x86/crypto/sha512-ssse3-asm.S
+++ b/arch/x86/crypto/sha512-ssse3-asm.S
@@ -363,7 +363,7 @@ updateblock:
 	pop	%rbx
 
 nowork:
-	ret
+	RET
 SYM_FUNC_END(sha512_transform_ssse3)
 
 ########################################################################
diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
index 1cc72b4..4767ab6 100644
--- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
@@ -246,7 +246,7 @@ SYM_FUNC_START(sm4_aesni_avx_crypt4)
 .Lblk4_store_output_done:
 	vzeroall;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(sm4_aesni_avx_crypt4)
 
 .align 8
@@ -356,7 +356,7 @@ SYM_FUNC_START_LOCAL(__sm4_crypt_blk8)
 	vpshufb RTMP2, RB3, RB3;
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(__sm4_crypt_blk8)
 
 /*
@@ -412,7 +412,7 @@ SYM_FUNC_START(sm4_aesni_avx_crypt8)
 .Lblk8_store_output_done:
 	vzeroall;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(sm4_aesni_avx_crypt8)
 
 /*
@@ -487,7 +487,7 @@ SYM_FUNC_START(sm4_aesni_avx_ctr_enc_blk8)
 
 	vzeroall;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(sm4_aesni_avx_ctr_enc_blk8)
 
 /*
@@ -537,7 +537,7 @@ SYM_FUNC_START(sm4_aesni_avx_cbc_dec_blk8)
 
 	vzeroall;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(sm4_aesni_avx_cbc_dec_blk8)
 
 /*
@@ -590,5 +590,5 @@ SYM_FUNC_START(sm4_aesni_avx_cfb_dec_blk8)
 
 	vzeroall;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(sm4_aesni_avx_cfb_dec_blk8)
diff --git a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
index 9c5d3f3..4732fe8 100644
--- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
@@ -268,7 +268,7 @@ SYM_FUNC_START_LOCAL(__sm4_crypt_blk16)
 	vpshufb RTMP2, RB3, RB3;
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(__sm4_crypt_blk16)
 
 #define inc_le128(x, minus_one, tmp) \
@@ -387,7 +387,7 @@ SYM_FUNC_START(sm4_aesni_avx2_ctr_enc_blk16)
 
 	vzeroall;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(sm4_aesni_avx2_ctr_enc_blk16)
 
 /*
@@ -441,7 +441,7 @@ SYM_FUNC_START(sm4_aesni_avx2_cbc_dec_blk16)
 
 	vzeroall;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(sm4_aesni_avx2_cbc_dec_blk16)
 
 /*
@@ -497,5 +497,5 @@ SYM_FUNC_START(sm4_aesni_avx2_cfb_dec_blk16)
 
 	vzeroall;
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(sm4_aesni_avx2_cfb_dec_blk16)
diff --git a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
index 37e63b3..31f9b2e 100644
--- a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
@@ -267,7 +267,7 @@ SYM_FUNC_START_LOCAL(__twofish_enc_blk8)
 	outunpack_blocks(RC1, RD1, RA1, RB1, RK1, RX0, RY0, RK2);
 	outunpack_blocks(RC2, RD2, RA2, RB2, RK1, RX0, RY0, RK2);
 
-	ret;
+	RET;
 SYM_FUNC_END(__twofish_enc_blk8)
 
 .align 8
@@ -307,7 +307,7 @@ SYM_FUNC_START_LOCAL(__twofish_dec_blk8)
 	outunpack_blocks(RA1, RB1, RC1, RD1, RK1, RX0, RY0, RK2);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RK1, RX0, RY0, RK2);
 
-	ret;
+	RET;
 SYM_FUNC_END(__twofish_dec_blk8)
 
 SYM_FUNC_START(twofish_ecb_enc_8way)
@@ -327,7 +327,7 @@ SYM_FUNC_START(twofish_ecb_enc_8way)
 	store_8way(%r11, RC1, RD1, RA1, RB1, RC2, RD2, RA2, RB2);
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(twofish_ecb_enc_8way)
 
 SYM_FUNC_START(twofish_ecb_dec_8way)
@@ -347,7 +347,7 @@ SYM_FUNC_START(twofish_ecb_dec_8way)
 	store_8way(%r11, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2);
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(twofish_ecb_dec_8way)
 
 SYM_FUNC_START(twofish_cbc_dec_8way)
@@ -372,5 +372,5 @@ SYM_FUNC_START(twofish_cbc_dec_8way)
 	popq %r12;
 
 	FRAME_END
-	ret;
+	RET;
 SYM_FUNC_END(twofish_cbc_dec_8way)
diff --git a/arch/x86/crypto/twofish-i586-asm_32.S b/arch/x86/crypto/twofish-i586-asm_32.S
index a6f09e4..3abcad6 100644
--- a/arch/x86/crypto/twofish-i586-asm_32.S
+++ b/arch/x86/crypto/twofish-i586-asm_32.S
@@ -260,7 +260,7 @@ SYM_FUNC_START(twofish_enc_blk)
 	pop	%ebx
 	pop	%ebp
 	mov	$1,	%eax
-	ret
+	RET
 SYM_FUNC_END(twofish_enc_blk)
 
 SYM_FUNC_START(twofish_dec_blk)
@@ -317,5 +317,5 @@ SYM_FUNC_START(twofish_dec_blk)
 	pop	%ebx
 	pop	%ebp
 	mov	$1,	%eax
-	ret
+	RET
 SYM_FUNC_END(twofish_dec_blk)
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
index bca4cea..d2288bf 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
@@ -258,7 +258,7 @@ SYM_FUNC_START(__twofish_enc_blk_3way)
 	popq %rbx;
 	popq %r12;
 	popq %r13;
-	ret;
+	RET;
 
 .L__enc_xor3:
 	outunpack_enc3(xor);
@@ -266,7 +266,7 @@ SYM_FUNC_START(__twofish_enc_blk_3way)
 	popq %rbx;
 	popq %r12;
 	popq %r13;
-	ret;
+	RET;
 SYM_FUNC_END(__twofish_enc_blk_3way)
 
 SYM_FUNC_START(twofish_dec_blk_3way)
@@ -301,5 +301,5 @@ SYM_FUNC_START(twofish_dec_blk_3way)
 	popq %rbx;
 	popq %r12;
 	popq %r13;
-	ret;
+	RET;
 SYM_FUNC_END(twofish_dec_blk_3way)
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64.S b/arch/x86/crypto/twofish-x86_64-asm_64.S
index d2e5623..775af29 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64.S
@@ -252,7 +252,7 @@ SYM_FUNC_START(twofish_enc_blk)
 
 	popq	R1
 	movl	$1,%eax
-	ret
+	RET
 SYM_FUNC_END(twofish_enc_blk)
 
 SYM_FUNC_START(twofish_dec_blk)
@@ -304,5 +304,5 @@ SYM_FUNC_START(twofish_dec_blk)
 
 	popq	R1
 	movl	$1,%eax
-	ret
+	RET
 SYM_FUNC_END(twofish_dec_blk)
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ccb9d32..00413e3 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -740,7 +740,7 @@ SYM_FUNC_START(schedule_tail_wrapper)
 	popl	%eax
 
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(schedule_tail_wrapper)
 .popsection
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 97b1f84..e23319a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -738,7 +738,7 @@ SYM_FUNC_START(asm_load_gs_index)
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
 	swapgs
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(asm_load_gs_index)
 EXPORT_SYMBOL(asm_load_gs_index)
 
@@ -889,7 +889,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * is needed here.
 	 */
 	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
-	ret
+	RET
 
 .Lparanoid_entry_checkgs:
 	/* EBX = 1 -> kernel GSBASE active, no restore required */
@@ -910,7 +910,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 .Lparanoid_kernel_gsbase:
 
 	FENCE_SWAPGS_KERNEL_ENTRY
-	ret
+	RET
 SYM_CODE_END(paranoid_entry)
 
 /*
@@ -989,7 +989,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	movq	%rax, %rsp			/* switch stack */
 	ENCODE_FRAME_POINTER
 	pushq	%r12
-	ret
+	RET
 
 	/*
 	 * There are two places in the kernel that can potentially fault with
@@ -1020,7 +1020,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
-	ret
+	RET
 
 .Lbstep_iret:
 	/* Fix truncated RIP */
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index f1f96d4..7591bab 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -24,7 +24,7 @@ SYM_CODE_START_NOALIGN(\name)
 	popl %edx
 	popl %ecx
 	popl %eax
-	ret
+	RET
 	_ASM_NOKPROBE(\name)
 SYM_CODE_END(\name)
 	.endm
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 496b11e..505b488 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -50,7 +50,7 @@ SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %rsi
 	popq %rdi
 	popq %rbp
-	ret
+	RET
 	_ASM_NOKPROBE(__thunk_restore)
 SYM_CODE_END(__thunk_restore)
 #endif
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index 6ddd7a9..d33c651 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -78,7 +78,7 @@ SYM_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)
 	popl	%ecx
 	CFI_RESTORE		ecx
 	CFI_ADJUST_CFA_OFFSET	-4
-	ret
+	RET
 	CFI_ENDPROC
 
 	.size __kernel_vsyscall,.-__kernel_vsyscall
diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index 99dafac..d77d278 100644
--- a/arch/x86/entry/vdso/vsgx.S
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -81,7 +81,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 	pop	%rbx
 	leave
 	.cfi_def_cfa		%rsp, 8
-	ret
+	RET
 
 	/* The out-of-line code runs with the pre-leave stack frame. */
 	.cfi_def_cfa		%rbp, 16
diff --git a/arch/x86/entry/vsyscall/vsyscall_emu_64.S b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
index 2e203f3..15e3515 100644
--- a/arch/x86/entry/vsyscall/vsyscall_emu_64.S
+++ b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
@@ -19,17 +19,17 @@ __vsyscall_page:
 
 	mov $__NR_gettimeofday, %rax
 	syscall
-	ret
+	RET
 
 	.balign 1024, 0xcc
 	mov $__NR_time, %rax
 	syscall
-	ret
+	RET
 
 	.balign 1024, 0xcc
 	mov $__NR_getcpu, %rax
 	syscall
-	ret
+	RET
 
 	.balign 4096, 0xcc
 
diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index daf88f8..cf69081 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -60,7 +60,7 @@ save_registers:
 	popl	saved_context_eflags
 
 	movl	$ret_point, saved_eip
-	ret
+	RET
 
 
 restore_registers:
@@ -70,7 +70,7 @@ restore_registers:
 	movl	saved_context_edi, %edi
 	pushl	saved_context_eflags
 	popfl
-	ret
+	RET
 
 SYM_CODE_START(do_suspend_lowlevel)
 	call	save_processor_state
@@ -86,7 +86,7 @@ SYM_CODE_START(do_suspend_lowlevel)
 ret_point:
 	call	restore_registers
 	call	restore_processor_state
-	ret
+	RET
 SYM_CODE_END(do_suspend_lowlevel)
 
 .data
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index e405fe1..a0ed0e4 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -19,7 +19,7 @@
 #endif
 
 SYM_FUNC_START(__fentry__)
-	ret
+	RET
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 
@@ -84,7 +84,7 @@ ftrace_graph_call:
 
 /* This is weak to keep gas from relaxing the jumps */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
-	ret
+	RET
 SYM_CODE_END(ftrace_caller)
 
 SYM_CODE_START(ftrace_regs_caller)
@@ -177,7 +177,7 @@ SYM_CODE_START(ftrace_graph_caller)
 	popl	%edx
 	popl	%ecx
 	popl	%eax
-	ret
+	RET
 SYM_CODE_END(ftrace_graph_caller)
 
 .globl return_to_handler
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 7a87990..11ac028 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -132,7 +132,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 SYM_FUNC_START(__fentry__)
-	retq
+	RET
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 
@@ -176,11 +176,11 @@ SYM_FUNC_END(ftrace_caller);
 SYM_FUNC_START(ftrace_epilogue)
 /*
  * This is weak to keep gas from relaxing the jumps.
- * It is also used to copy the retq for trampolines.
+ * It is also used to copy the RET for trampolines.
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	UNWIND_HINT_FUNC
-	retq
+	RET
 SYM_FUNC_END(ftrace_epilogue)
 
 SYM_FUNC_START(ftrace_regs_caller)
@@ -284,7 +284,7 @@ SYM_FUNC_START(__fentry__)
 	jnz trace
 
 SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
-	retq
+	RET
 
 trace:
 	/* save_mcount_regs fills in first two parameters */
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index d8c64da..eb8656b 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -340,7 +340,7 @@ SYM_FUNC_END(startup_32_smp)
 __INIT
 setup_once:
 	andl $0,setup_once_ref	/* Once is enough, thanks */
-	ret
+	RET
 
 SYM_FUNC_START(early_idt_handler_array)
 	# 36(%esp) %eflags
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index 760e1f2..aaf9e77 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -11,7 +11,7 @@
 SYM_FUNC_START(native_save_fl)
 	pushf
 	pop %_ASM_AX
-	ret
+	RET
 SYM_FUNC_END(native_save_fl)
 .popsection
 EXPORT_SYMBOL(native_save_fl)
diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index f469153..fcc8a76 100644
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -91,7 +91,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movl    %edi, %eax
 	addl    $(identity_mapped - relocate_kernel), %eax
 	pushl   %eax
-	ret
+	RET
 SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
@@ -159,7 +159,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	xorl    %edx, %edx
 	xorl    %esi, %esi
 	xorl    %ebp, %ebp
-	ret
+	RET
 1:
 	popl	%edx
 	movl	CP_PA_SWAP_PAGE(%edi), %esp
@@ -190,7 +190,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movl	%edi, %eax
 	addl	$(virtual_mapped - relocate_kernel), %eax
 	pushl	%eax
-	ret
+	RET
 SYM_CODE_END(identity_mapped)
 
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
@@ -208,7 +208,7 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	popl	%edi
 	popl	%esi
 	popl	%ebx
-	ret
+	RET
 SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
@@ -271,7 +271,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	popl	%edi
 	popl	%ebx
 	popl	%ebp
-	ret
+	RET
 SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c8fe74a..399f075 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -104,7 +104,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* jump to identity mapped page */
 	addq	$(identity_mapped - relocate_kernel), %r8
 	pushq	%r8
-	ret
+	RET
 SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
@@ -191,7 +191,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	xorl	%r14d, %r14d
 	xorl	%r15d, %r15d
 
-	ret
+	RET
 
 1:
 	popq	%rdx
@@ -210,7 +210,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	call	swap_pages
 	movq	$virtual_mapped, %rax
 	pushq	%rax
-	ret
+	RET
 SYM_CODE_END(identity_mapped)
 
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
@@ -231,7 +231,7 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	popq	%r12
 	popq	%rbp
 	popq	%rbx
-	ret
+	RET
 SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
@@ -288,7 +288,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	lea	PAGE_SIZE(%rax), %rsi
 	jmp	0b
 3:
-	ret
+	RET
 SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
index ee04941..3355e27 100644
--- a/arch/x86/kernel/sev_verify_cbit.S
+++ b/arch/x86/kernel/sev_verify_cbit.S
@@ -85,5 +85,5 @@ SYM_FUNC_START(sev_verify_cbit)
 #endif
 	/* Return page-table pointer */
 	movq	%rdi, %rax
-	ret
+	RET
 SYM_FUNC_END(sev_verify_cbit)
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index 641f0fe..1258a58 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -132,9 +132,9 @@ SYM_FUNC_START_LOCAL(verify_cpu)
 .Lverify_cpu_no_longmode:
 	popf				# Restore caller passed flags
 	movl $1,%eax
-	ret
+	RET
 .Lverify_cpu_sse_ok:
 	popf				# Restore caller passed flags
 	xorl %eax, %eax
-	ret
+	RET
 SYM_FUNC_END(verify_cpu)
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 4fa17df..dfaeb47 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -148,7 +148,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	pop %edi
 #endif
 	pop %_ASM_BP
-	ret
+	RET
 
 3:	cmpb $0, kvm_rebooting
 	jne 2b
@@ -202,7 +202,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	pop %edi
 #endif
 	pop %_ASM_BP
-	ret
+	RET
 
 3:	cmpb $0, kvm_rebooting
 	jne 2b
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 3a64616..435c187 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -49,14 +49,14 @@ SYM_FUNC_START_LOCAL(vmx_vmenter)
 	je 2f
 
 1:	vmresume
-	ret
+	RET
 
 2:	vmlaunch
-	ret
+	RET
 
 3:	cmpb $0, kvm_rebooting
 	je 4f
-	ret
+	RET
 4:	ud2
 
 	_ASM_EXTABLE(1b, 3b)
@@ -89,7 +89,7 @@ SYM_FUNC_START(vmx_vmexit)
 	pop %_ASM_AX
 .Lvmexit_skip_rsb:
 #endif
-	ret
+	RET
 SYM_FUNC_END(vmx_vmexit)
 
 /**
@@ -228,7 +228,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	pop %edi
 #endif
 	pop %_ASM_BP
-	ret
+	RET
 
 	/* VM-Fail.  Out-of-line to avoid a taken Jcc after VM-Exit. */
 2:	mov $1, %eax
@@ -293,7 +293,7 @@ SYM_FUNC_START(vmread_error_trampoline)
 	pop %_ASM_AX
 	pop %_ASM_BP
 
-	ret
+	RET
 SYM_FUNC_END(vmread_error_trampoline)
 
 SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
@@ -326,5 +326,5 @@ SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
 	 */
 	mov %_ASM_BP, %_ASM_SP
 	pop %_ASM_BP
-	ret
+	RET
 SYM_FUNC_END(vmx_do_interrupt_nmi_irqoff)
diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
index 4ad6b97..e768815 100644
--- a/arch/x86/lib/atomic64_386_32.S
+++ b/arch/x86/lib/atomic64_386_32.S
@@ -30,7 +30,7 @@ SYM_FUNC_START(atomic64_##op##_386); \
 
 #define RET_IRQ_RESTORE \
 	IRQ_RESTORE v; \
-	ret
+	RET
 
 #define v %ecx
 BEGIN_IRQ_SAVE(read)
diff --git a/arch/x86/lib/atomic64_cx8_32.S b/arch/x86/lib/atomic64_cx8_32.S
index ce69356..90afb48 100644
--- a/arch/x86/lib/atomic64_cx8_32.S
+++ b/arch/x86/lib/atomic64_cx8_32.S
@@ -18,7 +18,7 @@
 
 SYM_FUNC_START(atomic64_read_cx8)
 	read64 %ecx
-	ret
+	RET
 SYM_FUNC_END(atomic64_read_cx8)
 
 SYM_FUNC_START(atomic64_set_cx8)
@@ -28,7 +28,7 @@ SYM_FUNC_START(atomic64_set_cx8)
 	cmpxchg8b (%esi)
 	jne 1b
 
-	ret
+	RET
 SYM_FUNC_END(atomic64_set_cx8)
 
 SYM_FUNC_START(atomic64_xchg_cx8)
@@ -37,7 +37,7 @@ SYM_FUNC_START(atomic64_xchg_cx8)
 	cmpxchg8b (%esi)
 	jne 1b
 
-	ret
+	RET
 SYM_FUNC_END(atomic64_xchg_cx8)
 
 .macro addsub_return func ins insc
@@ -68,7 +68,7 @@ SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	popl %esi
 	popl %ebx
 	popl %ebp
-	ret
+	RET
 SYM_FUNC_END(atomic64_\func\()_return_cx8)
 .endm
 
@@ -93,7 +93,7 @@ SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	movl %ebx, %eax
 	movl %ecx, %edx
 	popl %ebx
-	ret
+	RET
 SYM_FUNC_END(atomic64_\func\()_return_cx8)
 .endm
 
@@ -118,7 +118,7 @@ SYM_FUNC_START(atomic64_dec_if_positive_cx8)
 	movl %ebx, %eax
 	movl %ecx, %edx
 	popl %ebx
-	ret
+	RET
 SYM_FUNC_END(atomic64_dec_if_positive_cx8)
 
 SYM_FUNC_START(atomic64_add_unless_cx8)
@@ -149,7 +149,7 @@ SYM_FUNC_START(atomic64_add_unless_cx8)
 	addl $8, %esp
 	popl %ebx
 	popl %ebp
-	ret
+	RET
 4:
 	cmpl %edx, 4(%esp)
 	jne 2b
@@ -176,5 +176,5 @@ SYM_FUNC_START(atomic64_inc_not_zero_cx8)
 	movl $1, %eax
 3:
 	popl %ebx
-	ret
+	RET
 SYM_FUNC_END(atomic64_inc_not_zero_cx8)
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 4304320..929ad17 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -127,7 +127,7 @@ SYM_FUNC_START(csum_partial)
 8:
 	popl %ebx
 	popl %esi
-	ret
+	RET
 SYM_FUNC_END(csum_partial)
 
 #else
@@ -245,7 +245,7 @@ SYM_FUNC_START(csum_partial)
 90: 
 	popl %ebx
 	popl %esi
-	ret
+	RET
 SYM_FUNC_END(csum_partial)
 				
 #endif
@@ -371,7 +371,7 @@ EXC(	movb %cl, (%edi)	)
 	popl %esi
 	popl %edi
 	popl %ecx			# equivalent to addl $4,%esp
-	ret	
+	RET
 SYM_FUNC_END(csum_partial_copy_generic)
 
 #else
@@ -447,7 +447,7 @@ EXC(	movb %dl, (%edi)         )
 	popl %esi
 	popl %edi
 	popl %ebx
-	ret
+	RET
 SYM_FUNC_END(csum_partial_copy_generic)
 				
 #undef ROUND
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index c4c7dd1..fe59b8a 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -17,7 +17,7 @@ SYM_FUNC_START(clear_page_rep)
 	movl $4096/8,%ecx
 	xorl %eax,%eax
 	rep stosq
-	ret
+	RET
 SYM_FUNC_END(clear_page_rep)
 EXPORT_SYMBOL_GPL(clear_page_rep)
 
@@ -39,7 +39,7 @@ SYM_FUNC_START(clear_page_orig)
 	leaq	64(%rdi),%rdi
 	jnz	.Lloop
 	nop
-	ret
+	RET
 SYM_FUNC_END(clear_page_orig)
 EXPORT_SYMBOL_GPL(clear_page_orig)
 
@@ -47,6 +47,6 @@ SYM_FUNC_START(clear_page_erms)
 	movl $4096,%ecx
 	xorl %eax,%eax
 	rep stosb
-	ret
+	RET
 SYM_FUNC_END(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu.S
index 3542502..33c70c0 100644
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -37,11 +37,11 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 
 	popfq
 	mov $1, %al
-	ret
+	RET
 
 .Lnot_same:
 	popfq
 	xor %al,%al
-	ret
+	RET
 
 SYM_FUNC_END(this_cpu_cmpxchg16b_emu)
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index ca01ed6..6a912d5 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -32,7 +32,7 @@ SYM_FUNC_START(cmpxchg8b_emu)
 	movl %ecx, 4(%esi)
 
 	popfl
-	ret
+	RET
 
 .Lnot_same:
 	movl  (%esi), %eax
@@ -40,7 +40,7 @@ SYM_FUNC_START(cmpxchg8b_emu)
 	movl 4(%esi), %edx
 
 	popfl
-	ret
+	RET
 
 SYM_FUNC_END(cmpxchg8b_emu)
 EXPORT_SYMBOL(cmpxchg8b_emu)
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index 7334055..2300979 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -77,7 +77,7 @@ SYM_FUNC_START(copy_mc_fragile)
 .L_done_memcpy_trap:
 	xorl %eax, %eax
 .L_done:
-	ret
+	RET
 SYM_FUNC_END(copy_mc_fragile)
 
 	.section .fixup, "ax"
@@ -132,7 +132,7 @@ SYM_FUNC_START(copy_mc_enhanced_fast_string)
 	rep movsb
 	/* Copy successful. Return zero */
 	xorl %eax, %eax
-	ret
+	RET
 SYM_FUNC_END(copy_mc_enhanced_fast_string)
 
 	.section .fixup, "ax"
@@ -145,7 +145,7 @@ SYM_FUNC_END(copy_mc_enhanced_fast_string)
 	 * user-copy routines.
 	 */
 	movq %rcx, %rax
-	ret
+	RET
 
 	.previous
 
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index db4b4f9..30ea644 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -17,7 +17,7 @@ SYM_FUNC_START(copy_page)
 	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
 	movl	$4096/8, %ecx
 	rep	movsq
-	ret
+	RET
 SYM_FUNC_END(copy_page)
 EXPORT_SYMBOL(copy_page)
 
@@ -85,5 +85,5 @@ SYM_FUNC_START_LOCAL(copy_page_regs)
 	movq	(%rsp), %rbx
 	movq	1*8(%rsp), %r12
 	addq	$2*8, %rsp
-	ret
+	RET
 SYM_FUNC_END(copy_page_regs)
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 2797e63..8fb562f 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -105,7 +105,7 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 	jnz 21b
 23:	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 
 	.section .fixup,"ax"
 30:	shll $6,%ecx
@@ -173,7 +173,7 @@ SYM_FUNC_START(copy_user_generic_string)
 	movsb
 	xorl %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 
 	.section .fixup,"ax"
 11:	leal (%rdx,%rcx,8),%ecx
@@ -207,7 +207,7 @@ SYM_FUNC_START(copy_user_enhanced_fast_string)
 	movsb
 	xorl %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 
 	.section .fixup,"ax"
 12:	movl %ecx,%edx		/* ecx is zerorest also */
@@ -237,7 +237,7 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
-	ret
+	RET
 
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
@@ -348,7 +348,7 @@ SYM_FUNC_START(__copy_user_nocache)
 	xorl %eax,%eax
 	ASM_CLAC
 	sfence
-	ret
+	RET
 
 	.section .fixup,"ax"
 .L_fixup_4x8b_copy:
diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index 1fbd8ee..d9e16a2 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -201,7 +201,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	movq 3*8(%rsp), %r13
 	movq 4*8(%rsp), %r15
 	addq $5*8, %rsp
-	ret
+	RET
 .Lshort:
 	movl %ecx, %r10d
 	jmp  .L1
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index fa1bc21..b70d98d 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -57,7 +57,7 @@ SYM_FUNC_START(__get_user_1)
 1:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
@@ -71,7 +71,7 @@ SYM_FUNC_START(__get_user_2)
 2:	movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
@@ -85,7 +85,7 @@ SYM_FUNC_START(__get_user_4)
 3:	movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
@@ -100,7 +100,7 @@ SYM_FUNC_START(__get_user_8)
 4:	movq (%_ASM_AX),%rdx
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 #else
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_DX,%_ASM_AX
@@ -112,7 +112,7 @@ SYM_FUNC_START(__get_user_8)
 5:	movl 4(%_ASM_AX),%ecx
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 #endif
 SYM_FUNC_END(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
@@ -124,7 +124,7 @@ SYM_FUNC_START(__get_user_nocheck_1)
 6:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__get_user_nocheck_1)
 EXPORT_SYMBOL(__get_user_nocheck_1)
 
@@ -134,7 +134,7 @@ SYM_FUNC_START(__get_user_nocheck_2)
 7:	movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__get_user_nocheck_2)
 EXPORT_SYMBOL(__get_user_nocheck_2)
 
@@ -144,7 +144,7 @@ SYM_FUNC_START(__get_user_nocheck_4)
 8:	movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__get_user_nocheck_4)
 EXPORT_SYMBOL(__get_user_nocheck_4)
 
@@ -159,7 +159,7 @@ SYM_FUNC_START(__get_user_nocheck_8)
 #endif
 	xor %eax,%eax
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__get_user_nocheck_8)
 EXPORT_SYMBOL(__get_user_nocheck_8)
 
@@ -169,7 +169,7 @@ SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
 bad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
-	ret
+	RET
 SYM_CODE_END(.Lbad_get_user_clac)
 
 #ifdef CONFIG_X86_32
@@ -179,7 +179,7 @@ bad_get_user_8:
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX
-	ret
+	RET
 SYM_CODE_END(.Lbad_get_user_8_clac)
 #endif
 
diff --git a/arch/x86/lib/hweight.S b/arch/x86/lib/hweight.S
index dbf8cc9..12c16c6 100644
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -32,7 +32,7 @@ SYM_FUNC_START(__sw_hweight32)
 	imull $0x01010101, %eax, %eax		# w_tmp *= 0x01010101
 	shrl $24, %eax				# w = w_tmp >> 24
 	__ASM_SIZE(pop,) %__ASM_REG(dx)
-	ret
+	RET
 SYM_FUNC_END(__sw_hweight32)
 EXPORT_SYMBOL(__sw_hweight32)
 
@@ -65,7 +65,7 @@ SYM_FUNC_START(__sw_hweight64)
 
 	popq    %rdx
 	popq    %rdi
-	ret
+	RET
 #else /* CONFIG_X86_32 */
 	/* We're getting an u64 arg in (%eax,%edx): unsigned long hweight64(__u64 w) */
 	pushl   %ecx
@@ -77,7 +77,7 @@ SYM_FUNC_START(__sw_hweight64)
 	addl    %ecx, %eax                      # result
 
 	popl    %ecx
-	ret
+	RET
 #endif
 SYM_FUNC_END(__sw_hweight64)
 EXPORT_SYMBOL(__sw_hweight64)
diff --git a/arch/x86/lib/iomap_copy_64.S b/arch/x86/lib/iomap_copy_64.S
index cb5a196..a1f9416 100644
--- a/arch/x86/lib/iomap_copy_64.S
+++ b/arch/x86/lib/iomap_copy_64.S
@@ -11,5 +11,5 @@
 SYM_FUNC_START(__iowrite32_copy)
 	movl %edx,%ecx
 	rep movsd
-	ret
+	RET
 SYM_FUNC_END(__iowrite32_copy)
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 1cc9da6..59cf234 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -39,7 +39,7 @@ SYM_FUNC_START_WEAK(memcpy)
 	rep movsq
 	movl %edx, %ecx
 	rep movsb
-	ret
+	RET
 SYM_FUNC_END(memcpy)
 SYM_FUNC_END_ALIAS(__memcpy)
 EXPORT_SYMBOL(memcpy)
@@ -53,7 +53,7 @@ SYM_FUNC_START_LOCAL(memcpy_erms)
 	movq %rdi, %rax
 	movq %rdx, %rcx
 	rep movsb
-	ret
+	RET
 SYM_FUNC_END(memcpy_erms)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
@@ -137,7 +137,7 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	movq %r9,	1*8(%rdi)
 	movq %r10,	-2*8(%rdi, %rdx)
 	movq %r11,	-1*8(%rdi, %rdx)
-	retq
+	RET
 	.p2align 4
 .Lless_16bytes:
 	cmpl $8,	%edx
@@ -149,7 +149,7 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	movq -1*8(%rsi, %rdx),	%r9
 	movq %r8,	0*8(%rdi)
 	movq %r9,	-1*8(%rdi, %rdx)
-	retq
+	RET
 	.p2align 4
 .Lless_8bytes:
 	cmpl $4,	%edx
@@ -162,7 +162,7 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	movl -4(%rsi, %rdx), %r8d
 	movl %ecx, (%rdi)
 	movl %r8d, -4(%rdi, %rdx)
-	retq
+	RET
 	.p2align 4
 .Lless_3bytes:
 	subl $1, %edx
@@ -180,7 +180,7 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	movb %cl, (%rdi)
 
 .Lend:
-	retq
+	RET
 SYM_FUNC_END(memcpy_orig)
 
 .popsection
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 6480101..e84d649 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -40,7 +40,7 @@ SYM_FUNC_START(__memmove)
 	/* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
 	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
-	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
+	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; RET", X86_FEATURE_ERMS
 
 	/*
 	 * movsq instruction have many startup latency
@@ -205,7 +205,7 @@ SYM_FUNC_START(__memmove)
 	movb (%rsi), %r11b
 	movb %r11b, (%rdi)
 13:
-	retq
+	RET
 SYM_FUNC_END(__memmove)
 SYM_FUNC_END_ALIAS(memmove)
 EXPORT_SYMBOL(__memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9827ae2..d624f2b 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -40,7 +40,7 @@ SYM_FUNC_START(__memset)
 	movl %edx,%ecx
 	rep stosb
 	movq %r9,%rax
-	ret
+	RET
 SYM_FUNC_END(__memset)
 SYM_FUNC_END_ALIAS(memset)
 EXPORT_SYMBOL(memset)
@@ -63,7 +63,7 @@ SYM_FUNC_START_LOCAL(memset_erms)
 	movq %rdx,%rcx
 	rep stosb
 	movq %r9,%rax
-	ret
+	RET
 SYM_FUNC_END(memset_erms)
 
 SYM_FUNC_START_LOCAL(memset_orig)
@@ -125,7 +125,7 @@ SYM_FUNC_START_LOCAL(memset_orig)
 
 .Lende:
 	movq	%r10,%rax
-	ret
+	RET
 
 .Lbad_alignment:
 	cmpq $7,%rdx
diff --git a/arch/x86/lib/msr-reg.S b/arch/x86/lib/msr-reg.S
index a2b9caa..ebd259f 100644
--- a/arch/x86/lib/msr-reg.S
+++ b/arch/x86/lib/msr-reg.S
@@ -35,7 +35,7 @@ SYM_FUNC_START(\op\()_safe_regs)
 	movl    %edi, 28(%r10)
 	popq %r12
 	popq %rbx
-	ret
+	RET
 3:
 	movl    $-EIO, %r11d
 	jmp     2b
@@ -77,7 +77,7 @@ SYM_FUNC_START(\op\()_safe_regs)
 	popl %esi
 	popl %ebp
 	popl %ebx
-	ret
+	RET
 3:
 	movl    $-EIO, 4(%esp)
 	jmp     2b
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 0ea344c..ecb2049 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -52,7 +52,7 @@ SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
 1:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
@@ -66,7 +66,7 @@ SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
 2:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
@@ -80,7 +80,7 @@ SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
 3:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
-	ret
+	RET
 SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index cf0b39f..a842866 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -23,7 +23,7 @@
 .Ldo_rop_\@:
 	mov     %\reg, (%_ASM_SP)
 	UNWIND_HINT_FUNC
-	ret
+	RET
 .endm
 
 .macro THUNK reg
diff --git a/arch/x86/math-emu/div_Xsig.S b/arch/x86/math-emu/div_Xsig.S
index 951da2a..8c270ab 100644
--- a/arch/x86/math-emu/div_Xsig.S
+++ b/arch/x86/math-emu/div_Xsig.S
@@ -341,7 +341,7 @@ L_exit:
 	popl	%esi
 
 	leave
-	ret
+	RET
 
 
 #ifdef PARANOID
diff --git a/arch/x86/math-emu/div_small.S b/arch/x86/math-emu/div_small.S
index d047d18..637439b 100644
--- a/arch/x86/math-emu/div_small.S
+++ b/arch/x86/math-emu/div_small.S
@@ -44,5 +44,5 @@ SYM_FUNC_START(FPU_div_small)
 	popl	%esi
 
 	leave
-	ret
+	RET
 SYM_FUNC_END(FPU_div_small)
diff --git a/arch/x86/math-emu/mul_Xsig.S b/arch/x86/math-emu/mul_Xsig.S
index 4afc7b1..54a031b 100644
--- a/arch/x86/math-emu/mul_Xsig.S
+++ b/arch/x86/math-emu/mul_Xsig.S
@@ -62,7 +62,7 @@ SYM_FUNC_START(mul32_Xsig)
 
 	popl %esi
 	leave
-	ret
+	RET
 SYM_FUNC_END(mul32_Xsig)
 
 
@@ -115,7 +115,7 @@ SYM_FUNC_START(mul64_Xsig)
 
 	popl %esi
 	leave
-	ret
+	RET
 SYM_FUNC_END(mul64_Xsig)
 
 
@@ -175,5 +175,5 @@ SYM_FUNC_START(mul_Xsig_Xsig)
 
 	popl %esi
 	leave
-	ret
+	RET
 SYM_FUNC_END(mul_Xsig_Xsig)
diff --git a/arch/x86/math-emu/polynom_Xsig.S b/arch/x86/math-emu/polynom_Xsig.S
index 702315e..35fd723 100644
--- a/arch/x86/math-emu/polynom_Xsig.S
+++ b/arch/x86/math-emu/polynom_Xsig.S
@@ -133,5 +133,5 @@ L_accum_done:
 	popl	%edi
 	popl	%esi
 	leave
-	ret
+	RET
 SYM_FUNC_END(polynomial_Xsig)
diff --git a/arch/x86/math-emu/reg_norm.S b/arch/x86/math-emu/reg_norm.S
index cad1d60..594936e 100644
--- a/arch/x86/math-emu/reg_norm.S
+++ b/arch/x86/math-emu/reg_norm.S
@@ -72,7 +72,7 @@ L_exit_valid:
 L_exit:
 	popl	%ebx
 	leave
-	ret
+	RET
 
 
 L_zero:
@@ -138,7 +138,7 @@ L_exit_nuo_valid:
 
 	popl	%ebx
 	leave
-	ret
+	RET
 
 L_exit_nuo_zero:
 	movl	TAG_Zero,%eax
@@ -146,5 +146,5 @@ L_exit_nuo_zero:
 
 	popl	%ebx
 	leave
-	ret
+	RET
 SYM_FUNC_END(FPU_normalize_nuo)
diff --git a/arch/x86/math-emu/reg_round.S b/arch/x86/math-emu/reg_round.S
index 4a9fc3c..0bb2a09 100644
--- a/arch/x86/math-emu/reg_round.S
+++ b/arch/x86/math-emu/reg_round.S
@@ -437,7 +437,7 @@ fpu_Arith_exit:
 	popl	%edi
 	popl	%esi
 	leave
-	ret
+	RET
 
 
 /*
diff --git a/arch/x86/math-emu/reg_u_add.S b/arch/x86/math-emu/reg_u_add.S
index 9c9e2c8..0724728 100644
--- a/arch/x86/math-emu/reg_u_add.S
+++ b/arch/x86/math-emu/reg_u_add.S
@@ -164,6 +164,6 @@ L_exit:
 	popl	%edi
 	popl	%esi
 	leave
-	ret
+	RET
 #endif /* PARANOID */
 SYM_FUNC_END(FPU_u_add)
diff --git a/arch/x86/math-emu/reg_u_div.S b/arch/x86/math-emu/reg_u_div.S
index e2fb5c2..b5a41e2 100644
--- a/arch/x86/math-emu/reg_u_div.S
+++ b/arch/x86/math-emu/reg_u_div.S
@@ -468,7 +468,7 @@ L_exit:
 	popl	%esi
 
 	leave
-	ret
+	RET
 #endif /* PARANOID */ 
 
 SYM_FUNC_END(FPU_u_div)
diff --git a/arch/x86/math-emu/reg_u_mul.S b/arch/x86/math-emu/reg_u_mul.S
index 0c779c8..e2588b2 100644
--- a/arch/x86/math-emu/reg_u_mul.S
+++ b/arch/x86/math-emu/reg_u_mul.S
@@ -144,7 +144,7 @@ L_exit:
 	popl	%edi
 	popl	%esi
 	leave
-	ret
+	RET
 #endif /* PARANOID */ 
 
 SYM_FUNC_END(FPU_u_mul)
diff --git a/arch/x86/math-emu/reg_u_sub.S b/arch/x86/math-emu/reg_u_sub.S
index e9bb7c2..4c900c2 100644
--- a/arch/x86/math-emu/reg_u_sub.S
+++ b/arch/x86/math-emu/reg_u_sub.S
@@ -270,5 +270,5 @@ L_exit:
 	popl	%edi
 	popl	%esi
 	leave
-	ret
+	RET
 SYM_FUNC_END(FPU_u_sub)
diff --git a/arch/x86/math-emu/round_Xsig.S b/arch/x86/math-emu/round_Xsig.S
index d9d7de8..126c404 100644
--- a/arch/x86/math-emu/round_Xsig.S
+++ b/arch/x86/math-emu/round_Xsig.S
@@ -78,7 +78,7 @@ L_exit:
 	popl	%esi
 	popl	%ebx
 	leave
-	ret
+	RET
 SYM_FUNC_END(round_Xsig)
 
 
@@ -138,5 +138,5 @@ L_n_exit:
 	popl	%esi
 	popl	%ebx
 	leave
-	ret
+	RET
 SYM_FUNC_END(norm_Xsig)
diff --git a/arch/x86/math-emu/shr_Xsig.S b/arch/x86/math-emu/shr_Xsig.S
index 726af98..f726bf6 100644
--- a/arch/x86/math-emu/shr_Xsig.S
+++ b/arch/x86/math-emu/shr_Xsig.S
@@ -45,7 +45,7 @@ SYM_FUNC_START(shr_Xsig)
 	popl	%ebx
 	popl	%esi
 	leave
-	ret
+	RET
 
 L_more_than_31:
 	cmpl	$64,%ecx
@@ -61,7 +61,7 @@ L_more_than_31:
 	movl	$0,8(%esi)
 	popl	%esi
 	leave
-	ret
+	RET
 
 L_more_than_63:
 	cmpl	$96,%ecx
@@ -76,7 +76,7 @@ L_more_than_63:
 	movl	%edx,8(%esi)
 	popl	%esi
 	leave
-	ret
+	RET
 
 L_more_than_95:
 	xorl	%eax,%eax
@@ -85,5 +85,5 @@ L_more_than_95:
 	movl	%eax,8(%esi)
 	popl	%esi
 	leave
-	ret
+	RET
 SYM_FUNC_END(shr_Xsig)
diff --git a/arch/x86/math-emu/wm_shrx.S b/arch/x86/math-emu/wm_shrx.S
index 4fc8917..f608a28 100644
--- a/arch/x86/math-emu/wm_shrx.S
+++ b/arch/x86/math-emu/wm_shrx.S
@@ -55,7 +55,7 @@ SYM_FUNC_START(FPU_shrx)
 	popl	%ebx
 	popl	%esi
 	leave
-	ret
+	RET
 
 L_more_than_31:
 	cmpl	$64,%ecx
@@ -70,7 +70,7 @@ L_more_than_31:
 	movl	$0,4(%esi)
 	popl	%esi
 	leave
-	ret
+	RET
 
 L_more_than_63:
 	cmpl	$96,%ecx
@@ -84,7 +84,7 @@ L_more_than_63:
 	movl	%edx,4(%esi)
 	popl	%esi
 	leave
-	ret
+	RET
 
 L_more_than_95:
 	xorl	%eax,%eax
@@ -92,7 +92,7 @@ L_more_than_95:
 	movl	%eax,4(%esi)
 	popl	%esi
 	leave
-	ret
+	RET
 SYM_FUNC_END(FPU_shrx)
 
 
@@ -146,7 +146,7 @@ SYM_FUNC_START(FPU_shrxs)
 	popl	%ebx
 	popl	%esi
 	leave
-	ret
+	RET
 
 /* Shift by [0..31] bits */
 Ls_less_than_32:
@@ -163,7 +163,7 @@ Ls_less_than_32:
 	popl	%ebx
 	popl	%esi
 	leave
-	ret
+	RET
 
 /* Shift by [64..95] bits */
 Ls_more_than_63:
@@ -189,7 +189,7 @@ Ls_more_than_63:
 	popl	%ebx
 	popl	%esi
 	leave
-	ret
+	RET
 
 Ls_more_than_95:
 /* Shift by [96..inf) bits */
@@ -203,5 +203,5 @@ Ls_more_than_95:
 	popl	%ebx
 	popl	%esi
 	leave
-	ret
+	RET
 SYM_FUNC_END(FPU_shrxs)
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index 17d292b..3d1dba0 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -65,7 +65,7 @@ SYM_FUNC_START(sme_encrypt_execute)
 	movq	%rbp, %rsp		/* Restore original stack pointer */
 	pop	%rbp
 
-	ret
+	RET
 SYM_FUNC_END(sme_encrypt_execute)
 
 SYM_FUNC_START(__enc_copy)
@@ -151,6 +151,6 @@ SYM_FUNC_START(__enc_copy)
 	pop	%r12
 	pop	%r15
 
-	ret
+	RET
 .L__enc_copy_end:
 SYM_FUNC_END(__enc_copy)
diff --git a/arch/x86/platform/efi/efi_stub_32.S b/arch/x86/platform/efi/efi_stub_32.S
index 09ec84f..f3cfdb1 100644
--- a/arch/x86/platform/efi/efi_stub_32.S
+++ b/arch/x86/platform/efi/efi_stub_32.S
@@ -56,5 +56,5 @@ SYM_FUNC_START(efi_call_svam)
 
 	movl	16(%esp), %ebx
 	leave
-	ret
+	RET
 SYM_FUNC_END(efi_call_svam)
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
index 90380a1..2206b8b 100644
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -23,5 +23,5 @@ SYM_FUNC_START(__efi_call)
 	mov %rsi, %rcx
 	CALL_NOSPEC rdi
 	leave
-	ret
+	RET
 SYM_FUNC_END(__efi_call)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index fd3dd17..f2a8eec 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -63,7 +63,7 @@ SYM_CODE_START(__efi64_thunk)
 1:	movq	24(%rsp), %rsp
 	pop	%rbx
 	pop	%rbp
-	retq
+	RET
 
 	.code32
 2:	pushl	$__KERNEL_CS
diff --git a/arch/x86/platform/olpc/xo1-wakeup.S b/arch/x86/platform/olpc/xo1-wakeup.S
index 75f4faf..3a5abff 100644
--- a/arch/x86/platform/olpc/xo1-wakeup.S
+++ b/arch/x86/platform/olpc/xo1-wakeup.S
@@ -77,7 +77,7 @@ save_registers:
 	pushfl
 	popl saved_context_eflags
 
-	ret
+	RET
 
 restore_registers:
 	movl saved_context_ebp, %ebp
@@ -88,7 +88,7 @@ restore_registers:
 	pushl saved_context_eflags
 	popfl
 
-	ret
+	RET
 
 SYM_CODE_START(do_olpc_suspend_lowlevel)
 	call	save_processor_state
@@ -109,7 +109,7 @@ ret_point:
 
 	call	restore_registers
 	call	restore_processor_state
-	ret
+	RET
 SYM_CODE_END(do_olpc_suspend_lowlevel)
 
 .data
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 8786653..5606a15 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -32,7 +32,7 @@ SYM_FUNC_START(swsusp_arch_suspend)
 	FRAME_BEGIN
 	call swsusp_save
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(swsusp_arch_suspend)
 
 SYM_CODE_START(restore_image)
@@ -108,5 +108,5 @@ SYM_FUNC_START(restore_registers)
 	/* tell the hibernation core that we've just restored the memory */
 	movl	%eax, in_suspend
 
-	ret
+	RET
 SYM_FUNC_END(restore_registers)
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index d9bed59..0a0539e 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -66,7 +66,7 @@ SYM_FUNC_START(restore_registers)
 	/* tell the hibernation core that we've just restored the memory */
 	movq	%rax, in_suspend(%rip)
 
-	ret
+	RET
 SYM_FUNC_END(restore_registers)
 
 SYM_FUNC_START(swsusp_arch_suspend)
@@ -96,7 +96,7 @@ SYM_FUNC_START(swsusp_arch_suspend)
 	FRAME_BEGIN
 	call swsusp_save
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(swsusp_arch_suspend)
 
 SYM_FUNC_START(restore_image)
diff --git a/arch/x86/um/checksum_32.S b/arch/x86/um/checksum_32.S
index 13f118d..aed782a 100644
--- a/arch/x86/um/checksum_32.S
+++ b/arch/x86/um/checksum_32.S
@@ -110,7 +110,7 @@ csum_partial:
 7:	
 	popl %ebx
 	popl %esi
-	ret
+	RET
 
 #else
 
@@ -208,7 +208,7 @@ csum_partial:
 80: 
 	popl %ebx
 	popl %esi
-	ret
+	RET
 				
 #endif
 	EXPORT_SYMBOL(csum_partial)
diff --git a/arch/x86/um/setjmp_32.S b/arch/x86/um/setjmp_32.S
index 62eaf8c..2d991dd 100644
--- a/arch/x86/um/setjmp_32.S
+++ b/arch/x86/um/setjmp_32.S
@@ -34,7 +34,7 @@ kernel_setjmp:
 	movl %esi,12(%edx)
 	movl %edi,16(%edx)
 	movl %ecx,20(%edx)		# Return address
-	ret
+	RET
 
 	.size kernel_setjmp,.-kernel_setjmp
 
diff --git a/arch/x86/um/setjmp_64.S b/arch/x86/um/setjmp_64.S
index 1b5d40d..b46acb6 100644
--- a/arch/x86/um/setjmp_64.S
+++ b/arch/x86/um/setjmp_64.S
@@ -33,7 +33,7 @@ kernel_setjmp:
 	movq %r14,40(%rdi)
 	movq %r15,48(%rdi)
 	movq %rsi,56(%rdi)		# Return address
-	ret
+	RET
 
 	.size kernel_setjmp,.-kernel_setjmp
 
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 444d824..e730e62 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -29,7 +29,7 @@
  */
 SYM_FUNC_START(xen_irq_disable_direct)
 	movb $1, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
-	ret
+	RET
 SYM_FUNC_END(xen_irq_disable_direct)
 
 /*
@@ -58,7 +58,7 @@ SYM_FUNC_START(check_events)
 	pop %rcx
 	pop %rax
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(check_events)
 
 /*
@@ -84,7 +84,7 @@ SYM_FUNC_START(xen_irq_enable_direct)
 	call check_events
 1:
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(xen_irq_enable_direct)
 
 /*
@@ -100,7 +100,7 @@ SYM_FUNC_START(xen_save_fl_direct)
 	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
 	setz %ah
 	addb %ah, %ah
-	ret
+	RET
 SYM_FUNC_END(xen_save_fl_direct)
 
 SYM_FUNC_START(xen_read_cr2)
@@ -108,14 +108,14 @@ SYM_FUNC_START(xen_read_cr2)
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
 	_ASM_MOV XEN_vcpu_info_arch_cr2(%_ASM_AX), %_ASM_AX
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(xen_read_cr2);
 
 SYM_FUNC_START(xen_read_cr2_direct)
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %_ASM_AX
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(xen_read_cr2_direct);
 .popsection
 
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 6a64496..11d2865 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -26,7 +26,7 @@ SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_FUNC
 		.skip 31, 0x90
-		ret
+		RET
 	.endr
 
 #define HYPERCALL(n) \
