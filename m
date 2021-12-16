Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2505476F81
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhLPLId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:08:33 -0500
Received: from foss.arm.com ([217.140.110.172]:42070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhLPLIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:08:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684CF1474;
        Thu, 16 Dec 2021 03:08:32 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC0433F774;
        Thu, 16 Dec 2021 03:08:31 -0800 (PST)
Date:   Thu, 16 Dec 2021 11:08:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] fortify: Detect struct member overflows in
 memcpy() at compile-time
Message-ID: <YbseKuBwHEfvzykO@FVFF77S0Q05N>
References: <20211213223331.135412-1-keescook@chromium.org>
 <20211213223331.135412-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213223331.135412-7-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:33:20PM -0800, Kees Cook wrote:
> memcpy() is dead; long live memcpy()
> 
> tl;dr: In order to eliminate a large class of common buffer overflow
> flaws that continue to persist in the kernel, have memcpy() (under
> CONFIG_FORTIFY_SOURCE) perform bounds checking of the destination struct
> member when they have a known size. This would have caught all of the
> memcpy()-related buffer write overflow flaws identified in at least the
> last three years.
> 

Hi Kees,

Since there's a *lot* of context below, it's very easy to miss some key details
(e.g. that the compile-time warnings are limited to W=1 builds). It would be
really nice if the summary above could say something like:

  This patch makes it possible to detect when memcpy() of a struct member may
  go past the bounds of that member. When CONFIG_FORTIFY_SOURCE=y, runtime
  checks are always emitted where the compiler cannot guarantee a memcpy() is
  safely bounded, and compile-time warnings are enabled for W=1 builds.

  This catches a large class of common buffer overflow flaws, and would have
  caught all of the memcpy()-related buffer write overflow flaws identified in
  the last three years.

As an aside, since W=1 is chock-full of (IMO useless) warnings, is there any
way to enable *just* the FORTIFY_SOURCE warnings?

[...]

> Implementation:
> 
> Tighten the memcpy() destination buffer size checking to use the actual
> ("mode 1") target buffer size as the bounds check instead of their
> enclosing structure's ("mode 0") size. Use a common inline for memcpy()
> (and memmove() in a following patch), since all the tests are the
> same. All new cross-field memcpy() uses must use the struct_group() macro
> or similar to target a specific range of fields, so that FORTIFY_SOURCE
> can reason about the size and safety of the copy.
> 
> For now, cross-member "mode 1" read detection at compile-time will be
> limited to W=1 builds, since it is, unfortunately, very common. As the
> priority is solving write overflows, read overflows can be part of the
> next phase.

I had a go at testing this on arm64, and could get build-time warnings from GCC
11.1.0, but not from Clang 13.0.0.

I picked the series from:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=memcpy/step2/next-20211213

I prepped a tree with that branch and a deliberate bug:

| [mark@lakrids:~/src/linux]% git checkout -f kernel-org-kees/memcpy/step2/next-20211213
| [mark@lakrids:~/src/linux]% git clean -qfdx
| [mark@lakrids:~/src/linux]% cat <<EOF >> arch/arm64/kernel/setup.c
| 
| struct foo {
|        int a;
|        int b;
| } foo1, foo2;
| 
| void foo_copy(void);
| void foo_copy(void)
| {
|        memcpy(&foo1.a, &foo2.a, sizeof(foo1));
| }
| EOF

When building with GCC 11.1.0:

| [mark@lakrids:~/src/linux]% usekorg 11.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s defconfig
| [mark@lakrids:~/src/linux]% ./scripts/config -e FORTIFY_SOURCE                                      
| [mark@lakrids:~/src/linux]% grep FORTIFY_SOURCE .config       
| CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
| CONFIG_FORTIFY_SOURCE=y
| [mark@lakrids:~/src/linux]% usekorg 11.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s arch/arm64/kernel/setup.o
| In file included from ./include/linux/string.h:253,
|                  from ./include/linux/bitmap.h:11,
|                  from ./include/linux/cpumask.h:12,
|                  from ./include/linux/smp.h:13,
|                  from ./include/linux/lockdep.h:14,
|                  from ./include/linux/mutex.h:17,
|                  from ./include/linux/kernfs.h:12,
|                  from ./include/linux/sysfs.h:16,
|                  from ./include/linux/kobject.h:20,
|                  from ./include/linux/of.h:17,
|                  from ./include/linux/irqdomain.h:35,
|                  from ./include/linux/acpi.h:13,
|                  from arch/arm64/kernel/setup.c:9:
| In function 'fortify_memcpy_chk',
|     inlined from 'foo_copy' at arch/arm64/kernel/setup.c:457:8:
| ./include/linux/fortify-string.h:316:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
|   316 |                         __write_overflow_field(p_size_field, size);
|       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| ./include/linux/fortify-string.h:324:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
|   324 |                         __read_overflow2_field(q_size_field, size);
|       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When building with clang 13.0.0 (the vdso bits can be ignored):

| [mark@lakrids:~/src/linux]% usellvm 13.0.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- LLVM=1 -s defconfig                    
| [mark@lakrids:~/src/linux]% ./scripts/config -e FORTIFY_SOURCE                                             
| [mark@lakrids:~/src/linux]% grep FORTIFY_SOURCE .config       
| CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
| CONFIG_FORTIFY_SOURCE=y
| [mark@lakrids:~/src/linux]% usellvm 13.0.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- LLVM=1 W=1 -s arch/arm64/kernel/setup.o
| arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: no previous prototype for function '__kernel_clock_gettime' [-Wmissing-prototypes]
| int __kernel_clock_gettime(clockid_t clock,
|     ^
| arch/arm64/kernel/vdso/vgettimeofday.c:9:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
| int __kernel_clock_gettime(clockid_t clock,
| ^
| static 
| arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: no previous prototype for function '__kernel_gettimeofday' [-Wmissing-prototypes]
| int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
|     ^
| arch/arm64/kernel/vdso/vgettimeofday.c:15:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
| int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
| ^
| static 
| arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: no previous prototype for function '__kernel_clock_getres' [-Wmissing-prototypes]
| int __kernel_clock_getres(clockid_t clock_id,
|     ^
| arch/arm64/kernel/vdso/vgettimeofday.c:21:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
| int __kernel_clock_getres(clockid_t clock_id,
| ^
| static 
| 3 warnings generated.

No relevant warnings, but code was generated for runtime warnings:

| 0000000000000000 <foo_copy>:
|    0:   d503233f        paciasp
|    4:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
|    8:   910003fd        mov     x29, sp
|    c:   52800080        mov     w0, #0x4                        // #4
|   10:   52800101        mov     w1, #0x8                        // #8
|   14:   94000000        bl      0 <__write_overflow_field>
|   18:   52800080        mov     w0, #0x4                        // #4
|   1c:   52800101        mov     w1, #0x8                        // #8
|   20:   94000000        bl      0 <__read_overflow2_field>
|   24:   90000008        adrp    x8, 8 <foo_copy+0x8>
|   28:   f9400108        ldr     x8, [x8]
|   2c:   90000009        adrp    x9, 0 <foo_copy>
|   30:   f9000128        str     x8, [x9]
|   34:   a8c17bfd        ldp     x29, x30, [sp], #16
|   38:   d50323bf        autiasp
|   3c:   d65f03c0        ret

Have I misunderstood how that's meant to work, or am I doing something wrong?

Thanks,
Mark.
