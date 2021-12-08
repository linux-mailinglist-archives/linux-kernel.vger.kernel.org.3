Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB246CF30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbhLHIkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbhLHIke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:40:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B83C061574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0626CE2035
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E950C00446;
        Wed,  8 Dec 2021 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638952619;
        bh=YkXTVyIR+lkzHQ7qhzOd9U5X6wCZzC8xHGITRuS4y2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QRk0Y1yMSMGxmnfBhWdQpodt8d0U3Dy9CuiW7ZpkjcUzDp3xGI9zCKDArKgBRSMKa
         hDk16/9qcgJTbfThmigA3g6gKVIAs0AP2POm5NxVlyA2ayyq6iHxsO274V8DXt0VD4
         H+ZCtHeiuYaHVzVDSZGse8Qy90IM8MQtJnbCqX0FAMl1v9zUstsw92U+sZ1Fh+eRgr
         Uv02dk0MU+vvEo/BIgv/a2kBvkXezoZLORgw6aTZXMzigU7b/H3DksDwIqKa+BQzJp
         V4Gh9r+1Art3VmOwhrCVElP6/paMhNrlPvkKI3AAeOyC/v3PjZyiMdV9dLvvl344W4
         bMkPxmckti0fA==
Date:   Wed, 8 Dec 2021 17:36:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20211208173655.b2b6f98ad9f38c7a4bcc5d59@kernel.org>
In-Reply-To: <20211207124002.59877-1-liuqi115@huawei.com>
References: <20211207124002.59877-1-liuqi115@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 Dec 2021 20:40:02 +0800
Qi Liu <liuqi115@huawei.com> wrote:

> This patch introduce optprobe for ARM64. In optprobe, probed
> instruction is replaced by a branch instruction to trampoline.
> 
> Performance of optprobe on Hip08 platform is test using kprobe
> example module[1] to analyze the latency of a kernel function,
> and here is the result:
> 
> common kprobe:
> [280709.846380] do_empty returned 0 and took 1530 ns to execute
> [280709.852057] do_empty returned 0 and took 550 ns to execute
> [280709.857631] do_empty returned 0 and took 440 ns to execute
> [280709.863215] do_empty returned 0 and took 380 ns to execute
> [280709.868787] do_empty returned 0 and took 360 ns to execute
> [280709.874362] do_empty returned 0 and took 340 ns to execute
> [280709.879936] do_empty returned 0 and took 320 ns to execute
> [280709.885505] do_empty returned 0 and took 300 ns to execute
> [280709.891075] do_empty returned 0 and took 280 ns to execute
> [280709.896646] do_empty returned 0 and took 290 ns to execute
> 
> optprobe:
> [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> 
> As the result shows, optprobe can greatly reduce the latency. Big
> latency of common kprobe will significantly impact the real result
> while doing performance analysis or debugging performance issues
> in lab, so optprobe is useful in this scenario.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> Note:
> As branch instruction in Arm64 has a 128M range limitation, optprobe
> could only used when offset between probe point and trampoline
> is less than 128M, otherwise kernel will choose common kprobe
> automaticly.
> 
> Limitation caused by branch isn't unique to Arm64, but also to
> x86/arm/powerpc.
> 
> In fact, Module PLT has been tried to get rid of limiation, but
> destination of PLT must be a fixed value, and we need to modify
> the destination (as each optprobe has its own trampoline).
> 
> As discussed with Masami[2], we can start with core-kernel point
> (within 128M) as the first step, like other architectures.

Thanks for updating! This is exactly what I expected.
I think this is good for the first step. Shrink down the trampoline
code will be the next step (the series after this series).

Thank you very much for your effort!


> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
> [2] https://lore.kernel.org/lkml/20211201105001.5164f98ba783e7207df1229c@kernel.org/
> ---
>  arch/arm64/Kconfig                            |   1 +
>  arch/arm64/include/asm/kprobes.h              |  21 ++
>  arch/arm64/kernel/probes/Makefile             |   2 +
>  arch/arm64/kernel/probes/opt_arm64.c          | 199 ++++++++++++++++++
>  .../arm64/kernel/probes/optprobe_trampoline.S |  97 +++++++++
>  include/linux/kprobes.h                       |   2 +
>  kernel/kprobes.c                              |  22 ++
>  7 files changed, 344 insertions(+)
>  create mode 100644 arch/arm64/kernel/probes/opt_arm64.c
>  create mode 100644 arch/arm64/kernel/probes/optprobe_trampoline.S
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17..6b68ec498e67 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -200,6 +200,7 @@ config ARM64
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
> +	select HAVE_OPTPROBES
>  	select HAVE_KRETPROBES
>  	select HAVE_GENERIC_VDSO
>  	select IOMMU_DMA if IOMMU_SUPPORT
> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
> index 05cd82eeca13..3838e4317877 100644
> --- a/arch/arm64/include/asm/kprobes.h
> +++ b/arch/arm64/include/asm/kprobes.h
> @@ -39,6 +39,27 @@ void arch_remove_kprobe(struct kprobe *);
>  int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>  int kprobe_exceptions_notify(struct notifier_block *self,
>  			     unsigned long val, void *data);
> +
> +struct arch_optimized_insn {
> +	kprobe_opcode_t orig_insn[1];
> +	kprobe_opcode_t *trampoline;
> +};
> +
> +#define MAX_OPTIMIZED_LENGTH	sizeof(kprobe_opcode_t)
> +#define MAX_OPTINSN_SIZE                                                       \
> +	((unsigned long)optprobe_template_restore_end - (unsigned long)optprobe_template_entry)
> +
> +extern __visible kprobe_opcode_t optprobe_template_entry[];
> +extern __visible kprobe_opcode_t optprobe_template_val[];
> +extern __visible kprobe_opcode_t optprobe_template_common[];
> +extern __visible kprobe_opcode_t optprobe_template_end[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
> +extern __visible kprobe_opcode_t optinsn_slot[];
> +
> +void optprobe_common(void);
> +
>  void __kretprobe_trampoline(void);
>  void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>  
> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> index 8e4be92e25b1..07105fd3261d 100644
> --- a/arch/arm64/kernel/probes/Makefile
> +++ b/arch/arm64/kernel/probes/Makefile
> @@ -4,3 +4,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>  				   simulate-insn.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>  				   simulate-insn.o
> +obj-$(CONFIG_OPTPROBES)		+= opt_arm64.o			\
> +				   optprobe_trampoline.o
> diff --git a/arch/arm64/kernel/probes/opt_arm64.c b/arch/arm64/kernel/probes/opt_arm64.c
> new file mode 100644
> index 000000000000..1bad5cddcdf2
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/opt_arm64.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Code for Kernel probes Jump optimization.
> + *
> + * Copyright (C) 2021 Hisilicon Limited
> + */
> +
> +#include <linux/jump_label.h>
> +#include <linux/kprobes.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/compiler.h>
> +#include <asm/insn.h>
> +#include <asm/kprobes.h>
> +#include <asm/patching.h>
> +
> +#define OPTPROBE_BATCH_SIZE 64
> +#define GET_LO_VAL(val)		FIELD_GET(GENMASK(31, 0), val)
> +#define GET_HI_VAL(val)		FIELD_GET(GENMASK(63, 32), val)
> +
> +#define TMPL_VAL_IDX \
> +	(optprobe_template_val - optprobe_template_entry)
> +#define TMPL_CALL_COMMON \
> +	(optprobe_template_common - optprobe_template_entry)
> +#define TMPL_RESTORE_ORIGN_INSN \
> +	(optprobe_template_restore_orig_insn - optprobe_template_entry)
> +#define TMPL_RESTORE_END \
> +	(optprobe_template_restore_end - optprobe_template_entry)
> +#define TMPL_END_IDX \
> +	(optprobe_template_end - optprobe_template_entry)
> +
> +static bool insn_page_in_use;
> +
> +void *alloc_optinsn_page(void)
> +{
> +	if (insn_page_in_use)
> +		return NULL;
> +	insn_page_in_use = true;
> +	return &optinsn_slot;
> +}
> +
> +void free_optinsn_page(void *page)
> +{
> +	insn_page_in_use = false;
> +}
> +
> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	return 0;
> +}
> +
> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
> +{
> +	return optinsn->trampoline != NULL;
> +}
> +
> +int arch_within_optimized_kprobe(struct optimized_kprobe *op, kprobe_opcode_t *addr)
> +{
> +	return op->kp.addr == addr;
> +}
> +
> +static void optprobe_set_pc_value(struct optimized_kprobe *op, struct pt_regs *regs)
> +{
> +	regs->pc = (unsigned long)op->kp.addr;
> +}
> +
> +static int optprobe_check_branch_limit(unsigned long pc, unsigned long addr)
> +{
> +	long offset;
> +
> +	if ((pc & 0x3) || (addr & 0x3))
> +		return -ERANGE;
> +
> +	offset = (long)addr - (long)pc;
> +	if (offset < -SZ_128M || offset >= SZ_128M)
> +		return -ERANGE;
> +
> +	return 0;
> +}
> +
> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
> +{
> +	kprobe_opcode_t *code, *buf;
> +	u32 insn;
> +	int ret = -ENOMEM;
> +	int i;
> +
> +	buf = kcalloc(MAX_OPTINSN_SIZE, sizeof(kprobe_opcode_t), GFP_KERNEL);
> +	if (!buf)
> +		return ret;
> +
> +	code = get_optinsn_slot();
> +	if (!code)
> +		goto out;
> +
> +	if (optprobe_check_branch_limit((unsigned long)code, (unsigned long)orig->addr + 8)) {
> +		ret = -ERANGE;
> +		goto error;
> +	}
> +
> +	op->set_pc = optprobe_set_pc_value;
> +	memcpy(buf, optprobe_template_entry, MAX_OPTINSN_SIZE * sizeof(kprobe_opcode_t));
> +
> +	insn = aarch64_insn_gen_branch_imm((unsigned long)&code[TMPL_CALL_COMMON],
> +					   (unsigned long)&optprobe_common,
> +					   AARCH64_INSN_BRANCH_LINK);
> +	buf[TMPL_CALL_COMMON] = insn;
> +
> +	insn = aarch64_insn_gen_branch_imm((unsigned long)&code[TMPL_RESTORE_END],
> +					   (unsigned long)op->kp.addr + 4,
> +					   AARCH64_INSN_BRANCH_NOLINK);
> +	buf[TMPL_RESTORE_END] = insn;
> +
> +	buf[TMPL_VAL_IDX] = cpu_to_le32(GET_LO_VAL((unsigned long)op));
> +	buf[TMPL_VAL_IDX + 1] = cpu_to_le32(GET_HI_VAL((unsigned long)op));
> +	buf[TMPL_RESTORE_ORIGN_INSN] = orig->opcode;
> +
> +	/* Setup template */
> +	for (i = 0; i < MAX_OPTINSN_SIZE; i++)
> +		aarch64_insn_patch_text_nosync(code + i, buf[i]);
> +
> +	flush_icache_range((unsigned long)code, (unsigned long)(&code[TMPL_VAL_IDX]));
> +	/* Set op->optinsn.trampoline means prepared. */
> +	op->optinsn.trampoline = code;
> +
> +out:
> +	kfree(buf);
> +	return ret;
> +
> +error:
> +	free_optinsn_slot(code, 0);
> +	goto out;
> +}
> +
> +void arch_optimize_kprobes(struct list_head *oplist)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +	kprobe_opcode_t insns[OPTPROBE_BATCH_SIZE];
> +	void *addrs[OPTPROBE_BATCH_SIZE];
> +	int i = 0;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		WARN_ON(kprobe_disabled(&op->kp));
> +
> +		/*
> +		 * Backup instructions which will be replaced
> +		 * by jump address
> +		 */
> +		memcpy(op->optinsn.orig_insn, op->kp.addr, AARCH64_INSN_SIZE);
> +
> +		addrs[i] = (void *)op->kp.addr;
> +		insns[i] = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
> +						       (unsigned long)op->optinsn.trampoline,
> +						       AARCH64_INSN_BRANCH_NOLINK);
> +
> +		list_del_init(&op->list);
> +		if (++i == OPTPROBE_BATCH_SIZE)
> +			break;
> +	}
> +
> +	aarch64_insn_patch_text(addrs, insns, i);
> +}
> +
> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> +{
> +	arch_arm_kprobe(&op->kp);
> +}
> +
> +/*
> + * Recover original instructions and breakpoints from relative jumps.
> + * Caller must call with locking kprobe_mutex.
> + */
> +void arch_unoptimize_kprobes(struct list_head *oplist,
> +			    struct list_head *done_list)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +	kprobe_opcode_t insns[OPTPROBE_BATCH_SIZE];
> +	void *addrs[OPTPROBE_BATCH_SIZE];
> +	int i = 0;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		addrs[i] = (void *)op->kp.addr;
> +		insns[i] = BRK64_OPCODE_KPROBES;
> +		list_move(&op->list, done_list);
> +
> +		if (++i == OPTPROBE_BATCH_SIZE)
> +			break;
> +	}
> +
> +	aarch64_insn_patch_text(addrs, insns, i);
> +}
> +
> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	if (op->optinsn.trampoline) {
> +		free_optinsn_slot(op->optinsn.trampoline, 1);
> +		op->optinsn.trampoline = NULL;
> +	}
> +}
> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S b/arch/arm64/kernel/probes/optprobe_trampoline.S
> new file mode 100644
> index 000000000000..1376daeae844
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * trampoline entry and return code for optprobes.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
> +
> +#define        OPT_SLOT_SIZE   65536
> +
> +	.global optinsn_slot
> +optinsn_slot:
> +	.space  OPT_SLOT_SIZE
> +
> +SYM_CODE_START(optprobe_common)
> +	stp x2, x3, [sp, #S_X2]
> +	stp x4, x5, [sp, #S_X4]
> +	stp x6, x7, [sp, #S_X6]
> +	stp x8, x9, [sp, #S_X8]
> +	stp x10, x11, [sp, #S_X10]
> +	stp x12, x13, [sp, #S_X12]
> +	stp x14, x15, [sp, #S_X14]
> +	stp x16, x17, [sp, #S_X16]
> +	stp x18, x19, [sp, #S_X18]
> +	stp x20, x21, [sp, #S_X20]
> +	stp x22, x23, [sp, #S_X22]
> +	stp x24, x25, [sp, #S_X24]
> +	stp x26, x27, [sp, #S_X26]
> +	stp x28, x29, [sp, #S_X28]
> +	add x2, sp, #PT_REGS_SIZE
> +	str x2, [sp, #S_SP]
> +	/* Construct a useful saved PSTATE */
> +	mrs x2, nzcv
> +	mrs x3, daif
> +	orr x2, x2, x3
> +	mrs x3, CurrentEL
> +	orr x2, x2, x3
> +	mrs x3, SPSel
> +	orr x2, x2, x3
> +	stp xzr, x2, [sp, #S_PC]
> +
> +	/* set the pt_regs address to x1 */
> +	mov	x1, sp
> +	/* store lr of optprobe_common temporary */
> +	sub sp, sp, #0x10
> +	str lr, [sp, #0x8]
> +
> +	bl optprobe_optimized_callback
> +
> +	ldr lr, [sp, #0x8]
> +	add sp, sp, #0x10
> +	ldr x0, [sp, #S_PSTATE]
> +	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
> +	msr nzcv, x0
> +	ldp x0, x1, [sp, #S_X0]
> +	ldp x2, x3, [sp, #S_X2]
> +	ldp x4, x5, [sp, #S_X4]
> +	ldp x6, x7, [sp, #S_X6]
> +	ldp x8, x9, [sp, #S_X8]
> +	ldp x10, x11, [sp, #S_X10]
> +	ldp x12, x13, [sp, #S_X12]
> +	ldp x14, x15, [sp, #S_X14]
> +	ldp x16, x17, [sp, #S_X16]
> +	ldp x18, x19, [sp, #S_X18]
> +	ldp x20, x21, [sp, #S_X20]
> +	ldp x22, x23, [sp, #S_X22]
> +	ldp x24, x25, [sp, #S_X24]
> +	ldp x26, x27, [sp, #S_X26]
> +	ldp x28, x29, [sp, #S_X28]
> +	ret
> +SYM_CODE_END(optprobe_common)
> +
> +	.global optprobe_template_entry
> +optprobe_template_entry:
> +	sub sp, sp, #PT_REGS_SIZE
> +	str lr, [sp, #S_LR]
> +	stp x0, x1, [sp, #S_X0]
> +	/* Get parameters to optimized_callback() */
> +	ldr x0, 1f
> +	.global optprobe_template_common
> +optprobe_template_common:
> +	nop
> +	ldr lr, [sp, #S_LR]
> +       add sp, sp, #PT_REGS_SIZE
> +	.global optprobe_template_restore_orig_insn
> +optprobe_template_restore_orig_insn:
> +	nop
> +	.global optprobe_template_restore_end
> +optprobe_template_restore_end:
> +	nop
> +	.global optprobe_template_val
> +optprobe_template_val:
> +	1:	.long 0
> +		.long 0
> +	.global optprobe_template_end
> +optprobe_template_end:
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 8c8f7a4d93af..7be680155df7 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -329,6 +329,7 @@ struct optimized_kprobe {
>  	struct kprobe kp;
>  	struct list_head list;	/* list for optimizing queue */
>  	struct arch_optimized_insn optinsn;
> +	void (*set_pc)(struct optimized_kprobe *op, struct pt_regs *regs);
>  };
>  
>  /* Architecture dependent functions for direct jump optimization */
> @@ -345,6 +346,7 @@ extern int arch_within_optimized_kprobe(struct optimized_kprobe *op,
>  					kprobe_opcode_t *addr);
>  
>  extern void opt_pre_handler(struct kprobe *p, struct pt_regs *regs);
> +extern void optprobe_optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs);
>  
>  DEFINE_INSN_CACHE_OPS(optinsn);
>  
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 21eccc961bba..d799e562a39a 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -430,6 +430,28 @@ void opt_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(opt_pre_handler);
>  
> +void optprobe_optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
> +{
> +	if (kprobe_disabled(&op->kp))
> +		return;
> +
> +	preempt_disable();
> +
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(&op->kp);
> +	} else {
> +		op->set_pc(op, regs);
> +		__this_cpu_write(current_kprobe, &op->kp);
> +		get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
> +		opt_pre_handler(&op->kp, regs);
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +
> +	preempt_enable();
> +}
> +NOKPROBE_SYMBOL(optprobe_optimized_callback)
> +
> +
>  /* Free optimized instructions and optimized_kprobe */
>  static void free_aggr_kprobe(struct kprobe *p)
>  {
> -- 
> 2.33.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
