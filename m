Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D705596975
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiHQGVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbiHQGVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:21:39 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F206FA31
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:21:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMUBGX4_1660717281;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMUBGX4_1660717281)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 14:21:22 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Validate if the pmd entry is present before accessing
Date:   Wed, 17 Aug 2022 14:21:12 +0800
Message-Id: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmd_huge() is used to validate if the pmd entry is mapped by a huge
page, also including the case of non-present (migration or hwpoisoned)
pmd entry on arm64 or x86 architectures. Thus we should validate if it
is present before making the pmd entry old or getting young state,
otherwise we can not get the correct corresponding page.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/damon/vaddr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6..1d16c6c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -304,6 +304,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (pmd_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
+		if (!pmd_present(*pmd)) {
+			spin_unlock(ptl);
+			return 0;
+		}
+
 		if (pmd_huge(*pmd)) {
 			damon_pmdp_mkold(pmd, walk->mm, addr);
 			spin_unlock(ptl);
@@ -431,6 +436,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
+		if (!pmd_present(*pmd)) {
+			spin_unlock(ptl);
+			return 0;
+		}
+
 		if (!pmd_huge(*pmd)) {
 			spin_unlock(ptl);
 			goto regular_page;
-- 
1.8.3.1

