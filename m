Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847B53D4A7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiFDBcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiFDBcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:32:43 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F136B13CD4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:32:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VFH9Sln_1654306358;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VFH9Sln_1654306358)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jun 2022 09:32:39 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mm: Factor out the pagetable pages account into new helper function
Date:   Sat,  4 Jun 2022 09:32:29 +0800
Message-Id: <809544e284d35caf72aa66bf7214a1ef006cad40.1654271618.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
References: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
References: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the pagetable pages account into new helper functions to avoid
duplicated code. Meanwhile these helper functions also will be used to
account pagetable pages which do not need split pagetale lock.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/mm.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8a96197..1ce3366 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2358,20 +2358,30 @@ static inline void pgtable_init(void)
 	pgtable_cache_init();
 }
 
+static inline void pgtable_set_and_inc(struct page *page)
+{
+	__SetPageTable(page);
+	inc_lruvec_page_state(page, NR_PAGETABLE);
+}
+
+static inline void pgtable_clear_and_dec(struct page *page)
+{
+	__ClearPageTable(page);
+	dec_lruvec_page_state(page, NR_PAGETABLE);
+}
+
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	pgtable_set_and_inc(page);
 	return true;
 }
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
 	ptlock_free(page);
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pgtable_clear_and_dec(page);
 }
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2457,16 +2467,14 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
 	if (!pmd_ptlock_init(page))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	pgtable_set_and_inc(page);
 	return true;
 }
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
 	pmd_ptlock_free(page);
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pgtable_clear_and_dec(page);
 }
 
 /*
-- 
1.8.3.1

