Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82434A6F18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiBBKp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:45:59 -0500
Received: from foss.arm.com ([217.140.110.172]:50412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbiBBKp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:45:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 044591FB;
        Wed,  2 Feb 2022 02:45:58 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872633F40C;
        Wed,  2 Feb 2022 02:45:56 -0800 (PST)
Date:   Wed, 2 Feb 2022 10:45:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <Yfpg1rspyJVBLb2a@FVFF77S0Q05N>
References: <20220202001918.4104428-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202001918.4104428-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 04:19:18PM -0800, Kees Cook wrote:
> While the stackleak plugin was already using notrace, objtool is now a
> bit more picky. Update the notrace uses to noinstr. Silences these
> warnings:
> 
> vmlinux.o: warning: objtool: do_syscall_64()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_int80_syscall_32()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: exc_general_protection()+0x22: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: fixup_bad_iret()+0x20: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_machine_check()+0x27: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .text+0x5346e: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x143: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x10eb: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x17f9: call to stackleak_erase() leaves .noinstr.text section
> 
> Cc: Alexander Popov <alex.popov@linux.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Is it correct to exclude .noinstr.text here? That means any functions called in
> there will have their stack utilization untracked. This doesn't seem right to me,
> though. Shouldn't stackleak_track_stack() just be marked noinstr instead?

Given "noinstr" means "no instrumentation", it seems entirely correct to me
that noinstr functions should not be instrumented with stack utilization
checks. I am surprised that those *were* instrumented, and arguably this is a
fix that should be backported.

For stackleak_erase() itself, using noinstr certianly makes sense to me given
the context in which it is called.

FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/stackleak.c                     | 3 +--
>  scripts/gcc-plugins/stackleak_plugin.c | 3 +++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index 66b8af394e58..72d4ebf49480 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -70,7 +70,7 @@ late_initcall(stackleak_sysctls_init);
>  #define skip_erasing()	false
>  #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
>  
> -asmlinkage void notrace stackleak_erase(void)
> +asmlinkage void noinstr stackleak_erase(void)
>  {
>  	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
>  	unsigned long kstack_ptr = current->lowest_stack;
> @@ -124,7 +124,6 @@ asmlinkage void notrace stackleak_erase(void)
>  	/* Reset the 'lowest_stack' value for the next syscall */
>  	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
>  }
> -NOKPROBE_SYMBOL(stackleak_erase);
>  
>  void __used __no_caller_saved_registers notrace stackleak_track_stack(void)
>  {
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index e9db7dcb3e5f..e7e51f0eb597 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -429,6 +429,7 @@ static unsigned int stackleak_cleanup_execute(void)
>  	return 0;
>  }
>  
> +/* Do not instrument anything found in special sections. */
>  static bool stackleak_gate(void)
>  {
>  	tree section;
> @@ -446,6 +447,8 @@ static bool stackleak_gate(void)
>  			return false;
>  		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
>  			return false;
> +		if (!strncmp(TREE_STRING_POINTER(section), ".noinstr.text", 13))
> +			return false;
>  	}
>  
>  	return track_frame_size >= 0;
> -- 
> 2.30.2
> 
