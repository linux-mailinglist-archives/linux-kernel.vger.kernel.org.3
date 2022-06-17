Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8978554F216
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380659AbiFQHlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380606AbiFQHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:41:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B491674D6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:41:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f8so3218418plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g0u/GOzU5BM3qUn8umbjZw50kUmeU2XoJmxQaCg7nLU=;
        b=KwEEf3udRnhhhDaQvmPI4JQPBSKliMmEhHeWpFqF+awD1U+SpUdFKnoXhXIU0vCJnt
         cSO1fGjsbT8bL2/SuRIzpO0q7GSAChivkye70mWhRdybV6ZxEaahzURxiIzpNUxhsRcB
         PHShwCufryY6y448ayQRRiU7kMdIGkpJC4yYYw5sPBEVzDohg8mX4LJFYWeWPJj6epW1
         jTaTXxYyyb8M02WEthSWFheYMj1sx0emm+UqaMqabvxY3jOsL7uai9EhSszMQnTUdgnf
         Fe/1uN1gMFmwKVfrT5NPByXUwWu6+oXoaWHPSa0p47as0EgQbX9saNdqTi/RWoUxuoxV
         IimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g0u/GOzU5BM3qUn8umbjZw50kUmeU2XoJmxQaCg7nLU=;
        b=Nm6afadpTqEpbGd6eeNkFGeeGYhRHkqsQrP5FoyO0Wc1D7FlDZh1YlEmf/BATbkuA8
         XpNxc0ZJUxgkT9MuGBbJKcAEjGvHCAcAdx2Gt/8+iJb2lio6qL5RirZluXA/uBoiCQOp
         XtS1LwgotshP9kjwn4n+m8Mx6orsCN9YR2aupG0uMRWesMd8NUY7CPEv9VVbEHuUqp06
         nfJHt+onCCVUYtfMwWVkutcR9yYGHKj8MXpNGsHjUxvK0Exdcu1+vzL8ymV7L9LZip+p
         0cShxLBRk2DEPAAPr9Zjz1SApgUGcfNEqSTNZUSd16ZGZ0VdOLZju35iUMvK3krAUQRl
         N7Bg==
X-Gm-Message-State: AJIora+l6g5VlVajE/+SWfx/N1c/9P5e1G/15uj6RjL1o/RzOb8i4sJZ
        bqUpAYLrZ+dptgOeuAuEt0JMH0doJgFvdn4fbhw=
X-Google-Smtp-Source: AGRyM1tdhHdnc0+kLaMgT+DSUtvNUQ6MYukrPIjnrcDDwpD5alDBnl2zxdr7erzLSb7RAc4DC3BhqQ==
X-Received: by 2002:a17:903:2308:b0:16a:666:8ec2 with SMTP id d8-20020a170903230800b0016a06668ec2mr1292738plh.20.1655451710002;
        Fri, 17 Jun 2022 00:41:50 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id j2-20020a62c502000000b0050dc762819bsm2960111pfg.117.2022.06.17.00.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:41:49 -0700 (PDT)
Date:   Fri, 17 Jun 2022 15:41:45 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: remove minimum_order variable
Message-ID: <YqwwOYIQ6KLuQavJ@FVFYT0MHHV2J.usts.net>
References: <20220616033846.96937-1-songmuchun@bytedance.com>
 <YqtwdhEx+57uDtpQ@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqtwdhEx+57uDtpQ@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:03:34AM -0700, Mike Kravetz wrote:
> On 06/16/22 11:38, Muchun Song wrote:
> > The following commit:
> > 
> >   commit 641844f5616d ("mm/hugetlb: introduce minimum hugepage order")
> > 
> > fixed a static checker warning and introduced a global variable minimum_order
> > to fix the warning.  However, the local variable in dissolve_free_huge_pages()
> > can be initialized to huge_page_order(&default_hstate) to fix the warning.
> > So remove minimum_order to simplify the code.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8ea4e51d8186..405d1c7441c9 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -66,12 +66,6 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
> >  #endif
> >  static unsigned long hugetlb_cma_size __initdata;
> >  
> > -/*
> > - * Minimum page order among possible hugepage sizes, set to a proper value
> > - * at boot time.
> > - */
> > -static unsigned int minimum_order __read_mostly = UINT_MAX;
> > -
> >  __initdata LIST_HEAD(huge_boot_pages);
> >  
> >  /* for command line parsing */
> > @@ -2161,11 +2155,17 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
> >  	unsigned long pfn;
> >  	struct page *page;
> >  	int rc = 0;
> > +	unsigned int order;
> > +	struct hstate *h;
> >  
> >  	if (!hugepages_supported())
> >  		return rc;
> >  
> > -	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
> > +	order = huge_page_order(&default_hstate);
> > +	for_each_hstate(h)
> > +		order = min(order, huge_page_order(h));
> 
> Since we will be traversing the array of hstates, I wonder if we should
> optimize this further?  We could:
> - Pass the node into dissolve_free_huge_pages
> - When traversing the hstate array, check free_huge_pages_node[node] in
>   each hstate.
> - If no free huge pages, no need to do the pfn scan.
> 
> Yes, the above is racy.  However, the code is already racy as hugetlb
> page state can change while performing this scan.  We only hold the hugetlb
> lock when checking an individual hugetlb page.  The change above may
> make the code a bit more racy.
>

Agree.
 
> If we think that is too racy, they we could at least check
> nr_huge_pages_node[node].  If there are no hugetlb pages on the node
> there is no need to scan.  And, I think we have isolated this pfn range
> so no new hugetlb pages can be created.
> 
> Not sure if the above optimizations are worth the effort.  IIUC, the
> pfn range is at most a memory block size which is not huge.
>

Right. It is not huge.

I have no strong opinion. dissolve_free_huge_pages() is only called in
memory offline path and it is not a hot path. If we think the optimization
is necessary, I think it should be a separate patch.

Thanks.
 
