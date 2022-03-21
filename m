Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780194E2F12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbiCURbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiCURbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6BA3A27F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647883808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NlV9jHxSF3Ib5TOatOCVcnKctI6qsGmDrK+z6mtlA4I=;
        b=Q5Esf0B7i/ksGZ5HXYY/MvlhTb6dqv9y6FL1ohADmC97wJ9IymmkDQIt55sm9mB2+k+PsV
        MYLV+vc8Uy1rGKD70gUt81Rf3zEjXX5L1zIZ/i/V2gS4akTnhhP+CwdcDatkINzZxkaKuD
        4ISbLMr7ONnsKb12Y+BGe6HnLDtr16o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-PwaYanD8McW_Ie2GNRy3_A-1; Mon, 21 Mar 2022 13:30:06 -0400
X-MC-Unique: PwaYanD8McW_Ie2GNRy3_A-1
Received: by mail-wr1-f69.google.com with SMTP id f18-20020adf9f52000000b00203d86759beso3306930wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=NlV9jHxSF3Ib5TOatOCVcnKctI6qsGmDrK+z6mtlA4I=;
        b=7fJHFfTRweqlvDdlKWMIeYI4jUX2Gqgp8tJB/vU+NScTmej/pOFtFrThAJOdJNP4tC
         di2rfVIkfwMxhXIwQRd1n03R/qEND3+XYQTqkKN2OCky+rXMuUr/m708ZmeTLb1HI6ic
         STYrqBmHGaU2RVjehZ3Ugeqtl1rmACI51Ui5PZBL+lmrEI+KD2KzLXNkNS9cI2k/Jbpp
         i/TT81dylIFMpx0GDMg28U+1ZHzi2fUWiLNVq71FtmaZJJwu9RWKWl0uWRkIvOaPypnf
         Ar3w1oDQz9vFEHuN5lKNq19erOCGm67cEJph3Esy27otmRYvldUD32XqOKO+LAkXoZIG
         cYxg==
X-Gm-Message-State: AOAM530oThDLCAH+OU0/+q+IGJSCUJ1T2JPeSBpYfA0E/tAc9ldqqPWd
        f8gyDZzcx2NOViftfCq8gwprIJnWJUQXr5pQGWkvT6QuIwPoRvC08wpS58v4NbpsJ1PWQvqAJqy
        pLE+qFrI+dODmY94daljDIJBe
X-Received: by 2002:adf:fa48:0:b0:1f0:d71:f9a with SMTP id y8-20020adffa48000000b001f00d710f9amr18490525wrr.50.1647883805451;
        Mon, 21 Mar 2022 10:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYz2NV6cPW/UKXwtVAymCN+7Gymo2gqLNLS9v0lWJ/iSz7O2RDgrimNHZ2Vt90Dk0VjLP16Q==
X-Received: by 2002:adf:fa48:0:b0:1f0:d71:f9a with SMTP id y8-20020adffa48000000b001f00d710f9amr18490499wrr.50.1647883805091;
        Mon, 21 Mar 2022 10:30:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm20068021wri.0.2022.03.21.10.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 10:30:04 -0700 (PDT)
Message-ID: <44a512ba-1707-d9c7-7df3-b81af9b5f0fb@redhat.com>
Date:   Mon, 21 Mar 2022 18:30:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220317153733.2171277-1-zi.yan@sent.com>
 <20220317153733.2171277-3-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 2/5] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <20220317153733.2171277-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.22 16:37, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
> pages within that granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page-isolation.h | 10 +++++
>  mm/page_alloc.c                | 13 +------
>  mm/page_isolation.c            | 69 ++++++++++++++++++++--------------
>  3 files changed, 51 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index e14eddf6741a..eb4a208fe907 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratetype)
>  {
>  	return migratetype == MIGRATE_ISOLATE;
>  }
> +static inline unsigned long pfn_max_align_down(unsigned long pfn)
> +{
> +	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> +}
> +
> +static inline unsigned long pfn_max_align_up(unsigned long pfn)
> +{
> +	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> +}
> +
>  #else
>  static inline bool has_isolate_pageblock(struct zone *zone)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6de57d058d3d..680580a40a35 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8937,16 +8937,6 @@ void *__init alloc_large_system_hash(const char *tablename,
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> -static unsigned long pfn_max_align_down(unsigned long pfn)
> -{
> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
> -static unsigned long pfn_max_align_up(unsigned long pfn)
> -{
> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
> @@ -9091,8 +9081,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	 * put back to page allocator so that buddy can use them.
>  	 */
>  
> -	ret = start_isolate_page_range(pfn_max_align_down(start),
> -				       pfn_max_align_up(end), migratetype, 0);
> +	ret = start_isolate_page_range(start, end, migratetype, 0);
>  	if (ret)
>  		return ret;

Shouldn't we similarly adjust undo_isolate_page_range()? IOW, all users
of pfn_max_align_down()/pfn_max_align_up(). would be gone from that file
and you can move these defines into mm/page_isolation.c instead of
include/linux/page-isolation.h?

Maybe perform this change in a separate patch for
start_isolate_page_range() and undo_isolate_page_range() ?

>  
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b34f1310aeaa..419c805dbdcd 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -16,7 +16,8 @@
>  #include <trace/events/page_isolation.h>
>  
>  /*
> - * This function checks whether pageblock includes unmovable pages or not.
> + * This function checks whether pageblock within [start_pfn, end_pfn) includes
> + * unmovable pages or not.

I think we still want to limit that to a single pageblock (see below),
as we're going to isolate individual pageblocks. Then an updated
description could be:

"This function checks whether the range [start_pfn, end_pfn) includes
unmovable pages or not. The range must fall into a single pageblock and
consequently belong to a single zone."

>   *
>   * PageLRU check without isolation or lru_lock could race so that
>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
> @@ -28,27 +29,26 @@
>   * cannot get removed (e.g., via memory unplug) concurrently.
>   *
>   */
> -static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> -				 int migratetype, int flags)
> +static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long end_pfn,
> +				int migratetype, int flags)
>  {
> -	unsigned long iter = 0;
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long offset = pfn % pageblock_nr_pages;
> +	unsigned long pfn = start_pfn;
>  
> -	if (is_migrate_cma_page(page)) {
> -		/*
> -		 * CMA allocations (alloc_contig_range) really need to mark
> -		 * isolate CMA pageblocks even when they are not movable in fact
> -		 * so consider them movable here.
> -		 */
> -		if (is_migrate_cma(migratetype))
> -			return NULL;

If we're really dealing with a range that falls into a single pageblock,
then you can leave the is_migrate_cma_page() in place and also lookup
the zone only once. That should speed up things and minimize the
required changes.

You can then further add VM_BUG_ON()s that make sure that start_pfn and
end_pfn-1 belong to a single pageblock.

> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +		struct page *page = pfn_to_page(pfn);
> +		struct zone *zone = page_zone(page);
>  
> -		return page;
> -	}
> +		if (is_migrate_cma_page(page)) {
> +			/*
> +			 * CMA allocations (alloc_contig_range) really need to mark
> +			 * isolate CMA pageblocks even when they are not movable in fact
> +			 * so consider them movable here.
> +			 */
> +			if (is_migrate_cma(migratetype))
> +				return NULL;
>  
> -	for (; iter < pageblock_nr_pages - offset; iter++) {
> -		page = pfn_to_page(pfn + iter);
> +			return page;
> +		}
>  
>  		/*
>  		 * Both, bootmem allocations and memory holes are marked
> @@ -85,7 +85,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  			}
>  
>  			skip_pages = compound_nr(head) - (page - head);
> -			iter += skip_pages - 1;
> +			pfn += skip_pages - 1;
>  			continue;
>  		}
>  
> @@ -97,7 +97,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 */
>  		if (!page_ref_count(page)) {
>  			if (PageBuddy(page))
> -				iter += (1 << buddy_order(page)) - 1;
> +				pfn += (1 << buddy_order(page)) - 1;
>  			continue;
>  		}
>  
> @@ -134,7 +134,13 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  	return NULL;
>  }
>  
> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
> +/*
> + * This function set pageblock migratetype to isolate if no unmovable page is
> + * present in [start_pfn, end_pfn). The pageblock must intersect with
> + * [start_pfn, end_pfn).
> + */
> +static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
> +			unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	struct zone *zone = page_zone(page);
>  	struct page *unmovable;
> @@ -155,8 +161,13 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	/*
>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
>  	 * We just check MOVABLE pages.
> +	 *
> +	 * Pass the intersection of [start_pfn, end_pfn) and the page's pageblock
> +	 * to avoid redundant checks.
>  	 */

I think I'd prefer some helper variables for readability.

> -	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
> +	unmovable = has_unmovable_pages(max(page_to_pfn(page), start_pfn),
> +			min(ALIGN(page_to_pfn(page) + 1, pageblock_nr_pages), end_pfn),
> +			migratetype, isol_flags);
>  	if (!unmovable) {
>  		unsigned long nr_pages;
>  		int mt = get_pageblock_migratetype(page);
> @@ -267,7 +278,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * be MIGRATE_ISOLATE.
>   * @start_pfn:		The lower PFN of the range to be isolated.
>   * @end_pfn:		The upper PFN of the range to be isolated.
> - *			start_pfn/end_pfn must be aligned to pageblock_order.
>   * @migratetype:	Migrate type to set in error recovery.
>   * @flags:		The following flags are allowed (they can be combined in
>   *			a bit mask)
> @@ -309,15 +319,16 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	unsigned long pfn;
>  	struct page *page;
>  
> -	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
> -	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
> +	unsigned long isolate_start = pfn_max_align_down(start_pfn);
> +	unsigned long isolate_end = pfn_max_align_up(end_pfn);
>  
> -	for (pfn = start_pfn;
> -	     pfn < end_pfn;
> +	for (pfn = isolate_start;
> +	     pfn < isolate_end;
>  	     pfn += pageblock_nr_pages) {
>  		page = __first_valid_page(pfn, pageblock_nr_pages);
> -		if (page && set_migratetype_isolate(page, migratetype, flags)) {
> -			undo_isolate_page_range(start_pfn, pfn, migratetype);
> +		if (page && set_migratetype_isolate(page, migratetype, flags,
> +					start_pfn, end_pfn)) {
> +			undo_isolate_page_range(isolate_start, pfn, migratetype);
>  			return -EBUSY;
>  		}
>  	}


-- 
Thanks,

David / dhildenb

