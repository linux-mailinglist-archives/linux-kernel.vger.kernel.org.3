Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1794B464D55
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349078AbhLAL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:57:18 -0500
Received: from foss.arm.com ([217.140.110.172]:34954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242696AbhLAL5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:57:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 529781476;
        Wed,  1 Dec 2021 03:53:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B0853F694;
        Wed,  1 Dec 2021 03:53:55 -0800 (PST)
Date:   Wed, 1 Dec 2021 11:53:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joey.gouly@arm.com
Subject: Re: [PATCH v2] arm64: Enable KCSAN
Message-ID: <YadiUPpJ0gADbiHQ@FVFF77S0Q05N>
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Mon, Nov 29, 2021 at 10:57:32PM +0800, Kefeng Wang wrote:
> This patch enables KCSAN for arm64, with updates to build rules
> to not use KCSAN for several incompatible compilation units.
> 
> Resent GCC version(at least GCC10) made outline-atomics as the
> default option(unlike Clang), which will cause linker errors
> for kernel/kcsan/core.o.
> 
> Disables the out-of-line atomics by no-outline-atomics to fix
> the linker errors.
> 
> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> and all passed.

Nice!

I think there are a few additional bits and pieces we'll need:

* Prior to clang 12.0.0, KCSAN would produce warnings with BTI, as I found in:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=2d67c39ae4f619ca94d9790e09186e77922fa826

  Since BTI is in defconfig, I think arm64's Kconfig should require a minimum
  of clang 12.0.0 to enable KCSAN.

* In the past clang did not have an attribute to suppress tsan instrumenation
  and would instrument noinstr regions. I'm not sure when clang gained the
  relevant attribute to supress this, but we will need to depend on this
  existing, either based on the clang version or with a test for the attribute.

  (If we're lucky, clang 12.0.0 is sufficient, and we solve BTI and this in one
  go).

  I *think* GCC always had an attribute, but I'm not certain.

  Marco, is there an existing dependency somewhere for this to work on x86? I
  thought there was an objtool pass to NOP this out, but I couldn't find it in
  mainline. If x86 is implicitly depending on a sufficiently recent version of
  clang, we add something to the common KCSAN Kconfig for ARCH_WANTS_NO_INSTR?

* There are some latent issues with some code (e.g. alternatives, patching, insn)
  code being instrumentable even though this is unsound, and depending on
  compiler choices this can happen to be fine or can result in boot-time
  failures (I saw lockups when I started trying to add KCSAN for arm64).

  While this isn't just a KCSAN problem, fixing that requires some fairly
  significant rework to a bunch of code, and until that's done we're on very
  shaky ground. So I'd like to make KCSAN depend on EXPERT for now.

  I had an initial stab at fixing some of that, e.g.

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/patching/rework
  
  Joey has started looking into this too.

* When I last tested, for simple boots I would get frequent KCSAN splats for a
  few common issues, and those drowned out all other reports.

  One case was manipulation of thread_info::flags, which Thomas Gleixner has
  queued some fixes at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=core/entry
 
  There were some other common failures, e.g. accesses to task_struct::on_cpu,
  and I hadn't had the chance to investigate/fix those, beyond a (likely
  unsound) hack:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=4fe9d6c2ef85257d80291086e4514eaaebd3504e

  It would be good if we could identify the most frequent problems (e.g. those
  that will occur when just booting) before we enable this generally, to avoid
  everyone racing to report/fix those as soon as we enable the feature.

  When you tested, did KCSAN flag anything beyond the selftests?

> 
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
> v2:
> - tested on GCC11 and disable outline-atomics for kernel/kcsan/core.c
>   suggested by Marco Elver
> 
>  arch/arm64/Kconfig               | 1 +
>  arch/arm64/kernel/vdso/Makefile  | 1 +
>  arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
>  kernel/kcsan/Makefile            | 1 +
>  4 files changed, 4 insertions(+)

Aside from the `-mno-outline-atomics` portion, this looks basically the same as what I had in:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=2d67c39ae4f619ca94d9790e09186e77922fa826

... so this looks good to me modulo the comments above.

Thanks,
Mark.

> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4ff73299f8a9..0ac90875f71d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -150,6 +150,7 @@ config ARM64
>  	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
> +	select HAVE_ARCH_KCSAN
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
