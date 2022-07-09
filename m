Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20E956CBA3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGIVzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:55:23 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B9101FF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 14:55:22 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id o4so911040vkn.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5vX9g3QlJXGDvHYS9ZplleP1BmnBHlgaCZWjSk2y80=;
        b=I3VpOlqiRPKDGKNIAZvPTv1BhrbcMCbJMGu/BSBubGZ7OWBipS7uQQULi/6rLuMiY0
         kIYZnqQPZvM2euzXamEg/MOPs5zdYr4o7YVYXV6capKSGkBGQ34FFT32B4XPjm9HiE+4
         SkOG9y4RIkg0q67zlLaCSUSV2R/skGaMh9Ipa26wqRCIH+yCv0Nz72xfzR6EEqHYMKcU
         ZkcmMIkbe2nPdk46DdgaxEsyrQpSC2S1p/9kRyYF/eTG98PtB0xtJGnjzW/kEJT/MM6F
         fPNMJ9T0BiAXg/H/witSVFtf9GOhrkLJMj4vvMXkHIxFV9KnoxIYFnUICqkro0mFFiKF
         OxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5vX9g3QlJXGDvHYS9ZplleP1BmnBHlgaCZWjSk2y80=;
        b=xBfFM51bsO9Ab5mBE/sMpzJFeDIauOXCbt4NK8y4Yt3Z6MO3+PGHmJAR6QR2x7fT4j
         Fw0lCabpU2fp8CsvNYFA7Mz9h0XV7hes4MiNj3ZZEuRi3eDE57yjw3f4+TQ79JF+gzOx
         JfwlJhhYgel+UMWlFH/FA/WdOIzVj9v8YoALh6ZEfh2xBhRikRlmYbpjfrceID9iswRU
         zq6JHLaxNXwLbTUStVGzcG9VO2ATungwVi8/MsBQoZh3fZfYQQu8Jx1+PdO0axzCmHjJ
         p0I/RMFGVbMt4L4HBaJDp237CZ23Kg5dIOYc5WRQecHVbnDjRhGmHIdQUSzbXQmGwrS6
         g3ig==
X-Gm-Message-State: AJIora/B1N1JpUiymGu0dqDbBtQ51rA0HwzMS0q5v7c3492LGxPMoG6H
        BSIO713uG4RYbiFs/ed8H1D01RqFZbTF/dH6CXLfXg==
X-Google-Smtp-Source: AGRyM1sI66wHiZCEyb+gRAA+zSgCNS3M8HIwI0tET8FnKNuaoY1e9NPUBeEdfitzKvMpplV9ZpK6y2IjNIg8WufsoJA=
X-Received: by 2002:a1f:2a86:0:b0:370:8ff3:d5f with SMTP id
 q128-20020a1f2a86000000b003708ff30d5fmr4049359vkq.35.1657403720760; Sat, 09
 Jul 2022 14:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-11-jthoughton@google.com> <CAHS8izNO+4Nzg=rgr1R027i2Evo-UKiFEK1gQcMHtF8uxcHzeQ@mail.gmail.com>
 <CADrL8HWuDZKf+9ERzNGNqneEdotSnKHf7cqZs0enVJj30gOULw@mail.gmail.com>
In-Reply-To: <CADrL8HWuDZKf+9ERzNGNqneEdotSnKHf7cqZs0enVJj30gOULw@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sat, 9 Jul 2022 14:55:09 -0700
Message-ID: <CAHS8izNKz=gxyC0aZpZaSo9d-Z+p0dFmFmsc20r0t3NmjT7idA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/26] hugetlb: add for_each_hgm_shift
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 8:52 AM James Houghton <jthoughton@google.com> wrote:
>
> On Tue, Jun 28, 2022 at 2:58 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
> > >
> > > This is a helper macro to loop through all the usable page sizes for a
> > > high-granularity-enabled HugeTLB VMA. Given the VMA's hstate, it will
> > > loop, in descending order, through the page sizes that HugeTLB supports
> > > for this architecture; it always includes PAGE_SIZE.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > ---
> > >  mm/hugetlb.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 8b10b941458d..557b0afdb503 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -6989,6 +6989,16 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> > >         /* All shared VMAs have HGM enabled. */
> > >         return vma->vm_flags & VM_SHARED;
> > >  }
> > > +static unsigned int __shift_for_hstate(struct hstate *h)
> > > +{
> > > +       if (h >= &hstates[hugetlb_max_hstate])
> > > +               return PAGE_SHIFT;
> >
> > h > &hstates[hugetlb_max_hstate] means that h is out of bounds, no? am
> > I missing something here?
>
> Yeah, it goes out of bounds intentionally. Maybe I should have called
> this out. We need for_each_hgm_shift to include PAGE_SHIFT, and there
> is no hstate for it. So to handle it, we iterate past the end of the
> hstate array, and when we are past the end, we return PAGE_SHIFT and
> stop iterating further. This is admittedly kind of gross; if you have
> other suggestions for a way to get a clean `for_each_hgm_shift` macro
> like this, I'm all ears. :)
>
> >
> > So is this intending to do:
> >
> > if (h == hstates[hugetlb_max_hstate]
> >     return PAGE_SHIFT;
> >
> > ? If so, could we write it as so?
>
> Yeah, this works. I'll write it this way instead. If that condition is
> true, `h` is out of bounds (`hugetlb_max_hstate` is past the end, not
> the index for the final element). I guess `hugetlb_max_hstate` is a
> bit of a misnomer.
>
> >
> > I'm also wondering why __shift_for_hstate(hstate[hugetlb_max_hstate])
> > == PAGE_SHIFT? Isn't the last hstate the smallest hstate which should
> > be 2MB on x86? Shouldn't this return PMD_SHIFT in that case?
>
> `huge_page_shift(hstate[hugetlb_max_hstate-1])` is PMD_SHIFT on x86.
> Actually reading `hstate[hugetlb_max_hstate]` would be bad, which is
> why `__shift_for_hstate` exists: to return PAGE_SIZE when we would
> otherwise attempt to compute
> `huge_page_shift(hstate[hugetlb_max_hstate])`.
>
> >
> > > +       return huge_page_shift(h);
> > > +}
> > > +#define for_each_hgm_shift(hstate, tmp_h, shift) \
> > > +       for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
> > > +                              (tmp_h) <= &hstates[hugetlb_max_hstate]; \
>
> Note the <= here. If we wanted to always remain inbounds here, we'd
> want < instead. But we don't have an hstate for PAGE_SIZE.
>

I see, thanks for the explanation. I can see 2 options here to make
the code more understandable:

option (a), don't go past the array. I.e. for_each_hgm_shift() will
loop over all the hugetlb-supported shifts on this arch, and the
calling code falls back to PAGE_SHIFT if the hugetlb page shifts don't
work for it. I admit that could lead to code dup in the calling code,
but I have not gotten to the patch that calls this yet.

option (b), simply add a comment and/or make it more obvious that
you're intentionally going out of bounds, and you want to loop over
PAGE_SHIFT at the end. Something like:

+ /* Returns huge_page_shift(h) if h is a pointer to an hstate in
hstates[] array, PAGE_SIZE otherwise. */
+static unsigned int __shift_for_hstate(struct hstate *h)
+{
+       if (h < &hstates[0] || h > &hstates[hugetlb_max_hstate - 1])
+               return PAGE_SHIFT;
+       return huge_page_shift(h);
+}
+
+ /* Loops over all the HGM shifts supported on this arch, from the
largest shift possible down to PAGE_SHIFT inclusive. */
+#define for_each_hgm_shift(hstate, tmp_h, shift) \
+       for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
+                              (tmp_h) <= &hstates[hugetlb_max_hstate]; \
+                              (tmp_h)++)
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */

> > > +                              (tmp_h)++)
> > >  #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> > >
> > >  /*
> > > --
> > > 2.37.0.rc0.161.g10f37bed90-goog
> > >
