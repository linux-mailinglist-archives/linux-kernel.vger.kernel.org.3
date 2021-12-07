Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5DB46C081
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbhLGQR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhLGQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:17:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC6C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 08:13:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r11so58708442edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwPB+JhWs3rhc/KUIs5o7e8MHxx1rjeX2nly04y/rhI=;
        b=WXs/H+X0iq64oI6ybEXVgw5Oq3co1L94LFoO0+Jdl36KnxOqZNwGS1DjBdRt3d9oP0
         hZ21CrfUB+EGbcCUIQanY949m4C8dgey0lQP8AwFHZ4ItDVKWeX7eljHRVkWA0cgRwzE
         d5HYCj/66Pn5lDO/4WYCgsTCjAZG9E4rj3krc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwPB+JhWs3rhc/KUIs5o7e8MHxx1rjeX2nly04y/rhI=;
        b=QV9MnNNH6QaTJeBsgez1+ctHuXS5jR3w8zJVuo4pq/XaSWSIDqviLEoGcWL3UdF5BO
         1dQnnxYtXbbwuq0DHDRNdg3uXR74Rv2on3GevoLydar9v/ImZlMLdbjo3GwKi6XubNPX
         l0tLykmqdN/4YYQdRXl47/MWMDPMjQGHcsWenFmUkURRw+/C528JhPuUQGqV1/Xy3tkW
         4POLYu7wdAB/W6SWtS1sgBbrHm9YA9yVuKSsDDAp8XcINRkMXYaLF+F1PoCNSLX0OgxZ
         0P0udet1iYSQl+P05G8EwF53KYXfuCxzpzbxPuEzjqNvAKJmeLbU8Fl/9oVh46z1qcU7
         W5rg==
X-Gm-Message-State: AOAM531sD4c7CNL0OvxuN7qwItunyPzXLbUEiyvqgIyzgvzU6v+uBoLw
        HrBJAyYHW7mBKlBEl5huqGVU9lfDdYI7gTa3
X-Google-Smtp-Source: ABdhPJyaozI4IwHGdE3jFV4dy8lh3S6cPuesbhn8VyRa0hcMUpE0lvuybyKGtzEkofdygBiAc4knsQ==
X-Received: by 2002:a17:906:7009:: with SMTP id n9mr338221ejj.431.1638893635557;
        Tue, 07 Dec 2021 08:13:55 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id x7sm149789edd.28.2021.12.07.08.13.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:13:55 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 137so11204353wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:13:54 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr8239503wmq.8.1638893634718;
 Tue, 07 Dec 2021 08:13:54 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 08:13:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
Message-ID: <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 5:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> +#define refcount_dec_and_test refcount_dec_and_test
> +static inline bool refcount_dec_and_test(refcount_t *r)
> +{
> +       asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
> +                          "jz %l[cc_zero]\n\t"
> +                          "jl %l[cc_error]"
> +                          : : [var] "m" (r->refs.counter)
> +                          : "memory"
> +                          : cc_zero, cc_error);
> +       return false;
> +
> +cc_zero:
> +       return true;
> +
> +cc_error:
> +       refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
> +       return false;
> +}

Please don't add broken arch-specific helpers that are useless for
anything else than the broken refcount_t use.

Make it return three return values, call it atomic_dec_and_test_ref()
or something like that, and now people can use it without having to
use a refcount_t.

Nobody really wants two different error cases anyway. The fact that
refcount_warn_saturate() has different cases is only an annoyance.

             Linus
