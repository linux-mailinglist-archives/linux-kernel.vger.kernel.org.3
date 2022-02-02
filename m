Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1204A7272
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiBBN7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBBN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:59:05 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA2C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:59:05 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p5so61172998ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWG9s1d/GvbwnTAYal6lRjtSrir89rmlhhFZo56v7xg=;
        b=0nQIn2NAlIoliEmY6SS6YwYBuiIbHPE+5Apygk3dbZfBoCgVICwMSvt9lX90OuMT9S
         6QrtNpPBhvW6Vl0yZw4cHWfyaz0WaHJ0LeTL7B873nyREhUI4pi82laXzphU34F6cujz
         xsjRgnBHHZYb/CGMqVOwxpRNZ8ChRWryGOXrvZS1FL16+NILZ8x4A6KHaxhsNfCSY+vo
         culkY6dG8arMD37GC2AGT+NwvcYKA0k3s0d0sdtssSfO/mAHI8XUwbcC/8gkK7+jpM/w
         7L1mwjf24KLb13ToS5UztFDh4tGi/fZp1Z+0SamF0syShLYGKe2rIDc9whjazf5VTzNH
         qcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWG9s1d/GvbwnTAYal6lRjtSrir89rmlhhFZo56v7xg=;
        b=jBOSS9W7YwLaFyikUiwBQVi0hGUVE9R4mizmpohi/W2+5rQBZozAOmcRndA7tADMFX
         ajhMf24fKQIBKieJKE495KGfIcxUpswPwTmEFOdsIijsTEhIUgxrHA0rFb1ddmX1QygT
         pZ6KGHpUrN6e/McZYtgoBoJGGoFqHvqVyVK63oMgRElQw0kQbTwojzwuKKspbUSa0snF
         J3XNOk0ZCI1VoppKJmd5yMjk6ITkIXNAdWEJrOt5yN0tOuQyRr3yDlZah8Adzb3cAAho
         2DXXq5B7U52dJgoYeaLGZVEUFX6+wvktl58Lsqi8FA2L/jPV2EQhQjuf34m/M6vGuYrN
         y2AA==
X-Gm-Message-State: AOAM532KfqlT4qylAXhIFQ43Zc4L4zVZwqTQ94z4uLhU2xAL8OubR02H
        2bT5AI7gOOBzPC4LiYSiwmOe9HnvT1T2Jt2Bbg+7ew==
X-Google-Smtp-Source: ABdhPJxnAIVW3l9/Qp/Grw4bohejfPa8v/qFOIktxw0zhGzSL9UlCZsT5sNDz0zULIC2JOT6+Dx4DqAbc2IbbSrXlDI=
X-Received: by 2002:a25:6b4e:: with SMTP id o14mr30320536ybm.485.1643810344332;
 Wed, 02 Feb 2022 05:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20220131160254.43211-1-songmuchun@bytedance.com>
 <20220131160254.43211-5-songmuchun@bytedance.com> <14df55c2-cab5-8ff0-5986-fd186c2f60d7@oracle.com>
In-Reply-To: <14df55c2-cab5-8ff0-5986-fd186c2f60d7@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 2 Feb 2022 21:58:26 +0800
Message-ID: <CAMZfGtWet8NB6+psZpEQDzX9uoUMNL4OiNDukREB4=D91JRG=Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm: hugetlb: fix missing cache flush in hugetlb_mcopy_atomic_pte()
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, zi.yan@cs.rutgers.edu,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Lars Persson <lars.persson@axis.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 6:24 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Cc: Matthew
>
> On 1/31/22 08:02, Muchun Song wrote:
> > folio_copy() will copy the data from one page to the target page, then
> > the target page will be mapped to the user space address, which might
> > have an alias issue with the kernel address used to copy the data from
> > the page to.  Fix this issue by flushing dcache but not use
> > flush_dcache_folio() since it is not backportable.
> >
> > Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a1baa198519a..f1f1ab31dc8a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5804,6 +5804,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                       goto out;
> >               }
> >       } else {
> > +             int i, nr;
> > +
> >               if (vm_shared &&
> >                   hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> >                       put_page(*pagep);
> > @@ -5819,6 +5821,9 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                       goto out;
> >               }
> >               folio_copy(page_folio(page), page_folio(*pagep));
>
> What if we changed that folio_copy() to?
>
>                 copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
>                         pages_per_huge_page(h));
>
> Seems like that would take care of the flush_dcache_page and it would be
> backportable.

Agree. I also can replace folio_copy() with copy_user_huge_page().

>
> Of course, Matthew may hate the idea.  Not sure if there are any plans to
> convert copy_user_huge_page to use folio type as it has some special hinting
> logic.
