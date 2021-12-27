Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22B147FBEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhL0Ksj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:48:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45418 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhL0Ksj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:48:39 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5D39210F0;
        Mon, 27 Dec 2021 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640602117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Rvd63Dmd2SDNoBxHdD3p9t0LUSl3An6PqLQ93ELpwE=;
        b=DvOn88a8sFAxHav9YVpiBmGnO9MSGXNH2RgFIzrf9uYiq5kF/qqZLmaDWjhTQbro47iJDH
        vLz7INpg2b8LF02Px27OnfjzjLa3Mm3ZP+OdThg2VIjjsY3kdtdLraoqD4uRBX28uB8Ne1
        BZcWBJcpcrDsLUWCf4yMpGADTKqCI6k=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 46987A3B81;
        Mon, 27 Dec 2021 10:48:37 +0000 (UTC)
Date:   Mon, 27 Dec 2021 11:48:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
Message-ID: <YcmaA9BS/DSB/iER@dhcp22.suse.cz>
References: <20211222052457.1960701-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222052457.1960701-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-12-21 21:24:57, Shakeel Butt wrote:
> The kvmalloc* allocation functions can fallback to vmalloc allocations
> and more often on long running machines. In addition the kernel does
> have __GFP_ACCOUNT kvmalloc* calls. So, often on long running machines,
> the memory.stat does not tell the complete picture which type of memory
> is charged to the memcg. So add a per-memcg vmalloc stat.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

The counter is useful IMHO. I just have one implementation specific
question.
[...]
> @@ -2626,6 +2627,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  		unsigned int page_order = vm_area_page_order(area);
>  		int i;
>  
> +		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
> +				     -(int)area->nr_pages);
> +
>  		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
>  			struct page *page = area->pages[i];
>  
> @@ -2964,6 +2968,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> +	mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC, area->nr_pages);
>  
>  	/*
>  	 * If not enough pages were obtained to accomplish an

Is it safe to assume that the whole area is always charged to the same
memcg? I am not really deeply familiar with vmalloc internals but is it
possible that an area could get resized/partially reused with a
different charging context?

A clarification comment would be really handy.
-- 
Michal Hocko
SUSE Labs
