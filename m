Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D74CF650
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbiCGJfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbiCGJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:27:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F15A15C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:24:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EA74210F4;
        Mon,  7 Mar 2022 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646645084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbesU7tJyBXRg16/sf1QCiyqq4j+TrNZcTyuNDIT7/4=;
        b=rTLHFWB4bkpJaVJPgKjefViGQ1MW7mGfILnZGnmR/e1uSjeYcrgMulGOd81cy7kQCCew/o
        qlhKN9armihWCc83R9lwywRfuwL0FTtyI7aqVZNB//zMIUql6X7nqbrnWf4XkQalzVmoXZ
        DAvljv84jgZXc/4TJZKTzQ6a7ut18xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646645084;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbesU7tJyBXRg16/sf1QCiyqq4j+TrNZcTyuNDIT7/4=;
        b=WmOasQHVSV5ZUWpJlANconS3gOQ1nNinKIGCsJfgVaOl4agm+UAVZ6lwdDagPbLzyexTBT
        DKCcO82dGtWe4LBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3000E13A84;
        Mon,  7 Mar 2022 09:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w4wFC1zPJWL+CwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Mar 2022 09:24:44 +0000
Message-ID: <862170fd-a325-a158-36b8-eb73b15c2629@suse.cz>
Date:   Mon, 7 Mar 2022 10:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
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
References: <20220304170215.1868106-1-eric.dumazet@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone
 spinlock is not held
In-Reply-To: <20220304170215.1868106-1-eric.dumazet@gmail.com>
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

On 3/4/22 18:02, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> For high order pages not using pcp, rmqueue() is currently calling
> the costly check_new_pages() while zone spinlock is held,
> and hard irqs masked.
> 
> This is not needed, we can release the spinlock sooner to reduce
> zone spinlock contention.
> 
> Note that after this patch, we call __mod_zone_freepage_state()
> before deciding to leak the page because it is in bad state.

Which is arguably an accounting fix on its own, because when we remove page
from the free list, we should decrease the respective counter(s) even if we
find the page is in bad state and discard (effectively leak) it.

> 
> v2: We need to keep interrupts disabled to call __mod_zone_freepage_state()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: David Rientjes <rientjes@google.com>
> ---
>  mm/page_alloc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31928f850ebe5a4015ddc40e0469f3..1804287c1b792b8aa0e964b17eb002b6b1115258 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3706,10 +3706,10 @@ struct page *rmqueue(struct zone *preferred_zone,
>  	 * allocate greater than order-1 page units with __GFP_NOFAIL.
>  	 */
>  	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> -	spin_lock_irqsave(&zone->lock, flags);
>  
>  	do {
>  		page = NULL;
> +		spin_lock_irqsave(&zone->lock, flags);
>  		/*
>  		 * order-0 request can reach here when the pcplist is skipped
>  		 * due to non-CMA allocation context. HIGHATOMIC area is
> @@ -3721,15 +3721,15 @@ struct page *rmqueue(struct zone *preferred_zone,
>  			if (page)
>  				trace_mm_page_alloc_zone_locked(page, order, migratetype);
>  		}
> -		if (!page)
> +		if (!page) {
>  			page = __rmqueue(zone, order, migratetype, alloc_flags);
> -	} while (page && check_new_pages(page, order));
> -	if (!page)
> -		goto failed;
> -
> -	__mod_zone_freepage_state(zone, -(1 << order),
> -				  get_pcppage_migratetype(page));
> -	spin_unlock_irqrestore(&zone->lock, flags);
> +			if (!page)
> +				goto failed;
> +		}
> +		__mod_zone_freepage_state(zone, -(1 << order),
> +					  get_pcppage_migratetype(page));
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +	} while (check_new_pages(page, order));
>  
>  	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
>  	zone_statistics(preferred_zone, zone, 1);

