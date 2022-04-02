Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1894F0216
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbiDBNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiDBNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:34:10 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C527100E24
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 06:32:18 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 232DVpoE026970
        for <linux-kernel@vger.kernel.org>; Sat, 2 Apr 2022 22:31:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 232DVpoE026970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648906312;
        bh=xOOUq32hUTZwQ6PgJmve8CWFa41o5uzRkpcTqar04RU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vCXu70nRSHY2Lv6Bw5iUYKQi4NgIBNGXSOv3tNAM7uIraCCo4LTa/ywLh+ye+shXb
         nyeay6O+48FKit5/DNX5BWey6iI40BfoR2CRvJ9EJ5+1MXt/oOmH7AiGeFkXQ0CPLj
         overa1Km8ueTLcpp80BLIQS5+ythR9TwB7nORO0unED0bJyMNbIeDnSvXjmiPGLNNy
         rtWiVaxJCRfc+6O8PQvVYCjXyi9cVfCo2OyOiU1mPuDeADIf6nNevP14XZ80czHeJc
         j3n6MCL+YEvGPHblicFd6wB/EgXap3UVRfAnQwGa7ymZI7mzsiAUubppy7IoR+dbuJ
         oanKvBFDQVSfg==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id f3so4990636pfe.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 06:31:51 -0700 (PDT)
X-Gm-Message-State: AOAM530zon4+2wc6e300ATrmBfUIDxkOiz8xt4ZVCWK6XEDYQPXImffd
        tYmXXEBiIg+KqaxaqrgxX6f/xh0RV4Lhi5Plsso=
X-Google-Smtp-Source: ABdhPJx4YYmusrB0Z5GeyAsnegUTZrEgkZTlTfMYeabO5lynAPEH3l4SbNCZnBVbE/nGUhMGQfWBqXQSL4kqhRfqwvQ=
X-Received: by 2002:a63:ec47:0:b0:382:692a:dc04 with SMTP id
 r7-20020a63ec47000000b00382692adc04mr18906915pgj.352.1648906311008; Sat, 02
 Apr 2022 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220401201916.1487500-1-samitolvanen@google.com> <20220401201916.1487500-2-samitolvanen@google.com>
In-Reply-To: <20220401201916.1487500-2-samitolvanen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 2 Apr 2022 22:31:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQoJWUscyxXVnOQ9924MYZwaZGgfBYSzmjJxKH_UC0Pkw@mail.gmail.com>
Message-ID: <CAK7LNAQoJWUscyxXVnOQ9924MYZwaZGgfBYSzmjJxKH_UC0Pkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: Change CFI_CLANG to depend on __builtin_function_start
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 5:19 AM Sami Tolvanen <samitolvanen@google.com> wrot=
e:
>
> Clang 14 added support for the __builtin_function_start()
> built-in function, which allows us to implement function_nocfi()
> without architecture-specific inline assembly. This patch changes
> CONFIG_CFI_CLANG to depend on the built-in and effectively upgrades
> the minimum supported compiler version for CFI to Clang 14.

From this description, I think the straight-forward change would be:

    depends on CLANG_VERSION >=3D 120000
-->
    depends on CLANG_VERSION >=3D 140000

Any reason to avoid this?


>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/Kconfig | 5 +----
>  init/Kconfig | 3 +++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 29b0167c088b..eecfc2809781 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -723,10 +723,7 @@ config ARCH_SUPPORTS_CFI_CLANG
>  config CFI_CLANG
>         bool "Use Clang's Control Flow Integrity (CFI)"
>         depends on LTO_CLANG && ARCH_SUPPORTS_CFI_CLANG
> -       # Clang >=3D 12:
> -       # - https://bugs.llvm.org/show_bug.cgi?id=3D46258
> -       # - https://bugs.llvm.org/show_bug.cgi?id=3D47479
> -       depends on CLANG_VERSION >=3D 120000
> +       depends on CC_HAS_BUILTIN_FUNCTION_START
>         select KALLSYMS
>         help
>           This option enables Clang=E2=80=99s forward-edge Control Flow I=
ntegrity
> diff --git a/init/Kconfig b/init/Kconfig
> index ddcbefe535e9..f024fd353373 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -86,6 +86,9 @@ config CC_HAS_ASM_INLINE
>  config CC_HAS_NO_PROFILE_FN_ATTR
>         def_bool $(success,echo '__attribute__((no_profile_instrument_fun=
ction)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
>
> +config CC_HAS_BUILTIN_FUNCTION_START
> +       def_bool $(success,echo 'void f(void) {}; void *p =3D __builtin_f=
unction_start(f);' | $(CC) -x c - -c -o /dev/null)
> +
>  config PAHOLE_VERSION
>         int
>         default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
> --
> 2.35.0
>


--
Best Regards
Masahiro Yamada
