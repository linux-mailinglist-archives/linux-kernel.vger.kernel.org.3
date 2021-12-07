Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C5B46C05F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhLGQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbhLGQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:13:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76768C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 08:10:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l25so58742374eda.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otbD5hBznqHR7VBYTusWIJyDWHMzOVHHmZJEdWTlm4Y=;
        b=Ebu9BclZTHW88tpIhWIGM5uFABs9quYXdDpMUVbFLA2B9mUrRisrp2I7WcNJhXPz4J
         ywK+c87S2hSWryMlZT1pXkiK/Y1MKegM3tbaeeFp68oQjt5B4MMnwp33BpauarvpIoy+
         CtLb6n2yUXHbIDOh9Z4WFRmDM9u/vp7T5yP2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otbD5hBznqHR7VBYTusWIJyDWHMzOVHHmZJEdWTlm4Y=;
        b=58rJ1lneSgJ+0UDBV3IgAUB1CABwylEB6FhjjcJuhGxJKHaFNmARQGPpH5PXD2c+i8
         NAW+T5dtWM4RMs4RSx7snupM9hHrheui8feOYBNiPp8CZWav2q8CrmPGVCpY0j+dLs4X
         sj7+LVYdL20j0J74KKb9Wh7u5C/Oq0AHPbvIOlAVZkLH+SkjlDtOUH+0+bP2gyaApE3z
         hmWY6kN81+v8neYbphO4MKOCBEcvsFLKdUzbRjA6NFeyigYpnmHChqkirk0yIzBHd3U/
         oIhw4FeumKQEA94i27Fb0Jt2ElwuxygzRu3m4uGjGeIr1H0gzZ/+knUSLfQ8gTYsjreu
         vUNg==
X-Gm-Message-State: AOAM533PGOIdOKdHVWrMlOwD2tLb85dpvIgTI7qt1m9VOLLFuKvyF5N4
        zTWF1iUCkJETHH6pQZ/SVa/HIM6pWGzjgeA3
X-Google-Smtp-Source: ABdhPJy2Mc4jcGxxIWOZ4fV1BFuSjuvyj1KdC2xXts2XTl3/Q5IA4yNx/gbypVoljjKt5yAaLA2Uig==
X-Received: by 2002:a05:6402:350e:: with SMTP id b14mr10721761edd.313.1638893419946;
        Tue, 07 Dec 2021 08:10:19 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id hu7sm8589812ejc.62.2021.12.07.08.10.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:10:19 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 137so11195214wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:10:18 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr8189198wmq.26.1638893418059;
 Tue, 07 Dec 2021 08:10:18 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk> <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
 <202112061455.F23512C3CB@keescook> <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
 <Ya83zQRVUCRRYNHQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya83zQRVUCRRYNHQ@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 08:10:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWJv6xNPQMk+FFumWix+_O1gfwTiCx6tpmcQ4cY=_F=A@mail.gmail.com>
Message-ID: <CAHk-=whWJv6xNPQMk+FFumWix+_O1gfwTiCx6tpmcQ4cY=_F=A@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 2:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 06, 2021 at 04:13:00PM -0800, Linus Torvalds wrote:
>
> > IOW, I think that "try_get_page()" function is basically the *much*
> > superior version of what is currently a broken "refcount_inc()".
>
> That places the burden of the unlikely overflow case on the user. Now
> every driver author needs to consider the overflow case and have a
> corresponding error path. How many bugs will that introduce?

Did you even *look* at the patch that started this discussion?

The patch replaced refcount_t, made for no more complex code.

> Why is saturation; iow. leaking the memory, a worse option than having
> bad/broken/never-tested error paths all over the kernel?

.. which is why I'm fine with refcount_t - for driver reference counts
etc sysfs behavior etc.

What I am *NOT* fine with is somebody then piping up claimign that
refcount_t is "better" than doing it properly by hand, and complaining
about patches that replace it with something else.

See the difference here?

'refcount_t' is fundamentally broken, cannot handle overflows
properly, and is *designed* to do that. You even seem to make excuses
for that very design.

And that "lazy mans overflow protection" is fine if we're talking
random code, and are talking maintainers who doesn't want to deal with
it.

But that is also why I do not EVER want to hear "no, don't convert
away from refcount_t".

Can you really not understand my dislike of a data type that is
fundamentally a lazy shortcut and intentionally hides error cases with
leaks?

Doing it properly is always the better option, and "refcount_t" really
*fundamentally* can never do it properly. It doesn't have the proper
interfaces, and it doesn't return enough information to recover.

I'm not arguing that we have to replace every refcount_t user.

But I *am* arguing that if somebody wants to replace their refcount_t
with something better - whatever the reason - they had better not hear
the mindless whining about it.

                Linus
