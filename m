Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390F648630A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiAFKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:40:23 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46389 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237909AbiAFKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:40:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V15yZ6T_1641465619;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V15yZ6T_1641465619)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 18:40:20 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     dan.carpenter@oracle.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Remove redundant page validation
Date:   Thu,  6 Jan 2022 18:40:11 +0800
Message-Id: <cd28052e89166d4ab90e360cce3421748076a0fc.1641465458.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will never get a NULL page by pte_page(), thus remove the redundant
page validation to fix below Smatch static checker warning.

mm/damon/vaddr.c:405 damon_hugetlb_mkold()
warn: 'page' can't be NULL.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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

