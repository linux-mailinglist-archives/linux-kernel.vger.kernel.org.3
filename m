Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8D4733E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbhLMSVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhLMSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:21:23 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D80C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:21:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g14so54189661edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8936iJXYzuQp1jpHlnVzWPD6pUJirOWbwtdpnJXACKE=;
        b=hzrGIorLE9Itm3KY9FMkg4bpBZO3+2x9d1Sxj1q8o+BvYsDL30klxGsR0Z6pNZkAZX
         Zs/VohMwcPKnWcMC68+vx9B7bZDwVlkeICMYrN1drsdOYJiXbH/A3QYh1mmsp4QuwZio
         78W/sVYC6g7BZPEZTSlDgYjlsL87503ZcgO90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8936iJXYzuQp1jpHlnVzWPD6pUJirOWbwtdpnJXACKE=;
        b=H2nl4jnsG1//h8OY9LtO4PRRRqcrh7SsjkyxXzxxtzQAiI1kE6dDZ/jQaJKmIVVrCU
         oBhvpt4vnILuFPjatwO6NLAoQWLJvrbr2D98IeJO7qAACE9Az58ra1F/cYoSSRJVClIy
         Fdobpt2cVSCCF2sApPPJpz/EBtfqs3VslyWQJO9L44fWgXBWQRj/bRcSqcJeMY1V5+pr
         Uod8YrNAgGSznVvlgvMrXUgeLQSKibx5ysN6AZ8z/E9RzhQNM/bJvkNrTLBL18gkvgwC
         8Z9KDOiErjWfsQiaBhIOPPMHv4MXy7kPScg2dVsWFfNYhvDB/2U3mwXQtjDbMlHN5d/1
         RB8Q==
X-Gm-Message-State: AOAM531H5Ad8tg/r/fc7as0pmXXPSXjz8p7eCRkCoPDCf8qROKfZ2m4N
        bjsVvNuWJq9w8HbIIL3ppz7nUEgqtfeRIZJG
X-Google-Smtp-Source: ABdhPJwRrfAAUetpsDDzqgLzg4h4xmV6BxZpVPwiHFRYfElI9a0gVeCMBprciMYoT7DCyGrZ5csv2w==
X-Received: by 2002:a05:6402:42:: with SMTP id f2mr583212edu.204.1639419681321;
        Mon, 13 Dec 2021 10:21:21 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id du16sm423394ejc.183.2021.12.13.10.21.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:21:20 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so12171619wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:21:19 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr39723062wmq.8.1639419679279;
 Mon, 13 Dec 2021 10:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20211210161618.645249719@infradead.org> <20211210162313.857673010@infradead.org>
 <20211213164334.GY16608@worktop.programming.kicks-ass.net> <CAHk-=wjc+mr_Rh++5pPDkNFuceyPwFxCtzp124AppBLgbVVV0A@mail.gmail.com>
In-Reply-To: <CAHk-=wjc+mr_Rh++5pPDkNFuceyPwFxCtzp124AppBLgbVVV0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Dec 2021 10:21:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wide=L5-UK34Rh11=H8wjWKJ9icmqtB3jSmUwCMQH=Spw@mail.gmail.com>
Message-ID: <CAHk-=wide=L5-UK34Rh11=H8wjWKJ9icmqtB3jSmUwCMQH=Spw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] atomic,x86: Alternative atomic_*_overflow() scheme
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But then on x86 - and other architectures that might prefer to use
> that offset trick because they have flags - I'm not sure it even makes
> sense to have anything to do with 'atomic_t' at all [..]

Side note: it might not be just about flags, and not just about things
like "offset-by-one".

We used to have special code for old 32-bit sparc because there you
couldn't actually sanely do 32-bit atomics: you could only really do
24 bits, because the whole first (upper) byte was the atomic lock
byte.

Now, that was too painful because nobody else did that, so these days
32-bit sparc just uses a hashed spinlock instead.

But I think it would be lovely to _design_ the atomic_ref_t to be able
to deal with that odd sparc32 issue too. Not because anybody cares
about 32-bit sparc any more, and not because I think anybody would
ever actually bother to write such code, but because I think it's a
good design goal to kind of aim for: if we're doing an actual
ref-counting data structure, where we do *not* have "int" semantics,
and very much have a concept of overflow, then I think it should
conceptually also work with that odd sparc32 24-byte atomic integer
model.

Was it a broken model? Was it stupid? Yes. Do I ever expect to see it
again? No. But I do think that conceptually we should strive to have
that as a _possible_ model.

In fact, it might be interesting to have something like that as a
debug model, where you have a smaller range for ref-counting, just to
make it easier to test that the code does the right thing for
overflow. 24 bits is a lot easier to overflow, while still being big
enough to work in practice.

So I do think that having a separate type system that simply does not
_work_ with somebody trying to do "atomic_xyz()" on it is the right
way to go.

              Linus
