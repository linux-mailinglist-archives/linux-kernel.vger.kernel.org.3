Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26146AED9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354146AbhLGAQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351131AbhLGAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:16:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E04C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:13:20 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o20so49889005eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZ4NTQl4vqWUi0q6qLDZFhtehtmC6acMk0BEOAwbblk=;
        b=THF2y8xIsbgj5uAmVksnApdBv0DkrP52LvcVJCs49feiZbKcjSFTUV7i34T5SFjKsj
         W8X6BM/2tJM6v4IENQbUJNn/c2/8x0+v2Jf86RR/4zzOaqoziLA6pCEdcJ7HNAmPe5kL
         a2MqXb/XXou6gEQllsBvCq+OuNsrCaOkkLk+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZ4NTQl4vqWUi0q6qLDZFhtehtmC6acMk0BEOAwbblk=;
        b=vpoD9/wABK8NU9ZzOHqhD2kytONowH7Pt/EOYYX1j0y1iYaFdDKgBuVevK1wN8AfzK
         1x+iTDahC3v4j/USqfZhvEmpmommcs1wVJp/lw2/J1iVp8om8bszmWC1l11j5tZGEWCl
         UmifNqFMUWmErEQE2luA88v5vwH0d/bs+7CLEitAysnqvv1gJ42FTqaM5xduvonI98Tj
         yYsxXZDLChqlaAFl5UbYZJF16is1AI7OfVHVmQZQBntZqOQGg5d4Vvofk9/cAbMj8RnE
         TTgSvWaX4V+ju9cAqZ+ZWzVtUtDJUAcqxZqYaAj1toYzKvJFnJYNgQ9M6pinFqiodryF
         ksLA==
X-Gm-Message-State: AOAM533mcB/F4IwxWMxpPpXYZ1E8up4/IjX8f6CD41R+xHqt+c7PiE42
        MUwHhDXzTGB74+fI1k9wiRWkcmgg14CXXwvX
X-Google-Smtp-Source: ABdhPJyqiolP7RTZWe0MXFeNouO1k42UXjtThtoTFCK37bbSqVL6wJtANMZhthsqJT6zJVApeN2D9g==
X-Received: by 2002:a50:955c:: with SMTP id v28mr3603347eda.293.1638835998854;
        Mon, 06 Dec 2021 16:13:18 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id d18sm8922982edj.23.2021.12.06.16.13.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 16:13:17 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso994901wmr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:13:17 -0800 (PST)
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr2274622wmg.152.1638835996701;
 Mon, 06 Dec 2021 16:13:16 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk> <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com> <202112061455.F23512C3CB@keescook>
In-Reply-To: <202112061455.F23512C3CB@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Dec 2021 16:13:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
Message-ID: <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 3:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> I'm not arguing for refcount_t -- I'm arguing for an API that isn't a
> regression of features that have been protecting the kernel from bugs.

Maybe somebody could actually just fix refcount_t instead. Somebody
who cares about that currently horrendously bad interface.

Fix it to not do the fundamentally broken saturation that actively
destroys state: fix it to have a safe "try to increment", instead of
an unsafe "increment and do bad things".

Fix it to not unnecessarily use expensive compare-and-exchange loops,
when you can safely just race a bit, safe in the knowledge that you're
not going to race 2**31 times.

IOW, I think that "try_get_page()" function is basically the *much*
superior version of what is currently a broken "refcount_inc()".

And yes, it does warn about that overflow case that you claim only
refcount_t does. And does so without the broken semantics that
refcount h as.

                Linus
