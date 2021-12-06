Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67A04695F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhLFMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:51:08 -0500
Received: from foss.arm.com ([217.140.110.172]:56372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243405AbhLFMvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:51:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7C51042;
        Mon,  6 Dec 2021 04:47:35 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E0843F73D;
        Mon,  6 Dec 2021 04:47:33 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        maz@kernel.org, mingo@redhat.com, peterz@infradead.org,
        tabba@google.com, tglx@linutronix.de, will@kernel.org
Subject: [RFC PATCH 5/6] x86: clean up symbol aliasing
Date:   Mon,  6 Dec 2021 12:47:14 +0000
Message-Id: <20211206124715.4101571-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

	SYM_FUNC_ALAIAS(alias, func)
	EXPORT_SYMBOL(alias)

There there are only aliases I I have not bothered with line spacing,
e.g.

	SYM_FUNC_START(func)
	    ... asm insns ...
	SYM_FUNC_END(func)
	SYM_FUNC_ALAIAS(alias, func)

There should be no functional change as a result of this patch.

TODO:

* Handle tools/ copy

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/boot/compressed/head_32.S |  3 +--
 arch/x86/boot/compressed/head_64.S |  3 +--
 arch/x86/lib/memcpy_64.S           | 10 +++++-----
 arch/x86/lib/memmove_64.S          |  4 ++--
 arch/x86/lib/memset_64.S           |  6 +++---
 5 files changed, 12 insertions(+), 14 deletions(-)

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
index 572c535cf45b..b2226321e735 100644
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
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 1cc9da6e29c7..aa1ff84bb39e 100644
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
 	ret
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
index 64801010d312..979f8279aec1 100644
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
 	retq
 SYM_FUNC_END(__memmove)
-SYM_FUNC_END_ALIAS(memmove)
 EXPORT_SYMBOL(__memmove)
+
+SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9827ae267f96..cd9205848e69 100644
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
 	ret
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

