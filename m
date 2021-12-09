Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56546F287
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbhLIR5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbhLIR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:57:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35654C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:53:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so22615148edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfEybSiwsoU+szdJyCoyr3s7v0KYcyy4yf9cBUePh2s=;
        b=O4IWy62uwI4QguMT07+F51bLJvECUq80pCyBjE1jmscovM/QVEeot/QqCm57U/gHHV
         vz3fUaQfbbEQ98L7wVNsFKoSOTalubyyzSJ4ey2heKZknSFyt8KewHYnV2DjVB3JR7jS
         1n9aE01NXzjRRPOW35GNkoBjkNB2vBl6LfEb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfEybSiwsoU+szdJyCoyr3s7v0KYcyy4yf9cBUePh2s=;
        b=jcXHqJtH07meQdfMxI9dX6XAnfgzhKj/ZYN6O1OscQuIi8k+h41ur7nmNe5tevloa9
         /hj7+gdr8PlqywbwbGscmRuywELb6eaXFr0REJksSkG7yk+5fdPxwcqz/3JCfhtwRUpn
         1rBJuK1yJEybEuajOCS7Lkutvb91qdI6LIjkgSeRXeYN+Sill+ItymWYNhJdDQXXKfki
         DtwZ8THtBBomhmq/ssQIgTyIILLwn5a2cAvANsg69VQwCyc5jHaPqogBzTokAIxSOt6+
         dAbYgFZVB+notEvY1dLWYvZt7HdcE7MHHThezqfNQ/otvw4Ngm4G3P/Tvp6bu26IBdag
         HB8g==
X-Gm-Message-State: AOAM530RWfcOzuDBVOXjBzP9cX+49BozCZ5sicTSNIxPwpAqTh3GqHpb
        J5HWT9weVaoCcgYqoU2IHXlnpHENv3IE9Pm+H1w=
X-Google-Smtp-Source: ABdhPJy6r6Hs2T34mReAeAlf/1bZXtPKM221ilnkjHutNqxbTIa6k6cbI1W/etwvrItdD44j23quAg==
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr17262454ejc.140.1639072335232;
        Thu, 09 Dec 2021 09:52:15 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id og14sm238739ejc.107.2021.12.09.09.52.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:52:13 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 133so4896440wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:52:13 -0800 (PST)
X-Received: by 2002:a1c:800e:: with SMTP id b14mr9241880wmd.155.1639072333220;
 Thu, 09 Dec 2021 09:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20211208183655.251963904@infradead.org> <20211208183906.548393311@infradead.org>
 <20211209083305.GN16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211209083305.GN16608@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 09:51:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5UcTh6bxhk_NO05Uyk8aHY_PUQx5UyrOBMFH8ATHcWg@mail.gmail.com>
Message-ID: <CAHk-=wh5UcTh6bxhk_NO05Uyk8aHY_PUQx5UyrOBMFH8ATHcWg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/5] refcount: Improve out-of-line code-gen
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

On Thu, Dec 9, 2021 at 12:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> For some obscure raisin it causes this: [snip]

Looks like the code generation at one point thought that it needs to
get the return value from the slow-path function call, and by the time
it had optimized that away it had already ended up with enough
temporaries that it needed to spill things into %rbx.

That looks like a fairly "internal to gcc" thing, but I think dropping
that patch is indeed the right thing to do.

When you made it do

        return refcount_warn_saturate(r, ..);

it now means that those inline functions don't obviously always return
'false' any more, so the compiler did end up needing a variable for
the return value at one point, and it really was a much more complex
decision. After it has inlined that top-level function, the return
value is not visible to the compiler because it doesn't see that
refcount_warn_saturate() always returns false.

The fact that quite often that whole refcount_warn_saturate() call
ended up then being in a cold part of the code, and could then be
optimized to a tailcall if that was the last thing generated, doesn't
end up helping in the general case, and instead only hurts: the
compiler doesn't see what the return value is for the warning case, so
it might end up doing other things in the place that the function was
inlined into.

I think the original patch was likely a mis-optimization triggered by
your test-case being a function that *only* did that
refcount_add_not_zero(), and returned the value. It didn't actually
have other code that then depended on the return value of it.

              Linus
