Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837934C2442
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiBXG6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiBXG6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:58:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80461BB71A;
        Wed, 23 Feb 2022 22:58:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so2297284ejc.7;
        Wed, 23 Feb 2022 22:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hypa21N0zanMgGLH9mohM/n3Ow6quteAnbWgQTT26/U=;
        b=H6U3HtHgGRz2L//QixHDUgzuArG/Q7+kUivaHj7KiwedSetjfLBSkg+h2yODOxyElI
         2nhkXulqaF52wrQQiOntznuzVSzTy0oKqyqJPSGL6pX92K1EAeFnkhAWdPa+P98iSosV
         qFS/kzGWBiz/EAdAfNVuq9zH6rmIPb2mPpQy6w8InjS6mNBSkOzR3IflLdSup03kHmQn
         TaB+anImJVW97zxTA8LF+dtqNLs4BYb/9JN4d3Ac11A6qDEec6hsegEhM9sELv4IqwDO
         MRVXSigXngdZ/9Lt21XjcKCjs/rPQHSKWnRiWn2kIL+Fxm2AmvDExxgP/59rIFYc9Val
         40AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hypa21N0zanMgGLH9mohM/n3Ow6quteAnbWgQTT26/U=;
        b=nHSCPHXKrV4cAuddDkJZCdL1PNe/rslD2qj7RY3JsB8tydHiGcFJ03iKQuGSoZQg5k
         xUhR44xzuo57Z66UNPm8kGaBFWDND45iNSXNhC8TljchOCp9OFr+3j86fTAcdWCONu4d
         uNgQKo4XjL4B+H1Q61ypr3WIKkfODDH4n08muqIMNL59sI3mhKtiEJ6yGyQO7zvrS6CP
         gsMlIUMBXbIwvAaHPLRp7bH02hafBz9O16DZA1dyqAg7DxRaLk5jfSv2Y9OzmWhvppG5
         EWIngIBa9PWjh3Or1AxSAMuvs8ATImawL7jU8gHaU1eC/kVVR0zBoVNkeYyzVJYQ+1x4
         eb8Q==
X-Gm-Message-State: AOAM532XoTOkmKm9rzLdvpFerRPIxe9nI4Z2a6JEI9JdBEOjQxygEaRV
        EcHobtGagImN5YZT/6sqRtHnMorXTIfnl5ge5wtVHR36
X-Google-Smtp-Source: ABdhPJwYFcDH2SXZ4L+ec75eSKAj5w9jFfMpcDMGySXG+r2pHVWijv8yey0wye/S8VWaDd0gUUk16Kxydx5YZr/l1Ug=
X-Received: by 2002:a17:907:3c12:b0:6cf:37d0:a551 with SMTP id
 gh18-20020a1709073c1200b006cf37d0a551mr1141531ejc.38.1645685892323; Wed, 23
 Feb 2022 22:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20220224060503.1856302-1-keescook@chromium.org>
 <CAMo8BfJFJE-n3=AF+pb9_6oF3gzxX7a+7aBrASHjjNX5byqDqw@mail.gmail.com> <202202232239.FF2343D42@keescook>
In-Reply-To: <202202232239.FF2343D42@keescook>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 23 Feb 2022 22:58:00 -0800
Message-ID: <CAMo8BfLU-BLRnp=fmmQkTckxPq1vkSZeOwfgiSW06L0+H+EDJA@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Implement "current_stack_pointer"
To:     Kees Cook <keescook@chromium.org>
Cc:     Chris Zankel <chris@zankel.net>, Marc Zyngier <maz@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Feb 23, 2022 at 10:22:59PM -0800, Max Filippov wrote:
> > On Wed, Feb 23, 2022 at 10:05 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > To follow the existing per-arch conventions replace open-coded uses
> > > of asm "sp" as "current_stack_pointer". This will let it be used in
> > > non-arch places (like HARDENED_USERCOPY).
> > >
> > > Cc: Chris Zankel <chris@zankel.net>
> > > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: linux-xtensa@linux-xtensa.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/xtensa/Kconfig                  | 1 +
> > >  arch/xtensa/include/asm/current.h    | 2 ++
> > >  arch/xtensa/include/asm/stacktrace.h | 2 +-
> > >  arch/xtensa/kernel/irq.c             | 3 +--
> > >  4 files changed, 5 insertions(+), 3 deletions(-)
> >
> > Acked-by: Max Filippov <jcmvbkbc@gmail.com>
>
> Thanks! And apologies, my cross-compiler tricked me into thinking this
> patch compiled without problems. It did, however. I've change the patch
> slightly to deal with the needed casts:
>
> diff --git a/arch/xtensa/include/asm/stacktrace.h b/arch/xtensa/include/asm/stacktrace.h
> index fe06e8ed162b..a85e785a6288 100644
> --- a/arch/xtensa/include/asm/stacktrace.h
> +++ b/arch/xtensa/include/asm/stacktrace.h
> @@ -19,14 +19,14 @@ struct stackframe {
>
>  static __always_inline unsigned long *stack_pointer(struct task_struct *task)
>  {
> -       unsigned long *sp;
> +       unsigned long sp;
>
>         if (!task || task == current)
> -               __asm__ __volatile__ ("mov %0, a1\n" : "=a"(sp));
> +               sp = current_stack_pointer;
>         else
> -               sp = (unsigned long *)task->thread.sp;
> +               sp = task->thread.sp;
>
> -       return sp;
> +       return (unsigned long *)sp;
>  }
>
>  void walk_stackframe(unsigned long *sp,
>
> Shall I send a v2, or just carry this fix in my tree?

This additional change looks good to me, if you could
fold it into the original patch that'd be perfect. But separate
patch would also work.

-- 
Thanks.
-- Max
