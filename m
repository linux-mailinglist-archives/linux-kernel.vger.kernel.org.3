Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC57A5A781F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiHaHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHaHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:51:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC696558
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:49:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MHbrP0cHszHnYm;
        Wed, 31 Aug 2022 15:48:05 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 15:49:51 +0800
Message-ID: <2ab8be67-fad5-7bef-6140-43312870d845@huawei.com>
Date:   Wed, 31 Aug 2022 15:49:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] arch/riscv: kprobes: implement optprobes
To:     <Conor.Dooley@microchip.com>, <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220831041014.1295054-1-chenguokai17@mails.ucas.ac.cn>
 <882e9efc-7222-c3af-e37b-f339789e94c0@microchip.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <882e9efc-7222-c3af-e37b-f339789e94c0@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/8/31 15:24, Conor.Dooley@microchip.com 写道:
> Hey Chen,
> 
> FYI there is a build warning with this patch:
> arch/riscv/kernel/probes/opt.c:34:27: warning: no previous prototype for 'can_kprobe_direct_exec' [-Wmissing-prototypes]
>     34 | enum probe_insn __kprobes can_kprobe_direct_exec(kprobe_opcode_t *addr)
> 
> Also, if you run scripts/checkpatch.pl --strict, it will have a
> few complaints about code style for you too. Other than that, I
> have a few comments for you below:
> 
> On 31/08/2022 05:10, Chen Guokai wrote:
>> [You don't often get email from chenguokai17@mails.ucas.ac.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> This patch adds jump optimization support for RISC-V.
> 
> s/This patch adds/Add
> 
>>
>> This patch replaces ebreak instructions used by normal kprobes with an
> 
> s/This patch replaces/Replace
> 
>> auipc+jalr instruction pair, at the aim of suppressing the probe-hit
>> overhead.
>>
>> All known optprobe-capable RISC architectures have been using a single
>> jump or branch instructions while this patch chooses not. RISC-V has a
>> quite limited jump range (4KB or 2MB) for both its branch and jump
>> instructions, which prevent optimizations from supporting probes that
>> spread all over the kernel.
>>
>> Auipc-jalr instruction pair is introduced with a much wider jump range
>> (4GB), where auipc loads the upper 12 bits to a free register and jalr
>> appends the lower 20 bits to form a 32 bit immediate. Note that returning
>> from probe handler requires another free register. As kprobes can appear
>> almost anywhere inside the kernel, the free register should be found in a
>> generic way, not depending on calling convension or any other regulations.
> 
> convention
> 
>>
>> The algorithm for finding the free register is inspired by the regiter
> 
> register
> 
>> renaming in modern processors. From the perspective of register renaming, a
>> register could be represented as two different registers if two neighbour
>> instructions both write to it but no one ever reads. Extending this fact,
>> a register is considered to be free if there is no read before its next
>> write in the execution flow. We are free to change its value without
>> interfering normal execution.
>>
>> Static analysis shows that 51% instructions of the kernel (default config)
>> is capable of being replaced i.e. two free registers can be found at both
>> the start and end of replaced instruction pairs while the replaced
>> instructions can be directly executed.
>>
>> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> 
> What does Liao have to do with this patch?I just provide some suggestion to Chen Guokai during development ;)
please remove my info from Signed-off-by tag.

> 
>> ---
>>   arch/riscv/Kconfig                        |   1 +
>>   arch/riscv/include/asm/ftrace.h           |   2 +-
>>   arch/riscv/include/asm/kprobes.h          |  28 ++
>>   arch/riscv/kernel/probes/Makefile         |   1 +
>>   arch/riscv/kernel/probes/opt.c            | 483 ++++++++++++++++++++++
>>   arch/riscv/kernel/probes/opt_trampoline.S | 133 ++++++
>>   arch/riscv/kernel/probes/simulate-insn.h  |   9 +
>>   7 files changed, 656 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/riscv/kernel/probes/opt.c
>>   create mode 100644 arch/riscv/kernel/probes/opt_trampoline.S
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index d557cc502..a54e50de2 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -97,6 +97,7 @@ config RISCV
>>          select HAVE_KPROBES if !XIP_KERNEL
>>          select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>>          select HAVE_KRETPROBES if !XIP_KERNEL
>> +       select HAVE_OPTPROBES if !XIP_KERNEL && !CONFIG_RISCV_ISA_C
>>          select HAVE_MOVE_PMD
>>          select HAVE_MOVE_PUD
>>          select HAVE_PCI
>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>> index 04dad3380..8b17a4c66 100644
>> --- a/arch/riscv/include/asm/ftrace.h
>> +++ b/arch/riscv/include/asm/ftrace.h
>> @@ -35,7 +35,7 @@ struct dyn_arch_ftrace {
>>   };
>>   #endif
>>
>> -#ifdef CONFIG_DYNAMIC_FTRACE
>> +#if defined(CONFIG_DYNAMIC_FTRACE) || defined(CONFIG_OPTPROBES)
>>   /*
>>    * A general call in RISC-V is a pair of insts:
>>    * 1) auipc: setting high-20 pc-related bits to ra register
>> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
>> index 217ef89f2..6c5e10709 100644
>> --- a/arch/riscv/include/asm/kprobes.h
>> +++ b/arch/riscv/include/asm/kprobes.h
>> @@ -43,5 +43,33 @@ bool kprobe_single_step_handler(struct pt_regs *regs);
>>   void __kretprobe_trampoline(void);
>>   void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>
>> +#ifdef CONFIG_OPTPROBES
>> +
>> +#define MAX_OPTIMIZED_LENGTH   8
>> +
>> +/* optinsn template addresses */
>> +extern __visible kprobe_opcode_t optprobe_template_entry[];
>> +extern __visible kprobe_opcode_t optprobe_template_val[];
>> +extern __visible kprobe_opcode_t optprobe_template_call[];
>> +extern __visible kprobe_opcode_t optprobe_template_store_epc[];
>> +extern __visible kprobe_opcode_t optprobe_template_end[];
>> +extern __visible kprobe_opcode_t optprobe_template_sub_sp[];
>> +extern __visible kprobe_opcode_t optprobe_template_add_sp[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
>> +
>> +#define MAX_OPTINSN_SIZE                               \
>> +               ((unsigned long)optprobe_template_end - \
>> +                (unsigned long)optprobe_template_entry)
>> +
>> +#define MAX_COPIED_INSN 2
>> +struct arch_optimized_insn {
>> +               kprobe_opcode_t copied_insn[MAX_COPIED_INSN];
>> +                       /* detour code buffer */
>> +                       kprobe_opcode_t *insn;
>> +};
>> +#define RVI_INST_SIZE 4
>> +#endif /* CONFIG_OPTPROBES */
>>   #endif /* CONFIG_KPROBES */
>>   #endif /* _ASM_RISCV_KPROBES_H */
>> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
>> index 7f0840dcc..6255b4600 100644
>> --- a/arch/riscv/kernel/probes/Makefile
>> +++ b/arch/riscv/kernel/probes/Makefile
>> @@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)           += kprobes.o decode-insn.o simulate-insn.o
>>   obj-$(CONFIG_KPROBES)          += kprobes_trampoline.o
>>   obj-$(CONFIG_KPROBES_ON_FTRACE)        += ftrace.o
>>   obj-$(CONFIG_UPROBES)          += uprobes.o decode-insn.o simulate-insn.o
>> +obj-$(CONFIG_OPTPROBES)                += opt.o opt_trampoline.o
>>   CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
>> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
>> new file mode 100644
>> index 000000000..b9bcf6e12
>> --- /dev/null
>> +++ b/arch/riscv/kernel/probes/opt.c
>> @@ -0,0 +1,483 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *  Kernel Probes Jump Optimization (Optprobes)
>> + *
>> + * Copyright (C) IBM Corporation, 2002, 2004
>> + * Copyright (C) Hitachi Ltd., 2012
>> + * Copyright (C) Huawei Inc., 2014
>> + * Copyright (C) 2022 Huawei Technologies Co., Ltd
>> + * Copyright (C) Guokai Chen, 2022
> 
> Should this not be your University here?
> 
>> + * Author: Guokai Chen chenguokai17@mails.ucas.ac.cn
>> + */
>> +
>> +#include <linux/kprobes.h>
>> +#include <linux/jump_label.h>
>> +#include <linux/extable.h>
>> +#include <linux/stop_machine.h>
>> +#include <linux/moduleloader.h>
>> +#include <linux/kprobes.h>
>> +#include <linux/cacheflush.h>
>> +/* for patch_text */
>> +#include <asm/ftrace.h>
>> +#include <asm/patch.h>
>> +#include "simulate-insn.h"
>> +#include "decode-insn.h"
>> +
>> +
>> +#define JUMP_SIZE 8
>> +
>> +/*
>> + * If the probed instruction doesn't use PC and is not system or fence
>> + * we can copy it into template and have it executed directly without
>> + * simulation or emulation.
>> + */
>> +enum probe_insn __kprobes can_kprobe_direct_exec(kprobe_opcode_t *addr)
>> +{
>> +       /*
>> +        * instructions that use PC
>> +        * branch jump auipc
>> +        * instructions that belongs to system or fence
>> +        * ebreak ecall fence.i
> 
> Please use the full columns available to you for comments.
> 
>> +        */
>> +       kprobe_opcode_t inst = *addr;
>> +
>> +       RISCV_INSN_REJECTED(system, inst);
>> +       RISCV_INSN_REJECTED(fence, inst);
>> +       RISCV_INSN_REJECTED(branch, inst);
>> +       RISCV_INSN_REJECTED(jal, inst);
>> +       RISCV_INSN_REJECTED(jalr, inst);
>> +       RISCV_INSN_REJECTED(auipc, inst);
>> +       return INSN_GOOD_NO_SLOT;
>> +}
>> +
>> +#define TMPL_VAL_IDX \
>> +       ((kprobe_opcode_t *)optprobe_template_val - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_CALL_IDX \
>> +       ((kprobe_opcode_t *)optprobe_template_call - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_STORE_EPC_IDX \
>> +       ((kprobe_opcode_t *)optprobe_template_store_epc - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_END_IDX \
>> +       ((kprobe_opcode_t *)optprobe_template_end - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_ADD_SP \
>> +       ((kprobe_opcode_t *)optprobe_template_add_sp - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_SUB_SP \
>> +       ((kprobe_opcode_t *)optprobe_template_sub_sp - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_RESTORE_BEGIN \
>> +       ((kprobe_opcode_t *)optprobe_template_restore_begin - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_RESTORE_ORIGN_INSN \
>> +       ((kprobe_opcode_t *)optprobe_template_restore_orig_insn - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_RESTORE_RET \
>> +       ((kprobe_opcode_t *)optprobe_template_ret - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +#define TMPL_RESTORE_END \
>> +       ((kprobe_opcode_t *)optprobe_template_restore_end - \
>> +        (kprobe_opcode_t *)optprobe_template_entry)
>> +
>> +#define FREE_SEARCH_DEPTH 32
>> +
>> +/*
>> + * RISC-V can always optimize an instruction if not null
>> + */
>> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
>> +{
>> +       return optinsn->insn != NULL;
>> +}
>> +
>> +/*
>> + * In RISC-V ISA, jal has a quite limited jump range
>> + * To achive adequate range, auipc+jalr is utilized
>> + * It requires a replacement of two instructions
>> + * thus next instruction should be examined
> 
> Please use the full columns available to you for comments.
> 
>> + */
>> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +       struct kprobe *p;
>> +
>> +       p = get_kprobe(op->kp.addr + 4);
> 
> Where does this 4 come from?
> 
>> +       if (p && !kprobe_disabled(p))
>> +               return -EEXIST;
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * In RISC-V ISA, auipc+jalr requires a free register
>> + * Inspired by register renaming in OoO processor,
>> + * we search backwards to find such a register that:
>> + * not previously used as a source register &&
>> + * is used as a destination register &&
>> + * before any branch/jump instruction
> 
> Ditto re comment width.
> 
>> + */
>> +static int
>> +__arch_find_free_register(kprobe_opcode_t *addr, int use_orig,
>> +                         kprobe_opcode_t orig)
>> +{
>> +       int i, rs1, rs2, rd;
>> +       kprobe_opcode_t inst;
>> +       int rs_mask = 0;
>> +
>> +       for (i = 0; i < FREE_SEARCH_DEPTH; i++) {
>> +               if (i == 0 && use_orig)
>> +                       inst = orig;
>> +               else
>> +                       inst = *(kprobe_opcode_t *) (addr + i);
>> +               /*
>> +                * Detailed handling:
>> +                * jalr/branch/system: must have reached the end, no result
>> +                * jal: if not chosen as result, must have reached the end
>> +                * arithmetic/load/store: record their rs
>> +                * jal/arithmetic/load: if proper rd found, return result
>> +                * others (float point/vector): ignore
>> +                */
>> +               if (riscv_insn_is_branch(inst) || riscv_insn_is_jalr(inst)
>> +                       || riscv_insn_is_system(inst)) {
>> +                       return 0;
>> +               }
>> +               /* instructions that has rs1 */
>> +               if (riscv_insn_is_arith_ri(inst) || riscv_insn_is_arith_rr(inst)
>> +                       || riscv_insn_is_load(inst) || riscv_insn_is_store(inst)
>> +                       || riscv_insn_is_amo(inst)) {
>> +                       rs1 = (inst & 0xF8000) >> 15;
>> +                       rs_mask |= 1 << rs1;
>> +               }
>> +               /* instructions that has rs2 */
>> +               if (riscv_insn_is_arith_rr(inst) || riscv_insn_is_store(inst)
>> +                       || riscv_insn_is_amo(inst)) {
>> +                       rs2 = (inst & 0x1F00000) >> 20;
>> +                       rs_mask |= 1 << rs2;
>> +               }
>> +               /* instructions that has rd */
>> +               if (riscv_insn_is_lui(inst) || riscv_insn_is_jal(inst)
>> +                       || riscv_insn_is_load(inst) || riscv_insn_is_arith_ri(inst)
>> +                       || riscv_insn_is_arith_rr(inst) || riscv_insn_is_amo(inst)) {
>> +                       rd = (inst & 0xF80) >> 7;
>> +                       if (rd != 0 && (rs_mask & (1 << rd)) == 0)
>> +                               return rd;
>> +                       if (riscv_insn_is_jal(inst))
>> +                               return 0;
>> +               }
>> +       }
>> +       return 0;
>> +}
>> +
>> +/*
>> + * If two free registers can be found at the beginning of both
>> + * the start and the end of replaced code, it can be optimized
>> + * Also, in-function jumps need to be checked to make sure that
>> + * there is no jump to the second instruction to be replaced
>> + */
>> +
>> +#define branch_imm(opcode) \
>> +       (((((opcode) >>  8) & 0xf) <<  1) | \
>> +        ((((opcode) >> 25) & 0x3f) <<  5) | \
>> +        ((((opcode) >>  7) & 0x1) << 11) | \
>> +        ((((opcode) >> 31) & 0x1) << 12))
> 
> All the numbers in here are quite meaningless to me.
> Could you please use defines here?
> 
>> +
>> +#define branch_offset(opcode) \
>> +       sign_extend32((branch_imm(opcode)), 12)
>> +
>> +#define jal_imm(opcode) \
>> +       ((((opcode >> 21) & 0x3ff) << 1) | \
>> +        (((opcode >> 20) & 0x1) << 11) | \
>> +        (((opcode >> 31) & 0x1) << 20))
>> +#define jal_offset(opcode) \
>> +       sign_extend32(jal_imm(opcode), 20)
>> +
>> +static int can_optimize(unsigned long paddr, kprobe_opcode_t orig)
>> +{
>> +       unsigned long addr, size = 0, offset = 0, target;
>> +       s32 imm;
>> +       kprobe_opcode_t inst;
>> +
>> +       if (!kallsyms_lookup_size_offset(paddr, &size, &offset))
>> +               return 0;
>> +
>> +       addr = paddr - offset;
>> +
>> +       /* if there are not enough space for our kprobe, skip */
>> +       if (addr + size <= paddr + MAX_OPTIMIZED_LENGTH)
>> +               return 0;
>> +
>> +       while (addr < paddr - offset + size) {
>> +               /* Check from the start until the end */
>> +
>> +               inst = *(kprobe_opcode_t *)addr;
>> +               /* branch and jal is capable of determing target before execution */
>> +               if (riscv_insn_is_branch(inst)) {
>> +                       imm = branch_offset(inst);
>> +                       target = addr + imm;
>> +                       if (target == paddr + RVI_INST_SIZE)
>> +                               return 0;
>> +               } else if (riscv_insn_is_jal(inst)) {
>> +                       imm = jal_offset(inst);
>> +                       target = addr + imm;
>> +                       if (target == paddr + RVI_INST_SIZE)
>> +                               return 0;
>> +               }
>> +               /* RVI is always 4 byte long */
>> +               addr += 4;
>> +       }
>> +
>> +       if (can_kprobe_direct_exec((kprobe_opcode_t *)(paddr + 4)) != INSN_GOOD_NO_SLOT)
>> +               return 0;
>> +
>> +       /* only valid when we find two free registers */
>> +       return __arch_find_free_register((kprobe_opcode_t *) paddr, 1, orig)
>> +               && __arch_find_free_register((kprobe_opcode_t *) (paddr + JUMP_SIZE), 0, 0);
>> +}
>> +
>> +/* Free optimized instruction slot */
>> +static void
>> +__arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
>> +{
>> +       if (op->optinsn.insn) {
>> +               free_optinsn_slot(op->optinsn.insn, dirty);
>> +               op->optinsn.insn = NULL;
>> +       }
>> +}
>> +
>> +extern void kprobe_handler(struct pt_regs *regs);
>> +
>> +static void
>> +optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
>> +{
>> +       unsigned long flags;
>> +       struct kprobe_ctlblk *kcb;
>> +
>> +       /* Save skipped registers */
>> +       regs->epc = (unsigned long)op->kp.addr;
>> +       regs->orig_a0 = ~0UL;
>> +
>> +       local_irq_save(flags);
>> +       kcb = get_kprobe_ctlblk();
>> +
>> +       if (kprobe_running()) {
>> +               kprobes_inc_nmissed_count(&op->kp);
>> +       } else {
>> +               __this_cpu_write(current_kprobe, &op->kp);
>> +               kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>> +               opt_pre_handler(&op->kp, regs);
>> +               __this_cpu_write(current_kprobe, NULL);
>> +       }
>> +
>> +       local_irq_restore(flags);
>> +}
>> +
>> +NOKPROBE_SYMBOL(optimized_callback)
>> +static inline kprobe_opcode_t
>> +__arch_patch_rd(kprobe_opcode_t inst, unsigned long val)
>> +{
>> +       inst &= 0xfffff07fUL;
> 
> It'd be nice if these were defines too, so that it was clear to
> the untrained eye what's going on here.
> 
>> +       inst |= val << 7;
>> +       return inst;
>> +}
>> +
>> +static inline kprobe_opcode_t
>> +__arch_patch_rs1(kprobe_opcode_t inst, unsigned long val)
>> +{
>> +       inst &= 0xfff07fffUL;
>> +       inst |= val << 15;
>> +       return inst;
>> +}
>> +
>> +static inline kprobe_opcode_t __arch_patch_rs2(kprobe_opcode_t inst,
>> +                                                  unsigned long val)
>> +{
>> +       inst &= 0xfe0fffffUL;
>> +       inst |= val << 20;
>> +       return inst;
>> +}
>> +
>> +int
>> +arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
>> +{
>> +       kprobe_opcode_t *code, *detour_slot, *detour_ret_addr;
>> +       long rel_chk;
>> +       unsigned long val;
>> +
>> +       /* not aligned address */
>> +       #ifdef CONFIG_RISCV_ISA_C
> 
> Please use IS_ENABLED() here if you can.
> 
>> +       return -ERANGE;
>> +       #endif
>> +
>> +       if (!can_optimize((unsigned long)orig->addr, orig->opcode))
>> +               return -EILSEQ;
>> +
>> +       code = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
>> +       detour_slot = get_optinsn_slot();
>> +
>> +       if (!code || !detour_slot) {
>> +               kfree(code);
>> +               if (detour_slot)
>> +                       free_optinsn_slot(detour_slot, 0);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       /*
>> +        * Verify if the address gap is within 4GB range, because this uses
>> +        * a auipc+jalr pair.
>> +        */
>> +       rel_chk = (long)detour_slot - (long)orig->addr + 8;
>> +       if (abs(rel_chk) > 0x7fffffff) {
> 
> GENMASK please.
> 
>> +               /*
>> +                * Different from x86, we free code buf directly instead of
>> +                * calling __arch_remove_optimized_kprobe() because
>> +                * we have not fill any field in op.
>> +                */
>> +               kfree(code);
>> +               free_optinsn_slot(detour_slot, 0);
>> +               return -ERANGE;
>> +       }
>> +
>> +       /* Copy arch-dep-instance from template. */
>> +       memcpy(code, (unsigned long *)optprobe_template_entry,
>> +                  TMPL_END_IDX * sizeof(kprobe_opcode_t));
>> +
>> +       /* Set probe information */
>> +       val = (unsigned long)op;
>> +       *(unsigned long *)(&code[TMPL_VAL_IDX]) = val;
>> +
>> +       /* Set probe function call */
>> +       val = (unsigned long)optimized_callback;
>> +       *(unsigned long *)(&code[TMPL_CALL_IDX]) = val;
> 
> What is the benefit of using val here? I think the comments
> are also pointing out the obvious here, no?
> 
>> +
>> +       /* Adjust epc register */
> 
> The comments here mainly just say what you're doing & not why
> it should be done.
> 
>> +       val = __arch_find_free_register(orig->addr, 1, orig->opcode);
>> +       /*
>> +        * patch rs2 of optprobe_template_store_epc
>> +        * after patch, optprobe_template_store_epc will be
>> +        * REG_S free_register, PT_EPC(sp)
>> +        */
>> +       code[TMPL_STORE_EPC_IDX] =
>> +               __arch_patch_rs2(code[TMPL_STORE_EPC_IDX], val);
>> +
>> +       /* Adjust return temp register */
>> +       val =
>> +               __arch_find_free_register(orig->addr +
>> +                                         JUMP_SIZE / sizeof(kprobe_opcode_t), 0,
>> +                                         0);
>> +       /*
>> +        * patch of optprobe_template_restore_end
>> +        * patch:
>> +        *   rd and imm of auipc
>> +        *   rs1 and imm of jalr
>> +        * after patch:
>> +        *   auipc free_register, %hi(return_address)
>> +        *   jalr x0, %lo(return_address)(free_register)
>> +        *
>> +        */
>> +
>> +       detour_ret_addr = &(detour_slot[optprobe_template_restore_end - optprobe_template_entry]);
>> +
>> +       make_call(detour_ret_addr, (orig->addr + JUMP_SIZE / sizeof(kprobe_opcode_t)),
>> +                       (code + TMPL_RESTORE_END));
>> +       code[TMPL_RESTORE_END] = __arch_patch_rd(code[TMPL_RESTORE_END], val);
>> +       code[TMPL_RESTORE_END + 1] =
>> +               __arch_patch_rs1(code[TMPL_RESTORE_END + 1], val);
>> +       code[TMPL_RESTORE_END + 1] = __arch_patch_rd(code[TMPL_RESTORE_END + 1], 0);
>> +
>> +       /* Copy insn and have it executed during restore */
>> +
>> +       code[TMPL_RESTORE_ORIGN_INSN] = orig->opcode;
>> +       code[TMPL_RESTORE_ORIGN_INSN + 1] =
>> +               *(kprobe_opcode_t *) (orig->addr + 1);
>> +
>> +       if (patch_text_nosync(detour_slot, code, MAX_OPTINSN_SIZE)) {
>> +               free_optinsn_slot(detour_slot, 0);
>> +               kfree(code);
>> +               return -EPERM;
>> +       }
>> +
>> +       kfree(code);
>> +       /* Set op->optinsn.insn means prepared. */
>> +       op->optinsn.insn = detour_slot;
>> +       return 0;
>> +}
>> +
>> +void __kprobes arch_optimize_kprobes(struct list_head *oplist)
>> +{
>> +       struct optimized_kprobe *op, *tmp;
>> +       kprobe_opcode_t val;
>> +
>> +       list_for_each_entry_safe(op, tmp, oplist, list) {
>> +               kprobe_opcode_t insn[2];
>> +
>> +               WARN_ON(kprobe_disabled(&op->kp));
>> +
>> +               /*
>> +                * Backup instructions which will be replaced
>> +                * by jump address
>> +                */
>> +               memcpy(op->optinsn.copied_insn, op->kp.addr, JUMP_SIZE);
>> +               op->optinsn.copied_insn[0] = op->kp.opcode;
>> +
>> +               make_call(op->kp.addr, op->optinsn.insn, insn);
>> +
>> +               // patch insn jalr to have rd as free register
>> +               val = (op->optinsn.insn[2] & 0x1F00000) >> 20;
> 
> Again, could you use some defines to make this more understandable
> to mere mortals like me? ;)
> 
>> +
>> +               insn[0] = __arch_patch_rd(insn[0], val);
>> +
>> +               insn[1] = __arch_patch_rd(insn[1], val);
>> +               insn[1] = __arch_patch_rs1(insn[1], val);
>> +
>> +               /*
>> +                * Similar to __arch_disarm_kprobe, operations which
>> +                * removing breakpoints must be wrapped by stop_machine
>> +                * to avoid racing.
>> +                */
>> +               WARN_ON(patch_text_nosync(op->kp.addr, insn, JUMP_SIZE));
>> +
>> +               list_del_init(&op->list);
>> +       }
>> +}
>> +
>> +static int arch_disarm_kprobe_opt(void *vop)
>> +{
>> +       struct optimized_kprobe *op = (struct optimized_kprobe *)vop;
>> +
>> +       patch_text_nosync(op->kp.addr, op->optinsn.copied_insn, JUMP_SIZE);
>> +       arch_arm_kprobe(&op->kp);
>> +       return 0;
>> +}
>> +
>> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>> +{
>> +       arch_disarm_kprobe_opt((void *)op);
>> +}
>> +
>> +/*
>> + * Recover original instructions and breakpoints from relative jumps.
>> + * Caller must call with locking kprobe_mutex.
>> + */
>> +void arch_unoptimize_kprobes(struct list_head *oplist,
>> +                                struct list_head *done_list)
>> +{
>> +       struct optimized_kprobe *op, *tmp;
>> +
>> +       list_for_each_entry_safe(op, tmp, oplist, list) {
>> +               arch_unoptimize_kprobe(op);
>> +               list_move(&op->list, done_list);
>> +       }
>> +}
>> +
>> +int arch_within_optimized_kprobe(struct optimized_kprobe *op,
>> +                                kprobe_opcode_t *addr)
>> +{
>> +       return (op->kp.addr <= addr &&
>> +               op->kp.addr + (JUMP_SIZE / sizeof(kprobe_opcode_t)) > addr);
>> +
>> +}
>> +
>> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +       __arch_remove_optimized_kprobe(op, 1);
>> +}
>> diff --git a/arch/riscv/kernel/probes/opt_trampoline.S b/arch/riscv/kernel/probes/opt_trampoline.S
> 
> Thanks,
> Conor.
> 
> 
> 

-- 
BR,
Liao, Chang
