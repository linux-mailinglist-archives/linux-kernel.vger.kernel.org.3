Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C304D5E08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiCKJCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245586AbiCKJCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:02:35 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F0C51BB73A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:01:30 -0800 (PST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx7xPgDytiQD0HAA--.2826S2;
        Fri, 11 Mar 2022 17:01:20 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/khugepaged: sched to numa node when collapse huge page
Date:   Fri, 11 Mar 2022 04:01:19 -0500
Message-Id: <20220311090119.2412738-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx7xPgDytiQD0HAA--.2826S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47ZFW8uw1UXFW8GFWxZwb_yoW8CryUpF
        WUtw4UGrWUJr1vgr1Iqan8AryFqr1kJFWktw1fAas7t3s0qr4FgFy5Za15A34UJFWkGFW3
        ArWavrn09r48J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

collapse huge page is slow, specially when khugepaged daemon runs
on different numa node with that of huge page. It suffers from
huge page copying across nodes, also cache is not used for target
node. With this patch, khugepaged daemon switches to the same numa
node with huge page. It saves copying time and makes use of local
cache better.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 mm/khugepaged.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 131492fd1148..460c285dc974 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -116,6 +116,7 @@ struct khugepaged_scan {
 	struct list_head mm_head;
 	struct mm_slot *mm_slot;
 	unsigned long address;
+	int node;
 };
 
 static struct khugepaged_scan khugepaged_scan = {
@@ -1066,6 +1067,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	struct mmu_notifier_range range;
 	gfp_t gfp;
+	const struct cpumask *cpumask;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
@@ -1079,6 +1081,13 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 * that. We will recheck the vma after taking it again in write mode.
 	 */
 	mmap_read_unlock(mm);
+
+	/* sched to specified node before huage page memory copy */
+	cpumask = cpumask_of_node(node);
+	if ((khugepaged_scan.node != node) && !cpumask_empty(cpumask)) {
+		set_cpus_allowed_ptr(current, cpumask);
+		khugepaged_scan.node = node;
+	}
 	new_page = khugepaged_alloc_page(hpage, gfp, node);
 	if (!new_page) {
 		result = SCAN_ALLOC_HUGE_PAGE_FAIL;
@@ -2380,6 +2389,7 @@ int start_stop_khugepaged(void)
 		kthread_stop(khugepaged_thread);
 		khugepaged_thread = NULL;
 	}
+	khugepaged_scan.node = NUMA_NO_NODE;
 	set_recommended_min_free_kbytes();
 fail:
 	mutex_unlock(&khugepaged_mutex);
-- 
2.31.1

