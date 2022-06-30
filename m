Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E8562038
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiF3QYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiF3QYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:24:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E731368
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:24:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 23so18954258pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQ0ABdxfR6D43G67MI06zZIhVmsQkiYQlJlGftbg3co=;
        b=U34n6EPZFSdi0BxyjYW9mpzFC4uLov7wQVqlBzu4KgmT9eQTL1rff0zfX9lTeGFG6x
         oAlz37vRUkmn91Zv1WGucnJQH0McZEV4cs1nm2Ji5UcXzWtixkiPwquhMbXwOjbY4KID
         g/U02e1hG1qzapf6uMxCMR+iLfmBhnlc96EiMONXF7wsJybq5FfZ6DFeC+8uPyLd2B/W
         nfedQ4nuV5Ft5fas0ry+rGPn5vbcjWNwjatkIoubdkClM6Mm71HXuzlO4IYki9z5lqP2
         CkjIkqZvO/lcSUJqm/uY6NspI/2FaW9jwowoIjxaBXl+q7NZTJnwq8G9Jhy4m1FjzK4K
         1Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQ0ABdxfR6D43G67MI06zZIhVmsQkiYQlJlGftbg3co=;
        b=q6ziQ6sJmP1ghF8POXyvM5ryO65W1rEHCHeBJJ+ElxsQYQgRyNDnMRsQZGTjLZYSjs
         jVeBKdseWxt/WrEqqwmX9PqM8JcquP1860V6GrIwe4n1pxPX2hUMlcjNpYpF3PACdYfX
         F0Bl3AxmS/xCrycsuLZZu5fVi1inl9Ml6biy47C+Uvyz9uPoOzfg5RW9UuAl6DcP3ncC
         Zh4Uf3PSKpaYGG6uagSRWQ5i4u9SlYF2cXihfMzD5q190aXXim3f4lmNxZocSy32oyjU
         yZAtELy3Oxepfke30BI9ubJfpt6vT96/SMpVe0SqwQZYYvn5D8VA+KASIDPl3r+121Um
         oUyw==
X-Gm-Message-State: AJIora9VD/fOc6nhbY6ayaavLNOBlBZ9+U994qPeGHypCgom9RmCiEjW
        LU6ai8ttE7Ura07NEUcNIWzYT55w15enWkoudxRe9w==
X-Google-Smtp-Source: AGRyM1vyljlV3h/CFSJYkNpPc3JzXZ4DEIbWhvcjFs6Qm0gF5Tz+g16pAYIAcWs2EeS1saAxpg3NA+2q2/KUAbSN9II=
X-Received: by 2002:a63:5449:0:b0:40d:c8d4:ed6a with SMTP id
 e9-20020a635449000000b0040dc8d4ed6amr8372360pgm.9.1656606240746; Thu, 30 Jun
 2022 09:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com> <YroYaWVvNZJvtqsH@monkey>
 <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net> <Yry+PPHSat2uN+aG@monkey>
 <CADrL8HX9OkuWzpODBzHx-6-7_SLJ1YCCe5HxXdPa4ibqeQZu3A@mail.gmail.com>
 <YrzRLVQaYtYAYsEa@monkey> <Yr1uUmfA/iWO740v@FVFYT0MHHV2J.usts.net>
In-Reply-To: <Yr1uUmfA/iWO740v@FVFYT0MHHV2J.usts.net>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 30 Jun 2022 09:23:49 -0700
Message-ID: <CADrL8HWuF-yXvgdJW7wWQSMU0GsRg3gttHykhV7=1VYSxfzkag@mail.gmail.com>
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an explicit
 shift argument.
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
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

On Thu, Jun 30, 2022 at 2:35 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, Jun 29, 2022 at 03:24:45PM -0700, Mike Kravetz wrote:
> > On 06/29/22 14:39, James Houghton wrote:
> > > On Wed, Jun 29, 2022 at 2:04 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > >
> > > > On 06/29/22 14:09, Muchun Song wrote:
> > > > > On Mon, Jun 27, 2022 at 01:51:53PM -0700, Mike Kravetz wrote:
> > > > > > On 06/24/22 17:36, James Houghton wrote:
> > > > > > > This is needed to handle PTL locking with high-granularity mapping. We
> > > > > > > won't always be using the PMD-level PTL even if we're using the 2M
> > > > > > > hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> > > > > > > case, we need to lock the PTL for the 4K PTE.
> > > > > >
> > > > > > I'm not really sure why this would be required.
> > > > > > Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
> > > > > > with less contention than using the more coarse mm lock.
> > > > > >
> > > > >
> > > > > Your words make me thing of another question unrelated to this patch.
> > > > > We __know__ that arm64 supports continues PTE HugeTLB. huge_pte_lockptr()
> > > > > did not consider this case, in this case, those HugeTLB pages are contended
> > > > > with mm lock. Seems we should optimize this case. Something like:
> > > > >
> > > > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > > > index 0d790fa3f297..68a1e071bfc0 100644
> > > > > --- a/include/linux/hugetlb.h
> > > > > +++ b/include/linux/hugetlb.h
> > > > > @@ -893,7 +893,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
> > > > >  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> > > > >                                            struct mm_struct *mm, pte_t *pte)
> > > > >  {
> > > > > -       if (huge_page_size(h) == PMD_SIZE)
> > > > > +       if (huge_page_size(h) <= PMD_SIZE)
> > > > >                 return pmd_lockptr(mm, (pmd_t *) pte);
> > > > >         VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
> > > > >         return &mm->page_table_lock;
> > > > >
> > > > > I did not check if elsewhere needs to be changed as well. Just a primary
> > > > > thought.
> > >
> > > I'm not sure if this works. If hugetlb_pte_size(hpte) is PAGE_SIZE,
> > > then `hpte.ptep` will be a pte_t, not a pmd_t -- I assume that breaks
> > > things. So I think, when doing a HugeTLB PT walk down to PAGE_SIZE, we
> > > need to separately keep track of the location of the PMD so that we
> > > can use it to get the PMD lock.
> >
> > I assume Muchun was talking about changing this in current code (before
> > your changes) where huge_page_size(h) can not be PAGE_SIZE.
> >
>
> Yes, that's what I meant.

Right -- but I think my point still stands. If `huge_page_size(h)` is
CONT_PTE_SIZE, then the `pte_t *` passed to `huge_pte_lockptr` will
*actually* point to a `pte_t` and not a `pmd_t` (I'm pretty sure the
distinction is important). So it seems like we need to separately keep
track of the real pmd_t that is being used in the CONT_PTE_SIZE case
(and therefore, when considering HGM, the PAGE_SIZE case).

However, we *can* make this optimization for CONT_PMD_SIZE (maybe this
is what you originally meant, Muchun?), so instead of
`huge_page_size(h) == PMD_SIZE`, we could do `huge_page_size(h) >=
PMD_SIZE && huge_page_size(h) < PUD_SIZE`.

>
> Thanks.
