Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38DE4630B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbhK3KMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:12:16 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:39467 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240550AbhK3KMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:12:15 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 9B3181E40
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:08:55 +0000 (GMT)
Received: (qmail 25169 invoked from network); 30 Nov 2021 10:08:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Nov 2021 10:08:55 -0000
Date:   Tue, 30 Nov 2021 10:08:53 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 0/3] Use pageblock_order for cma and
 alloc_contig_range alignment.
Message-ID: <20211130100853.GP3366@techsingularity.net>
References: <20211115193725.737539-1-zi.yan@sent.com>
 <3083463d-978b-fbe6-dadf-670d400ed437@suse.cz>
 <AEFF28CF-0ED8-450F-96A4-A6CD59CB1F3D@nvidia.com>
 <BF8FB68A-6E1D-4465-8A2B-884FC034660B@nvidia.com>
 <52dbf824-76be-cc34-3983-d45510b1b618@suse.cz>
 <35A20739-152A-450E-8535-2236D2B28748@nvidia.com>
 <1c67bb96-24db-f5a6-7520-3d97e54e5192@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1c67bb96-24db-f5a6-7520-3d97e54e5192@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:11:36AM +0100, Vlastimil Babka wrote:
> >>> I find that two pageblocks with different migratetypes, like MIGRATE_RECLAIMABLE
> >>> and MIGRATE_MOVABLE can be merged into a single free page after I checked
> >>> __free_one_page() in detail and printed pageblock information during buddy page
> >>> merging.
> >>
> >> Yes, that can happen.
> >>
> >> I am not sure what consequence it will cause. Do you have any idea?
> >>
> >> For MIGRATE_RECLAIMABLE or MIGRATE_MOVABLE or even MIGRATE_UNMOVABLE it's
> >> absolutely fine. As long as these pageblocks are fully free (and they are if
> >> it's a single free page spanning 2 pageblocks), they can be of any of these
> >> type, as they can be reused as needed without causing fragmentation.
> >>
> >> But in case of MIGRATE_CMA and MIGRATE_ISOLATE, uncontrolled merging would
> >> break the specifics of those types. That's why the code is careful for
> >> MIGRATE_ISOLATE, and MIGRATE_CMA was until now done in MAX_ORDER granularity.
> > 
> > Thanks for the explanation. Basically migratetypes that can fall back to each
> > other can be merged into a single free page, right?
> 
> Yes.
> 
> > How about MIGRATE_HIGHATOMIC? It should not be merged with other migratetypes
> > from my understanding.
> 
> Hmm it shouldn't minimally because it has an accounting that would become
> broken. So it should prevent merging or make sure the reservations are with
> MAX_ORDER granularity, but seems that neither is true? CCing Mel.
> 

MIGRATE_HIGHATOMIC pageblocks can have pages allocated of different
types, particularly UNMOVABLE and potentially RECLAIMABLE. The
reserving or releasing MIGRATE_HIGHATOMIC pageblocks should be done with
reserve_highatomic_pageblock and unreserve_highatomic_pageblock to get
the accounting right.

However, there does not appear to be any special protection against a
page in a highatomic pageblock getting merged with a buddy of another
pageblock type. The pageblock would still have the right setting but on
allocation, the pages could split to the wrong free list and be lost
until the pages belonging to MIGRATE_HIGHATOMIC were freed again.

Not sure how much of a problem that is in practice, it's been a while
since I've heard of high-order atomic allocation failures.

-- 
Mel Gorman
SUSE Labs
