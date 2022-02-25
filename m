Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B4B4C3C69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiBYD16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBYD1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:27:55 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97EC3E5CC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:27:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x18so3587769pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BgI2EJuSIzpOUNhctfjPqGhg508IvCLj61p7UGXcDW4=;
        b=lnKKEF71GQwLLk6L1Cb6CNm+zcjt5wSJXZcyPvZTpzRaRW24kN1PVpPd4tkvK4XtEq
         7OX5O5GAwUxP0NaDnJjpSp86bLWJECVKJqdcmoPKPkry6Yrt0GvX7Ef+VaLZRQa0F6X6
         IRVfTt/yCRIk+JZECaZqjcPTM31K9Qto1XGWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgI2EJuSIzpOUNhctfjPqGhg508IvCLj61p7UGXcDW4=;
        b=7IOITWBQ0Ngn4XSpqqKt6Ez1nW1iOKUq36NFGlkNcT44mwhDq2NIpfAy/x4ncelp+S
         YUAjupK3hMlRpOjWEX1+Y8QwK2I11a0O4BSF9dT9PEVHsPfPw6n8dCxggYddxpyD10on
         tGR6qVfxrVfm8JCqHe3Zmev0k9UfmyhdTsvFxdgq01nKZ/YBoM9seJKtCybUSqLiO2UH
         FvwaGjuHaBLbEIWTaBCwl2awFJe7y7QeEVW1aNUEuM93H2VMwFL/TFysNF+g0AbvnLNx
         W/a3US/LqxDA3kNhlpXi6UGUDzWZKga9qCV/AmnvkrFru9Y18gNv7xQoBMsk7JbE1MGc
         eAnA==
X-Gm-Message-State: AOAM531rWBKpcNrLnne2Ys2H/+NrZH7nRAXJMO1XO2tXJE6wGSbcqCrs
        3W8LXLJGkMfwd9uL6fbpFvumxA==
X-Google-Smtp-Source: ABdhPJw5ZZGF3Ss2gSpUb3HF2rJY1bntT7qQO5JeESYzYRqkYyAZEp30+JzL3ijQKwxRW4jmryxJzg==
X-Received: by 2002:a05:6a00:24c4:b0:4cb:7324:bfd with SMTP id d4-20020a056a0024c400b004cb73240bfdmr5899295pfv.60.1645759643482;
        Thu, 24 Feb 2022 19:27:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y191-20020a638ac8000000b0036c7329efadsm840783pgd.65.2022.02.24.19.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 19:27:23 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:27:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>, Marc Zyngier <maz@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xtensa: Implement "current_stack_pointer"
Message-ID: <202202241927.B5368AFC@keescook>
References: <20220224060503.1856302-1-keescook@chromium.org>
 <CAMo8BfJFJE-n3=AF+pb9_6oF3gzxX7a+7aBrASHjjNX5byqDqw@mail.gmail.com>
 <202202232239.FF2343D42@keescook>
 <CAMo8BfLU-BLRnp=fmmQkTckxPq1vkSZeOwfgiSW06L0+H+EDJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfLU-BLRnp=fmmQkTckxPq1vkSZeOwfgiSW06L0+H+EDJA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:58:00PM -0800, Max Filippov wrote:
> On Wed, Feb 23, 2022 at 10:43 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Feb 23, 2022 at 10:22:59PM -0800, Max Filippov wrote:
> > > On Wed, Feb 23, 2022 at 10:05 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > To follow the existing per-arch conventions replace open-coded uses
> > > > of asm "sp" as "current_stack_pointer". This will let it be used in
> > > > non-arch places (like HARDENED_USERCOPY).
> > > >
> > > > Cc: Chris Zankel <chris@zankel.net>
> > > > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: linux-xtensa@linux-xtensa.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  arch/xtensa/Kconfig                  | 1 +
> > > >  arch/xtensa/include/asm/current.h    | 2 ++
> > > >  arch/xtensa/include/asm/stacktrace.h | 2 +-
> > > >  arch/xtensa/kernel/irq.c             | 3 +--
> > > >  4 files changed, 5 insertions(+), 3 deletions(-)
> > >
> > > Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> >
> > Thanks! And apologies, my cross-compiler tricked me into thinking this
> > patch compiled without problems. It did, however. I've change the patch
> > slightly to deal with the needed casts:
> >
> > diff --git a/arch/xtensa/include/asm/stacktrace.h b/arch/xtensa/include/asm/stacktrace.h
> > index fe06e8ed162b..a85e785a6288 100644
> > --- a/arch/xtensa/include/asm/stacktrace.h
> > +++ b/arch/xtensa/include/asm/stacktrace.h
> > @@ -19,14 +19,14 @@ struct stackframe {
> >
> >  static __always_inline unsigned long *stack_pointer(struct task_struct *task)
> >  {
> > -       unsigned long *sp;
> > +       unsigned long sp;
> >
> >         if (!task || task == current)
> > -               __asm__ __volatile__ ("mov %0, a1\n" : "=a"(sp));
> > +               sp = current_stack_pointer;
> >         else
> > -               sp = (unsigned long *)task->thread.sp;
> > +               sp = task->thread.sp;
> >
> > -       return sp;
> > +       return (unsigned long *)sp;
> >  }
> >
> >  void walk_stackframe(unsigned long *sp,
> >
> > Shall I send a v2, or just carry this fix in my tree?
> 
> This additional change looks good to me, if you could
> fold it into the original patch that'd be perfect. But separate
> patch would also work.

Thanks!

-- 
Kees Cook
