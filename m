Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7455299D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 05:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbiFUDLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbiFUDL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:11:28 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7488F1F2FC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:11:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VH.Hjy._1655781080;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VH.Hjy._1655781080)
          by smtp.aliyun-inc.com;
          Tue, 21 Jun 2022 11:11:20 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com
Cc:     guoren@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] mm: fixup validation of buddy pfn
Date:   Tue, 21 Jun 2022 11:11:18 +0800
Message-Id: <20220621031118.3650529-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RISC-V arch the first 2MB RAM could be reserved for opensbi,
and the arch code may don't create pages for the first 2MB RAM,
so it would have pfn_base=512 and mem_map began with 512th PFN when
CONFIG_FLATMEM=y.

But __find_buddy_pfn algorithm thinks the start PFN 0, it could get
0 PFN or less than the pfn_base value, so page_is_buddy() can't
verify the page whose PFN is 0 ~ 511, actually we don't have valid
pages for PFN 0 ~ 511.

Actually, buddy system should not assume Arch cretaed pages for
reserved memory, Arch may don't know the implied limitation.
With this patch, we can gurantee a valid buddy no matter what we
have pages for reserved memory or not.

Fixes: 8170ac4700d26f65 ("mm: wrap __find_buddy_pfn() with a necessary buddy page validation")
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 mm/internal.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index c0f8fbe0445b..0ec446caeb2e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -322,7 +322,8 @@ __find_buddy_pfn(unsigned long page_pfn, unsigned int order)
  * The found buddy can be a non PageBuddy, out of @page's zone, or its order is
  * not the same as @page. The validation is necessary before use it.
  *
- * Return: the found buddy page or NULL if not found.
+ * Return: the found buddy page or NULL if not found or NULL if buddy pfn is
+ *         not valid.
  */
 static inline struct page *find_buddy_page_pfn(struct page *page,
 			unsigned long pfn, unsigned int order, unsigned long *buddy_pfn)
@@ -330,6 +331,9 @@ static inline struct page *find_buddy_page_pfn(struct page *page,
 	unsigned long __buddy_pfn = __find_buddy_pfn(pfn, order);
 	struct page *buddy;
 
+	if (!pfn_valid(__buddy_pfn))
+		return NULL;
+
 	buddy = page + (__buddy_pfn - pfn);
 	if (buddy_pfn)
 		*buddy_pfn = __buddy_pfn;
-- 
2.17.1

