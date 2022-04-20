Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABE1508D25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380518AbiDTQZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380384AbiDTQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:25:37 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B027A39B99;
        Wed, 20 Apr 2022 09:22:50 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 23KGMccr017946;
        Thu, 21 Apr 2022 01:22:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 23KGMccr017946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650471759;
        bh=g1D7GXEz3zPiKR6ViztNpGgyzc3O/TLrapN2L8mCzMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PlXVhddlRZHS7g51tQ+BfT48O30S5ckKf2dyGoE9XPGqopjqbQbwBSmonw+LOZVMY
         JPfbNYurcmLVb1kSBU0sGPO7oD9NGvcVM4kaXbgD5oTRUSmUTzfqOe/x2DPnw7tlYc
         TuhZf4ycC20c8u8FYY1O7sauZfN0cHSQM61heYFOxhS0jR8Mb10c7wNi4EFH0xx7az
         6wFd9Kc4ARi5EhJskbGv3xu62DiOUptmrsVCFvgeIB6a8b0HY99aDzrxZDyAIvCUmP
         9a/FrpLKZ16J09jX7puGORzTPCsgfEca23uDpdGFvj45dkNKNtKaR+QZtpHmycAhLm
         Hn8qpqT9+/FSg==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so2477514pji.4;
        Wed, 20 Apr 2022 09:22:38 -0700 (PDT)
X-Gm-Message-State: AOAM531guYGUZZVDfUlNcNraT4SY4gdLlgzgdL/599M8fI8m9rOMJDkz
        ljO8CiQMUFONZuehtGaSEdrLLT0Gu5SenrPCKvM=
X-Google-Smtp-Source: ABdhPJxm+6uKlQArnmwWK1to0XFTv3Hj9dLecMwfdgMqj/wvAfg90qkdUljRa/Aqd8G195TpJa7TqkAyVer/swDSKAQ=
X-Received: by 2002:a17:90a:de87:b0:1cb:b207:a729 with SMTP id
 n7-20020a17090ade8700b001cbb207a729mr5401383pjv.144.1650471757865; Wed, 20
 Apr 2022 09:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com> <20220408084607.106468-1-ydroneaud@opteya.com>
In-Reply-To: <20220408084607.106468-1-ydroneaud@opteya.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 21 Apr 2022 01:21:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARk+mpdQhHnQP8pKf8oAqVVkZaQ+cckdRosFCv_SsHP5Q@mail.gmail.com>
Message-ID: <CAK7LNARk+mpdQhHnQP8pKf8oAqVVkZaQ+cckdRosFCv_SsHP5Q@mail.gmail.com>
Subject: Re: [PATCHv1] kbuild: support W=e to make build abort in case of warning
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 5:46 PM Yann Droneaud <ydroneaud@opteya.com> wrote:
>
> When developing new code/feature, CONFIG_WERROR is most
> often turned off, especially for people using make W=12 to
> get more warnings.
>
> In such case, turning on -Werror temporarily would require
> switching on CONFIG_WERROR in the configuration, building,
> then switching off CONFIG_WERROR.
>
> For this use case, this patch introduces a new 'e' modifier
> to W= as a short hand for KCFLAGS+=-Werror" so that -Werror
> got added to the kernel (built-in) and modules' CFLAGS.
>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---


Applied to linux-kbuild.
Thanks.

>  Makefile                   |  1 +
>  scripts/Makefile.extrawarn | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> Changes since v0[0]:
>
>  - rebase on top of commit 64a91907c896 ("kbuild: refactor scripts/Makefile.extrawarn")
>  - document use case after commit 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
>
> [0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email-ydroneaud@opteya.com/
>
> diff --git a/Makefile b/Makefile
> index 8c7de9a72ea2..6dc621af18d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1649,6 +1649,7 @@ help:
>         @echo  '                1: warnings which may be relevant and do not occur too often'
>         @echo  '                2: warnings which occur quite often but may still be relevant'
>         @echo  '                3: more obscure warnings, can most likely be ignored'
> +       @echo  '                e: warnings are being treated as errors'
>         @echo  '                Multiple levels can be combined with W=12 or W=123'
>         @echo  ''
>         @echo  'Execute "make" or "make all" to build all targets marked with [*] '
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 650d0b8ceec3..f5f0d6f09053 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -2,8 +2,8 @@
>  # ==========================================================================
>  # make W=... settings
>  #
> -# There are three warning groups enabled by W=1, W=2, W=3.
> -# They are independent, and can be combined like W=12 or W=123.
> +# There are four warning groups enabled by W=1, W=2, W=3, and W=e
> +# They are independent, and can be combined like W=12 or W=123e.
>  # ==========================================================================
>
>  KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
> @@ -94,3 +94,12 @@ KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
>  KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
>
>  endif
> +
> +#
> +# W=e - error out on warnings
> +#
> +ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
> +
> +KBUILD_CFLAGS += -Werror
> +
> +endif
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
