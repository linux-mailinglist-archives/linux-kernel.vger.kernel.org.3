Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E185993EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbiHSEMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345947AbiHSEM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:12:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2DD4765
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1540BB82555
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A812C433D6;
        Fri, 19 Aug 2022 04:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660882344;
        bh=5gYyN5/YhF/Awfp/DEZJAfWB5qjBkFX3C40Sr9VWbiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4D61Oc16nqlsYrAc37zlc937iYsEazJo+ROdjVVM+XyoMCZv/SkE41jWolD090hQ
         m86h2HiDf7k+8MAoDxmfiYkLl0xoXwqtYkRacioBIAp7pTFIea1dDMtDP5JXA0CyR9
         4ja7Uft2RlR9Jasht+v9SgKYeprc7lGwcilQ7/SI/k966XK15tgZn7hvOVOMDEmmQQ
         49xHflDuMymL437/LKVd3keknFKn0yQyzNq2DrZls7S9Z69P5HCKG5DOlWckKkng1H
         mAk2Lf2RjEUfAquoHqVU+vE/tp3vBnhO3PzuhFdn6j0Ng9zCwJk7nFbQSK18/1HvVm
         iLUpNJZC87SmQ==
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
Subject: [PATCH 3/5] arm64/mmu: move helpers for hotplug page tables freeing close to callers
Date:   Fri, 19 Aug 2022 07:11:54 +0300
Message-Id: <20220819041156.873873-4-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220819041156.873873-1-rppt@kernel.org>
References: <20220819041156.873873-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index ea81e40a25cd..92267e5e9b5f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -887,30 +887,6 @@ static void free_hotplug_page_range(struct page *page, size_t size,
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
@@ -1043,6 +1019,30 @@ static void unmap_range(unsigned long addr, unsigned long end,
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
@@ -1196,7 +1196,7 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 		free_empty_p4d_table(pgdp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 }
-#endif
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 #if !ARM64_KERNEL_USES_PMD_MAPS
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-- 
2.35.3

