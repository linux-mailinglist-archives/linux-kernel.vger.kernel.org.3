Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480854FDB5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiFQTf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFQTfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:35:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171FA45AC6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:35:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 25so7427795edw.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmMKIaHn/lJTjmCsykKCt9XT6H8Qsb3yGwN5zvVmoPo=;
        b=KMDI/QIl3TzR4HQOzclvAzyn+GZoO4/UdB5GcWtbsstZxEclNwlGdNEmTLyh1D7Rcu
         TRwVeQzr+7oaG+vdSYs12BHCacXglgTT1/gtthYzO1iNcOTicnf9uaouyc6ZS8FTZTSi
         nRlrOSVVvk0son4VtLTZKXcxOIR/7WwTWAm0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmMKIaHn/lJTjmCsykKCt9XT6H8Qsb3yGwN5zvVmoPo=;
        b=FooAYjf5EgKDhL18Bwsvv7yyv7G6NDsRafhMIy5KsBCOZVSnzdvfiFl6N0myzA8nm0
         BdEj7abPdXQQfwCI2+HeVYVKEb29XHO2PxVFEnK7P26vlNMMMs2CDpKm8VwKFdBIT6YX
         aReWnLrpnC6mAmJPpbV5E+PrpXUoCDdELgCH3rYKQHHcJg02/+fGAR+nj6Fu3fJDKgoz
         9Db4H8zSH/lJxQdSm+bug9ls9tGPnOkIo3N5JIfyjuuBqBiN54xO9qAvFuoyqop+O/uJ
         9YGQqMvf2H9Aym+6I/PcCX6ApdAt3fviE5UQH1VmNDn3BXAOe2NizF8u0QD3QaIyMJwm
         LjHA==
X-Gm-Message-State: AJIora/yrVCA+clpiP7Ha+3f5+UhWc9+Sox/ZAhwJq56Q1NH/Cq715p6
        1m31f2K/nVIb5JKoBFotTU26botP2GlbnX4b
X-Google-Smtp-Source: AGRyM1vzhc93TYPbsrd2p9dBysCXTz8pS6/3+21ChOvrt+wiWWcDlSZ6cFxfg7tY7ZZa1S95x3yjHg==
X-Received: by 2002:a05:6402:3688:b0:42d:d3ba:4725 with SMTP id ej8-20020a056402368800b0042dd3ba4725mr14529823edb.212.1655494518374;
        Fri, 17 Jun 2022 12:35:18 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id eq20-20020a056402299400b0042deea0e961sm4045562edb.67.2022.06.17.12.35.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:35:17 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id g4so6910927wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:35:16 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr10778300wrf.193.1655494516234; Fri, 17
 Jun 2022 12:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com> <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net> <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
 <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com> <CANn89i+wBM+ewcP9u+ZWDqv3zQeK7ovKB+YJf9S6Om5QkqhLHA@mail.gmail.com>
In-Reply-To: <CANn89i+wBM+ewcP9u+ZWDqv3zQeK7ovKB+YJf9S6Om5QkqhLHA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Jun 2022 14:34:59 -0500
X-Gmail-Original-Message-ID: <CAHk-=wi9ut1VkB=Ja_gYtH67DZ7cc5QBG-uJCPkOpU=MZDJSUw@mail.gmail.com>
Message-ID: <CAHk-=wi9ut1VkB=Ja_gYtH67DZ7cc5QBG-uJCPkOpU=MZDJSUw@mail.gmail.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
To:     Eric Dumazet <edumazet@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 2:25 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Interesting...
>
>  I think getrusage(RUSAGE_SELF) is blocking interrupts in the
> possible long loop:

Yeah, that looks bad.

It needs that interrupt disable due to sighand->siglock, but normally
we would expect to *not* have a big loop inside the siglock.

Nasty.

I wonder if this is possibly a situation where we should actually make
siglock be a rwlock.

But considering that this RUSAGE_SELF is hopefully a special case,
maybe we could write it differently.

Instead of taking the sighand lock, we might be able to iterate just
over the regular thread list (using the tasklist lock), and then do
the "does sighand match" as a one-off check in
accumulate_thread_rusage().

It's not like we even really need that strict locking there, I suspect.

Anyway, I should have noted in my previous email that my "rwlock is
often not the win you'd think it is" that that is only true for this
*spinning* rwlock.

For the actual sleeping reader-writer lock (down_read/down_write and
friends), the whole "you can have multiple readers" is often a *huge*
deal and very central to using a rwlock. It's literally just the
spinning one that is often better as a spinlock unless you have those
magical reasons to use it.

              Linus
