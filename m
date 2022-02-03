Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB874A8377
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350375AbiBCMBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:01:32 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:33861 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiBCMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:01:31 -0500
X-QQ-mid: bizesmtp9t1643889682tzvd3pmrb
Received: from localhost.localdomain.localdoma (unknown [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Feb 2022 20:00:42 +0800 (CST)
X-QQ-SSF: 01400000008000C0M000000A0000000
X-QQ-FEAT: Mx1dxJbW4IVte//7n6tjVzHo+e1xtN7io7frxiWOysPyN2n85VaiNT+PuqEHt
        wIYNrjevUdMZNCeKMQECpLDi0Qlc0zr5zLC8Ys4XZan1eIBSIAR2YZpEFTWQ7pVfaMITGhg
        kW9De0CSaeL1rL1YvsJkDRTOiSaAoeCz8D9tfvW/om3TGtxc/zK4pOWKDk/Fdd0odXQJfrm
        rWnfev8qwyIbv+s/7e/eN8fMgEEcgZ829YY23WijoHr+ScGWrrl5WwrhVKecpmEHmxHFvZY
        43sV7+pN2lIqzL4R7ebODQaUYtVWmoSLciLcYtMn+2BBnBGiWBgQMR1WxO0LyelZWI0j+HI
        Y78gGwSjAuuLjcH0oc=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm/page_owner.c: record task name of process
Date:   Thu,  3 Feb 2022 20:00:40 +0800
Message-Id: <20220203120040.2338-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think in tracing page allocation behavior,
It is useful to record the task name of the process.

Although the current Page Owner has recorded the process ID,
When the process exits,
It is difficult to distinguish the specific function of this process,
This brings some inconvenience to debugging memory problems.

Therefore, add the task name information to the Page Owner,
So that users can clearly understand the task name of the process.
At the same time, with this information,
We can use tools/vm/page_owner_sort.c,
Provides more output modes for Page Owner.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 mm/page_owner.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 99e360df9465..a8d666cd13ac 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -29,6 +29,7 @@ struct page_owner {
 	u64 ts_nsec;
 	u64 free_ts_nsec;
 	pid_t pid;
+	char task_name[TASK_COMM_LEN];
 };
 
 static bool page_owner_enabled = false;
@@ -163,6 +164,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->gfp_mask = gfp_mask;
 		page_owner->last_migrate_reason = -1;
 		page_owner->pid = current->pid;
+		strcpy(page_owner->task_name, current->comm);
 		page_owner->ts_nsec = local_clock();
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
@@ -229,6 +231,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 		old_page_owner->last_migrate_reason;
 	new_page_owner->handle = old_page_owner->handle;
 	new_page_owner->pid = old_page_owner->pid;
+	strcpy(new_page_owner->task_name, old_page_owner->task_name);
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
 
@@ -339,9 +342,10 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		return -ENOMEM;
 
 	ret = snprintf(kbuf, count,
-			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
+			"Page allocated via order %u, mask %#x(%pGg), pid %d, task_name [%s], ts %llu ns, free_ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
 			&page_owner->gfp_mask, page_owner->pid,
+			page_owner->task_name,
 			page_owner->ts_nsec, page_owner->free_ts_nsec);
 
 	if (ret >= count)
@@ -415,9 +419,10 @@ void __dump_page_owner(const struct page *page)
 	else
 		pr_alert("page_owner tracks the page as freed\n");
 
-	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu, free_ts %llu\n",
+	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, task_name [%s], ts %llu, free_ts %llu\n",
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
-		 page_owner->pid, page_owner->ts_nsec, page_owner->free_ts_nsec);
+		 page_owner->pid, page_owner->task_name,
+		 page_owner->ts_nsec, page_owner->free_ts_nsec);
 
 	handle = READ_ONCE(page_owner->handle);
 	if (!handle)
@@ -629,3 +634,4 @@ static int __init pageowner_init(void)
 	return 0;
 }
 late_initcall(pageowner_init)
+
-- 
2.31.1



