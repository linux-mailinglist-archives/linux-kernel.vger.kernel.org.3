Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CD64C0196
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiBVSrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiBVSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:47:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E58ACAA2D9;
        Tue, 22 Feb 2022 10:47:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C69106F;
        Tue, 22 Feb 2022 10:47:08 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FD213F66F;
        Tue, 22 Feb 2022 10:47:06 -0800 (PST)
Date:   Tue, 22 Feb 2022 18:47:03 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, samitolvanen@google.com,
        npiggin@gmail.com, linux@roeck-us.net, mhiramat@kernel.org,
        ojeda@kernel.org, luc.vanoostenryck@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
Message-ID: <YhUvp5RHkTlBXX3o@lakrids>
References: <20220222095736.24898-1-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222095736.24898-1-ashimida@linux.alibaba.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 22, 2022 at 01:57:36AM -0800, Dan Li wrote:
> Shadow call stack is available in GCC > 11.2.0, this patch makes
> the corresponding kernel configuration available when compiling
> the kernel with gcc.

Neat!

My local GCC devs told me that means GCC 12.x.x rather than 11.2.x or
11.3.x, so as others have said it'd be clearer to say `GCC >= 12.0.0`.

I'd like to try this with a GCC binary before I provide an Ack or R-b;
but in the mean time I have a few comments below.

> Note that the implementation in GCC is slightly different from Clang.
> With SCS enabled, functions will only pop x30 once in the epilogue,
> like:
> 
>    str     x30, [x18], #8
>    stp     x29, x30, [sp, #-16]!
>    ......
> -  ldp     x29, x30, [sp], #16	  //clang
> +  ldr     x29, [sp], #16	  //GCC
>    ldr     x30, [x18, #-8]!

Given the prologue still pushes both x29 and x30 (which we critically
depend upon) that sounds OK to me.

> 
> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ce09ab17ddd21f73ff2caf6eec3b0ee9b0e1a11e
> 
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> ---
> FYI:
> This function can be used to test if the shadow call stack works:
> //noinline void __noscs scs_test(void)
> noinline void scs_test(void)
> {
>     register unsigned long *sp asm("sp");
>     unsigned long * lr = sp + 1;
> 
>     asm volatile("":::"x30");
>     *lr = 0;
> }

It's probably be better to use __builtin_frame_address(0) to get the
address of the frame record rather than assuming that fp==sp in the
middle of the function.

> ffff800008012704:       d503233f        paciasp
> ffff800008012708:       f800865e        str     x30, [x18], #8
> ffff80000801270c:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
> ffff800008012710:       910003fd        mov     x29, sp
> ffff800008012714:       910003e0        mov     x0, sp
> ffff800008012718:       f900041f        str     xzr, [x0, #8]
> ffff80000801271c:       f85f8e5e        ldr     x30, [x18, #-8]!
> ffff800008012720:       f84107fd        ldr     x29, [sp], #16
> ffff800008012724:       d50323bf        autiasp
> ffff800008012728:       d65f03c0        ret
> 
> If SCS protection is enabled, this function will return normally.
> If the function has __noscs attribute (scs disabled), it will crash due to 0
> address access.
> 
>  arch/Kconfig                 | 6 +++---
>  arch/arm64/Kconfig           | 2 +-
>  include/linux/compiler-gcc.h | 4 ++++
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 678a80713b21..35db7b72bdb0 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -604,11 +604,11 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
>  	  switching.
>  
>  config SHADOW_CALL_STACK
> -	bool "Clang Shadow Call Stack"
> -	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
> +	bool "Shadow Call Stack"
> +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>  	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
>  	help
> -	  This option enables Clang's Shadow Call Stack, which uses a
> +	  This option enables Clang/GCC's Shadow Call Stack, which uses a
>  	  shadow stack to protect function return addresses from being
>  	  overwritten by an attacker. More information can be found in
>  	  Clang's documentation:

Is there any additional GCC documentation that we can refer to?

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 09b885cc4db5..a48a604301aa 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1255,7 +1255,7 @@ config HW_PERF_EVENTS
>  config ARCH_HAS_FILTER_PGPROT
>  	def_bool y
>  
> -# Supported by clang >= 7.0
> +# Supported by clang >= 7.0 or GCC > 11.2.0

As above, I beleive that should be `GCC >= 12.0.0`.

Thanks,
Mark

>  config CC_HAVE_SHADOW_CALL_STACK
>  	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
>  
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index ccbbd31b3aae..deff5b308470 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -97,6 +97,10 @@
>  #define KASAN_ABI_VERSION 4
>  #endif
>  
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> +#endif
> +
>  #if __has_attribute(__no_sanitize_address__)
>  #define __no_sanitize_address __attribute__((no_sanitize_address))
>  #else
> -- 
> 2.17.1
> 
