Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454EE54B76D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiFNRPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFNRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:15:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8926421265
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD087CE1B7B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662CFC3411B;
        Tue, 14 Jun 2022 17:15:09 +0000 (UTC)
Date:   Tue, 14 Jun 2022 18:15:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/kmemleak: Prevent soft lockup in first object
 iteration loop of kmemleak_scan()
Message-ID: <YqjCGWmM2cGG1OOF@arm.com>
References: <20220612183301.981616-1-longman@redhat.com>
 <20220612183301.981616-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612183301.981616-4-longman@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:33:01PM -0400, Waiman Long wrote:
> @@ -1437,10 +1440,25 @@ static void kmemleak_scan(void)
>  #endif
>  		/* reset the reference count (whiten the object) */
>  		object->count = 0;
> -		if (color_gray(object) && get_object(object))
> +		if (color_gray(object) && get_object(object)) {
>  			list_add_tail(&object->gray_list, &gray_list);
> +			gray_list_cnt++;
> +			object_pinned = true;
> +		}
>  
>  		raw_spin_unlock_irq(&object->lock);
> +
> +		/*
> +		 * With object pinned by a positive reference count, it
> +		 * won't go away and we can safely release the RCU read
> +		 * lock and do a cond_resched() to avoid soft lockup every
> +		 * 64k objects.
> +		 */
> +		if (object_pinned && !(gray_list_cnt & 0xffff)) {
> +			rcu_read_unlock();
> +			cond_resched();
> +			rcu_read_lock();
> +		}

I'm not sure this gains much. There should be very few gray objects
initially (those passed to kmemleak_not_leak() for example). The
majority should be white objects.

If we drop the fine-grained object->lock, we could instead take
kmemleak_lock outside the loop with a cond_resched_lock(&kmemleak_lock)
within the loop. I think we can get away with not having an
rcu_read_lock() at all for list traversal with the big lock outside the
loop.

The reason I added it in the first kmemleak incarnation was to defer
kmemleak_object freeing as it was causing a re-entrant call into the
slab allocator. I later went for fine-grained locking and RCU list
traversal but I may have overdone it ;).

-- 
Catalin
