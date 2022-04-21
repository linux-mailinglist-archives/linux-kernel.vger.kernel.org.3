Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768CF509A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386365AbiDUIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383377AbiDUIE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:04:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0891A811
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:02:08 -0700 (PDT)
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KkVLb0GvNzFqWr;
        Thu, 21 Apr 2022 15:59:35 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:02:06 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:02:05 +0800
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
Subject: [PATCH -next v5 1/5] mm: page_table_check: using PxD_SIZE instead of PxD_PAGE_SIZE
Date:   Thu, 21 Apr 2022 08:20:38 +0000
Message-ID: <20220421082042.1167967-2-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421082042.1167967-1-tongtiangen@huawei.com>
References: <20220421082042.1167967-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro PUD_SIZE/PMD_SIZE is more general in various architectures. Using
PUD_SIZE/PMD_SIZE instead of PUD_PAGE_SIZE/PMD_PAGE_SIZE can better
support page table check in architectures other than x86 and it is no
functional impact on x86.

Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
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

