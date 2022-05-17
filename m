Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC9D52ACA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbiEQUVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352961AbiEQUVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:21:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DD31DEC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ECCDB81C50
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 20:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A465CC385B8;
        Tue, 17 May 2022 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652818875;
        bh=FUw9l4CEWJbA9/ZM7b1TCp7eWq+8/wCm8DPSvUGG3T4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r4KUhRHhufPM63pNUB6CmLAX4u4xMJo5dlQGS2SMPpOWhshwbXRO/d66JtnfYOO5q
         0LbTnM7jIHPi4aa6j/kxlk+UXIh/KXQQg3C05ODO02/e8MxJcF/08bnl1EUXljw39F
         jFHhuhOAYWqTUAOlF20+Z4IUlmlvWjgvgP2FEh1fS7/st8pxPHfliv6dTXQ7smWUXa
         Fa5ZG0ZxoCVnb6YHe6Rd/cToc11p2hb5gVQHYHsHZOba/yYJ5dlu5IGhB6DYOfQYiD
         JbzxyCcn/muQruVQz2t10S6lUmnVXX4p3emmkDkQvtMm6OHDwZlePrqUtEo+17yyaR
         r+XVcgvdcDJ0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 41A4E5C086D; Tue, 17 May 2022 13:21:15 -0700 (PDT)
Date:   Tue, 17 May 2022 13:21:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220517202115.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com>
 <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 01:12:02PM -0700, John Hubbard wrote:
> On 5/17/22 12:28, Jason Gunthorpe wrote:
> > > If you compare this to the snippet above, you'll see that there is
> > > an extra mov statement, and that one dereferences a pointer from
> > > %rax:
> > > 
> > >      mov    (%rax),%rbx
> > 
> > That is the same move as:
> > 
> >     mov    0x8(%rdx,%rax,8),%rbx
> > 
> > Except that the EA calculation was done in advance and stored in rax.
> > 
> > lea isn't a memory reference, it is just computing the pointer value
> > that 0x8(%rdx,%rax,8) represents. ie the lea computes
> > 
> >    %rax = %rdx + %rax*8 + 6
> > 
> > Which is then fed into the mov. Maybe it is an optimization to allow
> > one pipe to do the shr and an other to the EA - IDK, seems like a
> > random thing for the compiler to do.

Maybe an optimization suppressed due to the volatile nature of the
load?  If so, perhaps it might be considered a compiler bug.  Though
it is quite difficult to get optimization bugs involving volatile
to be taken seriously.

> Apologies for getting that wrong, and thanks for walking me through the
> asm.
> 
> [...]
> > 
> > Paul can correct me, but I understand we do not have a list of allowed
> > operations that are exempted from the READ_ONCE() requirement. ie it
> > is not just conditional branching that requires READ_ONCE().
> > 
> > This is why READ_ONCE() must always be on the memory load, because the
> > point is to sanitize away the uncertainty that comes with an unlocked
> > read of unstable memory contents. READ_ONCE() samples the value in
> > memory, and removes all tearing, multiload, etc "instability" that may
> > effect down stream computations. In this way down stream compulations
> > become reliable.
> > 
> > Jason
> 
> So then:

Works for me!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..b404f87e2682 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
>         word_bitidx = bitidx / BITS_PER_LONG;
>         bitidx &= (BITS_PER_LONG-1);
> 
> -       word = bitmap[word_bitidx];
> +       /*
> +        * This races, without locks, with set_pageblock_migratetype(). Ensure
> +        * a consistent (non-tearing) read of the memory array, so that results,
> +        * even though racy, are not corrupted.
> +        */
> +       word = READ_ONCE(bitmap[word_bitidx]);
>         return (word >> bitidx) & mask;
>  }
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
