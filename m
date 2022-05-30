Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4B5537A27
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiE3Luh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiE3Lue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:50:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2428B69CF6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:50:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D72CC113E;
        Mon, 30 May 2022 04:50:32 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.36.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0F893F766;
        Mon, 30 May 2022 04:50:30 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [RFC] mm/page_isolation: Fix an infinite loop in isolate_single_pageblock()
Date:   Mon, 30 May 2022 17:20:27 +0530
Message-Id: <20220530115027.123341-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HugeTLB allocation (32MB pages on 4K base page) via sysfs on arm64 platform
is getting stuck in isolate_single_pageblock(), because of an infinite loop
Because head_pfn always evaluate the same, so does pfn, and the outer loop
never exits. Dropping the relevant code block, which seems redundant, makes
the problem go away.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
I am not sure about this fix, and also did not find much time today to
debug any further. There are much code changes around this function in
recent days. This problem is present on latest mainline kernel.

- Anshuman

 mm/page_isolation.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6021f8444b5a..b0922fee75c1 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -389,10 +389,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 			struct page *head = compound_head(page);
 			unsigned long head_pfn = page_to_pfn(head);
 
-			if (head_pfn + nr_pages <= boundary_pfn) {
-				pfn = head_pfn + nr_pages;
-				continue;
-			}
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 			/*
 			 * hugetlb, lru compound (THP), and movable compound pages
-- 
2.20.1

