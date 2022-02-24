Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89D54C3471
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiBXSQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiBXSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:16:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD2C253150
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:16:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3138B212C3;
        Thu, 24 Feb 2022 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645726572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/8NsNP040//Ert9Skq2L4C9oDn8wOiaaKj5hexx7sw=;
        b=JDa1rU+ITsaYxZqceG/dUCQw5eurr/U7kNNMIatMBL+A98AQKJN9VedQqlMisOsEH4AfCF
        z9+JLlO9cZ6tmx40VNHpYhFtOEzWJmnYbh1pSd+KU+RO/5puqlJ0yTLD/5Kv58Rsj6D0px
        m4mB6UDJAVEkcd9qcI49vFlbO4Qvt1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645726572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/8NsNP040//Ert9Skq2L4C9oDn8wOiaaKj5hexx7sw=;
        b=PQrfOyKx5j+NZgdHPpRiCRPVmyhktbreHqVuZTXz07jUvBSOdm93vBoFVCrBQIJ8RoJZxv
        xdeFPpMoONHcEADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 017CB13B0C;
        Thu, 24 Feb 2022 18:16:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rq3BOmvLF2IEKAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Feb 2022 18:16:11 +0000
Message-ID: <cd4144f5-e769-cf73-ca25-b36f2c4bbf35@suse.cz>
Date:   Thu, 24 Feb 2022 19:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-6-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 5/5] mm/slub: Refactor deactivate_slab()
In-Reply-To: <20220221105336.522086-6-42.hyeyoo@gmail.com>
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

On 2/21/22 11:53, Hyeonggon Yoo wrote:
> Simply deactivate_slab() by removing variable 'lock' and replacing
> 'l' and 'm' with 'mode'. Instead, remove slab from list and unlock
> n->list_lock when cmpxchg_double() fails, and then retry.
> 
> One slight functional change is releasing and taking n->list_lock again
> when cmpxchg_double() fails. This is not harmful because SLUB avoids
> deactivating slabs as much as possible.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Hm I wonder if we could simplify even a bit more. Do we have to actually
place the slab on a partial (full) list before the cmpxchg, only to remove
it when cmpxchg fails? Seems it's to avoid anyone else seeing the slab
un-frozen, but not on the list, which would be unexpected. However if anyone
sees such slab, they have to take the list_lock first to start working with
the slab... so this should be safe, because we hold the list_lock here, and
will place the slab on the list before we release it. But it thus shouldn't
matter if the placement happens before or after a successful cmpxchg, no? So
we can only do it once after a successful cmpxchg and need no undo's?

Specifically AFAIK the only possible race should be with a __slab_free()
which might observe !was_frozen after we succeed an unfreezing cmpxchg and
go through the
"} else { /* Needs to be taken off a list */"
branch but then it takes the list_lock as the first thing, so will be able
to proceed only after the slab is actually on the list.

Do I miss anything or would you agree?

> ---
>  mm/slub.c | 74 +++++++++++++++++++++++++------------------------------
>  1 file changed, 33 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a4964deccb61..2d0663befb9e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2350,8 +2350,8 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
> @@ -2420,57 +2420,49 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
> +		add_partial(n, slab, tail);
> +	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> +		mode = M_FULL;
> +		/*
> +		 * This also ensures that the scanning of full
> +		 * slabs from diagnostic functions will not see
> +		 * any frozen slabs.
> +		 */
> +		spin_lock_irqsave(&n->list_lock, flags);
> +		add_full(s, n, slab);
>  	}
>  
> -	if (l != m) {
> -		if (l == M_PARTIAL)
> -			remove_partial(n, slab);
> -		else if (l == M_FULL)
> -			remove_full(s, n, slab);
>  
> -		if (m == M_PARTIAL)
> -			add_partial(n, slab, tail);
> -		else if (m == M_FULL)
> -			add_full(s, n, slab);
> -	}
> -
> -	l = m;
>  	if (!cmpxchg_double_slab(s, slab,
>  				old.freelist, old.counters,
>  				new.freelist, new.counters,
> -				"unfreezing slab"))
> +				"unfreezing slab")) {
> +		if (mode == M_PARTIAL) {
> +			remove_partial(n, slab);
> +			spin_unlock_irqrestore(&n->list_lock, flags);
> +		} else if (mode == M_FULL) {
> +			remove_full(s, n, slab);
> +			spin_unlock_irqrestore(&n->list_lock, flags);
> +		}
>  		goto redo;
> +	}
>  
> -	if (lock)
> -		spin_unlock_irqrestore(&n->list_lock, flags);
>  
> -	if (m == M_PARTIAL)
> +	if (mode == M_PARTIAL) {
> +		spin_unlock_irqrestore(&n->list_lock, flags);
>  		stat(s, tail);
> -	else if (m == M_FULL)
> +	} else if (mode == M_FULL) {
> +		spin_unlock_irqrestore(&n->list_lock, flags);
>  		stat(s, DEACTIVATE_FULL);
> -	else if (m == M_FREE) {
> +	} else if (mode == M_FREE) {
>  		stat(s, DEACTIVATE_EMPTY);
>  		discard_slab(s, slab);
>  		stat(s, FREE_SLAB);

