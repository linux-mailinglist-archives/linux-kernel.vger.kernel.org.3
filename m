Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6424E5E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348154AbiCXGWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbiCXGWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C6692A3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2063F60ECE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DBAC340F2;
        Thu, 24 Mar 2022 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648102872;
        bh=MdgQNGNSE+Sgr79DCsdGrpzudhUnWI3YfgIj/KYVg4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZDquGjTenN64kYEEGjGGRZISDVD0eV9F3yG3HIBdL+U/gSNgVyDZW12YOdkNcvYwV
         SwVM1AEf/r6zjSoYCysgysqueqd/orYArSnh1B/rAaO1g5FlRLwxK+6jRyShUUOpTf
         41Oq5pgcz5CX3JCggwg9qI7iYHfRlBLwU2WOJrCuT9M9w6rE24DdQyNkS9C2OETzOH
         7fpPWaZFuh4at1g6k41fTxgQ8NR5+/hVD4KhFfjHtPgl/gEmoPLrsVps3dy3zS50AN
         FsdJ+wBwR4DOHypUyjTDiUfw9gNMuWJIOqLm442hxDM64vxeOU1pOqfI9Zo8JiPqhU
         MbPiigD344wYw==
Date:   Thu, 24 Mar 2022 15:21:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ARM: kprobes: Make __kretprobe_trampoline as a pure asm
 function
Message-Id: <20220324152108.b6016621dd6b8297eddd6bb5@kernel.org>
In-Reply-To: <164733793626.1008610.12121025094280924953.stgit@devnote2>
References: <20220315182558.1a056d8b3975932f6589b60f@kernel.org>
        <164733793626.1008610.12121025094280924953.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a better solution for this issue from Ard :-)

https://lore.kernel.org/all/20220203082204.1176734-6-ardb@kernel.org/T/#u

I should use mov_l instead of ldr for loading the symbol address.

Thank you,

On Tue, 15 Mar 2022 18:52:16 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Make __kretprobe_trampoline() as a pure asm function same as the x86
> code does. Anyway, it is safe to define the symbol in the asm code
> instead of accessing a C symbol from the inline asm.
> 
> Without this fix, building arm kernel with GCC-11 may cause below
> error.
> 
>    /tmp/ccIWiggX.s: Assembler messages:
> >> /tmp/ccIWiggX.s:22: Error: invalid literal constant: pool needs to be closer
> 
> This fixes the error reported by 0day build bot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 7e9bf33b8124 ("ARM: kprobes: Make a frame pointer on __kretprobe_trampoline")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm/probes/kprobes/core.c |   57 +++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index 4848404ba51b..51f1438456ae 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -373,43 +373,46 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>   * should be enough for stacktrace from the return handler with or
>   * without pt_regs.
>   */
> -void __naked __kprobes __kretprobe_trampoline(void)
> -{
> -	__asm__ __volatile__ (
> +asm(
> +	".text\n"
> +	".global __kretprobe_trampoline\n"
> +	".type __kretprobe_trampoline, %function\n"
> +	"__kretprobe_trampoline:\n"
>  #ifdef CONFIG_FRAME_POINTER
> -		"ldr	lr, =__kretprobe_trampoline	\n\t"
> +	"ldr	lr, =__kretprobe_trampoline	\n\t"
>  	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
>  #ifdef CONFIG_CC_IS_CLANG
> -		"stmdb	sp, {sp, lr, pc}	\n\t"
> -		"sub	sp, sp, #12		\n\t"
> -		/* In clang case, pt_regs->ip = lr. */
> -		"stmdb	sp!, {r0 - r11, lr}	\n\t"
> -		/* fp points regs->r11 (fp) */
> -		"add	fp, sp,	#44		\n\t"
> +	"stmdb	sp, {sp, lr, pc}	\n\t"
> +	"sub	sp, sp, #12		\n\t"
> +	/* In clang case, pt_regs->ip = lr. */
> +	"stmdb	sp!, {r0 - r11, lr}	\n\t"
> +	/* fp points regs->r11 (fp) */
> +	"add	fp, sp,	#44		\n\t"
>  #else /* !CONFIG_CC_IS_CLANG */
> -		/* In gcc case, pt_regs->ip = fp. */
> -		"stmdb	sp, {fp, sp, lr, pc}	\n\t"
> -		"sub	sp, sp, #16		\n\t"
> -		"stmdb	sp!, {r0 - r11}		\n\t"
> -		/* fp points regs->r15 (pc) */
> -		"add	fp, sp, #60		\n\t"
> +	/* In gcc case, pt_regs->ip = fp. */
> +	"stmdb	sp, {fp, sp, lr, pc}	\n\t"
> +	"sub	sp, sp, #16		\n\t"
> +	"stmdb	sp!, {r0 - r11}		\n\t"
> +	/* fp points regs->r15 (pc) */
> +	"add	fp, sp, #60		\n\t"
>  #endif /* CONFIG_CC_IS_CLANG */
>  #else /* !CONFIG_FRAME_POINTER */
> -		"sub	sp, sp, #16		\n\t"
> -		"stmdb	sp!, {r0 - r11}		\n\t"
> +	"sub	sp, sp, #16		\n\t"
> +	"stmdb	sp!, {r0 - r11}		\n\t"
>  #endif /* CONFIG_FRAME_POINTER */
> -		"mov	r0, sp			\n\t"
> -		"bl	trampoline_handler	\n\t"
> -		"mov	lr, r0			\n\t"
> -		"ldmia	sp!, {r0 - r11}		\n\t"
> -		"add	sp, sp, #16		\n\t"
> +	"mov	r0, sp			\n\t"
> +	"bl	trampoline_handler	\n\t"
> +	"mov	lr, r0			\n\t"
> +	"ldmia	sp!, {r0 - r11}		\n\t"
> +	"add	sp, sp, #16		\n\t"
>  #ifdef CONFIG_THUMB2_KERNEL
> -		"bx	lr			\n\t"
> +	"bx	lr			\n\t"
>  #else
> -		"mov	pc, lr			\n\t"
> +	"mov	pc, lr			\n\t"
>  #endif
> -		: : : "memory");
> -}
> +	".size __kretprobe_trampoline, .-__kretprobe_trampoline\n"
> +);
> +NOKPROBE_SYMBOL(__kretprobe_trampoline);
>  
>  /* Called from __kretprobe_trampoline */
>  static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
