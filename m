Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333254719CB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhLLLcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:32:23 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41176 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhLLLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:32:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V-JZpjp_1639308731;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-JZpjp_1639308731)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Dec 2021 19:32:12 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] mm: Add a debug interface to control the range of speculative numa fault
Date:   Sun, 12 Dec 2021 19:31:58 +0800
Message-Id: <913a8a5282d265dc771309ca552c9c62c247c2b0.1639306956.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
References: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
References: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debug interface to control the range of speculative numa fault,
which can be used to tuning the performance or event close the speculative
numa fault window for some workloads.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2c9ed63e4e23..a0f4a2a008cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4052,7 +4052,29 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 static unsigned long fault_around_bytes __read_mostly =
 	rounddown_pow_of_two(65536);
 
+static unsigned long numa_around_bytes __read_mostly;
+
 #ifdef CONFIG_DEBUG_FS
+static int numa_around_bytes_get(void *data, u64 *val)
+{
+	*val = numa_around_bytes;
+	return 0;
+}
+
+static int numa_around_bytes_set(void *data, u64 val)
+{
+	if (val / PAGE_SIZE > PTRS_PER_PTE)
+		return -EINVAL;
+	if (val > PAGE_SIZE)
+		numa_around_bytes = rounddown_pow_of_two(val);
+	else
+		numa_around_bytes = 0; /* rounddown_pow_of_two(0) is undefined */
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(numa_around_bytes_fops,
+			 numa_around_bytes_get,
+			 numa_around_bytes_set, "%llu\n");
+
 static int fault_around_bytes_get(void *data, u64 *val)
 {
 	*val = fault_around_bytes;
@@ -4080,6 +4102,8 @@ static int __init fault_around_debugfs(void)
 {
 	debugfs_create_file_unsafe("fault_around_bytes", 0644, NULL, NULL,
 				   &fault_around_bytes_fops);
+	debugfs_create_file_unsafe("numa_around_bytes", 0644, NULL, NULL,
+				   &numa_around_bytes_fops);
 	return 0;
 }
 late_initcall(fault_around_debugfs);
@@ -4348,10 +4372,13 @@ static bool try_next_numa_page(struct vm_fault *vmf, unsigned int win_pages,
 	((win) & NUMA_FAULT_WINDOW_SIZE_MASK))
 
 static inline unsigned int numa_fault_max_pages(struct vm_area_struct *vma,
-						unsigned long fault_address)
+						unsigned long fault_address,
+						unsigned long numa_around_size)
 {
+	unsigned long numa_around_addr =
+		(fault_address + numa_around_size) & PAGE_MASK;
 	unsigned long pmd_end_addr = (fault_address & PMD_MASK) + PMD_SIZE;
-	unsigned long max_fault_addr = min_t(unsigned long, pmd_end_addr,
+	unsigned long max_fault_addr = min3(numa_around_addr, pmd_end_addr,
 					    vma->vm_end);
 
 	return (max_fault_addr - fault_address - 1) >> PAGE_SHIFT;
@@ -4360,12 +4387,24 @@ static inline unsigned int numa_fault_max_pages(struct vm_area_struct *vma,
 static unsigned int adjust_numa_fault_window(struct vm_area_struct *vma,
 					     unsigned long fault_address)
 {
+	unsigned long numa_around_size = READ_ONCE(numa_around_bytes);
 	unsigned long numafault_ahead = GET_NUMA_FAULT_INFO(vma);
         unsigned long prev_start = NUMA_FAULT_WINDOW_START(numafault_ahead);
         unsigned int prev_pages = NUMA_FAULT_WINDOW_SIZE(numafault_ahead);
 	unsigned long win_start;
 	unsigned int win_pages, max_fault_pages;
 
+	/*
+	 * Shut down the proactive numa fault if the numa_around_bytes
+	 * is set to 0.
+	 */
+	if (!numa_around_size) {
+		if (numafault_ahead)
+			atomic_long_set(&vma->numafault_ahead_info,
+					NUMA_FAULT_INFO(0, 0));
+		return 0;
+	}
+
 	win_start = fault_address + PAGE_SIZE;
 
 	/*
@@ -4437,7 +4476,8 @@ static unsigned int adjust_numa_fault_window(struct vm_area_struct *vma,
 	 * Make sure the size of ahead numa fault address is less than the
 	 * size of current VMA or PMD.
 	 */
-	max_fault_pages = numa_fault_max_pages(vma, fault_address);
+	max_fault_pages = numa_fault_max_pages(vma, fault_address,
+					       numa_around_size);
 	if (win_pages > max_fault_pages)
 		win_pages = max_fault_pages;
 
-- 
2.27.0

