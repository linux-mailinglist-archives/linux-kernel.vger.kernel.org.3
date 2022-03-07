Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41DF4D044E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiCGQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbiCGQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:41:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3FC506D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:40:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F4D1210FF;
        Mon,  7 Mar 2022 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646671243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8dh4GyWsuZQpOUWJYTNSBAILVfnH4W50m69Zy0f1yw=;
        b=OhPUMq1oOMBQ0yE+CkJlnQyTUyTCss65Ch7/ZNRSTi8a4fkUBir4gF62DX+dMYyjPAFpaN
        qpap3cgJ1Z7tG/XySu/OVwVDm5jc0msQWKtkhLToWiap2ElHVxQbZQSwmQAq+Q9A9YQ7nC
        ILDMcFOYDurqIARM75bLM98WEvblAVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646671243;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8dh4GyWsuZQpOUWJYTNSBAILVfnH4W50m69Zy0f1yw=;
        b=kKUob1H/wHo1YPnI8AbQcGpzs8kDJVK720KguYQ8y0I73thjpupeRcYOq5X4JCfo/AeSxK
        JfKfQk81OE2aX4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26DD813B93;
        Mon,  7 Mar 2022 16:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uBS0CIs1JmKYTAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Mar 2022 16:40:43 +0000
Message-ID: <07d4f687-544f-17d4-51cd-7b86aa23fb21@suse.cz>
Date:   Mon, 7 Mar 2022 17:40:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
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
References: <20220307074057.902222-1-42.hyeyoo@gmail.com>
 <20220307074057.902222-3-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 2/2] mm/slub: refactor deactivate_slab()
In-Reply-To: <20220307074057.902222-3-42.hyeyoo@gmail.com>
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

On 3/7/22 08:40, Hyeonggon Yoo wrote:
> Simplify deactivate_slab() by unlocking n->list_lock and retrying
> cmpxchg_double() when cmpxchg_double() fails, and perform
> add_{partial,full} only when it succeed.
> 
> Releasing and taking n->list_lock again here is not harmful as SLUB
> avoids deactivating slabs as much as possible.
> 
> [ vbabka@suse.cz: perform add_{partial,full} when cmpxchg_double()
>   succeed.
> 
>   count deactivating full slabs even if debugging flag is not set. ]
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

adding both to slab-next. Fixed up some nits myself, see below:

>  
> @@ -2420,61 +2416,50 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	new.frozen = 0;
>  
>  	if (!new.inuse && n->nr_partial >= s->min_partial)
> -		m = M_FREE;
> +		mode = M_FREE;
>  	else if (new.freelist) {

This was against kernel style even before the patch - we use { } in the
'else if' branch, thus all branches should use { } even if one-line.

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
> -	}
> -
> -	if (l != m) {
> -		if (l == M_PARTIAL)
> -			remove_partial(n, slab);
> -		else if (l == M_FULL)
> -			remove_full(s, n, slab);
> +		mode = M_PARTIAL;
> +		/*
> +		 * Taking the spinlock removes the possibility that
> +		 * acquire_slab() will see a slab that is frozen
> +		 */
> +		spin_lock_irqsave(&n->list_lock, flags);
> +	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> +		mode = M_FULL;
> +		/*
> +		 * This also ensures that the scanning of full
> +		 * slabs from diagnostic functions will not see
> +		 * any frozen slabs.
> +		 */
> +		spin_lock_irqsave(&n->list_lock, flags);
> +	} else
> +		mode = M_FULL_NOLIST;

Ditto here (this is new).

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
> -		stat(s, DEACTIVATE_FULL);
> -	else if (m == M_FREE) {
> +	} else if (mode == M_FREE) {
>  		stat(s, DEACTIVATE_EMPTY);
>  		discard_slab(s, slab);
>  		stat(s, FREE_SLAB);
> -	}
> +	} else if (mode == M_FULL) {
> +		add_full(s, n, slab);
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +		stat(s, DEACTIVATE_FULL);
> +	} else if (mode == M_FULL_NOLIST)
> +		stat(s, DEACTIVATE_FULL);

And here.

>  }
>  
>  #ifdef CONFIG_SLUB_CPU_PARTIAL

