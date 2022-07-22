Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61F57E272
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiGVNl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiGVNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:41:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C713E36
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:41:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id j26so5513049lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dx7D0BqkkDvjmBT9gC4DV9N7HZuC2AWyX/zQVsh2Lhg=;
        b=Mav9qQe7Hay6uovpG8VBsmTfL/xzD90QiB1XmORe5cOsqAXIlePMrDnpAKjk2SPHlU
         kb5Ut7GMhYSuGugphdGTCzl4QS6dVbBemaHVAe/68tr5YLIdKH+1dl3Be+60VFt6Mw1X
         89ZZ7H+XeGTtXT+aoENzLnwYujx0UEFEHIllUI+2lj18vV6lg2lkpPDYX2L9dVq8r5Mu
         ohtc/xno0dA+uaPEz0e57vbqZPXDLbKUqdzl3NXPeMXzZjWy8P656YDqqiKQAcIZgP12
         9CxD2oRBzvv/UqkEIIr6I79Mj6do1s20CN+FUt2qGuSgsOMDu5gIKWU0Uw89VqdLMCEK
         WJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dx7D0BqkkDvjmBT9gC4DV9N7HZuC2AWyX/zQVsh2Lhg=;
        b=i3kgreyAKjvyjc4hwQB4lhTCW6Qyn6TVqcxeKcWhrjNstUZkqKUBvl2W3uJvnyCUCh
         QVphDtkg+BbI2+vIU51N1KIVZ0B78gLa17mYvyGvjSQ5aatJVKPxLhPGtbsHVkXWtuHm
         peLhv2s7RE6vsgkQCF7ZdSNKD0l/cjdLi9tRA9RguIGiH68DsPJjhPee5J4afR2A2DMF
         ALpc4chRTm0ZnlQmSjaeyKqEs3ZooQrH2AR5H4sGqC5LFIIiAAa3la290DbdOlAI8Bpy
         qdXNJuhIT1wEjicsVkzcMxeglXIOAv9fOXNq/gu3c4cp3vUntA/b6PvXDMC2NIQKF96/
         ljAg==
X-Gm-Message-State: AJIora+85B5kOhouV6vQ9wF0im54IzgPABABj/q3qaBpgeChUAR/pw8S
        ofF1ZxA5UafOGRpnvu/D9SH9RGZU4Q5ZaYZhBlW/mG97fWEkzw==
X-Google-Smtp-Source: AGRyM1vqDflld4FdeS1YXh0RjgxlOzCf0nGqPxhUwqvkb5F6yDAk/Z183xcr0L3QZpAS70KrFAFPlj5+eHC8c+4k4GY=
X-Received: by 2002:a2e:bd0e:0:b0:25a:88b3:9af6 with SMTP id
 n14-20020a2ebd0e000000b0025a88b39af6mr24943ljq.363.1658497309800; Fri, 22 Jul
 2022 06:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-2-elver@google.com>
 <Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com> <20220722091044.GC18125@willie-the-truck>
 <CACT4Y+ZOXXqxhe4U3ZtQPCj2yrf6Qtjg1q0Kfq8+poAOxGgUew@mail.gmail.com>
 <20220722101053.GA18284@willie-the-truck> <CACT4Y+Z0imEHF0jM-f-uYdpfSpfzMpa+bFZfPeQW1ECBDjD9fA@mail.gmail.com>
 <20220722110305.GA18336@willie-the-truck>
In-Reply-To: <20220722110305.GA18336@willie-the-truck>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Jul 2022 15:41:38 +0200
Message-ID: <CACT4Y+aLiNNt3ESZUKHT9U8duN-TMK561nC7Htx9y3R7afCV4g@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 at 13:03, Will Deacon <will@kernel.org> wrote:
> > > > > > On Mon, Jul 04, 2022 at 05:05:01PM +0200, Marco Elver wrote:
> > > > > > I'm not immediately sure what would be necessary to support per-task kernel
> > > > > > breakpoints, but given a lot of that state is currently per-cpu, I imagine it's
> > > > > > invasive.
> > > > >
> > > > > I would actually like to remove HW_BREAKPOINT completely for arm64 as it
> > > > > doesn't really work and causes problems for other interfaces such as ptrace
> > > > > and kgdb.
> > > >
> > > > Will it be a localized removal of code that will be easy to revert in
> > > > future? Or will it touch lots of code here and there?
> > > > Let's say we come up with a very important use case for HW_BREAKPOINT
> > > > and will need to make it work on arm64 as well in future.
> > >
> > > My (rough) plan is to implement a lower-level abstraction for handling the
> > > underlying hardware resources, so we can layer consumers on top of that
> > > instead of funneling through hw_breakpoint. So if we figure out how to make
> > > bits of hw_breakpoint work on arm64, then it should just go on top.
> > >
> > > The main pain point for hw_breakpoint is kernel-side {break,watch}points
> > > and I think there are open design questions about how they should work
> > > on arm64, particularly when considering the interaction with user
> > > watchpoints triggering on uaccess routines and the possibility of hitting
> > > a kernel watchpoint in irq context.
> >
> > I see. Our main interest would be break/watchpoints on user addresses
> > firing from both user-space and kernel (uaccess), so at least on irqs.
>
> Interesting. Do other architectures report watchpoint hits on user
> addresses from kernel uaccess? It feels like this might be surprising to
> some users, and it opens up questions about accesses using different virtual
> aliases (e.g. via GUP) or from other entities as well (e.g. firmware,
> KVM guests, DMA).

x86 supports this.
There is that attr.exclude_kernel flag that requires special permissions:
https://elixir.bootlin.com/linux/v5.19-rc7/source/kernel/events/core.c#L12061
https://elixir.bootlin.com/linux/v5.19-rc7/source/kernel/events/core.c#L9323
But if I understand correctly, it only filters out delivery, the HW
breakpoint fires even if attr.exclude_kernel is set.

We also wanted to relax this permission check somewhat:
https://lore.kernel.org/all/20220601093502.364142-1-elver@google.com/

Yes, if the kernel maps the page at a different virtual address, then
the breakpoint won't fire I think.
Don't know what are the issues with firmware/KVM.
