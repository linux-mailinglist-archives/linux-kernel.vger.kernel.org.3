Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B246B495193
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbiATPhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376710AbiATPhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:37:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C75C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:37:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j2so30282417edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHr47Yn1aQ2oLbzKOLUIvoEfRNOv+H9Lzlr0T36vdYs=;
        b=c59rI5tTjPHQX5oara7rDAzHiToNlpr1xLa2EaLq0i8wxl8+7McWlcU1NWpJ1o9f7M
         Rzv5tsDhLIslBsZTPjvkwjCnJqLCKVQg5hiIN4TmnwsecLmmU187k6EiQXjnXEaWpCY2
         jFJSpLN1Md1XWSm8oA5U2druh67WwyGzmvn4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHr47Yn1aQ2oLbzKOLUIvoEfRNOv+H9Lzlr0T36vdYs=;
        b=VELgc9g5+WTpaCmmfYXXlaIB7CJsa6xussvwt4kA3H+/kK/y+MGZ5MwFiH0vcj0/BP
         on8LuB/NcaJcDY6NYxoLOxm9M8FNaDuVk/Km++1BKWeBTmTZtmY5o7EC/wb0w0hXzQt0
         zkbWx1bu3Env65y4iR607o2dSlhUMRjzaskd1goBW3spoRv18tTZGW4UhG5gBMnMAczS
         kp302rVttKgj4GmZVicyIi6ZOCWAXYOEcL+l0Xt38KRMeguqyLgLdtdPd9YK6zIhQrH2
         i5UDV4T2+y19Sy8GuTGCpW2gKTt+i2n0pG1bh+SYg6LLOIMo0fxo/KmeGMjedRPqvUMd
         sIbA==
X-Gm-Message-State: AOAM533a891EmMLwsjiNi9pONf1q/Mdhn9puYdpqrZpSir5EGA8vMkjU
        4waSpokkSX/1/GbhLeZw/oUfmbqFMIzOKNNe
X-Google-Smtp-Source: ABdhPJxoo6Wn47T22Gl5UVpyhQHEqTXBSs3gZwnXvn25ybgAI9LLgaht7UKKd5Zf2a6LOwZ8dRZfdg==
X-Received: by 2002:a05:6402:4316:: with SMTP id m22mr37900069edc.326.1642693050082;
        Thu, 20 Jan 2022 07:37:30 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id e9sm1465862edc.10.2022.01.20.07.37.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:37:28 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id v123so12939882wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:37:27 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr34195514wrh.97.1642693047630;
 Thu, 20 Jan 2022 07:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org> <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com> <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com> <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com> <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com> <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
In-Reply-To: <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Jan 2022 17:37:11 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjBFF_EJHVRe48jAjb7Xwu0aRNejyefzLOAGW_qnNu=-w@mail.gmail.com>
Message-ID: <CAHk-=wjBFF_EJHVRe48jAjb7Xwu0aRNejyefzLOAGW_qnNu=-w@mail.gmail.com>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 5:26 PM David Hildenbrand <david@redhat.com> wrote:
>
> So your claim is that read-only, PTE mapped pages are weird? How do you
> come to that conclusion?
>
> If we adjust the THP reuse logic to split on additional references
> (page_count() == 1) -- similarly as suggested by Linus to fix the CVE --
> we're going to end up with exactly that more frequently.

If you write to a THP page that has page_count() elevated - presumably
because of a fork() - then that COW is exactly what you want to
happen.

And presumably you want it to happen page-by-page.

So I fail to see what the problem is.

The *normal* THP case is that there hasn't been a fork, and there is
no COW activity. That's the only thing worth trying to optimize for
and worry about.

If you do some kind of fork with huge-pages, and actually write to
those pages (as opposed to just execve() in the child and wait in the
parent), you only have yourself to blame. You *will* take COW faults,
and you have to do it, and at that point spliting the THP in whoever
did the COW is likely the right thing to do just to hope that you
don't have to allocate a whole new hugepage. So it will cause new
(small-page) allocations and copies.

And yes, at that point, writes to the THP page will cause COW's for
both sides as they both end up making that "split it" decision.

Honestly, would anything else ever even make sense?

If you care about THP performance, you make sure that the COW THP case
simply never happens.

                 Linus
