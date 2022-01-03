Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C624830C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiACL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:58:24 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56180 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiACL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:58:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A1DE91F38A;
        Mon,  3 Jan 2022 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641211102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YZ7mq25SiE5S03nlCAmxhvLOytwyCBcGbYZinRze5bo=;
        b=tbn/jgA+JlfeERiquz3joiGXXpA6BzeN8LLT3j8QbnzVMvlPUUbG5mqpfUNXix06Mi19Sw
        6VIQZEf6J2ZVz1NguyRuGVWTk5IWaLy0ayufISQnSu/xflu571srH4E+x2uQtO29OJ3Aag
        J7ugDpgVy/kCD22KLt+6sDe9GCaSXe0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 179BAA3B83;
        Mon,  3 Jan 2022 11:58:22 +0000 (UTC)
Date:   Mon, 3 Jan 2022 12:58:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
Message-ID: <YdLk3cI68GTTxXLI@dhcp22.suse.cz>
References: <20211222052457.1960701-1-shakeelb@google.com>
 <YcmaA9BS/DSB/iER@dhcp22.suse.cz>
 <CALvZod5ORV1y02TcATpRAQVObEPYNv0y0t49bS0f0NTvT6WRSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5ORV1y02TcATpRAQVObEPYNv0y0t49bS0f0NTvT6WRSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-12-21 11:06:14, Shakeel Butt wrote:
> Hi Michal,
> 
> On Mon, Dec 27, 2021 at 2:48 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> > >       atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > > +     mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC, area->nr_pages);
> > >
> > >       /*
> > >        * If not enough pages were obtained to accomplish an
> >
> > Is it safe to assume that the whole area is always charged to the same
> > memcg? I am not really deeply familiar with vmalloc internals but is it
> > possible that an area could get resized/partially reused with a
> > different charging context?
> 
> From what I understand, vmalloc areas are not resized or partially
> reused at the moment. There is some ongoing discussion on caching it
> but caching would also require updating the accounting part as well.

OK.

> Regarding the whole area charged to the same memcg, the only way it
> may get charged to different memcgs is if the process in which the
> allocations are happening is migrated to a different memcg. We can
> resolve this by traversing the pages in area->pages array (and use
> lruvec based stats instead).

I haven't even thought of a task migration. I expect that this is not a
very likely scenario but it would lead to weird numbers and I guess we
would like to prevent from that. A loop over all pages in the area and
accounting them each separately should be good enough to cover that as
well as the existing problem that has already been observed by syzbot.

> I did contemplate on making this a lruvec stat but decided to start
> simple and if we ever need per-node stat then we can easily move to
> lruvec based stats. Let me know what you think.

I am not really sure here. For now I would go with page by page stats
gathering.

Thanks!
-- 
Michal Hocko
SUSE Labs
