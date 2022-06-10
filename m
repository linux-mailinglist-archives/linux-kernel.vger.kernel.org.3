Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0916E547031
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbiFJXoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351204AbiFJXoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:44:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4623F466D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:44:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w20so731564lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LsNMVk4QkQcHLkW7ut/k0O0Yaykk6wclPSmWZ5ifsY=;
        b=AXZAoRjCkVTGzxCFmAzh/oJWaoE94oMVuck4U6PkHFXm8Manqvzoox91KP0798a6Vm
         Iif2fnd5/zxMLU0WowWFmFD02PIvRdYbdM8AOKWN07FLf7W3i8ZgvaVIN6ZqOrxJi+Q+
         SNwkOFBnJdiJ/iMD4ZIHySibtDyYLWJnDV2Jl+l/OlObxnNJPZ+Gp3oKP77OD8CHjZwZ
         K23us6sh34xesB0jnd7qxO7B7+aQb/9BDyvvn90C40zKoUSvdukZv2F1wed/pqp4HhyW
         RyYE0sGw1Hex9gbwwYSWvCdaNw4UJ2EJraztGTA91vxlzFCYZr6g/lyW+aOzEEe+E3Xp
         PqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LsNMVk4QkQcHLkW7ut/k0O0Yaykk6wclPSmWZ5ifsY=;
        b=q2Tlmx31wTIKf/pTX4xpCmPH+r79/0NYPkPCYpPmMYpxoQ3XPdREsPLoEvc4LU3ffs
         OZ+RowmA71PDYazhEYsBS13Ga+qUoX7a8hj1XBop94UTXs3+aQQYfKLhsB6Bm77ev8CQ
         4nMAhXDxka5LVy5eJQkyWg+/JtqBlLELlHIg4moL+1ZmUGlD5etRef7tcN7APSqQX5AR
         iw+KQwcdORUzS5+AapGdpF8lYjwdXyL32bCv81rSRQ62aKRGmjBeYwwgNP7rmH/g1Ev1
         wRPePQteshvXLPrq0gjzD1G2WXl36/5VNklqvj6C7MCcboI+Uoft3lYkBSc1XS3PHgRn
         tObg==
X-Gm-Message-State: AOAM532h4W9iapbBe99giOwO1f8qyQYw38Unb9A6ygw3AdKyGbUAZuMs
        0f5LvJBd3k02rari9l1nZ+DIKpPHr6064tZtPX91dw==
X-Google-Smtp-Source: ABdhPJzmnqMLhs1bfP/6LgEEcErMYRF7zruVcTTGgghAvhoIJQutFqUZdi12symO64L5cd0aKgb51yl0Fh7DWLzLDco=
X-Received: by 2002:a05:6512:3f94:b0:478:7abe:de4a with SMTP id
 x20-20020a0565123f9400b004787abede4amr63212721lfa.401.1654904641567; Fri, 10
 Jun 2022 16:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com> <20220610233513.1798771-8-samitolvanen@google.com>
In-Reply-To: <20220610233513.1798771-8-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Jun 2022 16:43:50 -0700
Message-ID: <CAKwvOd=GRwL6K7GxhiLhRhJVaD3a1VT6MD5fMR4kcYPpd5=0PQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/20] lkdtm: Emit an indirect call for CFI tests
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 4:35 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Clang can convert the indirect calls in lkdtm_CFI_FORWARD_PROTO into
> direct calls. Move the call into a noinline function that accepts the
> target address as an argument to ensure the compiler actually emits an
> indirect call instead.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  drivers/misc/lkdtm/cfi.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> index 666a7f4bc137..b6b375112a2a 100644
> --- a/drivers/misc/lkdtm/cfi.c
> +++ b/drivers/misc/lkdtm/cfi.c
> @@ -20,6 +20,13 @@ static noinline int lkdtm_increment_int(int *counter)
>
>         return *counter;
>  }
> +
> +/* Don't allow the compiler to inline the calls. */
> +static noinline void lkdtm_indirect_call(void (*func)(int *))
> +{
> +       func(&called_count);
> +}
> +
>  /*
>   * This tries to call an indirect function with a mismatched prototype.
>   */
> @@ -29,15 +36,11 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>          * Matches lkdtm_increment_void()'s prototype, but not
>          * lkdtm_increment_int()'s prototype.
>          */
> -       void (*func)(int *);
> -
>         pr_info("Calling matched prototype ...\n");
> -       func = lkdtm_increment_void;
> -       func(&called_count);
> +       lkdtm_indirect_call(lkdtm_increment_void);
>
>         pr_info("Calling mismatched prototype ...\n");
> -       func = (void *)lkdtm_increment_int;
> -       func(&called_count);
> +       lkdtm_indirect_call((void *)lkdtm_increment_int);
>
>         pr_err("FAIL: survived mismatched prototype function call!\n");
>         pr_expected_config(CONFIG_CFI_CLANG);
> --
> 2.36.1.476.g0c4daa206d-goog
>


-- 
Thanks,
~Nick Desaulniers
