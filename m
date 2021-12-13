Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A2E4733EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbhLMSZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhLMSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:25:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9515C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:25:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r25so54589354edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9QkkvTopjVhiotJwEjgopR1B8bJ1qN8bAX4PSwUoSk=;
        b=atSePMRG15KGEzzBKt+bDeg7v8T/67BK1osJkUil9a7Qf30KScMHB6aOot6RolXTRs
         dw7GvYXV123uTbkSX4TdkD/x2izLgVvFyX5qdfsEjKmi9uOCu/CTZb9win5EV8h+Op5M
         WfdG55arjO/Y50om/TeJ6q9SzFxe2LrOwXBXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9QkkvTopjVhiotJwEjgopR1B8bJ1qN8bAX4PSwUoSk=;
        b=xxbaMGaOA95NFZtH3lTQDwcWQD7udDxQXqRDtLu1uBTgzunkZ1hYG2r32n7vUt8mh6
         4Saz3lGfQYYUGXn32kw4vFNA6W0ZkkTM1Ea4Dg11cayG74EMlw0TCXKm26upI/AF44ab
         TExVnrV1wlIaOqxeNrvSdyotNNIVg/y7xcFwdvFMx1KDghARFzak9FUNp04a5mGfWnQC
         v7X3lnDxoQYvO+p1DuNpyWvu1sqtWt48CkB61K0Ndm+9Vj1a3h+VJ3UgEODHoFTrOxAw
         F7QD2oqJbyZZCOfbOLvKpusBvT5Ao5jTSL7orcoUoQewYx4RVYSUKtpNJBrnElbPsRY6
         eJyw==
X-Gm-Message-State: AOAM5317NSGz1Dfn0IZ8yZzG7FZtG9n4K9mnGhlzxNU/Bj2DDFQz5Y2L
        +Hd0KfYu00N8yB/dqLdTwhOUaNIZWLJMkxRM
X-Google-Smtp-Source: ABdhPJywtGZgEIASkyayh/Wt4oJYvqc0x2rqP5uV/t7pmFh1PBUBaKcy5+j9uVXnvMfqnqp2FrkVHQ==
X-Received: by 2002:a17:907:60cd:: with SMTP id hv13mr32719ejc.712.1639419904380;
        Mon, 13 Dec 2021 10:25:04 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id o21sm406983ejy.181.2021.12.13.10.25.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:25:02 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id k9so10794420wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:25:02 -0800 (PST)
X-Received: by 2002:adf:e646:: with SMTP id b6mr199250wrn.442.1639419901892;
 Mon, 13 Dec 2021 10:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20211210161618.645249719@infradead.org> <20211210162313.857673010@infradead.org>
 <20211213164334.GY16608@worktop.programming.kicks-ass.net>
 <CAHk-=wjc+mr_Rh++5pPDkNFuceyPwFxCtzp124AppBLgbVVV0A@mail.gmail.com> <YbeOjq20FCdzcK1Q@elver.google.com>
In-Reply-To: <YbeOjq20FCdzcK1Q@elver.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Dec 2021 10:24:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicxUkovFa7D0YyhSweMVbL47VDimr-nytxr93SbgV9oQ@mail.gmail.com>
Message-ID: <CAHk-=wicxUkovFa7D0YyhSweMVbL47VDimr-nytxr93SbgV9oQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] atomic,x86: Alternative atomic_*_overflow() scheme
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:19 AM Marco Elver <elver@google.com> wrote:
>
> I'm still genuinely worried about this:
>
> >       2. Yet another potentially larger issue is if some code
> >          kmalloc()s some structs containing refcount_t, and relies on
> >          GFP_ZERO (kzalloc()) to initialize their data assuming that a
> >          freshly initialized refcount_t contains 0.
>
> Even with everything properly wrapped up in atomic_ref_t, it's not going
> to prevent mis-initialization via kzalloc() and friends.

I agree that it's an issue, but it's not a new issue. We've had the
exact same thing with a lot of other core data structures.

And a ref-count of zero isn't valid _anyway_. When you allocate a
structure, a zero ref-count by definition is wrong. You need to set
the ref-count to the user that allocated it.

So I don't actually think the "implicit zero" is an issue in practice,
because it would be wrong in the first place. Code that relies on
kzmalloc() to initialize a refcount cannot work right.

(And by "cannot" I obviously mean "can, if you do wrong things" - it's
not like it's *impossible* to do an "atomic_inc_ref()" to change a 0
refcount to a 1, but it's both wrong *AND* actively stupid, since an
allocation does not need to set the refcount atomically).

             Linus
