Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6F4B8DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiBPQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:23:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiBPQXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:23:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0418F1E8BD2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:22:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0C971474;
        Wed, 16 Feb 2022 08:22:47 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCBDD3F70D;
        Wed, 16 Feb 2022 08:22:45 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        joey.gouly@arm.com, jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH v4 3/4] x86: clean up symbol aliasing
Date:   Wed, 16 Feb 2022 16:22:28 +0000
Message-Id: <20220216162229.1076788-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216162229.1076788-1-mark.rutland@arm.com>
References: <20220216162229.1076788-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 659fad53ca82..3b354eb9516d 100644
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
index fd9441f40457..dea95301196b 100644
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
index 363699dd7220..837c1e0aa021 100644
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
index 59cf2343f3d9..d0d7b9bc6cad 100644
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
index 50ea390df712..d83cba364e31 100644
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
index d624f2bc42f1..fc9ffd3ff3b2 100644
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
index 59cf2343f3d9..d0d7b9bc6cad 100644
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
index d624f2bc42f1..fc9ffd3ff3b2 100644
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
-- 
2.30.2

