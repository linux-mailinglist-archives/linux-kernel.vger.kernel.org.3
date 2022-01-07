Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C754C487F7A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiAGXgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiAGXgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:36:16 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32266C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:36:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id o7so9040499ioo.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xYu9qteuFVNrHyo1i7aEmcfHOTj3gefz8I1p+xu99cE=;
        b=KVMWEcwAp4WTr2X5uSFAYSIb1gUJnxmuasFdE3TRGGuc9UPxRC1uEOaA//819Vna+R
         e9pELwJ72UnnP7NVDJw7XrozwhzL7wNV4H0GV2T4b8gpxk7axMm4pExfS9/MaG3i6JGJ
         Z8S4aOFzx5B381qYvSPzTu5BJTrmtIv1ta/fUPycwLNiPf1Pym5MuhqHYhl89EwEfffD
         dxpEejJr/Qlyh1TY1lKhv+BBjEtQhaYJFnqsK8x+2h5JwQlcsGqV/YIBJPMCubPsaWsX
         q8NP4iA/07CScovcAUk4KMBQ/aNkFtrHYjB2enZvlLociLWQWb9+rmYQARL8qQ7iRn6D
         eAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xYu9qteuFVNrHyo1i7aEmcfHOTj3gefz8I1p+xu99cE=;
        b=uTiZ0Ds3Shgxn67rUB1CXOXNGrBRqv5saehBQInQG6rsPqWksPAsBiQaTtvTWN2Cgl
         srOKxuUeKN+53HQ6VRYWWDSyLugMpdM9jJloASyhv4nxNhqhRKIlgngouAGyHCluqMEF
         fJ6+ED2onGK5IWh0/PkarlKOkwVs1niDqIfUsxdgN05DEG2tRW8jtqtcsxGqYx7Y4k+j
         8Oympt6JTDAG88v2Hdb1h2BHasnLLCduLr9hzhnGwjRg5XDbLvw+BcZZeE6mPpW1noyN
         Mv0TuAS9gyz2I4SwxVROB2GOPUnpugUGX0i64NwfAPGLwRtXczz2LZDouqX9zBiDIOap
         P+Ug==
X-Gm-Message-State: AOAM533DcQ+JxnzozsOFRNZ49JhKLxVSw+y2TUWLYvf9O04N8hIXgzFU
        cmalIDsp07JjW0hz2OA3avy0PQ==
X-Google-Smtp-Source: ABdhPJzDj049VbsKt/EYYdSUgiTzJatv/z9OgEricIXR1zpNkxJjKeELDnzLfrvVCz7m4TJ/mII9Dg==
X-Received: by 2002:a05:6602:1410:: with SMTP id t16mr32400729iov.160.1641598575473;
        Fri, 07 Jan 2022 15:36:15 -0800 (PST)
Received: from google.com ([2620:15c:183:200:8b41:537d:f5d3:269c])
        by smtp.gmail.com with ESMTPSA id w7sm48105ilu.27.2022.01.07.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:36:15 -0800 (PST)
Date:   Fri, 7 Jan 2022 16:36:11 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <YdjOazilBEkdUT7x@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <Ydg8AeE6JIUnC+ps@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydg8AeE6JIUnC+ps@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:11:29PM +0100, Michal Hocko wrote:
> On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> [...]
> > +static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
> > +{
> > +	struct mem_cgroup *memcg;
> > +	bool success = false;
> > +	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
> > +
> > +	VM_BUG_ON(!current_is_kswapd());
> > +
> > +	current->reclaim_state->mm_walk = &pgdat->mm_walk;
> > +
> > +	memcg = mem_cgroup_iter(NULL, NULL, NULL);
> > +	do {
> > +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > +
> > +		if (age_lruvec(lruvec, sc, min_ttl))
> > +			success = true;
> > +
> > +		cond_resched();
> > +	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
> > +
> > +	if (!success && mutex_trylock(&oom_lock)) {
> > +		struct oom_control oc = {
> > +			.gfp_mask = sc->gfp_mask,
> > +			.order = sc->order,
> > +		};
> > +
> > +		if (!oom_reaping_in_progress())
> > +			out_of_memory(&oc);
> > +
> > +		mutex_unlock(&oom_lock);
> > +	}
> 
> Why do you need to trigger oom killer from this path? Why cannot you
> rely on the page allocator to do that like we do now?

This is per desktop users' (repeated) requests. The can't tolerate
thrashing as servers do because of UI lags; and they usually don't
have fancy tools like oomd.

Related discussions I saw:
https://github.com/zen-kernel/zen-kernel/issues/218
https://lore.kernel.org/lkml/20101028191523.GA14972@google.com/
https://lore.kernel.org/lkml/20211213051521.21f02dd2@mail.inbox.lv/
https://lore.kernel.org/lkml/54C2C89C.8080002@gmail.com/
https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/

From patch 8:
  Personal computers
  ------------------
  :Thrashing prevention: Write ``N`` to
   ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
   ``N`` milliseconds from getting evicted. The OOM killer is invoked if
   this working set can't be kept in memory. Based on the average human
   detectable lag (~100ms), ``N=1000`` usually eliminates intolerable
   lags due to thrashing. Larger values like ``N=3000`` make lags less
   noticeable at the cost of more OOM kills.
