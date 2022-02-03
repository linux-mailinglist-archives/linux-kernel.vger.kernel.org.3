Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E28E4A821F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350024AbiBCKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:12:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35334 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiBCKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:12:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A5B011F3A5;
        Thu,  3 Feb 2022 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643883150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gr3C28hfRKIsSogmgFmAlwO97s2JhEgCbYXvCeygykg=;
        b=s8loehmza/5APLpfD591EuyiwIjmdCM4AHB+n6QqgJ+0PH+jV5VDVQVpxdzvIu5v8rX1/E
        nDr92yW4IhuSgZVdbUlSZs5H7U352e/+njt4bxJ06M8tSVMVXWDUm0qVN7V5/UUCyUDBwu
        4sVTiAt+6VnT9u5oFovnjL1ra46hFOE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 74138A3B87;
        Thu,  3 Feb 2022 10:12:30 +0000 (UTC)
Date:   Thu, 3 Feb 2022 11:12:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: vmscan: remove deadlock due to throttling failing to
 make progress
Message-ID: <YfuqjZVZFIUBbjJ0@dhcp22.suse.cz>
References: <20220203100326.GD3301@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203100326.GD3301@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-02-22 10:03:26, Mel Gorman wrote:
> A soft lockup bug in kcompactd was reported in a private bugzilla with
> the following visible in dmesg;
> 
> [15980.045209][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 26s! [kcompactd0:479]
> [16008.044989][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 52s! [kcompactd0:479]
> [16036.044768][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 78s! [kcompactd0:479]
> [16064.044548][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 104s! [kcompactd0:479]
> 
> The machine had 256G of RAM with no swap and an earlier failed allocation
> indicated that node 0 where kcompactd was run was potentially
> unreclaimable;
> 
> Node 0 active_anon:29355112kB inactive_anon:2913528kB active_file:0kB
>   inactive_file:0kB unevictable:64kB isolated(anon):0kB isolated(file):0kB
>   mapped:8kB dirty:0kB writeback:0kB shmem:26780kB shmem_thp:
>   0kB shmem_pmdmapped: 0kB anon_thp: 23480320kB writeback_tmp:0kB
>   kernel_stack:2272kB pagetables:24500kB all_unreclaimable? yes
> 
> Vlastimil Babka investigated a crash dump and found that a task migrating pages
> was trying to drain PCP lists;
> 
> PID: 52922  TASK: ffff969f820e5000  CPU: 19  COMMAND: "kworker/u128:3"
>  #0 [ffffaf4e4f4c3848] __schedule at ffffffffb840116d
>  #1 [ffffaf4e4f4c3908] schedule at ffffffffb8401e81
>  #2 [ffffaf4e4f4c3918] schedule_timeout at ffffffffb84066e8
>  #3 [ffffaf4e4f4c3990] wait_for_completion at ffffffffb8403072
>  #4 [ffffaf4e4f4c39d0] __flush_work at ffffffffb7ac3e4d
>  #5 [ffffaf4e4f4c3a48] __drain_all_pages at ffffffffb7cb707c
>  #6 [ffffaf4e4f4c3a80] __alloc_pages_slowpath.constprop.114 at ffffffffb7cbd9dd
>  #7 [ffffaf4e4f4c3b60] __alloc_pages at ffffffffb7cbe4f5
>  #8 [ffffaf4e4f4c3bc0] alloc_migration_target at ffffffffb7cf329c
>  #9 [ffffaf4e4f4c3bf0] migrate_pages at ffffffffb7cf6d15
>  10 [ffffaf4e4f4c3cb0] migrate_to_node at ffffffffb7cdb5aa
>  11 [ffffaf4e4f4c3da8] do_migrate_pages at ffffffffb7cdcf26
>  12 [ffffaf4e4f4c3e88] cpuset_migrate_mm_workfn at ffffffffb7b859d2
>  13 [ffffaf4e4f4c3e98] process_one_work at ffffffffb7ac45f3
>  14 [ffffaf4e4f4c3ed8] worker_thread at ffffffffb7ac47fd
>  15 [ffffaf4e4f4c3f10] kthread at ffffffffb7acbdc6
>  16 [ffffaf4e4f4c3f50] ret_from_fork at ffffffffb7a047e2
> 
> The root of the problem is that kcompact0 is not rescheduling on a CPU
> while a task that has isolated a large number of the pages from the
> LRU is waiting on kcompact0 to reschedule so the pages can be released.
> While shrink_inactive_list() only loops once around too_many_isolated,
> reclaim can continue without rescheduling if sc->skipped_deactivate ==
> 1 which could happen if there was no file LRU and the inactive anon list
> was not low.

I guess it should be mentioned explicitly that the problem is !PREEMPT
specific. Other than that looks good to me.

> Debugged-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Mel Gorman <mgorman@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 090bfb605ecf..59b14e0d696c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1066,8 +1066,10 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
>  	 * forward progress (e.g. journalling workqueues or kthreads).
>  	 */
>  	if (!current_is_kswapd() &&
> -	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
> +	    current->flags & (PF_IO_WORKER|PF_KTHREAD)) {
> +		cond_resched();
>  		return;
> +	}
>  
>  	/*
>  	 * These figures are pulled out of thin air.

-- 
Michal Hocko
SUSE Labs
