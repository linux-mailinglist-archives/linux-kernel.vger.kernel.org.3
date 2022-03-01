Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9D4C8135
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiCACuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiCACt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:49:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4631848321
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23155CE19B8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46903C340EE;
        Tue,  1 Mar 2022 02:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646102951;
        bh=X7av7f/8qhZ/I76I7AbB9oiJbXYYsliSttaik/cvwxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LmMKcGhud82p90sEsxJJx4/VlJsinl01BmyChrQ6f5ezyfv8wqdw3eAKFa0QGXaUq
         MG73YiRvHjP0GCBGxTw71C5immS/BXevjb2tX5sKfqv/q35MnWVA+/DX7gZG5LFQtK
         M3WtwQGqzM1yHtoZp48woXDFs7Q8/Qcx+1j6lresmyfJyyKLByU+JEbwF5umfgP0PU
         LPhiv7ToYhOKI+Vc/aQsiOsXkjCsbQXP9OYDUDMOAi+MK8qpmaaTxY1PJiN35fvO+/
         JFryp2NjBuPAZkEUcrHXqHChKMXmOv4jwxrtXAmGOD9NntBD6sWGXTE6eZFW78FD5n
         XMFCMKqy3MUNw==
Date:   Tue, 1 Mar 2022 11:49:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-Id: <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
In-Reply-To: <20220228232513.GH11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220228150705.aab2d654b973109bab070ffe@kernel.org>
        <20220228232513.GH11184@worktop.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 00:25:13 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 28, 2022 at 03:07:05PM +0900, Masami Hiramatsu wrote:
> > Hi Peter,
> > 
> > So, instead of this change, can you try below?
> > This introduce the arch_adjust_kprobe_addr() and use it in the kprobe_addr()
> > so that it can handle the case that user passed the probe address in 
> > _text+OFFSET format.
> 
> It works a little... at the very least it still needs
> arch_kprobe_on_func_entry() allowing offset 4.
> 
> But looking at this, we've got:
> 
> kprobe_on_func_entry(addr, sym, offset)
>   _kprobe_addr(addr, sym, offset)
>     if (sym)
>       addr = kprobe_lookup_name()
>            = kallsyms_lookup_name()
>     arch_adjust_kprobe_addr(addr+offset)
>       skip_endbr()
>         kallsyms_loopup_size_offset(addr, ...)
>   kallsyms_lookup_size_offset(addr, NULL, &offset)
>   arch_kprobe_on_func_entry(offset)
> 
> Which is _3_ kallsyms lookups and 3 weak/arch hooks.

Yeah.

> 
> Surely we can make this a little more streamlined? The below seems to
> work.

OK, let me check.

> 
> I think with a little care and testing it should be possible to fold all
> the magic of PowerPC's kprobe_lookup_name() into this one hook as well,
> meaning we can get rid of kprobe_lookup_name() entirely.  Naveen?

Agreed. my previous patch just focused on x86, but powerpc
kprobe_lookup_name() must be updated too.

> 
> This then gets us down to a 1 kallsyms call and 1 arch hook. Hmm?
> 
> ---
>  arch/powerpc/kernel/kprobes.c  |   34 +++++++++++++++---------
>  arch/x86/kernel/kprobes/core.c |   17 ++++++++++++
>  include/linux/kprobes.h        |    3 +-
>  kernel/kprobes.c               |   56 ++++++++++++++++++++++++++++++++++-------
>  4 files changed, 87 insertions(+), 23 deletions(-)
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
> @@ -301,6 +302,22 @@ static int can_probe(unsigned long paddr
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
> @@ -1489,24 +1489,63 @@ bool within_kprobe_blacklist(unsigned lo
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

Hmm, there are 2 issues.

- the 'addr' includes the 'offset' here.
- the 'offset' is NOT limited under the symbol size.
  (e.g. symbol_name = "_text" and @offset points the offset of target symbol from _text)

This means we need to call kallsyms_lookup_size_offset() in this case too.

>  		if (!addr)
>  			return ERR_PTR(-ENOENT);
> +	} else {
> +		/*
> +		 * Input: @addr + @offset
> +		 * Output: @addr' + @offset'
> +		 */
> +		if (!kallsyms_lookup_size_offset((unsigned long)addr + offset,
> +						 NULL, &offset))
> +			return ERR_PTR(-ENOENT);
> +		addr = (kprobe_opcode_t *)((unsigned long)addr - offset);
>  	}
>  
> -	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
> +	addr = arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_entry);

Thus we can ensure the 'offset' here is the real offset from the target function entry.

Thank you,

>  	if (addr)
>  		return addr;
>  
> @@ -1516,7 +1555,8 @@ static kprobe_opcode_t *_kprobe_addr(kpr
>  
>  static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
>  {
> -	return _kprobe_addr(p->addr, p->symbol_name, p->offset);
> +	bool on_func_entry;
> +	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
>  }
>  
>  /*
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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
