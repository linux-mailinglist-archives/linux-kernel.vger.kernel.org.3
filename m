Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0C50F316
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbiDZHzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343867AbiDZHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:55:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7920EBCA9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:52:02 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KnYxJ0lFDzhYnh;
        Tue, 26 Apr 2022 15:51:48 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 15:52:00 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 15:51:58 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next v6 1/6] mm: page_table_check: using PxD_SIZE instead of PxD_PAGE_SIZE
Date:   Tue, 26 Apr 2022 08:10:31 +0000
Message-ID: <20220426081036.1374452-2-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426081036.1374452-1-tongtiangen@huawei.com>
References: <20220426081036.1374452-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared with PxD_PAGE_SIZE, which is defined and used only on X86,
PxD_SIZE is more common in each architecture. Therefore, it is more
reasonable to use PxD_SIZE instead of PxD_PAGE_SIZE in page_table_check.c.
At the same time, it is easier to support page table check in other
architectures. The substitution has no functional impact on the x86.

Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/page_table_check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 2458281bff89..eb0d0b71cdf6 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -177,7 +177,7 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
 
 	if (pmd_user_accessible_page(pmd)) {
 		page_table_check_clear(mm, addr, pmd_pfn(pmd),
-				       PMD_PAGE_SIZE >> PAGE_SHIFT);
+				       PMD_SIZE >> PAGE_SHIFT);
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pmd_clear);
@@ -190,7 +190,7 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
 
 	if (pud_user_accessible_page(pud)) {
 		page_table_check_clear(mm, addr, pud_pfn(pud),
-				       PUD_PAGE_SIZE >> PAGE_SHIFT);
+				       PUD_SIZE >> PAGE_SHIFT);
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
@@ -219,7 +219,7 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 	__page_table_check_pmd_clear(mm, addr, *pmdp);
 	if (pmd_user_accessible_page(pmd)) {
 		page_table_check_set(mm, addr, pmd_pfn(pmd),
-				     PMD_PAGE_SIZE >> PAGE_SHIFT,
+				     PMD_SIZE >> PAGE_SHIFT,
 				     pmd_write(pmd));
 	}
 }
@@ -234,7 +234,7 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 	__page_table_check_pud_clear(mm, addr, *pudp);
 	if (pud_user_accessible_page(pud)) {
 		page_table_check_set(mm, addr, pud_pfn(pud),
-				     PUD_PAGE_SIZE >> PAGE_SHIFT,
+				     PUD_SIZE >> PAGE_SHIFT,
 				     pud_write(pud));
 	}
 }
-- 
2.25.1

