Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57B597F63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbiHRHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243740AbiHRHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:38:04 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755AEA261B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:38:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VMZnOiw_1660808276;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMZnOiw_1660808276)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 15:37:57 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
        mike.kravetz@oracle.com, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon: replace pmd_huge() with pmd_trans_huge() for THP
Date:   Thu, 18 Aug 2022 15:37:44 +0800
Message-Id: <a9e010ca5d299e18d740c7c52290ecb6a014dde6.1660805030.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmd_huge() is usually used to indicate if a pmd level hugetlb,
however a pmd mapped huge page can only be THP in damon_mkold_pmd_entry()
or damon_young_pmd_entry(), so replacing pmd_huge() with pmd_trans_huge()
in this case to make code more readable according to the discussion [1].

[1] https://lore.kernel.org/all/098c1480-416d-bca9-cedb-ca495df69b64@linux.alibaba.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 - New patch in v2.
---
 mm/damon/vaddr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1d16c6c..cc04d46 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -302,14 +302,14 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	if (pmd_huge(*pmd)) {
+	if (pmd_trans_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
 		if (!pmd_present(*pmd)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (pmd_huge(*pmd)) {
+		if (pmd_trans_huge(*pmd)) {
 			damon_pmdp_mkold(pmd, walk->mm, addr);
 			spin_unlock(ptl);
 			return 0;
@@ -434,14 +434,14 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damon_young_walk_private *priv = walk->private;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_huge(*pmd)) {
+	if (pmd_trans_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
 		if (!pmd_present(*pmd)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (!pmd_huge(*pmd)) {
+		if (!pmd_trans_huge(*pmd)) {
 			spin_unlock(ptl);
 			goto regular_page;
 		}
-- 
1.8.3.1

