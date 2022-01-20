Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2111495428
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbiATS00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346409AbiATS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:26:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EA2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:26:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m11so32299937edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNbdF/QpRq+ud6uqivBxeFheJzBweVEt87O2OSCqklM=;
        b=djYBV+Fns9UgKTk6TTACAWvrerNhzkQujwtFiTOlSK8aFgdw9KIP2SJdEIxhgYzhxj
         Z/i/nssIKRLowCnCad/bwyAii7uuvrcpkrLCIuZ1WeA7IwewD8/gV3wdK16Ki3fu63MG
         UpSVL4IEt/+iN0Ndf8jt4d2ApX936VBMq42/0WTC8Mi7bRNOFHnhop/beRmVECtt6hrN
         In1ROAWSfcDRXdXkwZkjBydQYCsygBmQY+ZPcpGKn7JJFoNs68fobNvwk5LC4EzrmnNp
         o1HjcxHEw9rJEqTokBItU+n42EI9iOwLm2DeZ4CoTnogtw5NcB7uLUSflQaekxybSNd9
         VsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNbdF/QpRq+ud6uqivBxeFheJzBweVEt87O2OSCqklM=;
        b=NoV502/R4ZAOaQReJiO6jjJ6xb72IHelVQMqlqkTJhg1inOtVgxiJZD6kFxRmhxfdM
         l2ugin+fbtsW/LF9U1H7ySHw7pxeY3cvU1ENc/qJ7oiImQV5uSuU1fzYMAyxN98aiHm6
         imdcMe+yg9b71Ii+uXqCZWdGp56B3gOkMxaV5OLcDXrFoyPd7NGjXMt50WDOrsSyU5x5
         JfD+kKAu36pCV1atXH41xdyli+veI0rRmbyrOaTGQrV0d1YPvhYgdXhUNrF9+JrgbqKx
         pKFnXU7UKjk0RM7f6ga3S4mqbvN4o6bhrJ/1NG599CD6XeB1/108Bl65rNZQLU5jQTdz
         TDyQ==
X-Gm-Message-State: AOAM531ETZXeVMDIfIkJLk0n/wIAWPigMXmlzbF8KtcytfY2nZrOOnV6
        WLg5kHraVkwTKgb1rmt2JkiIjLW9eBmrWiZ7Wdfasw==
X-Google-Smtp-Source: ABdhPJwZ1g5y5mmCGfSt1kmKCYsNuFITmsXjQrGs0XFE0mSOtrGpuw5zLq4qeQp4yp1nm3JTRAbkQncvDfH2eK2xfpA=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr316216edd.355.1642703182284;
 Thu, 20 Jan 2022 10:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
 <20220120042513.1648831-3-pasha.tatashin@soleen.com> <CAAPL-u_kP5E5iOtyztsXLJG0YNFzganD3djr2nW0vTkUpv=A9Q@mail.gmail.com>
In-Reply-To: <CAAPL-u_kP5E5iOtyztsXLJG0YNFzganD3djr2nW0vTkUpv=A9Q@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 20 Jan 2022 13:25:45 -0500
Message-ID: <CA+CK2bC5WJxdb9tdZj8eiB1PeOfV-D4v1Tpi+TEZhMskbZ6k4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/page_table_check: check entries at pud and pmd levels
To:     Wei Xu <weixugc@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Greg Thelen <gthelen@google.com>,
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

Hi Wei,

Thank you for looking at this patch.

> > +static void pmd_clear_level(struct mm_struct *mm, unsigned long addr,
> > +                           pmd_t *pmdp)
> > +{
> > +       unsigned long i;
> > +
> > +       for (i = 0; i < PTRS_PER_PMD; i++) {
> > +               pmd_t old_pmd = *pmdp;
> > +
> > +               if (pmd_user_accessible_page(old_pmd)) {
> > +                       page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
> > +                                              PMD_PAGE_SIZE >> PAGE_SHIFT);
> > +               } else if (!pmd_bad(old_pmd) && !pmd_leaf(old_pmd)) {
> > +                       pte_t *ptep = pte_offset_map(&old_pmd, addr);
> > +
> > +                       pte_clear_level(mm, addr, ptep);
> > +                       pte_unmap(ptep);
> > +               }
>
> You can call __page_table_check_pmd_clear(mm, addr, old_pmd, addr)
> instead to share the new code.

Yeap.

>
> >
> > +               addr += PMD_PAGE_SIZE;
> > +               pmdp++;
> > +       }
> > +}
> > +
> >  /*
> >   * page is on free list, or is being allocated, verify that counters are zeroes
> >   * crash if they are not.
> > @@ -186,6 +220,11 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
> >         if (pmd_user_accessible_page(pmd)) {
> >                 page_table_check_clear(mm, addr, pmd_pfn(pmd),
> >                                        PMD_PAGE_SIZE >> PAGE_SHIFT);
> > +       } else if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
> > +               pte_t *ptep = pte_offset_map(&pmd, addr);
> > +
> > +               pte_clear_level(mm, addr, ptep);
> > +               pte_unmap(ptep);
> >         }
> >  }
> >  EXPORT_SYMBOL(__page_table_check_pmd_clear);
> > @@ -199,6 +238,10 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
> >         if (pud_user_accessible_page(pud)) {
> >                 page_table_check_clear(mm, addr, pud_pfn(pud),
> >                                        PUD_PAGE_SIZE >> PAGE_SHIFT);
> > +       } else if (!pud_bad(pud) && !pud_leaf(pud)) {
> > +               pmd_t *pmdp = pmd_offset(&pud, addr);
> > +
> > +               pmd_clear_level(mm, addr, pmdp);
> >         }
> >  }
> >  EXPORT_SYMBOL(__page_table_check_pud_clear);
> > @@ -237,6 +280,11 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
> >         if (pmd_user_accessible_page(old_pmd)) {
> >                 page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
> >                                        PMD_PAGE_SIZE >> PAGE_SHIFT);
> > +       } else if (!pmd_bad(old_pmd) && !pmd_leaf(old_pmd)) {
> > +               pte_t *ptep = pte_offset_map(&old_pmd, addr);
> > +
> > +               pte_clear_level(mm, addr, ptep);
> > +               pte_unmap(ptep);
> >         }
> >
>
> How about replacing the above code with
> __page_table_check_pmd_clear(mm, addr, old_pmd)?

OK

>
> >         if (pmd_user_accessible_page(pmd)) {
> > @@ -259,6 +307,10 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
> >         if (pud_user_accessible_page(old_pud)) {
> >                 page_table_check_clear(mm, addr, pud_pfn(old_pud),
> >                                        PUD_PAGE_SIZE >> PAGE_SHIFT);
> > +       } else if (!pud_bad(old_pud) && !pud_leaf(old_pud)) {
> > +               pmd_t *pmdp = pmd_offset(&old_pud, addr);
> > +
> > +               pmd_clear_level(mm, addr, pmdp);
> >         }
>
> Replacing with __page_table_check_pud_clear(mm, addr, old_pud)?

OK

Good suggestions, I will simplify the code with your suggestions.

Pasha
