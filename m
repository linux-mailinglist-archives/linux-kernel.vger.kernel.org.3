Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D6747B546
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhLTVfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhLTVfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:35:42 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F2AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:35:42 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z26so15060428iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHpnB8CgjO+Yms6LesT1nUtQhl96Ut7K5WNqbdqk9YA=;
        b=qmMCnZ2CAKXnvSb1UcEQ07PxaRUHUSv9olfxSKSStbG9LRfse0miTWGzENPDnItdI/
         Krwc5RMYjB6XsXzX3Uh7BBZqFKD2pB1kArzol8q5yvx2Od/QNdH/2Qp68dtH2xbKSssO
         ADTFwp4ay8AgNvZG8LSZH3sMRqLEu/kNauVU1Rliup51knG4e0MeuDOzbgtajTmLW7Js
         GCXLoEwi+HQWTF10FPgsbIGn+7ZlZqB3YKHswQ3Bea5Xsm4h5pU3VtWiLRpojLIhMkky
         NUUa4/qtLpGfwm++QK2qZgHrpFOhJZGiAGzPehBN2nchntJvcuVVGPtXUE3TCeRCbN9l
         DRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHpnB8CgjO+Yms6LesT1nUtQhl96Ut7K5WNqbdqk9YA=;
        b=FQFBC+XO6XtD6ewpZopyTNhPVPk4n0xUBnRdWDu4vxhg0Ftnw2mnNuKyMCQBd85cVc
         gYigT3zDk5SeXv90IbhQVpjm69QWiY30OFhBsFP4AhYIebO7eMjhc9oZrblk+kG6WKtw
         B/v0XPYeAORbKg1n8SyZRsl5N0yriUOSVT7pJpVXnqxSzWhxWmh70fd86+tRvAVZorxe
         SfE5NS5BXVw+2BjP+93jT70y0xiAxLjJX76Gbg+rck9HADeijE5/zE1917gnNx5RgLAn
         b34BvxOY8jvw5RSuxj8Mz83kMM0J/6uE+FMKrzPJ2aMfZa4mSaLVlaou+r+6QYwhuTlB
         rz3A==
X-Gm-Message-State: AOAM530fFa7cXr2SvAvf9oH273/rnG5zFWH0yAh3I+HRcCF5HoR3t0W6
        0FYVHcg42tJkIi7hdr67x71NFScHTPbcX2VtKeM=
X-Google-Smtp-Source: ABdhPJxBTygb3u57J5jvVKsxH6KIELAKzWIk/6tVBq8E9yx8HJNdHuQJ51UZCO43e0irDMYSNF78NSGUu6AmfSOBB2c=
X-Received: by 2002:a05:6638:3449:: with SMTP id q9mr84508jav.218.1640036141911;
 Mon, 20 Dec 2021 13:35:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <cd8667450f7a0daf6b4081276e11a5f7bed60128.1639432170.git.andreyknvl@google.com>
 <bf06044e10b5eae36c9ac6ad0d56c77b35ca8585.camel@mediatek.com>
In-Reply-To: <bf06044e10b5eae36c9ac6ad0d56c77b35ca8585.camel@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 20 Dec 2021 22:35:31 +0100
Message-ID: <CA+fCnZe1Szu7V6PbWpBBiOJfUV0-YO03wpR_L6zn_nJ06-UfAQ@mail.gmail.com>
Subject: Re: [PATCH mm v3 28/38] kasan, page_alloc: allow skipping memory init
 for HW_TAGS
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Dec 17, 2021 at 2:50 AM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> On Tue, 2021-12-14 at 05:54 +0800, andrey.konovalov@linux.dev wrote:
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
> > Changes v2->v3:
> > - Update patch description.
> >
> > Changes v1->v2:
> > - Add this patch.
> > ---
> >  include/linux/gfp.h | 16 +++++++++++-----
> >  mm/page_alloc.c     | 13 ++++++++++++-
> >  2 files changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 6781f84345d1..b8b1a7198186 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -54,10 +54,11 @@ struct vm_area_struct;
> >  #define ___GFP_THISNODE              0x200000u
> >  #define ___GFP_ACCOUNT               0x400000u
> >  #define ___GFP_ZEROTAGS              0x800000u
> > -#define ___GFP_SKIP_KASAN_UNPOISON   0x1000000u
> > -#define ___GFP_SKIP_KASAN_POISON     0x2000000u
> > +#define ___GFP_SKIP_ZERO     0x1000000u
> > +#define ___GFP_SKIP_KASAN_UNPOISON   0x2000000u
> > +#define ___GFP_SKIP_KASAN_POISON     0x4000000u
> >  #ifdef CONFIG_LOCKDEP
> > -#define ___GFP_NOLOCKDEP     0x4000000u
> > +#define ___GFP_NOLOCKDEP     0x8000000u
> >  #else
> >  #define ___GFP_NOLOCKDEP     0
> >  #endif
> > @@ -230,7 +231,11 @@ struct vm_area_struct;
> >   * %__GFP_ZERO returns a zeroed page on success.
> >   *
> >   * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the
> > memory itself
> > - * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
> > + * is being zeroed (either via __GFP_ZERO or via init_on_alloc,
> > provided that
> > + * __GFP_SKIP_ZERO is not set).
> > + *
> > + * %__GFP_SKIP_ZERO makes page_alloc skip zeroing memory.
> > + * Only effective when HW_TAGS KASAN is enabled.
> >   *
> >   * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page
> > allocation.
> >   * Only effective in HW_TAGS mode.
> > @@ -242,6 +247,7 @@ struct vm_area_struct;
> >  #define __GFP_COMP   ((__force gfp_t)___GFP_COMP)
> >  #define __GFP_ZERO   ((__force gfp_t)___GFP_ZERO)
> >  #define __GFP_ZEROTAGS       ((__force gfp_t)___GFP_ZEROTAGS)
> > +#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
> >  #define __GFP_SKIP_KASAN_UNPOISON ((__force
> > gfp_t)___GFP_SKIP_KASAN_UNPOISON)
> >  #define __GFP_SKIP_KASAN_POISON   ((__force
> > gfp_t)___GFP_SKIP_KASAN_POISON)
> >
> > @@ -249,7 +255,7 @@ struct vm_area_struct;
> >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> >
> >  /* Room for N __GFP_FOO bits */
> > -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> > +#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
> >  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) -
> > 1))
> >
> >  /**
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index f1d5b80591c4..af7516a2d5ea 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2409,10 +2409,21 @@ static inline bool
> > should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
> >       return init_tags || (flags & __GFP_SKIP_KASAN_UNPOISON);
> >  }
> >
> > +static inline bool should_skip_init(gfp_t flags)
> > +{
> > +     /* Don't skip if a software KASAN mode is enabled. */
> > +     if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> > +             return false;
> > +
>
> Hi Andrey,
>
> Should we use kasan_hw_tags_enabled() in should_skip_init() function
> instead of checking the config?
>
> I think we should handle the condition which is CONFIG_KASAN_HW_TAGS=y
> and command line="kasan=off".

Hi Kuan-Ying,

You are right! Will fix in v4.

Thanks!
