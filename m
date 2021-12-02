Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2FF4668B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359797AbhLBRAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348240AbhLBRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:00:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD91C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 08:56:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63B27B82243
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 16:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23908C00446;
        Thu,  2 Dec 2021 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638464197;
        bh=0s6SgjQZoecKjBR8OmQ3AwSZx3KbVZTzrj2xll+zbio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXPK/G0J0vu1sQwKTPe1d682xXsOYhyf4PEluU7P0mLs8ho67US1FiqdH0CIivcnx
         Q74BlmiubN8I3Kin6LZxtEA70GT0P6FQP9UOZavdIAHRDPDOLptObIRP5bF7ymQmnh
         UYlzGvAPwKZmLGWv9kVVdslFhcy4ycSg15iLdn/szFeoMjJOkzHz8ulx41Zjm6CkR+
         FdhCWkhpskPbASPNeb7DIDwTH/W2SOeg4s85Q+dAAUlcgy65Hl5n1TIrjDlBmE8gP9
         Mmb7enkUUTdbbZ1Ko1x2JVWK4LZ7rkRPUcDHFDmfMvQAqf6QppXUjY7g7e2/sP0b08
         9ZgKvA+EivHIA==
Date:   Thu, 2 Dec 2021 09:56:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, llvm@lists.linux.dev
Subject: Re: [PATCH v3] arm64: Enable KCSAN
Message-ID: <Yaj6vxHk0wFQb8E3@archlinux-ax161>
References: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:33:31PM +0800, Kefeng Wang wrote:
> This patch enables KCSAN for arm64, with updates to build rules
> to not use KCSAN for several incompatible compilation units.
> 
> Resent GCC version(at least GCC10) made outline-atomics as the
> default option(unlike Clang), which will cause linker errors
> for kernel/kcsan/core.o. Disables the out-of-line atomics by
> no-outline-atomics to fix the linker errors.
> 
> Meanwhile, as Mark said[1], there is a specific issue on arm64
> about ARM64_BTI with Clang 11 if KCSAN enabled, which is fixed
> by Clang 12, add CLANG_VERSION check. And also some latent issues

I do not think this addition is necessary because we make BTI depend on
clang 12 or newer after commit 8cdd23c23c3d ("arm64: Restrict
ARM64_BTI_KERNEL to clang 12.0.0 and newer") upstream. I figured it was
better to go after the root cause rather than add a bunch of version
checks like this to the various sanitizers.

> are need to be fixed which isn't just a KCSAN problem, we make
> the KCSAN depends on EXPERT for now.
> 
> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> and all passed.
> 
> [1] https://lkml.org/lkml/2021/12/1/354
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> Tested on Qemu with clang 13 / gcc 11, based on 5.16-rc3.
> 
> [    0.221518] kcsan: enabled early
> [    0.222422] kcsan: strict mode configured
> ...
> [    5.839223] kcsan: selftest: 3/3 tests passed
> ...
> [  517.895102] # kcsan: pass:24 fail:0 skip:0 total:24
> [  517.896393] # Totals: pass:168 fail:0 skip:0 total:168
> [  517.897502] ok 1 - kcsan
> 
> v3:
> - add EXPERT and CLANG_VERSION depends suggested by Mark Rutland
> v2:
> - tested on GCC11 and disable outline-atomics for kernel/kcsan/core.c
>   suggested by Marco Elver
> 
>  arch/arm64/Kconfig               | 1 +
>  arch/arm64/kernel/vdso/Makefile  | 1 +
>  arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
>  kernel/kcsan/Makefile            | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4ff73299f8a9..3a7b17742cde 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -150,6 +150,7 @@ config ARM64
>  	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
> +	select HAVE_ARCH_KCSAN if EXPERT && (CC_IS_GCC || CLANG_VERSION >= 120000)
>  	select HAVE_ARCH_KFENCE
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_MMAP_RND_BITS
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 700767dfd221..60813497a381 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -32,6 +32,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
>  				$(CC_FLAGS_LTO)
>  KASAN_SANITIZE			:= n
> +KCSAN_SANITIZE			:= n
>  UBSAN_SANITIZE			:= n
>  OBJECT_FILES_NON_STANDARD	:= y
>  KCOV_INSTRUMENT			:= n
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index c3c11974fa3b..24b2c2425b38 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -89,6 +89,7 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI)
>  # cause crashes. Just disable it.
>  GCOV_PROFILE	:= n
>  KASAN_SANITIZE	:= n
> +KCSAN_SANITIZE	:= n
>  UBSAN_SANITIZE	:= n
>  KCOV_INSTRUMENT	:= n
>  
> diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> index c2bb07f5bcc7..e893b0e1d62a 100644
> --- a/kernel/kcsan/Makefile
> +++ b/kernel/kcsan/Makefile
> @@ -8,6 +8,7 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
>  
>  CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
> +	$(call cc-option,-mno-outline-atomics) \
>  	-fno-stack-protector -DDISABLE_BRANCH_PROFILING
>  
>  obj-y := core.o debugfs.o report.o
> -- 
> 2.26.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
