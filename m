Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4EA536A41
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355429AbiE1Cc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiE1Cc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:32:56 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C24F12AB0E;
        Fri, 27 May 2022 19:32:55 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id f14so4167431ilj.1;
        Fri, 27 May 2022 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=B9/k/vYalZlu99Y+0uMJfLSyG8XL3D1qV0fsmg7wW8k=;
        b=lmpl2R8kMj6FJrr+ZbxYA3Ec5/f0QMq2Vqcu4JzdXFQXBpyCEJxNO8J/VyrVIkZW6Y
         A82SLoVdR9sJuugK9SEQ2YKR3C/b19uiqlJmc1lMGybla+FplstTcpj4o/zz3FQNGge7
         zyXAGq4ro6UdZOjhLpYelUivo/a/g56zy9Myz4HYiBO2VAD9P8eh8vXSRGDqWz+8lAN4
         4oRVRSTaf1RoRF9WEXrBWHNJKHyA6511Cmg2upv5D6IhzAQLzFQoxoOvKOt20PxOh2+j
         WQ4LGZ4hqWWPie0NRAzUJi9MyyVP0+Lu8LkYiCldijKQNjK5vI0YyDMIKn/F4vsIXZIO
         lBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=B9/k/vYalZlu99Y+0uMJfLSyG8XL3D1qV0fsmg7wW8k=;
        b=DPBcNtva1S/hILv9g4jWvmB6TgBX7o221F/3CtRLgD4yNcevRfnjwc1WaolnpYkkWn
         fpXufuxVYXoeEhIUv8TOCsGEi+MbgKqumt4S9J3AupP6sr3h+XaJomvr3QF0z3Fyp5UA
         y8QQeGpDTqMZqC0lOBhSUG2jwRGdBWGFd040LPjuyJu6HxgQd1gxNkEOYU7GRP8Njkkl
         arzUd+EX2/jsII4XzD59frgz9ozKbIJXH4JTHCy/pJvGM4uFZKAK4DkQ9oFcWfEQO25b
         PUwnnqCACi/6ZCONVkswSKhJSS3jq8wTF/HqChI83NfaddoNgfjYXBBWU4nYeZ9VVU9q
         LW4w==
X-Gm-Message-State: AOAM530Jjt5le6/E8wRwjH1H1YqtRNgDHzywtXR0RGbekdjRGr+7mEzZ
        6WeyTSjIkRYa/ez/Kz5vX5B4GgJiTv6Sl2s2Rz0=
X-Google-Smtp-Source: ABdhPJwHfUd38QQKGLgQWhy/xoN/+ho5lVQ5i+2NshwjEm3+X5GKjnUhY8Wls0cR6GO03Rd/W9RbALzcxGAmKt9DDnE=
X-Received: by 2002:a05:6e02:174f:b0:2d1:3971:9348 with SMTP id
 y15-20020a056e02174f00b002d139719348mr23734496ill.4.1653705174899; Fri, 27
 May 2022 19:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220527100155.1996314-1-masahiroy@kernel.org> <20220527100155.1996314-2-masahiroy@kernel.org>
In-Reply-To: <20220527100155.1996314-2-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 28 May 2022 04:32:19 +0200
Message-ID: <CA+icZUX_xeZ8k-3YZppGbuYzeypU8f_iz_-tuMJ1bg0dhikH8A@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] kbuild: replace $(linked-object) with CONFIG options
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, llvm@lists.linux.dev,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 1:56 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> *.prelink.o is created when CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT
> is enabled.
>
> Replace $(linked-object) with $(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT)
> so you will get better idea when the --link option is passed.
>
> No functional change is intended.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Hi Masahiroy,

I was not CCed on the cover-letter and only on some patches in this series.

So, I have re-tested this series by pulling from kbuild.git#kbuild
(saw later you renewed the parisc/nm patch).

While testing my selfmade LLVM version 14.0.4 (PGO + ThinLTO
optimized) toolchain I included this series.

Just built fine and I was able to boot on bare metal.

-Sedat -

> ---
>
> Changes in v7:
>   - New patch
>
>  scripts/Makefile.build | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 06400504150b..f80196eef03a 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -219,7 +219,7 @@ objtool_args =                                                              \
>         $(if $(CONFIG_STACK_VALIDATION), --stackval)                    \
>         $(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)          \
>         --uaccess                                                       \
> -       $(if $(linked-object), --link)                                  \
> +       $(if $($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT)), --link)    \
>         $(if $(part-of-module), --module)                               \
>         $(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
>
> @@ -284,7 +284,6 @@ quiet_cmd_cc_prelink_modules = LD [M]  $@
>  # modules into native code
>  $(obj)/%.prelink.o: objtool-enabled = y
>  $(obj)/%.prelink.o: part-of-module := y
> -$(obj)/%.prelink.o: linked-object := y
>
>  $(obj)/%.prelink.o: $(obj)/%.o FORCE
>         $(call if_changed,cc_prelink_modules)
> --
> 2.32.0
>
