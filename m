Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104624FE973
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiDLU3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiDLU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:28:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DDAE0ACC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649795196; x=1681331196;
  h=from:to:cc:subject:date:message-id;
  bh=wzMgb7GR+grF1fIvEBxI4JfuKlzfjR11uwpwF7cfEU0=;
  b=TFten+KEnTeg44mUbyt1dR4KwKX3Sy6f7Za+2WjLRiqllcBxygfth7Jy
   j7KIrhemS6lRPdcpyPw9Ews2ju+IFoZukJU/WPlVVeERlPp0Z9q2vi5Co
   3uBmB6XoGzAHWgfLoKHNN4HPEIM8AZ2s4/p/YwFuackM4vD69DOmBe9ZE
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Apr 2022 13:16:55 -0700
X-QCInternal: smtphost
Received: from th-lint-014.qualcomm.com ([10.63.177.51])
  by ironmsg05-sd.qualcomm.com with ESMTP; 12 Apr 2022 13:16:55 -0700
Received: by th-lint-014.qualcomm.com (Postfix, from userid 455663)
        id 587FA139C; Tue, 12 Apr 2022 13:16:55 -0700 (PDT)
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Subject: [PATCH] mm, page_alloc: check pfn is valid before moving to freelist
Date:   Tue, 12 Apr 2022 13:16:22 -0700
Message-Id: <cover.1649794059.git.quic_sudaraja@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


[pageblock 0xE3800000 - 0xE3C00000]
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
[  107.678615][ T9688] user pgtable: 4k pages, 39-bit VAs, pgdp=000000098a237000
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


=============

Not sure what/where should be the right fix. Or are there any assumptions that
Base Addresses in RAM aprtition table should be aligned to pageblock size?
Clearly that pages within the same pageblock which has partial physical hole,
they are not being initialized and hence we would be operating on invalid pages
while doing move_freepages_block.

Thoughts or suggestions?


Sudarshan Rajagopalan (1):
  mm, page_alloc: check pfn is valid before moving to freelist

 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.7.4

