Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE83C5613AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiF3HxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiF3HxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:53:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B663E9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:53:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e28so20821402wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2a71x297ZADJzEPxttWEizkIknOexDX93mkmWqB2RE=;
        b=iL+4gYKEmRYRhP/EAIFUUv0eHXf37WrALCqJ8rYPPqnVghuCOw0+od/pXFe4pmUpwq
         MkY3fKo+PMK5V+hRsccI98WwWUG45LY4xpH+yFAsTZ1hrmoHEmPaVVQpdIwVqARZSWOb
         B13tZZV671MAQNhWX8kyS3di3TT6/Z0AtKctuXaZgHY7ELGSNCwOV5Sk693HMz+BQaxE
         ABOpxlI4mxlB8RdTwO3qsbFhzN//ncvti7vlJGTbYseEb7x7zlfd2nOkR6H13rNxo0tJ
         x0CkMeene+CNVm42kqY53oMPo6mqrgljcCRe+L4HD/7HsjBqhY0+BDIa+b1n9/A/KCHO
         5JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2a71x297ZADJzEPxttWEizkIknOexDX93mkmWqB2RE=;
        b=o33XhDlmUJ4vdxnA490TiCXgOjvEOFociorJ3ZvrpEyBxZm6GdlLgENFVb66DeFESh
         i6twa4pUrNwIT3bp5OaukMQ8qf8VezDJX29+9bX2sOBKbDUERDMHqWO8T1Eh7stcuaL9
         rEds2CqgIvWk/EP101Hg97Ol6g+LX3scoix7PkUEcUH+N+08BcO7r28SuqqoNqThcQY7
         djRmf6eYpVjq9LYJANGAyVpdH+4qllnzbX+p0R02RhMxU9iI172af+8HBBSOw4h2EDIY
         k2ZLbgylK2FWB0MqxprVyNfZ5RU6MlbV/jJnevfpxAr0V8fcCbhaDoBtIvqsUyHcWhbm
         iPWg==
X-Gm-Message-State: AJIora8/eZMSOLGcw36i4Mi8dRKfneQpxPIX+glmOEEn84xacqY8nFlO
        lfZYROgpkORJ9ym6zzwuQvQMPAd8cc/U85qsWgKH0w==
X-Google-Smtp-Source: AGRyM1u/EZ4JKaKS7hWiFLohAuDyr6Q1NZPrj9AIsTAlWbGBF+jSB2lmwsSysJ5PG3ER+YrMZ4nXykQzqKP7d2sbdFs=
X-Received: by 2002:a05:6000:1ac8:b0:21b:9239:8f28 with SMTP id
 i8-20020a0560001ac800b0021b92398f28mr7092801wry.517.1656575593964; Thu, 30
 Jun 2022 00:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220527185600.1236769-1-davidgow@google.com> <20220527185600.1236769-2-davidgow@google.com>
 <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
In-Reply-To: <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Jun 2022 15:53:02 +0800
Message-ID: <CABVgOSkNqTAeJa=Z4pNYO=ati0qVsLe2uGUfn7yO_D2QfAzHyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 4:14 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2022-05-27 at 11:56 -0700, David Gow wrote:
> >
> > This is v2 of the KASAN/UML port. It should be ready to go.
>
> Nice, thanks a lot! :)
>

Thanks for looking at this: I've finally had the time to go through
this in detail again, and have sent out v3:
https://lore.kernel.org/lkml/20220630074757.2739000-2-davidgow@google.com/

> > It does benefit significantly from the following patches:
> > - Bugfix for memory corruption, needed for KASAN_STACK support:
> > https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/
>
> Btw, oddly enough, I don't seem to actually see this (tried gcc 10.3 and
> 11.3 so far) - is there anything you know about compiler versions
> related to this perhaps? Or clang only?
>
> The kasan_stack_oob test passes though, and generally 45 tests pass and
> 10 are skipped.
>

Given this patch has already been accepted, I dropped this comment
from v3.  As you note, the issue didn't reproduce totally
consistently.

> > +# Kernel config options are not included in USER_CFLAGS, but the
> > option for KASAN
> > +# should be included if the KASAN config option was set.
> > +ifdef CONFIG_KASAN
> > +     USER_CFLAGS+=-DCONFIG_KASAN=y
> > +endif
> >
>
> I'm not sure that's (still?) necessary - you don't #ifdef on it anywhere
> in the user code; perhaps the original intent had been to #ifdef
> kasan_map_memory()?
>

I've got rid of this for v3, thanks.

> > +++ b/arch/um/os-Linux/user_syms.c
> > @@ -27,10 +27,10 @@ EXPORT_SYMBOL(strstr);
> >  #ifndef __x86_64__
> >  extern void *memcpy(void *, const void *, size_t);
> >  EXPORT_SYMBOL(memcpy);
> > -#endif
> > -
> >  EXPORT_SYMBOL(memmove);
> >  EXPORT_SYMBOL(memset);
> > +#endif
> > +
> >  EXPORT_SYMBOL(printf);
> >
> >  /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
> > diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> > index ba5789c35809..f778e37494ba 100644
> > --- a/arch/x86/um/Makefile
> > +++ b/arch/x86/um/Makefile
> > @@ -28,7 +28,8 @@ else
> >
> >  obj-y += syscalls_64.o vdso/
> >
> > -subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
> > +subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o \
> > +     ../lib/memmove_64.o ../lib/memset_64.o
>
> I wonder if we should make these two changes contingent on KASAN too, I
> seem to remember that we had some patches from Anton flying around at
> some point to use glibc string routines, since they can be even more
> optimised (we're in user space, after all).
>
> But I suppose for now this doesn't really matter, and even if we did use
> them, they'd come from libasan anyway?

I had a quick look into this, and think it's probably best left as-is.
I think it's better to have the same implementation of these
functions, regardless of whether KASAN is enabled. And given that we
need the explicit, separate instrumented and uninstrumented versions,
we'd need some way of having one copy which came from libasan and one
which was totally uninstrumented.

But if the performance difference is really significant, we could
always revisit it.


>
> Anyway, looks good to me, not sure the little not above about the user
> cflags matters.
>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
>

Cheers,
-- David
