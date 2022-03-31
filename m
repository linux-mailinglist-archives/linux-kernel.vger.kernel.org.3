Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA69D4ED190
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352492AbiCaCQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiCaCQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6543D1E1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBAC461964
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F497C340EE;
        Thu, 31 Mar 2022 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648692881;
        bh=l1qjXlV910SQvhBABrcXr3WHKwXfDb6DJqrt+F179IU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y7q7P79T6brRykBtLstI9JRhnXkdDRsxcDTObnE6HicO9gaZ8FLo/f4lc7lT0ecMf
         AKPTOLxMjR7KzODRCQBXtr7eztYD53LQsnGjNAaFtFM8xCzfPqFxPj65irh2UDy3mi
         RyXgoMf6w1UIFKOojDOFg4XlukfmKFJO10RHYEPg=
Date:   Wed, 30 Mar 2022 19:14:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in
 memcg_reparent_list_lru_node()
Message-Id: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org>
In-Reply-To: <20220330172646.2687555-1-longman@redhat.com>
References: <20220330172646.2687555-1-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 13:26:46 -0400 Waiman Long <longman@redhat.com> wrote:

> Muchun Song found out there could be a race between list_lru_add()
> and memcg_reparent_list_lru_node() causing the later function to miss
> reparenting of a lru entry as shown below:
> 
> CPU0:                           CPU1:
> list_lru_add()
>     spin_lock(&nlru->lock)
>     l = list_lru_from_kmem(memcg)
>                                 memcg_reparent_objcgs(memcg)
>                                 memcg_reparent_list_lrus(memcg)
>                                     memcg_reparent_list_lru()
>                                         memcg_reparent_list_lru_node()
>                                             if (!READ_ONCE(nlru->nr_items))
>                                                 // Miss reparenting
>                                                 return
>     // Assume 0->1
>     l->nr_items++
>     // Assume 0->1
>     nlru->nr_items++
> 
> Though it is not likely that a list_lru_node that has 0 item suddenly
> has a newly added lru entry at the end of its life. The race is still
> theoretically possible.
> 
> With the lock/unlock pair used within the percpu_ref_kill() which is
> the last function call of memcg_reparent_objcgs(), any read issued
> in memcg_reparent_list_lru_node() will not be reordered before the
> reparenting of objcgs.
> 
> Adding a !spin_is_locked()/smp_rmb()/!READ_ONCE(nlru->nr_items) check
> to ensure that either the reading of nr_items is valid or the racing
> list_lru_add() will see the reparented objcg.
> 
> ...
>
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -395,10 +395,33 @@ static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
>  	struct list_lru_one *src, *dst;
>  
>  	/*
> -	 * If there is no lru entry in this nlru, we can skip it immediately.
> +	 * With the lock/unlock pair used within the percpu_ref_kill()
> +	 * which is the last function call of memcg_reparent_objcgs(), any
> +	 * read issued here will not be reordered before the reparenting
> +	 * of objcgs.
> +	 *
> +	 * Assuming a racing list_lru_add():
> +	 * list_lru_add()
> +	 *				<- memcg_reparent_list_lru_node()
> +	 *   spin_lock(&nlru->lock)
> +	 *   l = list_lru_from_kmem(memcg)
> +	 *   nlru->nr_items++
> +	 *   spin_unlock(&nlru->lock)
> +	 *				<- memcg_reparent_list_lru_node()
> +	 *
> +	 * The !spin_is_locked(&nlru->lock) check is true means it is
> +	 * either before the spin_lock() or after the spin_unlock(). In the
> +	 * former case, list_lru_add() will see the reparented objcg and so
> +	 * won't touch the lru to be reparented. In the later case, it will
> +	 * see the updated nr_items. So we can use the optimization that if
> +	 * there is no lru entry in this nlru, skip it immediately.
>  	 */
> -	if (!READ_ONCE(nlru->nr_items))
> -		return;
> +	if (!spin_is_locked(&nlru->lock)) {

ick.

> +		/* nr_items read must be ordered after nlru->lock */
> +		smp_rmb();
> +		if (!READ_ONCE(nlru->nr_items))
> +			return;
> +	}

include/linux/spinlock_up.h has

#define arch_spin_is_locked(lock)	((void)(lock), 0)

so this `if' will always be true on CONFIG_SMP=n.  Will the kernel
still work?

At the very least let's have changelogging and commenting explaining
that we've actually thought about this.

Preferably, can we fix this hole properly and avoid this hack?  There is
a reason for this:

hp2:/usr/src/25> grep spin_is_locked mm/*.c
hp2:/usr/src/25> 


