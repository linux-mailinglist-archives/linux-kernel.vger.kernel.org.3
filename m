Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B652556166E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiF3JfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiF3JfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:35:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FFE42EDC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:35:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2351332pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rL6DMGGhflB32+5gUnVeD0pR8+KsqaqZLuRBQF3G2Qk=;
        b=VhbiN6QyzOQOkJswgUidFDK6rgIO8t1TbbGxo8RhSWrIlgiw94sKfZ7VHhRWHe7kA/
         up/kzUI+aGzDT+fMJN4pYKiasBt3t/DhEym5ofBiVTpWGbpsWck6fgQMQKesrjPRHsta
         yL9TTe4GX6xuY0mQQTWABxl+gm8iTK42AlA8dQItHMauru98jQ4ipRnLQf0Toi8RE15J
         o7YuidgsIiK0UnZ0A09zsRuThzXo8qNqJVy1ndNDfpbDh43CuMDHERpStCTKI8L1DQ8g
         L+mdWBHA/D607l17RSiuztqOynugC0YErU74JeuP+KcBaG7BsyyBlwD1ug67r7/ETZDU
         t29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rL6DMGGhflB32+5gUnVeD0pR8+KsqaqZLuRBQF3G2Qk=;
        b=Y91tC20hM09sH4STuPQODbbZzZCMDQC0CPlaQbWPhcPtNSsuCJcA8s3y7NKzunJOGp
         UtwFjPgYZej+L40+BsUleDUTvHn6WwRzIUyDP0WTHfEZVHbGzEnVDrOTPmnp+lMvS5YA
         pm0nzdD4gRbrmiynRau9X1qaxIlYkBFnyhnCgIGOd10NML29wEhtjU9e+6Ob+ybf5kqS
         aR9lsj9Jamz+8vMro8awiu7US6qgQ8bZeTzUkCEJ5khtRQNcReCCTGajQ46NKw7TJz3L
         oXfdQcdkwmLcmfDNatuvpURGnaYfsJPHxvNR8+vrStUjHdaYcLFXaIY/ndhVy48VT1CB
         MZ/A==
X-Gm-Message-State: AJIora+EWgUa7K3Fcyn0kwrp04NYzbb2BgrgHUpLU4To37Y0MzIVJ17Y
        AcO3Gy7UhXu0iG/lw4Hagrz29A==
X-Google-Smtp-Source: AGRyM1upCGl6d90CWWZX08Fxj8CQnHyQl0xE9J+whD56/1jigDVzXVNjFr3eYykIwCabp+TWn5PvxA==
X-Received: by 2002:a17:90b:4b48:b0:1ec:fc87:691c with SMTP id mi8-20020a17090b4b4800b001ecfc87691cmr11029817pjb.120.1656581718926;
        Thu, 30 Jun 2022 02:35:18 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090a550e00b001e31f4cc977sm3860054pji.56.2022.06.30.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:35:18 -0700 (PDT)
Date:   Thu, 30 Jun 2022 17:35:14 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an
 explicit shift argument.
Message-ID: <Yr1uUmfA/iWO740v@FVFYT0MHHV2J.usts.net>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com>
 <YroYaWVvNZJvtqsH@monkey>
 <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net>
 <Yry+PPHSat2uN+aG@monkey>
 <CADrL8HX9OkuWzpODBzHx-6-7_SLJ1YCCe5HxXdPa4ibqeQZu3A@mail.gmail.com>
 <YrzRLVQaYtYAYsEa@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrzRLVQaYtYAYsEa@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 03:24:45PM -0700, Mike Kravetz wrote:
> On 06/29/22 14:39, James Houghton wrote:
> > On Wed, Jun 29, 2022 at 2:04 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >
> > > On 06/29/22 14:09, Muchun Song wrote:
> > > > On Mon, Jun 27, 2022 at 01:51:53PM -0700, Mike Kravetz wrote:
> > > > > On 06/24/22 17:36, James Houghton wrote:
> > > > > > This is needed to handle PTL locking with high-granularity mapping. We
> > > > > > won't always be using the PMD-level PTL even if we're using the 2M
> > > > > > hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> > > > > > case, we need to lock the PTL for the 4K PTE.
> > > > >
> > > > > I'm not really sure why this would be required.
> > > > > Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
> > > > > with less contention than using the more coarse mm lock.
> > > > >
> > > >
> > > > Your words make me thing of another question unrelated to this patch.
> > > > We __know__ that arm64 supports continues PTE HugeTLB. huge_pte_lockptr()
> > > > did not consider this case, in this case, those HugeTLB pages are contended
> > > > with mm lock. Seems we should optimize this case. Something like:
> > > >
> > > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > > index 0d790fa3f297..68a1e071bfc0 100644
> > > > --- a/include/linux/hugetlb.h
> > > > +++ b/include/linux/hugetlb.h
> > > > @@ -893,7 +893,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
> > > >  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> > > >                                            struct mm_struct *mm, pte_t *pte)
> > > >  {
> > > > -       if (huge_page_size(h) == PMD_SIZE)
> > > > +       if (huge_page_size(h) <= PMD_SIZE)
> > > >                 return pmd_lockptr(mm, (pmd_t *) pte);
> > > >         VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
> > > >         return &mm->page_table_lock;
> > > >
> > > > I did not check if elsewhere needs to be changed as well. Just a primary
> > > > thought.
> > 
> > I'm not sure if this works. If hugetlb_pte_size(hpte) is PAGE_SIZE,
> > then `hpte.ptep` will be a pte_t, not a pmd_t -- I assume that breaks
> > things. So I think, when doing a HugeTLB PT walk down to PAGE_SIZE, we
> > need to separately keep track of the location of the PMD so that we
> > can use it to get the PMD lock.
> 
> I assume Muchun was talking about changing this in current code (before
> your changes) where huge_page_size(h) can not be PAGE_SIZE.
>

Yes, that's what I meant.

Thanks. 
