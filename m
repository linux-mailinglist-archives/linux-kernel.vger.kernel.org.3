Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3A4A8BF8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353601AbiBCSxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:53:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51854 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353592AbiBCSxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:53:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86BE6210F6;
        Thu,  3 Feb 2022 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643914433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZJP+ciPjqfM4S/keVcfF2rFaprDcpYE6rpUF4+5Cns=;
        b=Jf1/mBEmjU1uji8Qw6aEV/9uOYlArp7zwFxpaGC5sPsXJZMQsPp0dw1DcM333C1s2m3ALn
        v3tKGUyDjNjdr11NUYvEEHi11Vd15KQaP8joqioZraXRdevuaTz20fzLWCcukWd7IQCLqi
        ihsz0yfgIlj5XorvSVpACMGMxHisSA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643914433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZJP+ciPjqfM4S/keVcfF2rFaprDcpYE6rpUF4+5Cns=;
        b=zoxBBoAhCTkDPNfG99T9GZCrGXarYsaf9lwS2dCBNdeYhGWJCUE60lC6/o4k2RPM68axHe
        Fsp0IqDAahrT9qCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65433139FE;
        Thu,  3 Feb 2022 18:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qq/6F8Ek/GGBZQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Feb 2022 18:53:53 +0000
Message-ID: <2472c281-436c-d5f5-61d8-e5192e912ff1@suse.cz>
Date:   Thu, 3 Feb 2022 19:53:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] mm: vmscan: remove deadlock due to throttling failing to
 make progress
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220203100326.GD3301@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220203100326.GD3301@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 11:03, Mel Gorman wrote:
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
> 
> Debugged-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Mel Gorman <mgorman@suse.de>

Fixes: d818fca1cac3 ("mm/vmscan: throttle reclaim and compaction when too
may pages are isolated")

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


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
> 

