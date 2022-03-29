Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111CC4EB4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiC2UnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiC2UnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:43:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CA90FD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67036B81A0C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC47C340ED;
        Tue, 29 Mar 2022 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648586483;
        bh=pJSCcVdgWhnd5AION/wZGoiwQTTX6POSia8kN26SYyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCG/ZhqpVTyzS69XwXlzyVBDW1zW8l5QnSO50eXDkFf9ZnW4x4naKkHwY2Inr2xgk
         FanJ+gYoJMuP6rELE/txiiiRJs802tj8IUkCJdierNHcCZYeJdo5K8wJnJBK2pNx29
         pyLFJb7OU3tRRQDkUAsFiCYeJOViUIBY16OQ+329ZWSQYNKSVNbnaImcCPApRQGocd
         ZrCF1QXjaPiyUUz9oUQaZPo/UrfOxVg8/ocfZLe+rxpnOtZxqadj02ImErQXXBQwcG
         LstGZAl2Nzzqc9JpXq13/QK7uvJ74fR8qNdQNm6ykTeBhLR3NwJnFqOT3uJPWmv2HE
         SFZHnxjzacbew==
Date:   Tue, 29 Mar 2022 13:41:15 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Bernardo Meurer Costa <beme@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/extable: prefer local labels in .set directives
Message-ID: <YkNu6zmjxzhbjmei@dev-arch.thelio-3990X>
References: <20220329202148.2379697-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329202148.2379697-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:21:45PM -0700, Nick Desaulniers wrote:
> Bernardo reported an error that Nathan bisected down to
> (x86_64) defconfig+LTO_CLANG_FULL+X86_PMEM_LEGACY.
> 
>     LTO     vmlinux.o
>   ld.lld: error: <instantiation>:1:13: redefinition of 'found'
>   .set found, 0
>               ^
> 
>   <inline asm>:29:1: while in macro instantiation
>   extable_type_reg reg=%eax, type=(17 | ((0) << 16))
>   ^
> 
> This appears to be another LTO specific issue similar to what was folded
> into commit 4b5305decc84 ("x86/extable: Extend extable functionality"),
> where the `.set found, 0` in DEFINE_EXTABLE_TYPE_REG in
> arch/x86/include/asm/asm.h conflicts with the symbol for the static
> function `found` in arch/x86/kernel/pmem.c.
> 
> Assembler .set directive declare symbols with global visibility, so the
> assembler may not rename such symbols in the event of a conflict. LTO
> could rename static functions if there was a conflict in C sources, but
> it cannot see into symbols defined in inline asm.
> 
> The symbols are also retained in the symbol table, regardless of LTO.
> 
> Give the symbols .L prefixes making them locally visible, so that they
> may be renamed for LTO to avoid conflicts, and to drop them from the
> symbol table regardless of LTO.
> 
> Fixes: 4b5305decc84 ("x86/extable: Extend extable functionality")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1612
> Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html#Local-Symbol-Names
> Reported-by: Bernardo Meurer Costa <beme@google.com>
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

This resolves the build error for me and it passes a smoke test boot in
QEMU.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

Should this have an explicit "Cc: stable@vger.kernel.org"? The build
error was reported against Linux 5.17.

> ---
>  arch/x86/include/asm/asm.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> index c878fed3056f..fbcfec4dc4cc 100644
> --- a/arch/x86/include/asm/asm.h
> +++ b/arch/x86/include/asm/asm.h
> @@ -154,24 +154,24 @@
>  
>  # define DEFINE_EXTABLE_TYPE_REG \
>  	".macro extable_type_reg type:req reg:req\n"						\
> -	".set found, 0\n"									\
> -	".set regnr, 0\n"									\
> +	".set .Lfound, 0\n"									\
> +	".set .Lregnr, 0\n"									\
>  	".irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"		\
>  	".ifc \\reg, %%\\rs\n"									\
> -	".set found, found+1\n"									\
> -	".long \\type + (regnr << 8)\n"								\
> +	".set .Lfound, .Lfound+1\n"								\
> +	".long \\type + (.Lregnr << 8)\n"							\
>  	".endif\n"										\
> -	".set regnr, regnr+1\n"									\
> +	".set .Lregnr, .Lregnr+1\n"								\
>  	".endr\n"										\
> -	".set regnr, 0\n"									\
> +	".set .Lregnr, 0\n"									\
>  	".irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"	\
>  	".ifc \\reg, %%\\rs\n"									\
> -	".set found, found+1\n"									\
> -	".long \\type + (regnr << 8)\n"								\
> +	".set .Lfound, .Lfound+1\n"								\
> +	".long \\type + (.Lregnr << 8)\n"							\
>  	".endif\n"										\
> -	".set regnr, regnr+1\n"									\
> +	".set .Lregnr, .Lregnr+1\n"								\
>  	".endr\n"										\
> -	".if (found != 1)\n"									\
> +	".if (.Lfound != 1)\n"									\
>  	".error \"extable_type_reg: bad register argument\"\n"					\
>  	".endif\n"										\
>  	".endm\n"
> -- 
> 2.35.1.1021.g381101b075-goog
> 
