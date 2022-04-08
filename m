Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAD54F937B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiDHLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDHLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:08:54 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34ABB9B;
        Fri,  8 Apr 2022 04:06:49 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 238B6C4Q002886;
        Fri, 8 Apr 2022 20:06:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 238B6C4Q002886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649415973;
        bh=s9zrZypxx4qKAoT9NogtuydqAP7a1u09MP+68beU6so=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QuvN0NleKiel2dGU5Dj7jHHvecijHG9FV2ZP9Y9uG0BEdO7kqKh1OC+XGF48L1Mmm
         r1eIi5+KDPfO7v6O1BrGeIv2Iz821R5Aq2G9IghhjJyJ//j4ITDAbPqNvo4DZKAY3X
         waJLY6/lewvx0TLD1kvaXFOnR/Nu2AxYjfSE70Fg3db/Qr2KE1feiDd47+k/6ODvna
         PAT7oB9CxUTyvYV9tuLd7L39tuWV+967mYDi7lBkilcwyWJIhooqCFFIpNeKVIseo5
         Y084bO6jRP+4oMFySyuwVrZ1B2gLJBePtx9fublRvQfnJ0Z9+ZKW5jOCI1HZ5kPd5x
         C0X4zSgi9iA+g==
X-Nifty-SrcIP: [209.85.214.172]
Received: by mail-pl1-f172.google.com with SMTP id f10so7562177plr.6;
        Fri, 08 Apr 2022 04:06:13 -0700 (PDT)
X-Gm-Message-State: AOAM532P/btEYFWdvR8JSJ9ROsqlDainssjVIjRzwBZAf+92qGs/cM0M
        7Y4lySNIFXodUCn8K0tFVnEwaT8pyxZoUh3WCqc=
X-Google-Smtp-Source: ABdhPJxP8QeYtkk/qwK0C/lOHHOdc/P9d4RHR3AGaH4jF8wnNT1livbHCp5/gHaXP+JQJyQVAosuJUloMWH3Oz9W3h4=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr18283886plp.162.1649415972037; Fri, 08
 Apr 2022 04:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com> <20220408084607.106468-1-ydroneaud@opteya.com>
In-Reply-To: <20220408084607.106468-1-ydroneaud@opteya.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 8 Apr 2022 20:05:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
Message-ID: <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
Subject: Re: [PATCHv1] kbuild: support W=e to make build abort in case of warning
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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


I remembered the previous submission, I liked it, but I had lost it.

It seems already 7 years ago, (before I became the Kbuild maintainer).
Thanks for coming back to this.


I like this, but I will wait some time for review comments.









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
