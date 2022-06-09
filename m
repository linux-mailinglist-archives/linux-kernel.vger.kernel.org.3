Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE395453D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbiFISMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiFISMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:12:48 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7AF3B090A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:12:46 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id p1so19320835ilj.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZmFRyplZFrFLoO+ATeHLa4N7zJRWugh0qo8UpTNm2o=;
        b=RWIKj3WMK49P5Zmpj6ScWuednCPkicoLBfUdsszcedTzAn1hnIqJ27HJKwQeuxPkrf
         FiSeR3HEOThstP9AOalEwdFA0TH8lUcYMkiRKoCY8c5qoGXFJnROeuqfgRbHNmIjm2yv
         ZxuNgbtHELNgHBed7GTqcDNM+LUhtOVYMilQtlqIwX3k+wWIDF/5cLAVDUw2N0DjZL/x
         E4L0zHb3ycHhOAFu6gi1c6mtkslLKqSzU++q6y2hQk+hfDD54GLbLlFUtIBhWp0/dvYf
         IYr+Lo4RLmmU08ARY0Zd+CT39p0kl1BDRG7Zuvec6P+JPdrP70aTUNLRNNzdk8omy+H6
         Q/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZmFRyplZFrFLoO+ATeHLa4N7zJRWugh0qo8UpTNm2o=;
        b=KKnNPrp9kedLy/QxShZpeE/xNWtnIhPPEDVL33IFpy6EzQ+jtnw7fVwCEUbCVfnrnt
         PEAgUB8Dc6Q2g+ur7Jjd9KhzZRfWxiLr1q3hGb/O6Rhfcvc7UnKwcZ/bl8lpBwi++SeZ
         XN+p5AW3eHikzrCGic4EpiJzFG3dfES5pp51sQvtN+SkQwIhj3GXrnPStOYGtfqxeNMM
         dbuSpEdvNpV/6NZ7Y1t4a+AzSKCa7hJ7/GA8ggjZrqelcZDey1YASVF8eKVPmbzqkEnI
         HcLFdQ8Oq+E2LbSvrCZDOE0+O3mtFq8jmYpXZ1cCWNZ3wkoQLWaYqs3I6IxLvBN6WXnr
         3PPg==
X-Gm-Message-State: AOAM5301xLrQoSZfBteuP1aGeR8lqeiA85krJWKg8E6idyJD4xGHNAm7
        0mpW5QdcVyfPNb8ow2PIIdvfql45LpdUKCL6BYU=
X-Google-Smtp-Source: ABdhPJwdhN090aPzLnozcnxaxdnkDVe30GMopS0VDWoJT0IhUyzwqYNO0tg6CftkaO9VxNZgBwACy+C6743o+aIss5I=
X-Received: by 2002:a92:3609:0:b0:2c6:3595:2a25 with SMTP id
 d9-20020a923609000000b002c635952a25mr23142353ila.233.1654798365958; Thu, 09
 Jun 2022 11:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <4c76a95aff79723de76df146a10888a5a9196faf.1654011120.git.andreyknvl@google.com>
 <bbc30451228f670abeaf1b8aad678b9f6dda4ad3.1654011120.git.andreyknvl@google.com>
 <YpdbgGjjz954Us/y@elver.google.com>
In-Reply-To: <YpdbgGjjz954Us/y@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 9 Jun 2022 20:12:35 +0200
Message-ID: <CA+fCnZf7eyksP7cAVXVPdS9X=qnDTCTBMVJaqmLGUbwnbD6cdA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kasan: fix zeroing vmalloc memory with HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 2:28 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, May 31, 2022 at 05:43PM +0200, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > HW_TAGS KASAN skips zeroing page_alloc allocations backing vmalloc
> > mappings via __GFP_SKIP_ZERO. Instead, these pages are zeroed via
> > kasan_unpoison_vmalloc() by passing the KASAN_VMALLOC_INIT flag.
> >
> > The problem is that __kasan_unpoison_vmalloc() does not zero pages
> > when either kasan_vmalloc_enabled() or is_vmalloc_or_module_addr() fail.
> >
> > Thus:
> >
> > 1. Change __vmalloc_node_range() to only set KASAN_VMALLOC_INIT when
> >    __GFP_SKIP_ZERO is set.
> >
> > 2. Change __kasan_unpoison_vmalloc() to always zero pages when the
> >    KASAN_VMALLOC_INIT flag is set.
> >
> > 3. Add WARN_ON() asserts to check that KASAN_VMALLOC_INIT cannot be set
> >    in other early return paths of __kasan_unpoison_vmalloc().
> >
> > Also clean up the comment in __kasan_unpoison_vmalloc.
> >
> > Fixes: 23689e91fb22 ("kasan, vmalloc: add vmalloc tagging for HW_TAGS")
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/kasan/hw_tags.c | 30 ++++++++++++++++++++++--------
> >  mm/vmalloc.c       | 10 +++++-----
> >  2 files changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index 9e1b6544bfa8..c0ec01eadf20 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -263,21 +263,31 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
> >       u8 tag;
> >       unsigned long redzone_start, redzone_size;
> >
> > -     if (!kasan_vmalloc_enabled())
> > -             return (void *)start;
> > +     if (!kasan_vmalloc_enabled() || !is_vmalloc_or_module_addr(start)) {
> > +             struct page *page;
> > +             const void *addr;
> > +
> > +             /* Initialize memory if required. */
> > +
>
> This whole block of code looks out-of-place in this function, since it's
> not at all related to unpoisoning but a fallback if KASAN-vmalloc is off
> but we still want to initialize the memory.
>
> Maybe to ease readability here I'd change it to look like:

Sounds good, will do in v2! Thanks!
