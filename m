Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143434CF9C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiCGKKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiCGJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:51:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF26975619
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:44:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3364260F62
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5B9C340E9;
        Mon,  7 Mar 2022 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646646279;
        bh=4Ce73zt7zXRoK9sW1AFtNqsQJwip8P7mDWs2GukeN7s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sjj5xXr2QM1NbShQxKCx298UuTbjDwKzReLHYtgU11HP1KWDJa+Tt6fHatJm/UV6g
         FFIVuIWkcb3bAxHxqTg6Fq8O+Pr9i9f6qlzR5yfq9v7yHjeKjlCVFj4v8YxyK4TJS0
         QaRdiaA4w0hP68RsHGQzzNrgdj89lO51o1fZkuQWV6M0UDvH72K+EitH51QHrndpkx
         +nge2eXjIJ45LNWAub8rNOmsUl5TKfv7QG4mHvgZ/hH+L7hW9KEEthnxfRVnTZ52DT
         8GfG8DbKs5n+nnSgeZjOBCBCIu0sqWMhzCwbyrCdQcslEvRczioHscf2KGnVdDLZik
         s2OtOHMn+qQBw==
Date:   Mon, 7 Mar 2022 18:44:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 19/39] x86/ibt,kprobes: Cure sym+0 equals fentry woes
Message-Id: <20220307184434.4b7e5d83c9d16a983adedce5@kernel.org>
In-Reply-To: <20220303112826.104222438@infradead.org>
References: <20220303112321.422525803@infradead.org>
        <20220303112826.104222438@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2022 12:23:40 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Rework _kprobe_addr() to only ever do 2 kallsyms calls and require
> only a single architecture/weak function -- although currently powerpc
> still uses 2.

OK, and we need to note here that if the kernel enables this
X86_KERNEL_IBT, the kprobe address is possible to be sym+4 because
kprobes will skip the ENDBR.

Others looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/powerpc/kernel/kprobes.c  |   34 +++++++++++++--------
>  arch/x86/kernel/kprobes/core.c |   28 ++++++++++++++---
>  include/linux/kprobes.h        |    3 +
>  kernel/kprobes.c               |   66 ++++++++++++++++++++++++++++++++---------
>  4 files changed, 98 insertions(+), 33 deletions(-)
> 
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -105,6 +105,27 @@ kprobe_opcode_t *kprobe_lookup_name(cons
>  	return addr;
>  }
>  
> +static bool arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +#ifdef PPC64_ELF_ABI_v2
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	return offset <= 16;
> +#else
> +	return offset <= 8;
> +#endif
> +#else
> +	return !offset;
> +#endif
> +}
> +
> +/* XXX try and fold the magic of kprobe_lookup_name() in this */
> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
> +					 bool *on_func_entry)
> +{
> +	*on_func_entry = arch_kprobe_on_func_entry(offset);
> +	return (kprobe_opcode_t *)(addr + offset);

Just for make sure, 

> +}
> +
>  void *alloc_insn_page(void)
>  {
>  	void *page;
> @@ -218,19 +239,6 @@ static nokprobe_inline void set_current_
>  	kcb->kprobe_saved_msr = regs->msr;
>  }
>  
> -bool arch_kprobe_on_func_entry(unsigned long offset)
> -{
> -#ifdef PPC64_ELF_ABI_v2
> -#ifdef CONFIG_KPROBES_ON_FTRACE
> -	return offset <= 16;
> -#else
> -	return offset <= 8;
> -#endif
> -#else
> -	return !offset;
> -#endif
> -}
> -
>  void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
>  {
>  	ri->ret_addr = (kprobe_opcode_t *)regs->link;
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -52,6 +52,7 @@
>  #include <asm/insn.h>
>  #include <asm/debugreg.h>
>  #include <asm/set_memory.h>
> +#include <asm/ibt.h>
>  
>  #include "common.h"
>  
> @@ -197,13 +198,14 @@ __recover_probed_insn(kprobe_opcode_t *b
>  
>  	kp = get_kprobe((void *)addr);
>  	faddr = ftrace_location(addr);
> +
>  	/*
> -	 * Addresses inside the ftrace location are refused by
> -	 * arch_check_ftrace_location(). Something went terribly wrong
> -	 * if such an address is checked here.
> +	 * In case addr maps to sym+0 ftrace_location() might return something
> +	 * other than addr. In that case consider it the same as !faddr.
>  	 */
> -	if (WARN_ON(faddr && faddr != addr))
> -		return 0UL;
> +	if (faddr && faddr != addr)
> +		faddr = 0;
> +
>  	/*
>  	 * Use the current code if it is not modified by Kprobe
>  	 * and it cannot be modified by ftrace.
> @@ -301,6 +303,22 @@ static int can_probe(unsigned long paddr
>  	return (addr == paddr);
>  }
>  
> +/* If the x86 support IBT (ENDBR) it must be skipped. */
> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
> +					 bool *on_func_entry)
> +{
> +	if (is_endbr(*(u32 *)addr)) {
> +		*on_func_entry = !offset || offset == 4;
> +		if (*on_func_entry)
> +			offset = 4;
> +
> +	} else {
> +		*on_func_entry = !offset;
> +	}
> +
> +	return (kprobe_opcode_t *)(addr + offset);
> +}
> +
>  /*
>   * Copy an instruction with recovering modified instruction by kprobes
>   * and adjust the displacement if the instruction uses the %rip-relative
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -265,7 +265,6 @@ extern int arch_init_kprobes(void);
>  extern void kprobes_inc_nmissed_count(struct kprobe *p);
>  extern bool arch_within_kprobe_blacklist(unsigned long addr);
>  extern int arch_populate_kprobe_blacklist(void);
> -extern bool arch_kprobe_on_func_entry(unsigned long offset);
>  extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
>  
>  extern bool within_kprobe_blacklist(unsigned long addr);
> @@ -384,6 +383,8 @@ static inline struct kprobe_ctlblk *get_
>  }
>  
>  kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
> +
>  int register_kprobe(struct kprobe *p);
>  void unregister_kprobe(struct kprobe *p);
>  int register_kprobes(struct kprobe **kps, int num);
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1489,24 +1489,68 @@ bool within_kprobe_blacklist(unsigned lo
>  }
>  
>  /*
> + * arch_adjust_kprobe_addr - adjust the address
> + * @addr: symbol base address
> + * @offset: offset within the symbol
> + * @on_func_entry: was this @addr+@offset on the function entry
> + *
> + * Typically returns @addr + @offset, except for special cases where the
> + * function might be prefixed by a CFI landing pad, in that case any offset
> + * inside the landing pad is mapped to the first 'real' instruction of the
> + * symbol.
> + *
> + * Specifically, for things like IBT/BTI, skip the resp. ENDBR/BTI.C
> + * instruction at +0.
> + */
> +kprobe_opcode_t *__weak arch_adjust_kprobe_addr(unsigned long addr,
> +						unsigned long offset,
> +						bool *on_func_entry)
> +{
> +	*on_func_entry = !offset;
> +	return (kprobe_opcode_t *)(addr + offset);
> +}
> +
> +/*
>   * If 'symbol_name' is specified, look it up and add the 'offset'
>   * to it. This way, we can specify a relative address to a symbol.
>   * This returns encoded errors if it fails to look up symbol or invalid
>   * combination of parameters.
>   */
> -static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
> -			const char *symbol_name, unsigned int offset)
> +static kprobe_opcode_t *
> +_kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
> +	     unsigned long offset, bool *on_func_entry)
>  {
>  	if ((symbol_name && addr) || (!symbol_name && !addr))
>  		goto invalid;
>  
>  	if (symbol_name) {
> +		/*
> +		 * Input: @sym + @offset
> +		 * Output: @addr + @offset
> +		 *
> +		 * NOTE: kprobe_lookup_name() does *NOT* fold the offset
> +		 *       argument into it's output!
> +		 */
>  		addr = kprobe_lookup_name(symbol_name, offset);
>  		if (!addr)
>  			return ERR_PTR(-ENOENT);
>  	}
>  
> -	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
> +	/*
> +	 * So here we have @addr + @offset, displace it into a new
> +	 * @addr' + @offset' where @addr' is the symbol start address.
> +	 */
> +	addr = (void *)addr + offset;
> +	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
> +		return ERR_PTR(-ENOENT);
> +	addr = (void *)addr - offset;
> +
> +	/*
> +	 * Then ask the architecture to re-combine them, taking care of
> +	 * magical function entry details while telling us if this was indeed
> +	 * at the start of the function.
> +	 */
> +	addr = arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_entry);
>  	if (addr)
>  		return addr;
>  
> @@ -1516,7 +1560,8 @@ static kprobe_opcode_t *_kprobe_addr(kpr
>  
>  static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
>  {
> -	return _kprobe_addr(p->addr, p->symbol_name, p->offset);
> +	bool on_func_entry;
> +	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
>  }
>  
>  /*
> @@ -2047,11 +2092,6 @@ static int pre_handler_kretprobe(struct
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
> -bool __weak arch_kprobe_on_func_entry(unsigned long offset)
> -{
> -	return !offset;
> -}
> -
>  /**
>   * kprobe_on_func_entry() -- check whether given address is function entry
>   * @addr: Target address
> @@ -2067,15 +2107,13 @@ bool __weak arch_kprobe_on_func_entry(un
>   */
>  int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
>  {
> -	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
> +	bool on_func_entry;
> +	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset, &on_func_entry);
>  
>  	if (IS_ERR(kp_addr))
>  		return PTR_ERR(kp_addr);
>  
> -	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset))
> -		return -ENOENT;
> -
> -	if (!arch_kprobe_on_func_entry(offset))
> +	if (!on_func_entry)
>  		return -EINVAL;
>  
>  	return 0;
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
