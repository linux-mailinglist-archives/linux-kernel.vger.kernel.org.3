Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5C5370CA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiE2LhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiE2LhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:37:10 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731893BA58
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:37:09 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id a15so5946928ilq.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f2p+RNA3uW2ooZwCskBW9DfWGMzM7OSZpW6uiTppzOI=;
        b=e4ZYCc9oVK8MNkLyNA//UfF8oFEpedvj0IZa3bUuNrV66HOKChkPNWU47pOOOjxemh
         1dGyXx3X3bH8oBJiaW0F9T0guH902+CB2ax0JxTsTmrd+LSCS12iCZPf8+mkknanlBma
         sORCIdoBoEr8lCK8+yn7eJnzUENIntoUD/uuqFhq0r9lpV+eL7W9cJliXgw5EA03Shoz
         tUTTHkeXyvsKQ9OzNUiYuBMtsFDKinbtLFLuHhrajlR0wuwTqTvpS3iID6DVWMKbHUxE
         ndRb9q4+Yfd29FMEakiw8+dZoclAHSDdIdAVXkazY5CfmJU5nnlwzvwctPpi7DsiC7/Z
         cCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f2p+RNA3uW2ooZwCskBW9DfWGMzM7OSZpW6uiTppzOI=;
        b=SxwvkzIpB8MNVqmyuV5uQFCqWbNHZN86aC70QGcR19AamfxCCq9G0kaSDF5NXbYt9r
         0Zb6r2hd3w/P0Vy8qiy8j0+/pjXkkLobbocC7wKFQbDqeP8ifzPrG20HUQZAOMftQaP8
         ig5RvaAr8UMuPI27guSTiYxrlsj7nWEMwh4JBhgJvRkC9NN71OCermXEpoti9AZiUtr9
         MGRDugLRoUJoog+WLzDN73Pg0j1ZPHlgxLppZMPHhQmXpuSKH2srd/YM9SHK1PtD0Ufi
         jSM6ZUzKRX8TpgvJDLdzKlhIm1fEAysEDCfapVprO8KO+cUsBrDlF2QjXIVrsi517Wp8
         pzDQ==
X-Gm-Message-State: AOAM5303ek+GnyT4UgWbA+fU3LNASciB0a8cQsnKsgZk0FecwvzCEiJC
        aZBx2bzbJ16AdEs+uFmR9f8=
X-Google-Smtp-Source: ABdhPJxwX7tSauAwoz+2wEumjBcwtWDJqcKW8H5Ix2Y54w0yVWgPxtM0QNROKlhQaKw35RdTe7TqPw==
X-Received: by 2002:a05:6e02:5ab:b0:2d1:9303:1332 with SMTP id k11-20020a056e0205ab00b002d193031332mr18560323ils.168.1653824228821;
        Sun, 29 May 2022 04:37:08 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id q22-20020a0566380d1600b0032eec10773esm1954886jaj.16.2022.05.29.04.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 04:37:07 -0700 (PDT)
Date:   Sun, 29 May 2022 11:37:06 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Message-ID: <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 04:15:33PM +0800, Rongwei Wang wrote:
> In use cases where allocating and freeing slab frequently, some
> error messages, such as "Left Redzone overwritten", "First byte
> 0xbb instead of 0xcc" would be printed when validating slabs.
> That's because an object has been filled with SLAB_RED_INACTIVE,
> but has not been added to slab's freelist. And between these
> two states, the behaviour of validating slab is likely to occur.
> 
> Actually, it doesn't mean the slab can not work stably. But, these
> confusing messages will disturb slab debugging more or less.
> 
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>

Have you observed it or it's from code inspection?

> ---
>  mm/slub.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ed5c2c03a47a..310e56d99116 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1374,15 +1374,12 @@ static noinline int free_debug_processing(
>  	void *head, void *tail, int bulk_cnt,
>  	unsigned long addr)
>  {
> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>  	void *object = head;
>  	int cnt = 0;
> -	unsigned long flags, flags2;
> +	unsigned long flags;
>  	int ret = 0;
>  
> -	spin_lock_irqsave(&n->list_lock, flags);
> -	slab_lock(slab, &flags2);
> -
> +	slab_lock(slab, &flags);
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>  		if (!check_slab(s, slab))
>  			goto out;
> @@ -1414,8 +1411,7 @@ static noinline int free_debug_processing(
>  		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
>  			 bulk_cnt, cnt);
>  
> -	slab_unlock(slab, &flags2);
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	slab_unlock(slab, &flags);
>  	if (!ret)
>  		slab_fix(s, "Object at 0x%p not freed", object);
>  	return ret;
> @@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  
>  {
>  	void *prior;
> -	int was_frozen;
> +	int was_frozen, to_take_off = 0;
>  	struct slab new;
>  	unsigned long counters;
>  	struct kmem_cache_node *n = NULL;
> @@ -3315,15 +3311,19 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	if (kfence_free(head))
>  		return;
>  
> +	n = get_node(s, slab_nid(slab));
> +	spin_lock_irqsave(&n->list_lock, flags);
> +

Oh please don't do this.

SLUB free slowpath can be hit a lot depending on workload.

__slab_free() try its best not to take n->list_lock. currently takes n->list_lock
only when the slab need to be taken from list.

Unconditionally taking n->list_lock will degrade performance.

>  	if (kmem_cache_debug(s) &&
> -	    !free_debug_processing(s, slab, head, tail, cnt, addr))
> +	    !free_debug_processing(s, slab, head, tail, cnt, addr)) {
> +
> +		spin_unlock_irqrestore(&n->list_lock, flags);
>  		return;
> +	}
>  
>  	do {
> -		if (unlikely(n)) {
> -			spin_unlock_irqrestore(&n->list_lock, flags);
> -			n = NULL;
> -		}
> +		if (unlikely(to_take_off))
> +			to_take_off = 0;
>  		prior = slab->freelist;
>  		counters = slab->counters;
>  		set_freepointer(s, tail, prior);
> @@ -3343,18 +3343,11 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  				new.frozen = 1;
>  
>  			} else { /* Needs to be taken off a list */
> -
> -				n = get_node(s, slab_nid(slab));
>  				/*
> -				 * Speculatively acquire the list_lock.
>  				 * If the cmpxchg does not succeed then we may
> -				 * drop the list_lock without any processing.
> -				 *
> -				 * Otherwise the list_lock will synchronize with
> -				 * other processors updating the list of slabs.
> +				 * drop this behavior without any processing.
>  				 */
> -				spin_lock_irqsave(&n->list_lock, flags);
> -
> +				to_take_off = 1;
>  			}
>  		}
>  
> @@ -3363,8 +3356,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		head, new.counters,
>  		"__slab_free"));
>  
> -	if (likely(!n)) {
> +	if (likely(!to_take_off)) {
>  
> +		spin_unlock_irqrestore(&n->list_lock, flags);
>  		if (likely(was_frozen)) {
>  			/*
>  			 * The list lock was not taken therefore no list
> 
> -- 
> 2.27.0
> 
