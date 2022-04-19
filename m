Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192EA506897
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350600AbiDSKS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiDSKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:18:56 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B7193DF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:16:13 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2eafabbc80aso166268797b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0A8yKiNSIzt01Wdi2DEzhHefwHABBkNja1VeDIka0hE=;
        b=qShyWJlkk3HgXuBGOYS59wF9CBFj22b5veUhsdEY/CVFHRktQMMwOvjf4Ski6zoh/V
         R1z9lbUrzRzHnDgs6QgfqzcXvht47zCfMUI5rYRlOpzZyO8LNQswiMPAkIlkY9YBNQel
         er2x/jhI9Eq7ivgMEw20KpM9UAr6OLbPtPLHFrGSt8CviNlXgD18Yud3N2faUKWfxS5i
         QXhDJOrs2f4gzUFGNlVEz1G2U+hyXKVIMnVY0v2EtgclH2Y+xvWxr0BcI18iQg52ADKv
         zqw6NSndiuAUv9Uj/C7yDJctZq87sfyqk0TkGiV5FFSAFdIf5OOvwDZmTMpL4z5cE4n/
         +cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0A8yKiNSIzt01Wdi2DEzhHefwHABBkNja1VeDIka0hE=;
        b=A09MnwRGaTZHFik78064eP2b7/kRUClVKB7NA6bkbC+MgLbm7oEJoq+T3wkoDAG0kV
         ASoJRODxFTRXcAb/zJa677cPU/ll6JeFMd2CYw+L8281OvCEmzpZIx7/FPceeKB64kGp
         nORKlqYC5XrF7gWtGTxruXlS+tbbp/9S6hV3BWRsJo8yFZXJDpCfFsIZ91a/+s9Jv+tp
         ua+4RbMc9BStNH1V89m1B2aWUK6KXS9WJ3eR0nuyGWMlJx3V9ZfqcFWgs9vmdk7G5r+X
         RnhToxyYx1p8PAb5n5Aslzy7w8sBt2ECaGD3h4YWpAZ9fzAZSbu+juhxiBR+KAHUnqww
         UEQw==
X-Gm-Message-State: AOAM5326mTj9Nahi0U4zBPm/USwrrw6jZLKgjQ57sGn63xLiJs0IVKUk
        RUmOrZ3CEF9er9AwGAkRPmMIBq0+PsCzmv/B+SfbWw==
X-Google-Smtp-Source: ABdhPJwEChUx3kSOlycF6STgeFL+r7RNahLwLllD5HGYoEydgImnfN1Y0oKbuwhT2hbb6t1/BIfE8g3wmn4QO1GQcaA=
X-Received: by 2002:a81:5781:0:b0:2ef:6043:f3d2 with SMTP id
 l123-20020a815781000000b002ef6043f3d2mr14398581ywb.316.1650363372366; Tue, 19
 Apr 2022 03:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220416081355.2155050-1-jcmvbkbc@gmail.com>
In-Reply-To: <20220416081355.2155050-1-jcmvbkbc@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Apr 2022 12:15:36 +0200
Message-ID: <CANpmjNNW0kLf2Ou6i_dNeRLO=Qrru4bOEfJ=be=Dfig4wnQ67g@mail.gmail.com>
Subject: Re: [PATCH] xtensa: enable KCSAN
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice to see this happen!

On Sat, 16 Apr 2022 at 10:14, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Prefix arch-specific barrier macros with '__' to make use of instrumented
> generic macros.
> Prefix arch-specific bitops with 'arch_' to make use of instrumented
> generic functions.

> Provide stubs for 64-bit atomics when building with KCSAN.

The stubs are the only thing I don't understand. More elaboration on
why this is required would be useful (maybe there's another way to
solve?).

> Disable KCSAN instrumentation in arch/xtensa/boot.

Given you went for barrier instrumentation, I assume you tested with a
CONFIG_KCSAN_STRICT=y config? Did the kcsan_test pass?

> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/Kconfig               |  1 +
>  arch/xtensa/boot/lib/Makefile     |  1 +
>  arch/xtensa/include/asm/barrier.h |  6 ++--
>  arch/xtensa/include/asm/bitops.h  | 10 +++---
>  arch/xtensa/lib/Makefile          |  2 ++
>  arch/xtensa/lib/kcsan-stubs.c     | 54 +++++++++++++++++++++++++++++++
>  6 files changed, 67 insertions(+), 7 deletions(-)
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
> index d6f8d4ddc2bc..a22d4bb08159 100644
> --- a/arch/xtensa/include/asm/barrier.h
> +++ b/arch/xtensa/include/asm/barrier.h
> @@ -11,9 +11,9 @@
>
>  #include <asm/core.h>
>
> -#define mb()  ({ __asm__ __volatile__("memw" : : : "memory"); })
> -#define rmb() barrier()
> -#define wmb() mb()
> +#define __mb()  ({ __asm__ __volatile__("memw" : : : "memory"); })
> +#define __rmb() barrier()
> +#define __wmb() mb()
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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220416081355.2155050-1-jcmvbkbc%40gmail.com.
