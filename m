Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639AF4B97E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiBQExA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:53:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBQEw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:52:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE3661ED1DB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:52:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F6012FC;
        Wed, 16 Feb 2022 20:52:45 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC4AE3F66F;
        Wed, 16 Feb 2022 20:52:43 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64/hugetlb: Define __hugetlb_valid_size()
Date:   Thu, 17 Feb 2022 10:22:37 +0530
Message-Id: <1645073557-6150-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_hugetlb_valid_size() can be just factored out to create another helper
to be used in arch_hugetlb_migration_supported() as well. This just defines
__hugetlb_valid_size() for that purpose.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.17-rc4

Changes in V3:

- Moved up __hugetlb_valid_size() avoiding forward declaration per Will

Changes in V2:

https://lore.kernel.org/all/1644491770-16108-1-git-send-email-anshuman.khandual@arm.com/

- s/arm64_hugetlb_valid_size/__hugetlb_valid_size per Catalin
- Restored back warning in arch_hugetlb_migration_supported() per Catalin
- Updated the commit message subject line as required

Changes in V1:

https://lore.kernel.org/all/1644197468-26755-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/mm/hugetlbpage.c | 38 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index ffb9c229610a..a33aba91ad89 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -56,25 +56,34 @@ void __init arm64_hugetlb_cma_reserve(void)
 }
 #endif /* CONFIG_CMA */
 
-#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
-bool arch_hugetlb_migration_supported(struct hstate *h)
+static bool __hugetlb_valid_size(unsigned long size)
 {
-	size_t pagesize = huge_page_size(h);
-
-	switch (pagesize) {
+	switch (size) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SIZE:
 		return pud_sect_supported();
 #endif
-	case PMD_SIZE:
 	case CONT_PMD_SIZE:
+	case PMD_SIZE:
 	case CONT_PTE_SIZE:
 		return true;
 	}
-	pr_warn("%s: unrecognized huge page size 0x%lx\n",
-			__func__, pagesize);
+
 	return false;
 }
+
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
+bool arch_hugetlb_migration_supported(struct hstate *h)
+{
+	size_t pagesize = huge_page_size(h);
+
+	if (!__hugetlb_valid_size(pagesize)) {
+		pr_warn("%s: unrecognized huge page size 0x%lx\n",
+			__func__, pagesize);
+		return false;
+	}
+	return true;
+}
 #endif
 
 int pmd_huge(pmd_t pmd)
@@ -506,16 +515,5 @@ arch_initcall(hugetlbpage_init);
 
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
-	switch (size) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SIZE:
-		return pud_sect_supported();
-#endif
-	case CONT_PMD_SIZE:
-	case PMD_SIZE:
-	case CONT_PTE_SIZE:
-		return true;
-	}
-
-	return false;
+	return __hugetlb_valid_size(size);
 }
-- 
2.20.1

