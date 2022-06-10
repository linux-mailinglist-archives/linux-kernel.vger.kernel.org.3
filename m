Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1E5458E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiFJAB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFJAB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:01:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD25B2358E9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:01:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f65so13078401pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 17:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1O6AEKHlVD9Bngjug6xvCzo7n1uYfU+pNTujv/UlryM=;
        b=gKODhx7XfIhwVIKz1he6ZDxvO/tY2AjUieoIgQuHMoThC0FJ4vzfaklHySIZt6r5WJ
         1R8GaaFWN7nRXrevu/NSq1d8aV7Nu5/Sq5SLQHFVXwnEKGZJ5+q1zAkFZtFVBmGUCXpX
         N/Qwo7oTj9TeHGHffxgpURt4vfLx88GxXrRySh/Sl3XSD2BJnZbEbVYT/3f9not46+ZI
         NeJ4VyzzDhjO9WJnnxSD2Oi+D9cmk9rIflkNVFrOj/9R5e/oxmPlmHcCQcgxtU3MyvMw
         Ny75uHCxqiIETZYnXUhrZqG3DvDjUFLb+/+sXo+YrKfswDw/6fHuk6llXVutFVIDRKdU
         FAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1O6AEKHlVD9Bngjug6xvCzo7n1uYfU+pNTujv/UlryM=;
        b=CEpD4F48tpR4EWibvVtR1Avu7YdcZJNCzcgb4vhOxuIFaB7FRKG3+fmEh4il3V7mbl
         taP7IIEIPX5AK8Gl1JgVxT0r2tHaR7pixtBAPIobmgCg64Ch7iv29yHnqPxY5P31ooTB
         C8P5bzhMnO+qxbX6zR6Ura5IoTL3Y9hdzHy8lBIqSKc8eRoNdb3gZxvpOsKCdDmR1n+y
         lc0zHPKmgcg/L3rISbzK7bpav6sWsjoqHK3KbdClvgq99ageTxLd7hNNaJm3Oyvmk9eb
         7fo/MFNo6JOQZlti4BBc5aiEdzPQAQCIXcdbEvffBPlxlXeUDiM0zWo59Yb7X7tgodg2
         UYgQ==
X-Gm-Message-State: AOAM533VFyemkSg8n/5yvZzXcKNgFOlXDR07fJdDGIi5SIbTymkn8K/0
        vrqYXVn6OL0zVgpJtSKXa/s5D2PSgJ0OdJ3+zNc=
X-Google-Smtp-Source: ABdhPJzSTcuzVCQRZSa7XT1K3nxjYb6HDH+tN6bJ4JerIlwdo7OsNzX3wTowpisIFYReXy6Awud5rJq+I+eFfEF/O34=
X-Received: by 2002:a05:6a02:184:b0:3fc:3b43:e5da with SMTP id
 bj4-20020a056a02018400b003fc3b43e5damr36066679pgb.587.1654819312838; Thu, 09
 Jun 2022 17:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-4-shy828301@gmail.com>
 <CAAa6QmRTt2EXJTudBf7DK6yPTr2DRDUbGZiHDC8pAmKRwoB4_A@mail.gmail.com>
In-Reply-To: <CAAa6QmRTt2EXJTudBf7DK6yPTr2DRDUbGZiHDC8pAmKRwoB4_A@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 9 Jun 2022 17:01:40 -0700
Message-ID: <CAHbLzkqhH5oJmQ6YMvBoAW17t03nqwJsrxfzw4gXtP_mTtnWAg@mail.gmail.com>
Subject: Re: [v3 PATCH 3/7] mm: khugepaged: remove the redundant anon vma check
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 9, 2022 at 4:24 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > The hugepage_vma_check() already checked it, so remove the redundant
> > check.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/khugepaged.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index d0f8020164fc..7a5d1c1a1833 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -966,9 +966,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> >                 return SCAN_ADDRESS_RANGE;
> >         if (!hugepage_vma_check(vma, vma->vm_flags))
> >                 return SCAN_VMA_CHECK;
> > -       /* Anon VMA expected */
> > -       if (!vma->anon_vma || !vma_is_anonymous(vma))
> > -               return SCAN_VMA_CHECK;
> >         return 0;
> >  }
> >
> > --
> > 2.26.3
> >
> >
>
> So, I don't know if this is possible, but I wonder if there is a race here:
>
> hugepage_vma_revalidate() is called in the anon path when mmap_lock
> after dropped + reacquired, and we want to refind / revalidate the
> vma, since it might have changed.
>
> There is the possibility that the memory was unmapped, then remapped
> as file or shmem. If so, hugepage_vma_check() could return true
> without actually checking vma->anon_vma || !vma_is_anonymous(vma) -
> and we probably do want to (re)validate that this is indeed still an
> anon vma.

Nice catch! Totally possible. I did overlook this. I will drop this
patch in the next version or maybe making the comment clearer is a
better choice.
