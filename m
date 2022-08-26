Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D137C5A21FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbiHZHcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbiHZHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:31:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B3FFD34CD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:31:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxFeLDdghjfjwKAA--.46370S3;
        Fri, 26 Aug 2022 15:31:18 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
Subject: [PATCH v2 1/9] LoongArch/ftrace: Add basic support
Date:   Fri, 26 Aug 2022 15:31:06 +0800
Message-Id: <20220826073114.1515-2-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220826073114.1515-1-zhangqing@loongson.cn>
References: <20220826073114.1515-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxFeLDdghjfjwKAA--.46370S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW5ZF1kXr1rGr1fXr1fZwb_yoW3ZF47pr
        Zay3WkG3yxGFsakrWS9r15urn8Jrs7ury2qa9IyryFyFsFqr1rZwn2yryqqF97t397GrWI
        ga4fGr42kF45XwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnCzuDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains basic ftrace support for LoongArch.
Specifically, function tracer (HAVE_FUNCTION_TRACER), function graph
tracer (HAVE_FUNCTION_GRAPH_TRACER) are implemented following the
instructions in Documentation/trace/ftrace-design.txt.

Use `-pg` makes stub like a child function `void _mcount(void *ra)`.
Thus, it can be seen store RA and open stack before `call _mcount`.
Find `open stack` at first, and then find `store RA`

Note that the functions in both inst.c and time.c should not be
hooked with the compiler's -pg option: to prevent infinite self-
referencing for the former, and to ignore early setup stuff for the
latter.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig              |  2 +
 arch/loongarch/Makefile             |  5 ++
 arch/loongarch/include/asm/ftrace.h | 18 ++++++
 arch/loongarch/kernel/Makefile      |  8 +++
 arch/loongarch/kernel/ftrace.c      | 74 +++++++++++++++++++++++
 arch/loongarch/kernel/mcount.S      | 94 +++++++++++++++++++++++++++++
 6 files changed, 201 insertions(+)
 create mode 100644 arch/loongarch/include/asm/ftrace.h
 create mode 100644 arch/loongarch/kernel/ftrace.c
 create mode 100644 arch/loongarch/kernel/mcount.S

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4abc9a28aba4..703a2c3a8e0d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -84,6 +84,8 @@ config LOONGARCH
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
+        select HAVE_FUNCTION_GRAPH_TRACER
+        select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_VDSO
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ec3de6191276..44f11a2937e9 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -29,6 +29,11 @@ ifneq ($(SUBARCH),$(ARCH))
   endif
 endif
 
+ifdef CONFIG_DYNAMIC_FTRACE
+  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+endif
+
 ifdef CONFIG_64BIT
 ld-emul			= $(64bit-emul)
 cflags-y		+= -mabi=lp64s
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
new file mode 100644
index 000000000000..6a3e76234618
--- /dev/null
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_LOONGARCH_FTRACE_H
+#define _ASM_LOONGARCH_FTRACE_H
+
+#ifdef CONFIG_FUNCTION_TRACER
+#define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
+
+#ifndef __ASSEMBLY__
+extern void _mcount(void);
+#define mcount _mcount
+
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_FUNCTION_TRACER */
+#endif /* _ASM_LOONGARCH_FTRACE_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index e5be17009fe8..0a745d24d3e5 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -14,6 +14,14 @@ obj-$(CONFIG_EFI) 		+= efi.o
 
 obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 
+ifdef CONFIG_FUNCTION_TRACER
+    obj-y += mcount.o ftrace.o
+    CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+  CFLAGS_REMOVE_inst.o = $(CC_FLAGS_FTRACE)
+  CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
+  CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
+endif
+
 obj-$(CONFIG_MODULES)		+= module.o module-sections.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
diff --git a/arch/loongarch/kernel/ftrace.c b/arch/loongarch/kernel/ftrace.c
new file mode 100644
index 000000000000..c8ddc5f11f32
--- /dev/null
+++ b/arch/loongarch/kernel/ftrace.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/uaccess.h>
+#include <linux/init.h>
+#include <linux/ftrace.h>
+#include <linux/syscalls.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/cacheflush.h>
+#include <asm/inst.h>
+#include <asm/loongarch.h>
+#include <asm/syscall.h>
+#include <asm/unistd.h>
+
+#include <asm-generic/sections.h>
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+/*
+ * As `call _mcount` follows LoongArch psABI, ra-saved operation and
+ * stack operation can be found before this insn.
+ */
+
+static int ftrace_get_parent_ra_addr(unsigned long insn_addr, int *ra_off)
+{
+	union loongarch_instruction *insn;
+	int limit = 32;
+
+	insn = (union loongarch_instruction *)insn_addr;
+
+	do {
+		insn--;
+		limit--;
+
+		if (is_ra_save_ins(insn))
+			*ra_off = -((1 << 12) - insn->reg2i12_format.immediate);
+
+	} while (!is_stack_alloc_ins(insn) && limit);
+
+	if (!limit)
+		return -EINVAL;
+
+	return 0;
+}
+
+void prepare_ftrace_return(unsigned long self_addr,
+		unsigned long callsite_sp, unsigned long old)
+{
+	int ra_off;
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	if (ftrace_get_parent_ra_addr(self_addr, &ra_off))
+		goto out;
+
+	if (!function_graph_enter(old, self_addr, 0, NULL))
+		*(unsigned long *)(callsite_sp + ra_off) = return_hooker;
+
+	return;
+
+out:
+	ftrace_graph_stop();
+	WARN_ON(1);
+}
+#endif	/* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
new file mode 100644
index 000000000000..3de7c2d7fd12
--- /dev/null
+++ b/arch/loongarch/kernel/mcount.S
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch specific _mcount support
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/export.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/ftrace.h>
+
+	.text
+
+#define MCOUNT_STACK_SIZE	(2 * SZREG)
+#define MCOUNT_S0_OFFSET	(0)
+#define MCOUNT_RA_OFFSET	(SZREG)
+
+	.macro MCOUNT_SAVE_REGS
+	PTR_ADDI sp, sp, -MCOUNT_STACK_SIZE
+	PTR_S	s0, sp, MCOUNT_S0_OFFSET
+	PTR_S	ra, sp, MCOUNT_RA_OFFSET
+	move	s0, a0
+	.endm
+
+	.macro MCOUNT_RESTORE_REGS
+	move	a0, s0
+	PTR_L	ra, sp, MCOUNT_RA_OFFSET
+	PTR_L	s0, sp, MCOUNT_S0_OFFSET
+	PTR_ADDI sp, sp, MCOUNT_STACK_SIZE
+	.endm
+
+
+SYM_FUNC_START(_mcount)
+	la.pcrel	t1, ftrace_stub
+	la.pcrel	t2, ftrace_trace_function	/* Prepare t2 for (1) */
+	PTR_L	t2, t2, 0
+	beq	t1, t2, fgraph_trace
+
+	MCOUNT_SAVE_REGS
+
+	move	a0, ra				/* arg0: self return address */
+	move	a1, s0				/* arg1: parent's return address */
+	jirl	ra, t2, 0			/* (1) call *ftrace_trace_function */
+
+	MCOUNT_RESTORE_REGS
+
+fgraph_trace:
+#ifdef	CONFIG_FUNCTION_GRAPH_TRACER
+	la.pcrel	t1, ftrace_stub
+	la.pcrel	t3, ftrace_graph_return
+	PTR_L	t3, t3, 0
+	bne	t1, t3, ftrace_graph_caller
+	la.pcrel	t1, ftrace_graph_entry_stub
+	la.pcrel	t3, ftrace_graph_entry
+	PTR_L	t3, t3, 0
+	bne	t1, t3, ftrace_graph_caller
+#endif
+
+	.globl ftrace_stub
+ftrace_stub:
+	jr	ra
+SYM_FUNC_END(_mcount)
+EXPORT_SYMBOL(_mcount)
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+SYM_FUNC_START(ftrace_graph_caller)
+	MCOUNT_SAVE_REGS
+
+	PTR_ADDI	a0, ra, -4			/* arg0: Callsite self return addr */
+	PTR_ADDI	a1, sp, MCOUNT_STACK_SIZE	/* arg1: Callsite sp */
+	move	a2, s0					/* arg2: Callsite parent ra */
+	bl	prepare_ftrace_return
+
+	MCOUNT_RESTORE_REGS
+	jr	ra
+SYM_FUNC_END(ftrace_graph_caller)
+
+SYM_FUNC_START(return_to_handler)
+	PTR_ADDI sp, sp, -2 * SZREG
+	PTR_S	a0, sp, 0
+	PTR_S	a1, sp, SZREG
+
+	bl	ftrace_return_to_handler
+
+	/* restore the real parent address: a0 -> ra */
+	move	ra, a0
+
+	PTR_L	a0, sp, 0
+	PTR_L	a1, sp, SZREG
+	PTR_ADDI	sp, sp, 2 * SZREG
+	jr	ra
+SYM_FUNC_END(return_to_handler)
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.20.1

