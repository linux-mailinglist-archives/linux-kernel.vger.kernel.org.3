Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4894146A91B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbhLFVLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhLFVLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:11:31 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E1C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:08:02 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id x10so14549780ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IH41mDAtzUD8A+tMjDFc178hVvqONneJF0Z3g7u2BhU=;
        b=WC6vPd2g2w8EN4visTRWvwDwmHPpl5K/zWqjQFi1kCOj5ogTu4eQ8QKZMuChOUiZb2
         Idbku7TiJNX07EGFm+1p5/p9sGIGJpOZhdhpUpR0RXmlQcyPvx8GutSHCqxngIZeGnln
         oKXCxTSdUGuAQcnn+aa7vL7JIUiMXZT0UywSBdHTEnw3nGae1m9CfnqitAbdUTPqDLOv
         viziHvWTaV+/xjliWCz1z68Y3+nzLeJBx03Dg15VZWLrkxL0CBAd+5nX9/PXUw9sjoeX
         rSf13x9ZdLiysaesEHnjm7cMIiQNVqI8s/juNZQIXsO/oGRfzihv5UXDSGAhSuuVMkfU
         YBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IH41mDAtzUD8A+tMjDFc178hVvqONneJF0Z3g7u2BhU=;
        b=wPsdNIUm/2nNIj6MjJeUUOrSGldYK8iJqes/D5bXCKZHK8NRuE3MeIMo32frpncV0p
         LW+7xUxsiZugwe3pu3v9WsMbm53mHFjzFY/K8rfFDq3r1KnvqIy0KqjUFyYsuYnvIz4n
         nfNHtLCLJOKBHIcGysRYNx3xKa/ue6M6M8NKyW+V4dUJCt77I+RXPBUwpRtbVNfFvBw3
         oH43XBRbxfGH2swrh6fUmBIN+orQudLbh/0ajCOZh5ah0GMVQom4VAhlkK0LwqY1TH/W
         hfboV4qAU333IJ4qGHJouO6IOw/PMKuGW1CYF0/1VDfN9Pyx9f15H56k5txd2hTc4032
         xajw==
X-Gm-Message-State: AOAM533f88p4JnX4FH6LZIFa5WQDzcsJFd9zDP1yXUUUMf1qEL71A5zM
        ue+B/ApNqrHaTuaotz5JOEqvS2UQfNEW4No8OHA=
X-Google-Smtp-Source: ABdhPJzOo0c9AUAGf5YgRy/LpXtv/aLPq8dPDlfdOwleRGwiHehsOr6FjDRXqKvc3Fg5jwxlVVmJgh4zA4oRBv9t6ZA=
X-Received: by 2002:a05:6602:45d:: with SMTP id e29mr37027391iov.202.1638824881589;
 Mon, 06 Dec 2021 13:08:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <b28f30ed5d662439fd2354b7a05e4d58a2889e5f.1638308023.git.andreyknvl@google.com>
 <YaeCNIyblUAk5mmI@elver.google.com>
In-Reply-To: <YaeCNIyblUAk5mmI@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:07:50 +0100
Message-ID: <CA+fCnZfBNuDYf7A5EiBLrFjYKQNp_fydBrmjW5-wS7Sttk4wrg@mail.gmail.com>
Subject: Re: [PATCH 04/31] kasan, page_alloc: simplify kasan_poison_pages call site
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 3:10 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 10:39PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Simplify the code around calling kasan_poison_pages() in
> > free_pages_prepare().
> >
> > Reording kasan_poison_pages() and kernel_init_free_pages() is OK,
> > since kernel_init_free_pages() can handle poisoned memory.
>
> Why did they have to be reordered?

It's for the next patch, I'll move the reordering there in v2.

> > This patch does no functional changes besides reordering the calls.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/page_alloc.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3f3ea41f8c64..0673db27dd12 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1289,6 +1289,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >  {
> >       int bad = 0;
> >       bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
>
> skip_kasan_poison is only used once now, so you could remove the
> variable -- unless later code will use it in more than once place again.

Will do in v2.

Thanks!
