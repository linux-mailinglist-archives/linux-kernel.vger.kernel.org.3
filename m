Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9806248B7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiAKUPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiAKUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:15:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F38C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:15:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i5so813497edf.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIPHuIOvokpeNHmHUixV0mApYnjljbKFO0KUPR67zl4=;
        b=WkUrQMItIdviW32gVxTME1qmG78cK09N/WFqLy9Iv0myOcHM0JJ6ekcU8JpQUo1c6s
         EwUt9qH+HwlFUcOS9uJquiUQoS0opheUzJrb5L+hu3uiCv/lHpZjZUIRYpu+6riD7OVJ
         g1sIlIT7CN1X65a9ArD4h2V5w+0vG4Ns+U5Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIPHuIOvokpeNHmHUixV0mApYnjljbKFO0KUPR67zl4=;
        b=XD1mi/LH8vR6Yf1a57G2PzbcbSEkz9Q12ENf49wK2dbdlxuJtUVEJMBGgRBy4f1w2Z
         W9KL385e1lK7NYWvmEDAmlcJZbdSaf2tl4wjSOZIjYkPhWIkUvRev9Vu1R+c4n3gM55x
         rxp5k3FuDYeO5wiaENg86QSUWsaKaDB0ixf0C/SxqcfepBbNci1pgLhNnVceHcWNBmvr
         RbZoiubi1I5PC/78SKOzDYD2aNUd+l0fR/M8obpAgDODsdZ4wI2yR63vW6HvUUBUhBnT
         1DpZuppjzxAXXq1pW2secLKVHjjuqKKKBr51MlZaeahMg5wKtRzjrkcs9Nn1yEtMRKu1
         5Q+w==
X-Gm-Message-State: AOAM530Bw4hkztt9m6WDauew/LspzM4ufhdJxlPxRkStuy3sp4KXeWdo
        hjL1tHPyn9GSZOQAJ6+X+XUbFxNgeTAVWOdQsfU=
X-Google-Smtp-Source: ABdhPJzWxhvxUP7vTEhq4O4iTlIGW3NpY2dS2h5dBem15BSaX3oZu5bMKzTAxKnuYYCL6DDpx18A9g==
X-Received: by 2002:a17:907:7816:: with SMTP id la22mr5022217ejc.180.1641932114655;
        Tue, 11 Jan 2022 12:15:14 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id k16sm5439367edq.70.2022.01.11.12.15.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 12:15:13 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id t28so341395wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:15:12 -0800 (PST)
X-Received: by 2002:a5d:6083:: with SMTP id w3mr1708646wrt.281.1641932111796;
 Tue, 11 Jan 2022 12:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20220111071212.1210124-1-surenb@google.com> <Yd3RClhoz24rrU04@sol.localdomain>
 <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com> <Yd3dZklleDnJCQ46@gmail.com>
In-Reply-To: <Yd3dZklleDnJCQ46@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 12:14:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQ-qzKU8vyhgm8xsWE8DG6rR4jmbvOfBvbjVYq4SKQMA@mail.gmail.com>
Message-ID: <CAHk-=wiQ-qzKU8vyhgm8xsWE8DG6rR4jmbvOfBvbjVYq4SKQMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:41 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This is yet another case of "one time init".

Ehh. It's somewhat debatable.

For a flag that sets a value once, the rules are somewhat different.
In that case, people may simply not care about memory ordering at all,
because all they care about is the actual flag value, and - thanks to
the one-time behavior - basically whether some transition had happened
or not. That's not all that unusual.

But when you fetch a pointer, things are at least conceptually
slightly different.

Of course, you may use the existence of the pointer itself as a flag
(ie just a "NULL or not"), in which case it's the same as any other
one-time flag thing.

But if you use it to dereference something, then _by_definition_
you're not just fetching a one-time flag - even if the pointer is only
set once. At that point, at a minimum, you require that that thing has
been initialized.

Now, it's then absolutely true that the stuff behind the pointer may
then have other reasons not to care about memory ordering again, and
you may be able to avoid memory ordering even then. If you're just
switching the pointer around between different objects that has been
statically allocated and initialized, then there is no memory ordering
required, for example. You might be back to the "I just want one or
the other of these two pointers".

But if you have something that was initialized before the pointer was
assigned, you really do hit the problem we had on alpha, where even if
you order the pointer write side accesses, the dereferencing of the
pointer may not be ordered on the read side.

Now, alpha is basically dead, and we probably don't really care. Even
on alpha, the whole "data dependency isn't a memory ordering" is
almost impossible to trigger.

And in fact, to avoid too much pain we ended up saying "screw alpha"
and added a memory barrier to READ_ONCE(), so it turns out that
smp_store_release -> READ_ONCE() does work because we just couldn't be
bothered to try something more proper.

So yeah, READ_ONCE() ends up making the "access through a pointer"
thing safe, but that's less of a "it should be safe" and more of a "we
can't waste time dealing with braindamage on platforms that don't
matter".

In general, I think the rule should be that READ_ONCE() is for things
that simply don't care about memory ordering at all (or do whatever
ordering they want explicitly). And yes, one such very common case is
the "one-way flag" where once a certain state has been reached, it's
idempotent.

Of course, then we have the fact that READ_ONCE() can be more
efficient than "smp_load_acquire()" on some platforms, so if something
is *hugely* performance-critical, you might use READ_ONCE() even if
it's not really technically the right thing.

So it's complicated.

A lot of READ_ONCE() users exist just for historical reasons because
they predated smp_store_release/smp_load_acquire. They may well have
been using ACCESS_ONCE() long ago.

And some are there because it's a very critical piece of code, and
it's very intentional.

But if you don't have some huge reasons, I really would prefer people
use "smp_store_release -> smp_load_acquire" as a very clear "handoff"
event.

              Linus
