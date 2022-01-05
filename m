Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67090484F88
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiAEIrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:47:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37544 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiAEIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:47:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F0762112A;
        Wed,  5 Jan 2022 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641372419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/AOWs726IPdbXnbVpVSnXPeNpvFG1UBVciPUotuP6LE=;
        b=mnvS+TEIzPIKkwDgjp5ip2Z1VZ9hBakq06zMZgUS6pX2BqkGCZIXPEg5kv2/F1AEoyVR5O
        S3ZyQ2+elc2584tDXfD2ErKvQYeKyWOLqdCmJUfUZp3JAdx6WSmt8lBQuHhNlaiBMWUqX0
        5qosWpNCLsc6+6kIKJXfz206uk4CtlE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 60508A3B81;
        Wed,  5 Jan 2022 08:46:59 +0000 (UTC)
Date:   Wed, 5 Jan 2022 09:46:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: header circular dependencies
Message-ID: <YdVbAHJfyceA4ZRs@alley>
References: <CAHp75Vdjp9_67xe0PeZ9LzcJ=eNxB0qVqPJqtFEvh3SDgcdODw@mail.gmail.com>
 <YdRdhE9z+Yyxwrhj@alley>
 <CAHp75Vd0-__zV72YGpNqjdV6kOEQYcPkHeyEHPCQ0iL6K8oidQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd0-__zV72YGpNqjdV6kOEQYcPkHeyEHPCQ0iL6K8oidQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-01-04 16:52:25, Andy Shevchenko wrote:
> On Tue, Jan 4, 2022 at 4:46 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Wed 2021-12-22 21:08:39, Andy Shevchenko wrote:
> > > `make headerdep` is full of printk.h circular dependencies, like
> > >
> > > include/kvm/arm_vgic.h:18: warning: recursive header inclusion
> > > In file included from linux/printk.h,
> > >                 from linux/dynamic_debug.h:188
> > >                 from linux/printk.h:555 <-- here
> >
> > This one looks like false positive:
> >
> >    + printk.h includes dynamic_debug.h when CONFIG_DYNAMIC_DEBUG_CORE
> >    + dynamic_debug.h includes printk.h when !CONFIG_DYNAMIC_DEBUG_CORE
> >
> > But there seem to be other cycles, for example:
> >
> >    + printk.h
> >      + dynamic_debug.h
> >        + jump_label.h
> >          + bug.h
> >            + asm/bug.h
> >              + printk.h
> >
> > I guess that it somehow works _only_ because printk.h includes
> > dynamic_debug.h late. It probably defines everything that is needed
> > by bug.h early enough.
> >
> > > I'm wondering if it's a false positive?
> > > In either case, can we teach the headerdep not to complain by fixing
> > > the culprit?
> >
> > I am scratching my head how to clean this up. All the dependencies
> > make sense. The main problem is that all headers provide a lot of
> > inlined functionality. The inlining is often important either because
> > of speed or because every caller needs to have its own data structure
> > (struct _ddebug, struct static_key).
> >
> > I can't find any good solution at the moment. But I am still slowed
> > down after the holidays.
> 
> Thanks for looking into this.
> 
> Meanwhile (I haven't looked at that myself) Ingo announced some of his
> long work on the topic:
> https://lore.kernel.org/lkml/YdIfz+LMewetSaEB@gmail.com/
> 
> Perhaps he has a solution there.

Thanks for the pointer. Unfortunately, it seems that Ingo's patchset
does not solve our problem. It is possible that printk.h did not look
interesting enough. printk() is used almost anywhere and probably
does not include that much stuff on its own.

Anyway, Ingo's patchset uses many tricks. It might be good inspiration
how to solve our dependency hell. I am going to think more about it.

Best Regards,
Petr
