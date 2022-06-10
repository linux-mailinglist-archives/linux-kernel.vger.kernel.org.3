Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A24A547017
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349483AbiFJXke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349266AbiFJXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:40:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03FE12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:40:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d19so655169lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TS2dWkXH8XlZd5sL60zfsL+sc90yCJgLJMyjv2lHnXE=;
        b=oHik6Hczo89wBPZ/dDgD5TFhvpe+fyOMAOoTAMjJs65nr0gDLGEPoSsraJU0Q7oOtM
         O2ukn6J/kan5d1pizuTACOyL4AJMqq0TFSLAp9Nt2lKgu3kqQZW9UxvT0qNjLOLxVo2L
         VdOGNPR6TPWNd/CtXdpIJ7N2EBt48nIvTZG9aKik7rJCTjhAkUV4z93XCIDKCDjjb4xr
         Eka0ieDZibKew3gntWlhI1epJPmtu91/TEYdSYVyLPLxmXVPx/Ud5NTxrwHMoq7M8LXI
         Yay127WCX0aUnUu0ll1oXJYUbRIJB+uwqsk/wtall2ha0sXClujatVgr8lf3Ylw7R7On
         8Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TS2dWkXH8XlZd5sL60zfsL+sc90yCJgLJMyjv2lHnXE=;
        b=Hjxe5q+tPIohv5QyaRwUKfb7JDV4/HlwWBpl9d4Gh1oDmJ/yS6C+I6uV4Nd5TCSL53
         v3nAXx8udVwaIq4A7GXeHPuSKkQ/v3QEJg1g/spZ2Z7QJiwAiC/UUAY39PRouXJs/cS1
         ucdAVuINry/geopetc0dsxftDJM3Il6WFJh3Yg47w8sA6ZlSyRYpek1f/xmZxzWVlld4
         Gm9KOXT6UcuYFBgaOVQbqFqJsro/OBzVtUrQmGhwBNAtrkdvcPmSKX5Fi4ofxbDUfojd
         fMxlcxExF5KMLYlUMQYtpAsJvfMuezCmeYGcZzJU4KrcyMJhgl4xiT/oimUeoyichCLk
         jbbQ==
X-Gm-Message-State: AOAM532zPHT3+yA53HXrQaRoo+CIOEmpnCTnMQ4bUXyiD47hE79q8tzU
        CL5dINu16OgNdQc/YvKY24OnoNpn77R+GX93houJkQ==
X-Google-Smtp-Source: ABdhPJw86FbfqG8WmSA2UZEs9tshGtQTRPcCpdyUo1Eq8v8++ykofWmHBq3OGcBcqBQ711Hi3BEoaiAVfzLB2UfnGtw=
X-Received: by 2002:a2e:7802:0:b0:258:e918:23f0 with SMTP id
 t2-20020a2e7802000000b00258e91823f0mr2695378ljc.400.1654904427866; Fri, 10
 Jun 2022 16:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com> <20220610233513.1798771-17-samitolvanen@google.com>
In-Reply-To: <20220610233513.1798771-17-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Jun 2022 16:40:16 -0700
Message-ID: <CAKwvOdm1Abmu+NQ82ZLgX3O5g4vYPni23A9c4FJ+xeSYVwPtJw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 16/20] kallsyms: Drop CONFIG_CFI_CLANG workarounds
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
> With -fsanitize=kcfi, the compiler no longer renames static
> functions with CONFIG_CFI_CLANG + ThinLTO. Drop the code that cleans
> up the ThinLTO hash from the function names.

Good riddance!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/kallsyms.c | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index fbdf8d3279ac..2fbb94817e02 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -179,7 +179,6 @@ static bool cleanup_symbol_name(char *s)
>          * character in an identifier in C. Suffixes observed:
>          * - foo.llvm.[0-9a-f]+
>          * - foo.[0-9a-f]+
> -        * - foo.[0-9a-f]+.cfi_jt
>          */
>         res = strchr(s, '.');
>         if (res) {
> @@ -187,22 +186,6 @@ static bool cleanup_symbol_name(char *s)
>                 return true;
>         }
>
> -       if (!IS_ENABLED(CONFIG_CFI_CLANG) ||
> -           !IS_ENABLED(CONFIG_LTO_CLANG_THIN) ||
> -           CONFIG_CLANG_VERSION >= 130000)
> -               return false;
> -
> -       /*
> -        * Prior to LLVM 13, the following suffixes were observed when thinLTO
> -        * and CFI are both enabled:
> -        * - foo$[0-9]+
> -        */
> -       res = strrchr(s, '$');
> -       if (res) {
> -               *res = '\0';
> -               return true;
> -       }
> -
>         return false;
>  }
>
> --
> 2.36.1.476.g0c4daa206d-goog
>


-- 
Thanks,
~Nick Desaulniers
