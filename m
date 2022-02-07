Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6F4AB327
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347823AbiBGBih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiBGBie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:38:34 -0500
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 17:38:33 PST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B046C061348
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:38:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C45C36D;
        Sun,  6 Feb 2022 17:31:18 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.45.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15FF13F73B;
        Sun,  6 Feb 2022 17:31:16 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/migration: Define arm64_hugetlb_valid_size()
Date:   Mon,  7 Feb 2022 07:01:08 +0530
Message-Id: <1644197468-26755-1-git-send-email-anshuman.khandual@arm.com>
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
arm64_hugetlb_migration_supported() for that purpose.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index ffb9c229610a..dcdc4c0c3bd8 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -56,24 +56,12 @@ void __init arm64_hugetlb_cma_reserve(void)
 }
 #endif /* CONFIG_CMA */
 
+static bool arm64_hugetlb_valid_size(unsigned long size);
+
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 bool arch_hugetlb_migration_supported(struct hstate *h)
 {
-	size_t pagesize = huge_page_size(h);
-
-	switch (pagesize) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SIZE:
-		return pud_sect_supported();
-#endif
-	case PMD_SIZE:
-	case CONT_PMD_SIZE:
-	case CONT_PTE_SIZE:
-		return true;
-	}
-	pr_warn("%s: unrecognized huge page size 0x%lx\n",
-			__func__, pagesize);
-	return false;
+	return arm64_hugetlb_valid_size(huge_page_size(h));
 }
 #endif
 
@@ -504,7 +492,7 @@ static int __init hugetlbpage_init(void)
 }
 arch_initcall(hugetlbpage_init);
 
-bool __init arch_hugetlb_valid_size(unsigned long size)
+static bool arm64_hugetlb_valid_size(unsigned long size)
 {
 	switch (size) {
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -517,5 +505,12 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 		return true;
 	}
 
+	pr_warn("%s: unrecognized huge page size 0x%lx\n",
+		__func__, size);
 	return false;
 }
+
+bool __init arch_hugetlb_valid_size(unsigned long size)
+{
+	return arm64_hugetlb_valid_size(size);
+}
-- 
2.20.1

