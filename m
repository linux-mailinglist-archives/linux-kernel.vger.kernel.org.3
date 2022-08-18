Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8835A597CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiHREOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHREOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:14:30 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247246237;
        Wed, 17 Aug 2022 21:14:27 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 27I4E7qI006188;
        Thu, 18 Aug 2022 13:14:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 27I4E7qI006188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660796048;
        bh=fBjy9ghAjzX3QmOyrKyUNLeSrFTRlq0iDhHqAd6gtCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rencAVO4D0TjfrSZRafx6aNs97RkaK6uOnpKGl6E5lsaGih4qlNq/RoiZa+5kWvLf
         33Nc30864pLLL+uzW23zb1CxeK5xQ8vQBGcBF0qMDMxPM6wKEDQzqG7sKBTepuXvM4
         jp3p0P1Q7sRAiqIAX6euDcGXoMnd6EdaPVgcB4ixGQ6EqbHsL8K15IZ3Q917oWzqdq
         9UouUpYU3fi3uSyshjqckt5YiXFUX3xwZ7/J1j52377iaJKsaXRSnUmdRpD/m6jyyg
         cag6sBjFIhCL0+NPYTdaf+WN7k8xwUUt7H/cidZEYRxr7zDXh3mzOYsqE1ukUXfUDB
         S71DuIJ2aDy5w==
X-Nifty-SrcIP: [209.85.221.49]
Received: by mail-wr1-f49.google.com with SMTP id bu15so325415wrb.7;
        Wed, 17 Aug 2022 21:14:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ITk3jvadC4LsiTvO8aFW3O2v4IE7jBMMKitgLFwA48TTd6sln
        AyS+Ot+i92i8L9TLnHiRzBwfwe6XtdhKNyIXyPQ=
X-Google-Smtp-Source: AA6agR4lIVWc1fU/ENmobcLFg29NAbQPZK6jhJ3GLzTATiknyvOtX3MN9QCQOB5BlsrG7eYJ+SRc8fjkhJ8llgCZ8KM=
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr467318wrv.97.1660796046168; Wed, 17 Aug
 2022 21:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com>
In-Reply-To: <20220815013317.26121-1-dmitrii.bundin.a@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 18 Aug 2022 13:13:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzVto=rEpASc-JOF_TW0KhNT93jD0E2gfk8UES3PWFiw@mail.gmail.com>
Message-ID: <CAK7LNAQzVto=rEpASc-JOF_TW0KhNT93jD0E2gfk8UES3PWFiw@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?B?Ru+/ve+/ve+/vW5nLXJ177+977+977+9IFPvv73vv73vv71uZw==?= 
        <maskray@google.com>, Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:34 AM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> Adds config options to control debug info level and producing of macro
> definitions for GCC/Clang.
>
> Option DEBUG_INFO_LEVEL is responsible for controlling debug info level.
> Before GCC 11 and Clang 12 -gsplit-dwarf implicitly uses -g2. To provide
> a way to override the setting with, e.g. -g1, DEBUG_INFO_LEVEL is set
> independently from DEBUG_INFO_SPLIT.
>
> Option DEBUG_MACRO_DEFINITIONS is responsible for controlling inclusion
> of macro definitions. Since Clang uses -fdebug-macro to control if macro
> definitions are produced which is different from GCC, provides a
> compiler-specific way of handling macro inclusion. The option is handled
> after DEBUG_INFO_LEVEL since -g3 -g2 implies -g2, but -g2 -g3 implies
> -g3 and GCC uses -g3 to produce macro definitions.




I am not sure if DEBUG_INFO_LEVEL is useful
because the macro debug data is now enabled
by DEBUG_MACRO_DEFINITIONS.

-g1 is only possible via DEBUG_INFO_LEVEL, but
presumably it is not your main interest
(and not sure if there is anybody interested)
because the main motivation for your v1
is to generate macro debug data.


BTW, DEBUG_INFO_MACRO might be more consistent
(as the others are prefixed DEBUG_INFO_*), but that might
be just my personal preference.








>
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> ---
>
> Changes in v2: https://lore.kernel.org/all/20220804223504.4739-1-dmitrii.bundin.a@gmail.com/
>   - Replace hardcoded -g3 with a configurable debug info level
>
> Changes in v3: https://lore.kernel.org/all/20220814002021.16990-1-dmitrii.bundin.a@gmail.com/
>   - Make -g<level> and -gdwarf-split to be set independently
>   - Add a separate option to control macro definitions for GCC/Clang
>
>  lib/Kconfig.debug      | 20 ++++++++++++++++++++
>  scripts/Makefile.debug | 12 ++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2e24db4bff19..ace6f2eddb56 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -304,6 +304,26 @@ config DEBUG_INFO_REDUCED
>           DEBUG_INFO build and compile times are reduced too.
>           Only works with newer gcc versions.
>
> +config DEBUG_INFO_LEVEL
> +       int "Debug info level"
> +       range 1 3
> +       default "2"
> +       help
> +         Sets the level of how much debug information to generate (-glevel).
> +         Level 1 produces minimal debug information without including information
> +         about local variables. Level 3 includes extra information like macro
> +         definitions. Setting up level 3 will require significantly more disk
> +         space and increase built time.
> +
> +config DEBUG_MACRO_DEFINITIONS
> +       bool "Add macro definitions to debug info"
> +       default n
> +       help
> +         Generates macro definitions to provide a way to expand macros right
> +         in the debugging session. This information can be used with macro expand,
> +         info macro in gdb. This option is equivalent to setting -g3 in GCC and
> +         -fdebug-macro in Clang.
> +
>  config DEBUG_INFO_COMPRESSED
>         bool "Compressed debugging information"
>         depends on $(cc-option,-gz=zlib)
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 9f39b0130551..29cd04234e75 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -2,8 +2,6 @@ DEBUG_CFLAGS    :=
>
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   += -gsplit-dwarf
> -else
> -DEBUG_CFLAGS   += -g
>  endif
>
>  ifndef CONFIG_AS_IS_LLVM
> @@ -16,6 +14,16 @@ dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
>  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
>  endif
>
> +DEBUG_CFLAGS   += -g$(CONFIG_DEBUG_INFO_LEVEL)
> +ifdef CONFIG_DEBUG_MACRO_DEFINITIONS
> +ifdef CONFIG_CC_IS_GCC
> +DEBUG_CFLAGS   += -g3
> +endif
> +ifdef CONFIG_CC_IS_CLANG
> +DEBUG_CFLAGS   += -fdebug-macro
> +endif
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS   += -fno-var-tracking
>  ifdef CONFIG_CC_IS_GCC
> --
> 2.17.1
>


--
Best Regards
Masahiro Yamada
