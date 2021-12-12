Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD05C4719CD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhLLLc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:32:26 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50923 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhLLLcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:32:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V-JZpk0_1639308732;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-JZpk0_1639308732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Dec 2021 19:32:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] mm: Add speculative numa fault stats
Date:   Sun, 12 Dec 2021 19:31:59 +0800
Message-Id: <bb19a1a3997a2424d13da02c6e7297e624e09a4f.1639306956.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
References: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
References: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new statistic to help to tune the speculative numa fault window.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/vm_event_item.h | 1 +
 mm/memory.c                   | 2 ++
 mm/vmstat.c                   | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index a185cc75ff52..97cdc661b7da 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -62,6 +62,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_MIGRATION_SUCCESS,
 		THP_MIGRATION_FAIL,
 		THP_MIGRATION_SPLIT,
+		PGMIGRATE_SPECULATION,
 #endif
 #ifdef CONFIG_COMPACTION
 		COMPACTMIGRATE_SCANNED, COMPACTFREE_SCANNED,
diff --git a/mm/memory.c b/mm/memory.c
index a0f4a2a008cc..91122beb6e53 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4572,6 +4572,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
+		if (vmf->address != fault_address)
+			count_vm_events(PGMIGRATE_SPECULATION, 1);
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->pte = pte_offset_map(vmf->pmd, fault_address);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 787a012de3e2..c64700994786 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1314,6 +1314,7 @@ const char * const vmstat_text[] = {
 	"thp_migration_success",
 	"thp_migration_fail",
 	"thp_migration_split",
+	"pgmigrate_speculation",
 #endif
 #ifdef CONFIG_COMPACTION
 	"compact_migrate_scanned",
-- 
2.27.0

