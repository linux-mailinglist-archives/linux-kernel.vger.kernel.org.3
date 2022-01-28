Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8BC4A0085
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350695AbiA1Szk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350626AbiA1Szi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:55:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7C4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:55:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1B13617AC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 18:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4CDC340E7;
        Fri, 28 Jan 2022 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643396136;
        bh=xA8Ep0YfhZQNU2v7DBLtpJhxzd6pHkO59kXWUQ58m2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nn+lKmbj5RRcD2XU/XkSh9QSUHQoXcjMBlfUEREkDmgiIJEgfnJBWUqiOJUKqIXe5
         hjfViPftgOY2Xc870cS2omSHlbx6CA6EFUwlfUPtaD4VJAO0EReqVIiuMMoTBqICxD
         Ga5JUzClU3WaIf7FtEnIJGZoUfAAomxbaB5yNayEnbcBFwL7upJXZkKup1NqeS7wCK
         JKZcAxxWFnPIGoONo0MTwRj/D0PgC1Lu/uw6VjILd2ZlmvIlPbs1CnxUX3qiI4N3q0
         69v1Hz/nsu42s10bfpn0+6hWkjVAT1lT07UoSfIGMQIOnI6QMB96ApNton0pdjD+CN
         c2JdsZIjd2DCQ==
Date:   Fri, 28 Jan 2022 11:55:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] stack: Constrain stack offset randomization with
 Clang builds
Message-ID: <YfQ8IwCSzbtAhC3B@dev-arch.archlinux-ax161>
References: <20220128114446.740575-1-elver@google.com>
 <20220128114446.740575-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128114446.740575-2-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:44:46PM +0100, Marco Elver wrote:
> All supported versions of Clang perform auto-init of __builtin_alloca()
> when stack auto-init is on (CONFIG_INIT_STACK_ALL_{ZERO,PATTERN}).
> 
> add_random_kstack_offset() uses __builtin_alloca() to add a stack
> offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
> enabled, add_random_kstack_offset() will auto-init that unused portion
> of the stack used to add an offset.
> 
> There are several problems with this:
> 
> 	1. These offsets can be as large as 1023 bytes. Performing
> 	   memset() on them isn't exactly cheap, and this is done on
> 	   every syscall entry.
> 
> 	2. Architectures adding add_random_kstack_offset() to syscall
> 	   entry implemented in C require them to be 'noinstr' (e.g. see
> 	   x86 and s390). The potential problem here is that a call to
> 	   memset may occur, which is not noinstr.
> 
> A x86_64 defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:
> 
>  | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section
> 
> Clang 14 (unreleased) will introduce a way to skip alloca initialization
> via __builtin_alloca_uninitialized() (https://reviews.llvm.org/D115440).
> 
> Constrain RANDOMIZE_KSTACK_OFFSET to only be enabled if no stack
> auto-init is enabled, the compiler is GCC, or Clang is version 14+. Use
> __builtin_alloca_uninitialized() if the compiler provides it, as is done
> by Clang 14.
> 
> Link: https://lkml.kernel.org/r/YbHTKUjEejZCLyhX@elver.google.com
> Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One comment below.

> ---
>  arch/Kconfig                     |  1 +
>  include/linux/randomize_kstack.h | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 2cde48d9b77c..c5b50bfe31c1 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1163,6 +1163,7 @@ config RANDOMIZE_KSTACK_OFFSET
>  	bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
>  	default y
>  	depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> +	depends on INIT_STACK_NONE || !CC_IS_CLANG || CLANG_VERSION >= 140000
>  	help
>  	  The kernel stack offset can be randomized (after pt_regs) by
>  	  roughly 5 bits of entropy, frustrating memory corruption
> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> index 91f1b990a3c3..5c711d73ed10 100644
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -17,8 +17,18 @@ DECLARE_PER_CPU(u32, kstack_offset);
>   * alignment. Also, since this use is being explicitly masked to a max of
>   * 10 bits, stack-clash style attacks are unlikely. For more details see
>   * "VLAs" in Documentation/process/deprecated.rst
> + *
> + * The normal alloca() can be initialized with INIT_STACK_ALL. Initializing the
> + * unused area on each syscall entry is expensive, and generating an implicit
> + * call to memset() may also be problematic (such as in noinstr functions).
> + * Therefore, if the compiler provides it, use the "uninitialized" variant.
>   */
> -void *__builtin_alloca(size_t size);

Is it okay to remove the declaration? Why was it even added in the first
place (Kees)?

> +#if __has_builtin(__builtin_alloca_uninitialized)
> +#define __kstack_alloca __builtin_alloca_uninitialized
> +#else
> +#define __kstack_alloca __builtin_alloca
> +#endif
> +
>  /*
>   * Use, at most, 10 bits of entropy. We explicitly cap this to keep the
>   * "VLA" from being unbounded (see above). 10 bits leaves enough room for
> @@ -37,7 +47,7 @@ void *__builtin_alloca(size_t size);
>  	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
>  				&randomize_kstack_offset)) {		\
>  		u32 offset = raw_cpu_read(kstack_offset);		\
> -		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
> +		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));	\
>  		/* Keep allocation even after "ptr" loses scope. */	\
>  		asm volatile("" :: "r"(ptr) : "memory");		\
>  	}								\
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
> 
