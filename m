Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0054B7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350611AbiFNR2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346818AbiFNR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:28:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5999636E08
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12B66B81A25
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36EEC3411B;
        Tue, 14 Jun 2022 17:28:00 +0000 (UTC)
Date:   Tue, 14 Jun 2022 18:27:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/kmemleak: Prevent soft lockup in first object
 iteration loop of kmemleak_scan()
Message-ID: <YqjFHOMT+rDgz3EK@arm.com>
References: <20220612183301.981616-1-longman@redhat.com>
 <20220612183301.981616-4-longman@redhat.com>
 <YqjCGWmM2cGG1OOF@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqjCGWmM2cGG1OOF@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 06:15:14PM +0100, Catalin Marinas wrote:
> On Sun, Jun 12, 2022 at 02:33:01PM -0400, Waiman Long wrote:
> > @@ -1437,10 +1440,25 @@ static void kmemleak_scan(void)
> >  #endif
> >  		/* reset the reference count (whiten the object) */
> >  		object->count = 0;
> > -		if (color_gray(object) && get_object(object))
> > +		if (color_gray(object) && get_object(object)) {
> >  			list_add_tail(&object->gray_list, &gray_list);
> > +			gray_list_cnt++;
> > +			object_pinned = true;
> > +		}
> >  
> >  		raw_spin_unlock_irq(&object->lock);
> > +
> > +		/*
> > +		 * With object pinned by a positive reference count, it
> > +		 * won't go away and we can safely release the RCU read
> > +		 * lock and do a cond_resched() to avoid soft lockup every
> > +		 * 64k objects.
> > +		 */
> > +		if (object_pinned && !(gray_list_cnt & 0xffff)) {
> > +			rcu_read_unlock();
> > +			cond_resched();
> > +			rcu_read_lock();
> > +		}
> 
> I'm not sure this gains much. There should be very few gray objects
> initially (those passed to kmemleak_not_leak() for example). The
> majority should be white objects.
> 
> If we drop the fine-grained object->lock, we could instead take
> kmemleak_lock outside the loop with a cond_resched_lock(&kmemleak_lock)
> within the loop. I think we can get away with not having an
> rcu_read_lock() at all for list traversal with the big lock outside the
> loop.

Actually this doesn't work is the current object in the iteration is
freed. Does list_for_each_rcu_safe() help?

-- 
Catalin
