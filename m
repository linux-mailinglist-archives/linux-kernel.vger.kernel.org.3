Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF316591D85
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 04:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiHNCCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 22:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNCCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 22:02:41 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C9761D85;
        Sat, 13 Aug 2022 19:02:40 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27E22JNM016629;
        Sun, 14 Aug 2022 11:02:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27E22JNM016629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660442540;
        bh=+ryfJrFedXpCQcojonYdgaqJJ6AJncGa31MxYiq2M6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DnQvfUwM4j4K+0r5l5brVYkRdnvUehq3cCiFdpTKYgv0eadlk6G3mKPWtORseTg5x
         Lsao8FrJsnXZrlGsjoAhUKBFJdC6rU0apmIF2iHHQiSuhwqPP/Ob8Hr+Ll5V37lWOF
         BZdGEnzijxZ4v27/kPOajVK/VcQmrUzCjlLKV8XG/I8wawshCQDhkxP6MraWhCQQEx
         RsZy47lt3u09+2npv895sniq41+2aez2hkX8mfVergHl5IbRcEAR9GxsrOXCwtYgo8
         4A7CrBaqAREq7o+0MjJwMre4MFPHQzoYBDGZhXAnczXROlx6JdSWY8wtpgqFRD16qR
         BFSe/xEyAHUpA==
X-Nifty-SrcIP: [209.85.221.48]
Received: by mail-wr1-f48.google.com with SMTP id j1so5210609wrw.1;
        Sat, 13 Aug 2022 19:02:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo0dFpg3I2/FanHpOXbD8GdAOhUnI5dqOqw4vvFz7kUN8JiyB3Su
        r1mEZ/qmismOABGNq4nmOnNbHeJGdmyQgBGxERk=
X-Google-Smtp-Source: AA6agR7t1UEnvNygcrmvh3C0+i5LvZbUzhc2NIcpeRqpCaYYQ5brSfPXMb5aFJ4lvkG78X7qv7RPJKpjk8IXFL1PJ5E=
X-Received: by 2002:a05:6000:1f83:b0:223:60ee:6c08 with SMTP id
 bw3-20020a0560001f8300b0022360ee6c08mr5182335wrb.682.1660442538656; Sat, 13
 Aug 2022 19:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220814002021.16990-1-dmitrii.bundin.a@gmail.com>
In-Reply-To: <20220814002021.16990-1-dmitrii.bundin.a@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 14 Aug 2022 11:01:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com>
Message-ID: <CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add configurable debug info level
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC: Fangrui Song <maskray@google.com>




On Sun, Aug 14, 2022 at 9:25 AM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> Provides a way to configure debug info level (-glevel).
> Debug level 3 includes extra information such as macro definitions. With
> level 3 enabled it's possible to expand macros right from the debugging
> session in gdb simplifying debugging when complicated macros involved.
> The default level is set to 2 to not change the default build behavior.
>
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> ---
>
> Changes in v2: https://lore.kernel.org/all/20220804223504.4739-1-dmitrii.bundin.a@gmail.com/
>   - Replace hardcoded -g3 with a configurable debug info level
>
>  lib/Kconfig.debug      | 11 +++++++++++
>  scripts/Makefile.debug |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2e24db4bff19..a17c12c20290 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -304,6 +304,17 @@ config DEBUG_INFO_REDUCED
>           DEBUG_INFO build and compile times are reduced too.
>           Only works with newer gcc versions.
>
> +config DEBUG_INFO_LEVEL
> +       int "Debug info level"
> +       range 0 3
> +       default "2"
> +       help
> +         Sets the level of how much debug information to generate (-glevel).
> +         Level 1 produces minimal debug information without including information
> +         about local variables. Level 3 includes extra information like macro
> +         definitions. Setting up level 3 will require significantly more disk
> +         space and increase built time. Level 0 produces no debug information.
> +



We already have CONFIG_DEBUG_INFO_NONE to
disable the debug info.


The combination of CONFIG_DEBUG_INFO=y and
CONFIG_DEBUG_INFO_LEVEL=0  (-g0)
would emulate CONFIG_DEBUG_INFO_NONE ?



Using 'int' does not look sensible to me.





>  config DEBUG_INFO_COMPRESSED
>         bool "Compressed debugging information"
>         depends on $(cc-option,-gz=zlib)
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 9f39b0130551..28beffc42e71 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -3,7 +3,7 @@ DEBUG_CFLAGS    :=
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   += -gsplit-dwarf
>  else
> -DEBUG_CFLAGS   += -g
> +DEBUG_CFLAGS   += -g$(CONFIG_DEBUG_INFO_LEVEL)
>  endif
>
>  ifndef CONFIG_AS_IS_LLVM
> --
> 2.17.1
>


I want to consult Fangrui Song for this part.


With this Makefile code, CONFIG_DEBUG_INFO_SPLIT
takes the presidency over CONFIG_DEBUG_INFO_LEVEL.


When CONFIG_DEBUG_INFO_SPLIT is enabled (-gsplit-dwarf),
it always uses the default -g2 level.
CONFIG_DEBUG_INFO_LEVEL is just ignored silently.



It might be sensible in older GCC/Clang behavior because
-gsplit-dwarf implied -g2.


But, with this commit:
https://reviews.llvm.org/D80391

-gsplit-dwarf and -g<level> are orthogonal
for GCC 11+/Clang 12+, correct?


I think "splitting debug files" and "debug level"
should be controlled independently.
(but it depends on the compiler version, if I understood correctly)






--
Best Regards
Masahiro Yamada
