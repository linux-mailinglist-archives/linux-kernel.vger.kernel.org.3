Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA82586AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiHAMix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiHAMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:38:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9F7F9EC6B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:17:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxAM9WxOdiKTUAAA--.1249S4;
        Mon, 01 Aug 2022 20:17:28 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 2/4] LoongArch: Add prologue unwinder support
Date:   Mon,  1 Aug 2022 20:17:24 +0800
Message-Id: <20220801121726.9681-3-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220801121726.9681-1-zhangqing@loongson.cn>
References: <20220801121726.9681-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxAM9WxOdiKTUAAA--.1249S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr43GF1xGFWUJw4rtw4UCFg_yoWfKw4fpF
        Z8Ar95Gr48Wr9agr9rXrs5urs5Grs29r12gFZxJw1rCF12qryxWrnYk34qvF4DJ3ykWF10
        gFs5JrWagF4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryUMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRv31JUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It unwind the stack frame based on prologue code analyze.
CONFIG_KALLSYMS is needed, at least the address and length
of each function.

Three stages when we do unwind,
  (1)unwind_start(), the prapare of unwinding, fill unwind_state.
  (2)unwind_done(), judge whether the unwind process is finished or not.
  (3)unwind_next_frame(), unwind the next frame.

Dividing unwinder helps to add new unwinders in the future, eg:
unwind_frame, unwind_orc .etc

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig.debug            |  19 +++
 arch/loongarch/include/asm/inst.h       |  52 +++++++
 arch/loongarch/include/asm/unwind.h     |   8 ++
 arch/loongarch/kernel/Makefile          |   1 +
 arch/loongarch/kernel/traps.c           |   5 +
 arch/loongarch/kernel/unwind_prologue.c | 172 ++++++++++++++++++++++++
 6 files changed, 257 insertions(+)
 create mode 100644 arch/loongarch/kernel/unwind_prologue.c

diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
index 68634d4fa27b..57cdbe0cfd98 100644
--- a/arch/loongarch/Kconfig.debug
+++ b/arch/loongarch/Kconfig.debug
@@ -1,3 +1,11 @@
+choice
+	prompt "Choose kernel unwinder"
+	default UNWINDER_PROLOGUE if KALLSYMS
+	help
+	  This determines which method will be used for unwinding kernel stack
+	  traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
+	  lockdep, and more.
+
 config UNWINDER_GUESS
 	bool "Guess unwinder"
 	help
@@ -7,3 +15,14 @@ config UNWINDER_GUESS
 
 	  While this option often produces false positives, it can still be
 	  useful in many cases.
+
+config UNWINDER_PROLOGUE
+	bool "Prologue unwinder"
+	depends on KALLSYMS
+	help
+	  This option enables the "prologue" unwinder for unwinding kernel stack
+	  traces.  It unwind the stack frame based on prologue code analyze.  Symbol
+	  information is needed, at least the address and length of each function.
+	  Some of the addresses it reports may be incorrect.
+
+endchoice
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 575d1bb66ffb..b876907ca65a 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -23,12 +23,33 @@ enum reg1i20_op {
 	lu32id_op	= 0x0b,
 };
 
+enum reg1i21_op {
+	beqz_op		= 0x10,
+	bnez_op		= 0x11,
+};
+
 enum reg2i12_op {
+	addiw_op	= 0x0a,
+	addid_op	= 0x0b,
 	lu52id_op	= 0x0c,
+	ldb_op		= 0xa0,
+	ldh_op		= 0xa1,
+	ldw_op		= 0xa2,
+	ldd_op		= 0xa3,
+	stb_op		= 0xa4,
+	sth_op		= 0xa5,
+	stw_op		= 0xa6,
+	std_op		= 0xa7,
 };
 
 enum reg2i16_op {
 	jirl_op		= 0x13,
+	beq_op		= 0x16,
+	bne_op		= 0x17,
+	blt_op		= 0x18,
+	bge_op		= 0x19,
+	bltu_op		= 0x1a,
+	bgeu_op		= 0x1b,
 };
 
 struct reg0i26_format {
@@ -110,6 +131,37 @@ enum loongarch_gpr {
 	LOONGARCH_GPR_MAX
 };
 
+#define is_imm12_negative(val)	is_imm_negative(val, 12)
+
+static inline bool is_imm_negative(unsigned long val, unsigned int bit)
+{
+	return val & (1UL << (bit - 1));
+}
+
+static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
+{
+	/* addi.d $sp, $sp, -imm */
+	return ip->reg2i12_format.opcode == addid_op &&
+		ip->reg2i12_format.rj == LOONGARCH_GPR_SP &&
+		ip->reg2i12_format.rd == LOONGARCH_GPR_SP &&
+		is_imm12_negative(ip->reg2i12_format.immediate);
+}
+
+static inline bool is_ra_save_ins(union loongarch_instruction *ip)
+{
+	/* st.d $ra, $sp, offset */
+	return ip->reg2i12_format.opcode == std_op &&
+		ip->reg2i12_format.rj == LOONGARCH_GPR_SP &&
+		ip->reg2i12_format.rd == LOONGARCH_GPR_RA &&
+		!is_imm12_negative(ip->reg2i12_format.immediate);
+}
+
+static inline bool is_branch_insn(union loongarch_instruction insn)
+{
+	return insn.reg1i21_format.opcode >= beqz_op &&
+		insn.reg1i21_format.opcode <= bgeu_op;
+}
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index 243330b39d0d..f9f73a26504e 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -14,6 +14,14 @@
 struct unwind_state {
 	struct stack_info stack_info;
 	struct task_struct *task;
+#if defined(CONFIG_UNWINDER_PROLOGUE)
+	unsigned long ra;
+	bool enable;
+	/*
+	 * Enable is the prologue analysis method
+	 * otherwise is the way to guess.
+	 */
+#endif
 	unsigned long sp, pc;
 	bool first;
 	bool error;
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c5fa4adb23b6..918600e7b30f 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -23,5 +23,6 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_NUMA)		+= numa.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
+obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index ef2c3aeb1dab..3e904fa12d48 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -73,6 +73,11 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
 
 	unwind_start(&state, task, pregs);
 
+#ifdef CONFIG_UNWINDER_PROLOGUE
+	if (user_mode(regs))
+		state.enable = false;
+#endif
+
 	printk("%sCall Trace:", loglvl);
 	for (; !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
new file mode 100644
index 000000000000..072d1f7bf4ac
--- /dev/null
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include <linux/kallsyms.h>
+
+#include <asm/inst.h>
+#include <asm/ptrace.h>
+#include <asm/unwind.h>
+
+unsigned long unwind_get_return_address(struct unwind_state *state)
+{
+
+	if (unwind_done(state))
+		return 0;
+	else if (state->enable)
+		return state->pc;
+	else if (state->first)
+		return state->pc;
+
+	return *(unsigned long *)(state->sp);
+
+}
+EXPORT_SYMBOL_GPL(unwind_get_return_address);
+
+static bool unwind_by_prologue(struct unwind_state *state)
+{
+	struct stack_info *info = &state->stack_info;
+	union loongarch_instruction *ip, *ip_end;
+	unsigned long frame_size = 0, frame_ra = -1;
+	unsigned long size, offset, pc = state->pc;
+
+	if (state->sp >= info->end || state->sp < info->begin)
+		return false;
+
+	if (!kallsyms_lookup_size_offset(pc, &size, &offset))
+		return false;
+
+	ip = (union loongarch_instruction *)(pc - offset);
+	ip_end = (union loongarch_instruction *)pc;
+
+	while (ip < ip_end) {
+		if (is_stack_alloc_ins(ip)) {
+			frame_size = (1 << 12) - ip->reg2i12_format.immediate;
+			ip++;
+			break;
+		}
+		ip++;
+	}
+
+	if (!frame_size) {
+		if (state->first)
+			goto first;
+
+		return false;
+	}
+
+	while (ip < ip_end) {
+		if (is_ra_save_ins(ip)) {
+			frame_ra = ip->reg2i12_format.immediate;
+			break;
+		}
+		if (is_branch_insn(*ip))
+			break;
+		ip++;
+	}
+
+	if (frame_ra < 0) {
+		if (state->first) {
+			state->sp = state->sp + frame_size;
+			goto first;
+		}
+		return false;
+	}
+
+	if (state->first)
+		state->first = false;
+
+	state->pc = *(unsigned long *)(state->sp + frame_ra);
+	state->sp = state->sp + frame_size;
+	return !!__kernel_text_address(state->pc);
+
+first:
+	state->first = false;
+	if (state->pc == state->ra)
+		return false;
+
+	state->pc = state->ra;
+
+	return !!__kernel_text_address(state->ra);
+}
+
+static bool unwind_by_guess(struct unwind_state *state)
+{
+	struct stack_info *info = &state->stack_info;
+	unsigned long addr;
+
+	for (state->sp += sizeof(unsigned long);
+	     state->sp < info->end;
+	     state->sp += sizeof(unsigned long)) {
+		addr = *(unsigned long *)(state->sp);
+		if (__kernel_text_address(addr))
+			return true;
+	}
+
+	return false;
+}
+
+bool unwind_next_frame(struct unwind_state *state)
+{
+	struct stack_info *info = &state->stack_info;
+	struct pt_regs *regs;
+	unsigned long pc;
+
+	if (unwind_done(state))
+		return false;
+
+	do {
+		if (state->enable) {
+			if (unwind_by_prologue(state))
+				return true;
+
+			if (info->type == STACK_TYPE_IRQ &&
+				info->end == state->sp) {
+				regs = (struct pt_regs *)info->next_sp;
+				pc = regs->csr_era;
+				if (user_mode(regs) || !__kernel_text_address(pc))
+					return false;
+
+				state->pc = pc;
+				state->sp = regs->regs[3];
+				state->ra = regs->regs[1];
+				state->first = true;
+				get_stack_info(state->sp, state->task, info);
+
+				return true;
+			}
+		} else {
+			if (state->first)
+				state->first = false;
+			else if (unwind_by_guess(state))
+				return true;
+		}
+
+		state->sp = info->next_sp;
+
+	} while (!get_stack_info(state->sp, state->task, info));
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(unwind_next_frame);
+
+void unwind_start(struct unwind_state *state, struct task_struct *task,
+		    struct pt_regs *regs)
+{
+	memset(state, 0, sizeof(*state));
+
+	if (__kernel_text_address(regs->csr_era))
+		state->enable = true;
+
+	state->task = task;
+	state->pc = regs->csr_era;
+	state->sp = regs->regs[3];
+	state->ra = regs->regs[1];
+	state->first = true;
+
+	get_stack_info(state->sp, state->task, &state->stack_info);
+
+	if (!unwind_done(state) && !__kernel_text_address(state->pc))
+		unwind_next_frame(state);
+}
+EXPORT_SYMBOL_GPL(unwind_start);
-- 
2.20.1

