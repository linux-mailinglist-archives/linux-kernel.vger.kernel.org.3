Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB45865F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiHAIEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiHAIEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A82CC8C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F1D60F8C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A1FC43470;
        Mon,  1 Aug 2022 08:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659341081;
        bh=ZL4ATVbziZrOALfir8Dz0aCrysF/GVyZD7Hah4EI7BU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUktLeef3Hq29EFtuQWBwxp6i1t6pcS7qd0boRJ3PBt2FpzjdRKJp56846sTSzkqX
         vkpkrYO6rKrDNp8m4/0zMYJldaAPt++kFGatcVoCMRu7JWfv+Nlw+QvemlVIopJ2YN
         ZeMTaqiAYlFIL+CMtzvAt2D3+BV56y3Di43CZPYAKuCQoHtDb2EKs0r1W3HOIKGlXt
         nL0wCsni4U/qz9HRNCKfAaLq+NyizM68reJPJUHuxSO6x9eEZ1H73MwdtC4j14FRxN
         ZBg7LNcRqAF4gYVG3M9ZCxWeiCL54/8OMED4BBTsokEFhkM2cQ4lALkPFbH9gkFc3+
         Kj661lsXZr31g==
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
Subject: [RFC PATCH 2/4] arm64/mmu: drop _hotplug from unmap_hotplug_* function names
Date:   Mon,  1 Aug 2022 11:04:16 +0300
Message-Id: <20220801080418.120311-3-rppt@kernel.org>
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

so that they can be used for remapping crash kernel.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/mmu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d170b7956b01..baa2dda2dcce 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -861,7 +861,7 @@ static bool pgtable_range_aligned(unsigned long start, unsigned long end,
 	return true;
 }
 
-static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
+static void unmap_pte_range(pmd_t *pmdp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
 				    struct vmem_altmap *altmap)
 {
@@ -882,7 +882,7 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 	} while (addr += PAGE_SIZE, addr < end);
 }
 
-static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
+static void unmap_pmd_range(pud_t *pudp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
 				    struct vmem_altmap *altmap)
 {
@@ -911,11 +911,11 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
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
@@ -944,11 +944,11 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
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
@@ -963,11 +963,11 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
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
@@ -989,7 +989,7 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 			continue;
 
 		WARN_ON(!pgd_present(pgd));
-		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
+		unmap_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
@@ -1208,7 +1208,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	unmap_hotplug_range(start, end, true, altmap);
+	unmap_range(start, end, true, altmap);
 	free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
@@ -1472,7 +1472,7 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	WARN_ON(pgdir != init_mm.pgd);
 	WARN_ON((start < PAGE_OFFSET) || (end > PAGE_END));
 
-	unmap_hotplug_range(start, end, false, NULL);
+	unmap_range(start, end, false, NULL);
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-- 
2.35.3

