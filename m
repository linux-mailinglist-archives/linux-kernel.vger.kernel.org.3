Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA152C911
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiESA6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiESA6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:58:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA10A3C49C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:58:27 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3Wf74Wk2zgYNG;
        Thu, 19 May 2022 08:57:03 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 08:58:26 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 08:58:25 +0800
Message-ID: <d927a335-a70b-48d3-9645-1d33cc88bd9c@huawei.com>
Date:   Thu, 19 May 2022 08:58:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <hannes@cmpxchg.org>, <kirill.shutemov@linux.intel.com>,
        <npiggin@suse.de>, <linux-mm@kvack.org>,
        <n-horiguchi@ah.jp.nec.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>
From:   mawupeng <mawupeng1@huawei.com>
Subject: Warning on isolate tail page in isolate_lru_page
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

Recently I receive a warning in isolate_lru_page() reported by syzkaller.
This warning occurred in linux-v5.10 and can't be be reproduced.

The following two commits are the major changes since v5.10:

Commit ac1e9acc5acf ("mm: rearrange madvise code to allow for reuse") refactor
do_madvise in master and lead to call madvise_vma_behavior() instead of
madvise_vma(). For page out these is no difference because both all them will
call madvise_pageout() int the end.

Commit a72afd873089 ("tlb: mmu_gather: Remove start/end arguments from tlb_gather_mmu()")
remove start/end arguments from tlb_gather_mmu in madvise_pageout() since they
are no longer needed.

Warn msg "trying to isolate tail page" will be reported in isolate_lru_page()
if this page is a tail page.

However, if this page is a tail page, it will be split in
madvise_cold_or_pageout_pte_range(). Read lock mmap_read_lock(mm) is hold since
do_madvise() so no one can modify this. So the only reason I can image is
that something is wrong in split_huge_page().

do_madvise
     mmap_read_lock(mm);
         madvise_pageout
             madvise_cold_or_pageout_pte_range
                 split_huge_page(page) <-- split this huge page
                 isolate_lru_page(page)
                     WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");

The warning log is shown below:
==============================================================

WARNING: CPU: 1 PID: 26735 at mm/vmscan.c:1968 isolate_lru_page+0x44d/0x460 mm/vmscan.c:1968
Modules linked in:
RAX: 06bc73006006b800 RBX: 0000000000000001 RCX: 0000000009400000
RDX: ffffc90016103000 RSI: 0000000000000344 RDI: 0000000000000345
RBP: 0000000000000001 R08: ffffffff8a58bab9 R09: ffffed100c4c4f23
R10: ffffed100c4c4f23 R11: 1ffff1100c4c4f22 R12: ffffea0001d59a00
R13: ffffea0001d59bc0 R14: ffffea0001d59bc8 R15: 0000000020ffb000
FS:  00007f00b4284700(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000007541ff CR3: 0000000033dec004 CR4: 00000000003706e0
Call Trace:
  madvise_cold_or_pageout_pte_range+0x511/0x6d0 mm/madvise.c:460
  walk_pmd_range mm/pagewalk.c:89 [inline]
  walk_pud_range mm/pagewalk.c:160 [inline]
  walk_p4d_range+0x7f3/0xdb0 mm/pagewalk.c:193
  walk_pgd_range+0x2d3/0x360 mm/pagewalk.c:229
  __walk_page_range+0xda/0x360 mm/pagewalk.c:331
  walk_page_range+0x166/0x380 mm/pagewalk.c:427
  madvise_vma mm/madvise.c:520 [inline]
  do_madvise+0x159d/0x1810 mm/madvise.c:1137
  __do_sys_madvise mm/madvise.c:1163 [inline]
  __se_sys_madvise mm/madvise.c:1161 [inline]
  __x64_sys_madvise+0x5d/0x70 mm/madvise.c:1161
  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

I have no idea how to fix this warning, so is there anything else need to
analysis that I haven't considered?

Thanks.
