Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113434654E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhLASRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:17:48 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:56702 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbhLASRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:17:05 -0500
X-QQ-mid: bizesmtp36t1638382400ta57a6n1
Received: from localhost.localdomain.localdoma (unknown [202.96.137.248])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 02 Dec 2021 02:12:37 +0800 (CST)
X-QQ-SSF: 01400000002000C0L000000A0000000
X-QQ-FEAT: FXvDfBZI5O4d+vXJaVmaRyAb1bQpm8OYBEAf5xrzyf2y4jl7/DLUyO4H3+K6m
        fZ3jrXJ39FRTUgPdOdZcVCyf+8ON8AHghudFXP4AjJJdvmabZ67A1XXh3aq7Pq8nsBDeYzB
        KMzDSCmVEWtCNO8SByhzV+xRe9PLwpEKYqvTyCSsAI6f3xh//Plv9vQOj+23FwEe9WpFSHI
        QryPaf4RHZx3nZTfNTTSEihnw1YDfCHlh0EGxh6OdoCO36V2bWrqkK1gVruiM6rPUeZT3Mz
        khyJ9mbojraMg7JhuhA7lpWNHuo4GPvYzXwfPd4wkHrGhrSJH9MJNlg8G7n8UadC65Is58g
        EQnU2n0fz13yybYwgDizPtlbzrlXifi5Sno9csa
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm: fix the type of a parameter
Date:   Thu,  2 Dec 2021 02:12:36 +0800
Message-Id: <20211201181236.2315-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of "last_migrate_reason" in struct page_owner is short.
However, the type of "reason" in the argument list of following functions
__set_page_owner_migrate_reason
set_page_owner_migrate_reason

is int, which is inconsistent.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 include/linux/page_owner.h | 6 +++---
 mm/page_owner.c            | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 119a0c9d2a8b..c537315ec02f 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -13,7 +13,7 @@ extern void __set_page_owner(struct page *page,
 			unsigned short order, gfp_t gfp_mask);
 extern void __split_page_owner(struct page *page, unsigned int nr);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
-extern void __set_page_owner_migrate_reason(struct page *page, int reason);
+extern void __set_page_owner_migrate_reason(struct page *page, short reason);
 extern void __dump_page_owner(const struct page *page);
 extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone);
@@ -41,7 +41,7 @@ static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
 	if (static_branch_unlikely(&page_owner_inited))
 		__folio_copy_owner(newfolio, old);
 }
-static inline void set_page_owner_migrate_reason(struct page *page, int reason)
+static inline void set_page_owner_migrate_reason(struct page *page, short reason)
 {
 	if (static_branch_unlikely(&page_owner_inited))
 		__set_page_owner_migrate_reason(page, reason);
@@ -66,7 +66,7 @@ static inline void split_page_owner(struct page *page,
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
 {
 }
-static inline void set_page_owner_migrate_reason(struct page *page, int reason)
+static inline void set_page_owner_migrate_reason(struct page *page, short reason)
 {
 }
 static inline void dump_page_owner(const struct page *page)
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4f924957ce7a..4c23e910caf9 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -182,7 +182,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 }
 
-void __set_page_owner_migrate_reason(struct page *page, int reason)
+void __set_page_owner_migrate_reason(struct page *page, short reason)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
-- 
2.31.1



