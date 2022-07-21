Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2747C57C29B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGUDUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:20:51 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C71E47BA7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1658373648; bh=OEQHPVQeBFEcl0uk84V6zB2obeZka85gn0oklmQG5yc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m5vG2koQDRHirSjGlQsRuyhPF78SmE0HtY81e2DqHGcqvFJnWYm192DPhIcJsb6ON
         R0OpTgJE2FyO8V1KV/a4KVeLv4F0FPWlAzFuDbE06xMpBBJvB2IMBKDo/16jg3S1dH
         Pm7bs6dsG0r9u6UTvYKcOO86u9gm2SvfK68epkMo=
Received: from [100.100.35.250] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id A0FB26067B;
        Thu, 21 Jul 2022 11:20:48 +0800 (CST)
Message-ID: <d012f64d-66d6-4019-06a9-f756d48149f5@xen0n.name>
Date:   Thu, 21 Jul 2022 11:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH] LoongArch: Remove unused header compiler.h
Content-Language: en-US
To:     Jun Yi <yijun@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220721021127.1086628-1-yijun@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220721021127.1086628-1-yijun@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/21 10:11, Jun Yi wrote:
> Loongarch not used arch-specific compiler.h

Of course this is wrong. There are definitely #include's of this file, 
so it is definitely used.

Here's my take: "The content of loongarch's compiler.h is trivial, with 
some unused anywhere, so inline the definitions and remove the header."

>
> Signed-off-by: Jun Yi <yijun@loongson.cn>
> ---
>   arch/loongarch/Kconfig                |  1 -
>   arch/loongarch/include/asm/atomic.h   |  9 ++++-----
>   arch/loongarch/include/asm/compiler.h | 15 ---------------
>   arch/loongarch/include/asm/futex.h    |  5 ++---
>   arch/loongarch/include/asm/irqflags.h |  1 -
>   arch/loongarch/include/asm/local.h    |  1 -
>   arch/loongarch/kernel/reset.c         |  1 -
>   arch/loongarch/lib/delay.c            |  1 -
>   8 files changed, 6 insertions(+), 28 deletions(-)
>   delete mode 100644 arch/loongarch/include/asm/compiler.h
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 53a912befb62..89da3e09084e 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -69,7 +69,6 @@ config LOONGARCH
>   	select GENERIC_TIME_VSYSCALL
>   	select GPIOLIB
>   	select HAVE_ARCH_AUDITSYSCALL
> -	select HAVE_ARCH_COMPILER_H
>   	select HAVE_ARCH_MMAP_RND_BITS if MMU
>   	select HAVE_ARCH_SECCOMP_FILTER
>   	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
> index 979367ad4e2c..b5e2e3201af1 100644
> --- a/arch/loongarch/include/asm/atomic.h
> +++ b/arch/loongarch/include/asm/atomic.h
> @@ -10,7 +10,6 @@
>   #include <linux/types.h>
>   #include <asm/barrier.h>
>   #include <asm/cmpxchg.h>
> -#include <asm/compiler.h>
>   
>   #if __SIZEOF_LONG__ == 4
>   #define __LL		"ll.w	"
> @@ -164,7 +163,7 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
>   		"2:							\n"
>   		__WEAK_LLSC_MB
>   		: "=&r" (result), "=&r" (temp),
> -		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> +		  "+ZC" (v->counter)
>   		: "I" (-i));
>   	} else {
>   		__asm__ __volatile__(
> @@ -177,7 +176,7 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
>   		"2:							\n"
>   		__WEAK_LLSC_MB
>   		: "=&r" (result), "=&r" (temp),
> -		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> +		  "+ZC" (v->counter)
>   		: "r" (i));
>   	}
>   
> @@ -327,7 +326,7 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
>   		"2:							\n"
>   		__WEAK_LLSC_MB
>   		: "=&r" (result), "=&r" (temp),
> -		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> +		  "+ZC" (v->counter)
>   		: "I" (-i));
>   	} else {
>   		__asm__ __volatile__(
> @@ -340,7 +339,7 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
>   		"2:							\n"
>   		__WEAK_LLSC_MB
>   		: "=&r" (result), "=&r" (temp),
> -		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> +		  "+ZC" (v->counter)
>   		: "r" (i));
>   	}
>   
> diff --git a/arch/loongarch/include/asm/compiler.h b/arch/loongarch/include/asm/compiler.h
> deleted file mode 100644
> index 657cebe70ace..000000000000
> --- a/arch/loongarch/include/asm/compiler.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> - */
> -#ifndef _ASM_COMPILER_H
> -#define _ASM_COMPILER_H
> -
> -#define GCC_OFF_SMALL_ASM() "ZC"
> -
> -#define LOONGARCH_ISA_LEVEL "loongarch"
> -#define LOONGARCH_ISA_ARCH_LEVEL "arch=loongarch"
> -#define LOONGARCH_ISA_LEVEL_RAW loongarch
> -#define LOONGARCH_ISA_ARCH_LEVEL_RAW LOONGARCH_ISA_LEVEL_RAW
> -
> -#endif /* _ASM_COMPILER_H */
> diff --git a/arch/loongarch/include/asm/futex.h b/arch/loongarch/include/asm/futex.h
> index 9de8231694ec..e28b65d9c67a 100644
> --- a/arch/loongarch/include/asm/futex.h
> +++ b/arch/loongarch/include/asm/futex.h
> @@ -8,7 +8,6 @@
>   #include <linux/futex.h>
>   #include <linux/uaccess.h>
>   #include <asm/barrier.h>
> -#include <asm/compiler.h>
>   #include <asm/errno.h>
>   
>   #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
> @@ -95,8 +94,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newv
>   	"	"__UA_ADDR "\t1b, 4b				\n"
>   	"	"__UA_ADDR "\t2b, 4b				\n"
>   	"	.previous					\n"
> -	: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
> -	: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
> +	: "+r" (ret), "=&r" (val), "=ZC" (*uaddr)
> +	: "ZC" (*uaddr), "Jr" (oldval), "Jr" (newval),
>   	  "i" (-EFAULT)
>   	: "memory", "t0");
>   
> diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/include/asm/irqflags.h
> index 52121cd791fe..319a8c616f1f 100644
> --- a/arch/loongarch/include/asm/irqflags.h
> +++ b/arch/loongarch/include/asm/irqflags.h
> @@ -9,7 +9,6 @@
>   
>   #include <linux/compiler.h>
>   #include <linux/stringify.h>
> -#include <asm/compiler.h>
>   #include <asm/loongarch.h>
>   
>   static inline void arch_local_irq_enable(void)
> diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
> index 2052a2267337..65fbbae9fc4d 100644
> --- a/arch/loongarch/include/asm/local.h
> +++ b/arch/loongarch/include/asm/local.h
> @@ -9,7 +9,6 @@
>   #include <linux/bitops.h>
>   #include <linux/atomic.h>
>   #include <asm/cmpxchg.h>
> -#include <asm/compiler.h>
>   
>   typedef struct {
>   	atomic_long_t a;
> diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
> index 2b86469e4718..800c965a17ea 100644
> --- a/arch/loongarch/kernel/reset.c
> +++ b/arch/loongarch/kernel/reset.c
> @@ -13,7 +13,6 @@
>   #include <linux/console.h>
>   
>   #include <acpi/reboot.h>
> -#include <asm/compiler.h>
>   #include <asm/idle.h>
>   #include <asm/loongarch.h>
>   #include <asm/reboot.h>
> diff --git a/arch/loongarch/lib/delay.c b/arch/loongarch/lib/delay.c
> index 5d856694fcfe..831d4761f385 100644
> --- a/arch/loongarch/lib/delay.c
> +++ b/arch/loongarch/lib/delay.c
> @@ -7,7 +7,6 @@
>   #include <linux/smp.h>
>   #include <linux/timex.h>
>   
> -#include <asm/compiler.h>
>   #include <asm/processor.h>
>   
>   void __delay(unsigned long cycles)
The rest looks good.
