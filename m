Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43D749B4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576710AbiAYNZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:25:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37748 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576139AbiAYNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:20:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C010621129;
        Tue, 25 Jan 2022 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643116788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7ugEwGd8z1ciGcssO9NOuo6Y70kmTmAuz+RVBNhgQo=;
        b=OAQFnCJ9fJXwRf+XqgaH8z+GcXVjo9HxXhbpGWNi3xMFKm4awPudNVTJaJaXXs1dSxQj1I
        /htMCb/jE9Jo8zsCT8DVooqvtd6XAyQmf3X5bQaNYmHaXyRhOYiGujXcl4ae/nW4gqHHZG
        iIctFqchskLEpoSkcCX/nH6b9I06d44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643116788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7ugEwGd8z1ciGcssO9NOuo6Y70kmTmAuz+RVBNhgQo=;
        b=URWUxsOGxCPGESRThyQ7b2f2CoH5apJnVqlsxfRb5qW9qyCiYDfA7/lidO7XlY8xzuv09P
        oqD7gCa//062VVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F330613DE5;
        Tue, 25 Jan 2022 13:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TzS6OPP472GbRwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 25 Jan 2022 13:19:47 +0000
Date:   Tue, 25 Jan 2022 14:19:46 +0100
From:   Oscar Salvador <osalvador@suse.de>
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
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
Subject: Re: [PATCH v4 3/7] mm: page_isolation: check specified range for
 unmovable pages
Message-ID: <20220125131943.GA5609@linux>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-4-zi.yan@sent.com>
 <b7c311d4b2cd377cdc4f92bc9ccf6af1@suse.de>
 <6AEF32AC-4E0D-41E0-8850-33B8BD955920@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6AEF32AC-4E0D-41E0-8850-33B8BD955920@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:17:23PM -0500, Zi Yan wrote:
> You are right. Sorry for the confusion. I think it should be
> “Page isolation is done at least on max(MAX_ORDER_NR_PAEGS,
> pageblock_nr_pages) granularity.”
> 
> memory_hotplug uses PAGES_PER_SECTION. It is greater than that.

Or just specify that the max(MAX_ORDER_NR_PAGES, pageblock_nr_pages) granurality
only comes from alloc_contig_range at the moment. Other callers might want
to work in other granularity (e.g: memory-hotplug) although ultimately the
range has to be aligned to something.

> > True is that start_isolate_page_range() expects the range to be pageblock aligned and works in pageblock_nr_pages chunks, but I do not think that is what you meant to say here.
> 
> Actually, start_isolate_page_range() should expect max(MAX_ORDER_NR_PAEGS,
> pageblock_nr_pages) alignment instead of pageblock alignment. It seems to
> be an uncovered bug in the current code, since all callers uses at least
> max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) alignment.
> 
> The reason is that if start_isolate_page_range() is only pageblock aligned
> and a caller wants to isolate one pageblock from a MAX_ORDER-1
> (2 pageblocks on x84_64 systems) free page, this will lead to MIGRATE_ISOLATE
> accounting error. To avoid it, start_isolate_page_range() needs to isolate
> the max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) aligned range.

So, let me see if I get this straight:

You are saying that, currently, alloc_contig_ranges() works on the biggest
alignment otherwise we might have this scenario:

[      MAX_ORDER-1       ]
[pageblock#0][pageblock#1]

We only want to isolate pageblock#1, so we pass a pageblock-aligned range to
start_isolate_page_range(), but the page belonging to pageblock#1 spans
pageblock#0 and pageblock#1 because it is a MAX_ORDER-1 page.

So when we call set_migratetype_isolate()->set_pageblock_migratetype(), this will
mark either pageblock#0 or pageblock#1 as isolated, but the whole page will be put
in the MIGRATE_ISOLATE freelist by move_freepages_block()->move_freepages().
Meaning, we wil effectively have two pageblocks isolated, but only one marked
as such?

Did I get it right or did I miss something?

I know that this has been discussed previously, and the cover-letter already
mentions it, but I think it would be great to have some sort of information about
the problem in the commit message as well, so people do not have to go and find
it somewhere else.


-- 
Oscar Salvador
SUSE Labs
