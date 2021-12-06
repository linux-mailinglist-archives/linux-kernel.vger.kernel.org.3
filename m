Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A0C46A928
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350133AbhLFVNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhLFVNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:13:19 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C22C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:09:50 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p65so14606790iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9EatIR8zw0uiCmcjCpN5nb99oEeaRmy6PPAXAHDInU=;
        b=d8LJ0GCx9BppTTQuyCnfWdUbOS18FiLlkBaZqlZTqBPzEHiMZPEL9ZSdj556Eah2XI
         8lLBlM5ZcDf5e3zcahr/GkNISYRLmFIVViussCMRxJROiCzyAVJK8ARmHICXD1JOa5nd
         uOd5D4yyl+L1scbBv41ckD+qezDn72yyT8oxZXVdmIcWyTdQsKEuhPBZJtXIpEPYENed
         fIDdIqWEnSGpeGhLDP76V4Qm5nkp0KQUN1XDAdB2aoYjYWSDMRVh2Cw/BwsNaElENZqo
         xcK7JplojrsWLqrzyxdiHLahfo/Cn/3no775T5dAgOEBPSw22VUPN3e6Gi3EWyzSjFHe
         TLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9EatIR8zw0uiCmcjCpN5nb99oEeaRmy6PPAXAHDInU=;
        b=XOSFMqQxi26MEBC4r/+s4xAvolSusdlVRzbVbNbOqdhM00USg+o/0/6f2O4nTnNExY
         GVJmWTRgjTmM9U+9uUt40QrB3uiIwcRp2WkhwzaM50Pml14FZDAZ6pwBc2OfOsU71QM9
         CT5LYLuD2UArxKVU2umh+/vB/8IeYmhxs45ve+E/yjVAG+4KEV7BKjudx+8JxLOJTWwr
         JTAqQ3z9dNfrlhgrs0gZ+iFoAmAsWshcQi3YVXBen3lnzaUAsacj3u/ALCourXwlr38f
         xsNG/8+8T/7WkDGaG3Ypu06odo2mquo6+RMbe/3YAPzFbbzb8rOid3kW7Ud5iX+LSi0q
         Orzg==
X-Gm-Message-State: AOAM533LH4r/wkMnqE9Usu+plGlqbSQvYkuA7tjmFvIebF1gOVZZwBnZ
        RnDCWD35trLf589uRLPbVUW7mtzqXhcRMfimPmE=
X-Google-Smtp-Source: ABdhPJy1cQs9Bcx2KLI7O1M+hytgLnfpb9EsS+I497WYYRltPdfjm7tK2yK47FJ6xYP2uGNfp8KkeM4MOGQqJfGHuqw=
X-Received: by 2002:a5e:9b0e:: with SMTP id j14mr37680837iok.127.1638824989563;
 Mon, 06 Dec 2021 13:09:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <984104c118a451fc4afa2eadb7206065f13b7af2.1638308023.git.andreyknvl@google.com>
 <CAG_fn=U71Yn-qCGMBR=_uOt0QCEu9skGzhgRBJjpkQCjZ=dKiA@mail.gmail.com>
In-Reply-To: <CAG_fn=U71Yn-qCGMBR=_uOt0QCEu9skGzhgRBJjpkQCjZ=dKiA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:09:38 +0100
Message-ID: <CA+fCnZfto82vg3vGkZGNxJKOOqsOp_bpmHEd0Z350PfPJ7Y=1w@mail.gmail.com>
Subject: Re: [PATCH 08/31] kasan, page_alloc: refactor init checks in post_alloc_hook
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
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

On Thu, Dec 2, 2021 at 5:14 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 10:41 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > This patch separates code for zeroing memory from the code clearing tags
> > in post_alloc_hook().
> >
> > This patch is not useful by itself but makes the simplifications in
> > the following patches easier to follow.
> >
> > This patch does no functional changes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/page_alloc.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2ada09a58e4b..0561cdafce36 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2406,19 +2406,21 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >                 kasan_alloc_pages(page, order, gfp_flags);
> >         } else {
> >                 bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
> > +               bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
> >
> >                 kasan_unpoison_pages(page, order, init);
> >
> > -               if (init) {
> > -                       if (gfp_flags & __GFP_ZEROTAGS) {
> > -                               int i;
> > +               if (init_tags) {
> > +                       int i;
> >
> > -                               for (i = 0; i < 1 << order; i++)
> > -                                       tag_clear_highpage(page + i);
> > -                       } else {
> > -                               kernel_init_free_pages(page, 1 << order);
> > -                       }
> > +                       for (i = 0; i < 1 << order; i++)
> > +                               tag_clear_highpage(page + i);
> > +
> > +                       init = false;
>
> I find this a bit twisted and prone to breakages.
> Maybe just check for (init && !init_tags) below?

I did it this way deliberately. Check out the code after all the changes:

https://github.com/xairy/linux/blob/up-kasan-vmalloc-tags-v1/mm/page_alloc.c#L2447

It's possible to remove resetting the init variable by expanding the
if (init) check listing all conditions under which init is currently
reset, but that would essentially be duplicating the checks. I think
resetting init is more clear.

Please let me know what you think.

Thanks!
