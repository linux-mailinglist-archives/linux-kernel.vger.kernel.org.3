Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDA4930EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiARWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240802AbiARWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:38:34 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4DC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:38:34 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id x33so909012uad.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFIPDwsDeRm81c05CD5S02oyUJN8DIpI+1GsvDMiep4=;
        b=Jfugtf9FbGJis6uBQ4CdXc/8nGduDpvhXy+a27fLvitVKGrLopKpViHKRTXSVXqewY
         cjAWMe19MPI2EVo2djGEGz3qllkZkYd9nbf6TEsLnVMTi+FdIzdmDADcm1tWu3ntoMqg
         vfgyvwacp89WuvL7BspNzyyBXpxQOeOTwYHhEvOq+me4IzdfiNkJtn7VmqCiMBwSxl9h
         j+jXpUvZ4pNBWhLTHMuNeOppkdgSynwqMWguZVWhdgyq3B6q2k8tEY0eCQNIA4A6BNni
         +wvxQlo2GGOJv9x2DtpxzkWVdwKdzQSbqFeGqcCgMHoL4pLIwsmJvkO3bhyzQMQqMe4Z
         BTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFIPDwsDeRm81c05CD5S02oyUJN8DIpI+1GsvDMiep4=;
        b=D27Qq8UlABNcWBOiF/6veQl3nELD4OWC8b6S3HfBVveGLn5Yhpw+an2AZcHJyGPOL4
         aHgoNlJW/9Eqg+7j2ITRfIlUJUQwJeY9/cmvEDaZXBN+hHe9rNvLWI0vHVOCp24QcbOD
         XqUlb6/kAGCcgVFFP4G/9kdfT0RnE0BR0WO1sOHVftoJmgU2bpsuPBLg08LJo47ioWl+
         pU1NgBsYppiBsHlAv1OLaSbWEqwMQ9apKp/K7tHuMh/sWOLqvREqyFZglOxF0pKKt36P
         9Oioy/F7kXgDPJRfk8e/nk8SUyZKC/FAx9JjHdKDCdykX9VskudXZt/kpU0jFOXTGrsl
         NdCg==
X-Gm-Message-State: AOAM530cKp9KteEZb7Gd9XI7Jrfl9h9opEkeFvih6zIUJDdxBgZXjIfi
        cOUHOISEZJ321deBdBCjyyLQ149tT9YdHqyxOs5cZTKB0Krr6g==
X-Google-Smtp-Source: ABdhPJxQh1t44Frfz/2XYxwpy7ZXI1lO+ncbRUGm6GBcUykDOdHTvp8gIOSQksTNoWrRHe66Sh+aumcYSnD4CXhOpo4=
X-Received: by 2002:a67:ebc2:: with SMTP id y2mr3183653vso.72.1642545513445;
 Tue, 18 Jan 2022 14:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20220113031434.464992-1-pcc@google.com> <CA+fCnZeckbw+Vv9TQaCNfaMBA9DkMGXeiQwcoHnwxoO6fCrzcA@mail.gmail.com>
In-Reply-To: <CA+fCnZeckbw+Vv9TQaCNfaMBA9DkMGXeiQwcoHnwxoO6fCrzcA@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 18 Jan 2022 14:38:22 -0800
Message-ID: <CAMn1gO7zBjaAU9f=qnKKhVBxuujmqzHDpuEdHQxtePDZVBgWMg@mail.gmail.com>
Subject: Re: [PATCH] mm: use compare-exchange operation to set KASAN page tag
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 1:58 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
>  On Thu, Jan 13, 2022 at 6:14 AM Peter Collingbourne <pcc@google.com> wrote:
> >
> > It has been reported that the tag setting operation on newly-allocated
> > pages can cause the page flags to be corrupted when performed
> > concurrently with other flag updates as a result of the use of
> > non-atomic operations.
>
> Is it know how exactly this race happens? Why are flags for a newly
> allocated page being accessed concurrently?

In the report that we received, the race resulted in a crash in
kswapd. This may just be a symptom of the problem though.

I haven't closely audited all of the callers to page_kasan_tag_set()
to check whether they may be operating on already-visible pages, but
at least it doesn't appear to be unanticipated that there may be other
threads accessing the page flags concurrently with a call to
page_kasan_tag_set() (see the calls to smp_wmb() in
arch/arm64/kernel/mte.c, arch/arm64/mm/copypage.c and
arch/arm64/mm/mteswap.c).

> > Fix the problem by using a compare-exchange
> > loop to update the tag.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/I456b24a2b9067d93968d43b4bb3351c0cec63101
> > Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
> > Cc: stable@vger.kernel.org
> > ---
> >  include/linux/mm.h | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index c768a7c81b0b..b544b0a9f537 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1531,11 +1531,17 @@ static inline u8 page_kasan_tag(const struct page *page)
> >
> >  static inline void page_kasan_tag_set(struct page *page, u8 tag)
> >  {
> > -       if (kasan_enabled()) {
> > -               tag ^= 0xff;
> > -               page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
> > -               page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> > -       }
> > +       unsigned long old_flags, flags;
> > +
> > +       if (!kasan_enabled())
> > +               return;
> > +
> > +       tag ^= 0xff;
> > +       do {
> > +               old_flags = flags = page->flags;
>
> I guess this should be at least READ_ONCE(page->flags) if we care
> about concurrency.

Makes sense. I copied this code from page_cpupid_xchg_last() in
mm/mmzone.c which has the same problem. I'll send a patch to fix that
one as well.

Peter
