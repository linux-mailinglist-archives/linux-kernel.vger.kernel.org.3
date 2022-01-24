Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC39849850F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbiAXQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:43:35 -0500
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:59367 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243843AbiAXQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:43:32 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 2287CFA9C7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:43:31 +0000 (GMT)
Received: (qmail 22301 invoked from network); 24 Jan 2022 16:43:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Jan 2022 16:43:30 -0000
Date:   Mon, 24 Jan 2022 16:43:29 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Eric Ren <renzhengeek@gmail.com>
Subject: Re: [PATCH v4 1/7] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
Message-ID: <20220124164329.GF3366@techsingularity.net>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-2-zi.yan@sent.com>
 <20220124140203.GE3366@techsingularity.net>
 <06467F5D-25F9-42DC-9FEC-6559E6058D01@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <06467F5D-25F9-42DC-9FEC-6559E6058D01@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:12:07AM -0500, Zi Yan wrote:
> On 24 Jan 2022, at 9:02, Mel Gorman wrote:
> 
> > On Wed, Jan 19, 2022 at 02:06:17PM -0500, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> >> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> >> requirement for CMA and alloc_contig_range().
> >>
> >> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> >> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> >> Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>
> >> <SNIP>
> >>
> >> @@ -2484,6 +2483,7 @@ static int fallbacks[MIGRATE_TYPES][3] = {
> >>  	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
> >>  	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
> >>  	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
> >> +	[MIGRATE_HIGHATOMIC] = { MIGRATE_TYPES }, /* Never used */
> >>  #ifdef CONFIG_CMA
> >>  	[MIGRATE_CMA]         = { MIGRATE_TYPES }, /* Never used */
> >>  #endif
> >
> > If it's never used, why is it added?
> 
> Just to make the fallbacks list complete, since MIGRATE_CMA and
> MIGRATE_ISOLATE are in the list. Instead, I can remove MIGRATE_CMA and
> MIGRATE_ISOLATE. WDYT?
> 

It probably makes more sense to remove them or replace them with a comment
stating what migratetypes do not have a fallback list. Do it as a separate
patch that stands alone. It does not need to be part of this series.

-- 
Mel Gorman
SUSE Labs
