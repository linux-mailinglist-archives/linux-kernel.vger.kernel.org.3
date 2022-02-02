Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE04A7095
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbiBBMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:19:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51044 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiBBMS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:18:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF82C210F6;
        Wed,  2 Feb 2022 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643804337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyPSpPed0+9M2XwlKQxCWeOGFdixxutcj0lTKCCpUgE=;
        b=u76Vu7FI2iLzLD3FOVgP2Vix8282DDpGEUlqFJuJoAb7GsoqZiiQsX/AprPIwhS/GWi56p
        hD+5Ugm1z+vcC2tF3t7VCAeaDd4J+dj0QTX3rdLFl2N7ndUKlhA7S+LDyQ54YGDmYJubxZ
        g1MR8ScpZe9y57RPNVrdPTNnYe+HjjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643804337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyPSpPed0+9M2XwlKQxCWeOGFdixxutcj0lTKCCpUgE=;
        b=s2082Jsn9mldjm1PkVxfSrWcQSpPxDldSrSOzFSMI7rwrn/600G2/luQBlMLKmomZx067+
        PsS1l+MmKwK7JVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4142913E18;
        Wed,  2 Feb 2022 12:18:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4KsvDLB2+mElIgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 02 Feb 2022 12:18:56 +0000
Date:   Wed, 2 Feb 2022 13:18:54 +0100
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
Message-ID: <Yfp2rv0K6d3cNmwg@localhost.localdomain>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-4-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119190623.1029355-4-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:06:19PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
> pages within that granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.

Another thing that came to my mind.
Prior to this patch, has_unmovable_pages() was checking on pageblock
granularity, starting at pfn#0 of the pageblock.
With this patch, you no longer check on pageblock granularity, which
means you might isolate a pageblock, but some pages that sneaked in
might actually be unmovable.

E.g:

Let's say you have a pageblock that spans (pfn#512,pfn#1024),
and you pass alloc_contig_range() (pfn#514,pfn#1024).
has_unmovable_pages() will start checking the pageblock at pfn#514,
and so it will mis pfn#512 and pfn#513. Isn't that a problem, if those
pfn turn out to be actually unmovable?


-- 
Oscar Salvador
SUSE Labs
