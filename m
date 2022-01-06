Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E31486771
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiAFQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:12:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52380 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiAFQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:12:20 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 96AC721126;
        Thu,  6 Jan 2022 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641485538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GswLImmejcBJzE34E9NsNUmMkP/vwikx4Qx1uqSJXO0=;
        b=CYKDxTacSb+lxU2Io5XRNzgzcRRyXMByC0urq7S6nLTf37jzscMEZ7s8Uxrxd/kr+sfmQN
        i5mBf2co5jf2IFcE619RHbJn85UKQjkvXypoydtr9bAn+NizfMCZWbe9DVRJKKcNcI/yA3
        Z45WOvoLPJLl38pYFNJ3gIVqjUmkcaA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1E99FA3B81;
        Thu,  6 Jan 2022 16:12:18 +0000 (UTC)
Date:   Thu, 6 Jan 2022 17:12:16 +0100
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
Message-ID: <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104202227.2903605-7-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> +static struct lru_gen_mm_walk *alloc_mm_walk(void)
> +{
> +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> +		return kvzalloc(sizeof(struct lru_gen_mm_walk), GFP_KERNEL);
> +
> +	return current->reclaim_state->mm_walk;
> +}
> +
> +static void free_mm_walk(struct lru_gen_mm_walk *walk)
> +{
> +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> +		kvfree(walk);
> +}

Do I get it right that you are allocating from the reclaim context? What
prevents this to completely deplete the memory as the reclaim context is
PF_MEMALLOC?
-- 
Michal Hocko
SUSE Labs
