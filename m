Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75324A8207
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349979AbiBCKDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:03:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51714 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbiBCKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:03:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D06B5210F1;
        Thu,  3 Feb 2022 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643882609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=XFe4KRaJnmlSNS9ZV+8yOgyiyJH5UKwmTbZlHDLxHEE=;
        b=APTLIlHGaPPZnk26W11ZryI+stoqJejBX7pfmdmB63QWIedA8EsHBLSFkvv0FdB1khn0Gf
        gL110nJWv/vI86wikLtLXIXwBN0FJCN7Ue+UOoT9um3lVOt0zKm50F096ROZo8ZW1wj67V
        Vl5ID4raPjVLAbEBZSNgyEtcJ9ZqZZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643882609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=XFe4KRaJnmlSNS9ZV+8yOgyiyJH5UKwmTbZlHDLxHEE=;
        b=4RNCdlsyfAtrcoOxd1+ciLscNjsO+PrJ+3tpk0eFvu+enuU/0NSYimbClAaMqVzLYf7gqn
        9ABW6LGcau4kYQAQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E1FC7A3B88;
        Thu,  3 Feb 2022 10:03:28 +0000 (UTC)
Date:   Thu, 3 Feb 2022 10:03:26 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: vmscan: remove deadlock due to throttling failing to
 make progress
Message-ID: <20220203100326.GD3301@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A soft lockup bug in kcompactd was reported in a private bugzilla with
the following visible in dmesg;

[15980.045209][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 26s! [kcompactd0:479]
[16008.044989][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 52s! [kcompactd0:479]
[16036.044768][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 78s! [kcompactd0:479]
[16064.044548][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 104s! [kcompactd0:479]

The machine had 256G of RAM with no swap and an earlier failed allocation
indicated that node 0 where kcompactd was run was potentially
unreclaimable;

Node 0 active_anon:29355112kB inactive_anon:2913528kB active_file:0kB
  inactive_file:0kB unevictable:64kB isolated(anon):0kB isolated(file):0kB
  mapped:8kB dirty:0kB writeback:0kB shmem:26780kB shmem_thp:
  0kB shmem_pmdmapped: 0kB anon_thp: 23480320kB writeback_tmp:0kB
  kernel_stack:2272kB pagetables:24500kB all_unreclaimable? yes

Vlastimil Babka investigated a crash dump and found that a task migrating pages
was trying to drain PCP lists;

PID: 52922  TASK: ffff969f820e5000  CPU: 19  COMMAND: "kworker/u128:3"
 #0 [ffffaf4e4f4c3848] __schedule at ffffffffb840116d
 #1 [ffffaf4e4f4c3908] schedule at ffffffffb8401e81
 #2 [ffffaf4e4f4c3918] schedule_timeout at ffffffffb84066e8
 #3 [ffffaf4e4f4c3990] wait_for_completion at ffffffffb8403072
 #4 [ffffaf4e4f4c39d0] __flush_work at ffffffffb7ac3e4d
 #5 [ffffaf4e4f4c3a48] __drain_all_pages at ffffffffb7cb707c
 #6 [ffffaf4e4f4c3a80] __alloc_pages_slowpath.constprop.114 at ffffffffb7cbd9dd
 #7 [ffffaf4e4f4c3b60] __alloc_pages at ffffffffb7cbe4f5
 #8 [ffffaf4e4f4c3bc0] alloc_migration_target at ffffffffb7cf329c
 #9 [ffffaf4e4f4c3bf0] migrate_pages at ffffffffb7cf6d15
 10 [ffffaf4e4f4c3cb0] migrate_to_node at ffffffffb7cdb5aa
 11 [ffffaf4e4f4c3da8] do_migrate_pages at ffffffffb7cdcf26
 12 [ffffaf4e4f4c3e88] cpuset_migrate_mm_workfn at ffffffffb7b859d2
 13 [ffffaf4e4f4c3e98] process_one_work at ffffffffb7ac45f3
 14 [ffffaf4e4f4c3ed8] worker_thread at ffffffffb7ac47fd
 15 [ffffaf4e4f4c3f10] kthread at ffffffffb7acbdc6
 16 [ffffaf4e4f4c3f50] ret_from_fork at ffffffffb7a047e2

The root of the problem is that kcompact0 is not rescheduling on a CPU
while a task that has isolated a large number of the pages from the
LRU is waiting on kcompact0 to reschedule so the pages can be released.
While shrink_inactive_list() only loops once around too_many_isolated,
reclaim can continue without rescheduling if sc->skipped_deactivate ==
1 which could happen if there was no file LRU and the inactive anon list
was not low.

Debugged-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Mel Gorman <mgorman@suse.de>
---
 mm/vmscan.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 090bfb605ecf..59b14e0d696c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1066,8 +1066,10 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
+	    current->flags & (PF_IO_WORKER|PF_KTHREAD)) {
+		cond_resched();
 		return;
+	}
 
 	/*
 	 * These figures are pulled out of thin air.
