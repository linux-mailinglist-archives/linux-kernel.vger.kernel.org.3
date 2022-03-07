Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD114D0439
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbiCGQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiCGQgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:36:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267768A6E8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:35:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5E4FD1F37C;
        Mon,  7 Mar 2022 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646670950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bi0TS8YAsfzZF7BR80OGd4EstizzGicY5c5jqgoj9Ic=;
        b=OITWtj4iUQ9DNSSmv0jTOyieGEG/ojcmQKf1RpAnfBirfqoMOJ39g8t/hEgHD688jLL/DU
        zU7EqiyVWgTv8AsLz5DfOAoOmQoHdY6Wx9sHa2HbhEc9WimiA8c9AbGSXmxuZ6rJaPKON+
        BARwFWaCSM3GiyTU9O5oeygAFaTt2xw=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 17F1BA3B81;
        Mon,  7 Mar 2022 16:35:50 +0000 (UTC)
Date:   Mon, 7 Mar 2022 17:35:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in
 drain_all_pages
Message-ID: <YiY0Zf9XH/m/IqcR@alley>
References: <20220225012819.1807147-1-surenb@google.com>
 <20220302002150.2113-1-hdanton@sina.com>
 <CAJuCfpG3TRgs8fA5kpkhrFRcDF=C9VyqLTCz42sxOyKZ0pRaNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG3TRgs8fA5kpkhrFRcDF=C9VyqLTCz42sxOyKZ0pRaNQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 15:06:24, Suren Baghdasaryan wrote:
> On Tue, Mar 1, 2022 at 4:22 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Thu, 24 Feb 2022 17:28:19 -0800 Suren Baghdasaryan wrote:
> > > Sending as an RFC to confirm if this is the right direction and to
> > > clarify if other tasks currently executed on mm_percpu_wq should be
> > > also moved to kthreads. The patch seems stable in testing but I want
> > > to collect more performance data before submitting a non-RFC version.
> > >
> > >
> > > Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> > > list during direct reclaim. The tasks on a workqueue can be delayed
> > > by other tasks in the workqueues using the same per-cpu worker pool.
> >
> > The pending works may be freeing a couple of slabs/pages each. Who knows?
> 
> If we are talking about work specifically scheduled on mm_percpu_wq
> then apart from drain_all_pages, mm_percpu_wq is used to execute
> vmstat_update and lru_add_drain_cpu for drainig pagevecs. If OTOH what
> you mean is that the work might be blocked by say kswapd, which is
> freeing memory, then sure, who knows...

Note that the same worker pool is used by many workqueues. And
work items in per-cpu workqueues are serialized on a single worker.
Another worker is used only when a work goes into a sleeping wait.

I want to say that "drain_all_pages" are not blocked only by other
works using "mm_percpu_wq" but also by works from many other
workqueues, including "system_wq".

These works might do anything, including memory allocation, freeing.

> >
> > > This results in sizable delays in drain_all_pages when cpus are highly
> > > contended.
> > > Memory management operations designed to relieve memory pressure should
> > > not be allowed to block by other tasks, especially if the task in direct
> > > reclaim has higher priority than the blocking tasks.
> >
> > Wonder why priority is the right cure to tight memory - otherwise it was
> > not a problem given a direct reclaimer of higher priority.
> >
> > Off topic question - why is it making sense from begining for a task of
> > lower priority to peel pages off from another of higher priority if
> > priority is considered in direct reclaim?
> 
> The way I understood your question is that you are asking why we have
> to use workqueues of potentially lower priority to drain pages for a
> potentially higher priority process in direct reclaim (which is
> blocked waiting for workqueues to complete draining)?
> If so, IIUC this mechanism was introduced in
> https://lore.kernel.org/all/20170117092954.15413-4-mgorman@techsingularity.net
> to avoid draining from IPI context (CC'ing Mel Gorman to correct me if
> I'm wrong).
> I think the issue here is that in the process we are losing
> information about the priority of the process in direct reclaim, which
> might lead to priority inversion.

Note that priority of workqueue workers is static. It is defined
by the workqueue parameters.

kthread_worker API allows to create custom kthreads. The user could
modify the priority as needed. It allows to prevent priority
inversion. It can hardly be achieved by workques where the workers
are heavily shared by unrelated tasks.

Best Regards,
Petr
