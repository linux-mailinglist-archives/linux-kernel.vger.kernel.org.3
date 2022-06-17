Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A254FD49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiFQTJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiFQTJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:09:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD365562E6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:09:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id es26so5661506edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HqVDx/x+rV9pKzCWWdeqEJ7q1aea98z4AeXGaYWkE0=;
        b=ZEUhP60nI0xEZ1b6iNDV9mZsAi10PJrW03J5aQt7Zk9mniXx8w5IdeTpWG1GfzKwLi
         PcBVWk+K0D8fuK/FuO/Ntyigy0HR2T0gPIv27Ggp/dftPExqzhfuoaP4yaEqPPM8fAQI
         2XvG+9CNYptz531VG2pB23NQP6X+3Ea4Ibs1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HqVDx/x+rV9pKzCWWdeqEJ7q1aea98z4AeXGaYWkE0=;
        b=tgo8fZIuotFXNwkNNHvhhWkQ5r9TpsJWuFZhMcwJsjiPBHFZr9YGvrEuJaAo4kotcp
         WCTNHaVebeuwMOB+0MOYdlCA5609RHesjzROjfiGX23VmeHn/yOAB3W2OPy8QCJUXPrR
         V/mbG+/5rCmzQldKOxEFWGoDbSJqoS9cpj5IkyNaAfed0Z4GlnntDmO0Pj5oUpss+4xs
         KbvQgn6l2PLtJhg9h+yY3wufcTK3tNCiwJ7wOXJkaiPd7Bag1a77cC7kBY9XEubXul8O
         6EhU/OSjLYXi72OQqMSoWZaKIjVduAVw2+2f+g+wvcZ7LxQ/JzZFCbNYl70H/3DaXptm
         Zu2Q==
X-Gm-Message-State: AJIora9P/O2TmO255KpIn7JDdjlxBhoFYA2RwpNQmnetHKZLjBrCekBy
        PNho2EkWiW2xhJKh9o4Lir6m721QjQpwocML
X-Google-Smtp-Source: AGRyM1sAg4Ew8Xgk6c0Zxqz2+eXOYFssG6nfMEEtjvtmNNPbEudN7gN5ekTfv0Q8kxgsU//rvLCtUw==
X-Received: by 2002:a05:6402:528f:b0:42a:c778:469e with SMTP id en15-20020a056402528f00b0042ac778469emr13995957edb.404.1655492947010;
        Fri, 17 Jun 2022 12:09:07 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id g10-20020a056402424a00b00435390befe2sm3524501edb.58.2022.06.17.12.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:09:05 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso4809511wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:09:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id
 h2-20020a05600c498200b0039c3c0d437cmr11620476wmp.38.1655492945244; Fri, 17
 Jun 2022 12:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com> <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
In-Reply-To: <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Jun 2022 14:08:48 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjJwAWgqEjwes3TbUV-_=fLcT2v-OK3QGWvPy+m8n=rOg@mail.gmail.com>
Message-ID: <CAHk-=wjJwAWgqEjwes3TbUV-_=fLcT2v-OK3QGWvPy+m8n=rOg@mail.gmail.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
To:     Eric Dumazet <edumazet@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Fri, Jun 17, 2022 at 12:45 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Were rwlocks always unfair, and we have been lucky ?

Yes, rwlocks have always been unfair.

And the unfairness is very fundamental: it is what allows you to take
a read-lock without disabling interrupts (or softirqs), and still
allowing interrupts to *also* take the lock for reading.

That's actually a big deal for some things, with the tasklist lock
being the traditional thing, but there could be others.

Because with a fair lock, you'd have deadlocks when CPU1 gets the lock
for reading, then another CPU blocks on writing (with interrupts
disabled), and then CPU1 takes an interrupt and wants to read again.

This is not going to change.

If you want fair rwlocks, you have a couple of options:

 - add a new explicitlly fair version.

 - don't use rwlocks from irq or softirq context

 - use another lock entirely (spinlocks are fair, and often perform better)

You do *not* get to change behavior that has been there since day#1
and that very core code very much depends on.

In fact, the fact that you use a read_lock from softirq context makes
me suspect that you yourself might be in danger of deadlocking due to
that "look, another CPU is trying to get the write lock" deadlock
situation.

Because the only way to fix that deadlock is

 (a) unfair rwlocks like we have now

 (b) having to disable interrupts around all read-locked regions

and (b) often basically means that the whole point of using a rwlock
goes away, because it is now much more expensive.

             Linus
