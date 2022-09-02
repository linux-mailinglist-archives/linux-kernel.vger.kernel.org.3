Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9363A5AA9D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiIBIVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiIBIUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED75050068
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662106853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UyZUOg7p/TzqkDBtMIegEKQUho3iKfbgStXxRwVupNs=;
        b=bpcCAOcKk/rpe91c7aP2gQ3U4HPx0e4AebNMu02KERMSzrkOhnKo9HHNX7cnichllOQ/P1
        ul4GM9SZtV6GfIVQpTmU+pUDo9YyRJy4Hi/Doh1Vp9bMN1Mq2owOtzphi/tN3rRRm2xQXk
        mfu/jqhpjZ9mkec5uMvBx8wgXrPKu/M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-WkFXzdm4MrGv3swa6JYHRg-1; Fri, 02 Sep 2022 04:20:51 -0400
X-MC-Unique: WkFXzdm4MrGv3swa6JYHRg-1
Received: by mail-wr1-f71.google.com with SMTP id u15-20020adfa18f000000b00226d4b62f10so135490wru.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=UyZUOg7p/TzqkDBtMIegEKQUho3iKfbgStXxRwVupNs=;
        b=K0rI88FAcVp13POwZyAMoCcwD4EgXaSKFzj6tc7dNRwficK3A1x1jvzbXAqwEDIvmM
         wY+h/HeT1vOx+Zfw/CwN1wDlSR4MFyFXaKcTCvHN+IJi+LWOd01lRSmYk3IHTcXliYuJ
         rXw0RE3lwWBaqI0w54/WrJipmWtqQBAHkZaupOgp67ljbljEG7bG616ZBnbDgDA0oXC5
         a/+dFmnhRkCfHSEbwTl2slW8vPEYCNkfK7Pk6dhaJvvYHueubnWEMGJJ4uz/TpIZSdw2
         m2qJUDfpUjE3iXDPjAwa0689t0+U4n6Tlz/cH5NnbdC5IERQR4xaqPTVeH0Rc2cm9ErQ
         nh7g==
X-Gm-Message-State: ACgBeo0rTxtybcUTSsLbYMnVdQFIXr+9Ix8/vssSO0wueG94oGVTnQh8
        7AP3UJioIR5ZaxDISXKrbziKUIbJJkQJboQQZYp9bnb5jrVvBU29mMQmEuXJn8q4I5DolJGx1u5
        N6DJiUecKDQZr5Ts6AdLNQhvf
X-Received: by 2002:a7b:c451:0:b0:3a6:829a:6102 with SMTP id l17-20020a7bc451000000b003a6829a6102mr2003054wmi.12.1662106850797;
        Fri, 02 Sep 2022 01:20:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4fuYPlcEhqJLhewH7Nd+dggsTljUv6rlMT2YuLUENnMUMi0oNDyE6wkUcyj08mesdw5rqhnw==
X-Received: by 2002:a7b:c451:0:b0:3a6:829a:6102 with SMTP id l17-20020a7bc451000000b003a6829a6102mr2003031wmi.12.1662106850440;
        Fri, 02 Sep 2022 01:20:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:4800:2077:1bf6:40e7:2833? (p200300cbc714480020771bf640e72833.dip0.t-ipconnect.de. [2003:cb:c714:4800:2077:1bf6:40e7:2833])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6103000000b002252cb35184sm940758wrt.25.2022.09.02.01.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 01:20:50 -0700 (PDT)
Message-ID: <417630cc-eaa8-1d73-6427-d87b02c187b6@redhat.com>
Date:   Fri, 2 Sep 2022 10:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
References: <20220902064751.17890-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/2] mm: reuse pageblock_start/end_pfn() macro
In-Reply-To: <20220902064751.17890-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.22 08:47, Kefeng Wang wrote:
> Move pageblock_start_pfn/pageblock_end_pfn() into pageblock-flags.h,
> then they could be used somewhere else, not only in compaction.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/pageblock-flags.h |  2 ++
>  mm/compaction.c                 |  2 --
>  mm/memblock.c                   |  2 +-
>  mm/page_alloc.c                 | 13 ++++++-------
>  mm/page_isolation.c             |  2 +-
>  mm/page_owner.c                 |  4 ++--
>  6 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index 83c7248053a1..ef2e17e312ae 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -53,6 +53,8 @@ extern unsigned int pageblock_order;
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  #define pageblock_nr_pages	(1UL << pageblock_order)
> +#define pageblock_start_pfn(pfn)	round_down(pfn, pageblock_nr_pages)
> +#define pageblock_end_pfn(pfn)		ALIGN((pfn + 1), pageblock_nr_pages)
>  

I'd naturally have paired ALIGN with ALIGN_DOWN -- or round_up with round_down.
(You're replacing one instance where ALIGN_DOWN was used at least.)

But maybe there is an obvious reason that I am missing :)

>  /* Forward declaration */
>  struct page;
> diff --git a/mm/compaction.c b/mm/compaction.c
> index f72907c7cfef..65bef5f78897 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -52,8 +52,6 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
>  
>  #define block_start_pfn(pfn, order)	round_down(pfn, 1UL << (order))
>  #define block_end_pfn(pfn, order)	ALIGN((pfn) + 1, 1UL << (order))
> -#define pageblock_start_pfn(pfn)	block_start_pfn(pfn, pageblock_order)
> -#define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
>  
>  /*
>   * Page order with-respect-to which proactive compaction
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b5d3026979fc..46fe7575f03c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2000,7 +2000,7 @@ static void __init free_unused_memmap(void)
>  		 * presume that there are no holes in the memory map inside
>  		 * a pageblock
>  		 */
> -		start = round_down(start, pageblock_nr_pages);
> +		start = pageblock_start_pfn(start);
>  
>  		/*
>  		 * If we had a previous bank, and there is a space
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 36b20215a3be..93339cc61f92 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -544,7 +544,7 @@ static inline int pfn_to_bitidx(const struct page *page, unsigned long pfn)
>  #ifdef CONFIG_SPARSEMEM
>  	pfn &= (PAGES_PER_SECTION-1);
>  #else
> -	pfn = pfn - round_down(page_zone(page)->zone_start_pfn, pageblock_nr_pages);
> +	pfn = pfn - pageblock_start_pfn(page_zone(page)->zone_start_pfn);
>  #endif /* CONFIG_SPARSEMEM */
>  	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
>  }
> @@ -1857,7 +1857,7 @@ void set_zone_contiguous(struct zone *zone)
>  	unsigned long block_start_pfn = zone->zone_start_pfn;
>  	unsigned long block_end_pfn;
>  
> -	block_end_pfn = ALIGN(block_start_pfn + 1, pageblock_nr_pages);
> +	block_end_pfn = pageblock_end_pfn(block_start_pfn);
>  	for (; block_start_pfn < zone_end_pfn(zone);
>  			block_start_pfn = block_end_pfn,
>  			 block_end_pfn += pageblock_nr_pages) {
> @@ -2653,8 +2653,8 @@ int move_freepages_block(struct zone *zone, struct page *page,
>  		*num_movable = 0;
>  
>  	pfn = page_to_pfn(page);
> -	start_pfn = pfn & ~(pageblock_nr_pages - 1);
> -	end_pfn = start_pfn + pageblock_nr_pages - 1;
> +	start_pfn = pageblock_start_pfn(pfn);
> +	end_pfn = pageblock_end_pfn(pfn) - 1;
>  
>  	/* Do not cross zone boundaries */
>  	if (!zone_spans_pfn(zone, start_pfn))
> @@ -6939,9 +6939,8 @@ static void __init init_unavailable_range(unsigned long spfn,
>  	u64 pgcnt = 0;
>  
>  	for (pfn = spfn; pfn < epfn; pfn++) {
> -		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> -			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> -				+ pageblock_nr_pages - 1;
> +		if (!pfn_valid(pageblock_start_pfn(pfn))) {
> +			pfn = pageblock_end_pfn(pfn) - 1;
>  			continue;
>  		}
>  		__init_single_page(pfn_to_page(pfn), pfn, zone, node);
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 9d73dc38e3d7..f2df4ad53cd6 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -172,7 +172,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	 * to avoid redundant checks.
>  	 */
>  	check_unmovable_start = max(page_to_pfn(page), start_pfn);
> -	check_unmovable_end = min(ALIGN(page_to_pfn(page) + 1, pageblock_nr_pages),
> +	check_unmovable_end = min(pageblock_end_pfn(page_to_pfn(page)),
>  				  end_pfn);
>  


There are some more cases that might need care as well:


mm/memblock.c:          prev_end = ALIGN(end, pageblock_nr_pages);
mm/memblock.c:          prev_end = ALIGN(end, pageblock_nr_pages);
mm/page_isolation.c:    VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=
mm/page_isolation.c:              ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
mm/page_isolation.c:    unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
mm/page_isolation.c:    unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
mm/page_isolation.c:    unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
mm/page_isolation.c:    unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);



-- 
Thanks,

David / dhildenb

