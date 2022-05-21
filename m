Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168E852FDEC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355459AbiEUPkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355508AbiEUPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:39:39 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB596351C;
        Sat, 21 May 2022 08:39:18 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24LFcxRn020449;
        Sun, 22 May 2022 00:38:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24LFcxRn020449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653147539;
        bh=E7Am5Nb9a8KomAfL0DWSpMGcRuyvDbO2H0enFw86lac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mmss+paMa26fLx30DM4uAjXe+hi1m5UbvsADimGmzr7IWvQyc6/ycCqMbIK6Sn8xm
         T8VwUVO3Eb1qe8Ct//Bc39+yvk+sWAe9GrN4+miP74KPs7FZWo/AWwG2sSzz8rp6YJ
         OjAWhOOp6Q7/c1cINOoO8uIqMg3jqxM3Cu8HIlLWrRtdpdT9kS0Z9w3vPlWHVnmuhw
         vY83rN/VIt3qDm1xePB8sQeGYLmXCE8l6aaeAP3VzyO6rWCc00bN41VzyhIO3SKIwM
         ROjBLWIkgYW6pr89ytbBmjv53x9OjiLIRYTXGphXiw5fqg4rgR7YU9rK6X5rkZe/dq
         KwU/UWjM4qW6A==
X-Nifty-SrcIP: [209.85.210.173]
Received: by mail-pf1-f173.google.com with SMTP id w200so10053813pfc.10;
        Sat, 21 May 2022 08:38:59 -0700 (PDT)
X-Gm-Message-State: AOAM533x//zvxN8lLJ3Zh6SQEJZBrqiYTOR0w3wLftJ5RwjoxCr+zImk
        W710Y5drRv2OGQ2OhSKti1HqxJZEhkzyhHbydIg=
X-Google-Smtp-Source: ABdhPJwqVIczKOUbexuJjN8ztbp6Eewxf8TjPCHhzKdG58dczONSDGOjuexLGdkEJyZqRUMX15iTRwYrfw5DZUuNY9A=
X-Received: by 2002:a63:9043:0:b0:3f9:6c36:3de3 with SMTP id
 a64-20020a639043000000b003f96c363de3mr5866156pge.616.1653147535087; Sat, 21
 May 2022 08:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 22 May 2022 00:38:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHGyzKS-d+S1GYz_L0pBxxSwk05YfvV+LK4ghZ5xx=cA@mail.gmail.com>
Message-ID: <CAK7LNASHGyzKS-d+S1GYz_L0pBxxSwk05YfvV+LK4ghZ5xx=cA@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: Add an option to enable -O1 and speed-up
 compilation time
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC: Arnd, Changbin Du)


If -O1 support does not require additional effort,
I have no objection to this patch.

(but I do not have enough insight about
the compiler's inlining heuristic)



BTW, when we attempted to add the -Og support,
we fixed various parts, and Linus rejected it.

https://lore.kernel.org/linux-kbuild/CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com/







On Sat, May 21, 2022 at 6:04 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Add a new compilation option which speeds-up compilation time.
> This can be useful when using static checker such as smatch or build-bots.
> In such cases, the speed and quality of the generated code is not
> important.
>
> Using -O0 would be even better, but unfortunately, building fails with
> this option.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  Makefile     | 5 ++++-
>  init/Kconfig | 8 ++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 1f8bef92868f..14467386f947 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -817,7 +817,10 @@ KBUILD_CFLAGS      += $(call cc-disable-warning, format-truncation)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, address-of-packed-member)
>
> -ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> +ifdef CONFIG_CC_OPTIMIZE_FOR_COMPILATION_SPEED
> +KBUILD_CFLAGS += -O1
> +KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := 1
> +else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
>  KBUILD_CFLAGS += -O2
>  KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := 2
>  else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
> diff --git a/init/Kconfig b/init/Kconfig
> index a96776a9b080..3177a1830c9a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1384,6 +1384,14 @@ choice
>         prompt "Compiler optimization level"
>         default CC_OPTIMIZE_FOR_PERFORMANCE
>
> +config CC_OPTIMIZE_FOR_COMPILATION_SPEED
> +       bool "Optimize for compilation speed (-O1)"
> +       help
> +         This option can be useful when running a static checker such as smatch
> +         or a build-bot.
> +         Compilation time is slighly faster than -O2 and it requires less
> +         memory.
> +
>  config CC_OPTIMIZE_FOR_PERFORMANCE
>         bool "Optimize for performance (-O2)"
>         help
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
