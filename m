Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90E509AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386874AbiDUIuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386852AbiDUIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:50:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD813F90
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:47:14 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t67so7523129ybi.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAlP0SwMAgEokpC45b/8A58tbYCJ2ulOw6rDhTTZvu8=;
        b=HQ6BuTHEFF7E7NWy+QGPf6QLh2//lK8EPrUZndG1ON8byVtII3jlIGEaBEO57I12WC
         MgqGyzUrS3f8bvA19pZxab+kVKkLR65hJNwGVmDMp+YMoSn0YDsbHsGjm2BE70Ek3/hR
         eLv2uK55IouOrUQ04aCsLxUn/l2gf6scgN4LNKWZvlUs8aH6qLVuSO/aqIcKZE7TG4cG
         KjazkE097Ljmwb/nJfdx+NKgrKtdfv8SSs/KW3sZXtmR/UrhCQl30aTTZKLSOSGQka0B
         Y47Ta+tv9R8jETrWSNHSaoT3uGhcgB25kspRm+ytwOW2AAju7vMFa5MYpv/xIfJ9T9EZ
         /hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAlP0SwMAgEokpC45b/8A58tbYCJ2ulOw6rDhTTZvu8=;
        b=EhtfKHDGiAGPBaai1tJytiR46ZSVuiUh+YUGvDbvihjEro2mNmb3T4A8lk4wza7Zv5
         JQJ1+ocJsnW7Zj18lm0eTx5BVBBWxOn60VleNpHMGfnMKJ4YZf8m2Dpn6Ch9gKBCZ4Jz
         cXzfBEa1lL4GphvTL9/XbS895tP8DQH47CEqCGBrPNizysyRm4HmWf7YSA25CgwWxFNt
         DXHafuB0RILbXoG0l9ekQk9MfrjGMOUc0iA+fVn36XL6AM9754QpgCdgrWlOueg2NxBF
         kNm/kNFvpnBfcvWRwZx/Y8o9c8Wtxqr+VhA44pQTlicRYYjxLuvfXkfEWwuYUDOxXTd+
         navw==
X-Gm-Message-State: AOAM532G5hwVuZgbl9zuPI6+bYqzVn53jQOSL4UiGVxAucHldO/SmGuT
        mKWEP3HU0g0RZKYDm36EYm7hPR8zPh1bcwgktWuhFA==
X-Google-Smtp-Source: ABdhPJz+RB414Kbzmepfy09ll2ddoIKN2wFJH1Cn2piskeDAADKm3TADqvJf/y/fucrdpR9Niu+WaVP/H6QQarZT0T8=
X-Received: by 2002:a25:aaa4:0:b0:641:3506:900 with SMTP id
 t33-20020a25aaa4000000b0064135060900mr23664506ybi.87.1650530833852; Thu, 21
 Apr 2022 01:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220420190805.152533-1-jcmvbkbc@gmail.com>
In-Reply-To: <20220420190805.152533-1-jcmvbkbc@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 Apr 2022 10:46:37 +0200
Message-ID: <CANpmjNO4nXfqFYcS3xBREZ3TCTe_feOsBFqQ46YJUjSvLWUqGQ@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: enable KCSAN
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 at 21:08, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Prefix arch-specific barrier macros with '__' to make use of instrumented
> generic macros.
> Prefix arch-specific bitops with 'arch_' to make use of instrumented
> generic functions.
> Provide stubs for 64-bit atomics when building with KCSAN.
> Disable KCSAN instrumentation in arch/xtensa/boot.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Acked-by: Marco Elver <elver@google.com>

> ---
> Changes v1->v2:
>
> - fix __wmb definition to use __mb instead of mb
> - provide __smp_{,r,w}mb definitions because definitions from the
>   asm-generic use mb/rmb/wmb instead of __mb/__rmb/__wmb, thus
>   doubling KCSAN instrumentation.
>
>   Both changes fix a few failures in the KCSAN testsuite.
>
>  arch/xtensa/Kconfig               |  1 +
>  arch/xtensa/boot/lib/Makefile     |  1 +
>  arch/xtensa/include/asm/barrier.h | 12 +++++--
>  arch/xtensa/include/asm/bitops.h  | 10 +++---
>  arch/xtensa/lib/Makefile          |  2 ++
>  arch/xtensa/lib/kcsan-stubs.c     | 54 +++++++++++++++++++++++++++++++
>  6 files changed, 73 insertions(+), 7 deletions(-)
>  create mode 100644 arch/xtensa/lib/kcsan-stubs.c
>
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 797355c142b3..c87f5ab493d9 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -29,6 +29,7 @@ config XTENSA
>         select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>         select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
> +       select HAVE_ARCH_KCSAN
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_CONTEXT_TRACKING
> diff --git a/arch/xtensa/boot/lib/Makefile b/arch/xtensa/boot/lib/Makefile
> index e3d717c7bfa1..162d10af36f3 100644
> --- a/arch/xtensa/boot/lib/Makefile
> +++ b/arch/xtensa/boot/lib/Makefile
> @@ -16,6 +16,7 @@ CFLAGS_REMOVE_inffast.o = -pg
>  endif
>
>  KASAN_SANITIZE := n
> +KCSAN_SANITIZE := n
>
>  CFLAGS_REMOVE_inflate.o += -fstack-protector -fstack-protector-strong
>  CFLAGS_REMOVE_zmem.o += -fstack-protector -fstack-protector-strong
> diff --git a/arch/xtensa/include/asm/barrier.h b/arch/xtensa/include/asm/barrier.h
> index d6f8d4ddc2bc..898ea397e9bc 100644
> --- a/arch/xtensa/include/asm/barrier.h
> +++ b/arch/xtensa/include/asm/barrier.h
> @@ -11,9 +11,15 @@
>
>  #include <asm/core.h>
>
> -#define mb()  ({ __asm__ __volatile__("memw" : : : "memory"); })
> -#define rmb() barrier()
> -#define wmb() mb()
> +#define __mb()  ({ __asm__ __volatile__("memw" : : : "memory"); })
> +#define __rmb() barrier()
> +#define __wmb() __mb()
> +
> +#ifdef CONFIG_SMP
> +#define __smp_mb() __mb()
> +#define __smp_rmb() __rmb()
> +#define __smp_wmb() __wmb()
> +#endif
>
>  #if XCHAL_HAVE_S32C1I
>  #define __smp_mb__before_atomic()              barrier()
> diff --git a/arch/xtensa/include/asm/bitops.h b/arch/xtensa/include/asm/bitops.h
> index cd225896c40f..e02ec5833389 100644
> --- a/arch/xtensa/include/asm/bitops.h
> +++ b/arch/xtensa/include/asm/bitops.h
> @@ -99,7 +99,7 @@ static inline unsigned long __fls(unsigned long word)
>  #if XCHAL_HAVE_EXCLUSIVE
>
>  #define BIT_OP(op, insn, inv)                                          \
> -static inline void op##_bit(unsigned int bit, volatile unsigned long *p)\
> +static inline void arch_##op##_bit(unsigned int bit, volatile unsigned long *p)\
>  {                                                                      \
>         unsigned long tmp;                                              \
>         unsigned long mask = 1UL << (bit & 31);                         \
> @@ -119,7 +119,7 @@ static inline void op##_bit(unsigned int bit, volatile unsigned long *p)\
>
>  #define TEST_AND_BIT_OP(op, insn, inv)                                 \
>  static inline int                                                      \
> -test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)       \
> +arch_test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)  \
>  {                                                                      \
>         unsigned long tmp, value;                                       \
>         unsigned long mask = 1UL << (bit & 31);                         \
> @@ -142,7 +142,7 @@ test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)    \
>  #elif XCHAL_HAVE_S32C1I
>
>  #define BIT_OP(op, insn, inv)                                          \
> -static inline void op##_bit(unsigned int bit, volatile unsigned long *p)\
> +static inline void arch_##op##_bit(unsigned int bit, volatile unsigned long *p)\
>  {                                                                      \
>         unsigned long tmp, value;                                       \
>         unsigned long mask = 1UL << (bit & 31);                         \
> @@ -163,7 +163,7 @@ static inline void op##_bit(unsigned int bit, volatile unsigned long *p)\
>
>  #define TEST_AND_BIT_OP(op, insn, inv)                                 \
>  static inline int                                                      \
> -test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)       \
> +arch_test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)  \
>  {                                                                      \
>         unsigned long tmp, value;                                       \
>         unsigned long mask = 1UL << (bit & 31);                         \
> @@ -205,6 +205,8 @@ BIT_OPS(change, "xor", )
>  #undef BIT_OP
>  #undef TEST_AND_BIT_OP
>
> +#include <asm-generic/bitops/instrumented-atomic.h>
> +
>  #include <asm-generic/bitops/le.h>
>
>  #include <asm-generic/bitops/ext2-atomic-setbit.h>
> diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
> index 5848c133f7ea..d4e9c397e3fd 100644
> --- a/arch/xtensa/lib/Makefile
> +++ b/arch/xtensa/lib/Makefile
> @@ -8,3 +8,5 @@ lib-y   += memcopy.o memset.o checksum.o \
>            divsi3.o udivsi3.o modsi3.o umodsi3.o mulsi3.o \
>            usercopy.o strncpy_user.o strnlen_user.o
>  lib-$(CONFIG_PCI) += pci-auto.o
> +lib-$(CONFIG_KCSAN) += kcsan-stubs.o
> +KCSAN_SANITIZE_kcsan-stubs.o := n
> diff --git a/arch/xtensa/lib/kcsan-stubs.c b/arch/xtensa/lib/kcsan-stubs.c
> new file mode 100644
> index 000000000000..2b08faa62b86
> --- /dev/null
> +++ b/arch/xtensa/lib/kcsan-stubs.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bug.h>
> +#include <linux/types.h>
> +
> +void __atomic_store_8(volatile void *p, u64 v, int i)
> +{
> +       BUG();
> +}
> +
> +u64 __atomic_load_8(const volatile void *p, int i)
> +{
> +       BUG();
> +}
> +
> +u64 __atomic_exchange_8(volatile void *p, u64 v, int i)
> +{
> +       BUG();
> +}
> +
> +bool __atomic_compare_exchange_8(volatile void *p1, void *p2, u64 v, bool b, int i1, int i2)
> +{
> +       BUG();
> +}
> +
> +u64 __atomic_fetch_add_8(volatile void *p, u64 v, int i)
> +{
> +       BUG();
> +}
> +
> +u64 __atomic_fetch_sub_8(volatile void *p, u64 v, int i)
> +{
> +       BUG();
> +}
> +
> +u64 __atomic_fetch_and_8(volatile void *p, u64 v, int i)
> +{
> +       BUG();
> +}
> +
> +u64 __atomic_fetch_or_8(volatile void *p, u64 v, int i)
> +{
> +       BUG();
> +}
> +
> +u64 __atomic_fetch_xor_8(volatile void *p, u64 v, int i)
> +{
> +       BUG();
> +}
> +
> +u64 __atomic_fetch_nand_8(volatile void *p, u64 v, int i)
> +{
> +       BUG();
> +}
> --
> 2.30.2
>
