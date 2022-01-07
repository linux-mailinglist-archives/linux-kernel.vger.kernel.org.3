Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14115487454
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbiAGIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:55:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57262 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346229AbiAGIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:55:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 27E4321126;
        Fri,  7 Jan 2022 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641545709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsH9bvGYmcoVLtgyOeudSiXiKCPWiynwrsli+B3sPnQ=;
        b=UP1E+5z3SkIzHd+AgFvtKhkj1igIXiPHVg/zKRG/6JCEPDtSsv/kAIQ8PFbHCkl0nCi/br
        hjj1L7x0eW/vzawzbR1Q4qKP+0Qrv/i533npRsABif8OOsXzQmjRYZWVA6IXXt2+j1B7Zd
        bSMWFbCfwgwfJ7VkTFpFlJvSnhKWG8E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6642DA3B91;
        Fri,  7 Jan 2022 08:55:08 +0000 (UTC)
Date:   Fri, 7 Jan 2022 09:55:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <Ydf/7DDu94fMs0CG@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <Yddh+APQGg8dKRgw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yddh+APQGg8dKRgw@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-01-22 14:41:12, Yu Zhao wrote:
> On Thu, Jan 06, 2022 at 05:12:16PM +0100, Michal Hocko wrote:
> > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > > +static struct lru_gen_mm_walk *alloc_mm_walk(void)
> > > +{
> > > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> > > +		return kvzalloc(sizeof(struct lru_gen_mm_walk), GFP_KERNEL);
> > > +
> > > +	return current->reclaim_state->mm_walk;
> > > +}
> > > +
> > > +static void free_mm_walk(struct lru_gen_mm_walk *walk)
> > > +{
> > > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> > > +		kvfree(walk);
> > > +}
> > 
> > Do I get it right that you are allocating from the reclaim context? What
> > prevents this to completely deplete the memory as the reclaim context is
> > PF_MEMALLOC?
> 
> Yes, and in general the same reason zram/zswap/etc. allocate memory in
> the reclaim context: to make more free memory.

I have to admit that I am not really familiar with zram/zswap but I find
the concept of requiring memory to do the reclaim really problematic.
 
> In this case, lru_gen_mm_walk is small (160 bytes); it's per direct
> reclaimer; and direct reclaimers rarely come here, i.e., only when
> kswapd can't keep up in terms of the aging, which is similar to the
> condition where the inactive list is empty for the active/inactive
> lru.

Well, this is not a strong argument to be honest. Kswapd being stuck
and the majority of the reclaim being done in the direct reclaim
context is a situation I have seen many many times. We used to have
problems with direct reclaimers throttling to prevent an over eager OOM
situations.

Have you considered using a pool of preallocated objects instead?
-- 
Michal Hocko
SUSE Labs
