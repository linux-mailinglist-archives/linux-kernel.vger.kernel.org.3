Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DE946A316
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243339AbhLFRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbhLFRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:38:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E3BC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:35:23 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o20so46202572eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8umLnxkQDgi96rJjwGXauJbyfOBhd/Q4eq0+fA0pj4=;
        b=GgGJB+R0LyUMIljalT2P610uyhWqSzmVzWTfYAaVG9JKs22KYrGSzdp/WQqDo9mdgg
         +IGu14R485pYnYs9PS+e1DyxU7/CuuaymG7wMaGu0ykbYL/P60NEJPUrSP7cv+udmhTg
         q3Yd4KitjWWfifbPjo7dI8KBc67WVxrc4jkiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8umLnxkQDgi96rJjwGXauJbyfOBhd/Q4eq0+fA0pj4=;
        b=734FoVfYCTStazRBVBIHgox0ldGaQJMq10oOwdETOH6AkA65P4lAKHgZ0ZesqEg5XX
         HoZOiRClcEkM/txpzjmZjumaBRDyFuU+FficqU+NCX0z1SYAOfC+WFEnZYOLQh4vrw0S
         HriRlSl8zQg31lkTyj8f5L5lZmkU1oWPIzJPxNqPCywcc4inZeA2nceCXmAKift7sNRK
         aSW1D61ZvqN+KHg3QdpDoLMQl1xQDw6pF7M3e07UAs9qrB03CfQ/Z2FYt2EkX/rAnA80
         Dr8zthdHOv3oxXJv1ue3wuD0WE9KYnw2Gw2j3/4dC3sMNVZR7/H94U/T+n5lLRDJIHiV
         O7BA==
X-Gm-Message-State: AOAM533TOKBejaGUMNlq2qSumXWuUbZdu2Oa9EikP27tMazfOBWyyD7S
        v2FN32zTQYv5R7wCh/ihXS6n0MmL4YiKg4nX
X-Google-Smtp-Source: ABdhPJzevFI0nPrStkxZUGqhzGUouTYVqqanBtdUFzvTnuTEAkZjJ9tWos3TVATRkRhEa+VgYyoNxA==
X-Received: by 2002:aa7:ce1a:: with SMTP id d26mr616650edv.189.1638812121227;
        Mon, 06 Dec 2021 09:35:21 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id hq9sm7652257ejc.119.2021.12.06.09.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 09:35:20 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id d9so24051678wrw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:35:20 -0800 (PST)
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr43315963wrx.378.1638812120016;
 Mon, 06 Dec 2021 09:35:20 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Dec 2021 09:35:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
Message-ID: <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 12:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Quite; and for something that pretends to be about performance, it also
> lacks any actual numbers to back that claim.
>
> The proposed implementation also doesn't do nearly as much as the
> refcount_t one does.

Stop pretending refcoutn_t is that great.

It's horrid. The code it generators is disgusting. It should never
have been inlines in the first place, and the design decsisions were
questionable to begin with.

There's a reason core stuff (like the page counters) DO NOT USE REFCOUNT_T.

I seriously believe that refcount_t should be used for things like
device reference counting or similar issues, and not for _any_ truly
core code.

                  Linus
