Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE94FE972
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiDLU3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiDLU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:28:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398BEA27FE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649795198; x=1681331198;
  h=from:to:cc:subject:date:message-id;
  bh=U07zXEF5XKiHrZJWluQBPtBzbqwPfha91C4VetzKe+k=;
  b=MPnKibYpukiTeiB26W9N+TTrKBB6SQvdgM4+UatuPVtjGBFgHLsrPvL1
   Bk25ICjv+CH91oM6zO5bG4o7/NVpEKi1E0B4mXgdOI1DiUwRj0wkZFeBD
   02OS564KT8q7HH2ePzoCMKYs8E8DkQhnEYYj7UJn/0eN4+KTHTXx6Zsvq
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Apr 2022 13:17:03 -0700
X-QCInternal: smtphost
Received: from th-lint-014.qualcomm.com ([10.63.177.51])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 12 Apr 2022 13:17:02 -0700
Received: by th-lint-014.qualcomm.com (Postfix, from userid 455663)
        id DEC2B139C; Tue, 12 Apr 2022 13:17:02 -0700 (PDT)
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] mm, page_alloc: check pfn is valid before moving to freelist
Date:   Tue, 12 Apr 2022 13:16:23 -0700
Message-Id: <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1649794059.git.quic_sudaraja@quicinc.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com>
In-Reply-To: <cover.1649794059.git.quic_sudaraja@quicinc.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if pfn is valid before or not before moving it to freelist.

There are possible scenario where a pageblock can have partial physical
hole and partial part of System RAM. This happens when base address in RAM
partition table is not aligned to pageblock size.

Example:

Say we have this first two entries in RAM partition table -

Base Addr: 0x0000000080000000 Length: 0x0000000058000000
Base Addr: 0x00000000E3930000 Length: 0x0000000020000000
...

Physical hole: 0xD8000000 - 0xE3930000

On system having 4K as page size and hence pageblock size being 4MB, the
base address 0xE3930000 is not aligned to 4MB pageblock size.

Now we will have pageblock which has partial physical hole and partial part
of System RAM -

Pageblock [0xE3800000 - 0xE3C00000] -
	0xE3800000 - 0xE3930000 -- physical hole
	0xE3930000 - 0xE3C00000 -- System RAM

Now doing __alloc_pages say we get a valid page with PFN 0xE3B00 from
__rmqueue_fallback, we try to put other pages from the same pageblock as well
into freelist by calling steal_suitable_fallback().

We then search for freepages from start of the pageblock due to below code -

 move_freepages_block(zone, page, migratetype, ...)
{
    pfn = page_to_pfn(page);
    start_pfn = pfn & ~(pageblock_nr_pages - 1);
    end_pfn = start_pfn + pageblock_nr_pages - 1;
...
}

With the pageblock which has partial physical hole at the beginning, we will
run into PFNs from the physical hole whose struct page is not initialized and
is invalid, and system would crash as we operate on invalid struct page to find
out of page is in Buddy or LRU or not

[  107.629453][ T9688] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  107.639214][ T9688] Mem abort info:
[  107.642829][ T9688]   ESR = 0x96000006
[  107.646696][ T9688]   EC = 0x25: DABT (current EL), IL = 32 bits
[  107.652878][ T9688]   SET = 0, FnV = 0
[  107.656751][ T9688]   EA = 0, S1PTW = 0
[  107.660705][ T9688]   FSC = 0x06: level 2 translation fault
[  107.666455][ T9688] Data abort info:
[  107.670151][ T9688]   ISV = 0, ISS = 0x00000006
[  107.674827][ T9688]   CM = 0, WnR = 0
[  107.678615][ T9688] user pgtable: 4k pages, 39-bit VAs, pgdp=000000098a237000
[  107.685970][ T9688] [0000000000000000] pgd=0800000987170003, p4d=0800000987170003, pud=0800000987170003, pmd=0000000000000000
[  107.697582][ T9688] Internal error: Oops: 96000006 [#1] PREEMPT SMP

[  108.209839][ T9688] pc : move_freepages_block+0x174/0x27c
[  108.215407][ T9688] lr : steal_suitable_fallback+0x20c/0x398

[  108.305908][ T9688] Call trace:
[  108.309151][ T9688]  move_freepages_block+0x174/0x27c        [PageLRU]
[  108.314359][ T9688]  steal_suitable_fallback+0x20c/0x398
[  108.319826][ T9688]  rmqueue_bulk+0x250/0x934
[  108.324325][ T9688]  rmqueue_pcplist+0x178/0x2ac
[  108.329086][ T9688]  rmqueue+0x5c/0xc10
[  108.333048][ T9688]  get_page_from_freelist+0x19c/0x430
[  108.338430][ T9688]  __alloc_pages+0x134/0x424
[  108.343017][ T9688]  page_cache_ra_unbounded+0x120/0x324
[  108.348494][ T9688]  do_sync_mmap_readahead+0x1b0/0x234
[  108.353878][ T9688]  filemap_fault+0xe0/0x4c8
[  108.358375][ T9688]  do_fault+0x168/0x6cc
[  108.362518][ T9688]  handle_mm_fault+0x5c4/0x848
[  108.367280][ T9688]  do_page_fault+0x3fc/0x5d0
[  108.371867][ T9688]  do_translation_fault+0x6c/0x1b0
[  108.376985][ T9688]  do_mem_abort+0x68/0x10c
[  108.381389][ T9688]  el0_ia+0x50/0xbc
[  108.385175][ T9688]  el0t_32_sync_handler+0x88/0xbc
[  108.390208][ T9688]  el0t_32_sync+0x1b8/0x1bc

Hence, avoid operating on invalid pages within the same pageblock by checking
if pfn is valid or not.

Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Fixes: 4c7b9896621be ("mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE")
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6e5b448..e87aa053 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2521,6 +2521,11 @@ static int move_freepages(struct zone *zone,
 	int pages_moved = 0;
 
 	for (pfn = start_pfn; pfn <= end_pfn;) {
+		if (!pfn_valid(pfn)) {
+			pfn++;
+			continue;
+		}
+
 		page = pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
 			/*
-- 
2.7.4

