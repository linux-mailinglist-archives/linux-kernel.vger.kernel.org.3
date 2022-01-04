Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C34840D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiADL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiADL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:29:10 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD4EC061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 03:29:09 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id j6so28087236ila.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 03:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKqdYNUCxKzWzj64ePA/dIaYRd4jF6O5Lkt/GXeobao=;
        b=qL2vWPomO27J1PEwXZFya6wcIq0uH8g3dXvzklM5aowXYZNyJzriHug6Kl2j21Nzps
         hIRqsNusK1XQAgzpfrKvGa9mN0ace71v+2c4bIRKpqhPhmEAJfCdKR4YMtS7Ar38AZ/O
         YziR4gToYH7YAiH+W8m5zJgL0OotcfcWS02AOdWLt+fTfaT7s3xnbScS+2PHzN5PR7gs
         7lwkJo8ZRJkBufaFRnqw3aC1hEGqaeKg28r/4RFUgPy4kjGCEEU0jGCrQ6/vM+DuIlWQ
         g7TUyRo1jHMOeFMobU3hKaL5m26Ycgl4jHwi3fDje5ieNunAru8+o9Rukpfq4lUw9/zd
         m/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKqdYNUCxKzWzj64ePA/dIaYRd4jF6O5Lkt/GXeobao=;
        b=oVmk5i9NyRk1BQKGYzDrJKX9PY2HNFEjDuUbnO/LEwEUwuakUBCYjYQJj58jcwafZx
         36AXym5DP1lRWiVSTi735BwMgZF+MOqkaK0go6e8RAQMEjfxVntBBPrRQ9PdOBvJk2GL
         0stBC0RLpRvoDGayn/Oseb598U7l5tgUK8bno7/sPjelT5KIG2AzriN3V5k4xXBc2Yap
         a/0z1djAv7oApdlRvIXd171TLWE5dR5gZAqcJMqnIvPbDM1xVQ8rVCzQ4fRPXoXRWNRK
         yrsC5NZuELXI+kdgCllr60t4Ux3GgCChhBSNK2UBxqNaVoHGdSYyXARF6zsgt10Bs03g
         Fivw==
X-Gm-Message-State: AOAM531egrs+SxF63yA8yluZJxOSbqln4zuOy387sxjjTWbLyjrUbrP4
        TUADjosBquktTBY7YBhsA1OqfR00dgMXOwz4Y/4=
X-Google-Smtp-Source: ABdhPJxxsXPXjAmG3t87AeyeecNl+9d9kJZoif2QHp57xEI7LUNqvHJ+3B6eGT2gNprN9vPFF4mYIYQiUJNNY+4NZn4=
X-Received: by 2002:a05:6e02:1bec:: with SMTP id y12mr24360769ilv.233.1641295749226;
 Tue, 04 Jan 2022 03:29:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640891329.git.andreyknvl@google.com> <88f2964f4063aa6fd935ef8c8302d02d8d67005b.1640891329.git.andreyknvl@google.com>
 <b968e485f4d7f201fdb4e39f64ca757180e7374a.camel@mediatek.com>
In-Reply-To: <b968e485f4d7f201fdb4e39f64ca757180e7374a.camel@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 4 Jan 2022 12:28:58 +0100
Message-ID: <CA+fCnZd4p+80MqOLJTa0-SwcXPbXe+n3FsCCN2dFHJ+bAsdZ-A@mail.gmail.com>
Subject: Re: [PATCH mm v5 29/39] kasan, page_alloc: allow skipping memory init
 for HW_TAGS
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 3:32 AM Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> On Fri, 2021-12-31 at 03:14 +0800, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Add a new GFP flag __GFP_SKIP_ZERO that allows to skip memory
> > initialization. The flag is only effective with HW_TAGS KASAN.
> >
> > This flag will be used by vmalloc code for page_alloc allocations
> > backing vmalloc() mappings in a following patch. The reason to skip
> > memory initialization for these pages in page_alloc is because
> > vmalloc
> > code will be initializing them instead.
> >
> > With the current implementation, when __GFP_SKIP_ZERO is provided,
> > __GFP_ZEROTAGS is ignored. This doesn't matter, as these two flags
> > are
> > never provided at the same time. However, if this is changed in the
> > future, this particular implementation detail can be changed as well.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > ---
> >
> > Changes v4->v5:
> > - Cosmetic changes to __def_gfpflag_names_kasan and __GFP_BITS_SHIFT.
> >
> > Changes v3->v4:
> > - Only define __GFP_SKIP_ZERO when CONFIG_KASAN_HW_TAGS is enabled.
> > - Add __GFP_SKIP_ZERO to include/trace/events/mmflags.h.
> > - Use proper kasan_hw_tags_enabled() check instead of
> >   IS_ENABLED(CONFIG_KASAN_HW_TAGS). Also add explicit checks for
> >   software modes.
> >
> > Changes v2->v3:
> > - Update patch description.
> >
> > Changes v1->v2:
> > - Add this patch.
> > ---
> >  include/linux/gfp.h            | 18 +++++++++++-------
> >  include/trace/events/mmflags.h |  1 +
> >  mm/page_alloc.c                | 18 +++++++++++++++++-
> >  3 files changed, 29 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 487126f089e1..6eef3e447540 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -55,14 +55,16 @@ struct vm_area_struct;
> >  #define ___GFP_ACCOUNT               0x400000u
> >  #define ___GFP_ZEROTAGS              0x800000u
> >  #ifdef CONFIG_KASAN_HW_TAGS
> > -#define ___GFP_SKIP_KASAN_UNPOISON   0x1000000u
> > -#define ___GFP_SKIP_KASAN_POISON     0x2000000u
> > +#define ___GFP_SKIP_ZERO             0x1000000u
> > +#define ___GFP_SKIP_KASAN_UNPOISON   0x2000000u
> > +#define ___GFP_SKIP_KASAN_POISON     0x4000000u
> >  #else
> > +#define ___GFP_SKIP_ZERO             0
> >  #define ___GFP_SKIP_KASAN_UNPOISON   0
> >  #define ___GFP_SKIP_KASAN_POISON     0
> >  #endif
> >  #ifdef CONFIG_LOCKDEP
> > -#define ___GFP_NOLOCKDEP     0x4000000u
> > +#define ___GFP_NOLOCKDEP     0x8000000u
> >  #else
> >  #define ___GFP_NOLOCKDEP     0
> >  #endif
> > @@ -235,9 +237,10 @@ struct vm_area_struct;
> >   * %__GFP_ZERO returns a zeroed page on success.
> >   *
> >   * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the
> > memory itself
> > - * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
> > This flag is
> > - * intended for optimization: setting memory tags at the same time
> > as zeroing
> > - * memory has minimal additional performace impact.
> > + * is being zeroed (either via __GFP_ZERO or via init_on_alloc,
> > provided that
> > + * __GFP_SKIP_ZERO is not set). This flag is intended for
> > optimization: setting
> > + * memory tags at the same time as zeroing memory has minimal
> > additional
> > + * performace impact.
> >   *
> >   * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page
> > allocation.
> >   * Only effective in HW_TAGS mode.
> > @@ -249,6 +252,7 @@ struct vm_area_struct;
> >  #define __GFP_COMP   ((__force gfp_t)___GFP_COMP)
> >  #define __GFP_ZERO   ((__force gfp_t)___GFP_ZERO)
> >  #define __GFP_ZEROTAGS       ((__force gfp_t)___GFP_ZEROTAGS)
> > +#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
> >  #define __GFP_SKIP_KASAN_UNPOISON ((__force
> > gfp_t)___GFP_SKIP_KASAN_UNPOISON)
> >  #define __GFP_SKIP_KASAN_POISON   ((__force
> > gfp_t)___GFP_SKIP_KASAN_POISON)
> >
> > @@ -257,7 +261,7 @@ struct vm_area_struct;
> >
> >  /* Room for N __GFP_FOO bits */
> >  #define __GFP_BITS_SHIFT (24 +
> >       \
> > -                       2 * IS_ENABLED(CONFIG_KASAN_HW_TAGS) +        \
> > +                       3 * IS_ENABLED(CONFIG_KASAN_HW_TAGS) +        \
> >                         IS_ENABLED(CONFIG_LOCKDEP))
> >  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) -
> > 1))
> >
> > diff --git a/include/trace/events/mmflags.h
> > b/include/trace/events/mmflags.h
> > index 5ffc7bdce91f..0698c5d0f194 100644
> > --- a/include/trace/events/mmflags.h
> > +++ b/include/trace/events/mmflags.h
> > @@ -52,6 +52,7 @@
> >
> >  #ifdef CONFIG_KASAN_HW_TAGS
> >  #define __def_gfpflag_names_kasan ,
> >        \
> > +     {(unsigned long)__GFP_SKIP_ZERO,           "__GFP_SKIP_ZERO"},
> >   \
> >       {(unsigned
> > long)__GFP_SKIP_KASAN_POISON,   "__GFP_SKIP_KASAN_POISON"}, \
> >       {(unsigned long)__GFP_SKIP_KASAN_UNPOISON,
> > "__GFP_SKIP_KASAN_UNPOISON"}
> >  #else
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 102f0cd8815e..30da0e1f94f8 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2415,10 +2415,26 @@ static inline bool
> > should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
> >       return init_tags || (flags & __GFP_SKIP_KASAN_UNPOISON);
> >  }
> >
> > +static inline bool should_skip_init(gfp_t flags)
> > +{
> > +     /* Don't skip if a software KASAN mode is enabled. */
> > +     if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > +         IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > +             return false;
>
> Forget to drop the above check?
>
> I saw v4 mentioned that this check can be dropped. [1]
>
> Do I miss something?
>
> [1] https://lkml.org/lkml/2021/12/30/450

Right, forgot to include this change. Will include into v5 or post as
a standalone fix closer to rc1. Thanks for noticing!
