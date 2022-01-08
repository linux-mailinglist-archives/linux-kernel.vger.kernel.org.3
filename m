Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A438A4882D4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 10:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiAHJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 04:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiAHJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 04:31:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028B9C061574;
        Sat,  8 Jan 2022 01:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B12560B61;
        Sat,  8 Jan 2022 09:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF2DC36AF4;
        Sat,  8 Jan 2022 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641634286;
        bh=jjD+NJPlawSx/AlIpPp/NXrmxDO2bZYxDhuTS6IqXlU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXYn+P8OQrwu9P3f4K7G0ug1hT7+QGfHEzWTs/lAN5DSFFFYWu6FBiOvr06Xts/mQ
         3qzxE1Nr31jlmNNvIbHS4hPcnBrPJW7F+ORGgtoTSnwokM9xTigMnOoJjoC+u3335B
         2o/P9P/LYUa8LE2JPJa+k4hjCLUrEGetpEP0H1DPkKtdark8XDVz9SHg5DO3kdZByI
         koGBiizop7a1ZNQJt2PijPssbshloMy5fHvNNfVAxoBx7J3jeqmv9NKO+qzy2qkWM7
         dLBmchBvz63OE6vZh1jjyy0KFjLu41oS2cAfXoSYVy6d7NJ1JiDIzkY2hyWI+fDORS
         K6yjyPvc5bxhw==
Received: by mail-wr1-f46.google.com with SMTP id q8so15777477wra.12;
        Sat, 08 Jan 2022 01:31:26 -0800 (PST)
X-Gm-Message-State: AOAM532wNVb9wjoPNGZwVqb5NPsmMu4RNkLci8u06+/7QxMtxH7nml+a
        MM/xrM/XqERqy1xf8FxT4HQMZ4GAfdDE156saBA=
X-Google-Smtp-Source: ABdhPJxx2qmdR7NAzQD9V8jeJxYPy2vtISFzIOMS3FjflpBZ9EvhrL6zKLbCx5As2Kj2V3TQfjjrkP6hm71LtFvwKGk=
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr57379330wry.447.1641634285039;
 Sat, 08 Jan 2022 01:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20220107232746.1540130-1-keescook@chromium.org>
In-Reply-To: <20220107232746.1540130-1-keescook@chromium.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 8 Jan 2022 10:31:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFOqUuSUG=9g0Dd+m3yUfbtf7JG=CR2VP6i6AGXPPAa8Q@mail.gmail.com>
Message-ID: <CAMj1kXFOqUuSUG=9g0Dd+m3yUfbtf7JG=CR2VP6i6AGXPPAa8Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: atomics: Dereference matching size
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 at 00:28, Kees Cook <keescook@chromium.org> wrote:
>
> When building with -Warray-bounds (which is desired to be enabled
> globally), the following warning is generated:
>
> In file included from ./arch/arm64/include/asm/lse.h:16,
>                  from ./arch/arm64/include/asm/cmpxchg.h:14,
>                  from ./arch/arm64/include/asm/atomic.h:16,
>                  from ./include/linux/atomic.h:7,
>                  from ./include/asm-generic/bitops/atomic.h:5,
>                  from ./arch/arm64/include/asm/bitops.h:25,
>                  from ./include/linux/bitops.h:33,
>                  from ./include/linux/kernel.h:22,
>                  from kernel/printk/printk.c:22:
> ./arch/arm64/include/asm/atomic_lse.h:247:9: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
>   247 |         asm volatile(                                                   \
>       |         ^~~
> ./arch/arm64/include/asm/atomic_lse.h:266:1: note: in expansion of macro '__CMPXCHG_CASE'
>   266 | __CMPXCHG_CASE(w,  , acq_, 32,  a, "memory")
>       | ^~~~~~~~~~~~~~
> kernel/printk/printk.c:3606:17: note: while referencing 'printk_cpulock_owner'
>  3606 | static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
>       |                 ^~~~~~~~~~~~~~~~~~~~
>
> This is due to the compiler seeing an unsigned long * cast against
> something (atomic_t) that is int sized. Replace the cast with the
> matching size cast. This results in no change in binary output.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/include/asm/atomic_lse.h | 2 +-
>  arch/arm64/include/asm/cmpxchg.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index d955ade5df7c..5d460f6b7675 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -249,7 +249,7 @@ __lse__cmpxchg_case_##name##sz(volatile void *ptr,                  \
>         "       mov     %" #w "[tmp], %" #w "[old]\n"                   \
>         "       cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"    \
>         "       mov     %" #w "[ret], %" #w "[tmp]"                     \
> -       : [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr),            \
> +       : [ret] "+r" (x0), [v] "+Q" (*(u##sz *)ptr),                    \
>           [tmp] "=&r" (tmp)                                             \
>         : [old] "r" (x1), [new] "r" (x2)                                \
>         : cl);                                                          \
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index f9bef42c1411..497acf134d99 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -243,7 +243,7 @@ static inline void __cmpwait_case_##sz(volatile void *ptr,          \
>         "       cbnz    %" #w "[tmp], 1f\n"                             \
>         "       wfe\n"                                                  \
>         "1:"                                                            \
> -       : [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)           \
> +       : [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)                   \
>         : [val] "r" (val));                                             \
>  }
>
> --
> 2.30.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
