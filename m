Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993CB4BDBDB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355452AbiBULLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:11:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347773AbiBULKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:10:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDA2651
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:41:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9739D1F391;
        Mon, 21 Feb 2022 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645440105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0d7lkAaMU8geNxG5zttR6qwP8lVzWt7ebeJABufG5E=;
        b=NUkcdVMkWxksW0aIV03i58GVEpjqYqxCokpTxzb/xSycX+EIEca7qebOKI+dCTpTmxPLyJ
        oD9RKEyRRvn7vPXdT6h6dOBk0Mol8t3oq3oioabSWqNfegsw+Va8Z/ZSlPTLEVoLTpwJe8
        AdTEg8Ipbaj8nY/53fGsbdsFfuU6FEU=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 50417A3B81;
        Mon, 21 Feb 2022 10:41:45 +0000 (UTC)
Date:   Mon, 21 Feb 2022 11:41:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, peterz@infradead.org, guro@fb.com,
        shakeelb@google.com, minchan@kernel.org, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
Message-ID: <YhNsaHLLfvFoxnNu@alley>
References: <20220219174940.2570901-1-surenb@google.com>
 <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-21 09:55:12, Michal Hocko wrote:
> On Sat 19-02-22 09:49:40, Suren Baghdasaryan wrote:
> > When page allocation in direct reclaim path fails, the system will
> > make one attempt to shrink per-cpu page lists and free pages from
> > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > be a very slow operation because it's done using workqueues and the
> > task in direct reclaim waits for all of them to finish before
> > proceeding. Currently this time is not accounted as psi memory stall.
> > 
> > While testing mobile devices under extreme memory pressure, when
> > allocations are failing during direct reclaim, we notices that psi
> > events which would be expected in such conditions were not triggered.
> > After profiling these cases it was determined that the reason for
> > missing psi events was that a big chunk of time spent in direct
> > reclaim is not accounted as memory stall, therefore psi would not
> > reach the levels at which an event is generated. Further investigation
> > revealed that the bulk of that unaccounted time was spent inside
> > drain_all_pages call.
> 
> It would be cool to have some numbers here.
> 
> > Annotate drain_all_pages and unreserve_highatomic_pageblock during
> > page allocation failure in the direct reclaim path so that delays
> > caused by these calls are accounted as memory stall.
> 
> If the draining is too slow and dependent on the current CPU/WQ
> contention then we should address that. The original intention was that
> having a dedicated WQ with WQ_MEM_RECLAIM would help to isolate the
> operation from the rest of WQ activity. Maybe we need to fine tune
> mm_percpu_wq. If that doesn't help then we should revise the WQ model
> and use something else. Memory reclaim shouldn't really get stuck behind
> other unrelated work.

WQ_MEM_RECLAIM causes that one special worker (rescuer) is created for
the workqueue. It is used _only_ when new workers could not be created
for some, typically when there is non enough memory. It is just
a fallback, last resort. It does _not_ speedup processing.

Otherwise, "mm_percpu_wq" is a normal CPU-bound wq. It uses the shared
per-CPU worker pools. They serialize all work items on a single
worker. Another worker is used only when a work goes asleep and waits
for something.

It means that "drain" work is blocked by other work items that are
using the same worker pool and were queued earlier.


You might try to allocate "mm_percpu_wq" with WQ_HIGHPRI flag. It will
use another shared per-CPU worker pools where the workers have nice
-20. The "drain" work still might be blocked by another work items
using the same pool. But it should be faster because the workers
have higher priority.


Dedicated kthreads might be needed when the "draining" should not be
blocked by anything. If you go this way then I suggest to use
the kthread_worker API, see "linux/kthread.h". It is very similar
to the workqueues API but it always creates new kthreads.

Just note that kthread_worker API does not maintain per-CPU workers
on its own. If you need per-CPU workers than you need to
use kthread_create_worker_on_cpu() for_each_online_cpu().
And you would need cpu hotplug callbacks to create/destroy
ktheads. For example, see start_power_clamp_worker().

HTH,
Petr
