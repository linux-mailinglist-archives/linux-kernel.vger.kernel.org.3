Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BAE4F45B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbiDEUWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457787AbiDEQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:49:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C155EF7B7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:47:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b17so16620816lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEhM/YV2YdBzzmeRnY7JhZnKZDh2nVlggSS8Y2uY7lI=;
        b=sUVpCDJQ8J/CRA8PR7PPY48C1InS+CQhJSLs1znkm7e//MzZx9EXf2LdEMJsgySE3X
         Y8yxY0zXSYvL37Y/zNyAFZTYibEv8PqrpTwowl0xMd7/zBmORHLrvr41WRd83ZkSdD4o
         e1sQVHSRRQmyx7w9vUVqaBe27zEFh616QD5fSO6hNEt0/0ownUdzSGXXrK6GKyNF5I/3
         hTsLFm9HbeGonYTzD9z9irJeAfu1Th/QWskdyJ6P0ysm/PVhc2BC+IZifkws8aNTKJZA
         wjcNCK8Nt6GGzIVo2gAti0iJSH5ytX7DUJQc6A3NnlxRQz0Udzg+BOyLgUXRgnYDlQUQ
         60IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEhM/YV2YdBzzmeRnY7JhZnKZDh2nVlggSS8Y2uY7lI=;
        b=6KPU0EtgSjCncZ6w0a2mDrMZmeS9wrFpC6ivgDj4S2LAskUVm9lCP5kCTEO8H71lIy
         f6lNac84H4iJjLZbjEBIl4jrKWZgYvVJE9JzLrrW26AmC+zHOVs114zem0CTTWbDbRd7
         jfJQxNaEGlfIvuQsPyctEJd1wZsgxmOJhiJ69lQlCCwlI4z+0JQxQJQGKH20bx+GpbHL
         wnfPkVNqXSUAD0RwhiPpiSGr3XM3gHQ8zcL0fGW1jQNVsNpNJaiehbm2mN+LYbeBYxex
         h+0ptx21kcg/z3DSgjUZzU5dFKBT+8XRhvYrUxaiJb9VtoUHOLL4lRVmi8wYYuPWukhU
         4aPg==
X-Gm-Message-State: AOAM533nvbjYwKrF6Y9Tg7RaeAQVVQ1lGGb1bLzMkiTMqGOroKLaDdFe
        7CGpySrvDJfk0MpUy13yDv/j9C84VTkTrjjDyXb4eQ==
X-Google-Smtp-Source: ABdhPJyKkxCjonnx/UVgfMj7EGt2uj4XEQygSAlfsJv6l51yF47d09NTJ20QL1Rq0QmtacVYXuZbQrURhJ4NW2FaMn0=
X-Received: by 2002:a05:6512:33d4:b0:44a:9971:de48 with SMTP id
 d20-20020a05651233d400b0044a9971de48mr3211524lfg.392.1649177235321; Tue, 05
 Apr 2022 09:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220405113359.2880241-1-masahiroy@kernel.org> <20220405113359.2880241-11-masahiroy@kernel.org>
In-Reply-To: <20220405113359.2880241-11-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Apr 2022 09:47:04 -0700
Message-ID: <CAKwvOd=cEDiS-XUpGFiF=7uaJSKPmkxK4bv37cr5uHgwC_M3TQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] kbuild: refactor cmd_modversions_S
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
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

On Tue, Apr 5, 2022 at 4:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Split the code into two macros, cmd_gen_symversions_S for running
> genksyms, and cmd_modversions for running $(LD) to update the object
> with CRCs.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>   - new
>
>  scripts/Makefile.build | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index ba2be555f942..58be0997c5dd 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -274,7 +274,8 @@ define rule_as_o_S
>         $(call cmd_and_fixdep,as_o_S)
>         $(call cmd,gen_ksymdeps)
>         $(call cmd,gen_objtooldep)
> -       $(call cmd,modversions_S)
> +       $(call cmd,gen_symversions_S)
> +       $(call cmd,modversions)
>  endef
>
>  # Built-in and composite module parts
> @@ -366,16 +367,8 @@ ifdef CONFIG_ASM_MODVERSIONS
>  # versioning matches the C process described above, with difference that
>  # we parse asm-prototypes.h C header to get function definitions.
>
> -cmd_modversions_S =                                                            \
> -       if $(OBJDUMP) -h $@ | grep -q __ksymtab; then                           \
> -               $(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))  \
> -                   > $(@D)/.tmp_$(@F:.o=.ver);                                 \
> -                                                                               \
> -               $(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@               \
> -                       -T $(@D)/.tmp_$(@F:.o=.ver);                            \
> -               mv -f $(@D)/.tmp_$(@F) $@;                                      \
> -               rm -f $(@D)/.tmp_$(@F:.o=.ver);                                 \
> -       fi
> +cmd_gen_symversions_S = $(call gen_symversions,S)
> +
>  endif
>
>  $(obj)/%.o: $(src)/%.S FORCE
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
