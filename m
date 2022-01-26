Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E9149C9C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiAZMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbiAZMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:34:57 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCECC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:34:57 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id h7so38744411ejf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A872bzMo6IlzyAAaWw5oHBWQXder2YytjfpeZ9XG+YI=;
        b=dLcrTCHgZcoiBBrgo+IT+WWZcsahinvRFDXNidl+eV1OG12bGu7I6xaNL82s+EBKv2
         IJjyrcfFhuwJZ1sA/nXSwuiWMJOCMjCS9lcu2VoKXklf9VT2M+F4Jpp1XqO2KtSWLTH7
         iGImzI/53J51uWCaN80T3ayPBbQdrnx4TNm/O1tlhcYRIgkQgu/mKcQ1q/79rTvobqXO
         gPuF2b2FHMtJqlo6/Te7Q/6c5KpP0TTrTSy2UGKP4eSupuilp3YrK07yKJmwQDnS97nQ
         337HDYc8smOlARoDdWP5vb9i/MHr8SUJ0rgW9IcsGJbonEk08b6gIdGrvRrt4XZ0ae+f
         atrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A872bzMo6IlzyAAaWw5oHBWQXder2YytjfpeZ9XG+YI=;
        b=gaes7xCojweYu9U3p3/QiLwCyn96dmoOUmV5i8VRSKbVldVDDp5luMhKXJDu2fQyxK
         iXt0esV3iochzbrqH3XH5uJfvJfLAPlW50LR9qh0OZtjBO3loEg/mTVZidB6zE3vaOl0
         j1iILm/xxYEWnRq2O1Kfp8sxdc0CX5Nl03J+nN580x5iauNE1w6F/XnG/YFC+yFQyTem
         Z1U84mMBfVZTp8RjIKxl4FdfdJbciwmetWHaf1zRRdWRDgbJJ/zi95XjUDFrdaBUXYtj
         ULbhzkFAPPm3HZZUehbRMsag6I5D9aa17r2VlA2VhhB+PXCVTNToirQeGAuNJkRcJxbJ
         Pn/Q==
X-Gm-Message-State: AOAM533csh1YIjaL/iBDvLYjRCIvpv6tYegpaC7EpXXF/q1hZdacXx7w
        oxHDRxX6WvJAqgPjC4OgsohXBCBWVAa5E8sLbmaP1Q==
X-Google-Smtp-Source: ABdhPJzzm/M/KzGvTIlAYxOvQ2uo59zhnAsKB2J/FvNGDsr+MM678QTfLTc0An/w7tcT+GYa+/zH6vCyWLvjGDfg2kk=
X-Received: by 2002:a17:907:7d8c:: with SMTP id oz12mr862732ejc.320.1643200495700;
 Wed, 26 Jan 2022 04:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
 <20220126060514.1574935-4-pasha.tatashin@soleen.com> <edd2d5d0-998a-633c-fc60-4f31ae768d3e@google.com>
In-Reply-To: <edd2d5d0-998a-633c-fc60-4f31ae768d3e@google.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 26 Jan 2022 07:34:19 -0500
Message-ID: <CA+CK2bB_DwxGCD0TOJ7B1gN4sgXg5Bptw2LQbuD7Q4gQFm3vCg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm/khugepaged: unify collapse pmd clear, flush and free
To:     David Rientjes <rientjes@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Turner <pjt@google.com>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Fusion Future <qydwhotmail@gmail.com>,
        Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:34 AM David Rientjes <rientjes@google.com> wrote:
>
> On Wed, 26 Jan 2022, Pasha Tatashin wrote:
>
> > Unify the code that flushes, clears pmd entry, and frees the PTE table
> > level into a new function collapse_and_free_pmd().
> >
> > This clean-up is useful as in the next patch we will add another call to
> > this function to iterate through PTE prior to freeing the level for page
> > table check.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Acked-by: David Rientjes <rientjes@google.com>

Thank you, David.

>
> One nit below.
>
> > ---
> >  mm/khugepaged.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 35f14d0a00a6..440112355ffe 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1416,6 +1416,17 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> >       return 0;
> >  }
> >
> > +static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
> > +                               unsigned long addr, pmd_t *pmdp)
> > +{
> > +     spinlock_t *ptl = pmd_lock(vma->vm_mm, pmdp);
> > +     pmd_t pmd = pmdp_collapse_flush(vma, addr, pmdp);
> > +
> > +     spin_unlock(ptl);
>
> No strong objection, but I think the typical style would be to declare the
> local variables separately and avoid mixing the code, especially in cases
> when taking locks (and not just initializing the local variables).

I will address this in the next revision.

Thank you,
Pasha
