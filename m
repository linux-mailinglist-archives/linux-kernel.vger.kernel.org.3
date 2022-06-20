Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD65514CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbiFTJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbiFTJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:50:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEF013E05
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:50:27 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-317741c86fdso92891247b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5v3S7Zkd9PrYC84ZzumNRLfIqFWNrQTW2/cBzQcLYg=;
        b=mIpWvLd42Zk3qDlC1lJPcvqz7M92/WQXcIoyM0LykA88iAo+rdgJDoHazph31kdSjO
         VUG7i/8HNZaOHLdu3N7nDqHPuwIY9fq9FvuOy2YX4EQM5bkG55ZAVqX3dyMqhKkf3Zrp
         wdgsnCqcf5yU/1gR7FrWP0Ud1NWBTI4TQjIzmZlty8pgPxfb7xHnM8DyqjB9t4bddRHR
         O64X//fr0z/4HxfkqMa1L+YEzzaQ9IobIbQsg9BgYcppkG2JYM76WtyvjDHFXlKlUAJ0
         15NorsK1RaWXrUbZhIe7SdlsQlOhJzxaaCKzH9GSm4bD8dAmvyeOcvf0LOG2jFT9DYh9
         yfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5v3S7Zkd9PrYC84ZzumNRLfIqFWNrQTW2/cBzQcLYg=;
        b=UfMptIEMgXfaLBobp2trlndR9vgFQ2mKyf80H6LtWdzf7A3CjZEwBDitguykSzgnpg
         UtwYox2zrQ7VSycu0IU9THAP8nZJLFMbLfcncMPaX+lD0iN5EohKG1ksJi7vQBhL7+Ug
         NQuDJ+HOHZXmdOtFf3Cak5S4SXfZyfsU5TImO4XL2nt/unguz9nwZjs9H/vDeKq+JnYs
         GvbwDz4rnP8yVQ2BUO/R7WQeffYkjEIHWO+lSXJbSouzy0xvcfAbXcIQcnvhgbdg7hmX
         opOCldzkKgu3XQNodQZVhVY5L3LJ7Bb1JeVsvOetDrgLmUDUXcL3KXLLYNShsfeIl/PG
         QXbA==
X-Gm-Message-State: AJIora+GCVX8ObkTOYlXyuN9XWdE4wgZ0rAhVmZqI6egX1buL6wTOgUh
        RvINApoUiGHEToLq7SqDjvTOvpsBwdplFOjG2q/b0Q==
X-Google-Smtp-Source: AGRyM1uqwPv5EEm+1mfuSKwMODskeRwUAmI9vr2ZogkAKlsFAi/E6OQyVuET36WKVD2vqMmJlAF716hcyW0OfDGtk5M=
X-Received: by 2002:a05:690c:681:b0:317:e92b:7f8d with SMTP id
 bp1-20020a05690c068100b00317e92b7f8dmr1282353ywb.264.1655718625831; Mon, 20
 Jun 2022 02:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com> <20220617144031.2549432-5-alexandr.lobakin@intel.com>
In-Reply-To: <20220617144031.2549432-5-alexandr.lobakin@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 11:49:50 +0200
Message-ID: <CANpmjNMU86pKB37OcnZ34Avd8+gBn-Ekz_6uYvF94zFZY0itCw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] bitops: define const_*() versions of the non-atomics
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 at 19:21, Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> Define const_*() variants of the non-atomic bitops to be used when
> the input arguments are compile-time constants, so that the compiler
> will be always able to resolve those to compile-time constants as
> well. Those are mostly direct aliases for generic_*() with one
> exception for const_test_bit(): the original one is declared
> atomic-safe and thus doesn't discard the `volatile` qualifier, so
> in order to let optimize code, define it separately disregarding
> the qualifier.
> Add them to the compile-time type checks as well just in case.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  .../asm-generic/bitops/generic-non-atomic.h   | 31 +++++++++++++++++++
>  include/linux/bitops.h                        |  1 +
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> index b85b8a2ac239..3d5ebd24652b 100644
> --- a/include/asm-generic/bitops/generic-non-atomic.h
> +++ b/include/asm-generic/bitops/generic-non-atomic.h
> @@ -127,4 +127,35 @@ generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
>         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
>
> +/*
> + * const_*() definitions provide good compile-time optimizations when
> + * the passed arguments can be resolved at compile time.
> + */
> +#define const___set_bit                        generic___set_bit
> +#define const___clear_bit              generic___clear_bit
> +#define const___change_bit             generic___change_bit
> +#define const___test_and_set_bit       generic___test_and_set_bit
> +#define const___test_and_clear_bit     generic___test_and_clear_bit
> +#define const___test_and_change_bit    generic___test_and_change_bit
> +
> +/**
> + * const_test_bit - Determine whether a bit is set
> + * @nr: bit number to test
> + * @addr: Address to start counting from
> + *
> + * A version of generic_test_bit() which discards the `volatile` qualifier to
> + * allow a compiler to optimize code harder. Non-atomic and to be called only
> + * for testing compile-time constants, e.g. by the corresponding macros, not
> + * directly from "regular" code.
> + */
> +static __always_inline bool
> +const_test_bit(unsigned long nr, const volatile unsigned long *addr)
> +{
> +       const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
> +       unsigned long mask = BIT_MASK(nr);
> +       unsigned long val = *p;
> +
> +       return !!(val & mask);
> +}
> +
>  #endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 87087454a288..d393297287d5 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -37,6 +37,7 @@ extern unsigned long __sw_hweight64(__u64 w);
>  /* Check that the bitops prototypes are sane */
>  #define __check_bitop_pr(name)                                         \
>         static_assert(__same_type(arch_##name, generic_##name) &&       \
> +                     __same_type(const_##name, generic_##name) &&      \
>                       __same_type(name, generic_##name))
>
>  __check_bitop_pr(__set_bit);
> --
> 2.36.1
>
