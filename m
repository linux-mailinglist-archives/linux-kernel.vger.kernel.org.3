Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D684D561B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiF3N3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiF3N3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:29:05 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB8E3335C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:29:03 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o4so12371478ilm.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpBSxRjyWissqpsLZxu6rDb8LTkx6HPCXFAIhKQadlM=;
        b=LLapPG0yWqc1q3kp+JD49502aWcoipy4BmuQbAaSYV/5y2Sb7CY5mzUjZee4X8qtwj
         qMsEezJ4dGpdsHEp+6ePq8uns8LD/ITi/HiPpStnOfTzlcsKdBQJYn3dNmKHyWu96G11
         6HcAkwV9Ti82rxCtcEfTLO0ctZEzUotaYfF/3xv5Sd7PANeo0ZBtH5CzXY3Xun2BItn5
         0UO+30Uly4DQaG+WE4DCMpmnT2y/NgQxzIxoQi7WdvGa/91Z/LMox32jdDZPtorGCKom
         mk0+LZMwuQdmyMO7kvYlpns3RsUs28dQQi/L8CDIin4CXO25qaNcBx9WKYba3tTnItDw
         Vxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpBSxRjyWissqpsLZxu6rDb8LTkx6HPCXFAIhKQadlM=;
        b=XuDBdKKAV/Ng+o6ZTKlqFF9Uz4wJYr2J2Ldpe0pizMtokwUM5ivgxD5nA9NjG9Bf9P
         HgocKnR+wWObcbVxAUFYUVyEb4EUU1MwzFQJrKj9BXrqt5qWh4zVrqQTNOjohMNM3EZp
         VhZqv32WNLphYfhw60HaElifsrn/2fHLJtYsyp9FuDMI0KY0DRAZU0uAXJCEvWsvqFH5
         TkifODt2tP0Ynp5Qqn4Pkl9DWrLxhEAZrst7yAiZ1sEp91GrJ0yd7IHlzmH6NbXafZ04
         KReEtIYEKU1HiV+jdbrO4w5uZSCBZVeppb41zbLpGaUNW7TBfo0zDKJ1ObbMdPZ7flqN
         CugQ==
X-Gm-Message-State: AJIora9mamNr7uc4s4kFaoA90swXC1RcMsEk1zDR0z1DBprliqmiUWtZ
        dIOq5oHrI5NOEsTSVCV2IWGui5b/A08jmET98uc=
X-Google-Smtp-Source: AGRyM1sGll8gIz0SR3UTo0m6iKl+5SLhukEFeBZdDITQ6UfGDLAoD8uSKC2i2k4I9cGeQBY3i9dbKbZ60VijY+gS4Sg=
X-Received: by 2002:a05:6e02:1c2a:b0:2d9:45ef:75c2 with SMTP id
 m10-20020a056e021c2a00b002d945ef75c2mr4984281ilh.235.1656595743231; Thu, 30
 Jun 2022 06:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220630080834.2742777-1-davidgow@google.com> <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com> <20220630125434.GA20153@axis.com>
In-Reply-To: <20220630125434.GA20153@axis.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Jun 2022 15:28:52 +0200
Message-ID: <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] UML: add support for KASAN under x86_64
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 2:54 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Thu, Jun 30, 2022 at 11:41:04AM +0200, Dmitry Vyukov wrote:
> > On Thu, 30 Jun 2022 at 10:08, David Gow <davidgow@google.com> wrote:
> > > diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> > > index 1c2d4b29a3d4..a089217e2f0e 100644
> > > --- a/arch/um/kernel/Makefile
> > > +++ b/arch/um/kernel/Makefile
> > > @@ -27,6 +27,9 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
> > >  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> > >  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> > >
> > > +KASAN_SANITIZE_stacktrace.o := n
> > > +KASAN_SANITIZE_sysrq.o := n
> >
> > Why are these needed?
> > It's helpful to leave some comments for any of *_SANITIZE:=n.
> > Otherwise later it's unclear if it's due to some latent bugs, some
> > inherent incompatibility, something that can be fixed, etc.
>
> I believe I saw the stacktrace code itself triggering KASAN splats and
> causing recursion when sanitization was not disabled on it.  I noticed
> that other architectures disabled sanitization of their stacktrace code,
> eg. ARM in commit 4d576cab16f57e1f87978f ("ARM: 9028/1: disable KASAN in
> call stack capturing routines"), so I did not investigate it further.
>
> (Note that despite the name, sysrq.c is also just stacktrace code.)

Stack trace collection code might trigger KASAN splats when walking
stack frames, but this can be resolved by using unchecked accesses.
The main reason to disable instrumentation here is for performance
reasons, see the upcoming patch for arm64 [1] for some details.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=802b91118d11
