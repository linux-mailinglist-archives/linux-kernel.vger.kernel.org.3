Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A3851C42D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381416AbiEEPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381396AbiEEPso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:48:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B146532E2;
        Thu,  5 May 2022 08:45:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9535106F;
        Thu,  5 May 2022 08:45:02 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F0413F85F;
        Thu,  5 May 2022 08:45:00 -0700 (PDT)
Date:   Thu, 5 May 2022 16:44:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 09/21] arm64: Add CFI error handling
Message-ID: <YnPw+SiY9Ij/b7Yg@FVFF77S0Q05N.cambridge.arm.com>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429203644.2868448-10-samitolvanen@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On Fri, Apr 29, 2022 at 01:36:32PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, CFI always traps. Add arm64 support for handling
> CFI failures and determining the target address.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/include/asm/brk-imm.h |  2 ++
>  arch/arm64/include/asm/insn.h    |  1 +
>  arch/arm64/kernel/traps.c        | 57 ++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> index ec7720dbe2c8..3a50b70b4404 100644
> --- a/arch/arm64/include/asm/brk-imm.h
> +++ b/arch/arm64/include/asm/brk-imm.h
> @@ -16,6 +16,7 @@
>   * 0x400: for dynamic BRK instruction
>   * 0x401: for compile time BRK instruction
>   * 0x800: kernel-mode BUG() and WARN() traps
> + * 0x801: Control-Flow Integrity traps
>   * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)

As a high-level thing, it would be good if we could agree on some paritioning
of the BRK immediate space between compiler usage and kernel usage (or have
some way to ask the compiler to use specific values), so that we can allocate
values without clashing.

>   */
>  #define KPROBES_BRK_IMM			0x004
> @@ -25,6 +26,7 @@
>  #define KGDB_DYN_DBG_BRK_IMM		0x400
>  #define KGDB_COMPILED_DBG_BRK_IMM	0x401
>  #define BUG_BRK_IMM			0x800
> +#define CFI_BRK_IMM			0x801
>  #define KASAN_BRK_IMM			0x900
>  #define KASAN_BRK_MASK			0x0ff
>  
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index 1e5760d567ae..12225bdfa776 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -334,6 +334,7 @@ __AARCH64_INSN_FUNCS(store_pre,	0x3FE00C00, 0x38000C00)
>  __AARCH64_INSN_FUNCS(load_pre,	0x3FE00C00, 0x38400C00)
>  __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
>  __AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
> +__AARCH64_INSN_FUNCS(ldur,	0x3FE00C00, 0x38400000)
>  __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
>  __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
>  __AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 0529fd57567e..b524411ba663 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -26,6 +26,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/mm_types.h>
>  #include <linux/kasan.h>
> +#include <linux/cfi.h>
>  
>  #include <asm/atomic.h>
>  #include <asm/bug.h>
> @@ -990,6 +991,55 @@ static struct break_hook bug_break_hook = {
>  	.imm = BUG_BRK_IMM,
>  };
>  
> +#ifdef CONFIG_CFI_CLANG
> +void *arch_get_cfi_target(unsigned long addr, struct pt_regs *regs)
> +{
> +	/* The expected CFI check instruction sequence:
> +	 *   ldur    wA, [xN, #-4]
> +	 *   movk    wB, #nnnnn
> +	 *   movk    wB, #nnnnn, lsl #16
> +	 *   cmp     wA, wB
> +	 *   b.eq    .Ltmp1
> +	 *   brk     #0x801		; <- addr
> +	 *   .Ltmp1:
> +	 *
> +	 * Therefore, the target address is in the xN register, which we can
> +	 * decode from the ldur instruction.
> +	 */
> +	u32 insn, rn;
> +	void *p = (void *)(addr - 5 * AARCH64_INSN_SIZE);

It would be a bit nicer if we could encode the register index into the BRK
immediate, i.e. allocate a range of 32 immediates (or 31 given BLR XZR is
nonsensical), and have:

	BRK #CFI_BRK_IMM + n

... where `n` is the Xn index.

That way the kernel doesn't need to know the specific code sequence and
wouldn't have to decode the instruction to find the relevant register -- we
could determine that from the ESR alone. That would also avoid tying the
compiler into a specific code sequence, and would allow that to change.

Since the BRK immediate is 16 bits, we have enough space to also encode the
index of the wB register, which would allow the kernel's BRK handler to recover
and log the expected type value and the the value at the target of the branch
(that latter we can recover from xN, so we don't need wA to be encoded into the
immediate).

With that, the handler can be something like:

| #define CFI_BRK_IMM_TARGET	GENMASK(4,0)
| #define CFI_BRK_IMM_TYPE	GENMASK(9,5)
| 
| #define CFI_BRK_IMM_BASE	0x8000
| #define CFI_BRK_IMM_MASK	(CFI_BRK_IMM_TARGET | CFI_BRK_IMM_TYPE)
| 
| static int cfi_handler(struct pt_regs *regs, unsigned long esr)
| {
| 	int reg_target, reg_type;
| 	unsigned long target, type;
| 
| 	reg_target = FIELD_GET(esr, BRK_CFI_IMM_TARGET);
| 	target = pt_regs_read(regs, reg_target);
| 	
| 	reg_type = FIELD_GET(esr, BRK_CFI_IMM_TYPE);
| 	type = pt_regs_read(regs, reg_type);
| 
| 	report_cfi_failure(regs,		// regs
| 			   regs->pc,		// BRK address
| 			   target,		// branch target
| 			   type);		// expected type
| 
| 	// TODO: switch over the return value of report_cfi_failure()
| }
| 
| struct break_hook cfi_break_hook = {
| 	.fn = cfi_handler,
| 	.imm = CFI_BRK_IMM_BASE,
| 	.mask = CFI_BRK_IMM_MASK,
| };

... does the compiler side of that sound possible?

Thanks,
Mark.

>
> +
> +	if (aarch64_insn_read(p, &insn) || !aarch64_insn_is_ldur(insn))
> +		return NULL;
> +
> +	rn = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn);
> +	return (void *)regs->regs[rn];
> +}
> +
> +static int cfi_handler(struct pt_regs *regs, unsigned int esr)
> +{
> +	switch (report_cfi(regs->pc, regs)) {
> +	case BUG_TRAP_TYPE_BUG:
> +		die("Oops - CFI", regs, 0);
> +		break;
> +
> +	case BUG_TRAP_TYPE_WARN:
> +		break;
> +
> +	default:
> +		return DBG_HOOK_ERROR;
> +	}
> +
> +	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> +	return DBG_HOOK_HANDLED;
> +}
> +
> +static struct break_hook cfi_break_hook = {
> +	.fn = cfi_handler,
> +	.imm = CFI_BRK_IMM,
> +};
> +#endif /* CONFIG_CFI_CLANG */
> +
>  static int reserved_fault_handler(struct pt_regs *regs, unsigned int esr)
>  {
>  	pr_err("%s generated an invalid instruction at %pS!\n",
> @@ -1063,6 +1113,10 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
>  
>  	if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
>  		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
> +#endif
> +#ifdef CONFIG_CFI_CLANG
> +	if ((esr & ESR_ELx_BRK64_ISS_COMMENT_MASK) == CFI_BRK_IMM)
> +		return cfi_handler(regs, esr) != DBG_HOOK_HANDLED;
>  #endif
>  	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
>  }
> @@ -1070,6 +1124,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
>  void __init trap_init(void)
>  {
>  	register_kernel_break_hook(&bug_break_hook);
> +#ifdef CONFIG_CFI_CLANG
> +	register_kernel_break_hook(&cfi_break_hook);
> +#endif
>  	register_kernel_break_hook(&fault_break_hook);
>  #ifdef CONFIG_KASAN_SW_TAGS
>  	register_kernel_break_hook(&kasan_break_hook);
> -- 
> 2.36.0.464.gb9c8b46e94-goog
> 
