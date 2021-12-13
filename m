Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD47473719
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243449AbhLMV5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbhLMV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:57:16 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BFC0613F8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:57:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y16so20633736ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMKUwfdVnZa0OC/+PlApSfDHQCaCth1VpxrX4nAiO2A=;
        b=ic0VaoHZRb6KjXHIJ3P+2qZGi8j7+ESfuWNH5jXxukMRB/UeYCBIULZCpgwxV/LTJA
         +OuksLZgOljy73DZeiFIyo4CHIHPJRsot81EcZK0HMqGAeved3eeruKibnE1vQFk/QOM
         0ZnHOgTJ/J9nu1/ENFbVzXnsXyI5ZDNR5tPOajcwg2HvmLbGbzJD9Y/C2GCOjShgtc1/
         m8zmk8F0OOh7T1WzI6zzvRPEppf8y/gAimwGCHf4CxAOxCMk1DjdTCT25IAcxOu9QX03
         aACzybsyQxehSm7g4oYLMqdRj6um078xfE58+gEo1TXQCQHiiwN5Dw5NVl3V5rSQJ0zM
         gvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMKUwfdVnZa0OC/+PlApSfDHQCaCth1VpxrX4nAiO2A=;
        b=hzHvUGUiFh+ZHkF5tas90xEqXh0ehuzocYn4WU4wsKz1W8R9SLhx4OsU2LcjQKmrHN
         6fUJVp67XRGRRwK4Y5BnurD1951Y1tibIq+s+qT8oRmdytJfbS4kqmQMwmZzNCXMZ+DL
         uPgrYlC7q+WNV2/YFrYCywHNZSHaigxOeAFBkKDvurwikjAwcOgxvOsAirgXZXqHD2LU
         SZsubgAIh9aIE6Z1DL//ylF7LpPUwT7V1fgtas6xppNTGXpe3caiX3u4jbSZsOBxqS3a
         F3EkyFE7WQbpitJLe1N9Y4ZwLbgmD08wWvCQHayKTx6cK9lTuvARP0xCf3e+xLze1uZo
         XeTg==
X-Gm-Message-State: AOAM531JVkejPilcj80441s1VgvPnIQN9+21JMGlcp11To+kKEoxURMD
        Fo1PN3XFhDMRRdiHN0qNeGgU8wNKwBSHo/KAnTY=
X-Google-Smtp-Source: ABdhPJzEm7BmcDz3kvXaVml6MCEm0bMB1AEfgSyLQveI2p4I5q9R2vEr5vD0+TNs9r9GQeXSfrkedE+vghQ57a6w0dE=
X-Received: by 2002:a05:6638:2608:: with SMTP id m8mr562528jat.57.1639432635722;
 Mon, 13 Dec 2021 13:57:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638825394.git.andreyknvl@google.com> <cca947c05c4881cf5b7548614909f1625f47be61.1638825394.git.andreyknvl@google.com>
 <YbOS/jskofqqOc0y@arm.com>
In-Reply-To: <YbOS/jskofqqOc0y@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 13 Dec 2021 22:57:05 +0100
Message-ID: <CA+fCnZd7znwWCc11NS9g+6m7G3KT=1jq1cJi7crF6QXMCky7ag@mail.gmail.com>
Subject: Re: [PATCH v2 08/34] kasan: only apply __GFP_ZEROTAGS when memory is zeroed
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 6:48 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Dec 06, 2021 at 10:43:45PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > __GFP_ZEROTAGS should only be effective if memory is being zeroed.
> > Currently, hardware tag-based KASAN violates this requirement.
> >
> > Fix by including an initialization check along with checking for
> > __GFP_ZEROTAGS.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Reviewed-by: Alexander Potapenko <glider@google.com>
> > ---
> >  mm/kasan/hw_tags.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index 0b8225add2e4..c643740b8599 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -199,11 +199,12 @@ void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
> >        * page_alloc.c.
> >        */
> >       bool init = !want_init_on_free() && want_init_on_alloc(flags);
> > +     bool init_tags = init && (flags & __GFP_ZEROTAGS);
> >
> >       if (flags & __GFP_SKIP_KASAN_POISON)
> >               SetPageSkipKASanPoison(page);
> >
> > -     if (flags & __GFP_ZEROTAGS) {
> > +     if (init_tags) {
>
> You can probably leave this unchanged but add a WARN_ON_ONCE() if !init.
> AFAICT there's only a single place where __GFP_ZEROTAGS is passed.

Yes, there's only one such place.

In a later patch, I implement handling __GFP_ZEROTAGS in regardless of
having __GFP_ZERO present or not, so adding WARN_ON() here and then
removing it probably doesn't make much sense.

As per what you said in the other message, I've left this unchanged.

Thanks!
