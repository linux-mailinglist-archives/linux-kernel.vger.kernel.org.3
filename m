Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04847531CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbiEWSoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244188AbiEWSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:44:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351A16A051
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:27:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p4so25615054lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNu8GgvsbpstMN5PR/r7FbQyBoA4doE2J/KRSOCWuco=;
        b=P4pCSBFcumSIj5G4eIByQ1cm/h9Hiq5VA5X97Wk5UNf0wFrpzLrxjDCqTalhhKVTsz
         PvwpPZ9FJfsbf0ox3kCgikqETgzKMdva4NshPTE1JP4W53KKH+sW+wrW+54VARwa4YMX
         BfsdHFkVHasswm9iaWq3P9l1cagN2JnEWskhgSbu/kTSPUGqS4cUtzJDscd1ugPrui5H
         p0CHPAwR6+c3l1JmiveYG6JaNwZ38USv8NdSsZV/p0I9FfOdpCH7Ex/VpCqvNeG0mFL6
         dJDZJIX2UzkTIsywtWdqKf1Ca5Mf11nB3+8oZMzd6xdPNwOhDScTVsFtzdwmFVfjIIgt
         tylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNu8GgvsbpstMN5PR/r7FbQyBoA4doE2J/KRSOCWuco=;
        b=KGKGbXTCiJPGPiZ5VTOqv03OM2v0Q0+oRM1WTPBWrZVkfW8IEH9WTP7ISZvuA1xmEb
         pd6nQrAoQnw29QYj7Mjmu1X+heWbM2glXBaxqlwqv+ZnUxpnuYXk2JmFq+vdK0tUcUs6
         HeANB8gEfmH4tlYmqzryS2aSUNcAT7eU8kuh8/zEEt1nmf6hwOIG/tcx+zgV9gtBZhqR
         czTdHg439d08ofeTPaQE1OBH+BrAHpkt8+5TRYwwJCETspvSRzNMnyAaoZseD9+S/9Z8
         bCXt9c4DFv7D8Ee9ZZrZojmjvJ+jh58jtP0FmNA+6bgxXxj1Hrft86s/R9uGjKYcJgcl
         QaZA==
X-Gm-Message-State: AOAM533YLG+IGBDGtq+9mSWd8/tWUtIq2tFvQsueUOIxm1tGVyRUysHt
        0cU9s5xDNlbTAHyYaNqADzFB+AfdyrzgcLq4g1SXK7DN2dyMCA==
X-Google-Smtp-Source: ABdhPJwtL/9b9Op6DZncvq9prrrbtQImTZ5H/bUzajfBqooqYDKMkJ9dAI4p7nxMhLDrq+Oyhd6w4ml0b0qA5xV8mAk=
X-Received: by 2002:a19:651c:0:b0:477:87cf:de6 with SMTP id
 z28-20020a19651c000000b0047787cf0de6mr16656479lfb.432.1653330426475; Mon, 23
 May 2022 11:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 May 2022 11:26:54 -0700
Message-ID: <CAKwvOdneqUvq+Nz_zPmJmuPFfAvWQgnzrw1AJt=WqQF2hThF-A@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: Add an option to enable -O1 and speed-up
 compilation time
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
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

On Sat, May 21, 2022 at 2:04 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Add a new compilation option which speeds-up compilation time.
> This can be useful when using static checker such as smatch or build-bots.
> In such cases, the speed and quality of the generated code is not
> important.
>
> Using -O0 would be even better, but unfortunately, building fails with
> this option.

Which is a tragedy.

As with the Rust series, I'm not a fan of this (or
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3):
https://lore.kernel.org/lkml/CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com/

These feel more like attempts to wrap every conceivable command line
flag in a kconfig option, which makes me think of that meme from
Jurassic Park: "your scientists were so preoccupied with whether or
not they could, they didn't stop to think if they should."
Not a fan.  I'd ask for measurements, but that would be a request for
a "rock fetching quest" for something I still wouldn't be a fan of.

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

s/slighly/slightly/

> +         memory.
> +
>  config CC_OPTIMIZE_FOR_PERFORMANCE
>         bool "Optimize for performance (-O2)"
>         help
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
