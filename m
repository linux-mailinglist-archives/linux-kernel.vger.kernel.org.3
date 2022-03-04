Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85EB4CCFE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiCDI1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiCDI12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:27:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45AA199E1F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:26:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5492D1F384;
        Fri,  4 Mar 2022 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646382399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCOFuAaVAY0b+QRiHm9j3INKSoRjWhgAoY5Aj0qS72k=;
        b=wtT15f5UUskM2rJ/gLefAZDBA7aM70gAobwaXXxYAPnzKq3enKrDiWPtpeSoan+xWYnrc/
        yY+//jl/tZ+x9ZCij9HZTf6rrao7t8r4hkb5UmJvkQcLHMBEOWdCopYzoMmT5L/Fe0A3Qj
        lZPqAx2zxyC3eZk18WdeSHgZGTtmMZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646382399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCOFuAaVAY0b+QRiHm9j3INKSoRjWhgAoY5Aj0qS72k=;
        b=/lVPlxh+3PA0CyUEi3v5YaNiI76ndEJyKPnkw9qiQ86YO25Rtt8sgZ4wEsIfPL31852vk4
        CBbwyyt76lvL1vDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 279CA13AF7;
        Fri,  4 Mar 2022 08:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uRr2CD/NIWJ/ZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 08:26:39 +0000
Message-ID: <3fdd3840-fc97-96a6-8b61-ad1c89b5b403@suse.cz>
Date:   Fri, 4 Mar 2022 09:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm/page_alloc: call check_new_pages() while zone spinlock
 is not held
Content-Language: en-US
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
References: <20220304015941.1704249-1-eric.dumazet@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220304015941.1704249-1-eric.dumazet@gmail.com>
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

On 3/4/22 02:59, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> For high order pages not using pcp, rmqueue() is currently calling
> the costly check_new_pages() while zone spinlock is held.
> 
> This is not needed, we can release the spinlock sooner to reduce
> zone spinlock contention.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: David Rientjes <rientjes@google.com>
> ---
>  mm/page_alloc.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Just a quick reply from what AFAIK immediately see as a issue.

> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31928f850ebe5a4015ddc40e0469f3..0890a65f8cc2259e82bc1f5ba95a592fb30f9fb8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3685,7 +3685,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>  			gfp_t gfp_flags, unsigned int alloc_flags,
>  			int migratetype)
>  {
> -	unsigned long flags;
>  	struct page *page;
>  
>  	if (likely(pcp_allowed_order(order))) {
> @@ -3706,10 +3705,12 @@ struct page *rmqueue(struct zone *preferred_zone,
>  	 * allocate greater than order-1 page units with __GFP_NOFAIL.
>  	 */
>  	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> -	spin_lock_irqsave(&zone->lock, flags);
>  
>  	do {
> +		unsigned long flags;
> +
>  		page = NULL;
> +		spin_lock_irqsave(&zone->lock, flags);
>  		/*
>  		 * order-0 request can reach here when the pcplist is skipped
>  		 * due to non-CMA allocation context. HIGHATOMIC area is
> @@ -3723,13 +3724,13 @@ struct page *rmqueue(struct zone *preferred_zone,
>  		}
>  		if (!page)
>  			page = __rmqueue(zone, order, migratetype, alloc_flags);
> -	} while (page && check_new_pages(page, order));
> -	if (!page)
> -		goto failed;
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +		if (!page)
> +			return NULL;
> +	} while (check_new_pages(page, order));
>  
>  	__mod_zone_freepage_state(zone, -(1 << order),
>  				  get_pcppage_migratetype(page));
> -	spin_unlock_irqrestore(&zone->lock, flags);

__mod_zone_freepage_state() outside the lock is AFAIK unsafe.

>  
>  	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
>  	zone_statistics(preferred_zone, zone, 1);
> @@ -3743,10 +3744,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>  
>  	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
>  	return page;
> -
> -failed:
> -	spin_unlock_irqrestore(&zone->lock, flags);
> -	return NULL;
>  }
>  
>  #ifdef CONFIG_FAIL_PAGE_ALLOC

