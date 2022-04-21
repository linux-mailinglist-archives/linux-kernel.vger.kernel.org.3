Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5283550A120
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387223AbiDUNuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiDUNt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:49:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 471223464F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:47:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DEE31515;
        Thu, 21 Apr 2022 06:47:05 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89D153F73B;
        Thu, 21 Apr 2022 06:47:03 -0700 (PDT)
Date:   Thu, 21 Apr 2022 14:47:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 4/4] arm64/ftrace: implement long jump for
 dynamic trampolines
Message-ID: <YmFgVbPuv1criVBq@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220316100132.244849-5-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316100132.244849-5-bobo.shaobowang@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:01:32PM +0800, Wang ShaoBo wrote:
> From: Cheng Jian <cj.chengjian@huawei.com>
> 
> When kaslr is enabled, long jump should be implemented for jumping
> to according trampoline and to callback from this trampoline.

I believe this is also potentially a problem with some debug
configurations, even without KASLR (e.g. I have built a ~900MiB Image in
the past), so we *might* need this more generally, even if it is
unusual.

> Firstly, we use -fpatchable-function-entry=5,3 to reserve 3 NOPs at
> the end of each function, and also 2 NOPs at the head as 3b23e4991fb6
> ("arm64: implement ftrace with regs") does, so rec->ip should be
> rec->ip + 4 after change in case there is no extra instrument
> (such as bti ) be put the head.
> 
> But should note this will increase the size of the text section:
>  //Using defconfig with -fpatchable-function-entry=5,3://
>    text        data      bss     dec        hex     filename
>   27095761  14578580   533268  42207609  2840979    vmlinux
> 
>  //Using defconfig with -fpatchable-function-entry=2://
>    text        data      bss     dec        hex     filename
>   26394597  14575988   533268  41503853  2794c6d    vmlinux

So that's ~687KiB for a ~40M kernel.

> When registering new ftrace function, we put this ftrace_ops registered
> into our trampoline allocated dynamically but not the ftrace_ops_list,
> 
>    .text section:
>      funcA:         |    funcA():       funcB():    |
>       `->  +-----+  |    |   ...         mov x9 x30 |
>            | ... |  |    |   adrp   <-   bl  <>     |
>            | nop |  |    |   add
>            | nop |  |    |   br   x16 ---+
>      funcB | nop |  |                    | ftrace_(regs_)caller_tramp:
>       `->  +-----+  |                    `--> +---------------------+
>            | nop |  |                         | ...                 |
>            | nop |  |       ftrace callsite   +---------------------+
>            | ... |  |                `----->  | PLT entry:          |
>            | nop |  |                         |      adrp           |
>            | nop |  |                         |      add            |
>     funcC: | nop |  | ftrace graph callsite   |      br   x16       |
>       `->  +-----+  |                `----->  +---------------------+
>            | nop |  |                         | ...                 |
>            | nop |  |                         +---------------------+
> 
> There are three steps to concreate this conection when registering
> a ftrace_ops for a function to be traced (Take funcB as example):
> 
> Step 1: use make_init_nop() to generate 'mov x9 x30' for LR reservation.
>           funcB:
>           | mov x9 x30
>           | nop        //rec->ip
>           | ...

So this is the same as today.

> Step 2: create trampoline and use ftrace_make_call() to update plt entry:
>           funcA:
>           | ...
>           | adrp
>           | add
> 	  | br   x16   //pointer to trampoline allocated
> 
> Step 3: fill plt entry to where ftrace_ops(addr stored in x2) contained:
>           trampoline:
>           | ...
>           | adrp
>           | add
>           | br   x16   //pointer to callback handler
> 
> At the end automically replacing nop to bl in funB to enable profiling.
>           funcB:
>           | mov x9 x30
>           | bl <>      //to first adrp in funA
>           | ...

... but these steps have a bunch of work which cannot be done
atomically, which worries me, because it means we can't safely modify a
patch-site without some *very* expensive global synchronization. I
believe we need some synchronization to safely cleanup the dynamic
trampolines themselves, but I don't know what form that takes today --
how are those freed safely?

When I last looked at this, I'd assumed we'd need a 6-instruction
patch-site (and force function alignment) so that we could have a 64-bit
value that can be patched atomically, e.g.

		NOP
		NOP
		NOP
		NOP
	func:
		(BTI)
		NOP
		NOP
		...

... which we could split up as:

	__trampoline_ptr:
		.quad	<trampoline_addr>
	__pre_patch:
		LDR	X16, __trampoline_ptr
		BL	X17		/// or `B __post_patch` if disabled
	func:
		(BTI)
		MOV	X9, X30
		B	__pre_patch	// or `NOP` if disabled
	__post_patch:
		...

... and the trampoline would have to adjust the X30 it receives as
that'd point to `func`, and it needs to point to `__post_patch` to
return back into the function.

Thanks,
Mark.

> If funcB was bound to another ftrace_ops, Step2 and Step3 will be repeated,
> If funcB was bound to multiple ftrace_ops, this trampoline will not be used
> but jump to ftrace_(regs)_caller.
> 
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  arch/arm64/Makefile              |   2 +-
>  arch/arm64/include/asm/ftrace.h  |   2 +-
>  arch/arm64/include/asm/module.h  |   9 +++
>  arch/arm64/kernel/entry-ftrace.S |   8 ++
>  arch/arm64/kernel/ftrace.c       | 127 +++++++++++++++++--------------
>  arch/arm64/kernel/module-plts.c  |  50 ++++++++++++
>  6 files changed, 140 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 2f1de88651e6..3139d6d9ee52 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -130,7 +130,7 @@ CHECKFLAGS	+= -D__aarch64__
>  
>  ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
>    KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> -  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> +  CC_FLAGS_FTRACE := -fpatchable-function-entry=5,3
>  endif
>  
>  # Default value
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 1494cfa8639b..d0562c13b1dc 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -70,7 +70,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	 * See ftrace_init_nop() for the callsite sequence.
>  	 */
>  	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
> -		return addr + AARCH64_INSN_SIZE;
> +		return addr + AARCH64_INSN_SIZE + sizeof(struct plt_entry);
>  	/*
>  	 * addr is the address of the mcount call instruction.
>  	 * recordmcount does the necessary offset calculation.
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index 4e7fa2623896..30f5b1cd5c9c 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -36,6 +36,14 @@ extern u64 module_alloc_base;
>  #define module_alloc_base	((u64)_etext - MODULES_VSIZE)
>  #endif
>  
> +enum {
> +	PLT_MAKE_NOP,
> +	PLT_MAKE_CALL,
> +	PLT_MAKE_CALL_LINK,
> +	PLT_MAKE_LCALL,
> +	PLT_MAKE_LCALL_LINK
> +};
> +
>  struct plt_entry {
>  	/*
>  	 * A program that conforms to the AArch64 Procedure Call Standard
> @@ -58,6 +66,7 @@ static inline bool is_forbidden_offset_for_adrp(void *place)
>  }
>  
>  struct plt_entry get_plt_entry(u64 dst, void *pc);
> +struct plt_entry update_plt_entry(u64 pc, u64 dst, int record);
>  bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b);
>  
>  static inline bool plt_entry_is_initialized(const struct plt_entry *e)
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index 88462d925446..71290f0e0740 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -154,8 +154,12 @@ SYM_INNER_LABEL(ftrace_regs_caller_tramp_ops, SYM_L_GLOBAL)
>  	mov	x3, sp				// regs
>  SYM_INNER_LABEL(ftrace_regs_caller_tramp_call, SYM_L_GLOBAL)
>  	nop
> +	nop
> +	nop
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  SYM_INNER_LABEL(ftrace_regs_caller_tramp_graph_call, SYM_L_GLOBAL)
> +	nop
> +	nop
>  	nop					// ftrace_graph_caller()
>  #endif
>  	ftrace_regs_restore
> @@ -175,8 +179,12 @@ SYM_INNER_LABEL(ftrace_caller_tramp_ops, SYM_L_GLOBAL)
>  	mov	x3, sp				// regs
>  SYM_INNER_LABEL(ftrace_caller_tramp_call, SYM_L_GLOBAL)
>  	nop
> +	nop
> +	nop
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  SYM_INNER_LABEL(ftrace_caller_tramp_graph_call, SYM_L_GLOBAL)
> +	nop
> +	nop
>  	nop					// ftrace_graph_caller()
>  #endif
>  	ftrace_regs_restore
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index d35a042baf75..4011aceefe8c 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -234,27 +234,55 @@ ftrace_trampoline_get_func(struct ftrace_ops *ops, bool is_graph)
>  	return func;
>  }
>  
> +static struct plt_entry *
> +update_ftrace_tramp_plt(unsigned long pc, unsigned long addr, bool enable, bool link)
> +{
> +	int i;
> +	struct plt_entry entry;
> +	u32 *pentry;
> +	long offset;
> +	struct plt_entry *plt = (struct plt_entry *)pc;
> +
> +	offset = (long)pc - (long)addr;
> +
> +	if (!enable)
> +		entry = update_plt_entry(pc, addr, PLT_MAKE_NOP);
> +	else if (offset < -SZ_128M || offset >= SZ_128M) {
> +		if (link)
> +			entry = update_plt_entry(pc, addr, PLT_MAKE_LCALL_LINK);
> +		else
> +			entry = update_plt_entry(pc, addr, PLT_MAKE_LCALL);
> +	} else {
> +		if (link)
> +			entry = update_plt_entry(pc, addr, PLT_MAKE_CALL_LINK);
> +		else
> +			entry = update_plt_entry(pc, addr, PLT_MAKE_CALL);
> +	}
> +
> +	pentry = (u32 *)&entry;
> +	for (i = 0; i < sizeof(struct plt_entry) / AARCH64_INSN_SIZE; i++)
> +		aarch64_insn_patch_text_nosync((void *)((u32*)pc + i), *(pentry + i));
> +
> +	return plt;
> +}
> +
>  static int
>  ftrace_trampoline_modify_call(struct ftrace_ops *ops, bool is_graph, bool active)
>  {
>  	unsigned long offset;
>  	unsigned long pc;
>  	ftrace_func_t func;
> -	u32 nop, branch;
>  
>  	offset = calc_trampoline_call_offset(ops->flags &
>  				FTRACE_OPS_FL_SAVE_REGS, is_graph);
>  	pc = ops->trampoline + offset;
>  
>  	func = ftrace_trampoline_get_func(ops, is_graph);
> -	nop = aarch64_insn_gen_nop();
> -	branch = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
> -				AARCH64_INSN_BRANCH_LINK);
>  
> -	if (active)
> -		return ftrace_modify_code(pc, 0, branch, false);
> -	else
> -		return ftrace_modify_code(pc, 0, nop, false);
> +	if (update_ftrace_tramp_plt(pc, (unsigned long)func, active, true))
> +		return 0;
> +
> +	return -EINVAL;
>  }
>  
>  extern int ftrace_graph_active;
> @@ -262,13 +290,6 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
>  {
>  	unsigned int size;
>  
> -	/*
> -	 * If kaslr is enabled, the address of tramp and ftrace call
> -	 * may be far away, Therefore, long jump support is required.
> -	 */
> -	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -		return;
> -
>  	if (!ops->trampoline) {
>  		ops->trampoline = create_trampoline(ops, &size);
>  		if (!ops->trampoline)
> @@ -349,17 +370,34 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  	return ftrace_modify_code(pc, 0, new, false);
>  }
>  
> -static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
> +extern void ftrace_kernel_plt(void);
> +static struct plt_entry *
> +get_ftrace_plt(struct module *mod, unsigned long pc, unsigned long addr)
>  {
> -#ifdef CONFIG_ARM64_MODULE_PLTS
> -	struct plt_entry *plt = mod->arch.ftrace_trampolines;
> +	struct plt_entry *plt;
>  
> -	if (addr == FTRACE_ADDR)
> -		return &plt[FTRACE_PLT_IDX];
> -	if (addr == FTRACE_REGS_ADDR &&
> -	    IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
> -		return &plt[FTRACE_REGS_PLT_IDX];
> +	if (mod) {
> +#ifdef CONFIG_ARM64_MODULE_PLTS
> +		plt = mod->arch.ftrace_trampolines;
> +
> +		if (addr == FTRACE_ADDR)
> +			return &plt[FTRACE_PLT_IDX];
> +		else if (addr == FTRACE_REGS_ADDR &&
> +			IS_ENABLED(CONFIG_FTRACE_WITH_REGS))
> +			return &plt[FTRACE_REGS_PLT_IDX];
> +		else {
>  #endif
> +			pc = pc - sizeof(struct plt_entry) - AARCH64_INSN_SIZE;
> +			return update_ftrace_tramp_plt(pc, addr, true, false);
> +#ifdef CONFIG_ARM64_MODULE_PLTS
> +		}
> +#endif
> +	} else {
> +		WARN_ON(addr == FTRACE_ADDR || addr == FTRACE_REGS_ADDR);
> +		pc = pc - sizeof(struct plt_entry) - AARCH64_INSN_SIZE;
> +		return update_ftrace_tramp_plt(pc, addr, true, false);
> +	}
> +
>  	return NULL;
>  }
>  
> @@ -376,9 +414,6 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  		struct module *mod;
>  		struct plt_entry *plt;
>  
> -		if (!IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> -			return -EINVAL;
> -
>  		/*
>  		 * On kernels that support module PLTs, the offset between the
>  		 * branch instruction and its target may legally exceed the
> @@ -393,12 +428,10 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  		mod = __module_text_address(pc);
>  		preempt_enable();
>  
> -		if (WARN_ON(!mod))
> -			return -EINVAL;
> -
> -		plt = get_ftrace_plt(mod, addr);
> +		plt = get_ftrace_plt(mod, pc, addr);
>  		if (!plt) {
> -			pr_err("ftrace: no module PLT for %ps\n", (void *)addr);
> +			pr_err("ftrace: no %s PLT for %ps\n",
> +					mod ? "module" : "kernel", (void *)addr);
>  			return -EINVAL;
>  		}
>  
> @@ -474,36 +507,18 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  	if (offset < -SZ_128M || offset >= SZ_128M) {
>  		u32 replaced;
>  
> -		if (!IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> -			return -EINVAL;
> -
> -		/*
> -		 * 'mod' is only set at module load time, but if we end up
> -		 * dealing with an out-of-range condition, we can assume it
> -		 * is due to a module being loaded far away from the kernel.
> -		 */
> -		if (!mod) {
> -			preempt_disable();
> -			mod = __module_text_address(pc);
> -			preempt_enable();
> -
> -			if (WARN_ON(!mod))
> -				return -EINVAL;
> -		}
> -
>  		/*
> -		 * The instruction we are about to patch may be a branch and
> -		 * link instruction that was redirected via a PLT entry. In
> -		 * this case, the normal validation will fail, but we can at
> -		 * least check that we are dealing with a branch and link
> -		 * instruction that points into the right module.
> +		 * The instruction we are about to patch may be a branch
> +		 * and link instruction that was redirected via a PLT entry
> +		 * supported by a dynamic trampoline or module, in this case,
> +		 * the normal validation will fail, but we can at least check
> +		 * that we are dealing with a branch and link instruction
> +		 * that points into the right place.
>  		 */
>  		if (aarch64_insn_read((void *)pc, &replaced))
>  			return -EFAULT;
>  
> -		if (!aarch64_insn_is_bl(replaced) ||
> -		    !within_module(pc + aarch64_get_branch_offset(replaced),
> -				   mod))
> +		if (!aarch64_insn_is_bl(replaced))
>  			return -EINVAL;
>  
>  		validate = false;
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index e53493d8b208..b7a832dfaa69 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -37,6 +37,56 @@ struct plt_entry get_plt_entry(u64 dst, void *pc)
>  	return plt;
>  }
>  
> +struct plt_entry update_plt_entry(u64 pc, u64 dst, int record)
> +{
> +	u32 adrp, add, br;
> +
> +	switch (record) {
> +	case PLT_MAKE_NOP:
> +		adrp = aarch64_insn_gen_nop();
> +		add = aarch64_insn_gen_nop();
> +		br = aarch64_insn_gen_nop();
> +		break;
> +
> +	case PLT_MAKE_CALL_LINK:
> +		adrp = aarch64_insn_gen_nop();
> +		add = aarch64_insn_gen_nop();
> +		br = aarch64_insn_gen_branch_imm(pc + 8, dst,
> +						 AARCH64_INSN_BRANCH_LINK);
> +		break;
> +
> +	case PLT_MAKE_LCALL_LINK:
> +		adrp = aarch64_insn_gen_adr(pc, dst, AARCH64_INSN_REG_16,
> +					    AARCH64_INSN_ADR_TYPE_ADRP);
> +		add = aarch64_insn_gen_add_sub_imm(AARCH64_INSN_REG_16,
> +						   AARCH64_INSN_REG_16, dst % SZ_4K,
> +						   AARCH64_INSN_VARIANT_64BIT,
> +						   AARCH64_INSN_ADSB_ADD);
> +		br = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_16,
> +						 AARCH64_INSN_BRANCH_LINK);
> +		break;
> +
> +	case PLT_MAKE_LCALL:
> +		adrp = aarch64_insn_gen_adr(pc, dst, AARCH64_INSN_REG_16,
> +					    AARCH64_INSN_ADR_TYPE_ADRP);
> +		add = aarch64_insn_gen_add_sub_imm(AARCH64_INSN_REG_16,
> +						   AARCH64_INSN_REG_16,
> +						   dst % SZ_4K,
> +						   AARCH64_INSN_VARIANT_64BIT,
> +						   AARCH64_INSN_ADSB_ADD);
> +		br = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_16,
> +						 AARCH64_INSN_BRANCH_NOLINK);
> +		break;
> +	default:
> +		pr_err("[%s %d] error flag %d\n", __func__, __LINE__, record);
> +		BUG();
> +		break;
> +	}
> +
> +	return (struct plt_entry){ cpu_to_le32(adrp), cpu_to_le32(add),
> +				cpu_to_le32(br) };
> +}
> +
>  bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b)
>  {
>  	u64 p, q;
> -- 
> 2.25.1
> 
