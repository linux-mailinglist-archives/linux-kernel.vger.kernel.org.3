Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3052147C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbiEJMCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbiEJMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:01:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B52B4C99
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:57:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so23455908wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/m0glBNNCVKw7fvlcpkMEkUOHFdiKfYATAc+fdZIDDw=;
        b=W1Per8Y5SaWb05RSOM7+C7BtAd6Ff8HmmxNM4go/sLroEn+TYzwORTZz3OKyZKFNtp
         +++m5roLasFOFiJv2yhdCt/ne8MIdu1/koir/R7h9JNHoEmdIFCUMKHfdvnhg1+j1QX/
         WswQAKRqw0BtYXcjSi3vdWymxOL74prVN75P5IO89W+veMoMUV01cCSwISEvVGPt6ILM
         5TVUMW2cQ9MgBNhZt+RrIAwBzGE8Jryjm3qo8fyD/qrDtj5Q6v1HxtH3O5Gbix0WpwPc
         OODsZ5tKijw1hNN8Qr2S1HnhVCxJufeFpcGlHL22MWlbPjRpu5aVGp2f/0wfVHJ+Up2o
         MYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/m0glBNNCVKw7fvlcpkMEkUOHFdiKfYATAc+fdZIDDw=;
        b=L9EDe8fewiuxb+xEzvhRktYHbraAYW8yXZ6MmrX4Gx/6C0GPxmt29+lZfxT3/CCXbm
         GT28MYH/FB9v7CLEHNhXtNS56FizKIJ+YRdpJonuK8BKTB6Xb3jVyJI5C+AjCjeofJXq
         15X9ijLwC6pY8opagSA4M/6YY3A4qM1aUXmI7keiMkq3cCBx4TLOjoUBvKRQXKd7wIjN
         v/ZX5fOwl5HSbZaQH4FqrW/XjAC4rIy7LPpuqv3As2DGNaNt1yCOYzDUuLErCMCe0y5l
         ClAy9vvX/g6RZ53vABkWXDk5ldhTOMgbf9lcnsOTI0jWFctNs2cDS9cTAzgu6c962udw
         kPvA==
X-Gm-Message-State: AOAM531029qWeJr0Wlue6eSlmQJ+0F5KGojANu7hRbwcCCgCRRx6zII4
        5WWthD+3PWXykCXEUudY+ktbfnm1fRxktw==
X-Google-Smtp-Source: ABdhPJw9YfZtIAzByRAd5mXcXcFiH52ISrML5AWY4bPIAlAivDb42Lb/gJTYTfoyVW9HhIiEnhsIcQ==
X-Received: by 2002:a5d:56c8:0:b0:20a:d4a1:94de with SMTP id m8-20020a5d56c8000000b0020ad4a194demr17994567wrw.268.1652183851987;
        Tue, 10 May 2022 04:57:31 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:640f:aa66:3ec8:cbb6])
        by smtp.gmail.com with ESMTPSA id x18-20020adfdd92000000b0020c5253d915sm13491130wrl.97.2022.05.10.04.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:57:31 -0700 (PDT)
Date:   Tue, 10 May 2022 13:57:25 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 3/3] kasan: clean-up kconfig options descriptions
Message-ID: <YnpTJR177vJ5G+HW@elver.google.com>
References: <5bd58ebebf066593ce0e1d265d60278b5f5a1874.1652123204.git.andreyknvl@google.com>
 <47afaecec29221347bee49f58c258ac1ced3b429.1652123204.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47afaecec29221347bee49f58c258ac1ced3b429.1652123204.git.andreyknvl@google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:07PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Various readability clean-ups of KASAN Kconfig options.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

But see further (not in this patch) suggestion for improvement below.

> ---
>  lib/Kconfig.kasan | 168 ++++++++++++++++++++++------------------------
>  1 file changed, 82 insertions(+), 86 deletions(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 1f3e620188a2..f0973da583e0 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
>  # This config refers to the generic KASAN mode.
>  config HAVE_ARCH_KASAN
>  	bool
> @@ -15,9 +16,8 @@ config HAVE_ARCH_KASAN_VMALLOC
>  config ARCH_DISABLE_KASAN_INLINE
>  	bool
>  	help
> -	  An architecture might not support inline instrumentation.
> -	  When this option is selected, inline and stack instrumentation are
> -	  disabled.
> +	  Disables both inline and stack instrumentation. Selected by
> +	  architectures that do not support these instrumentation types.
>  
>  config CC_HAS_KASAN_GENERIC
>  	def_bool $(cc-option, -fsanitize=kernel-address)
> @@ -26,13 +26,13 @@ config CC_HAS_KASAN_SW_TAGS
>  	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
>  
>  # This option is only required for software KASAN modes.
> -# Old GCC versions don't have proper support for no_sanitize_address.
> +# Old GCC versions do not have proper support for no_sanitize_address.
>  # See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89124 for details.
>  config CC_HAS_WORKING_NOSANITIZE_ADDRESS
>  	def_bool !CC_IS_GCC || GCC_VERSION >= 80300
>  
>  menuconfig KASAN
> -	bool "KASAN: runtime memory debugger"
> +	bool "KASAN: dynamic memory safety error detector"
>  	depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
>  		     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
>  		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
> @@ -40,10 +40,13 @@ menuconfig KASAN
>  	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
>  	select STACKDEPOT_ALWAYS_INIT
>  	help
> -	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
> -	  designed to find out-of-bounds accesses and use-after-free bugs.
> +	  Enables KASAN (Kernel Address Sanitizer) - a dynamic memory safety
> +	  error detector designed to find out-of-bounds and use-after-free bugs.
> +
>  	  See Documentation/dev-tools/kasan.rst for details.
>  
> +	  For better error reports, also enable CONFIG_STACKTRACE.
> +
>  if KASAN
>  
>  choice
> @@ -51,75 +54,71 @@ choice
>  	default KASAN_GENERIC
>  	help
>  	  KASAN has three modes:
> -	  1. generic KASAN (similar to userspace ASan,
> -	     x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
> -	  2. software tag-based KASAN (arm64 only, based on software
> -	     memory tagging (similar to userspace HWASan), enabled with
> -	     CONFIG_KASAN_SW_TAGS), and
> -	  3. hardware tag-based KASAN (arm64 only, based on hardware
> -	     memory tagging, enabled with CONFIG_KASAN_HW_TAGS).
>  
> -	  All KASAN modes are strictly debugging features.
> +	  1. Generic KASAN (supported by many architectures, enabled with
> +	     CONFIG_KASAN_GENERIC, similar to userspace ASan),
> +	  2. Software Tag-Based KASAN (arm64 only, based on software memory
> +	     tagging, enabled with CONFIG_KASAN_SW_TAGS, similar to userspace
> +	     HWASan), and
> +	  3. Hardware Tag-Based KASAN (arm64 only, based on hardware memory
> +	     tagging, enabled with CONFIG_KASAN_HW_TAGS).
>  
> -	  For better error reports enable CONFIG_STACKTRACE.
> +	  See Documentation/dev-tools/kasan.rst for details about each mode.
>  
>  config KASAN_GENERIC
> -	bool "Generic mode"
> +	bool "Generic KASAN"
>  	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
>  	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
>  	select SLUB_DEBUG if SLUB
>  	select CONSTRUCTORS
>  	help
> -	  Enables generic KASAN mode.
> +	  Enables Generic KASAN.
>  
> -	  This mode is supported in both GCC and Clang. With GCC it requires
> -	  version 8.3.0 or later. Any supported Clang version is compatible,
> -	  but detection of out-of-bounds accesses for global variables is
> -	  supported only since Clang 11.
> +	  Requires GCC 8.3.0+ or Clang.
>  
> -	  This mode consumes about 1/8th of available memory at kernel start
> -	  and introduces an overhead of ~x1.5 for the rest of the allocations.
> +	  Consumes about 1/8th of available memory at kernel start and adds an
> +	  overhead of ~50% for dynamic allocations.
>  	  The performance slowdown is ~x3.
>  
> -	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
> -	  (the resulting kernel does not boot).
> +	  (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)

Why aren't they made mutually exclusive via Kconfig constraints? Does it
work these days?

Either KASAN_GENERIC and KASAN_SW_TAGS do "depends on !DEBUG_SLAB ||
COMPILE_TEST", or DEBUG_SLAB does "depends on !(KASAN_GENERIC || KASAN_SW_TAGS) || COMPILE_TEST".

I feel DEBUG_SLAB might not be used very much these days, so perhaps
DEBUG_SLAB should add the constraint, also given KASAN is the better
debugging aid.

>  config KASAN_SW_TAGS
> -	bool "Software tag-based mode"
> +	bool "Software Tag-Based KASAN"
>  	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
>  	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
>  	select SLUB_DEBUG if SLUB
>  	select CONSTRUCTORS
>  	help
> -	  Enables software tag-based KASAN mode.
> +	  Enables Software Tag-Based KASAN.
>  
> -	  This mode require software memory tagging support in the form of
> -	  HWASan-like compiler instrumentation.
> +	  Requires GCC 11+ or Clang.
>  
> -	  Currently this mode is only implemented for arm64 CPUs and relies on
> -	  Top Byte Ignore. This mode requires Clang.
> +	  Supported only on arm64 CPUs and relies on Top Byte Ignore.
>  
> -	  This mode consumes about 1/16th of available memory at kernel start
> -	  and introduces an overhead of ~20% for the rest of the allocations.
> -	  This mode may potentially introduce problems relating to pointer
> -	  casting and comparison, as it embeds tags into the top byte of each
> -	  pointer.
> +	  Consumes about 1/16th of available memory at kernel start and
> +	  add an overhead of ~20% for dynamic allocations.
>  
> -	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
> -	  (the resulting kernel does not boot).
> +	  May potentially introduce problems related to pointer casting and
> +	  comparison, as it embeds a tag into the top byte of each pointer.
> +
> +	  (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)
>  
>  config KASAN_HW_TAGS
> -	bool "Hardware tag-based mode"
> +	bool "Hardware Tag-Based KASAN"
>  	depends on HAVE_ARCH_KASAN_HW_TAGS
>  	depends on SLUB
>  	help
> -	  Enables hardware tag-based KASAN mode.
> +	  Enables Hardware Tag-Based KASAN.
> +
> +	  Requires GCC 10+ or Clang 12+.
>  
> -	  This mode requires hardware memory tagging support, and can be used
> -	  by any architecture that provides it.
> +	  Supported only on arm64 CPUs starting from ARMv8.5 and relies on
> +	  Memory Tagging Extension and Top Byte Ignore.
>  
> -	  Currently this mode is only implemented for arm64 CPUs starting from
> -	  ARMv8.5 and relies on Memory Tagging Extension and Top Byte Ignore.
> +	  Consumes about 1/32nd of available memory.
> +
> +	  May potentially introduce problems related to pointer casting and
> +	  comparison, as it embeds a tag into the top byte of each pointer.
>  
>  endchoice
>  
> @@ -131,83 +130,80 @@ choice
>  config KASAN_OUTLINE
>  	bool "Outline instrumentation"
>  	help
> -	  Before every memory access compiler insert function call
> -	  __asan_load*/__asan_store*. These functions performs check
> -	  of shadow memory. This is slower than inline instrumentation,
> -	  however it doesn't bloat size of kernel's .text section so
> -	  much as inline does.
> +	  Makes the compiler insert function calls that check whether the memory
> +	  is accessible before each memory access. Slower than KASAN_INLINE, but
> +	  does not bloat the size of the kernel's .text section so much.
>  
>  config KASAN_INLINE
>  	bool "Inline instrumentation"
>  	depends on !ARCH_DISABLE_KASAN_INLINE
>  	help
> -	  Compiler directly inserts code checking shadow memory before
> -	  memory accesses. This is faster than outline (in some workloads
> -	  it gives about x2 boost over outline instrumentation), but
> -	  make kernel's .text size much bigger.
> +	  Makes the compiler directly insert memory accessibility checks before
> +	  each memory access. Faster than KASAN_OUTLINE (gives ~x2 boost for
> +	  some workloads), but makes the kernel's .text size much bigger.
>  
>  endchoice
>  
>  config KASAN_STACK
> -	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> +	bool "Stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
>  	depends on KASAN_GENERIC || KASAN_SW_TAGS
>  	depends on !ARCH_DISABLE_KASAN_INLINE
>  	default y if CC_IS_GCC
>  	help
> -	  The LLVM stack address sanitizer has a know problem that
> -	  causes excessive stack usage in a lot of functions, see
> -	  https://bugs.llvm.org/show_bug.cgi?id=38809
> -	  Disabling asan-stack makes it safe to run kernels build
> -	  with clang-8 with KASAN enabled, though it loses some of
> -	  the functionality.
> -	  This feature is always disabled when compile-testing with clang
> -	  to avoid cluttering the output in stack overflow warnings,
> -	  but clang users can still enable it for builds without
> -	  CONFIG_COMPILE_TEST.	On gcc it is assumed to always be safe
> -	  to use and enabled by default.
> -	  If the architecture disables inline instrumentation, stack
> -	  instrumentation is also disabled as it adds inline-style
> -	  instrumentation that is run unconditionally.
> +	  Disables stack instrumentation and thus KASAN's ability to detect
> +	  out-of-bounds bugs in stack variables.
> +
> +	  With Clang, stack instrumentation has a problem that causes excessive
> +	  stack usage, see https://bugs.llvm.org/show_bug.cgi?id=38809. Thus,
> +	  with Clang, this option is deemed unsafe.
> +
> +	  This option is always disabled when compile-testing with Clang to
> +	  avoid cluttering the log with stack overflow warnings.
> +
> +	  With GCC, enabling stack instrumentation is assumed to be safe.
> +
> +	  If the architecture disables inline instrumentation via
> +	  ARCH_DISABLE_KASAN_INLINE, stack instrumentation gets disabled
> +	  as well, as it adds inline-style instrumentation that is run
> +	  unconditionally.
>  
>  config KASAN_TAGS_IDENTIFY
> -	bool "Enable memory corruption identification"
> +	bool "Memory corruption type identification"
>  	depends on KASAN_SW_TAGS || KASAN_HW_TAGS
>  	help
> -	  This option enables best-effort identification of bug type
> -	  (use-after-free or out-of-bounds) at the cost of increased
> -	  memory consumption.
> +	  Enables best-effort identification of the bug types (use-after-free
> +	  or out-of-bounds) at the cost of increased memory consumption.
> +	  Only applicable for the tag-based KASAN modes.
>  
>  config KASAN_VMALLOC
>  	bool "Check accesses to vmalloc allocations"
>  	depends on HAVE_ARCH_KASAN_VMALLOC
>  	help
> -	  This mode makes KASAN check accesses to vmalloc allocations for
> -	  validity.
> +	  Makes KASAN check the validity of accesses to vmalloc allocations.
>  
> -	  With software KASAN modes, checking is done for all types of vmalloc
> -	  allocations. Enabling this option leads to higher memory usage.
> +	  With software KASAN modes, all types vmalloc allocations are
> +	  checked. Enabling this option leads to higher memory usage.
>  
> -	  With hardware tag-based KASAN, only VM_ALLOC mappings are checked.
> -	  There is no additional memory usage.
> +	  With Hardware Tag-Based KASAN, only non-executable VM_ALLOC mappings
> +	  are checked. There is no additional memory usage.
>  
>  config KASAN_KUNIT_TEST
>  	tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
>  	depends on KASAN && KUNIT
>  	default KUNIT_ALL_TESTS
>  	help
> -	  This is a KUnit test suite doing various nasty things like
> -	  out of bounds and use after free accesses. It is useful for testing
> -	  kernel debugging features like KASAN.
> +	  A KUnit-based KASAN test suite. Triggers different kinds of
> +	  out-of-bounds and use-after-free accesses. Useful for testing whether
> +	  KASAN can detect certain bug types.
>  
>  	  For more information on KUnit and unit tests in general, please refer
> -	  to the KUnit documentation in Documentation/dev-tools/kunit.
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
>  
>  config KASAN_MODULE_TEST
>  	tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
>  	depends on m && KASAN && !KASAN_HW_TAGS
>  	help
> -	  This is a part of the KASAN test suite that is incompatible with
> -	  KUnit. Currently includes tests that do bad copy_from/to_user
> -	  accesses.
> +	  A part of the KASAN test suite that is not integrated with KUnit.
> +	  Incompatible with Hardware Tag-Based KASAN.
>  
>  endif # KASAN
> -- 
> 2.25.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/47afaecec29221347bee49f58c258ac1ced3b429.1652123204.git.andreyknvl%40google.com.
