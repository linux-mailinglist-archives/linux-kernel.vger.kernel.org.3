Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11952ED7A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349947AbiETNtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiETNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:49:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F2516A25A;
        Fri, 20 May 2022 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ba6DMHWyXzdLsqC4Y07ESqJjiG6gg4aITxzVthnQoC8=; b=cUJqXgYw330e56mSFSoMDsdrjj
        OspQ054YYQ+xxQD+1gausbKU4e7IZ9hMPLr0OxvpzlDiZY8pzexJ/dtirkR3HGbJwBxsr2ditCb5h
        QeJYJQcw+aNqHwNzWpGcHATSEVecgMMCwxi7xmM8v1WswIXxhMgqeeK3OyW8vHnaVTFnkYB5h0Ia3
        wUhucQPz4WuqIahwKquyttn5oUz/6yWDyHHAAIDmhe3vaZSDVLzpDBr4fOGHHd7LRRxKu4R2sWZzB
        8/9xGRyKuz9otdxKJox0jl/FJLJ9J4WoZ6lp2N6dyskWuPIVc3u82KiCTF1ApbPpU4HuZb8VcrcwS
        NSMM05lw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns306-00DmZI-Eg; Fri, 20 May 2022 13:49:06 +0000
Date:   Fri, 20 May 2022 14:49:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <YoecUo+D1XaphlA/@casper.infradead.org>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <YoI5TbDfw/88vf1f@hirez.programming.kicks-ass.net>
 <YoJKhHluN4n0kZDm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJKhHluN4n0kZDm@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:58:44PM +0200, Peter Zijlstra wrote:
> @willy, how horribly broken is this xarray usage?

The xarray doesn't work very well as a hash ;-(  It has pretty much
pessimal memory usage if you have a good hash.  You'll end up allocating
essentially the entire 4 billion * ptr_size address space of the hash.
Can you use an rhashtable instead?

> ---
>  arch/x86/include/asm/traps.h            |   1 +
>  arch/x86/kernel/alternative.c           | 316 ++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/common.c            |   5 +
>  arch/x86/kernel/vmlinux.lds.S           |   9 +
>  tools/objtool/check.c                   |  67 ++++++-
>  tools/objtool/include/objtool/objtool.h |   1 +
>  tools/objtool/objtool.c                 |   1 +
>  7 files changed, 399 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index 35317c5c551d..a423343cffbc 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -19,6 +19,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *e
>  #endif
>  
>  extern bool ibt_selftest(void);
> +extern bool ibt_broken;
>  
>  #ifdef CONFIG_X86_F00F_BUG
>  /* For handling the FOOF bug */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d374cb3cf024..abce4e78a1e0 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -18,6 +18,9 @@
>  #include <linux/mmu_context.h>
>  #include <linux/bsearch.h>
>  #include <linux/sync_core.h>
> +#include <linux/moduleloader.h>
> +#include <linux/xarray.h>
> +#include <linux/set_memory.h>
>  #include <asm/text-patching.h>
>  #include <asm/alternative.h>
>  #include <asm/sections.h>
> @@ -115,6 +118,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
>  }
>  
>  extern s32 __retpoline_sites[], __retpoline_sites_end[];
> +extern s32 __cfi_sites[], __cfi_sites_end[];
>  extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
>  extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
>  extern s32 __smp_locks[], __smp_locks_end[];
> @@ -549,6 +553,315 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
>  
>  #endif /* CONFIG_X86_KERNEL_IBT */
>  
> +#ifdef CONFIG_CFI_CLANG
> +/*
> + *  FineIBT                                         kCFI
> + *
> + *  __fineibt_\hash:
> + *    xor     \hash, %r10     # 7
> + *    jz      1f              # 2
> + *    ud2                     # 2
> + *  1:ret                     # 1
> + *    int3                    # 1
> + *
> + *
> + *  __cfi_\sym:                                     __cfi_\sym:
> + *                                                    int3; int3                              # 2
> + *    endbr                   # 4                     mov     \hash, %eax                     # 5
> + *    call    __fineibt_\hash # 5                     int3; int3                              # 2
> + *  \sym:                                           \sym:
> + *  ...                                             ...
> + *
> + *
> + *  caller:                                         caller:
> + *    movl    \hash, %r10d    # 6                     cmpl    \hash, -6(%r11)                 # 8
> + *    sub     $9, %r11        # 4                     je      1f                              # 2
> + *    nop2                    # 2                     ud2                                     # 2
> + *
> + *    call    *%r11           # 3                     call    __x86_indirect_thunk_r11        # 5
> + *    nop2                    # 2
> + */
> +
> +static DEFINE_XARRAY(cfi_hashes);
> +static int nr_cfi_hashes;
> +
> +static u32 decode_cfi_preamble(void *addr)
> +{
> +	u8 *p = addr;
> +
> +	if (p[0] == 0xcc && p[1] == 0xcc &&
> +	    p[2] == 0xb8 &&
> +	    p[7] == 0xcc && p[8] == 0xcc)
> +		return *(u32 *)(addr + 3);
> +
> +	return 0; /* invalid hash value */
> +}
> +
> +static u32 decode_cfi_caller(void *addr)
> +{
> +	u8 *p = addr;
> +
> +	if (((p[0] == 0x41 && p[1] == 0x81) ||
> +	     (p[0] == 0xeb && p[1] == 0x0a)) && p[2] == 0x7b &&
> +	    p[8] == 0x74 && p[9] == 0x02 &&
> +	    p[10] == 0x0f && p[11] == 0x0b)
> +		return *(u32 *)(addr + 4);
> +
> +	return 0; /* invalid hash value */
> +}
> +
> +// .cfi_sites
> +static int cfi_index_hashes(s32 *start, s32 *end)
> +{
> +	s32 *s;
> +
> +	for (s = start; s < end; s++) {
> +		void *addr = (void *)s + *s;
> +		void *xa;
> +		u32 hash;
> +
> +		hash = decode_cfi_preamble(addr);
> +		if (!hash) {
> +			//WARN();
> +			return -EINVAL;
> +		}
> +
> +		xa = xa_store(&cfi_hashes, hash, NULL, GFP_KERNEL);
> +		if (xa_is_err(xa)) {
> +			//WARN();
> +			return xa_err(xa);
> +		}
> +		nr_cfi_hashes++;
> +	}
> +
> +	return 0;
> +}
> +
> +asm (	".pushsection .rodata\n"
> +	"fineibt_template_start:\n"
> +	"	xorl	$0x12345678, %r10d\n"	// 7
> +	"	je	1f\n"			// 2
> +	"	ud2\n"				// 2
> +	"1:	ret\n"				// 1
> +	"	int3\n"
> +	"	int3\n"
> +	"	int3\n"
> +	"	int3\n"				// 4
> +	"fineibt_template_end:\n"
> +	".popsection\n"
> +    );
> +
> +extern u8 fineibt_template_start[];
> +extern u8 fineibt_template_end[];
> +
> +static int cfi_create_fineibt_stubs(void)
> +{
> +	size_t size = 16 * nr_cfi_hashes;
> +	int pages = 1 + ((size - 1) >> PAGE_SHIFT);
> +	void *text, *entry, *xa;
> +	unsigned long hash;
> +	int err = -ENOMEM;
> +
> +	text = module_alloc(size);
> +	if (!text)
> +		return err;
> +
> +	entry = text;
> +	xa_for_each(&cfi_hashes, hash, xa) {
> +
> +		memcpy(entry, fineibt_template_start, 16);
> +		*(u32 *)(entry + 3) = hash;
> +
> +		xa = xa_store(&cfi_hashes, hash, entry, GFP_KERNEL);
> +		if (xa_is_err(xa)) {
> +			err = xa_err(xa);
> +			goto err_alloc;
> +		}
> +		if (xa) {
> +			err = -EINVAL;
> +			goto err_alloc;
> +		}
> +
> +		entry += 16;
> +	}
> +
> +	set_memory_ro((unsigned long)text, pages);
> +	set_memory_x((unsigned long)text, pages);
> +
> +	return 0;
> +
> +err_alloc:
> +	module_memfree(text);
> +	return -EINVAL;
> +}
> +
> +// .retpoline_sites
> +static int cfi_disable_callers(s32 *start, s32 *end)
> +{
> +	/*
> +	 * Disable CFI by patching in a 2 byte JMP, this leaves the hash in
> +	 * tact for later usage. Also see decode_cfi_caller() and
> +	 * cfu_rewrite_callers().
> +	 */
> +	const u8 jmp12[] = { 0xeb, 0x0a };
> +	s32 *s;
> +
> +	for (s = start; s < end; s++) {
> +		void *addr = (void *)s + *s;
> +		u32 hash;
> +
> +		hash = decode_cfi_caller(addr - 12);
> +		if (!hash) {
> +			// WARN();
> +			return -EINVAL;
> +		}
> +
> +		text_poke_early(addr - 12, jmp12, 2);
> +	}
> +
> +	return 0;
> +}
> +
> +asm (	".pushsection .rodata\n"
> +	"fineibt_cfi_start:\n"
> +	"	endbr64\n"
> +	"	call fineibt_caller_start\n"
> +	"fineibt_cfi_end:"
> +	".popsection\n"
> +    );
> +
> +extern u8 fineibt_cfi_start[];
> +extern u8 fineibt_cfi_end[];
> +
> +// .cfi_sites
> +static int cfi_rewrite_cfi(s32 *start, s32 *end)
> +{
> +	s32 *s;
> +
> +	for (s = start; s < end; s++) {
> +		void *dest, *addr = (void *)s + *s;
> +		unsigned long index;
> +		u32 hash;
> +
> +		index = hash = decode_cfi_preamble(addr);
> +		dest = xa_find(&cfi_hashes, &index, hash, XA_PRESENT);
> +
> +		if (WARN_ON_ONCE(index != hash || !dest))
> +			return -EINVAL;
> +
> +		text_poke_early(addr, fineibt_cfi_start,
> +				(fineibt_cfi_end - fineibt_cfi_start));
> +
> +		__text_gen_insn(addr + 4,
> +				CALL_INSN_OPCODE, addr + 4,
> +				dest, CALL_INSN_SIZE);
> +	}
> +
> +	return 0;
> +}
> +
> +asm (	".pushsection .rodata\n"
> +	"fineibt_caller_start:\n"
> +	"	movl	$0x12345678, %r10d\n"
> +	"	sub	$9, %r11\n"
> +	"	.nops	2\n"
> +	"fineibt_caller_end:"
> +	".popsection\n"
> +    );
> +
> +extern u8 fineibt_caller_start[];
> +extern u8 fineibt_caller_end[];
> +
> +// .retpoline_sites
> +static int cfi_rewrite_callers(s32 *start, s32 *end)
> +{
> +	s32 *s;
> +
> +	for (s = start; s < end; s++) {
> +		void *addr = (void *)s + *s;
> +		u32 hash;
> +
> +		hash = decode_cfi_caller(addr - 12);
> +
> +		if (WARN_ON_ONCE(!hash))
> +			return -EINVAL;
> +
> +		text_poke_early(addr - 12, fineibt_caller_start,
> +				(fineibt_caller_end - fineibt_caller_end));
> +
> +		*(u32 *)(addr - 12 + 2) = hash;
> +
> +		/* rely on apply_retpolines() to rewrite the actual call */
> +	}
> +
> +	return 0;
> +}
> +
> +bool __ro_after_init ibt_broken = false;
> +
> +static void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
> +			  s32 *start_cfi, s32 *end_cfi)
> +{
> +	int ret;
> +
> +	/* If IBT, use FineIBT */
> +	if (!HAS_KERNEL_IBT || !cpu_feature_enabled(X86_FEATURE_IBT))
> +		return;
> +
> +	/*
> +	 * Find and count all unique hash values.
> +	 */
> +	ret = cfi_index_hashes(start_cfi, end_cfi);
> +	if (ret)
> +		goto err;
> +
> +	/*
> +	 * Allocate module memory and write FineIBT stubs.
> +	 */
> +	ret = cfi_create_fineibt_stubs();
> +	if (ret)
> +		goto err;
> +
> +	/*
> +	 * Rewrite the callers to not use the __cfi_ stubs, such that we might
> +	 * rewrite them. Disables all CFI. If this succeeds but any of the
> +	 * later stages fails, we're CFI-less.
> +	 */
> +	ret = cfi_disable_callers(start_retpoline, end_retpoline);
> +	if (ret)
> +		goto err;
> +
> +	/*
> +	 * Rewrite the __cfi_ stubs from kCFI to FineIBT.
> +	 */
> +	ret = cfi_rewrite_cfi(start_cfi, end_cfi);
> +	if (ret)
> +		goto err;
> +
> +	/*
> +	 * Now that everything is in place; rewrite the callers to FineIBT.
> +	 */
> +	ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
> +	if (ret)
> +		goto err;
> +
> +	return;
> +
> +err:
> +	pr_err("Something went horribly wrong trying to rewrite the CFI implementation.\n");
> +	/* must *NOT* enable IBT */
> +	ibt_broken = true;
> +}
> +
> +#else
> +
> +static void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
> +			  s32 *start_cfi, s32 *end_cfi)
> +{
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_SMP
>  static void alternatives_smp_lock(const s32 *start, const s32 *end,
>  				  u8 *text, u8 *text_end)
> @@ -855,6 +1168,9 @@ void __init alternative_instructions(void)
>  	 */
>  	apply_paravirt(__parainstructions, __parainstructions_end);
>  
> +	apply_fineibt(__retpoline_sites, __retpoline_sites_end,
> +		      __cfi_sites, __cfi_sites_end);
> +
>  	/*
>  	 * Rewrite the retpolines, must be done before alternatives since
>  	 * those can rewrite the retpoline thunks.
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index e342ae4db3c4..e4377256b952 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -630,6 +630,11 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
>  	    !cpu_feature_enabled(X86_FEATURE_IBT))
>  		return;
>  
> +#ifdef CONFIG_CFI_CLANG
> +	if (ibt_broken)
> +		return;
> +#endif
> +
>  	wrmsrl(MSR_IA32_S_CET, msr);
>  	cr4_set_bits(X86_CR4_CET);
>  
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 7fda7f27e762..72ffc91ddd20 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -294,6 +294,15 @@ SECTIONS
>  	}
>  #endif
>  
> +#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_RETPOLINE) && defined(CONFIG_X86_KERNEL_IBT)
> +	. = ALIGN(8);
> +	.cfi_sites : AT(ADDR(.cfi_sites) - LOAD_OFFSET) {
> +		__cfi_sites = .;
> +		*(.cfi_sites)
> +		__cfi_sites_end = .;
> +	}
> +#endif
> +
>  	/*
>  	 * struct alt_inst entries. From the header (alternative.h):
>  	 * "Alternative instructions for different CPU types or capabilities"
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 88f005ae6dcc..edc8aecf229c 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -797,6 +797,52 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
>  	return 0;
>  }
>  
> +static int create_cfi_sections(struct objtool_file *file)
> +{
> +	struct instruction *insn;
> +	struct section *sec;
> +	int idx;
> +
> +	sec = find_section_by_name(file->elf, ".cfi_sites");
> +	if (sec) {
> +		WARN("file already has .cfi_sites, skipping");
> +		return 0;
> +	}
> +
> +	idx = 0;
> +	list_for_each_entry(insn, &file->cfi_list, call_node)
> +		idx++;
> +
> +	if (!idx)
> +		return 0;
> +
> +	sec = elf_create_section(file->elf, ".cfi_sites", 0,
> +				 sizeof(int), idx);
> +	if (!sec) {
> +		WARN("elf_create_section: .cfi_sites");
> +		return -1;
> +	}
> +
> +	idx = 0;
> +	list_for_each_entry(insn, &file->cfi_list, call_node) {
> +
> +		int *site = (int *)sec->data->d_buf + idx;
> +		*site = 0;
> +
> +		if (elf_add_reloc_to_insn(file->elf, sec,
> +					  idx * sizeof(int),
> +					  R_X86_64_PC32,
> +					  insn->sec, insn->offset)) {
> +			WARN("elf_add_reloc_to_insn: .cfi_sites");
> +			return -1;
> +		}
> +
> +		idx++;
> +	}
> +
> +	return 0;
> +}
> +
>  static int create_mcount_loc_sections(struct objtool_file *file)
>  {
>  	struct section *sec;
> @@ -3301,6 +3347,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  {
>  	struct alternative *alt;
>  	struct instruction *next_insn, *prev_insn = NULL;
> +	struct instruction *first_insn = insn;
>  	struct section *sec;
>  	u8 visited;
>  	int ret;
> @@ -3312,8 +3359,19 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  
>  		if (func && insn->func && func != insn->func->pfunc) {
>  			/* Ignore KCFI type preambles, which always fall through */
> -			if (!strncmp(func->name, "__cfi_", 6))
> +			if (!strncmp(func->name, "__cfi_", 6)) {
> +				/*
> +				 * If the function has a __cfi_ preamble, the endbr
> +				 * will live in there.
> +				 */
> +				insn->noendbr = true;
> +				/*
> +				 * The preamble starts with INSN_TRAP,
> +				 * call_node cannot be used.
> +				 */
> +				list_add_tail(&first_insn->call_node, &file->cfi_list);
>  				return 0;
> +			}
>  
>  			WARN("%s() falls through to next function %s()",
>  			     func->name, insn->func->name);
> @@ -3953,6 +4011,13 @@ int check(struct objtool_file *file)
>  		warnings += ret;
>  	}
>  
> +	if (ibt && retpoline) {
> +		ret = create_cfi_sections(file);
> +		if (ret < 0)
> +			goto out;
> +		warnings += ret;
> +	}
> +
>  	if (stats) {
>  		printf("nr_insns_visited: %ld\n", nr_insns_visited);
>  		printf("nr_cfi: %ld\n", nr_cfi);
> diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
> index a6e72d916807..93f52e275fa6 100644
> --- a/tools/objtool/include/objtool/objtool.h
> +++ b/tools/objtool/include/objtool/objtool.h
> @@ -27,6 +27,7 @@ struct objtool_file {
>  	struct list_head static_call_list;
>  	struct list_head mcount_loc_list;
>  	struct list_head endbr_list;
> +	struct list_head cfi_list;
>  	bool ignore_unreachables, hints, rodata;
>  
>  	unsigned int nr_endbr;
> diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
> index 843ff3c2f28e..16ed3613b0e2 100644
> --- a/tools/objtool/objtool.c
> +++ b/tools/objtool/objtool.c
> @@ -129,6 +129,7 @@ struct objtool_file *objtool_open_read(const char *_objname)
>  	INIT_LIST_HEAD(&file.static_call_list);
>  	INIT_LIST_HEAD(&file.mcount_loc_list);
>  	INIT_LIST_HEAD(&file.endbr_list);
> +	INIT_LIST_HEAD(&file.cfi_list);
>  	file.ignore_unreachables = no_unreachable;
>  	file.hints = false;
>  
