Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267375993EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbiHSEM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbiHSEMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:12:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E7D41BD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 538FFB82555
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F87C433C1;
        Fri, 19 Aug 2022 04:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660882341;
        bh=zBIuI5xJv0DW/mdZk8va9FmpzHKWXDhqhhaqKGKSfXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQAoFAYvMa2YCWmHycPxD7RjUUKALOFfcuCjJ+ET6gwjVaBZ8zpGwlCII6ybIwIYp
         dtbZUq65yd+jjOfgLj36qfXtIMqNN7ENdkHwsq+RRb7R2lCWsbgpnTsXW7Lgnx+1p+
         lPr65UdT/vl7v5EptEhxOtmELPq/fbJXOSWLQRVNcncYtz3/v0BuLRZJfEk1HeOgqX
         FepEhVhEBTSyoK+x7RETM710mRHS1fVwe92Ip1E12u0OwAaGV+t6TERW81HD9T9BNP
         IKDBeDVG27XnSoWiA13XzEwwA11t0szOgzydrU5cvgb5u9+6ZfvyRE/rVP9h1RLonZ
         XJSsuYdQfmesw==
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
Subject: [PATCH 2/5] arm64/mmu: drop _hotplug from unmap_hotplug_* function names
Date:   Fri, 19 Aug 2022 07:11:53 +0300
Message-Id: <20220819041156.873873-3-rppt@kernel.org>
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

so that they can be used for remapping crash kernel.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/mmu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index bf303f1dea25..ea81e40a25cd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -911,7 +911,7 @@ static bool pgtable_range_aligned(unsigned long start, unsigned long end,
 	return true;
 }
 
-static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
+static void unmap_pte_range(pmd_t *pmdp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
 				    struct vmem_altmap *altmap)
 {
@@ -932,7 +932,7 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 	} while (addr += PAGE_SIZE, addr < end);
 }
 
-static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
+static void unmap_pmd_range(pud_t *pudp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
 				    struct vmem_altmap *altmap)
 {
@@ -961,11 +961,11 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 			continue;
 		}
 		WARN_ON(!pmd_table(pmd));
-		unmap_hotplug_pte_range(pmdp, addr, next, free_mapped, altmap);
+		unmap_pte_range(pmdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
-static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
+static void unmap_pud_range(p4d_t *p4dp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
 				    struct vmem_altmap *altmap)
 {
@@ -994,11 +994,11 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
 			continue;
 		}
 		WARN_ON(!pud_table(pud));
-		unmap_hotplug_pmd_range(pudp, addr, next, free_mapped, altmap);
+		unmap_pmd_range(pudp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
-static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
+static void unmap_p4d_range(pgd_t *pgdp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
 				    struct vmem_altmap *altmap)
 {
@@ -1013,11 +1013,11 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 			continue;
 
 		WARN_ON(!p4d_present(p4d));
-		unmap_hotplug_pud_range(p4dp, addr, next, free_mapped, altmap);
+		unmap_pud_range(p4dp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
-static void unmap_hotplug_range(unsigned long addr, unsigned long end,
+static void unmap_range(unsigned long addr, unsigned long end,
 				bool free_mapped, struct vmem_altmap *altmap)
 {
 	unsigned long next;
@@ -1039,7 +1039,7 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 			continue;
 
 		WARN_ON(!pgd_present(pgd));
-		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
+		unmap_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
@@ -1258,7 +1258,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	unmap_hotplug_range(start, end, true, altmap);
+	unmap_range(start, end, true, altmap);
 	free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
@@ -1522,7 +1522,7 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	WARN_ON(pgdir != init_mm.pgd);
 	WARN_ON((start < PAGE_OFFSET) || (end > PAGE_END));
 
-	unmap_hotplug_range(start, end, false, NULL);
+	unmap_range(start, end, false, NULL);
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-- 
2.35.3

