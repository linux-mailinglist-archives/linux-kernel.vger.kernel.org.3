Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49B758589A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 06:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbiG3E0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 00:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiG3E0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 00:26:35 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51567FD3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:26:34 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 141so11084742ybn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzsdefuadf9H+aE6G/CtU3WmTBAcp2YL8ABvJGwjcew=;
        b=yzFdn6bauv5da3EBoeXs5JkVt5HMWnnNejbXxH85NjTw/jm163qZO5s6xWK4F7lKAy
         gPpAjr+Z+ee1rIYepNqeo/DC8EQ3LbeF7E2/iGa/1raCoV0hyyoBq7f9ZMRofHEqzi4m
         SUNDcjkizmNan97OhSyaCKlQkXox3YJGIskwmZktHlGyhs2lKXC75ZdxCSOi0C64Z//+
         M8CAv9l6+aquSjPjpCExdKXH5KMzZepzfSH2I49JMP1S3Fm4oEUD2uBtTw9rcFn1tkyS
         i+YZKpAWaKCcAEmWZNA53x1mTpiQiv1Ix/R2F5Qd3pQKc9nxib/t66zuvcpSICbjCAiW
         s+Zw==
X-Gm-Message-State: ACgBeo2RTlJGBM/bfyNXZsiPociWAxcUdXOyXBp9Fs5S4FepBSxRgm/a
        mVKYQcYOXUgp3i7og3bQHkuwoqHIEgMc44CL9t2MkiUAb4M=
X-Google-Smtp-Source: AA6agR6VvqFOzqGE3Lu3msGHcg0Y+gMjM66sP2CPciUiF8JyPyOKKuQUk2yBE8xveU9wv/5Q9wdu6N2NETlwSBVUNMs=
X-Received: by 2002:a25:3789:0:b0:671:6d58:f242 with SMTP id
 e131-20020a253789000000b006716d58f242mr4770892yba.142.1659155193430; Fri, 29
 Jul 2022 21:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220729090307.57905-1-mailhol.vincent@wanadoo.fr>
 <2e3ef1724d1d9acdbbf1a80487891a7f@kernel.org> <CAMZ6RqJbJCQOQVLvBGtfk7PsZeQtJdhhj3HJgiwZtf1XNFHZSA@mail.gmail.com>
In-Reply-To: <CAMZ6RqJbJCQOQVLvBGtfk7PsZeQtJdhhj3HJgiwZtf1XNFHZSA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 30 Jul 2022 13:26:21 +0900
Message-ID: <CAMZ6RqJ+-LA_oTNEqu+Z9jp7DwrbO3zQkbrPUYgdmbBPbMucrQ@mail.gmail.com>
Subject: Re: [PATCH] irqdomain: do not shadow nr_irqs global definition
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri. 29 Jul. 2022 at 20:12, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Fri. 29 juil. 2022 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
> > On 2022-07-29 10:03, Vincent Mailhol wrote:
> > > include/linux/irqnr.h declares a global variable named `nr_irqs'.
> > >
> > > The inline function irq_domain_alloc_irqs() from
> > > include/linux/irqdomain.h also uses the same name and thus shadow the
> > > global declaration. Rename the function argument from `nr_irqs' to
> > > `nbr_irqs'.
> > >
> > > This patch silences below -Wshadow warning:
> > >
> > > | In file included from ./arch/x86/include/asm/irqdomain.h:5,
> > > |                  from ./arch/x86/include/asm/msi.h:5,
> > > |                  from ./include/linux/msi.h:23,
> > > |                  from ./include/linux/kvm_host.h:19,
> > > |                  from arch/x86/kernel/../kvm/vmx/vmx.h:5,
> > > |                  from arch/x86/kernel/asm-offsets.c:22:
> > > | ./include/linux/irqdomain.h: In function 'irq_domain_alloc_irqs':
> > > | ./include/linux/irqdomain.h:514:38: warning: declaration of
> > > 'nr_irqs' shadows a global declaration [-Wshadow]
> > > |   514 |                         unsigned int nr_irqs, int node, void
> > > *arg)
> > > |       |                         ~~~~~~~~~~~~~^~~~~~~
> > > | In file included from ./include/linux/interrupt.h:10,
> > > |                  from ./include/linux/kernel_stat.h:9,
> > > |                  from ./include/linux/cgroup.h:26,
> > > |                  from ./include/linux/memcontrol.h:13,
> > > |                  from ./include/linux/swap.h:9,
> > > |                  from ./include/linux/suspend.h:5,
> > > |                  from arch/x86/kernel/asm-offsets.c:13:
> > > | ./include/linux/irqnr.h:8:12: note: shadowed declaration is here
> > > |     8 | extern int nr_irqs;
> > > |       |            ^~~~~~~
> > >
> > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > ---
> > >  include/linux/irqdomain.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> > > index 00d577f90883..76949bb029b0 100644
> > > --- a/include/linux/irqdomain.h
> > > +++ b/include/linux/irqdomain.h
> > > @@ -511,9 +511,9 @@ extern int irq_domain_activate_irq(struct irq_data
> > > *irq_data, bool early);
> > >  extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
> > >
> > >  static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
> > > -                     unsigned int nr_irqs, int node, void *arg)
> > > +                                     unsigned int nbr_irqs, int node, void *arg)
> > >  {
> > > -     return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
> > > +     return __irq_domain_alloc_irqs(domain, -1, nbr_irqs, node, arg,
> > > false,
> > >                                      NULL);
> > >  }
> >
> > I really don't think this is worth it. A function has its
> > own namespace, and this warning is on the long list of
> > "this is completely silly". Case in point:
> >
> > $ git grep 'unsigned int nr_irqs'| wc -l
> > 207
> >
> > Is anything broken? Not as far as I can tell.
>
> Nothing is broken, my only concern is that this occurs in a header
> file and thus the warning will pop up in random files which include
> this header.
>
> | git grep "unsigned int nr_irqs" include/ arch/*/include | wc -l
> | 17
> (and all static inline function which trigger the warning are from
> linux/irqdomain.h)
>
> Time to time, I check the W=2 output and spam from the headers makes
> it annoying to triage. I absolutely do not care of shadowing
> everywhere else outside of the includes directory.
>
> > If there was anything to fix, it is the top-level definition
> > that should be more indicative of its global status. But again,
> > there is nothing broken so far.
>
> This is also feasible, but it will become a tree-wide patch. And I am
> quite certain that it will be NACKed right away, so I will not try
> this alternate solution.

To add some figures, on a "make allyesconfig" (linux-next branch,
x86_64 build, gcc 12), there are in total 36005 -Wshadow and
irqdomain.h accounts for 7094 of all these (i.e. this patch suppresses
roughly one fifth of all -Wshadow warnings tree wide).


Yours sincerely,
Vincent Mailhol
