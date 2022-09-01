Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62F35A9E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiIARvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIARvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:51:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C7606B0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:51:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p8-20020a17090ad30800b001fdfc8c7567so5958235pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ydOUsvfoYP5w3ZdcSNr57xEXqz42yurihKzVQuaAqlU=;
        b=PrWSLe97cVkJlciww9uG8TE8kFuxL/HQILWj2oC8RGORwaCmDjC50hmfLyGgH4UndZ
         NBbX37mSiYM7gajDrqE/v4Lj9T0sJUMZjRvkeMJ3SW0OHH3hkr3OpY0nbttpgovV0Ipc
         x2gYZQ7qTUMP+ZzI+cuhHtm8TVA1+eI3l8m/r1N7eaIWvZS8z8pGda5MnrHYVzRnldWh
         v0N0oeUshMQ22jXKYXWCVeOfNHvmMg6iFKg17p6uaqCOcGG2oqziX9bqWyggUFoVxkA5
         Zd8IFgNrrDs65mwyXDKnVVH4TugPbVlmzjLo+xRoRv+kB1prFyQDFCLxqs1EsYB+xdBg
         2OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ydOUsvfoYP5w3ZdcSNr57xEXqz42yurihKzVQuaAqlU=;
        b=S4EWs8oyHpKuilMP6P2m0yvku/RsoCqynsIfDbFi/LeaZeeNuv/ejlTbCQG8g2UdyR
         H5I7KzswzvSFHOQ7xupUTjh4f1JeYJaAjyLMvZ8Ryjencc2riiHU6h9yqv+1neUW7RG3
         +VqL7a09DkdQQS/NxUpDyi7sKHTl72MEPl61q6OT7qmjxgcAyzq4+1OmD8w/zVx0ypn2
         t0iZy9sxwjPfc2BZGRgn9hKVbAhjGsPcavHC+FdKBYQgc3yb1PEj8KLHBrHTmjXdWhlM
         L6kRnL/DQv0pyArNFw5bIH1Uq3K7sAXGL6cYZwu3p+MwJH7pRy0U5pjO6N3AEr9258c8
         Ivkg==
X-Gm-Message-State: ACgBeo35PsNLqyuoIH8a0/2ysLiE4R8XfSdbFes2icmmGUY54XbOtAJ1
        5Q0473wnjuR4CQlK4R9kMKx1FcNdqeeP/v7cEVs=
X-Google-Smtp-Source: AA6agR6YPaL/8RIc5vgRqhHlaUpwRW3LY6QgLtwmkywmKtjgkqcdYotiTSpnuv9lg5Lk6IsfVLe737MDidzN9/ycTPo=
X-Received: by 2002:a17:90a:bc9:b0:1fb:c5bf:e9d with SMTP id
 x9-20020a17090a0bc900b001fbc5bf0e9dmr292313pjd.21.1662054661221; Thu, 01 Sep
 2022 10:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220901072119.37588-1-david@redhat.com> <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com> <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
In-Reply-To: <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Sep 2022 10:50:48 -0700
Message-ID: <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 9:46 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.09.22 18:40, Peter Xu wrote:
> > On Thu, Sep 01, 2022 at 06:34:41PM +0200, David Hildenbrand wrote:
> >> On 01.09.22 18:28, Peter Xu wrote:
> >>> On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
> >>>> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
> >>>> PMDs") didn't remove all details about the THP split requirements for
> >>>> RCU GUP-fast.
> >>>>
> >>>> IPI broeadcasts on THP split are no longer required.
> >>>>
> >>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>>> Cc: Sasha Levin <sasha.levin@oracle.com>
> >>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >>>> Cc: Vlastimil Babka <vbabka@suse.cz>
> >>>> Cc: Jerome Marchand <jmarchan@redhat.com>
> >>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >>>> Cc: Hugh Dickins <hughd@google.com>
> >>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
> >>>> Cc: John Hubbard <jhubbard@nvidia.com>
> >>>> Cc: Peter Xu <peterx@redhat.com>
> >>>> Cc: Yang Shi <shy828301@gmail.com>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  mm/gup.c | 5 ++---
> >>>>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/mm/gup.c b/mm/gup.c
> >>>> index 5abdaf487460..cfe71f422787 100644
> >>>> --- a/mm/gup.c
> >>>> +++ b/mm/gup.c
> >>>> @@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
> >>>>   *
> >>>>   * Another way to achieve this is to batch up page table containing pages
> >>>>   * belonging to more than one mm_user, then rcu_sched a callback to free those
> >>>> - * pages. Disabling interrupts will allow the fast_gup walker to both block
> >>>> - * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
> >>>> - * (which is a relatively rare event). The code below adopts this strategy.
> >>>> + * pages. Disabling interrupts will allow the fast_gup walker to block the
> >>>> + * rcu_sched callback.
> >>>
> >>> This is the comment for fast-gup in general but not only for thp split.
> >>
> >> "an IPI that we broadcast for splitting THP" is about splitting THP.
> >
> > Ah OK.  Shall we still keep some "IPI broadcast" information here if we're
> > modifying it?  Otherwise it gives a feeling that none needs the IPIs.
>
> I guess that's the end goal -- and we forgot about the PMD collapse case.
>
> Are we aware of any other case that needs an IPI? I'd rather avoid
> documenting something that's no longer true.
>
> >
> > It can be dropped later if you want to rework the thp collapse side and
> > finally remove IPI dependency on fast-gup, but so far it seems to me it's
> > still needed.  Or just drop this patch until that rework happens?
>
> The doc as is is obviously stale, why drop this patch?
>
> We should see a fix for the THP collapse issue very soon I guess. Most
> probably this patch will go upstream after that fix.

I will be working on the fix.

>
> >
> >>
> >>>
> >>> I can understand that we don't need IPI for thp split, but isn't the IPIs
> >>> still needed for thp collapse (aka pmdp_collapse_flush)?
> >>
> >> That was, unfortunately, never documented -- and as discussed in the
> >> other thread, arm64 doesn't do that IPI before collapse and might need
> >> fixing. We'll most probably end up getting rid of that
> >> (undocumented/forgotten) IPI requirement and fix it in GUP-fast by
> >> re-rechecking if the PMD changed.
> >
> > Yeah from an initial thought that looks valid to me.  It'll also allow
> > pmdp_collapse_flush() to be dropped too, am I right?
>
> I think the magic about pmdp_collapse_flush() is not only the IPIs, but
> that we don't perform an ordinary PMD flush but we logically flush "all
> PTEs in that range".

Yeah, because THP collapse does copy the data before clearing pte. If
we want to remove pmdp_collapse_flush() by just clearing pmd, we
should clear *AND* flush pte before copying the data IIRC.

>
> Apparently, that's a difference on some architectures.
>
>
> --
> Thanks,
>
> David / dhildenb
>
