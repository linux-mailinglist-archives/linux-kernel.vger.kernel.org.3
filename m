Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3374BC9B1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbiBSSF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:05:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiBSSF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:05:58 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467260045
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:05:35 -0800 (PST)
X-QQ-mid: bizesmtp69t1645293913t7knxfog
Received: from localhost.localdomain (unknown [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 02:04:52 +0800 (CST)
X-QQ-SSF: 01400000000000D0N000B00A0000000
X-QQ-FEAT: l2baldexF9l31JYpc/mQabxD4TJZaEAyqM+u9vrz/2Wzx8oahLNxbfg6cFCMc
        lzPJluj2xovT7H0ygkSZwoHxQfhVpdLOVe/331kflsGtjCx2zIXpkbiNG4GhgzLdpHO8HMD
        D0zNVYJfkRKsf+fgHEQobMtYML/JXi62G9T9umb1H+bXhiAHTwyCC4SOlAk0fB8HN2Jp1+D
        Z2hgID0T+kP5eWQ+8GGdAcCiaHi5u5lCmAZMQN3APk3j3JO08YFYUqNP8UeQLuG6HWZu46x
        0tTcQcGkw6bOxmj9o+cgQTqUnUwFOVL5CeVXwWAcF9uvp2ZxtnrozlCNLXDWqAEiFnu7mzm
        v/JHNdN
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm/page_owner.c: record tgid
Date:   Sun, 20 Feb 2022 02:04:50 +0800
Message-Id: <20220219180450.2399-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a single-threaded process,
the pid in kernel task_struct is the same as the tgid,
which can mark the process of page allocation.
But in a multithreaded process,
only the task_struct of the thread leader
has the same pid as tgid,
and the pids of other threads are different from tgid.
Therefore, tgid is recorded to provide effective information
for debugging and data statistics of multithreaded programs.

This can also be achieved by observing the
task name (executable file name) for a specific process.
However, when the same program is started multiple times,
the task name is the same and the tgid is different.
Therefore, in the debugging of multi-threaded programs,
combined with the task name and tgid,
more accurate runtime information of a certain run
of the program can be obtained.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 mm/page_owner.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index d56afa9c792e..0a9588506571 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -31,6 +31,7 @@ struct page_owner {
 	u64 free_ts_nsec;
 	char comm[TASK_COMM_LEN];
 	pid_t pid;
+	pid_t tgid;
 };
 
 static bool page_owner_enabled = false;
@@ -165,6 +166,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->gfp_mask = gfp_mask;
 		page_owner->last_migrate_reason = -1;
 		page_owner->pid = current->pid;
+		page_owner->tgid = current->tgid;
 		page_owner->ts_nsec = local_clock();
 		strlcpy(page_owner->comm, current->comm,
 			sizeof(page_owner->comm));
@@ -233,6 +235,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 		old_page_owner->last_migrate_reason;
 	new_page_owner->handle = old_page_owner->handle;
 	new_page_owner->pid = old_page_owner->pid;
+	new_page_owner->tgid = old_page_owner->tgid;
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
 	strcpy(new_page_owner->comm, old_page_owner->comm);
@@ -383,11 +386,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		return -ENOMEM;
 
 	ret = scnprintf(kbuf, count,
-			"Page allocated via order %u, mask %#x(%pGg), pid %d (%s), ts %llu ns, free_ts %llu ns\n",
+			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu ns, free_ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
 			&page_owner->gfp_mask, page_owner->pid,
-			page_owner->comm, page_owner->ts_nsec,
-			page_owner->free_ts_nsec);
+			page_owner->tgid, page_owner->comm,
+			page_owner->ts_nsec, page_owner->free_ts_nsec);
 
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
@@ -454,10 +457,10 @@ void __dump_page_owner(const struct page *page)
 	else
 		pr_alert("page_owner tracks the page as freed\n");
 
-	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d (%s), ts %llu, free_ts %llu\n",
+	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu, free_ts %llu\n",
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
-		 page_owner->pid, page_owner->comm, page_owner->ts_nsec,
-		 page_owner->free_ts_nsec);
+		 page_owner->pid, page_owner->tgid, page_owner->comm,
+		 page_owner->ts_nsec, page_owner->free_ts_nsec);
 
 	handle = READ_ONCE(page_owner->handle);
 	if (!handle)
@@ -669,3 +672,4 @@ static int __init pageowner_init(void)
 	return 0;
 }
 late_initcall(pageowner_init)
+
-- 
2.31.1



