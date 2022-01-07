Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C365C487464
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346299AbiAGJAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:00:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54206 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiAGJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:00:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 24CFD1F3A2;
        Fri,  7 Jan 2022 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641546032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ig5IiEWOoBShbVVLKjnlcWWj+KTg7Y8hxv8YDisw5s=;
        b=azeK60Hwa4gjEk7/3/CK0/YkNfN3ozmGMgfJ8kvjeqVWwwOZAOQ/Lutrrl+keH9pchj3QG
        qQk413bZp9arhr9FtD5jljEVLkXa7HqxhbWYhGx//HeTw09NwojUSB3vg2FgBnIf8g67nG
        aE4/RnBndC/Rw4J8e8NJOdGwoXD2rOw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8304BA3B83;
        Fri,  7 Jan 2022 09:00:31 +0000 (UTC)
Date:   Fri, 7 Jan 2022 10:00:31 +0100
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
Message-ID: <YdgBL1dRk1KmyXJS@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <Yddh+APQGg8dKRgw@google.com>
 <Ydf/7DDu94fMs0CG@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydf/7DDu94fMs0CG@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-01-22 09:55:09, Michal Hocko wrote:
[...]
> > In this case, lru_gen_mm_walk is small (160 bytes); it's per direct
> > reclaimer; and direct reclaimers rarely come here, i.e., only when
> > kswapd can't keep up in terms of the aging, which is similar to the
> > condition where the inactive list is empty for the active/inactive
> > lru.
> 
> Well, this is not a strong argument to be honest. Kswapd being stuck
> and the majority of the reclaim being done in the direct reclaim
> context is a situation I have seen many many times.

Also do not forget that memcg reclaim is effectivelly only direct
reclaim. Not that the memcg reclaim indicates a global memory shortage
but it can add up and race with the global reclaim as well.

-- 
Michal Hocko
SUSE Labs
