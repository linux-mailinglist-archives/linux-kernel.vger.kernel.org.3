Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4709546C828
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbhLGX0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbhLGX0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:26:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00CDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:23:20 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y13so1948077edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFqKn/JH+GK+DPO0IYtLG54mM/YPzkAV7Qb7f0SlT3Q=;
        b=OlRpfi8Z2djbQ1ovqBbkrOfDN/aezMU9Fd5Y7kDd//OahmypBQLJ1F/mW/C7X0LDIJ
         LwSOIk/qo/V+IhZF2uHzna5UXytN0bYl3/kXllmYdNjdi3+/+Nhm9ddysoQ/qwby0mjh
         ZsCJMXooRGgSw4lYlE0AjfXqnyjwQyXsf+KEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFqKn/JH+GK+DPO0IYtLG54mM/YPzkAV7Qb7f0SlT3Q=;
        b=70pAosx5Up83oY96g1lERm1WOm3raeTpXJJg3rq4uVIHGCBX3aIMYOssQmDkZ+/8n+
         s2pPm9R7xk1WDTB5GB2RWn0lj1Ns0C9T6wflHrMr9cs2cVBpqpvbiDg/h7dAA+ljotVI
         B3Corausz6rumeH/IGvvAqgXgJuyHYZri7lU/hrSu++KVqM6xkmUdFPwEkqo2qaoXiaT
         Y8FxnHWz3mZMWym0US2u9a8btRMlu6uHcVsPF33NFTDxurtcJ5rAdWCOrUxfJpONIeod
         8sYy2c/1rMtf4AUvO0ywEj1QaLMD8rAnXPjzFkn09pHperGYtskFtdt59G/zUUXQjy7S
         SCJg==
X-Gm-Message-State: AOAM532Pm042O/FDyeulcC1ETT81OCa8HQwRbaVqDPXTmafo6xWWLq5K
        wj0YaPMisio1SFLuSgs4fdltRIpOkhozuVeSPlY=
X-Google-Smtp-Source: ABdhPJybhHHC5Ek5CaPIL/kU17z54U56gyscYynJ8jHDTGPga5OaOzMgIVW8p27N/NMbzk//L7F9Rg==
X-Received: by 2002:a05:6402:1911:: with SMTP id e17mr13907717edz.326.1638919399322;
        Tue, 07 Dec 2021 15:23:19 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id v3sm772329edc.69.2021.12.07.15.23.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 15:23:18 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso2927341wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:23:18 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr11077730wmq.8.1638919398284;
 Tue, 07 Dec 2021 15:23:18 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <20211207202831.GA18361@worktop.programming.kicks-ass.net>
In-Reply-To: <20211207202831.GA18361@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 15:23:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
Message-ID: <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 12:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Argh.. __atomic_add_fetch() != __atomic_fetch_add(); much confusion for
> GCC having both. With the right primitive it becomes:
>
>         movl    $1, %eax
>         lock xaddl      %eax, (%rdi)
>         testl   %eax, %eax
>         je      .L5
>         js      .L6
>
> Which makes a whole lot more sense.

Note that the above misses the case where the old value was MAX_INT
and the result now became negative.

That isn't a _problem_, of course. I think it's fine. But if you cared
about it, you'd have to do something like

>         movl    $1, %eax
>         lock xaddl      %eax, (%rdi)
>         jl      .L6
>         testl   %eax, %eax
>         je      .L5

instead (I might have gotten that "jl" wrong, needs more testing.

But if you don't care about the MAX_INT overflow and make the overflow
boundary be the next increment, then just make it be one error case:

>         movl    $1, %eax
>         lock xaddl      %eax, (%rdi)
>         testl   %eax, %eax
>         jle      .L5

and then (if you absolutely have to distinguish them) you can test eax
again in the slow path.

                     Linus
