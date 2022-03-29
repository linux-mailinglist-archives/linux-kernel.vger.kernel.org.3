Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4604EB36B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiC2SiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiC2SiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:38:05 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFEF149256
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:36:21 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z7so22082440iom.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUrhq9evNqA9x3IGobvT5hE7CTLMIVYRzbuHHy97Qyw=;
        b=nj4/aW6Kbl9hIgkEraEI7qLFULOD5EsXDCHMwh1SxLrSK2YgGQ3y+94ZHK97TL7WpP
         Ch8HtblRcIWAOKuHo8Im5a5bC0dmZJu2ffG2aimykeJQP2qKnYdYTFCuZcgXjPaNoJql
         3+6X+JLQYuWQmTCyg8Zgv24+R5OYKlR9xAOxDqyW5ojxT6YdO4C+sT1KkUAcCnHp1v0P
         Q5kbDOtOJY//ZrhA9Sd6JDY07ZtSBtinAgXN5X8mzwHWjRAkYCuTc6e49DCXRhnyV4aP
         8AMGT2yKqSgm1Gjd7CJQ3SPp024WGeIZERrflKsvB2oHa8F8zapXlBfo7um85Qs9YlVF
         yINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUrhq9evNqA9x3IGobvT5hE7CTLMIVYRzbuHHy97Qyw=;
        b=v2hFca/C1T2/zVyTQlvjM4dJwzyJl2pwsYJGnWvvcxpEfv3QmOB1FYIei07UauzeCr
         vGfeHKGB7jTgwBOVFWkAyYx/gfy7tZ2FK3pbMcrjaBRMrNwLeR1uEuDmlM78oaIxnC5C
         TVxhZOTejZab+w3SZ1ClSC8yC3koz9GAL0pYu7eyVcraTY+yw5/esGx/avolMS2/Wa9N
         etXQrKoU/maJ2q0LLP6yaneglD/nPZQMHPwu2iVAvYt3KxUDbtSwc1/jYumynhdkWSA4
         Ry7cj9akPux0X3r3bHb0eQqLAPMoKoT7uBfT0twU2eOyKSW9+nfBoXpgr3XsjVRgG1zH
         zwaQ==
X-Gm-Message-State: AOAM532gMiEKdE6dYzIU4inLbzsiWfBybjfmWYnkfRavBmgI1FEaltOt
        IBXk3DAHpL0687Fle1Y32NbgYp20u61jp9KhlhQ=
X-Google-Smtp-Source: ABdhPJwP776hOCDGMQP+vDMRjnkGUHFev1/eqPS4VGu6yaU0gkRv1VzLNw4Un55174Uom6XE7s8ryiokbz3HyW2YlTU=
X-Received: by 2002:a02:b687:0:b0:323:60e7:121a with SMTP id
 i7-20020a02b687000000b0032360e7121amr8803432jam.22.1648578980752; Tue, 29 Mar
 2022 11:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <21e3e20ea58e242e3c82c19abbfe65b579e0e4b8.1648049113.git.andreyknvl@google.com>
 <20220325134629.99699c921bb8c8db413e8e35@linux-foundation.org>
In-Reply-To: <20220325134629.99699c921bb8c8db413e8e35@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 29 Mar 2022 20:36:09 +0200
Message-ID: <CA+fCnZfbDnC+tii5g+FGMDrMAz2vPmp-3LJG8q3T4psRJi3N4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] stacktrace: add interface based on shadow call stack
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Fri, Mar 25, 2022 at 9:46 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 23 Mar 2022 16:32:52 +0100 andrey.konovalov@linux.dev wrote:
>
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Add a new interface stack_trace_save_shadow() for collecting stack traces
> > by copying frames from the Shadow Call Stack.
> >
> > Collecting stack traces this way is significantly faster: boot time
> > of a defconfig build with KASAN enabled gets descreased by ~30%.
> >
> > The few patches following this one add an implementation of
> > stack_trace_save_shadow() for arm64.
> >
> > The implementation of the added interface is not meant to use
> > stack_trace_consume_fn to avoid making a function call for each
> > collected frame to further improve performance.
> >
> > ...
> >
> > @@ -108,4 +111,16 @@ static inline int stack_trace_save_tsk_reliable(struct task_struct *tsk,
> >  }
> >  #endif
> >
> > +#if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_SHADOW_STACKTRACE)
> > +int stack_trace_save_shadow(unsigned long *store, unsigned int size,
> > +                         unsigned int skipnr);
> > +#else
> > +static inline int stack_trace_save_shadow(unsigned long *store,
> > +                                       unsigned int size,
> > +                                       unsigned int skipnr)
> > +{
> > +     return -ENOSYS;
> > +}
> > +#endif
>
> checkpatch sayeth "WARNING: ENOSYS means 'invalid syscall nr' and
> nothing else".

This is done deliberately to mimic stack_trace_save_tsk_reliable().
I'll mention this in the changelog.

> checkpatch also picked up a typo in a changelog.  Useful thing to run,
> is checkpatch.

My bad, I ran it on diff instead of the patch. Will fix in v3. Thanks!
