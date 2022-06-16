Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E9E54E844
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbiFPRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiFPRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:01:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A583F885
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:01:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B9F01F8BB;
        Thu, 16 Jun 2022 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655398914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m8FLOcERmZrpjJZ8Jd9/Y7nfhUCFzUgn4yTma3QGvug=;
        b=YWFDKtMY0LbEkUyeN5hZdDo8o9ynLosp6Rw14sy5TA1W5umeEvw4LMXl2UAG1jNdUdNWru
        Arp5xbTXA/DF/JLLQshKgDo3BHm8SBees5DCmnZwK8NDyDSjYsDpRXJisDI6tJD8dDcNaS
        Q+rvnPwPIQrssTM65RYu1/if4knd7BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655398914;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m8FLOcERmZrpjJZ8Jd9/Y7nfhUCFzUgn4yTma3QGvug=;
        b=hQso4cv0U5K8brxQ4UlJFYq7ARJg8Hlo8p87GLHP2f9nWzGT7VaFKGdzhfwT1nAz2dArXx
        7Oapxb5PBn2FlODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3A9E1344E;
        Thu, 16 Jun 2022 17:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KJG5MQFiq2IRZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Jun 2022 17:01:53 +0000
Message-ID: <43033655-2e78-621b-cc76-c3dc53024d00@suse.cz>
Date:   Thu, 16 Jun 2022 19:01:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220613125622.18628-8-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 14:56, Mel Gorman wrote:
> struct per_cpu_pages is no longer strictly local as PCP lists can be
> drained remotely using a lock for protection. While the use of local_lock
> works, it goes against the intent of local_lock which is for "pure
> CPU local concurrency control mechanisms and not suited for inter-CPU
> concurrency control" (Documentation/locking/locktypes.rst)
> 
> local_lock protects against migration between when the percpu pointer is
> accessed and the pcp->lock acquired. The lock acquisition is a preemption
> point so in the worst case, a task could migrate to another NUMA node
> and accidentally allocate remote memory. The main requirement is to pin
> the task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.
> 
> Replace local_lock with helpers that pin a task to a CPU, lookup the
> per-cpu structure and acquire the embedded lock. It's similar to local_lock
> without breaking the intent behind the API. It is not a complete API
> as only the parts needed for PCP-alloc are implemented but in theory,
> the generic helpers could be promoted to a general API if there was
> demand for an embedded lock within a per-cpu struct with a guarantee
> that the per-cpu structure locked matches the running CPU and cannot use
> get_cpu_var due to RT concerns. PCP requires these semantics to avoid
> accidentally allocating remote memory.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

...

> @@ -3367,30 +3429,17 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
>  	return min(READ_ONCE(pcp->batch) << 2, high);
>  }
>  
> -/* Returns true if the page was committed to the per-cpu list. */
> -static bool free_unref_page_commit(struct page *page, int migratetype,
> -				   unsigned int order, bool locked)
> +static void free_unref_page_commit(struct per_cpu_pages *pcp, struct zone *zone,
> +				   struct page *page, int migratetype,
> +				   unsigned int order)

Hmm given this drops the "bool locked" and bool return value again, my
suggestion for patch 5/7 would result in less churn as those woudn't need to
be introduced?

...

> @@ -3794,19 +3805,29 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>  	struct list_head *list;
>  	struct page *page;
>  	unsigned long flags;
> +	unsigned long __maybe_unused UP_flags;
>  
> -	local_lock_irqsave(&pagesets.lock, flags);
> +	/*
> +	 * spin_trylock_irqsave is not necessary right now as it'll only be
> +	 * true when contending with a remote drain. It's in place as a
> +	 * preparation step before converting pcp locking to spin_trylock
> +	 * to protect against IRQ reentry.
> +	 */
> +	pcp_trylock_prepare(UP_flags);
> +	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
> +	if (!pcp)

Besides the missing unpin Andrew fixed, I think also this is missing
pcp_trylock_finish(UP_flags); ?

> +		return NULL;
>  
>  	/*
>  	 * On allocation, reduce the number of pages that are batch freed.
>  	 * See nr_pcp_free() where free_factor is increased for subsequent
>  	 * frees.
>  	 */
> -	pcp = this_cpu_ptr(zone->per_cpu_pageset);
>  	pcp->free_factor >>= 1;
>  	list = &pcp->lists[order_to_pindex(migratetype, order)];
> -	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list, false);
> -	local_unlock_irqrestore(&pagesets.lock, flags);
> +	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
> +	pcp_spin_unlock_irqrestore(pcp, flags);
> +	pcp_trylock_finish(UP_flags);
>  	if (page) {
>  		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
>  		zone_statistics(preferred_zone, zone, 1);
> @@ -5410,10 +5431,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		goto failed;
>  
>  	/* Attempt the batch allocation */
> -	local_lock_irqsave(&pagesets.lock, flags);
> -	pcp = this_cpu_ptr(zone->per_cpu_pageset);
> +	pcp = pcp_spin_lock_irqsave(zone->per_cpu_pageset, flags);
>  	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
> -	spin_lock(&pcp->lock);
>  
>  	while (nr_populated < nr_pages) {
>  
> @@ -5424,13 +5443,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		}
>  
>  		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
> -							pcp, pcp_list, true);
> +							pcp, pcp_list);
>  		if (unlikely(!page)) {
>  			/* Try and allocate at least one page */
> -			if (!nr_account) {
> -				spin_unlock(&pcp->lock);
> +			if (!nr_account)
>  				goto failed_irq;
> -			}
>  			break;
>  		}
>  		nr_account++;
> @@ -5443,8 +5460,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		nr_populated++;
>  	}
>  
> -	spin_unlock(&pcp->lock);
> -	local_unlock_irqrestore(&pagesets.lock, flags);
> +	pcp_spin_unlock_irqrestore(pcp, flags);
>  
>  	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>  	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
> @@ -5453,7 +5469,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	return nr_populated;
>  
>  failed_irq:
> -	local_unlock_irqrestore(&pagesets.lock, flags);
> +	pcp_spin_unlock_irqrestore(pcp, flags);
>  
>  failed:
>  	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);

