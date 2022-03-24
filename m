Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BB4E642A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350469AbiCXNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344983AbiCXNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61557A8EEB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E72A461378
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B0BC340F3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648128967;
        bh=H1yVe7fzkO0/y1JjqU0c9Jl4rZ+MCGTqLHyYO6Uh5MU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dHlwj9Uz5kPNUbJKWQmyWlCyVD8eT6pQHBgtzaEblnUHHyvKCMdUPVlCYcRwYZ0A/
         K5A4Zfq4o1Pc8gmMyFMMzJMW/dda57f30B0E1Jn3FkuIlkiKBuGkJ/AFLjsFf8eISA
         FsHwWBEIjhcUBt539ThP6v3L5kVC6Jbm7Nnx33pMvs9llKfD79prLkCf5QSaAisNea
         6joHRM9vj9fWIsvwIGLapiSYa846qd8nBWDOJsThUq9PDF/IdPZ7WzlPOwpWyJwBYy
         wJGvYeLSjcBfV4/9Bocc0EOaYbh0eiL67X5nU1zNhLNSMUwVeQ+aiRVpTEGU9necGU
         MsOZ4/YEUvjxw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-de2cb87f6aso4911915fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:36:07 -0700 (PDT)
X-Gm-Message-State: AOAM5329L4EhdrSEfUhXa1IAb0VFt4tly2uxFJwjJ4NonUpWktSjJnbf
        MRnW80+SBh+AAGIdLp5BlRcMPpOezjiS/4FyhaE=
X-Google-Smtp-Source: ABdhPJxOQXfjHu0ygYEA53tljUNFsMfu22U/5M60LmszJvI+WhERfoDbTaeOOcPe6q8GgRV0IcfVMHZzGsKgNpORFk4=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr2484729oae.126.1648128966439; Thu, 24
 Mar 2022 06:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220315182558.1a056d8b3975932f6589b60f@kernel.org>
 <164733793626.1008610.12121025094280924953.stgit@devnote2>
 <20220324152108.b6016621dd6b8297eddd6bb5@kernel.org> <20220324222322.9f59df377b01856f2230a4ea@kernel.org>
 <CAMj1kXFtrogyse1MOF1KDBuYwtxNDvCu3rF=o7b__83Lu6Fj4A@mail.gmail.com>
In-Reply-To: <CAMj1kXFtrogyse1MOF1KDBuYwtxNDvCu3rF=o7b__83Lu6Fj4A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Mar 2022 14:35:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGHbQq0dU1KwD4VJMMZ+LOhaXXvZC6anTGuX3KmT34tMw@mail.gmail.com>
Message-ID: <CAMj1kXGHbQq0dU1KwD4VJMMZ+LOhaXXvZC6anTGuX3KmT34tMw@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: Make __kretprobe_trampoline as a pure asm function
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 at 14:34, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -377,7 +377,7 @@ void __naked __kprobes __kretprobe_trampoline(void)
>  {
>         __asm__ __volatile__ (
>  #ifdef CONFIG_FRAME_POINTER
> -               "ldr    lr, =__kretprobe_trampoline     \n\t"
> +               "ldr    lr, .L__kretprobe_trampoline    \n\t"
>         /* __kretprobe_trampoline makes a framepointer on pt_regs. */
>  #ifdef CONFIG_CC_IS_CLANG
>                 "stmdb  sp, {sp, lr, pc}        \n\t"
> @@ -407,6 +407,11 @@ void __naked __kprobes __kretprobe_trampoline(void)
>                 "bx     lr                      \n\t"
>  #else
>                 "mov    pc, lr                  \n\t"
> +#endif
> +#ifdef CONFIG_FRAME_POINTER
> +               ".align 2                       \n\t"
> +       ".L__kretprobe_trampoline:              \n\t"
> +               ".long  __kretprobe_trampoline  \n\t"
>  #endif
>                 : : : "memory");
>  }
>
>

Pardon the copy/paste error.

> What about the below?

was meant to refer to the diff above.


> On Thu, 24 Mar 2022 at 14:23, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 24 Mar 2022 15:21:08 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > > Hi,
> > >
> > > I found a better solution for this issue from Ard :-)
> > >
> > > https://lore.kernel.org/all/20220203082204.1176734-6-ardb@kernel.org/T/#u
> > >
> > > I should use mov_l instead of ldr for loading the symbol address.
> >
> > Hm, these macros are only for the pure assembly file (.S), so we have to
> > split this in a asm file to use that.
> >
>
>
> What about the below?
