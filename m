Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168BE4B92AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiBPU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:58:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiBPU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:58:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600C41FFCBC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:58:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCDEA61977
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBDFC004E1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:58:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="afAwUJHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645045108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vm56TpHVvV+qdbi0Jo/k3CXXVkfce+ElHncK+ZkoLLc=;
        b=afAwUJHMlJD0KBlyfDlYE+iWYc8938LSu2B0llv6WGYJt9fS10xUHN/f0tiGjNjQD0Wx6z
        Sba62ikxaoTz4zoR3d7Nat7u4yyf77XDi6n6QOjm/v8qPjS4skJy5F1HtsJqrwPN3zqbAM
        GXz1rdZE8Df4GYU+mI41OCT+KGNoZ2k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 95f9a213 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 16 Feb 2022 20:58:27 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d07c4a0d06so12190907b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:58:27 -0800 (PST)
X-Gm-Message-State: AOAM531PbfXUCOW9K8Y+QlMtFjay219Mb3zQX7YlzoZv/WG0zgXIs0kQ
        Hn5qVdvd/WjpBH5tPFxuluD7PW5MkxmS7zVm5Ic=
X-Google-Smtp-Source: ABdhPJyGFWqPQS+KATBkGcXUscX4JVxD5y/x8JiKI/0SnSFKLjGlmVKGkSEyCZ7bkQCQ2CxLAvAaaKXd6TN4wgYzTJQ=
X-Received: by 2002:a81:7d04:0:b0:2d0:d0e2:126f with SMTP id
 y4-20020a817d04000000b002d0d0e2126fmr4026278ywc.485.1645045105719; Wed, 16
 Feb 2022 12:58:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pO41uwYExSROc5X2+RE=a5tZfE=c=bAxVbhCHfa7=zSA@mail.gmail.com>
 <20220204155142.56419-1-Jason@zx2c4.com> <Yf1M3YGVq71oC9BM@linutronix.de> <CAG48ez1ucJikx_6GzK2XUfCGoTeL+R418riTn+ECj_ud5BSFow@mail.gmail.com>
In-Reply-To: <CAG48ez1ucJikx_6GzK2XUfCGoTeL+R418riTn+ECj_ud5BSFow@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 16 Feb 2022 21:58:14 +0100
X-Gmail-Original-Message-ID: <CAHmME9q6bm_pXer0aVq907-RevtH8nLPH=Uo2UU6gEKU6GaFwA@mail.gmail.com>
Message-ID: <CAHmME9q6bm_pXer0aVq907-RevtH8nLPH=Uo2UU6gEKU6GaFwA@mail.gmail.com>
Subject: Re: [PATCH v3] random: remove batched entropy locking
To:     Jann Horn <jannh@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 9:01 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Feb 4, 2022 at 4:57 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > On 2022-02-04 16:51:42 [+0100], Jason A. Donenfeld wrote:
> > > index 455615ac169a..3e54b90a3ff8 100644
> > > --- a/drivers/char/random.c
> > > +++ b/drivers/char/random.c
> > > @@ -1759,41 +1762,54 @@ u64 get_random_u64(void)
> > >       unsigned long flags;
> > >       struct batched_entropy *batch;
> > >       static void *previous;
> > > +     int next_gen;
> > >
> > >       warn_unseeded_randomness(&previous);
> > >
> > > -     batch = raw_cpu_ptr(&batched_entropy_u64);
> > > -     spin_lock_irqsave(&batch->batch_lock, flags);
> > > -     if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
> > > +     batch = this_cpu_ptr(&batched_entropy_u64);
> > > +     local_lock_irqsave(&batch->lock, flags);
> >
> > Does this compile and work? From the looks of it, this should be:
> >
> >         local_lock_irqsave(&batched_entropy_u64.lock, flags);
> >         batch = this_cpu_ptr(&batched_entropy_u64);
> >
> > and we could do s/this_cpu_ptr/raw_cpu_ptr/
>
> Why raw_cpu_ptr? include/linux/percpu-defs.h says about raw_*() operations:
>
>  * Operations for contexts where we do not want to do any checks for
>  * preemptions.  Unless strictly necessary, always use [__]this_cpu_*()
>  * instead.
>
> So when I see a raw_*() percpu thing, I read it as "it is expected
> that we can migrate after this point (or we're in some really weird
> context where the normal context check doesn't work)". Is that
> incorrect?

If it says "contexts where we do not want to do any checks for
preemptions", then that would apply here I would think? We're taking a
local lock, which means afterwards there are no preemptions. For
context, the code that got committed after Sebastian's final review
is:

        local_lock_irqsave(&batched_entropy_u32.lock, flags);
        batch = raw_cpu_ptr(&batched_entropy_u32);

However, I think most other code uses this_cpu_ptr() instead? So not sure.

Jason
