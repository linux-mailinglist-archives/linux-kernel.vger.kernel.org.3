Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6551460A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356990AbiD2Jzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357250AbiD2Jxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:53:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091CBC6665
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:48:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B50E01F37F;
        Fri, 29 Apr 2022 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651225728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxggnncOAcblbYQZJNB30akkHG4VRQKKY5BkiDnWc90=;
        b=aeKg0UWRKRUj9aNmKB3RFC/Nj0ws05YLrnpIGDfr5/diw7DIrOI/Sh9kPshXQOg+N+G6YJ
        U9kKGyLU4o2x7kCzgJKiIcT2WLZxBAxtecdaDERGWZ9+kT7ksgE2JBb9tWBIoSWS7BOfCS
        exise+5F534oK4qyX5oNmdPFrozfIxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651225728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxggnncOAcblbYQZJNB30akkHG4VRQKKY5BkiDnWc90=;
        b=Ruy+j4YcDnjAuLyn/ajdQqb0aegdQ1KqdSEWkvoP6/FujouErtPZdES7DIzgLBHly8ETq0
        2zVhosDIfSQniGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90FE513AE0;
        Fri, 29 Apr 2022 09:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j7jFIoC0a2KeDQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Apr 2022 09:48:48 +0000
Message-ID: <5681e266-36ec-f389-20c4-399bc5295898@suse.cz>
Date:   Fri, 29 Apr 2022 11:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] mm/slub: remove unused kmem_cache_order_objects max
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220429090545.33413-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220429090545.33413-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 11:05, Miaohe Lin wrote:
> max field holds the largest slab order that was ever used for a slab cache.
> But it's unused now. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Added to slab tree, thanks.

> ---
>  include/linux/slub_def.h | 1 -
>  mm/slub.c                | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 33c5c0e3bd8d..f9c68a9dac04 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -105,7 +105,6 @@ struct kmem_cache {
>  	struct kmem_cache_order_objects oo;
>  
>  	/* Allocation and freeing of slabs */
> -	struct kmem_cache_order_objects max;
>  	struct kmem_cache_order_objects min;
>  	gfp_t allocflags;	/* gfp flags to use on each alloc */
>  	int refcount;		/* Refcount for slab cache destroy */
> diff --git a/mm/slub.c b/mm/slub.c
> index 1f699ddfff7f..e5535020e0fd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4162,8 +4162,6 @@ static int calculate_sizes(struct kmem_cache *s)
>  	 */
>  	s->oo = oo_make(order, size);
>  	s->min = oo_make(get_order(size), size);
> -	if (oo_objects(s->oo) > oo_objects(s->max))
> -		s->max = s->oo;
>  
>  	return !!oo_objects(s->oo);
>  }

