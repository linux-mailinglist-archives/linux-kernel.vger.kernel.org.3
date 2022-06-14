Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE054B6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351452AbiFNQyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350089AbiFNQym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:54:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C693
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F58B817BF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33368C3411B;
        Tue, 14 Jun 2022 16:54:36 +0000 (UTC)
Date:   Tue, 14 Jun 2022 17:54:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/kmemleak: Skip unlikely objects in
 kmemleak_scan() without taking lock
Message-ID: <Yqi9SP2HZ4dlQOWG@arm.com>
References: <20220612183301.981616-1-longman@redhat.com>
 <20220612183301.981616-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612183301.981616-3-longman@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:33:00PM -0400, Waiman Long wrote:
> With a debug kernel running on a 2-socket 96-thread x86-64 system
> (HZ=1000), the 2nd and 3rd iteration loops speedup with this patch on
> the first kmemleak_scan() call after bootup is shown in the table below.
> 
>                    Before patch                    After patch
>   Loop #    # of objects  Elapsed time     # of objects  Elapsed time
>   ------    ------------  ------------     ------------  ------------
>     2        2,599,850      2.392s          2,596,364       0.266s
>     3        2,600,176      2.171s          2,597,061       0.260s
> 
> This patch reduces loop iteration times by about 88%. This will greatly
> reduce the chance of a soft lockup happening in the 2nd or 3rd iteration
> loops.

Nice numbers, thanks for digging into this.

But I'm slightly surprised that the first loop doesn't cause any
problems.

> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index dad9219c972c..7dd64139a7c7 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1508,6 +1508,13 @@ static void kmemleak_scan(void)
>  	 */
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(object, &object_list, object_list) {
> +		/*
> +		 * This is racy but we can save the overhead of lock/unlock
> +		 * calls. The missed objects, if any, should be caught in
> +		 * the next scan.
> +		 */
> +		if (!color_white(object))
> +			continue;
>  		raw_spin_lock_irq(&object->lock);
>  		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
>  		    && update_checksum(object) && get_object(object)) {

It's not actually scanning (like tree look-ups) but only updating the
checksum of the potentially orphan objects. If the problem is caused by
object->lock, we should have seen it with the first loop as well.

It is possible that some large list is occasionally missed if there are
concurrent updates and a significant number of objects turn up "white",
forcing the checksum update. Otherwise this shouldn't be much different
from the first loop if there are no massive (false) leaks.

I think the race on color_white() can only be with a kmemleak_ignore()
or kmemleak_not_leak() call, otherwise the object colour shouldn't be
changed. So such objects can only turn from white to gray or black, so
the race I think is safe.

> @@ -1535,6 +1542,13 @@ static void kmemleak_scan(void)
>  	 */
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(object, &object_list, object_list) {
> +		/*
> +		 * This is racy but we can save the overhead of lock/unlock
> +		 * calls. The missed objects, if any, should be caught in
> +		 * the next scan.
> +		 */
> +		if (!color_white(object))
> +			continue;
>  		raw_spin_lock_irq(&object->lock);
>  		if (unreferenced_object(object) &&
>  		    !(object->flags & OBJECT_REPORTED)) {

Same here.

I did wonder whether it's worth keeping object->lock around, I even have
a stashed patch lying around from 2019. Instead we'd have the big
kmemleak_lock held for longer, though released periodically during
scanning. We can then move the lock outside the loop and traversal would
be faster but with an increased latency on slab allocation/freeing on
other CPUs. Right now we take the kmemleak_lock when scanning a single
block (e.g. object) to protect the rb-tree and rely on object->lock to
ensure the object isn't freed. Other concurrent allocs/frees would only
be blocked during single object scanning.

Anyway, I'm not entirely sure it's the lock causing the issue as we
don't see it with the first loop. I'm more inclined to think it's the
checksum and the skipping if !color_white() would do the trick.

Unless there's a better idea:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
