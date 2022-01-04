Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED474843DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiADOyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiADOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:54:18 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABAEC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:54:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z9so79588304edm.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DiluQW1CddfJIgHwP7IazIb4BrI4L8BdVRV21aDJlj8=;
        b=jpNSvZxe+IQwNFaXFpmtaCYLjzvLfqRAxoNxWO+3Bi+kVyO2RhvlFySZYMJOgjiGcW
         Zw1DmRvMjms99hyTx5MI/Bckt0ainxPQjDast9Pp7/zb+0WHyyiQnNiBlZprx0o6GkOV
         pO/EJ8bagbFNdcTcHTK1aLQ932m1Xs3jJkduyJBu9w4cLtk7XP4mzXzO0SQRoeu1n5+K
         jf40sLufq5lvMBmsZtXR1mGFRCCcFwqrhbWAccOcHJn7azA8A2z2EELy4xvWbCURzFqq
         NH6pUMQ65XMQdjFCcJoZX0u0TCxBmL6zjJ1L/33V6i4OyLgvGtyenphFPmTLJoIbWjlo
         rlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DiluQW1CddfJIgHwP7IazIb4BrI4L8BdVRV21aDJlj8=;
        b=jAt+Gsia6QGvqUZsuhzLZIlrnglngptxs2Oe2gPmyV1ojssyDAtKpEWqBFbmZSVWOf
         FvppXg2ewAJur9VmuKTKfoLNxRICiJgYw6j7bwAiDq12OII4PkUDxMhR/lmFHh5RYB0m
         Ojv8PUq/yaizPcKRt4Qq2lRlBQ+TwYqO0eUas1en2XMtqSOtDjRb0kkXrGUr+A187yzW
         9iBJAW6Jb9YCHTCqfvpLwC//y0H14BQE3p0acHv5MGfiGStUElZdvJdAI2g/YdGbY8fP
         TY6NAD091dmMG3m6dCQ4VdZbmmU8kwezRHFf5EUqu69HGAWwe5JKVqP8OKwH2RlOrwOF
         /guw==
X-Gm-Message-State: AOAM5302xVqln7UH286RsJRY9e09vii80e9eZ5oziPvyCcpFa2bvAnxT
        /HxIm+tfdXCQabZCfafSNen9VQaQyNCtJNkzP8E=
X-Google-Smtp-Source: ABdhPJxnjQTp0LOq61he5x9HUwD5haZyDoNGe9ieqNx+P1vM+N5sMIzBlko2BecBXIqa5TT62m74eTzKMFldxAv+p6I=
X-Received: by 2002:a17:906:ced9:: with SMTP id si25mr42645917ejb.77.1641308056827;
 Tue, 04 Jan 2022 06:54:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vdjp9_67xe0PeZ9LzcJ=eNxB0qVqPJqtFEvh3SDgcdODw@mail.gmail.com>
 <YdRdhE9z+Yyxwrhj@alley>
In-Reply-To: <YdRdhE9z+Yyxwrhj@alley>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Jan 2022 16:52:25 +0200
Message-ID: <CAHp75Vd0-__zV72YGpNqjdV6kOEQYcPkHeyEHPCQ0iL6K8oidQ@mail.gmail.com>
Subject: Re: header circular dependencies
To:     Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 4:46 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2021-12-22 21:08:39, Andy Shevchenko wrote:
> > `make headerdep` is full of printk.h circular dependencies, like
> >
> > include/kvm/arm_vgic.h:18: warning: recursive header inclusion
> > In file included from linux/printk.h,
> >                 from linux/dynamic_debug.h:188
> >                 from linux/printk.h:555 <-- here
>
> This one looks like false positive:
>
>    + printk.h includes dynamic_debug.h when CONFIG_DYNAMIC_DEBUG_CORE
>    + dynamic_debug.h includes printk.h when !CONFIG_DYNAMIC_DEBUG_CORE
>
> But there seem to be other cycles, for example:
>
>    + printk.h
>      + dynamic_debug.h
>        + jump_label.h
>          + bug.h
>            + asm/bug.h
>              + printk.h
>
> I guess that it somehow works _only_ because printk.h includes
> dynamic_debug.h late. It probably defines everything that is needed
> by bug.h early enough.
>
> > I'm wondering if it's a false positive?
> > In either case, can we teach the headerdep not to complain by fixing
> > the culprit?
>
> I am scratching my head how to clean this up. All the dependencies
> make sense. The main problem is that all headers provide a lot of
> inlined functionality. The inlining is often important either because
> of speed or because every caller needs to have its own data structure
> (struct _ddebug, struct static_key).
>
> I can't find any good solution at the moment. But I am still slowed
> down after the holidays.

Thanks for looking into this.

Meanwhile (I haven't looked at that myself) Ingo announced some of his
long work on the topic:
https://lore.kernel.org/lkml/YdIfz+LMewetSaEB@gmail.com/

Perhaps he has a solution there.


-- 
With Best Regards,
Andy Shevchenko
