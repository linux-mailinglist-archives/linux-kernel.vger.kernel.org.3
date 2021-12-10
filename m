Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98351470674
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbhLJQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244249AbhLJQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:57:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDD4C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:53:48 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so31501074edd.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nTOg8rJWU8BdSZlmSj1JbyQAWkIqyTD+0WbjfFOnMk=;
        b=PCw582JVM5mAG4YE2zRRSnTu65r0baerxHsDk/EtQJkxzIreRmva1a/NRZSKascAcg
         gMC55Q6Y31pQrS07rXbX9Iw5fR2hLArDYNpwYIYJdnLHbkLdE2xjFjIt0buanxRlxHYl
         3SULjuLfotmj+FLuWrm/Y4w5DrSyN/tXEJc3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nTOg8rJWU8BdSZlmSj1JbyQAWkIqyTD+0WbjfFOnMk=;
        b=I/WpSmXztosEhGGBlAJad414TVGghR3bzJZ4PTEjU0wrumB1V1lcRFj7DUTCBIFmAx
         LCxekxzcstPx1E9xddEDmfQ3WIt55FANpUBSneH+lqZmphotzB59W826ybGDyQ4qWa7S
         yc7CX35d0FjStpzQAFJXHTCrn1BmaVltfuTWjsSodELwuUrMTcgcp5SszRgxO9QXfc5r
         UQdi81vWMZrcMl0vQr5csxGNI4uLcsYMlEvuxS2q1Mz6jlzgaVKGnUSxCQQKOTKGRYqu
         qWJozqowf0CwKK5/iZ13M53DvS7sepSBK5QUtCxvYhHaDVUyiF+z7Lm2U3w+/btVKDuF
         NfWg==
X-Gm-Message-State: AOAM532BKJu1HTjz0FCOgJWbE/K8LIjesqFGJP/jdIuXTr48wuYhOd82
        NsoT+PrITdGq2NBBX3BzzAasTdpK0XSjACk4Acc=
X-Google-Smtp-Source: ABdhPJxJonNPnsXLIYw/HFNaG3klqt3iV+R5wto3/25+YmItyHLaLEed99jhxrTQ+1qFdD1+sope0w==
X-Received: by 2002:a05:6402:1911:: with SMTP id e17mr39760972edz.43.1639155226406;
        Fri, 10 Dec 2021 08:53:46 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id s16sm1729876edt.30.2021.12.10.08.53.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 08:53:45 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id a9so15931381wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:53:45 -0800 (PST)
X-Received: by 2002:a5d:4575:: with SMTP id a21mr15769110wrc.193.1639155225572;
 Fri, 10 Dec 2021 08:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20211210161618.645249719@infradead.org> <20211210162313.857673010@infradead.org>
In-Reply-To: <20211210162313.857673010@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 08:53:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiDXWy8ekFDxVzCbudZv_3CqiWa9w+xO8mxJkk8SNmJCg@mail.gmail.com>
Message-ID: <CAHk-=wiDXWy8ekFDxVzCbudZv_3CqiWa9w+xO8mxJkk8SNmJCg@mail.gmail.com>
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

On Fri, Dec 10, 2021 at 8:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Shift the overflow range from [0,INT_MIN] to [-1,INT_MIN], this allows
> optimizing atomic_inc_overflow() to use "jle" to detect increment
> from free-or-negative (with -1 being the new free and it's increment
> being 0 which sets ZF).

Thanks.

However, I think you can simplify this further:

> This then gives the following primitives:
>
> [-1, INT_MIN]                                   [0, INT_MIN]
>
> inc()                                           inc()
>         lock inc %[var]                                 mov       $-1, %[reg]
>         jle     error-free-or-negative                  lock xadd %[reg], %[var]
>                                                         test      %[reg], %[reg]
>                                                         jle       error-zero-or-negative
>
> dec()                                           dec()
>         lock sub $1, %[var]                             lock dec %[var]
>         jc      error-to-free                           jle     error-zero-or-negative
>         jl      error-from-negative
>
> dec_and_test()                                  dec_and_test()
>         lock sub $1, %[var]                             lock dec %[var]
>         jc      do-free                                 jl      error-from-negative
>         jl      error-from-negative                     je      do-free

That "dec()" case could be just

        lock dec %[var]
        js error

because an underflow is an underflow - it doesn't matter if it's a "it
went to free" or "it became some other negative number".

That said - it may not matter - I'm not sure a plain "dec" is even a
valid operation on a ref in the first place. How could you ever
validly decrement a ref without checking for it being the last entry?

So I'm not sure "atomic_dec_overflow()" is even worth having as a
primitive, because I can't see any valid use for it. Is it for some
legacy case?

                  Linus
