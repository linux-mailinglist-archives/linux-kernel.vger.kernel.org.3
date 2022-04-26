Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49277510A44
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354923AbiDZUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354920AbiDZUWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:22:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D02E1A73DD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651004340; x=1682540340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9eVKmLkjcPLHT1pKfInMUHcB/TClxCN7Mx5KT9zdIvI=;
  b=P8lCQtP2rEeNIDisHTRc3WvaBO65QMcg7FnPiVAPtsOsn1p/qwqLZ0Ja
   Vh9M6nskS+U+YkQa5FY9l8TwCmQkOMFF4oOUEXZ+vBsmOmj1ZXwJRCud5
   wFhWF4kblsZNBFrKYWpip8oFkkHZwt2JmCGmLnYlh8e0E9FXDyJ1MjzxV
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Apr 2022 13:19:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:18:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 13:18:59 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 13:18:57 -0700
Date:   Tue, 26 Apr 2022 16:18:55 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and
 alloc_contig_range alignment.
Message-ID: <20220426201855.GA1014@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425143118.2850746-1-zi.yan@sent.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:31:12AM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi David,
> 
> This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
> and alloc_contig_range(). It prepares for my upcoming changes to make
> MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-04-20-17-12.
> 
> Changelog
> ===
> V11
> ---
> 1. Moved start_isolate_page_range()/undo_isolate_page_range() alignment
>    change to a separate patch after the unmovable page check change and
>    alloc_contig_range() change to avoid some unwanted memory
>    hotplug/hotremove failures.
> 2. Cleaned up has_unmovable_pages() in Patch 2.
> 
> V10
> ---
> 1. Reverted back to the original outer_start, outer_end range for
>    test_pages_isolated() and isolate_freepages_range() in Patch 3,
>    otherwise isolation will fail if start in alloc_contig_range() is in
>    the middle of a free page.
> 
> V9
> ---
> 1. Limited has_unmovable_pages() check within a pageblock.
> 2. Added a check to ensure page isolation is done within a single zone
>    in isolate_single_pageblock().
> 3. Fixed an off-by-one bug in isolate_single_pageblock().
> 4. Fixed a NULL-deferencing bug when the pages before to-be-isolated pageblock
>    is not online in isolate_single_pageblock().
> 
> V8
> ---
> 1. Cleaned up has_unmovable_pages() to remove page argument.
> 
> V7
> ---
> 1. Added page validity check in isolate_single_pageblock() to avoid out
>    of zone pages.
> 2. Fixed a bug in split_free_page() to split and free pages in correct
>    page order.
> 
> V6
> ---
> 1. Resolved compilation error/warning reported by kernel test robot.
> 2. Tried to solve the coding concerns from Christophe Leroy.
> 3. Shortened lengthy lines (pointed out by Christoph Hellwig).
> 
> V5
> ---
> 1. Moved isolation address alignment handling in start_isolate_page_range().
> 2. Rewrote and simplified how alloc_contig_range() works at pageblock
>    granularity (Patch 3). Only two pageblock migratetypes need to be saved and
>    restored. start_isolate_page_range() might need to migrate pages in this
>    version, but it prevents the caller from worrying about
>    max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) alignment after the page range
>    is isolated.
> 
> V4
> ---
> 1. Dropped two irrelevant patches on non-lru compound page handling, as
>    it is not supported upstream.
> 2. Renamed migratetype_has_fallback() to migratetype_is_mergeable().
> 3. Always check whether two pageblocks can be merged in
>    __free_one_page() when order is >= pageblock_order, as the case (not
>    mergeable pageblocks are isolated, CMA, and HIGHATOMIC) becomes more common.
> 3. Moving has_unmovable_pages() is now a separate patch.
> 4. Removed MAX_ORDER-1 alignment requirement in the comment in virtio_mem code.
> 
> Description
> ===
> 
> The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_range()
> isolates pageblocks to remove free memory from buddy allocator but isolating
> only a subset of pageblocks within a page spanning across multiple pageblocks
> causes free page accounting issues. Isolated page might not be put into the
> right free list, since the code assumes the migratetype of the first pageblock
> as the whole free page migratetype. This is based on the discussion at [2].
> 
> To remove the requirement, this patchset:
> 1. isolates pages at pageblock granularity instead of
>    max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages);
> 2. splits free pages across the specified range or migrates in-use pages
>    across the specified range then splits the freed page to avoid free page
>    accounting issues (it happens when multiple pageblocks within a single page
>    have different migratetypes);
> 3. only checks unmovable pages within the range instead of MAX_ORDER - 1 aligned
>    range during isolation to avoid alloc_contig_range() failure when pageblocks
>    within a MAX_ORDER - 1 aligned range are allocated separately.
> 4. returns pages not in the range as it did before.
> 
> One optimization might come later:
> 1. make MIGRATE_ISOLATE a separate bit to be able to restore the original
>    migratetypes when isolation fails in the middle of the range.
> 
> Feel free to give comments and suggestions. Thanks.
> 
> [1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.com/
> [2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@redhat.com/
> 
> Zi Yan (6):
>   mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
>   mm: page_isolation: check specified range for unmovable pages
>   mm: make alloc_contig_range work at pageblock granularity
>   mm: page_isolation: enable arbitrary range page isolation.
>   mm: cma: use pageblock_order as the single alignment
>   drivers: virtio_mem: use pageblock size as the minimum virtio_mem
>     size.
> 
>  drivers/virtio/virtio_mem.c    |   6 +-
>  include/linux/cma.h            |   4 +-
>  include/linux/mmzone.h         |   5 +-
>  include/linux/page-isolation.h |   6 +-
>  mm/internal.h                  |   6 +
>  mm/memory_hotplug.c            |   3 +-
>  mm/page_alloc.c                | 191 +++++-------------
>  mm/page_isolation.c            | 345 +++++++++++++++++++++++++++++++--
>  8 files changed, 392 insertions(+), 174 deletions(-)

Reverting this series fixed a deadlock during memory offline/online
tests and then a crash.

 INFO: task kmemleak:1027 blocked for more than 120 seconds.
       Not tainted 5.18.0-rc4-next-20220426-dirty #27
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kmemleak        state:D stack:27744 pid: 1027 ppid:     2 flags:0x00000008
 Call trace:
  __switch_to
  __schedule
  schedule
  percpu_rwsem_wait
  __percpu_down_read
  percpu_down_read.constprop.0
  get_online_mems
  kmemleak_scan
  kmemleak_scan_thread
  kthread
  ret_from_fork

 Showing all locks held in the system:
 1 lock held by rcu_tasks_kthre/11:
  #0: ffffc1e2cefc17f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp
 1 lock held by rcu_tasks_rude_/12:
  #0: ffffc1e2cefc1a90 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp
 1 lock held by rcu_tasks_trace/13:
  #0: ffffc1e2cefc1db0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp
 1 lock held by khungtaskd/824:
  #0: ffffc1e2cefc2820 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks
 2 locks held by kmemleak/1027:
  #0: ffffc1e2cf1aa628 (scan_mutex){+.+.}-{3:3}, at: kmemleak_scan_thread
  #1: ffffc1e2cf14e690 (mem_hotplug_lock){++++}-{0:0}, at: get_online_mems
 2 locks held by cppc_fie/1805:
 1 lock held by in:imklog/2822:
 8 locks held by tee/3334:
  #0: ffff0816d65c9438 (sb_writers#6){.+.+}-{0:0}, at: vfs_write
  #1: ffff40025438be88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter
  #2: ffff4000c8261eb0 (kn->active#298){.+.+}-{0:0}, at: kernfs_fop_write_iter
  #3: ffffc1e2d0013f68 (device_hotplug_lock){+.+.}-{3:3}, at: online_store
  #4: ffff0800cd8bb998 (&dev->mutex){....}-{3:3}, at: device_offline
  #5: ffffc1e2ceed3750 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock
  #6: ffffc1e2cf14e690 (mem_hotplug_lock){++++}-{0:0}, at: offline_pages
  #7: ffffc1e2cf13bf68 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable
 __zone_set_pageset_high_and_batch at mm/page_alloc.c:7005
 (inlined by) zone_pcp_disable at mm/page_alloc.c:9286

Later, running some kernel compilation workloads could trigger a crash.

 Unable to handle kernel paging request at virtual address fffffbfffe000030
 KASAN: maybe wild-memory-access in range [0x0003dffff0000180-0x0003dffff0000187]
 Mem abort info:
   ESR = 0x96000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000006
   CM = 0, WnR = 0
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000817545fd000
 [fffffbfffe000030] pgd=00000817581e9003, p4d=00000817581e9003, pud=00000817581ea003, pmd=0000000000000000
 Internal error: Oops: 96000006 [#1] PREEMPT SMP
 Modules linked in: bridge stp llc cdc_ether usbnet ipmi_devintf ipmi_msghandler cppc_cpufreq fuse ip_tables x_tables ipv6 btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq zstd_compress dm_mod nouveau drm_ttm_helper ttm crct10dif_ce mlx5_core drm_display_helper drm_kms_helper nvme mpt3sas xhci_pci nvme_core drm raid_class xhci_pci_renesas
 CPU: 147 PID: 3334 Comm: tee Not tainted 5.18.0-rc4-next-20220426-dirty #27
 pstate: 10400009 (nzcV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : isolate_single_pageblock
 lr : isolate_single_pageblock
 sp : ffff80003e767500
 x29: ffff80003e767500 x28: 0000000000000000 x27: ffff783c59963b1f
 x26: dfff800000000000 x25: ffffc1e2ccb1d000 x24: ffffc1e2ccb1d8f8
 x23: 00000000803bfe00 x22: ffffc1e2cee39098 x21: 0000000000000020
 x20: 00000000803c0000 x19: fffffbfffe000000 x18: ffffc1e2cee37d1c
 x17: 0000000000000000 x16: 1fffe8004a86f14c x15: 1fffe806c89e154a
 x14: 1fffe8004a86f11c x13: 0000000000000004 x12: ffff783c5c455e6d
 x11: 1ffff83c5c455e6c x10: ffff783c5c455e6c x9 : dfff800000000000
 x8 : ffffc1e2e22af363 x7 : 0000000000000001 x6 : 0000000000000003
 x5 : ffffc1e2e22af360 x4 : ffff783c5c455e6c x3 : ffff700007cece90
 x2 : 0000000000000003 x1 : 0000000000000000 x0 : fffffbfffe000030
 Call trace:
 Call trace:
  isolate_single_pageblock
  PageBuddy at ./include/linux/page-flags.h:969 (discriminator 3)
  (inlined by) isolate_single_pageblock at mm/page_isolation.c:414 (discriminator 3)
  start_isolate_page_range
  offline_pages
  memory_subsys_offline
  device_offline
  online_store
  dev_attr_store
  sysfs_kf_write
  kernfs_fop_write_iter
  new_sync_write
  vfs_write
  ksys_write
  __arm64_sys_write
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 Code: 38fa6821 7100003f 7a411041 54000dca (b9403260)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: 0x41e2c0720000 from 0xffff800008000000
 PHYS_OFFSET: 0x80000000
 CPU features: 0x000,0021700d,19801c82
 Memory Limit: none
