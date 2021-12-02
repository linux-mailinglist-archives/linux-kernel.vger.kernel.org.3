Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53224665A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355653AbhLBOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:48:59 -0500
Received: from foss.arm.com ([217.140.110.172]:36192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358717AbhLBOsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:48:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F39C6142F;
        Thu,  2 Dec 2021 06:45:00 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1CDC3F766;
        Thu,  2 Dec 2021 06:44:59 -0800 (PST)
Date:   Thu, 2 Dec 2021 14:44:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joey.gouly@arm.com
Subject: Re: [PATCH v3] arm64: Enable KCSAN
Message-ID: <Yajb4w6R4nqPpELq@lakrids>
References: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
 <CANpmjNO5DUk=biDkfP9iepKYBeROO8wL58n8HziOTXuRMOXpvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO5DUk=biDkfP9iepKYBeROO8wL58n8HziOTXuRMOXpvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:36:06PM +0100, Marco Elver wrote:
> On Thu, 2 Dec 2021 at 15:23, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >
> > This patch enables KCSAN for arm64, with updates to build rules
> > to not use KCSAN for several incompatible compilation units.
> >
> > Resent GCC version(at least GCC10) made outline-atomics as the
> 
> s/Resent/Recent/
> 
> > default option(unlike Clang), which will cause linker errors
> > for kernel/kcsan/core.o. Disables the out-of-line atomics by
> > no-outline-atomics to fix the linker errors.
> >
> > Meanwhile, as Mark said[1], there is a specific issue on arm64
> > about ARM64_BTI with Clang 11 if KCSAN enabled, which is fixed
> > by Clang 12, add CLANG_VERSION check. And also some latent issues
> > are need to be fixed which isn't just a KCSAN problem, we make
> > the KCSAN depends on EXPERT for now.
> >
> > Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> > and all passed.
> >
> > [1] https://lkml.org/lkml/2021/12/1/354
> 
> Please use lore/kernel.org permalinks. For this one it'd be:
> https://lkml.kernel.org/r/YadiUPpJ0gADbiHQ@FVFF77S0Q05N
> 
> (But I think if this is the final version of the patch, hopefully a
> maintainer can amend the commit message.)
> 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Acked-by: Marco Elver <elver@google.com> # kernel/kcsan
> 
> is still valid, given nothing changed there. I leave the rest to Mark.

I want to do some compiler / config testing before I ack this (just to
make sure there isn't some latent issue I've forgotten about), but
otherwise I think this should be fine.

I'll try to have that done in the next few days.

Any other review/testing would be appreciated!

Thanks,
Mark.

> 
> Thanks,
> -- Marco
> 
> > ---
> > Tested on Qemu with clang 13 / gcc 11, based on 5.16-rc3.
> >
> > [    0.221518] kcsan: enabled early
> > [    0.222422] kcsan: strict mode configured
> > ...
> > [    5.839223] kcsan: selftest: 3/3 tests passed
> > ...
> > [  517.895102] # kcsan: pass:24 fail:0 skip:0 total:24
> > [  517.896393] # Totals: pass:168 fail:0 skip:0 total:168
> > [  517.897502] ok 1 - kcsan
> >
> > v3:
> > - add EXPERT and CLANG_VERSION depends suggested by Mark Rutland
> > v2:
> > - tested on GCC11 and disable outline-atomics for kernel/kcsan/core.c
> >   suggested by Marco Elver
> >
> >  arch/arm64/Kconfig               | 1 +
> >  arch/arm64/kernel/vdso/Makefile  | 1 +
> >  arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
> >  kernel/kcsan/Makefile            | 1 +
> >  4 files changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 4ff73299f8a9..3a7b17742cde 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -150,6 +150,7 @@ config ARM64
> >         select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
> >         select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> >         select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
> > +       select HAVE_ARCH_KCSAN if EXPERT && (CC_IS_GCC || CLANG_VERSION >= 120000)
> >         select HAVE_ARCH_KFENCE
> >         select HAVE_ARCH_KGDB
> >         select HAVE_ARCH_MMAP_RND_BITS
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > index 700767dfd221..60813497a381 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -32,6 +32,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
> >  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
> >                                 $(CC_FLAGS_LTO)
> >  KASAN_SANITIZE                 := n
> > +KCSAN_SANITIZE                 := n
> >  UBSAN_SANITIZE                 := n
> >  OBJECT_FILES_NON_STANDARD      := y
> >  KCOV_INSTRUMENT                        := n
> > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> > index c3c11974fa3b..24b2c2425b38 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > @@ -89,6 +89,7 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI)
> >  # cause crashes. Just disable it.
> >  GCOV_PROFILE   := n
> >  KASAN_SANITIZE := n
> > +KCSAN_SANITIZE := n
> >  UBSAN_SANITIZE := n
> >  KCOV_INSTRUMENT        := n
> >
> > diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> > index c2bb07f5bcc7..e893b0e1d62a 100644
> > --- a/kernel/kcsan/Makefile
> > +++ b/kernel/kcsan/Makefile
> > @@ -8,6 +8,7 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
> >
> >  CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
> > +       $(call cc-option,-mno-outline-atomics) \
> >         -fno-stack-protector -DDISABLE_BRANCH_PROFILING
> >
> >  obj-y := core.o debugfs.o report.o
> > --
> > 2.26.2
> >
