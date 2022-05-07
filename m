Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CC051E807
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446572AbiEGPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385533AbiEGPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:10:44 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06007237FC
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:06:56 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 9A28C1E80D89;
        Sat,  7 May 2022 23:02:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I7NvjaRQfYCx; Sat,  7 May 2022 23:02:00 +0800 (CST)
Received: from localhost.localdomain (unknown [123.113.181.70])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A6A301E80D6D;
        Sat,  7 May 2022 23:02:00 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] mm: Functions may simplify the use of return values
Date:   Sat,  7 May 2022 23:06:30 +0800
Message-Id: <20220507150630.90399-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p4d_clear_huge may be optimized for void return type and function usage.
vunmap_p4d_range function saves a few steps here.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/x86/mm/pgtable.c   |  3 +--
 include/linux/pgtable.h | 12 +++---------
 mm/vmalloc.c            |  7 ++-----
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..9222b6832c36 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -676,9 +676,8 @@ int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
  *
  * No 512GB pages yet -- always return 0
  */
-int p4d_clear_huge(p4d_t *p4d)
+void p4d_clear_huge(p4d_t *p4d)
 {
-	return 0;
 }
 #endif
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f4f4077b97aa..5448b5b10241 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1394,16 +1394,13 @@ static inline int pmd_protnone(pmd_t pmd)
 
 #ifndef __PAGETABLE_P4D_FOLDED
 int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot);
-int p4d_clear_huge(p4d_t *p4d);
+void p4d_clear_huge(p4d_t *p4d);
 #else
 static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 {
 	return 0;
 }
-static inline int p4d_clear_huge(p4d_t *p4d)
-{
-	return 0;
-}
+static inline void p4d_clear_huge(p4d_t *p4d) { }
 #endif /* !__PAGETABLE_P4D_FOLDED */
 
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
@@ -1426,10 +1423,7 @@ static inline int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 {
 	return 0;
 }
-static inline int p4d_clear_huge(p4d_t *p4d)
-{
-	return 0;
-}
+static inline void p4d_clear_huge(p4d_t *p4d) { }
 static inline int pud_clear_huge(pud_t *pud)
 {
 	return 0;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cadfbb5155ea..fa915f3cb75e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -389,18 +389,15 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 {
 	p4d_t *p4d;
 	unsigned long next;
-	int cleared;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
 		next = p4d_addr_end(addr, end);
 
-		cleared = p4d_clear_huge(p4d);
-		if (cleared || p4d_bad(*p4d))
+		p4d_clear_huge(p4d);
+		if (p4d_bad(*p4d))
 			*mask |= PGTBL_P4D_MODIFIED;
 
-		if (cleared)
-			continue;
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		vunmap_pud_range(p4d, addr, next, mask);
-- 
2.18.2

