Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFB489D75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbiAJQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:25:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbiAJQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:25:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C262C1F393;
        Mon, 10 Jan 2022 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641831916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7C3iBFO6mPZG0zqznbI9unOua16tjFDplhQ2oT/yec=;
        b=DQBwKbxwJZEyQg10FCROT+HMkMX/2RAAibSv0z8ACXSJtgY9OdtKzOSdJIOVMoHvfJqI9X
        /RlcxZJdjiCsps9h11Hji2qnDEXcFPStpt9VuWTgk2zXTUvh8rh6hZ33fEfBJ5kBXTPzBo
        377kRe33OmnPdldc821hy8euxse9hpM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EDB44A3B88;
        Mon, 10 Jan 2022 16:25:15 +0000 (UTC)
Date:   Mon, 10 Jan 2022 17:25:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <Ydxd6zHs2uR5mNnn@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <YdxKORU9OWCv114O@dhcp22.suse.cz>
 <8edfd643-888b-fbe6-97c0-21f900767c27@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edfd643-888b-fbe6-97c0-21f900767c27@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-01-22 17:01:07, Vlastimil Babka wrote:
> On 1/10/22 16:01, Michal Hocko wrote:
> > On Thu 06-01-22 17:12:18, Michal Hocko wrote:
> >> On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> >> > +static struct lru_gen_mm_walk *alloc_mm_walk(void)
> >> > +{
> >> > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> >> > +		return kvzalloc(sizeof(struct lru_gen_mm_walk), GFP_KERNEL);
> > 
> > One thing I have overlooked completely. You cannot really use GFP_KERNEL
> > allocation here because the reclaim context can be constrained (e.g.
> > GFP_NOFS). This allocation will not do any reclaim as it is PF_MEMALLOC
> > but I suspect that the lockdep will complain anyway.
> > 
> > Also kvmalloc is not really great here. a) vmalloc path is never
> > executed for small objects and b) we do not really want to make a
> > dependency between vmalloc and the reclaim (by vmalloc -> reclaim ->
> > vmalloc).
> > 
> > Even if we rule out vmalloc and look at kmalloc alone. Is this really
> > safe? I do not see any recursion prevention in the SL.B code. Maybe this
> > just happens to work but the dependency should be really documented so
> > that future SL.B changes won't break the whole scheme. 
> 
> Slab implementations drop all locks before calling into page allocator (thus
> possibly reclaim) so slab itself should be fine and I don't expect it to
> change. But we could eventually reach the page allocator recursively again,
> that's true and not great.

Thanks for double checking. If recursion is really intended and
something SL.B allocators should support then this is definitely worth
documenting so that a subtle change won't break in the future. 

-- 
Michal Hocko
SUSE Labs
