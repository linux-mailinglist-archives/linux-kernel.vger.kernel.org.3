Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D9C49819B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiAXOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:02:08 -0500
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:46560 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238037AbiAXOCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:02:06 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id BC765C0C90
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:02:05 +0000 (GMT)
Received: (qmail 12616 invoked from network); 24 Jan 2022 14:02:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Jan 2022 14:02:05 -0000
Date:   Mon, 24 Jan 2022 14:02:03 +0000
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
Message-ID: <20220124140203.GE3366@techsingularity.net>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220119190623.1029355-2-zi.yan@sent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:06:17PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> requirement for CMA and alloc_contig_range().
> 
> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
> 
> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> <SNIP>
>
> @@ -2484,6 +2483,7 @@ static int fallbacks[MIGRATE_TYPES][3] = {
>  	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
>  	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
>  	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
> +	[MIGRATE_HIGHATOMIC] = { MIGRATE_TYPES }, /* Never used */
>  #ifdef CONFIG_CMA
>  	[MIGRATE_CMA]         = { MIGRATE_TYPES }, /* Never used */
>  #endif

If it's never used, why is it added?

Otherwise looks fine so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
