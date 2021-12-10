Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C547072B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhLJRbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhLJRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:31:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E2C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:28:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z5so32864923edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZDdsAEji6F4xH+OXdZswoKDJWOajVXllvHjlHcMLw4=;
        b=A4a0qPSojsO1wlDX6QwekQS+VoSwxN+dvj6FEkQIXS8EheKHyvFmopz7d3vHNalwWr
         cM4cMQNv6DppSPgMGsg3XK9GbRrPTlrzEuThfFoTWw8k9hH5hYkpgGVEbHDJOxYD/Xm5
         N2VvLCDnD+XQTzvxdSYFi04KOiSyO9Mk/n57k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZDdsAEji6F4xH+OXdZswoKDJWOajVXllvHjlHcMLw4=;
        b=sTMLSiFC0GXqX3556+sZgrq7u9I4lbuvRytJYfjjp8FjdIZmAEDfdw1Uz+Ipzexzr7
         iX6BjizRDLasd4T9lhHprJgKhjM2n10Im8gbvaE8cheMCvcJviCr69DOdZF39O5b5xax
         l54inZ9UQroaFyBoAir3ERCLwF9FrFtN9o+pFcqgoyvNXzyNklN+AiKQ5+h93th7sJcn
         srVF4MSNI6ehveFxbU7mB/Ty2NCzcj/evjHdU9GROWzNsl2OJUqFn+TrYFKw0wSiZ4M8
         Vpk1I4yMeTutAPuk0Kwd3ssSSp3s1nMAPUBO7dXYUBqPgkTRP3wjU7l7iX0RHbmennPd
         c8QQ==
X-Gm-Message-State: AOAM531Qc44jDfir8IGe8rzSfJcpAdN69Lft1GBwgsm36aA8k4HvtddF
        f+c25WC9331fwJnwn6iA7a6yh1zZlJJZBpUwaqY=
X-Google-Smtp-Source: ABdhPJxCmA929VVD1eaf09iXZpMw1FIA68Pw1gayas0Aqkbnwrtggq8vf5nPS07vxkzs8+FWRtzePA==
X-Received: by 2002:a17:907:68e:: with SMTP id wn14mr25656887ejb.258.1639157288472;
        Fri, 10 Dec 2021 09:28:08 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id ho30sm1831512ejc.30.2021.12.10.09.28.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:28:06 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id u17so16142247wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:28:04 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr14236955wra.281.1639157284621;
 Fri, 10 Dec 2021 09:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20211210161618.645249719@infradead.org> <20211210162313.857673010@infradead.org>
 <CAHk-=wiDXWy8ekFDxVzCbudZv_3CqiWa9w+xO8mxJkk8SNmJCg@mail.gmail.com>
In-Reply-To: <CAHk-=wiDXWy8ekFDxVzCbudZv_3CqiWa9w+xO8mxJkk8SNmJCg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 09:27:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whStLWvUzmz3SmQxy1PPyNDjf1O-7z1mq5=WZ-+EABa7w@mail.gmail.com>
Message-ID: <CAHk-=whStLWvUzmz3SmQxy1PPyNDjf1O-7z1mq5=WZ-+EABa7w@mail.gmail.com>
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

On Fri, Dec 10, 2021 at 8:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said - it may not matter - I'm not sure a plain "dec" is even a
> valid operation on a ref in the first place. How could you ever
> validly decrement a ref without checking for it being the last entry?

I should have checked the users - it seems to be a pattern at least in
networking where people have extra references and do

        refcount_dec(&skb->users);
        dev_kfree_skb_any(skb);

because there's no way to tell dev_kfree_skb*() to decrement more than once.

So I guess it's all good, but yes, I still think you can just do "lock
dec .. js" for this operation.

             Linus
