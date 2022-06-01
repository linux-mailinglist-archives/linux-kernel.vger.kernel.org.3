Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6222C53A332
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351281AbiFAKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352676AbiFAKsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:48:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5937013E3C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:48:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i1so1426202plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygjUxfkqHRj2c+XbYZgzwfLNN/gLk7A7fF4S+oHb6+U=;
        b=bgpwLbbe1FlcWjVnusaNYiEwx0t2E4qplUZnv6r7lVSq/8qBCdgRYzAhIbF2V40Fqb
         kJVgd2FD5tULhTVIaS6h0kPX+cKe+Gtkl5g9Zl/AXqaXskOFlcOuuFoFlxfnUeicwmcf
         RNSjY99gv5VcKQR5EagRSgaW15uApuc6u5SZa4Px4pn3Toa0q0SSsbeS3KNouNwY26mc
         JCXOwkFFVtFYXHd1dSvb3o96GHcIitjb3xYSwVYlYOqdf3e6oGJ7MY45Crc/e7U5XayD
         YeHODFHb6Jc6DUcZ8GlzwSrFBvZt5iGJJbalseM3gJAV45pZWE7D5vS7B7M0ff99j2ix
         hQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygjUxfkqHRj2c+XbYZgzwfLNN/gLk7A7fF4S+oHb6+U=;
        b=jm44A8HlwCTW5a5oDmgsBlEJW5kTb2UtzwuWYqMtiq76FnewFi+kZvDt7jLtAGwG2X
         +j13Tff9s4Ly2t9jUQspRUW1u9rPkw5L4mylaJ0+X9IVdq/J1IZoJMkUMLyiXvYtXIeN
         EXOlotAASQcqW4jn5cC8FoSueILoMmR39l533uhsdFIZPTJaS13/R8asF252btPLWQHV
         tVJPr29o5PT01aBOEoU1Z46e7cfHSkkxQLkweeUUvJ+dnXzwnB4q6o7U/NeltQn1UiAH
         eqrAMxBiV52VHtdWJWoSMnijtyVfpYUPwXi/BpofLDfqkxBCj5oyYMPCyUHtuh7yX9Fr
         NliA==
X-Gm-Message-State: AOAM530kp1ez7njHdP74V9lNeHkEuYZMcWN/2YZPvHw25d1dL0Cg7TKB
        iJ/YmjYzsbd437zIsbqV36HvjQ==
X-Google-Smtp-Source: ABdhPJxUJ6OjZuyCicU2quC0fvCgVui98qkaje1vjhkSIDc9Ym4TBRDr5UETuYDCiMCuuMiwhweVfQ==
X-Received: by 2002:a17:90a:de0b:b0:1e3:33e9:6665 with SMTP id m11-20020a17090ade0b00b001e333e96665mr9204009pjv.27.1654080498895;
        Wed, 01 Jun 2022 03:48:18 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:f9bc:fb5f:5b66:a80e])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903404400b001616b71e5e3sm1166040pla.171.2022.06.01.03.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:48:18 -0700 (PDT)
Date:   Wed, 1 Jun 2022 18:48:13 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>, mike.kravetz@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@bytedance.com
Subject: Re: [PATCH 1/3] mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related
 functions
Message-ID: <YpdD7WCYlfCkvv2L@FVFYT0MHHV2J.googleapis.com>
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-2-songmuchun@bytedance.com>
 <087817e3-98ce-09f6-9ae9-68e544f43775@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087817e3-98ce-09f6-9ae9-68e544f43775@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:28:44AM +0200, David Hildenbrand wrote:
> On 04.04.22 09:46, Muchun Song wrote:
> > The word of "free" is not expressive enough to express the feature of optimizing
> > vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
> > And some function names are prefixed with "huge_page" instead of "hugetlb", it is
> > easily to be confused with THP.  In this patch , cheanup related functions to make
> > code more clear and expressive.
> 
> No strong opinion (I remember I kicked of the discussion), but I was
> wondering if instead of alloc vs. free we could be using something like
> optimize vs. restore/rollback.
> 
> E.g., hugetlb_vmemmap_optimize() vs. hugetlb_vmemmap_restore().
>

I think it is a good suggestion.
 
> 
> Maybe there are other suggestions?
>
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/hugetlb.h |  2 +-
> >  mm/hugetlb.c            | 10 +++++-----
> >  mm/hugetlb_vmemmap.c    | 42 ++++++++++++++++++++----------------------
> >  mm/hugetlb_vmemmap.h    | 20 ++++++++++----------
> >  4 files changed, 36 insertions(+), 38 deletions(-)
> > 
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 53c1b6082a4c..c16fbb1228a3 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -618,7 +618,7 @@ struct hstate {
> >  	unsigned int free_huge_pages_node[MAX_NUMNODES];
> >  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > -	unsigned int nr_free_vmemmap_pages;
> > +	unsigned int optimize_vmemmap_pages;
> 
> I suggest converting that into a bool and just calling it
> 
> "bool optimize_vmemmap_pages".
> 
> You can easily compute what hugetlb_vmemmap_init() at runtime from the
> page and RESERVE_VMEMMAP_NR, right?
> 

Right. A little overhead, but hugetlb_vmemmap_alloc() is not hot path,
maybe we can accept the increased overhead of calculating at runtime.

Hi Mike,

Do you have any objections on this? If no, I think we can do this in a
separate patch.

> At least the calculation in alloc_huge_page_vmemmap() and
> free_huge_page_vmemmap() become *less* weird for me if the magic value
> RESERVE_VMEMMAP_NR isn't used explicitly for vmemmap_addr but implicitly
> for vmemmap_end.
> 
> >  #endif
> >  #ifdef CONFIG_CGROUP_HUGETLB
> >  	/* cgroup control files */
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index dd642cfc538b..1f9fbdddc86b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1540,7 +1540,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
> >  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> >  		return;
> >  
> > -	if (alloc_huge_page_vmemmap(h, page)) {
> > +	if (hugetlb_vmemmap_alloc(h, page)) {
> >  		spin_lock_irq(&hugetlb_lock);
> >  		/*
> >  		 * If we cannot allocate vmemmap pages, just refuse to free the
> > @@ -1617,7 +1617,7 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> >  
> >  static inline void flush_free_hpage_work(struct hstate *h)
> >  {
> > -	if (free_vmemmap_pages_per_hpage(h))
> > +	if (hugetlb_optimize_vmemmap_pages(h))
> 
> It might be reasonable to call that hugetlb_should_optimize_vmemmap()
> then, letting it return a bool.
>

How about the name of "hugetlb_vmemmap_optimizable()"?  "should" seems to
tell the user that this hugetlb should be optimized, however, optimization
also depends on "hugetlb_free_vmemmap=on".  "optimizable" seems to be more
appropriate, right?

Thanks.  

