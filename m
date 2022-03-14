Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3050C4D7DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiCNI7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiCNI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:59:05 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B78DBF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:57:52 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l2so29301309ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnStb81zNfCbHNpdfKDavCPptqLqSaSsDRJFANgLx8A=;
        b=dq218i3qZDV4+B76aTfwkaH9pAlGjbYICkbByaYC8TXGnhwN6Ehv1mPsMhNyM9O8++
         qvfNx5pKKzlTMNvwYIN55VhYlrepET0w3qSroHDLgagYw6yJZ/YakR4CykLuIhL3LrSF
         JrJEVzlId77OaIhjTUBslVlKJv4S7oqc6sySieHKCG34OCikFruQ9/H+HO0yqnIDvktS
         5URQXk75ftEsml2eptXJ3rPy3obpqRDDEgcaawW2q/dqhVA1yepsxYYVhjH/szn2ORPb
         lzlKShszva657FhgQJR7T0zHCZPKAsh+gpEeYnp2R6tP4uoQM8OSWEB76QULmsZqMkMI
         2Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnStb81zNfCbHNpdfKDavCPptqLqSaSsDRJFANgLx8A=;
        b=jqWCv4HLPMTPWmb8IuJ5x/+NHb7Q+m/cY45M3cYwnGc6O9uR1FgxCHP934P0GbvcKZ
         QSai4wHQIS8UpHsIkjqZ8JFFSxhWWFNG8t0iefVTojhEq/g0KQc9Q07J9SzpCgRiaOMC
         irym9/KJlrkDrwcQxwC1e37wlAjz3sECAU5fz1aAc0kDGKxBlVwssL2rAP/eSjccWgit
         Th6okGelkM9OV8oCtBVVqgEYcy4LF3VR33O8DfRbIZgyu7kaU3RljNvQ9I85i8FmJtcG
         KVvnJZjUhACFLbsmaZwpRnIUERTqM5ESV4/MaoDzuNU4zyILZ68GRJWpcKj2KwgfaCOK
         2qDw==
X-Gm-Message-State: AOAM532I9vMkuLfIZeCkcbkdJdwGFlG0hKYOMdQWWFiv0aTPxP1AYmf1
        PBWkTU5Fl2X1lyqcvhmf0Ery74yr1yp7Vmyk5eXfJw==
X-Google-Smtp-Source: ABdhPJxuxOY6aZUyjBnh7cuSqx9wWpYORShFAkS3wOwBe4x0wT3pJ/53NQryS1a+JqhW0WBAjH/EmcMgDm7r/a2nfls=
X-Received: by 2002:a25:6994:0:b0:629:1e05:b110 with SMTP id
 e142-20020a256994000000b006291e05b110mr17250131ybc.425.1647248271489; Mon, 14
 Mar 2022 01:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
 <CA+fCnZe-zj8Xqi5ACz0FjRX92b5KnnP=qKCjEck0=mAjV0nohA@mail.gmail.com>
In-Reply-To: <CA+fCnZe-zj8Xqi5ACz0FjRX92b5KnnP=qKCjEck0=mAjV0nohA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Mar 2022 09:57:15 +0100
Message-ID: <CANpmjNN-UPGOwkYWiOWX5DeSBWnYcobWb+M1ZyWMuSbzJQcFsg@mail.gmail.com>
Subject: Re: [PATCH] kasan, scs: collect stack traces from shadow stack
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Florian Mayer <fmayer@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 at 00:44, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Sat, Mar 12, 2022 at 9:14 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Currently, KASAN always uses the normal stack trace collection routines,
> > which rely on the unwinder, when saving alloc and free stack traces.
> >
> > Instead of invoking the unwinder, collect the stack trace by copying
> > frames from the Shadow Call Stack whenever it is enabled. This reduces
> > boot time by 30% for all KASAN modes when Shadow Call Stack is enabled.
> >
> > To avoid potentially leaking PAC pointer tags, strip them when saving
> > the stack trace.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > ---
> >
> > Things to consider:
> >
> > We could integrate shadow stack trace collection into kernel/stacktrace.c
> > as e.g. stack_trace_save_shadow(). However, using stack_trace_consume_fn
> > leads to invoking a callback on each saved from, which is undesirable.
> > The plain copy loop is faster.
> >
> > We could add a command line flag to switch between stack trace collection
> > modes. I noticed that Shadow Call Stack might be missing certain frames
> > in stacks originating from a fault that happens in the middle of a
> > function. I am not sure if this case is important to handle though.
> >
> > Looking forward to thoughts and comments.
> >
> > Thanks!
> >
> > ---
> >  mm/kasan/common.c | 36 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index d9079ec11f31..65a0723370c7 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -9,6 +9,7 @@
> >   *        Andrey Konovalov <andreyknvl@gmail.com>
> >   */
> >
> > +#include <linux/bits.h>
> >  #include <linux/export.h>
> >  #include <linux/init.h>
> >  #include <linux/kasan.h>
> > @@ -21,6 +22,7 @@
> >  #include <linux/printk.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/task_stack.h>
> > +#include <linux/scs.h>
> >  #include <linux/slab.h>
> >  #include <linux/stacktrace.h>
> >  #include <linux/string.h>
> > @@ -30,12 +32,44 @@
> >  #include "kasan.h"
> >  #include "../slab.h"
> >
> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +
> > +#ifdef CONFIG_ARM64_PTR_AUTH
> > +#define PAC_TAG_RESET(x) (x | GENMASK(63, CONFIG_ARM64_VA_BITS))
> > +#else
> > +#define PAC_TAG_RESET(x) (x)
> > +#endif
> > +
> > +static unsigned int save_shadow_stack(unsigned long *entries,
> > +                                     unsigned int nr_entries)
> > +{
> > +       unsigned long *scs_sp = task_scs_sp(current);
> > +       unsigned long *scs_base = task_scs(current);
> > +       unsigned long *frame;
> > +       unsigned int i = 0;
> > +
> > +       for (frame = scs_sp - 1; frame >= scs_base; frame--) {
> > +               entries[i++] = PAC_TAG_RESET(*frame);
> > +               if (i >= nr_entries)
> > +                       break;
> > +       }
> > +
> > +       return i;
> > +}
> > +#else /* CONFIG_SHADOW_CALL_STACK */
> > +static inline unsigned int save_shadow_stack(unsigned long *entries,
> > +                                       unsigned int nr_entries) { return 0; }
> > +#endif /* CONFIG_SHADOW_CALL_STACK */
> > +
> >  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
> >  {
> >         unsigned long entries[KASAN_STACK_DEPTH];
> >         unsigned int nr_entries;
> >
> > -       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> > +       if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK))
> > +               nr_entries = save_shadow_stack(entries, ARRAY_SIZE(entries));
> > +       else
> > +               nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> >         return __stack_depot_save(entries, nr_entries, flags, can_alloc);
>
> Another option here is to instruct stack depot to get the stack from
> the Shadow Call Stack. This would avoid copying the frames twice.

Yes, I think a stack_depot_save_shadow() would be appropriate if it
saves a copy.
