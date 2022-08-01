Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E535865F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiHAIE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiHAIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:04:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9482F64D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAD4BB80E89
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47132C43142;
        Mon,  1 Aug 2022 08:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659341085;
        bh=SyAn2OHlBoyp4SJs3YcoSeH4zAJTR/slnZqVIScbiks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lb4X4JP+kNTAv0eGRJhEMXlCO1mRzMi4zoNFWWJleYiOLzI/Wai1ETeVIr/3h0u/3
         mI0r14pSSP/C04M+CHkHZL72Kvdhw86NOTOPnf+Y7dDf/2kHtBc/9WGP/gUlEGx5Eb
         xBz1XfEwKYldWQBSs14yy31vvtxQgjDmY9rHHq23iAS8DDmTQNhKN9lwJL8M+uGHV2
         iWqdH0u6tdfYyCqn6a0SOjKkI1xoIS2P5OHQcDKafsAbtXO7KMotIJk8JoAIF25Zgj
         pzqueuu6VcfX8p56Likx83mfhhgbO8grf3KLwf+x0QDt1N4qz21buo+0tXcffqJXP8
         4Q2uYr35AtWLw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 3/4] arm64/mmu: move helpers for hotplug page tables freeing close to callers
Date:   Mon,  1 Aug 2022 11:04:17 +0300
Message-Id: <20220801080418.120311-4-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220801080418.120311-1-rppt@kernel.org>
References: <20220801080418.120311-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

to minimize extra ifdefery when unmap_*() methods will be used to remap
crash kernel.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/mmu.c | 50 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index baa2dda2dcce..2f548fb2244c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -837,30 +837,6 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 	}
 }
 
-static void free_hotplug_pgtable_page(struct page *page)
-{
-	free_hotplug_page_range(page, PAGE_SIZE, NULL);
-}
-
-static bool pgtable_range_aligned(unsigned long start, unsigned long end,
-				  unsigned long floor, unsigned long ceiling,
-				  unsigned long mask)
-{
-	start &= mask;
-	if (start < floor)
-		return false;
-
-	if (ceiling) {
-		ceiling &= mask;
-		if (!ceiling)
-			return false;
-	}
-
-	if (end - 1 > ceiling - 1)
-		return false;
-	return true;
-}
-
 static void unmap_pte_range(pmd_t *pmdp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
 				    struct vmem_altmap *altmap)
@@ -993,6 +969,30 @@ static void unmap_range(unsigned long addr, unsigned long end,
 	} while (addr = next, addr < end);
 }
 
+static bool pgtable_range_aligned(unsigned long start, unsigned long end,
+				  unsigned long floor, unsigned long ceiling,
+				  unsigned long mask)
+{
+	start &= mask;
+	if (start < floor)
+		return false;
+
+	if (ceiling) {
+		ceiling &= mask;
+		if (!ceiling)
+			return false;
+	}
+
+	if (end - 1 > ceiling - 1)
+		return false;
+	return true;
+}
+
+static void free_hotplug_pgtable_page(struct page *page)
+{
+	free_hotplug_page_range(page, PAGE_SIZE, NULL);
+}
+
 static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
 				 unsigned long end, unsigned long floor,
 				 unsigned long ceiling)
@@ -1146,7 +1146,7 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 		free_empty_p4d_table(pgdp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 }
-#endif
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 #if !ARM64_KERNEL_USES_PMD_MAPS
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-- 
2.35.3

