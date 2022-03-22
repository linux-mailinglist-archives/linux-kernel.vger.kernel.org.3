Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDA64E3E38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiCVMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiCVMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:16:23 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B74C6AA5A;
        Tue, 22 Mar 2022 05:14:54 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 7E5F51E80D24;
        Tue, 22 Mar 2022 20:14:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0eSG7M0PoPWY; Tue, 22 Mar 2022 20:14:01 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 3C0DE1E80D06;
        Tue, 22 Mar 2022 20:14:01 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     naoya.horiguchi@nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com, liqiong <liqiong@nfschina.com>
Subject: [PATCH] mm: remove unnecessary (void*) conversions.
Date:   Tue, 22 Mar 2022 20:13:38 +0800
Message-Id: <20220322121338.27428-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct hwp_walk*).

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 97a9ed8f87a9..4ed0dcf03659 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -630,7 +630,7 @@ static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
 static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 			      unsigned long end, struct mm_walk *walk)
 {
-	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
+	struct hwp_walk *hwp = walk->private;
 	int ret = 0;
 	pte_t *ptep, *mapped_pte;
 	spinlock_t *ptl;
@@ -664,7 +664,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			    unsigned long addr, unsigned long end,
 			    struct mm_walk *walk)
 {
-	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
+	struct hwp_walk *hwp = walk->private;
 	pte_t pte = huge_ptep_get(ptep);
 	struct hstate *h = hstate_vma(walk->vma);
 
-- 
2.11.0

