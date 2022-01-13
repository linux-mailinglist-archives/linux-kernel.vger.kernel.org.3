Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E855748D706
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiAML6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:58:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48680 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiAML5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:57:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D1721F3A5;
        Thu, 13 Jan 2022 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642075060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lewmpLo/LsNms+2qW30Nngxyo9/rk6CzvqYO8ieYnV8=;
        b=LVNTyLA6AWr4vMsxHfrm31Uc801ybPFJp4QiLY7el8++BGBNnjG8uqvk9ZzcXSqLwvewub
        buqU8bGiyVwsBWUKF2oQUvULUsLUay9xZAj+QDz5SbHw4jL44Qga5MnjpeTdSLkCj7HBTt
        Cupf5Ta/1iyHX0cGnEYui8DW4BX5onI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3521EA3B88;
        Thu, 13 Jan 2022 11:57:39 +0000 (UTC)
Date:   Thu, 13 Jan 2022 12:57:35 +0100
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
Message-ID: <YeATr//U6XD87fWF@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <Ydxlg5rI4ZvODQvF@dhcp22.suse.cz>
 <Yd4oaUwHkpadAKwe@google.com>
 <Yd6q0QdLVTS53vu4@dhcp22.suse.cz>
 <Yd9nk0qlK3jK9baN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd9nk0qlK3jK9baN@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-01-22 16:43:15, Yu Zhao wrote:
> On Wed, Jan 12, 2022 at 11:17:53AM +0100, Michal Hocko wrote:
[...]
> > Is there any reason you are not using folio_memcg_lock in the
> > pte walk instead?
> 
> We have a particular lruvec (the first arg), hence a particular memcg
> to lock. But we don't have a particular page to lock.

That is certainly true at this layer but the locking should be needed
only for specific pages, no? So you can move the lock down to the
callback which examines respective pages. Or is there anything
preventing that?

To be honest, and that is the reason I am asking, I really do not like
to open code the migration synchronization outside of the memcg proper.
Code paths which need a stable memcg are supposed to be using
folio_memcg_lock for the specific examination time. If you prefer a
trylock approach for this usecase then we can add one.

-- 
Michal Hocko
SUSE Labs
