Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B408C47AAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhLTOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhLTOCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:02:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F138C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1408CE10DD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADBBC36AEB;
        Mon, 20 Dec 2021 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640008918;
        bh=UHd8irFWrJvz2WdD4moLLaKqv/z5Bxz0tCOFodBO6YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNs4WOgoFzFrIBsMWokBwmzk5Gz1kIpW2jZHsgibSSkZcxbYeOhxFiUGMVq7mUJfW
         CEaehVM+NkTr87T3v2YVkpp9WcwgW656aPfMP1UJj5eO+q1jI1cPJZvTcgig6wK5JR
         R0tTmuXxJCNWY9k9Cbz6ZT93YwwabgmSAee29QKxIjR0kIqNG885AG2ysSdV65hugA
         7NWyKhkIXxJXBVgwi4um6+FIRy26CEqbtOEbb9Wf7xSngjqxuK75JjK+L/dHjawPQr
         3yI/xV+70tbK6KiNWYUKSCEe7UobHelcdDSiaN05bPpS/TilH1dfXw78eZ7/SyyTmA
         49KaECWwrfPtQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/5] arm64: implement support for static call trampolines
Date:   Mon, 20 Dec 2021 15:01:39 +0100
Message-Id: <20211220140142.922323-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220140142.922323-1-frederic@kernel.org>
References: <20211220140142.922323-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Implement arm64 support for the 'unoptimized' static call variety, which
routes all calls through a single trampoline that is patched to perform a
tail call to the selected function.

It is expected that the direct branch instruction will be able to cover
the common case. However, given that static call targets may be located
in modules loaded out of direct branching range, we need a fallback path
that loads the address into R16 and uses a branch-to-register (BR)
instruction to perform an indirect call.

Unlike on x86, there is no pressing need on arm64 to avoid indirect
calls at all cost, but hiding it from the compiler as is done here does
have some benefits:
- the literal is located in .text, which gives us the same robustness
  advantage that code patching does;
- no performance hit on CFI enabled Clang builds that decorate compiler
  emitted indirect calls with branch target validity checks.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/Kconfig                   |  2 +
 arch/arm64/include/asm/static_call.h | 40 +++++++++++++++
 arch/arm64/kernel/patching.c         | 77 ++++++++++++++++++++++++++--
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 4 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/static_call.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..6f2d3e31fb54 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -193,6 +193,8 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	# https://github.com/ClangBuiltLinux/linux/issues/1354
+	select HAVE_STATIC_CALL if !LTO_CLANG_THIN || CLANG_VERSION >= 130000
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select MMU_GATHER_RCU_TABLE_FREE
diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
new file mode 100644
index 000000000000..6ee918991510
--- /dev/null
+++ b/arch/arm64/include/asm/static_call.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+/*
+ * The sequence below is laid out in a way that guarantees that the literal and
+ * the instruction are always covered by the same cacheline, and can be updated
+ * using a single store-pair instruction (provided that we rewrite the BTI C
+ * instruction as well). This means the literal and the instruction are always
+ * in sync when observed via the D-side.
+ *
+ * However, this does not guarantee that the I-side will catch up immediately
+ * as well: until the I-cache maintenance completes, CPUs may branch to the old
+ * target, or execute a stale NOP or RET. We deal with this by writing the
+ * literal unconditionally, even if it is 0x0 or the branch is in range. That
+ * way, a stale NOP will fall through and call the new target via an indirect
+ * call. Stale RETs or Bs will be taken as before, and branch to the old
+ * target.
+ */
+#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insn)			    \
+	asm("	.pushsection	.static_call.text, \"ax\"		\n" \
+	    "	.align		4					\n" \
+	    "	.globl		" STATIC_CALL_TRAMP_STR(name) "		\n" \
+	    "0:	.quad		0x0					\n" \
+	    STATIC_CALL_TRAMP_STR(name) ":				\n" \
+	    "	hint 		34	/* BTI C */			\n" \
+		insn "							\n" \
+	    "	ldr		x16, 0b					\n" \
+	    "	cbz		x16, 1f					\n" \
+	    "	br		x16					\n" \
+	    "1:	ret							\n" \
+	    "	.popsection						\n")
+
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "b " #func)
+
+#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret")
+
+#endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 771f543464e0..a265a87d4d9e 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/spinlock.h>
+#include <linux/static_call.h>
 #include <linux/stop_machine.h>
 #include <linux/uaccess.h>
 
@@ -66,7 +67,7 @@ int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
 	return ret;
 }
 
-static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
+static int __kprobes __aarch64_insn_write(void *addr, void *insn, int size)
 {
 	void *waddr = addr;
 	unsigned long flags = 0;
@@ -75,7 +76,7 @@ static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
 	raw_spin_lock_irqsave(&patch_lock, flags);
 	waddr = patch_map(addr, FIX_TEXT_POKE0);
 
-	ret = copy_to_kernel_nofault(waddr, &insn, AARCH64_INSN_SIZE);
+	ret = copy_to_kernel_nofault(waddr, insn, size);
 
 	patch_unmap(FIX_TEXT_POKE0);
 	raw_spin_unlock_irqrestore(&patch_lock, flags);
@@ -85,7 +86,77 @@ static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
 
 int __kprobes aarch64_insn_write(void *addr, u32 insn)
 {
-	return __aarch64_insn_write(addr, cpu_to_le32(insn));
+	__le32 i = cpu_to_le32(insn);
+
+	return __aarch64_insn_write(addr, &i, AARCH64_INSN_SIZE);
+}
+
+static void *strip_cfi_jt(void *addr)
+{
+	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+		void *p = addr;
+		u32 insn;
+
+		/*
+		 * Taking the address of a function produces the address of the
+		 * jump table entry when Clang CFI is enabled. Such entries are
+		 * ordinary jump instructions, preceded by a BTI C instruction
+		 * if BTI is enabled for the kernel.
+		 */
+		if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
+			p += 4;
+
+		insn = le32_to_cpup(p);
+		if (aarch64_insn_is_b(insn))
+			return p + aarch64_get_branch_offset(insn);
+
+		WARN_ON(1);
+	}
+	return addr;
+}
+
+void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
+{
+	/*
+	 * -0x8	<literal>
+	 *  0x0	bti c		<--- trampoline entry point
+	 *  0x4	<branch or nop>
+	 *  0x8	ldr x16, <literal>
+	 *  0xc	cbz x16, 20
+	 * 0x10	br x16
+	 * 0x14	ret
+	 */
+	struct {
+		u64	literal;
+		__le32	insn[2];
+	} insns;
+	u32 insn;
+	int ret;
+
+	insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_BTIC);
+	insns.literal = (u64)func;
+	insns.insn[0] = cpu_to_le32(insn);
+
+	if (!func) {
+		insn = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_LR,
+						   AARCH64_INSN_BRANCH_RETURN);
+	} else {
+		insn = aarch64_insn_gen_branch_imm((u64)tramp + 4,
+						   (u64)strip_cfi_jt(func),
+						   AARCH64_INSN_BRANCH_NOLINK);
+
+		/*
+		 * Use a NOP if the branch target is out of range, and rely on
+		 * the indirect call instead.
+		 */
+		if (insn == AARCH64_BREAK_FAULT)
+			insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
+	}
+	insns.insn[1] = cpu_to_le32(insn);
+
+	ret = __aarch64_insn_write(tramp - 8, &insns, sizeof(insns));
+	if (!WARN_ON(ret))
+		caches_clean_inval_pou((u64)tramp - 8, sizeof(insns));
 }
 
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 50bab186c49b..e16860a14eaf 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -173,6 +173,7 @@ SECTIONS
 			HIBERNATE_TEXT
 			KEXEC_TEXT
 			TRAMP_TEXT
+			STATIC_CALL_TEXT
 			*(.gnu.warning)
 		. = ALIGN(16);
 		*(.got)			/* Global offset table		*/
-- 
2.25.1

