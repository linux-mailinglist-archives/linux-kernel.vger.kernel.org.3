Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5375098A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379088AbiDUHIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiDUHIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:08:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5620515A31
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:05:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00E561477;
        Thu, 21 Apr 2022 00:05:52 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.40.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DF153F73B;
        Thu, 21 Apr 2022 00:05:49 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/page_table_check: Drop all redundant EXPORT_SYMBOL()
Date:   Thu, 21 Apr 2022 12:36:31 +0530
Message-Id: <20220421070631.1273879-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in V2:

- Restored EXPORT_SYMBOL for __page_table_check_pte_set() per Pasha

 mm/page_table_check.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 2458281bff89..627c5025d786 100644
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
@@ -223,7 +220,6 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 				     pmd_write(pmd));
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pmd_set);
 
 void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud)
@@ -238,7 +234,6 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 				     pud_write(pud));
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pud_set);
 
 void __page_table_check_pte_clear_range(struct mm_struct *mm,
 					unsigned long addr,
-- 
2.20.1

