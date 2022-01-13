Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7848D6C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiAMLhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:37:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54184 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAMLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:36:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A39A608CC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E819C36AE3;
        Thu, 13 Jan 2022 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642073818;
        bh=+YT0N1Ya5C3GpxZb3D9lx91/TA7aYugOCM+xLuWjYus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8pNbom+not22khASxC0ueT85weSmm7kwqI+jqij2ZQjNxusyGBuws6c2xcGeS2aN
         9swZkNa2lHT+EqUFoHcqwscUUVPriy4Cm4fAIQjZLWNlg7hI9+AtHC/h6in4aJ2vRs
         7WBuPU+LvQc6MavLpwW30LJ5V1WHuEA17r/aBUHfdlyYbe4rxmup5KWNk0YUJhq6A4
         1fcD63FjDJCSMo+Po0f1aEVflhmsnSpMVI2j8jOkqcPkWMfP5sHyJP3P/iYTWNcU9P
         LXw/TsOnQN4ucHQJqihS6vgO2Ure2XIVDeeLBPlAh/jMjE6BsbJrJyGGEzGtqUOOm+
         bwsfmuQCDueEQ==
Date:   Thu, 13 Jan 2022 13:36:50 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
Subject: Re: [RFC PATCH v3 1/8] mm: page_alloc: avoid merging
 non-fallbackable pageblocks with others.
Message-ID: <YeAO0vtyjWWMRliF@kernel.org>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-2-zi.yan@sent.com>
 <7dc078ef-70f4-159e-b928-34f0fb0ffaea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dc078ef-70f4-159e-b928-34f0fb0ffaea@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:54:49AM +0100, David Hildenbrand wrote:
> On 05.01.22 22:47, Zi Yan wrote:
> > From: Zi Yan <ziy@nvidia.com>
> > 
> > This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> > It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> > requirement for CMA and alloc_contig_range().
> > 
> > MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> > MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> > Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
> > 
> > [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> > 
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > ---
> >  include/linux/mmzone.h |  6 ++++++
> >  mm/page_alloc.c        | 28 ++++++++++++++++++----------
> >  2 files changed, 24 insertions(+), 10 deletions(-)
> > 

...

> > @@ -3545,8 +3553,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
> >  		struct page *endpage = page + (1 << order) - 1;
> >  		for (; page < endpage; page += pageblock_nr_pages) {
> >  			int mt = get_pageblock_migratetype(page);
> > -			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
> > -			    && !is_migrate_highatomic(mt))
> > +			/* Only change normal pageblock */
> > +			if (migratetype_has_fallback(mt))
> >  				set_pageblock_migratetype(page,
> >  							  MIGRATE_MOVABLE);
> >  		}
> 
> That part is a nice cleanup IMHO. Although the "has fallback" part is a
> bit imprecise. "migratetype_is_mergable()" might be a bit clearer.
> ideally "migratetype_is_mergable_with_other_types()". Can we come up
> with a nice name for that?

migratetype_is_mergable() kinda implies "_with_other_types", no?

I like migratetype_is_mergable() more than _has_fallback().

My $0.02 to bikeshedding :)
 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.
