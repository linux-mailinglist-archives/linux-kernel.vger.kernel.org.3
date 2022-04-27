Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CB9511346
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359344AbiD0INR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359339AbiD0INN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:13:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4694C2C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:10:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EF761F380;
        Wed, 27 Apr 2022 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651047001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFAtxF/0wAb9NJnG/I53G5SBU7w/mpVy8mXh+S+TaHk=;
        b=y5ZDC4wMdeTmEh57cAh/YKO6iXiIANJC2QM2D9eruFvDF6ZLrJ94LtxcOUodpouV+Rgf/P
        4HqT63bfPyWc6KM6Ty9u9xPRUC1/155gvdomkJL2uwp8Z66o3GR7spNb1NRha8qpkKlEo6
        0dFndph8qFE+ppCUYqe0mJ/UOkTeM6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651047001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFAtxF/0wAb9NJnG/I53G5SBU7w/mpVy8mXh+S+TaHk=;
        b=+wXKTGVjYGj2LnJDm3asEQsDfsIZlrUO62gro2/laJJH/151q6YFlVDlAjN+A2wwyzuZu1
        Sjwn/vIlM2PZboCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 395091323E;
        Wed, 27 Apr 2022 08:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AdxJDVn6aGIIPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 27 Apr 2022 08:10:01 +0000
Message-ID: <5f47bb6b-d7f4-13fc-8d09-e80c9a5185ba@suse.cz>
Date:   Wed, 27 Apr 2022 10:10:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 13/23] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-14-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-14-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 10:57, Hyeonggon Yoo wrote:
> There is not much benefit for serving large objects in kmalloc().
> Let's pass large requests to page allocator like SLUB for better
> maintenance of common code.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits:

> @@ -3607,15 +3607,25 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
>  {
>  	struct kmem_cache *s;
>  	size_t i;
> +	struct folio *folio;
>  
>  	local_irq_disable();
>  	for (i = 0; i < size; i++) {
>  		void *objp = p[i];

folio can be declared here
could probably move 's' too, and 'i' to the for () thanks to gnu11

>  
> -		if (!orig_s) /* called via kfree_bulk */
> -			s = virt_to_cache(objp);
> -		else
> +		if (!orig_s) {
> +			folio = virt_to_folio(objp);
> +			/* called via kfree_bulk */
> +			if (!folio_test_slab(folio)) {
> +				local_irq_enable();
> +				free_large_kmalloc(folio, objp);
> +				local_irq_disable();
> +				continue;
> +			}
> +			s = folio_slab(folio)->slab_cache;
> +		} else
>  			s = cache_from_obj(orig_s, objp);

This should now use { } brackets per kernel style.

> +
>  		if (!s)
>  			continue;
>  
