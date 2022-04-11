Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9394FB9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbiDKKep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiDKKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:34:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4152543AC1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:32:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB43521112;
        Mon, 11 Apr 2022 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649673147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7yn14Y/CNyAPNmn1Vk4CncuqQ7yIwJ/m/NWdKk6AwE=;
        b=SHIFLTG4fxP64tFjsmBTuKW0xZaXURXx4OYOA89r2RKiKxJYta/2cGgn+YEzmneyLPYPaz
        f3+wUrbivyqaIIY8WQe0YbouLIfFxBsamLsw1gsvp3xhqJzkLU23ETGXOB2RzHmgOyrmI+
        7QjOAnL77o0eCKq1cNnt5pCT6Q1c9QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649673147;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7yn14Y/CNyAPNmn1Vk4CncuqQ7yIwJ/m/NWdKk6AwE=;
        b=phA3f4AM9CXr/rcsh4h12IH/EqBtuKqQwnwM0eNcSFQpqqgZI4StWaBfSJ4TzVTN0y4f/N
        UXwzQxc0PNJL0gAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3C3013AB5;
        Mon, 11 Apr 2022 10:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aUP+LrsDVGL0YQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Apr 2022 10:32:27 +0000
Message-ID: <78656e93-fc52-5ae1-4da3-b779dac4d779@suse.cz>
Date:   Mon, 11 Apr 2022 12:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm/slub: remove duplicate flag in allocate_slab()
Content-Language: en-US
To:     Jiyoup Kim <lakroforce@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220409150538.1264-1-lakroforce@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220409150538.1264-1-lakroforce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/22 17:05, Jiyoup Kim wrote:
> In allocate_slab(), __GFP_NOFAIL flag is removed twice when trying
> higher-order allocation. Remove it.
> 
> Signed-off-by: Jiyoup Kim <lakroforce@gmail.com>

Thanks, added.

> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 74d92aa4a3a2..a0e605ab3036 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1939,7 +1939,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  	 */
>  	alloc_gfp = (flags | __GFP_NOWARN | __GFP_NORETRY) & ~__GFP_NOFAIL;
>  	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
> -		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
> +		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
>  
>  	slab = alloc_slab_page(alloc_gfp, node, oo);
>  	if (unlikely(!slab)) {

