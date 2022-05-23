Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA5531702
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbiEWSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiEWSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:34:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165BA12816C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:12:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d38so338576pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmemOOUEaDn+3pBgS68jUUDL7N3enFtsy+GPMY+Vi6U=;
        b=n2tQcL8/YL1f/GBjKWuCzRSTzfyyvoQBKFNBDB+xRgnFzWa4d7UTVk37vTevUvPZaH
         e5XQ+pAHnWvmnrApZzOvvjVtlikFGEhVHjPTCBblSSSRmhp3kA41OMO8ATckAMf7XMGm
         cdck697O08Ae7rISm8i6/vBOT1Glq6HSPjcexp4qUwbcqSJ6JQ55E9ttT74IRp6OFtFE
         40+R6gm9X9eT3+xsv791DFr1ZBu+AVqv3QyO+BuGH3J1Qr8BMV88GnnWZR3aiUHxvsS8
         VVPGWN3FZpzlOPxgKvgGP4B0XN8tNVyg9VCudGxUdS1HMyc4z9bJbOQMS154YkQqsCQP
         gw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmemOOUEaDn+3pBgS68jUUDL7N3enFtsy+GPMY+Vi6U=;
        b=vgNsE23cGBswWuFZllVfP2SfbVEjPr5oI4a5QRkCwv6nYF5+Rr7qlZlXnHBB7EfAA2
         nPgIYlnSDbOyC2fvLEzWtSeXHWDOV6hoA46aWD0idmtbY0yehBP4NKeHT6z5zAvwo0bN
         oCEeM+6Utbz0wmT5PjIZQlJYgVbDtz5DSp4ikZmUFvYG0z/qH+wZYp/dnJtYFdAG/dqo
         EnPClbIMTUq9gOleJVqS+nL1n/TbnHVqqN5zIz062tJaAWd/ffrwRrXv3uKBnIVIwJFz
         qneoLvzrr3AEe3R82kfkSn8XmsrD/tDBYQbrWtRUsRauMx5y5iIWPtYCC3RAnAsa684t
         kTiw==
X-Gm-Message-State: AOAM530PD0bmbkjELHfl3QAimJMKEhf22rTD977nSHLzWRIfuzPXt79K
        RqwzJTUVeBZSezCkNAbwfeZkOv4LSL0kHhrqAP8=
X-Google-Smtp-Source: ABdhPJzBk+TiEQTYc5wMTDULGuOuR+VzwNW6gAFLt04HMW9UrLp26iJOSpNAUq+kU6cs7Ut54Kc3A8DGPEwpw0gryHg=
X-Received: by 2002:a63:fc04:0:b0:3f6:4b2b:9d36 with SMTP id
 j4-20020a63fc04000000b003f64b2b9d36mr18715962pgi.206.1653329551659; Mon, 23
 May 2022 11:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220520211605.51473-1-shy828301@gmail.com> <20220520211605.51473-3-shy828301@gmail.com>
 <20220521013954.2695-1-hdanton@sina.com>
In-Reply-To: <20220521013954.2695-1-hdanton@sina.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 23 May 2022 11:12:18 -0700
Message-ID: <CAHbLzkp7kr9QS3oByEmcD2msB1tQ0fA+fp8QPp-sjdQUtvW-OQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
To:     Hillf Danton <hdanton@sina.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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

On Fri, May 20, 2022 at 6:40 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Fri, 20 May 2022 14:16:00 -0700 Yang Shi wrote:
> > There are couple of places that check whether the vma size is ok for
> > THP or not, they are open coded and duplicate, introduce
> > transhuge_vma_size_ok() helper to do the job.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/huge_mm.h | 17 +++++++++++++++++
> >  mm/huge_memory.c        |  5 +----
> >  mm/khugepaged.c         | 12 ++++++------
> >  3 files changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 648cb3ce7099..a8f61db47f2a 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -116,6 +116,18 @@ extern struct kobj_attribute shmem_enabled_attr;
> >
> >  extern unsigned long transparent_hugepage_flags;
> >
> > +/*
> > + * The vma size has to be large enough to hold an aligned HPAGE_PMD_SIZE area.
> > + */
> > +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > +{
> > +     if (round_up(vma->vm_start, HPAGE_PMD_SIZE) <
> > +         (vma->vm_end & HPAGE_PMD_MASK))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >               unsigned long addr)
> >  {
> > @@ -345,6 +357,11 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> >       return false;
> >  }
> >
> > +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > +{
> > +     return false;
> > +}
> > +
> >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >               unsigned long addr)
> >  {
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 80e8b58b4f39..d633f97452c1 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -71,10 +71,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
> >
> >  bool transparent_hugepage_active(struct vm_area_struct *vma)
> >  {
> > -     /* The addr is used to check if the vma size fits */
> > -     unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> > -
> > -     if (!transhuge_vma_suitable(vma, addr))
> > +     if (!transhuge_vma_size_ok(vma))
> >               return false;
>
> Given the comment added in 4/7, this patch adds change in semantic.
> If that is intened, add some words in log message for it.

It should not change the semantic even with 4/7. The old comment says
"The addr is used to check if the vma size fits", so the purpose of
transhuge_vma_suitable() here is used to check if the vma size is ok
or not.

>
> >       if (vma_is_anonymous(vma))
> >               return __transparent_hugepage_enabled(vma);
>
