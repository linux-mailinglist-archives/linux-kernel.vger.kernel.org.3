Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755C0490040
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 03:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiAQCeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 21:34:36 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:35447 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230132AbiAQCeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:34:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V1ziwmF_1642386869;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V1ziwmF_1642386869)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jan 2022 10:34:29 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/damon: Remove redundant page validation
Date:   Mon, 17 Jan 2022 10:34:18 +0800
Message-Id: <6d32f7d201b8970d53f51b6c5717d472aed2987c.1642386715.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will never get a NULL page by pte_page() as discussed in thread [1],
thus remove the redundant page validation to fix below Smatch static
checker warning.

    mm/damon/vaddr.c:405 damon_hugetlb_mkold()
    warn: 'page' can't be NULL.

[1] https://lore.kernel.org/linux-mm/20220106091200.GA14564@kili/

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
Changes from v1:
 - Improve the commit message suggested by SeongJae.
 - Add reviewed-by tag from SeongJae.
---
 mm/damon/vaddr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 89b6468d..8a52e00 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -402,9 +402,6 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 	pte_t entry = huge_ptep_get(pte);
 	struct page *page = pte_page(entry);
 
-	if (!page)
-		return;
-
 	get_page(page);
 
 	if (pte_young(entry)) {
@@ -564,9 +561,6 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 		goto out;
 
 	page = pte_page(entry);
-	if (!page)
-		goto out;
-
 	get_page(page);
 
 	if (pte_young(entry) || !page_is_idle(page) ||
-- 
1.8.3.1

