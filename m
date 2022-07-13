Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E21573406
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiGMKWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGMKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:22:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5CAF6B93
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:22:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso2831283pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b5jq6UrVYBVqTLSb/d0xvUYQZH0h9wR5dakglSUgaZ8=;
        b=g5alBPtl1kiyK40iPkwyzCu6yFxh7PyJi6pFAkN61ulSqzjmelFtm6FtAkcCHes8kr
         daHxnuWSUSt12V/BhanrKNNmulx6+YXEgoQ2xxvvtaSWTlyhAqPR6mDbWMdWsFmDi9ee
         XuIhEH2ImnQ3v86iRJJLk+NzMej2G5icsNTuyxklpvTzxh6n6M4zzyAV7ydjNxufDRCy
         LvuHJu+aK8xB5AoXBTLUf9HBRmBwnglYQ/WMXHBxpWFcetDRVDDFUowrBZYqpRUN46px
         +h6hZOtJIv43kaBPGAd5+Eq9FCgkOXlmsWJyoU+sj0cvlvJ+Tpg3kalj2gUJLRpiXIUe
         hkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5jq6UrVYBVqTLSb/d0xvUYQZH0h9wR5dakglSUgaZ8=;
        b=wU0m6JfI4b1xfvFnF3pjMj7BdGNI6BBv6GcSdGSWvHcwd4SB1oNkOrUwvLekbiO9Bm
         TDLn9yOSA3UaztPS7ujdIMxUcgcPvrjj8j4z85fJJ8nIwzi8lwSX+sXYMKaUpELUHjbL
         qek+S6BFS6LA5/GCxNzKO01tyOWBRwT1ezE+zwov8Ou15kn6z2/dUtaBnSZv1RqOJ4yd
         Tqfmy0MPF1Z1l8K+iOMZR7RtRxSByAQh7o0LveJtAD4KBuqHNnN+qpgS57kqdHEc6XEV
         /ALeX/CCa93z3ZEOrET/eNUy5C8D0q1HfBcVTCzSSnAKz8kC4w3GMbQG3wIzL9Paaebj
         6g6w==
X-Gm-Message-State: AJIora8zZ9ujZaJSAGt9kXxp39tl03HOjOIbii9zOrv2UIrSlNgKugKh
        2N+WXkBzps32ZY8R2ytEnbk=
X-Google-Smtp-Source: AGRyM1sPq8ed9TwVbIZY8O2QeLWLmXL4AdxvDg5qyTxSxy5AwpGCuydUo80OlrN8cbqH0AwqqhUH4g==
X-Received: by 2002:a17:902:e842:b0:16c:5639:eb3e with SMTP id t2-20020a170902e84200b0016c5639eb3emr2846227plg.119.1657707727826;
        Wed, 13 Jul 2022 03:22:07 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-77-58-189.ap-northeast-1.compute.amazonaws.com. [35.77.58.189])
        by smtp.gmail.com with ESMTPSA id pi4-20020a17090b1e4400b001df264610c4sm6129791pjb.0.2022.07.13.03.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 03:22:06 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:22:02 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@gentwo.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Message-ID: <Ys6cymrtnHNlCDG9@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:28:05AM +0800, Rongwei Wang wrote:
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
> ---
>  mm/slub.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>

This makes the code more complex.

A part of me says it may be more pleasant to split implementation
allocating from caches for debugging. That would make it simpler.

something like:

__slab_alloc() {
	if (kmem_cache_debug(s))
		slab_alloc_debug()
	else
		___slab_alloc()
}

slab_free() {
	if (kmem_cache_debug(s))
		slab_free_debug()
	else
		__do_slab_free()
}

See also:
	https://lore.kernel.org/lkml/faf416b9-f46c-8534-7fb7-557c046a564d@suse.cz/

> diff --git a/mm/slub.c b/mm/slub.c
> index b1281b8654bd..e950d8df8380 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1391,18 +1391,16 @@ static noinline int free_debug_processing(
>  	void *head, void *tail, int bulk_cnt,
>  	unsigned long addr)
>  {
> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>  	void *object = head;
>  	int cnt = 0;
> -	unsigned long flags, flags2;
> +	unsigned long flags;
>  	int ret = 0;
>  	depot_stack_handle_t handle = 0;
>  
>  	if (s->flags & SLAB_STORE_USER)
>  		handle = set_track_prepare();
>  
> -	spin_lock_irqsave(&n->list_lock, flags);
> -	slab_lock(slab, &flags2);
> +	slab_lock(slab, &flags);
>  
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>  		if (!check_slab(s, slab))
> @@ -1435,8 +1433,7 @@ static noinline int free_debug_processing(
>  		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
>  			 bulk_cnt, cnt);
>  
> -	slab_unlock(slab, &flags2);
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	slab_unlock(slab, &flags);
>  	if (!ret)
>  		slab_fix(s, "Object at 0x%p not freed", object);
>  	return ret;
> @@ -3330,7 +3327,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  
>  {
>  	void *prior;
> -	int was_frozen;
> +	int was_frozen, to_take_off = 0;
>  	struct slab new;
>  	unsigned long counters;
>  	struct kmem_cache_node *n = NULL;
> @@ -3341,14 +3338,23 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	if (kfence_free(head))
>  		return;
>  
> -	if (kmem_cache_debug(s) &&
> -	    !free_debug_processing(s, slab, head, tail, cnt, addr))
> -		return;
> +	n = get_node(s, slab_nid(slab));
> +	if (kmem_cache_debug(s)) {
> +		int ret;
>  
> -	do {
> -		if (unlikely(n)) {
> +		spin_lock_irqsave(&n->list_lock, flags);
> +		ret = free_debug_processing(s, slab, head, tail, cnt, addr);
> +		if (!ret) {
>  			spin_unlock_irqrestore(&n->list_lock, flags);
> -			n = NULL;
> +			return;
> +		}
> +	}
> +
> +	do {
> +		if (unlikely(to_take_off)) {
> +			if (!kmem_cache_debug(s))
> +				spin_unlock_irqrestore(&n->list_lock, flags);
> +			to_take_off = 0;
>  		}
>  		prior = slab->freelist;
>  		counters = slab->counters;
> @@ -3369,8 +3375,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  				new.frozen = 1;
>  
>  			} else { /* Needs to be taken off a list */
> -
> -				n = get_node(s, slab_nid(slab));
>  				/*
>  				 * Speculatively acquire the list_lock.
>  				 * If the cmpxchg does not succeed then we may
> @@ -3379,8 +3383,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  				 * Otherwise the list_lock will synchronize with
>  				 * other processors updating the list of slabs.
>  				 */
> -				spin_lock_irqsave(&n->list_lock, flags);
> +				if (!kmem_cache_debug(s))
> +					spin_lock_irqsave(&n->list_lock, flags);
>  
> +				to_take_off = 1;
>  			}
>  		}
>  
> @@ -3389,8 +3395,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		head, new.counters,
>  		"__slab_free"));
>  
> -	if (likely(!n)) {
> -
> +	if (likely(!to_take_off)) {
> +		if (kmem_cache_debug(s))
> +			spin_unlock_irqrestore(&n->list_lock, flags);
>  		if (likely(was_frozen)) {
>  			/*
>  			 * The list lock was not taken therefore no list
> -- 
> 2.27.0
> 
