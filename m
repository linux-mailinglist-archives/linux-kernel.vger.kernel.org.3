Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1B515BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382505AbiD3J2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiD3J2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 05:28:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772B362BD5;
        Sat, 30 Apr 2022 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=f7uipT1rxINXEEkDub0QoWVvJ2yKFuDILl1sxKUMthA=; b=o65ng6t9hVrv4G5R8uT1BmQbza
        OEVdEctaniRc7CYwLHJJ21J8qSz0f78GOX2bJVsS9yQ9VKEzog6lRi7xp6Nyf6Og7tqlhjggbVRDt
        G8RWrWE2uvgLaLhC067Mv/LG+meqiyIc/k3KQ7683CjYZHl9c6IrTX12bvr+QR0OrHNdhfIestin+
        6vCpJgNWys0ccAmJ671ed2wQHBWfhsJNNOLg+0jJN0Tfc7qErwEDgtNqU771QJA4nN/EF7HvZQOWW
        6a3KLq6dCyTjM9Bew2t9jAW0QoOzJ48qol38CwKAUBI2bybOAPiSQ2wUM2gjX47s2QIDlylseCO1y
        O1i1kHXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkjL2-009sWc-MC; Sat, 30 Apr 2022 09:24:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFE21300473;
        Sat, 30 Apr 2022 11:24:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B393F2028EFE6; Sat, 30 Apr 2022 11:24:27 +0200 (CEST)
Date:   Sat, 30 Apr 2022 11:24:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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
Subject: Re: [RFC PATCH 21/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <Ym0ASy87mE3r3EVE@hirez.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-22-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429203644.2868448-22-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:36:44PM -0700, Sami Tolvanen wrote:
> Add CONFIG_CFI_CLANG error handling and allow the config to be selected
> on x86_64.

Might be useful to have an example output of all ths somewhere, because
unless I go build my own clang again, I can't tell from these patches
what actual codegen looks like.

Going from the below, I seem to be able to reverse engineer some of it:

  .long \signature
  int3
  int3
my_func:
  ENDBR
  ...
  ret

And then the callsites look like (clang *always* uses r11, right?):


  cmpl	\signature, -6(%r11)
  je	1f
  ud2
1:
  call __x86_indirect_thunk_r11



> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/Kconfig               |  1 +
>  arch/x86/include/asm/linkage.h |  7 ++++++
>  arch/x86/kernel/traps.c        | 39 +++++++++++++++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b0142e01002e..01db5c5c4dde 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -108,6 +108,7 @@ config X86
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
>  	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
>  	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
> +	select ARCH_SUPPORTS_CFI_CLANG		if X86_64
>  	select ARCH_SUPPORTS_LTO_CLANG
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
>  	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
> index 85865f1645bd..d20acf5ebae3 100644
> --- a/arch/x86/include/asm/linkage.h
> +++ b/arch/x86/include/asm/linkage.h
> @@ -25,6 +25,13 @@
>  #define RET	ret
>  #endif
>  
> +#ifdef CONFIG_CFI_CLANG
> +#define __CFI_TYPE(name)			\
> +	.fill 10, 1, 0x90 ASM_NL		\
> +	.4byte __kcfi_typeid_##name ASM_NL	\
> +	.fill 2, 1, 0xcc
> +#endif
> +
>  #else /* __ASSEMBLY__ */
>  
>  #ifdef CONFIG_SLS
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 1563fb995005..b9e46e6ed83b 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -40,6 +40,7 @@
>  #include <linux/hardirq.h>
>  #include <linux/atomic.h>
>  #include <linux/ioasid.h>
> +#include <linux/cfi.h>
>  
>  #include <asm/stacktrace.h>
>  #include <asm/processor.h>
> @@ -295,6 +296,41 @@ static inline void handle_invalid_op(struct pt_regs *regs)
>  		      ILL_ILLOPN, error_get_trap_addr(regs));
>  }
>  
> +#ifdef CONFIG_CFI_CLANG
> +void *arch_get_cfi_target(unsigned long addr, struct pt_regs *regs)
> +{
> +	char buffer[MAX_INSN_SIZE];
> +	int offset;
> +	struct insn insn;
> +	unsigned long *target;

Reverse xmas please..

> +
> +	/*
> +	 * The expected CFI check instruction sequence:
> +	 *   cmpl    <id>, -6(%reg)	; 7 bytes
> +	 *   je      .Ltmp1		; 2 bytes
> +	 *   ud2			; <- addr
> +	 *   .Ltmp1:
> +	 *
> +	 * Therefore, the target address is in a register that we can
> +	 * decode from the cmpl instruction.
> +	 */
> +	if (copy_from_kernel_nofault(buffer, (void *)addr - 9, MAX_INSN_SIZE))
> +		return NULL;
> +	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
> +		return NULL;

insn_decode_kernel()

> +	if (insn.opcode.value != 0x81)
> +		return NULL;

That's not sufficient to uniquely identify cmp, you also need to look at
the modrm to find r==7 I think.

> +
> +	offset = insn_get_modrm_rm_off(&insn, regs);
> +	if (offset < 0)
> +		return NULL;
> +
> +	target = (void *)regs + offset;
> +
> +	return (void *)*target;
> +}
> +#endif
> +
>  static noinstr bool handle_bug(struct pt_regs *regs)
>  {
>  	bool handled = false;
> @@ -312,7 +348,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
>  	 */
>  	if (regs->flags & X86_EFLAGS_IF)
>  		raw_local_irq_enable();
> -	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
> +	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> +	    report_cfi(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {

This way you'll first get a BUG splat and then tack on the CFI thing.
Seems a bit daft to have two splats.

>  		regs->ip += LEN_UD2;
>  		handled = true;
>  	}
> -- 
> 2.36.0.464.gb9c8b46e94-goog
> 
