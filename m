Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081484D7EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiCNJfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiCNJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:35:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4B87649
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:34:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FADC210FE;
        Mon, 14 Mar 2022 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647250442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrhvns3eJJSZbbPJB+GUKs5Vp1t21GpqMnW5wv4sJQ8=;
        b=Y25w2WPOH3cK6txjIYtc49Po4O1/afIyXuOozDA34MwximIDz+N2cmbar4kSB5EYpzkrJk
        bODVrAA9bozP9LHMeq2RXmoYbfT1j/H3TtejnVbud0rlZXzzTW/1nNQK3sJ7mhyKva6UPi
        cOepCvvAzYumSLU8QtlsWV6+PopStGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647250442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrhvns3eJJSZbbPJB+GUKs5Vp1t21GpqMnW5wv4sJQ8=;
        b=/wIFhhkF1b+HQseLdC724tUXvjOGsEMoH8Bz86vUlo0aZ2HZ6VT6gu1JBvHEQjQlq+mCL0
        nm6kqi1rM3wr+eCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F3ED13B2B;
        Mon, 14 Mar 2022 09:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iqa5DgoML2KUbQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 14 Mar 2022 09:34:02 +0000
Message-ID: <a77849a7-987d-ecf8-42c1-fc611cd71e15@suse.cz>
Date:   Mon, 14 Mar 2022 10:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>
References: <20220313232547.3843690-1-eric.dumazet@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: call check_pcp_refill() while zone
 spinlock is not held
In-Reply-To: <20220313232547.3843690-1-eric.dumazet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 00:25, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> check_pcp_refill() is used from rmqueue_bulk() while zone spinlock
> is held.
> 
> This used to be fine because check_pcp_refill() was testing only the
> head page, while its 'struct page' was very hot in the cpu caches.
> 
> With ("mm/page_alloc: check high-order pages for corruption during PCP
> operations") check_pcp_refill() will add latencies for high order pages.
> 
> We can defer the calls to check_pcp_refill() after the zone
> spinlock has been released.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> ---
>  mm/page_alloc.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c9ebf0635d592c6f58df9793ce9fa213371a9a7f..5f0531c11ad668b1c4426ebddc17821aca824783 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3024,7 +3024,9 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  			unsigned long count, struct list_head *list,
>  			int migratetype, unsigned int alloc_flags)
>  {
> +	struct page *page, *tmp;
>  	int i, allocated = 0;
> +	int free_cma_pages = 0;
>  
>  	/*
>  	 * local_lock_irq held so equivalent to spin_lock_irqsave for

Right so this should be AFAIU enough for
__mod_zone_page_state(NR_FREE_CMA_PAGES) at the end to be OK outside of
zone->lock.

> @@ -3032,14 +3034,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	 */
>  	spin_lock(&zone->lock);
>  	for (i = 0; i < count; ++i) {
> -		struct page *page = __rmqueue(zone, order, migratetype,
> -								alloc_flags);
> +		page = __rmqueue(zone, order, migratetype, alloc_flags);
>  		if (unlikely(page == NULL))
>  			break;
>  
> -		if (unlikely(check_pcp_refill(page)))
> -			continue;
> -
>  		/*
>  		 * Split buddy pages returned by expand() are received here in
>  		 * physical page order. The page is added to the tail of
> @@ -3052,9 +3050,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		 */
>  		list_add_tail(&page->lru, list);
>  		allocated++;
> -		if (is_migrate_cma(get_pcppage_migratetype(page)))
> -			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
> -					      -(1 << order));
>  	}
>  
>  	/*
> @@ -3065,6 +3060,16 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	 */
>  	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
>  	spin_unlock(&zone->lock);

You could maybe even exchange those two lines as well?

> +	list_for_each_entry_safe(page, tmp, list, lru) {
> +		if (unlikely(check_pcp_refill(page))) {
> +			list_del(&page->lru);
> +			allocated--;
> +		} else if (is_migrate_cma(get_pcppage_migratetype(page))) {
> +			free_cma_pages++;

I think in line with the (IMHO correct) decreasing NR_FREE_CMA_PAGES
regardless of the check result, we should also count free_cma_pages here
unconditionally before doing check_pcp_refill().

> +		}
> +	}
> +	if (free_cma_pages)
> +		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, -(free_cma_pages << order));
>  	return allocated;
>  }
>  

