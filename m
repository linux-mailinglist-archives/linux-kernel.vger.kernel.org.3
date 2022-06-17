Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF854FD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiFQTTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiFQTTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:19:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F73A34642
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:19:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ej4so3437560edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DI1RxyMzElXtlcQrNQZug30SgE2uSFwxG1kHH+iR6eM=;
        b=OZMdtgldn2H7V3EtlQ5+jBb7O1GqZR6ZtJXHPkuqA2kIoPKyFiMkzZvQ31Bnq4pQii
         HnoV3nD8jo9ufRDwBXvwpAw75D+Tsne78FPMg8gEP+jrgUZ1k8g1sEu8+vVSPjwhn6iF
         zIy93qLf+DfBMXjP6Vs/ehN6+BnkJSdbH0ZCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DI1RxyMzElXtlcQrNQZug30SgE2uSFwxG1kHH+iR6eM=;
        b=tppv99ytj+EZxYrNl4hVJaNIy81TN/yceJgqFGtXDo9gvCztbnnk4X9N4ozl8sdt4e
         y1U2M3eBT5/XROdJCUQkv7zCYvjz7Ox/Uuaujh2fveiCQ56CtwLL0wApIYMP8HYbGlVA
         gXhthcP3hf1+9nQACJAf2KouQ2hKB7KshhE9PwjGUCyVE5OTXS4juzavxXP9XuLXfHTI
         OkaoWpzYlePDOeFOUDX1kCVSYFiRI4b65EaeBVIs79wMlijb1xd0C8r6Rga/ntUrozPz
         toOAJ8OExl+xwUmCko/0qZeoE6oy08gPeZoUCUUR9BLQS7MTYwNIBFoAqc8r5P1pTTjB
         1Xlg==
X-Gm-Message-State: AJIora/7CiqtuWzuc0/wPkwsfZ3rU3bA7MhKaFCm9ELV+zYeQC7vzqv0
        ywNh1XgF9y9vobDVtI58+qeuwkqQ4b2JHw/g
X-Google-Smtp-Source: AGRyM1sSW6j24TaXxkn1cI+lePMniNW5CXmGr1Cy56MU7yo1KrXUnq6PzkaP1X80mDnzFFrKsAsO5w==
X-Received: by 2002:a05:6402:42d5:b0:433:1727:b31c with SMTP id i21-20020a05640242d500b004331727b31cmr14176207edc.9.1655493589781;
        Fri, 17 Jun 2022 12:19:49 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id r26-20020a056402035a00b00435201d96f8sm4260036edw.16.2022.06.17.12.19.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:19:49 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id q9so6884818wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:19:49 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr4117896wrx.281.1655493588814; Fri, 17
 Jun 2022 12:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com> <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net> <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
In-Reply-To: <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Jun 2022 14:19:32 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
Message-ID: <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
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

On Fri, Jun 17, 2022 at 2:10 PM Eric Dumazet <edumazet@google.com> wrote:
>
> So I wonder why we replaced eventpoll spinlock with an rwlock.

Yeah, usually we've actually gone the other way.

Spinning rwlocks are seldom a big win, unless you can get some
secondary indirect win out of them.

That secondary win is often:

 (a) unfairness is usually very good for throughput (iow, the very
unfairness that you hit may *be* the reason why it looked good in some
benchmark, and people decided "ok, let's do this").

 (b) the special case of "interrupts take the lock for reading only"
thing that allows other readers to not disable interrupts

IOW, the win of a spinning rwlock is not necessarily the "we allow
multiple concurrent readers" that you'd expect, because if you have
small sections of code you protect, that just isn't a big deal, and
the costs are in the lock bouncing etc.

It's also worth pointing out that rwlocks are only unfair *if* they
hit that "reader from (soft)interrupt" case. Which means that such
cases *really* had better either have very very short locked regions
(with interrupts disabled), or they really need that (b) part above.

And yes, the tasklist lock really needs the (b) part above. Disabling
interrupts for task traversal would be completely and entirely
unacceptable, because the traversal can actually be fairly expensive
(lots and lots of threads).

I suspect eventpoll just did the wrong thing.

              Linus
