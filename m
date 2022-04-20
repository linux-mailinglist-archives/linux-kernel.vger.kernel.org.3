Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E255080D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356799AbiDTGEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbiDTGEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:04:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78AD61EECE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:01:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4431B23A;
        Tue, 19 Apr 2022 23:01:56 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.41.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B75F33F5A1;
        Tue, 19 Apr 2022 23:01:52 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_table_check: Drop all redundant EXPORT_SYMBOL()
Date:   Wed, 20 Apr 2022 11:32:21 +0530
Message-Id: <20220420060221.1107736-1-anshuman.khandual@arm.com>
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

Function definitions need not be exported via EXPORT_SYMBOL() mechanism. In
this case these functions just get called only inside their wrappers. Even
__page_table_check_zero() gets called without such an export. Just drop all
these redundant EXPORT_SYMBOL().

Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.18-rc3

 mm/page_table_check.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 2458281bff89..5c2a96159832 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -167,7 +167,6 @@ void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
 				       PAGE_SIZE >> PAGE_SHIFT);
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pte_clear);
 
 void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
 				  pmd_t pmd)
@@ -180,7 +179,6 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
 				       PMD_PAGE_SIZE >> PAGE_SHIFT);
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pmd_clear);
 
 void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
 				  pud_t pud)
@@ -193,7 +191,6 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
 				       PUD_PAGE_SIZE >> PAGE_SHIFT);
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pud_clear);
 
 void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte)
@@ -208,7 +205,6 @@ void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
 				     pte_write(pte));
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pte_set);
 
 void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
@@ -223,7 +219,6 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 				     pmd_write(pmd));
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pmd_set);
 
 void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud)
@@ -238,7 +233,6 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 				     pud_write(pud));
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pud_set);
 
 void __page_table_check_pte_clear_range(struct mm_struct *mm,
 					unsigned long addr,
-- 
2.20.1

