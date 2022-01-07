Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8CB4877FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347472AbiAGNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:11:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbiAGNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:11:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A1AD81F3A2;
        Fri,  7 Jan 2022 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641561090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gc7RESSovFXbtCRI/cp6kE8Jiq0QYX7ZdbQPcYT0MvA=;
        b=QQw+dSw+MkkBXaVdJafoPeNUIflGmPW62gMUEi4yCfxCFFaRd1W7t932jUYgp7Mgr5PuoE
        srfYFRdT74WF7lt4tiRTIm1asMrtXugn8eQtn7Nr3gv2qwEjA42CIBDjXrmnQIV6m4wUMG
        /NyHXMZwFyKT20uxbjX+N6aeU7sX+cw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D93FA3B8B;
        Fri,  7 Jan 2022 13:11:29 +0000 (UTC)
Date:   Fri, 7 Jan 2022 14:11:29 +0100
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
Message-ID: <Ydg8AeE6JIUnC+ps@dhcp22.suse.cz>
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
[...]
> +static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
> +{
> +	struct mem_cgroup *memcg;
> +	bool success = false;
> +	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
> +
> +	VM_BUG_ON(!current_is_kswapd());
> +
> +	current->reclaim_state->mm_walk = &pgdat->mm_walk;
> +
> +	memcg = mem_cgroup_iter(NULL, NULL, NULL);
> +	do {
> +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +
> +		if (age_lruvec(lruvec, sc, min_ttl))
> +			success = true;
> +
> +		cond_resched();
> +	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
> +
> +	if (!success && mutex_trylock(&oom_lock)) {
> +		struct oom_control oc = {
> +			.gfp_mask = sc->gfp_mask,
> +			.order = sc->order,
> +		};
> +
> +		if (!oom_reaping_in_progress())
> +			out_of_memory(&oc);
> +
> +		mutex_unlock(&oom_lock);
> +	}

Why do you need to trigger oom killer from this path? Why cannot you
rely on the page allocator to do that like we do now?
-- 
Michal Hocko
SUSE Labs
