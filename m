Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEFD4E65F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351289AbiCXPbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbiCXPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:31:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 341C45AA75
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:30:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64301515;
        Thu, 24 Mar 2022 08:30:03 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD4A03F73B;
        Thu, 24 Mar 2022 08:30:02 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:29:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: clang memcpy calls
Message-ID: <YjyOdJlda3JcK3he@lakrids>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjxTt3pFIcV3lt8I@zn.tnic>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 12:19:19PM +0100, Borislav Petkov wrote:
> Hi folks,

Hi Boris,

> so I've been looking at a recent objtool noinstr warning from clang
> builds:
> 
> vmlinux.o: warning: objtool: sync_regs()+0x20: call to memcpy() leaves .noinstr.text section
> 
> The issue is that clang generates a memcpy() call when a struct copy
> happens:
> 
>         if (regs != eregs)
>                 *regs = *eregs;
> 
> see below for asm output.
> 
> While gcc does simply generate an actual "rep; movsq".

I think there's a more general soundness problem with noinstr here,
because with the options we pass today it's entirely legitimate for the
compiler to generate out-of-line calls to a number of support functions
(e.g. memcpy, but also memset and others), and we either need to inhibit
out-of-line calls to *any* of those, or ensure the out-of-line copies
used are never instrumented.

I'm not entirely sure how to prevent this on arm64 short of some
whole-compilation-unit shennanigans -- we don't have short sequence like
"rep movsq" that can be easily inlined, and we explicitly instrument
mem*() when certain KASAN options are selected.

I think we need more compiler help to make noinstr sound generally,
and/or may need to rethink the way we use noinstr.

Thanks,
Mark.

> So, how hard would it be to make clang do that too pls?
> 
> Oh, and another thing while we're comparing asm: I'd love for clang's
> -fverbose-asm to issue interleaved C source lines too, like gcc does.
> 
> That's it - no pink pony - just "normal" wishes. :-)
> 
> GCC:
> ====
> 
> sync_regs:
> .LASANPC4246:
> # arch/x86/kernel/traps.c:770: {
>         movq    %rdi, %rsi      # tmp91, eregs
> # arch/x86/kernel/traps.c:771:  struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
> #APP
> # 771 "arch/x86/kernel/traps.c" 1
>         movq %gs:cpu_current_top_of_stack(%rip), %rax   # cpu_current_top_of_stack, pfo_val__
> # 0 "" 2
> # arch/x86/kernel/traps.c:771:  struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
> #NO_APP
>         subq    $168, %rax      #, <retval>
> # arch/x86/kernel/traps.c:772:  if (regs != eregs)
>         cmpq    %rdi, %rax      # eregs, <retval>
>         je      .L387   #,
> # arch/x86/kernel/traps.c:773:          *regs = *eregs;
>         movl    $21, %ecx       #, tmp89
>         movq    %rax, %rdi      # <retval>, <retval>
>         rep movsq
> .L387:
> # arch/x86/kernel/traps.c:775: }
>         ret
> 
> CLANG:
> ======
> 
>         .section        .noinstr.text,"ax",@progbits
>         .globl  sync_regs                       # -- Begin function sync_regs
>         .p2align        6, 0x90
>         .type   sync_regs,@function
> sync_regs:                              # @sync_regs
> # %bb.0:                                # %entry
>         pushq   %rbx
>         #APP
>         movq    %gs:cpu_current_top_of_stack(%rip), %rbx
>         #NO_APP
>         addq    $-168, %rbx
>         cmpq    %rdi, %rbx
>         je      .LBB19_2
> # %bb.1:                                # %if.then
>         movq    %rdi, %rsi
>         movl    $168, %edx
>         movq    %rbx, %rdi
>         callq   memcpy@PLT
> .LBB19_2:                               # %if.end
>         movq    %rbx, %rax
>         popq    %rbx
>         retq
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
