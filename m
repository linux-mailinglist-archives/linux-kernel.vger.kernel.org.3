Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00F4D2A23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiCIH65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiCIH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99372166E2B;
        Tue,  8 Mar 2022 23:55:23 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mqg0/1Bl9F+kBT44zyBynLr+BcAS3vlx4kvS63JrMnw=;
        b=QztsIpKR2mISSaIiXJIVxqwPwZ7jCqIkr560OhFxCSppS0lyqyLVcOruje4aUl+Z6WVfHu
        EQ0azyy/UbFobpcLBQX5SCD63aIbhmeRXv2+d1m9o+Cjy6L3QBCLEokMhUIccFqaRoDG8L
        IKj0TyDgAaPFv5xO0GwZbWBdTt+OmDGh/ZHGdoeC+PIddlftmZq+OWolD3IFChiCQghYjJ
        ggvQhY5IyRG3fJQbfH7d15foPqj03E/sWyvX5sBZGp8qI5sVXBnMPzcvZ3MmTqR+t3O3Hb
        DPQydz43/WE1Hpv8PlZxwu3LiBczgyqb3wfrMTWRztFm3xOvWVGTIGJ3aR658w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mqg0/1Bl9F+kBT44zyBynLr+BcAS3vlx4kvS63JrMnw=;
        b=EO/ED3NDwvQ6hTxsjicIGmC83vI0F9SULecBN/78OXuDRNUFzJgZy8yFZyVpbnPXJtqkIM
        rIEYdH7rrlNYZbCg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: clean up symbol aliasing
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220216162229.1076788-4-mark.rutland@arm.com>
References: <20220216162229.1076788-4-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164681252041.16921.13637320927245353003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7be2e319640c8926bbba4e004a1bee9cf6ed67b0
Gitweb:        https://git.kernel.org/tip/7be2e319640c8926bbba4e004a1bee9cf6ed67b0
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 16 Feb 2022 16:22:28 
Committer:     Will Deacon <will@kernel.org>
CommitterDate: Tue, 22 Feb 2022 16:21:34 

x86: clean up symbol aliasing

Now that we have SYM_FUNC_ALIAS() and SYM_FUNC_ALIAS_WEAK(), use those
to simplify the definition of function aliases across arch/x86.

For clarity, where there are multiple annotations such as
EXPORT_SYMBOL(), I've tried to keep annotations grouped by symbol. For
example, where a function has a name and an alias which are both
exported, this is organised as:

	SYM_FUNC_START(func)
	    ... asm insns ...
	SYM_FUNC_END(func)
	EXPORT_SYMBOL(func)

	SYM_FUNC_ALIAS(alias, func)
	EXPORT_SYMBOL(alias)

Where there are only aliases and no exports or other annotations, I have
not bothered with line spacing, e.g.

	SYM_FUNC_START(func)
	    ... asm insns ...
	SYM_FUNC_END(func)
	SYM_FUNC_ALIAS(alias, func)

The tools/perf/ copies of memset_64.S and memset_64.S are updated
likewise to avoid the build system complaining these are mismatched:

| Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
| diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
| Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs from latest version at 'arch/x86/lib/memset_64.S'
| diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220216162229.1076788-4-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/x86/boot/compressed/head_32.S |  3 +--
 arch/x86/boot/compressed/head_64.S |  3 +--
 arch/x86/crypto/aesni-intel_asm.S  |  4 +---
 arch/x86/lib/memcpy_64.S           | 10 +++++-----
 arch/x86/lib/memmove_64.S          |  4 ++--
 arch/x86/lib/memset_64.S           |  6 +++---
 tools/arch/x86/lib/memcpy_64.S     | 10 +++++-----
 tools/arch/x86/lib/memset_64.S     |  6 +++---
 8 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 659fad5..3b354eb 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -152,14 +152,13 @@ SYM_FUNC_END(startup_32)
 
 #ifdef CONFIG_EFI_STUB
 SYM_FUNC_START(efi32_stub_entry)
-SYM_FUNC_START_ALIAS(efi_stub_entry)
 	add	$0x4, %esp
 	movl	8(%esp), %esi	/* save boot_params pointer */
 	call	efi_main
 	/* efi_main returns the possibly relocated address of startup_32 */
 	jmp	*%eax
 SYM_FUNC_END(efi32_stub_entry)
-SYM_FUNC_END_ALIAS(efi_stub_entry)
+SYM_FUNC_ALIAS(efi_stub_entry, efi32_stub_entry)
 #endif
 
 	.text
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fd9441f..dea9530 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -535,7 +535,6 @@ SYM_CODE_END(startup_64)
 #ifdef CONFIG_EFI_STUB
 	.org 0x390
 SYM_FUNC_START(efi64_stub_entry)
-SYM_FUNC_START_ALIAS(efi_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	movq	%rdx, %rbx			/* save boot_params pointer */
 	call	efi_main
@@ -543,7 +542,7 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	leaq	rva(startup_64)(%rax), %rax
 	jmp	*%rax
 SYM_FUNC_END(efi64_stub_entry)
-SYM_FUNC_END_ALIAS(efi_stub_entry)
+SYM_FUNC_ALIAS(efi_stub_entry, efi64_stub_entry)
 #endif
 
 	.text
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 363699d..837c1e0 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1751,8 +1751,6 @@ SYM_FUNC_END(aesni_gcm_finalize)
 
 #endif
 
-
-SYM_FUNC_START_LOCAL_ALIAS(_key_expansion_128)
 SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	pshufd $0b11111111, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
@@ -1764,7 +1762,7 @@ SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	add $0x10, TKEYP
 	RET
 SYM_FUNC_END(_key_expansion_256a)
-SYM_FUNC_END_ALIAS(_key_expansion_128)
+SYM_FUNC_ALIAS_LOCAL(_key_expansion_128, _key_expansion_256a)
 
 SYM_FUNC_START_LOCAL(_key_expansion_192a)
 	pshufd $0b01010101, %xmm1, %xmm1
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 59cf234..d0d7b9b 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -27,8 +27,7 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START_ALIAS(__memcpy)
-SYM_FUNC_START_WEAK(memcpy)
+SYM_FUNC_START(__memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
@@ -40,11 +39,12 @@ SYM_FUNC_START_WEAK(memcpy)
 	movl %edx, %ecx
 	rep movsb
 	RET
-SYM_FUNC_END(memcpy)
-SYM_FUNC_END_ALIAS(__memcpy)
-EXPORT_SYMBOL(memcpy)
+SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
+SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+EXPORT_SYMBOL(memcpy)
+
 /*
  * memcpy_erms() - enhanced fast string memcpy. This is faster and
  * simpler than memcpy. Use memcpy_erms when possible.
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 50ea390..d83cba3 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -24,7 +24,6 @@
  * Output:
  * rax: dest
  */
-SYM_FUNC_START_WEAK(memmove)
 SYM_FUNC_START(__memmove)
 
 	mov %rdi, %rax
@@ -207,6 +206,7 @@ SYM_FUNC_START(__memmove)
 13:
 	RET
 SYM_FUNC_END(__memmove)
-SYM_FUNC_END_ALIAS(memmove)
 EXPORT_SYMBOL(__memmove)
+
+SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index d624f2b..fc9ffd3 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -17,7 +17,6 @@
  *
  * rax   original destination
  */
-SYM_FUNC_START_WEAK(memset)
 SYM_FUNC_START(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
@@ -42,10 +41,11 @@ SYM_FUNC_START(__memset)
 	movq %r9,%rax
 	RET
 SYM_FUNC_END(__memset)
-SYM_FUNC_END_ALIAS(memset)
-EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(__memset)
 
+SYM_FUNC_ALIAS_WEAK(memset, __memset)
+EXPORT_SYMBOL(memset)
+
 /*
  * ISO C memset - set a memory block to a byte value. This function uses
  * enhanced rep stosb to override the fast string function.
diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 59cf234..d0d7b9b 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -27,8 +27,7 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START_ALIAS(__memcpy)
-SYM_FUNC_START_WEAK(memcpy)
+SYM_FUNC_START(__memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
@@ -40,11 +39,12 @@ SYM_FUNC_START_WEAK(memcpy)
 	movl %edx, %ecx
 	rep movsb
 	RET
-SYM_FUNC_END(memcpy)
-SYM_FUNC_END_ALIAS(__memcpy)
-EXPORT_SYMBOL(memcpy)
+SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
+SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+EXPORT_SYMBOL(memcpy)
+
 /*
  * memcpy_erms() - enhanced fast string memcpy. This is faster and
  * simpler than memcpy. Use memcpy_erms when possible.
diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index d624f2b..fc9ffd3 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -17,7 +17,6 @@
  *
  * rax   original destination
  */
-SYM_FUNC_START_WEAK(memset)
 SYM_FUNC_START(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
@@ -42,10 +41,11 @@ SYM_FUNC_START(__memset)
 	movq %r9,%rax
 	RET
 SYM_FUNC_END(__memset)
-SYM_FUNC_END_ALIAS(memset)
-EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(__memset)
 
+SYM_FUNC_ALIAS_WEAK(memset, __memset)
+EXPORT_SYMBOL(memset)
+
 /*
  * ISO C memset - set a memory block to a byte value. This function uses
  * enhanced rep stosb to override the fast string function.
