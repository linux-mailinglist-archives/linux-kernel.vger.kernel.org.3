Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0835D4DBFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiCQGvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiCQGvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:51:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6B97BE38
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 23:50:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axisww2jJi_bYKAA--.8164S2;
        Thu, 17 Mar 2022 14:50:24 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge page
Date:   Thu, 17 Mar 2022 02:50:24 -0400
Message-Id: <20220317065024.2635069-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axisww2jJi_bYKAA--.8164S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1DAF4DGF18Cw13uw1xXwb_yoW8WF4fpF
        WDJ3yDGrWDXry8Kws2qw1DAryrtr95trWvqw13Aan7tr98Jw10ga4UZayUAFy7JFZ7GFWf
        JrWYvrnY9F10q3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

collapse huge page will copy huge page from general small pages,
dest node is calculated from most one of source pages, however
THP daemon is not scheduled on dest node. The performance may be
poor since huge page copying across nodes, also cache is not used
for target node. With this patch, khugepaged daemon switches to
the same numa node with huge page. It saves copying time and makes
use of local cache better.

With this patch, specint 2006 base performance is improved with 6%
on Loongson 3C5000L platform with 32 cores and 8 numa nodes.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
changelog:
V2: remove node record for thp daemon
V3: remove unlikely statement
---
 mm/khugepaged.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 131492fd1148..b3cf0885f5a2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1066,6 +1066,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	struct mmu_notifier_range range;
 	gfp_t gfp;
+	const struct cpumask *cpumask;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
@@ -1079,6 +1080,13 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 * that. We will recheck the vma after taking it again in write mode.
 	 */
 	mmap_read_unlock(mm);
+
+	/* sched to specified node before huage page memory copy */
+	if (task_node(current) != node) {
+		cpumask = cpumask_of_node(node);
+		if (!cpumask_empty(cpumask))
+			set_cpus_allowed_ptr(current, cpumask);
+	}
 	new_page = khugepaged_alloc_page(hpage, gfp, node);
 	if (!new_page) {
 		result = SCAN_ALLOC_HUGE_PAGE_FAIL;
-- 
2.31.1

