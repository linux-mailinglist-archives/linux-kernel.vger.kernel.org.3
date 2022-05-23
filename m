Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCEF5318D5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiEWTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiEWTHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:07:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41269A9BA
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:45:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r3so11393268ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOWZUBJqNcdlgAF3ozzceIWa1QLe3KoX8JwY9UNGHd4=;
        b=UstXh4WwiSYrL1ybcoTWRmyZsv9hEjc6PjZMBIKnBZP0zhT7iTun1KvXZ8H17U8qSH
         iz+7+bLHxdtL7wvkFkMIpdZu3lQ51hwOwKdx/wG4KzaJXykJmazsGwA7t4UGAtTePw/B
         mK+BUuXVrIeuhZNDEKPHGY+iv6YBe6R27v/utPWafsuvsLf2TmGu2ewgAfZSdKBowv4l
         LoP4BWbhRDtTjeIcpB3tIiVwfN42D2mxokpmBrGJMTT5Dd6TNpI3j9kQxH/bd3ESREMT
         XevvqDcVtKuqvXq0zcj3Z/G0wAyCfCELfimVoPf+6+u9hcQLdRX4KGz8yIs0FLopHIeq
         RhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOWZUBJqNcdlgAF3ozzceIWa1QLe3KoX8JwY9UNGHd4=;
        b=HKT66azjPtcBauC5Jd5SEXp6ioThdR+2uyArZ/TSFrBZExsishvnVDH9RFkJQiPSWb
         eVRbhSY8W6emt58K1r33a0+RG/XA5mchCfBobqQoCWw8FTCdvk94iogg2x+tXp9IO4bz
         X13OIcsjIsb9ZEybgv/jm+D6YRVonxGH9oxOKyOXxHcmsa7WmGavIZv8+NQsYI44dco3
         kLrAV6l7E+YyPvopht+I40E6RHeO11nOSCI6axclCppt+ASAakMyOLzp5R16fhlCRSG4
         v3+r4UNAA6kZxiadCDYuYPwaP5Fa7AQHkjKF4T4Zg4Mq5pgEllZiNSZu46exUo0JCEed
         rFSA==
X-Gm-Message-State: AOAM530/6NQgttfLthEqC58pWVeuAqyYsSZ+JAVt+y3W/CeyLKSBhLYJ
        Hp6MSEMEUUo4vXAREyW8Nl5NZvsXgAx4bIwDwiRVQw==
X-Google-Smtp-Source: ABdhPJyqr3CCsMipzHURp2FsSWTJB3upstez3xIYqCFafcp/ENDyuWVgPX2GXxQPyyXKkJMEh1xX8mg+wI61pNqucdI=
X-Received: by 2002:a2e:98cd:0:b0:253:df46:323e with SMTP id
 s13-20020a2e98cd000000b00253df46323emr9603557ljj.295.1653331503220; Mon, 23
 May 2022 11:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-22-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-22-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 May 2022 11:44:51 -0700
Message-ID: <CAKwvOdkTjxNEmCTnuH5f41WB50ef6ErBM2Kp2zJ-t9q_5U8rBA@mail.gmail.com>
Subject: Re: [PATCH v7 21/25] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>,
        David Gow <davidgow@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-um@lists.infradead.org
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

> +choice
> +       prompt "Optimization level"
> +       default RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C
> +       depends on RUST
> +       help
> +         Controls rustc's `-Copt-level` codegen option.
> +
> +         This flag controls the optimization level.
> +
> +         If unsure, say "Similar as chosen for C".
> +
> +config RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C
> +       bool "Similar as chosen for C"
> +       help
> +         This choice will pick a similar optimization level as chosen in
> +         the "Compiler optimization level" for C:
> +
> +             -O2 is currently mapped to -Copt-level=2
> +             -O3 is currently mapped to -Copt-level=3
> +             -Os is currently mapped to -Copt-level=s
> +
> +         The mapping may change over time to follow the intended semantics
> +         of the choice for C as sensibly as possible.
> +
> +         This is the default.
> +
> +config RUST_OPT_LEVEL_0
> +       bool "No optimizations (-Copt-level=0)"
> +       help
> +         Not recommended for most purposes. It may come in handy for debugging
> +         suspected optimizer bugs, unexpected undefined behavior, etc.
> +
> +         Note that this level will *not* enable debug assertions nor overflow
> +         checks on its own (like it happens when interacting with rustc
> +         directly). Use the corresponding configuration options to control
> +         that instead, orthogonally.
> +
> +         Note this level may cause excessive stack usage, which can lead to stack
> +         overflow and subsequent crashes.
> +
> +config RUST_OPT_LEVEL_1
> +       bool "Basic optimizations (-Copt-level=1)"
> +       help
> +         Useful for debugging without getting too lost, but without
> +         the overhead and boilerplate of no optimizations at all.
> +
> +         Note this level may cause excessive stack usage, which can lead to stack
> +         overflow and subsequent crashes.
> +
> +config RUST_OPT_LEVEL_2
> +       bool "Some optimizations (-Copt-level=2)"
> +       help
> +         The sensible choice in most cases.
> +
> +config RUST_OPT_LEVEL_3
> +       bool "All optimizations (-Copt-level=3)"
> +       help
> +         Yet more performance (hopefully).
> +
> +config RUST_OPT_LEVEL_S
> +       bool "Optimize for size (-Copt-level=s)"
> +       help
> +         Smaller kernel, ideally without too much performance loss.
> +
> +config RUST_OPT_LEVEL_Z
> +       bool "Optimize for size, no loop vectorization (-Copt-level=z)"
> +       help
> +         Like the previous level, but also turn off loop vectorization.

I'm super not into having the rust optimization level differ from the
C optimization level.  This is just someone having too much fun
wrapping every compiler flag in a kbuild option.  Either folks wan't
smaller size or more optimizations. Allowing for RUST_OPT_LEVEL_S and
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE or RUST_OPT_LEVEL_3 and
CONFIG_CC_OPTIMIZE_FOR_SIZE is just wacky nonsense that's going to
make randconfig bug reports more confusing to tease out.
-- 
Thanks,
~Nick Desaulniers
