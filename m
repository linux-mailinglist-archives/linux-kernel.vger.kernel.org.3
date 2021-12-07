Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8346C84C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbhLGXhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbhLGXhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:37:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dd+SCrzB7JWbhzw7xRm3UlZciOw/vMHq8v77nVO1WHg=; b=pFLMshcojgCLkHpUOHmnrWNe73
        gVy4BaXE6UnY7Q76+BmnZtVNgKZVx7m2UY7VNUV0ojECgELrm6k3X5s0bgWqkdp3/BW4PBiGXtm3C
        EUQJw5JaS2wkrh9H65kTyNQXBuoe5pHGGyDw/2zoJTarhvjUkl5gmYCcg0f3StyHRsCnbzpQCdWiS
        XumRPnUB+L1F+QEQcP9MTXrBIs3IXFr2S0uSifcFZHLm8di0Zs864ynGTR2mQa2zuWm+hcPVni+5L
        G8gLrDlMqv7tDdPRSZlLH0EnGXxzpwJegBIeQByJVyOnBnUt1v2nGu1/tA8VHWMXy2FktMdQi+PVt
        0dja8wFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mujyC-007sJY-Vr; Tue, 07 Dec 2021 23:34:01 +0000
Date:   Tue, 7 Dec 2021 23:34:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com,
        mhocko@suse.com, david@redhat.com
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya/vaGdKHm6Zy3ML@casper.infradead.org>
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207224013.880775-2-npache@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:40:13PM -0500, Nico Pache wrote:
> +++ b/mm/vmscan.c
> @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  	int size = map_size + defer_size;
>  
>  	for_each_node(nid) {
> +		int tmp = nid;
>  		pn = memcg->nodeinfo[nid];
>  		old = shrinker_info_protected(memcg, nid);
>  		/* Not yet online memcg */
>  		if (!old)
>  			return 0;
>  
> -		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> +		if(!node_online(nid))
> +			tmp = numa_mem_id();
> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>  		if (!new)

Why should this be fixed here and not in, say, kvmalloc_node()?
