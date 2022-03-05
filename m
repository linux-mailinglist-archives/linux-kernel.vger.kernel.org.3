Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1C4CE288
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 05:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiCED6y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Mar 2022 22:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCED6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 22:58:52 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B915F37A06
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 19:58:02 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2dbfe58670cso111941067b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 19:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k/KxZWnsipa0LOVNrv/AsWXD0KCOxYbfZhWdDw0/Nm4=;
        b=BFqdwGgy2XlTQ/eStV24a7ZzYuvCfbpd5YieUJE4Fbr7Z04hla5zUnMcPb4TBJb3WI
         dbq4x+uFhODA3/TwVvdwr9YF6KpkLiKJ1Frk3y0P7E+WxHKO08tr1U9+annPdibX3PNN
         4dz50UhESRbklggWq6slY5/rzJUHwE9yLndLpaiJaebR0SQs5l4mzDoDZw8zv/fTjyyt
         tzj/E2NaA2fHQhBd1my7wn/HTvINbG8qYz1BpV8xFE3OHIYhDIQ8EwBm4HtWfWFmqbCu
         XOefRywwQIn5pcif333Dl8f0qoGx5bV3R8A/ipz9+QUN9yTHxHEFFeFDkZxRV/CIIUkO
         YgGw==
X-Gm-Message-State: AOAM530pQ9w3ZUVgRww+1eTY6GmeED3LhduFuzvnLOzpbxdU/uW0cT5b
        0inVsgDjDTKmwqw2OWlEuXsqaXBYEI9/0jk72gZwgAxiyZc=
X-Google-Smtp-Source: ABdhPJwTfa6aCxlr0sFO35UhWl3Vyye6JHsSSKz2bi39j8Uw4B9EyrgTuuVV1JikDrCPMZalNw5Fytn14W0TJrmvBpE=
X-Received: by 2002:a81:6bc6:0:b0:2db:fe24:d5ee with SMTP id
 g189-20020a816bc6000000b002dbfe24d5eemr1424302ywc.392.1646452681895; Fri, 04
 Mar 2022 19:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20220303110755.24147-1-mailhol.vincent@wanadoo.fr> <CAKwvOd=Fyu6S=pK-tGeYgoJL3ntGRSC0EQ6si8Cdg9q2pn0a6A@mail.gmail.com>
In-Reply-To: <CAKwvOd=Fyu6S=pK-tGeYgoJL3ntGRSC0EQ6si8Cdg9q2pn0a6A@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 5 Mar 2022 12:57:50 +0900
Message-ID: <CAMZ6Rq+DmXexN62m8AxPrjT=Fi=3fEg_VVjOOm3YV+X22Td0PA@mail.gmail.com>
Subject: Re: [PATCH] x86/bug: __WARN_FLAGS: prevent shadowing by renaming
 local variable f to __flags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 5 Mar 2022 à 04:26, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Thu, Mar 3, 2022 at 3:08 AM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> > The macro __WARN_FLAGS() uses a local variable named "f". This being a
> > common name, there is a risk of shadowing other variables.
> >
> > For example:
> >
> > | In file included from ./include/linux/bug.h:5,
> > |                  from ./include/linux/cpumask.h:14,
> > |                  from ./arch/x86/include/asm/cpumask.h:5,
> > |                  from ./arch/x86/include/asm/msr.h:11,
> > |                  from ./arch/x86/include/asm/processor.h:22,
> > |                  from ./arch/x86/include/asm/timex.h:5,
> > |                  from ./include/linux/timex.h:65,
> > |                  from ./include/linux/time32.h:13,
> > |                  from ./include/linux/time.h:60,
> > |                  from ./include/linux/stat.h:19,
> > |                  from ./include/linux/module.h:13,
> > |                  from virt/lib/irqbypass.mod.c:1:
> > | ./include/linux/rcupdate.h: In function 'rcu_head_after_call_rcu':
> > | ./arch/x86/include/asm/bug.h:80:21: warning: declaration of 'f' shadows a parameter [-Wshadow]
> > |    80 |         __auto_type f = BUGFLAG_WARNING|(flags);                \
> > |       |                     ^
> > | ./include/asm-generic/bug.h:106:17: note: in expansion of macro '__WARN_FLAGS'
> > |   106 |                 __WARN_FLAGS(BUGFLAG_ONCE |                     \
> > |       |                 ^~~~~~~~~~~~
> > | ./include/linux/rcupdate.h:1007:9: note: in expansion of macro 'WARN_ON_ONCE'
> > |  1007 |         WARN_ON_ONCE(func != (rcu_callback_t)~0L);
> > |       |         ^~~~~~~~~~~~
> > | In file included from ./include/linux/rbtree.h:24,
> > |                  from ./include/linux/mm_types.h:11,
> > |                  from ./include/linux/buildid.h:5,
> > |                  from ./include/linux/module.h:14,
> > |                  from virt/lib/irqbypass.mod.c:1:
> > | ./include/linux/rcupdate.h:1001:62: note: shadowed declaration is here
> > |  1001 | rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
> > |       |                                               ~~~~~~~~~~~~~~~^
> >
> > This patch renames the variable from f to __flags (with two underscore
> > prefixes as suggested in the Linux kernel coding style [1]) in order
> > to prevent collisions.
> >
> > [1] Linux kernel coding style, section 12) Macros, Enums and RTL,
> > paragraph 5) namespace collisions when defining local variables in
> > macros resembling functions
> > https://www.kernel.org/doc/html/v4.10/process/coding-style.html#macros-enums-and-rtl

Indeed! Will update this in v2 (and will also fix the Fixes: tag as
pointed by Josh).

> Ah, thanks for the patch. I missed that coding style recommendation.
> Might want to link to a newer (or evergreen) version of the docs
> though:
> https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
> Not sure what happens when we start shadowing variables named __flags,
> but maybe we cross that bridge if/when we get there.

Ack.

> Thanks for the fix!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
