Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95A54E686
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378071AbiFPP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378110AbiFPP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:59:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9B483AE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:59:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DD331F7AB;
        Thu, 16 Jun 2022 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655395175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhO8fx+N0t/ZLpQ+sMzhgl7vGpI2fxQcQAASoCjQrlE=;
        b=bt/65kyRXDmJD9B6Mfex4CmXNZpULdJOEmHZTFOcFCOykT47YgmDngb9h6SURkwUGIA29j
        M1JS3jILhGOOx1M0oXMnN6aRNbgFJEkTh4yKb+EYQOJ7yIau/Q6+XmcFpgd/Sh1qmzvlKe
        +Sarv/sxALURpL6+qUiMPu17LqqXuEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655395175;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhO8fx+N0t/ZLpQ+sMzhgl7vGpI2fxQcQAASoCjQrlE=;
        b=dE7415pV/JQhObWc64P3wIuMigOwne1KfssobhSNON3HaoBXVhoUPdtgZKOCghirighPQQ
        FqIfxCwvT6wj8ABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0750613A70;
        Thu, 16 Jun 2022 15:59:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4qQRAWdTq2JGTwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Jun 2022 15:59:35 +0000
Message-ID: <af8f5c7d-5f7f-17ad-835e-1fdea2d8dda8@suse.cz>
Date:   Thu, 16 Jun 2022 17:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/7] mm/page_alloc: Protect PCP lists with a spinlock
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
 <20220613125622.18628-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220613125622.18628-6-mgorman@techsingularity.net>
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
> Currently the PCP lists are protected by using local_lock_irqsave to
> prevent migration and IRQ reentrancy but this is inconvenient.  Remote
> draining of the lists is impossible and a workqueue is required and every
> task allocation/free must disable then enable interrupts which is
> expensive.
> 
> As preparation for dealing with both of those problems, protect the lists
> with a spinlock.  The IRQ-unsafe version of the lock is used because IRQs
> are already disabled by local_lock_irqsave.  spin_trylock is used in
> preparation for a time when local_lock could be used instead of
> lock_lock_irqsave.
> 
> The per_cpu_pages still fits within the same number of cache lines after
> this patch relative to before the series.
> 
> struct per_cpu_pages {
>         spinlock_t                 lock;                 /*     0     4 */
>         int                        count;                /*     4     4 */
>         int                        high;                 /*     8     4 */
>         int                        batch;                /*    12     4 */
>         short int                  free_factor;          /*    16     2 */
>         short int                  expire;               /*    18     2 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         struct list_head           lists[13];            /*    24   208 */
> 
>         /* size: 256, cachelines: 4, members: 7 */
>         /* sum members: 228, holes: 1, sum holes: 4 */
>         /* padding: 24 */
> } __attribute__((__aligned__(64)));
> 
> There is overhead in the fast path due to acquiring the spinlock even
> though the spinlock is per-cpu and uncontended in the common case.  Page
> Fault Test (PFT) running on a 1-socket reported the following results on a
> 1 socket machine.
> 
>                                      5.18.0-rc1               5.18.0-rc1
>                                         vanilla         mm-pcpdrain-v2r1
> Hmean     faults/sec-1   886331.5718 (   0.00%)   885462.7479 (  -0.10%)
> Hmean     faults/sec-3  2337706.1583 (   0.00%)  2332130.4909 *  -0.24%*
> Hmean     faults/sec-5  2851594.2897 (   0.00%)  2844123.9307 (  -0.26%)
> Hmean     faults/sec-7  3543251.5507 (   0.00%)  3516889.0442 *  -0.74%*
> Hmean     faults/sec-8  3947098.0024 (   0.00%)  3916162.8476 *  -0.78%*
> Stddev    faults/sec-1     2302.9105 (   0.00%)     2065.0845 (  10.33%)
> Stddev    faults/sec-3     7275.2442 (   0.00%)     6033.2620 (  17.07%)
> Stddev    faults/sec-5    24726.0328 (   0.00%)    12525.1026 (  49.34%)
> Stddev    faults/sec-7     9974.2542 (   0.00%)     9543.9627 (   4.31%)
> Stddev    faults/sec-8     9468.0191 (   0.00%)     7958.2607 (  15.95%)
> CoeffVar  faults/sec-1        0.2598 (   0.00%)        0.2332 (  10.24%)
> CoeffVar  faults/sec-3        0.3112 (   0.00%)        0.2587 (  16.87%)
> CoeffVar  faults/sec-5        0.8670 (   0.00%)        0.4404 (  49.21%)
> CoeffVar  faults/sec-7        0.2815 (   0.00%)        0.2714 (   3.60%)
> CoeffVar  faults/sec-8        0.2399 (   0.00%)        0.2032 (  15.28%)
> 
> There is a small hit in the number of faults per second but given that the
> results are more stable, it's borderline noise.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

With comments:

> -static void free_unref_page_commit(struct page *page, int migratetype,
> -				   unsigned int order)
> +/* Returns true if the page was committed to the per-cpu list. */
> +static bool free_unref_page_commit(struct page *page, int migratetype,
> +				   unsigned int order, bool locked)

'bool locked' schemes are frowned upon. Although this does some preparatory
work outside of the locked section...

>  {
>  	struct zone *zone = page_zone(page);
>  	struct per_cpu_pages *pcp;
>  	int high;
>  	int pindex;
>  	bool free_high;
> +	unsigned long __maybe_unused UP_flags;
>  
>  	__count_vm_event(PGFREE);
>  	pcp = this_cpu_ptr(zone->per_cpu_pageset);
>  	pindex = order_to_pindex(migratetype, order);

... maybe it would be simpler to just do the locking always outside? We
aren't expecting any contention anyway except if draining is in progress,
and thus making the lock hold time a bunch of instructions longer won't make
any difference?

That said I don't know yet how patches 6 and 7 change this...

[...]

> @@ -3465,10 +3510,19 @@ void free_unref_page(struct page *page, unsigned int order)
>  void free_unref_page_list(struct list_head *list)
>  {
>  	struct page *page, *next;
> +	struct per_cpu_pages *pcp;
> +	struct zone *locked_zone;
>  	unsigned long flags;
>  	int batch_count = 0;
>  	int migratetype;
>  
> +	/*
> +	 * An empty list is possible. Check early so that the later
> +	 * lru_to_page() does not potentially read garbage.
> +	 */ 
> +	if (list_empty(list))
> +		return;

There's another check below and list_for_each_entry_safe() is fine with an
empty list, so this one seems unnecessary?

>  	/* Prepare pages for freeing */
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		unsigned long pfn = page_to_pfn(page);
> @@ -3489,8 +3543,31 @@ void free_unref_page_list(struct list_head *list)
>  		}
>  	}
>  
> +	/*
> +	 * Preparation could have drained the list due to failing to prepare
> +	 * or all pages are being isolated.
> +	 */
> +	if (list_empty(list))
> +		return;
> +
>  	local_lock_irqsave(&pagesets.lock, flags);
> +
> +	page = lru_to_page(list);
