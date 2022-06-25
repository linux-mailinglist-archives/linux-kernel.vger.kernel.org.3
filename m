Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1955A87C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiFYJdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiFYJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:33:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262F3057E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:33:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LVTKF74c2zkWNs;
        Sat, 25 Jun 2022 17:32:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 25 Jun
 2022 17:33:47 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <ying.huang@intel.com>,
        <songmuchun@bytedance.com>, <quic_qiancai@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 1/2] mm/swapfile: fix possible data races of inuse_pages
Date:   Sat, 25 Jun 2022 17:33:45 +0800
Message-ID: <20220625093346.48894-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220625093346.48894-1-linmiaohe@huawei.com>
References: <20220625093346.48894-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

si->inuse_pages could still be accessed concurrently now. The plain reads
outside si->lock critical section, i.e. swap_show and si_swapinfo, which
results in data races. READ_ONCE and WRITE_ONCE is used to fix such data
races. Note these data races should be ok because they're just used for
showing swap info.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/swapfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index edc3420d30e7..5c8681a3f1d9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -695,7 +695,7 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 		si->lowest_bit += nr_entries;
 	if (end == si->highest_bit)
 		WRITE_ONCE(si->highest_bit, si->highest_bit - nr_entries);
-	si->inuse_pages += nr_entries;
+	WRITE_ONCE(si->inuse_pages, si->inuse_pages + nr_entries);
 	if (si->inuse_pages == si->pages) {
 		si->lowest_bit = si->max;
 		si->highest_bit = 0;
@@ -732,7 +732,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			add_to_avail_list(si);
 	}
 	atomic_long_add(nr_entries, &nr_swap_pages);
-	si->inuse_pages -= nr_entries;
+	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
 			si->bdev->bd_disk->fops->swap_slot_free_notify;
@@ -2641,7 +2641,7 @@ static int swap_show(struct seq_file *swap, void *v)
 	}
 
 	bytes = si->pages << (PAGE_SHIFT - 10);
-	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
+	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
 
 	file = si->swap_file;
 	len = seq_file_path(swap, file, " \t\n\\");
@@ -3260,7 +3260,7 @@ void si_swapinfo(struct sysinfo *val)
 		struct swap_info_struct *si = swap_info[type];
 
 		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
-			nr_to_be_unused += si->inuse_pages;
+			nr_to_be_unused += READ_ONCE(si->inuse_pages);
 	}
 	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
 	val->totalswap = total_swap_pages + nr_to_be_unused;
-- 
2.23.0

