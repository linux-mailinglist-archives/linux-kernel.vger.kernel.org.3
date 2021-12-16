Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCABC476E99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhLPKNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbhLPKN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:13:29 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F72C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:13:29 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id t11so24907958qtw.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YRNyvvMx0D6cmoATqQzVllabSh/sAVBFjHpHuEs3K98=;
        b=QP5fMqjj2HERTi9+wi+qJlnEfdulm9t0JMh0e3fxdFg1Eptn92K/EJRkxC+dymhP1k
         rDgAGl9zjJiJy9Z2CLiM1aizonlBf8p4dYx8YPJOsMLDa2CtFG0KgjcUo/D/MpmW/Lfu
         E+y0YzFu6MrvdOrCWw1M+DOOVTvuWp2IKjjkf/hmk4SVjZuBczcjSDavSFfIJtyfp35V
         Gk4GCY/9fc4684sjRRdi1uVL3BVTL7yPcVOqrC5Fz/rzT/vBsyErQfuaCdNAfmtKskb9
         WF1IZa6maksSZ1RTQ16ie08YUAXwm3MzxFerPjTDYyrDPC/lZsZGY7ZL//NangtkxY0A
         raMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YRNyvvMx0D6cmoATqQzVllabSh/sAVBFjHpHuEs3K98=;
        b=l7YyTi5yVerD+QHaGIf39jhRvUpw8wWvPdyRsN38ah07GiHhbpNcKtTvplwhGFG0Qj
         JhXcgAYDd+3XqSZ5eQ3CL8SubpJ/3x243vk/973tZe45/6KIVgENDV1R50QkPSggN7Dx
         wWcIZVvWpMFdIwP40jPLc4/gsh525iQjFwMdyJURaWdLJnEhZk93y6hRrtGn537FBnu4
         17Egyhf0Tz2krRu0O/ihDEFHwHWieDLMUkWSLjn0VZ11TLkBac6H352f3vjIPI1t8yWm
         2rWOumGOyd+b3lv1qfpsk13bGcnlLgStcVy8Kw3Gn+90zF7fLhXJDbV+pfh0DcSZmoXG
         3XEg==
X-Gm-Message-State: AOAM533R5TbD9sYwkGrg6wtLDhHkct2VrOyQZ2MKhMHd8K+PJn538/U8
        4ArmNQJnM934t6hIdO09gBSNH7EpIH1dj/+N/+fskA==
X-Google-Smtp-Source: ABdhPJxFhNQBI4hw6cIRpJ3Bn2gy/Dy3Dn3EXkPsiZJ6PPFBQxKOA/co/dhObm1iQVeZPt6w2zfFhE/oIx5W4j8ixtU=
X-Received: by 2002:ac8:4e56:: with SMTP id e22mr16491312qtw.72.1639649608437;
 Thu, 16 Dec 2021 02:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <YbjIHa/1Qr/v8Q8J@kroah.com>
In-Reply-To: <YbjIHa/1Qr/v8Q8J@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 11:12:52 +0100
Message-ID: <CAG_fn=Ub57GfJwUuuKqfc0rhFOdRF9e=vgb4fwm_bXYziraFMA@mail.gmail.com>
Subject: Re: [PATCH 00/43] Add KernelMemorySanitizer infrastructure
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 5:36 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 14, 2021 at 05:20:07PM +0100, Alexander Potapenko wrote:
> > KernelMemorySanitizer (KMSAN) is a detector of errors related to uses o=
f
> > uninitialized memory. It relies on compile-time Clang instrumentation
> > (similar to MSan in the userspace [1]) and tracks the state of every bi=
t
> > of kernel memory, being able to report an error if uninitialized value =
is
> > used in a condition, dereferenced, or escapes to userspace, USB or DMA.
>
> Why is USB unique here?

syzkaller just happens to be good at fuzzing USB drivers, so it was
fairly easy to implement and test USB support for KMSAN.
This should give the maintainers of other buses an idea of how this
could be done :)

 What about serial data?  i2c?  spi?  w1?  We
> have a lot of different I/O bus types :)

We hope to cover those after KMSAN hits upstream.

>
> And how is DMA checked given that the kernel shouldn't be seeing dma
> memory?

Before writing a buffer to DMA, that buffer's contents are checked by
KMSAN. If there are uninitialized bytes, those will be reported.
After reading a buffer from DMA, it is marked as initialized to avoid
false positives.
We do not track DMA memory itself.

> thanks,
>
> greg k-h



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
