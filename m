Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5D4F4719
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiDEU7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457334AbiDEQDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:06 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3F35ABD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:38:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 125so15583885iov.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oiy4ymydbM7WhtHftpHVioZDVdSgqELYIqmQkx6duOw=;
        b=ihYjRwCIZTZwXJPzTOWwXK3ednGB5hCoNS1RNHgt1AdElXNvPJiQGMuSWIys6jLwHM
         hJcEcd/i+mJbqgiTM/QqEMB3jro9dJ6W0v3I+Ty0YNprxSTmdDUpdDZeq3b6WUyBHDN5
         a4qxa6AkA5XahcZHSQTXwD24ZAAeQfxg9DUEOkqZ7Y1wTQZYplqniPZvmjXU1AgRdpzo
         BnAUl8ZsT1JkCpuftrQ/cfzcpCavx7DlzaraGcW3E7Dg3ojL/5b2oOkTNNfYYLeLaZQO
         nhdojGE0QsWyA0cvn+icLNQTxGFI/wQode6hKOboLUuwaB5P5ZoMTYCIclNR9XEXFc8m
         o1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oiy4ymydbM7WhtHftpHVioZDVdSgqELYIqmQkx6duOw=;
        b=PNRMA5LAoVga49WH5hPQfxTkyarVNY3sF0mL7JCk7Hm++Nf8HZ2VgDJmPGkb+9j5gr
         g5vd6LRe1TiM53A/U+cpB31/DMNbpJgPAQ1ERPHaeviWyTQmy8BamV76WUpk0e+6ebCV
         fk/FtZFQTNbiNGm4RZH0040NFYvjcE7SatIdNwey7NDRzNLB/zgNGQ7toFr+BntBZa5k
         Ld45me4PH/ByrR2Qd6HYTCZ58shCf9UFrKB7pvQJVDO1i9Rg4Hs0uKAl9J5dp2q9yKCa
         sffGMADZtvonddYKRQ+P2w8ZLGt/ecX+0bZemRNl2vyHnaHow/TEqjfjqgX4FD33lmeW
         gZJQ==
X-Gm-Message-State: AOAM533AVvl0zitb/WUKRWiMak6lXN+JzYah84NF0OY3NxP8TdkS8Ri8
        KzaBYIxnDthL5k/XPliF3OeQIPP6NfgcBusCTys=
X-Google-Smtp-Source: ABdhPJwX8TxPVTrXNP9ml2a4Ds0AfLhTgqMeoGckQ8JopyAaiiqQLa8ounWMHtg7A7wBY4P3eqcIN7bQAQFXYIm6uWA=
X-Received: by 2002:a6b:116:0:b0:648:bd29:2f44 with SMTP id
 22-20020a6b0116000000b00648bd292f44mr2028950iob.56.1649173098285; Tue, 05 Apr
 2022 08:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <0bb72ea8fa88ef9ae3508c23d993952a0ae6f0f9.1648049113.git.andreyknvl@google.com>
 <YkV1ORaR97g45Fag@FVFF77S0Q05N>
In-Reply-To: <YkV1ORaR97g45Fag@FVFF77S0Q05N>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 5 Apr 2022 17:38:07 +0200
Message-ID: <CA+fCnZc0--X_bQDEr+3kgimFL3zGm-kBL-5Tx6KLYybUd3zEzA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: implement stack_trace_save_shadow
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
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

On Thu, Mar 31, 2022 at 11:32 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> This doesn't do any of the trampoline repatinting (e.g. for kretprobes or
> ftrace graph caller) that the regular unwinder does, so if either of those are
> in use this is going to produce bogus results.

Responded on the cover letter wrt this.

> > +noinline notrace int arch_stack_walk_shadow(unsigned long *store,
> > +                                         unsigned int size,
> > +                                         unsigned int skipnr)
> > +{
> > +     unsigned long *scs_top, *scs_base, *scs_next;
> > +     unsigned int len = 0, part;
> > +
> > +     preempt_disable();
>
> This doesn't look necessary; it's certinaly not needed for the regular unwinder.
>
> Critically, in the common case of unwinding just the task stack, we don't need
> to look at any of the per-cpu stacks, and so there's no need to disable
> preemption. See the stack nesting logic in the regular unwinder.

The common unwinder doesn't access per-cpu variables, so
preempt_disable() is not required.

Although, in this case, the per-cpu variable is read-only, so
preempt_disable() is probably also not required. Unless LOCKDEP or
some other tools complain about this.

> If we *do* need to unwind per-cpu stacks, we figure that out and verify our
> countext *at* the transition point.

I'm not sure I understand this statement. You mean we need to keep the
currently relevant SCS stack base and update it in interrupt handlers?
This will require modifying the entry code.

> > +
> > +     /* Get the SCS pointer. */
> > +     asm volatile("mov %0, x18" : "=&r" (scs_top));
>
> Does the compiler guarantee where this happens relative to any prologue
> manipulation of x18?
>
> This seems like something we should be using a compilar intrinsic for, or have
> a wrapper that passes this in if necessary.

This is a good point, I'll investigate this.

> > +
> > +     /* The top SCS slot is empty. */
> > +     scs_top -= 1;
> > +
> > +     /* Handle SDEI and hardirq frames. */
> > +     for (part = 0; part < ARRAY_SIZE(scs_parts); part++) {
> > +             scs_next = *this_cpu_ptr(scs_parts[part].saved);
> > +             if (scs_next) {
> > +                     scs_base = *this_cpu_ptr(scs_parts[part].base);
> > +                     if (walk_shadow_stack_part(scs_top, scs_base, store,
> > +                                                size, &skipnr, &len))
> > +                             goto out;
> > +                     scs_top = scs_next;
> > +             }
> > +     }
>
> We have a number of portential stack nesting orders (and may need to introduce
> more stacks in future), so I think we need to be more careful with this. The
> regular unwinder handles that dynamically.

I'll rewrite this part based on the other comments, so let's discuss it then.

Thanks!
