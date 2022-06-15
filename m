Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9C54CC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbiFOPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbiFOPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0D366A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22AD66146E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D16C34115;
        Wed, 15 Jun 2022 15:11:15 +0000 (UTC)
Date:   Wed, 15 Jun 2022 16:11:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 3/3] mm/kmemleak: Prevent soft lockup in first object
 iteration loop of kmemleak_scan()
Message-ID: <Yqn2jxZhk5Neomu7@arm.com>
References: <20220614220359.59282-1-longman@redhat.com>
 <20220614220359.59282-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614220359.59282-4-longman@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 06:03:59PM -0400, Waiman Long wrote:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 7dd64139a7c7..abba063ae5ee 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1417,12 +1417,16 @@ static void kmemleak_scan(void)
>  	struct zone *zone;
>  	int __maybe_unused i;
>  	int new_leaks = 0;
> +	int loop1_cnt = 0;
>  
>  	jiffies_last_scan = jiffies;
>  
>  	/* prepare the kmemleak_object's */
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(object, &object_list, object_list) {
> +		bool obj_pinned = false;
> +
> +		loop1_cnt++;
>  		raw_spin_lock_irq(&object->lock);
>  #ifdef DEBUG
>  		/*
> @@ -1437,10 +1441,32 @@ static void kmemleak_scan(void)
>  #endif
>  		/* reset the reference count (whiten the object) */
>  		object->count = 0;
> -		if (color_gray(object) && get_object(object))
> +		if (color_gray(object) && get_object(object)) {
>  			list_add_tail(&object->gray_list, &gray_list);
> +			obj_pinned = true;
> +		}
>  
>  		raw_spin_unlock_irq(&object->lock);
> +
> +		/*
> +		 * Do a cond_resched() to avoid soft lockup every 64k objects.
> +		 * Make sure a reference has been taken so that the object
> +		 * won't go away without RCU read lock.
> +		 */
> +		if (!(loop1_cnt & 0xffff)) {
> +			if (!obj_pinned && !get_object(object)) {
> +				/* Try the next object instead */
> +				loop1_cnt--;
> +				continue;
> +			}

With this trick we could probably get rid of rcu_read_lock() and take
the kmemleak_lock instead. But that's for another patch.

> +
> +			rcu_read_unlock();
> +			cond_resched();
> +			rcu_read_lock();

cond_resched_rcu() to save a couple of lines?

> +
> +			if (!obj_pinned)
> +				put_object(object);
> +		}

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.
