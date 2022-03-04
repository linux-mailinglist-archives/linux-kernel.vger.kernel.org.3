Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1684CDD14
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiCDTCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 14:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiCDTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:02:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909A31DBA9B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:01:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 192081F38A;
        Fri,  4 Mar 2022 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646420481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tt49sqFxCrGkXmPXZ9oMGkRFOU2rUQvc4pyyYVC4QWg=;
        b=ibPrHdVXCSddMXrXx3xD0EDxeu/v84LxFsPVauKbTbydXSnx9NsRzaKbNtsYKsAL1beGT3
        yvPHPfB3dNtBsaTtP1RysudxCHU5g8GjoHVEt3oPVOlTW+CJ+Cotz67ci0mRAOKfeVGNKU
        /GqB1a/q2vc2Q/9RsTTd/aOhRSoi4Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646420481;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tt49sqFxCrGkXmPXZ9oMGkRFOU2rUQvc4pyyYVC4QWg=;
        b=b1OsdYPquuc85r7XwG2CZX73jPE8d1SoPTyy3GDepmZbv6Gj07uzhpx9W3Wj5rzZCiYgYt
        ZOPhsSfXfJxyf5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6B8E13B5B;
        Fri,  4 Mar 2022 19:01:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WXWpNwBiImLkDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 19:01:20 +0000
Message-ID: <6763e97b-88bf-59b0-c80e-26c3846531fc@suse.cz>
Date:   Fri, 4 Mar 2022 20:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 5/5] mm/slub: refactor deactivate_slab()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <20220304063427.372145-6-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220304063427.372145-6-42.hyeyoo@gmail.com>
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

On 3/4/22 07:34, Hyeonggon Yoo wrote:
> Simplify deactivate_slab() by unlocking n->list_lock and retrying
> cmpxchg_double() when cmpxchg_double() fails, and perform
> add_{partial,full} only when it succeed.
> 
> Releasing and taking n->list_lock again here is not harmful as SLUB
> avoids deactivating slabs as much as possible.
> 
> [ vbabka@suse.cz: perform add_{partial,full} when cmpxchg_double()
>   succeed. ]
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Looks good, just noticed a tiny issue.

> ---
>  mm/slub.c | 81 ++++++++++++++++++++++---------------------------------
>  1 file changed, 32 insertions(+), 49 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f9ae983a3dc6..c1a693ec5874 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2344,8 +2344,8 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  {
>  	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
>  	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> -	int lock = 0, free_delta = 0;
> -	enum slab_modes l = M_NONE, m = M_NONE;
> +	int free_delta = 0;
> +	enum slab_modes mode = M_NONE;
>  	void *nextfree, *freelist_iter, *freelist_tail;
>  	int tail = DEACTIVATE_TO_HEAD;
>  	unsigned long flags = 0;
> @@ -2387,14 +2387,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	 * Ensure that the slab is unfrozen while the list presence
>  	 * reflects the actual number of objects during unfreeze.
>  	 *
> -	 * We setup the list membership and then perform a cmpxchg
> -	 * with the count. If there is a mismatch then the slab
> -	 * is not unfrozen but the slab is on the wrong list.
> -	 *
> -	 * Then we restart the process which may have to remove
> -	 * the slab from the list that we just put it on again
> -	 * because the number of objects in the slab may have
> -	 * changed.
> +	 * We first perform cmpxchg holding lock and insert to list
> +	 * when it succeed. If there is mismatch then slub is not
> +	 * unfrozen and number of objects in the slab may have changed.
> +	 * Then release lock and retry cmpxchg again.
>  	 */
>  redo:
>  
> @@ -2414,57 +2410,44 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	new.frozen = 0;
>  
>  	if (!new.inuse && n->nr_partial >= s->min_partial)
> -		m = M_FREE;
> +		mode = M_FREE;
>  	else if (new.freelist) {
> -		m = M_PARTIAL;
> -		if (!lock) {
> -			lock = 1;
> -			/*
> -			 * Taking the spinlock removes the possibility that
> -			 * acquire_slab() will see a slab that is frozen
> -			 */
> -			spin_lock_irqsave(&n->list_lock, flags);
> -		}
> -	} else {
> -		m = M_FULL;
> -		if (kmem_cache_debug_flags(s, SLAB_STORE_USER) && !lock) {

This used to set m = M_FULL; always.

> -			lock = 1;
> -			/*
> -			 * This also ensures that the scanning of full
> -			 * slabs from diagnostic functions will not see
> -			 * any frozen slabs.
> -			 */
> -			spin_lock_irqsave(&n->list_lock, flags);
> -		}
> +		mode = M_PARTIAL;
> +		/*
> +		 * Taking the spinlock removes the possibility that
> +		 * acquire_slab() will see a slab that is frozen
> +		 */
> +		spin_lock_irqsave(&n->list_lock, flags);
> +	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> +		mode = M_FULL;

Now you only set it for SLAB_STORE_USER caches.

> +		/*
> +		 * This also ensures that the scanning of full
> +		 * slabs from diagnostic functions will not see
> +		 * any frozen slabs.
> +		 */
> +		spin_lock_irqsave(&n->list_lock, flags);
>  	}
>  
> -	if (l != m) {
> -		if (l == M_PARTIAL)
> -			remove_partial(n, slab);
> -		else if (l == M_FULL)
> -			remove_full(s, n, slab);
> -
> -		if (m == M_PARTIAL)
> -			add_partial(n, slab, tail);
> -		else if (m == M_FULL)
> -			add_full(s, n, slab);
> -	}
>  
> -	l = m;
>  	if (!cmpxchg_double_slab(s, slab,
>  				old.freelist, old.counters,
>  				new.freelist, new.counters,
> -				"unfreezing slab"))
> +				"unfreezing slab")) {
> +		if (mode == M_PARTIAL || mode == M_FULL)
> +			spin_unlock_irqrestore(&n->list_lock, flags);
>  		goto redo;
> +	}
>  
> -	if (lock)
> -		spin_unlock_irqrestore(&n->list_lock, flags);
>  
> -	if (m == M_PARTIAL)
> +	if (mode == M_PARTIAL) {
> +		add_partial(n, slab, tail);
> +		spin_unlock_irqrestore(&n->list_lock, flags);
>  		stat(s, tail);
> -	else if (m == M_FULL)
> +	} else if (mode == M_FULL) {
> +		add_full(s, n, slab);
> +		spin_unlock_irqrestore(&n->list_lock, flags);
>  		stat(s, DEACTIVATE_FULL);

As a result, full slabs without SLAB_STORE_USER will not count
DEACTIVATE_FULL anymore.
I guess the easiest way to solve it is to e.g. add a M_FULL_NOLIST mode that
only does the DEACTIVATE_FULL counting.

> -	else if (m == M_FREE) {
> +	} else if (mode == M_FREE) {
>  		stat(s, DEACTIVATE_EMPTY);
>  		discard_slab(s, slab);
>  		stat(s, FREE_SLAB);

