Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1864E65EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347796AbiCXPUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiCXPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4608148322
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D63B0617B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A26C340ED;
        Thu, 24 Mar 2022 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648135115;
        bh=Ml/tHPbe2zU2+0ldVRiam6quUBs/j+WDsFnjNccGLgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGOvaG/iuWm7NfreHvlgk/5oCqJWWQK7rlNntLyOqdbxt6x09bczGQ9A9jWJ1Rbs6
         RpyuGdoDdWcmImEHs3lXXUfwACVfLIwlLVdo0CLsJkbYt2BiVGkuYnD4US8ZW/SR+7
         ILzTCr8V/I7zBQs8TvypU5CaYXP1XFPd6K6YWCM4H1yFS3TMZbZAmJNnmIUVpRVPV+
         AxAFY6J+MfhosCtG4pAs3/E58+krp8AyhTs63UF5h/m4DDLTUbNvpb77Aak8B4OMKM
         crR9HJPW8sDveivFgJTqve1Ln1koAcUx7QchvO86l5rLJeRzm5CjSpWCnlROA34wPH
         Wk7LcQI0N5WcQ==
Date:   Fri, 25 Mar 2022 00:18:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ARM: kprobes: Make __kretprobe_trampoline as a pure asm
 function
Message-Id: <20220325001831.e363577abe647f99b0714be8@kernel.org>
In-Reply-To: <CAMj1kXFtrogyse1MOF1KDBuYwtxNDvCu3rF=o7b__83Lu6Fj4A@mail.gmail.com>
References: <20220315182558.1a056d8b3975932f6589b60f@kernel.org>
        <164733793626.1008610.12121025094280924953.stgit@devnote2>
        <20220324152108.b6016621dd6b8297eddd6bb5@kernel.org>
        <20220324222322.9f59df377b01856f2230a4ea@kernel.org>
        <CAMj1kXFtrogyse1MOF1KDBuYwtxNDvCu3rF=o7b__83Lu6Fj4A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, 24 Mar 2022 14:34:46 +0100
Ard Biesheuvel <ardb@kernel.org> wrote:

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

Yes, I confirmed this works too :-)

Can you send the patch with my Tested-by ?

Thank you!

> 
> 
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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
