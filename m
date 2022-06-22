Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BDC5552D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376283AbiFVRvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358522AbiFVRvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:51:16 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58C33A24
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:51:14 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id z66so3086830vsb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng/df5AftYa6HouAx68+qKADaV8l9xif0UQWBG3KtHk=;
        b=bL4IUZSpTnsYqnliL9bS194bN1A3mRHAFyjqbzWhVGQjCNEoIMYjrVwIvu98Oe25r+
         1huKFJ9VYYCFmnU7KVcBaFVNfyJmhSymMGEnQ+zP0qkNRhSX1a1gG0HHCgqxJJNX/jmI
         yXTPQ6nhY15dm6W20jAPX6yyh/Lep/4dyUFULHP1TLtb6U+5Cjv3dJNx/v418lDe/fpB
         yNd8/Hmok6M752zjM4/X/QTG8L/akhbe98K1A/cIEe54azM0dcMAIba9vW+PGH5Lkpvw
         YHNGNtVdztM5ihHMfExXWJhki44ubcyTAJ92XCwjFk4QSMPa2PGGhgG8VCms8/+09oFW
         VQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng/df5AftYa6HouAx68+qKADaV8l9xif0UQWBG3KtHk=;
        b=N9dkQ6Cttzx9hrEiBmFYLLUGS2EYFJhwxKqNScyzHqZ6GZ9Y3cNQ00JGi4aD7qNuyX
         CtYtcAVVx/8qTjifdcZ2ipO4g6vlkJX7scMEF0D3RshvXd4hZIhRodyb3qh+wOIfWkAb
         7L13vZf7zLq4sKG/MjKx7oRNpLijycokHjoxNVUH+cm9OrvhdjMShWULl2Jj9PWpB0RQ
         t6A9ACUaKJRtvZyh/e5YFfreJQ+5SATGK0fgsAfIJnrXBupuLsmWVT8TKpQcqVSTPXM9
         +6KsTSR9ss4b0pRdyFPO4UMODPRCEKT9dY2UyZGwgZFNN5yquRMaWvdA0gyKTjxityUk
         /hqw==
X-Gm-Message-State: AJIora/vln/7DFvB8uQBTnKCkC/ZnkVNO0cHAZ20aaLqMNcgLJqW+iqB
        YnA1vTwMA+prbjlxxB9rWMqlo4d9jkLv0ybeBdFyig==
X-Google-Smtp-Source: AGRyM1uIY5SMK3ycziyQoTmBUYCUPwLRKShJz9vdMkmKghmb2/4LehImyRPhd2kqCW78SaT8N80kJ+mErUahn4bhY8M=
X-Received: by 2002:a05:6102:1044:b0:354:550e:4f15 with SMTP id
 h4-20020a056102104400b00354550e4f15mr3585283vsq.54.1655920273622; Wed, 22 Jun
 2022 10:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBRVF9qmxKFgmjZpzN3tx=U+_8udECMLHs7BrtzfPwmuhQ@mail.gmail.com>
 <YqyVFsbviKjVGGZ9@worktop.programming.kicks-ass.net>
In-Reply-To: <YqyVFsbviKjVGGZ9@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 22 Jun 2022 19:51:02 +0200
Message-ID: <CABPqkBRRFhPcYL25TX6H7vWN=VKNR2+8e2_sO01Pka_R625Lqw@mail.gmail.com>
Subject: Re: [RFC] pr_warn_once() issue in x86 MSR extable code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, jpoimboe@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>
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

Hi Peter,

Thanks for taking a quick look at this.
I am currently OOO and I cannot test this proposed patch.
I am okay with your suggestion.

Thanks.

On Fri, Jun 17, 2022 at 4:52 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 17, 2022 at 02:08:52PM +0300, Stephane Eranian wrote:
> > Hi,
> >
> > Some changes to the way invalid MSR accesses are reported by the kernel is
> > causing some problems with messages printed on the console.
> >
> > We have seen several cases of ex_handler_msr() printing invalid MSR
> > accesses once but
> > the callstack multiple times causing confusion on the console.
> >
> > The last time the exception MSR code was modified (5.16) by PeterZ was:
> >
> >   d52a7344bdfa x86/msr: Remove .fixup usage:
> >
> >   if (!safe && wrmsr &&  pr_warn_once("unchecked MSR access error: ..."))
> >                show_stack_regs(regs);
> >
> > Note that this code pattern was also present, though in a different
> > form, before this commit.
> >
> > The problem here is that another earlier commit (5.13):
> >
> > a358f40600b3 once: implement DO_ONCE_LITE for non-fast-path "do once"
> > functionality
> >
> > Modifies all the pr_*_once() calls to always return true claiming that
> > no caller is ever
> > checking the return value of the functions.
> >
> > This is why we are seeing the callstack printed without the associated
> > printk() msg.
> >
> > I believe that having the pr_*_once() functions return true the first
> > time they are called
> > is useful especially when extra information, such as callstack, must
> > be printed to help
> > track the origin of the problem.
> >
> > The exception handling code seems to be the only place where the
> > return value is checked
> > for pr_warn_once(). A minimal change would be to create another
> > version of that function
> > that calls DO_ONCE() instead of DO_ONCE_LITE(), e.g., pr_warn_once_return().
> >
> > I can post a patch to that effect if we all agree on the approach.
> >
> > Thanks.
>
> How about something like this?
>
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index dba2197c05c3..331310c29349 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -94,16 +94,18 @@ static bool ex_handler_copy(const struct exception_table_entry *fixup,
>  static bool ex_handler_msr(const struct exception_table_entry *fixup,
>                            struct pt_regs *regs, bool wrmsr, bool safe, int reg)
>  {
> -       if (!safe && wrmsr &&
> -           pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
> -                        (unsigned int)regs->cx, (unsigned int)regs->dx,
> -                        (unsigned int)regs->ax,  regs->ip, (void *)regs->ip))
> +       if (__ONCE_LITE_IF(!safe && wrmsr)) {
> +               pr_warn("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
> +                       (unsigned int)regs->cx, (unsigned int)regs->dx,
> +                       (unsigned int)regs->ax,  regs->ip, (void *)regs->ip);
>                 show_stack_regs(regs);
> +       }
>
> -       if (!safe && !wrmsr &&
> -           pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
> -                        (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
> +       if (__ONCE_LITE_IF(!safe && !wrmsr)) {
> +               pr_warn("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
> +                       (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
>                 show_stack_regs(regs);
> +       }
>
>         if (!wrmsr) {
>                 /* Pretend that the read succeeded and returned 0. */
> diff --git a/include/linux/once_lite.h b/include/linux/once_lite.h
> index 861e606b820f..63c3bbcef694 100644
> --- a/include/linux/once_lite.h
> +++ b/include/linux/once_lite.h
> @@ -9,15 +9,27 @@
>   */
>  #define DO_ONCE_LITE(func, ...)                                                \
>         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
> -#define DO_ONCE_LITE_IF(condition, func, ...)                          \
> +
> +#define __ONCE_LITE_IF(condition)                                      \
>         ({                                                              \
>                 static bool __section(".data.once") __already_done;     \
> -               bool __ret_do_once = !!(condition);                     \
> +               bool __ret_cond = !!(condition);                        \
> +               bool __ret_once = false;                                \
>                                                                         \
>                 if (unlikely(__ret_do_once && !__already_done)) {       \
>                         __already_done = true;                          \
> -                       func(__VA_ARGS__);                              \
> +                       __ret_once = true;                              \
>                 }                                                       \
> +               unlikely(__ret_once);                                   \
> +       })
> +
> +#define DO_ONCE_LITE_IF(condition, func, ...)                          \
> +       ({                                                              \
> +               bool __ret_do_once = !!(condition);                     \
> +                                                                       \
> +               if (__ONCE_LITE_IF(__ret_do_once))                      \
> +                       func(__VA_ARGS__);                              \
> +                                                                       \
>                 unlikely(__ret_do_once);                                \
>         })
>
