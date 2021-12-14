Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7B474ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhLNSYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:24:23 -0500
Received: from foss.arm.com ([217.140.110.172]:34594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhLNSYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:24:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 233B46D;
        Tue, 14 Dec 2021 10:24:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF6543F5A1;
        Tue, 14 Dec 2021 10:24:20 -0800 (PST)
Date:   Tue, 14 Dec 2021 18:24:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v4] arm64: Enable KCSAN
Message-ID: <YbjhUaEP4Sqk7qRP@FVFF77S0Q05N>
References: <20211211131734.126874-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211131734.126874-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 09:17:34PM +0800, Kefeng Wang wrote:
> This patch enables KCSAN for arm64, with updates to build rules
> to not use KCSAN for several incompatible compilation units.
> 
> Recent GCC version(at least GCC10) made outline-atomics as the
> default option(unlike Clang), which will cause linker errors
> for kernel/kcsan/core.o. Disables the out-of-line atomics by
> no-outline-atomics to fix the linker errors.
> 
> Meanwhile, as Mark said[1], some latent issues are needed to be
> fixed which isn't just a KCSAN problem, we make the KCSAN depends
> on EXPERT for now.
> 
> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> and all passed.
> 
> [1] https://lkml.kernel.org/r/YadiUPpJ0gADbiHQ@FVFF77S0Q05N
> Acked-by: Marco Elver <elver@google.com> # kernel/kcsan
> Tested-by: Joey Gouly <joey.gouly@arm.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> 
> Tested on Qemu with clang 13 / gcc 11, based on 5.16-rc3 by Kefeng.
> Tested with gcc 11 and clang 14.0 (built from git) on qemu and FVP by Joey.

Hi,

Sorry for the silence on v3; I got a little busy elsewhere and wasn't able to
test that, but I have given this v4 a fairly intensive test with KCSAN combined
with other config options I use when fuzzing.

I eyeballed the output from a bunch of compilers (noted below), and there's
still a fair amount of potentially-unsound instrumentation, but I'm happy with
that so long as we have the EXPERT dependency. I agree we can fix those
(latent) issues with follow-up work.

I have one minor comment below about adding a comment, but aside from that,
this looks good and I didn't encounter any unexpected issues while testing, so:

  Reviewed-by: Mark Rutland <mark.rutland@arm.com>
  Tested-by: Mark Rutland <mark.rutland@arm.com>

> v4:
> - drop Clang version as commit 8cdd23c23c3d ("arm64: Restrict ARM64_BTI_KERNEL
>   to clang 12.0.0 and newer"), suggested by Nathan Chancellor
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
> index 4ff73299f8a9..2cc9dea55e00 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -150,6 +150,7 @@ config ARM64
>  	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
> +	select HAVE_ARCH_KCSAN if EXPERT

It might be worth adding:

	/* Some instrumentation may be unsound */

... immediately above this to clarify why we added the EXPERT dependency here.

Other than that trivial comment, this looks good to me!

For future reference, below is an info dump about how I've tested this, and
which latent issues KCSAN reported during testing. Feel free to ignore for now.
:)

I've pushed  your patch (atop v5.16-rc4) and the config fragments I used to
test a `arm64-kcsan-kw-20211214` tag:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64-kcsan-kw-20211214
  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/tag/?h=arm64-kcsan-kw-20211214

From that branch I built the following configurations:

* defconfig (as a baseline)
* defconfig + kcsan.config
* defconfig + fuzzing.config + kcsan.config

Using the following toolchains:

* GCC 11.1.0
* LLVM 11.0.0 (using LLVM=1)
* LLVM 12.0.0 (using LLVM=1)
* LLVM 13.0.0 (using LLVM=1)

I booted each kernel on a 250-vCPU VM with 8GB or RAM on a ThunderX2 host a
number of times, using QEMU 6.2.0-rc1-96-gdd4b0de459, and the following script:

| #!/bin/sh
| 
| KERNEL=$1
| 
| FILESYSTEM=/home/mark/src/buildroot/output/images/rootfs.ext4
| QEMU=/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64
| 
| ${QEMU} \
|         -m 8192 -smp 250 \
|         -net nic \
|         -net user,host=10.0.2.10,hostfwd=tcp::65022-:22 \
|         -nographic \
|         -no-reboot \
|         -machine virt,accel=kvm,gic-version=host \
|         -cpu host \
|         -hda ${FILESYSTEM} \
|         -snapshot \
|         -kernel ${KERNEL} \
|         -append "earlycon=pl011,0x9000000 console=ttyAMA0,115200 root=/dev/vda loglevel=9"

I've logged the unique KCSAN reports I saw for a regular boot into my bugs
folder on kernel.org:

  https://mirrors.edge.kernel.org/pub/linux/kernel/people/mark/bugs/20211214-v5.16-rc4%2Bkcsan/

... the summary of which is below:

* BUG: KCSAN: data-race in capable / cgroup_freezer_migrate_task
* BUG: KCSAN: data-race in console_unlock / vprintk_emit
* BUG: KCSAN: data-race in __d_add / __d_add
* BUG: KCSAN: data-race in __do_sys_prctl / do_task_stat
* BUG: KCSAN: data-race in do_task_stat / sigprocmask
* BUG: KCSAN: data-race in ep_modify / ep_poll_callback
* BUG: KCSAN: data-race in _find_next_bit+0x60/0x194
* BUG: KCSAN: data-race in folio_mark_accessed / workingset_activation
* BUG: KCSAN: data-race in ktime_get / timekeeping_advance
* BUG: KCSAN: data-race in more_used_split+0x38/0x60
* BUG: KCSAN: data-race in mutex_spin_on_owner+0xcc/0x150
* BUG: KCSAN: data-race in rwsem_spin_on_owner+0xa8/0x13c
* BUG: KCSAN: data-race in start_dir_add+0x34/0xd4
* BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_idle_stop_tick
* BUG: KCSAN: data-race in timekeeping_delta_to_ns+0x34/0x94
* BUG: KCSAN: data-race in virtqueue_get_buf_ctx+0xe8/0x458
* BUG: KCSAN: data-race in virtqueue_get_buf_ctx_split+0x68/0x2dc
* BUG: KCSAN: data-race in vprintk_emit+0x320/0x494

By far the most commonly reported races were in "{mutex,rwsem}_spin_on_owner",
followed by "timekeeping_delta_to_ns" followed by "virtqueue_get_buf_ctx*". So
those look like the ones to focus on in the near term.

When using GCC I would very often see reports I didn't see with LLVM, for
"vprintk_emit" and "ktime_get / timekeeping_advance". I don't know if that's
down to something getting optimized away or something getting instrumented
differently.

While testing I also hit a couple of UBSAN splats that I don't think are
related:

* UBSAN: null-ptr-deref in ./include/linux/pagemap.h:1088:17
* UBSAN: object-size-mismatch in net/unix/af_unix.c:977:14

... but I've uploaded the reports all the same, and I'll see about reporting
them properly shortly.

Thanks,
Mark.

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
