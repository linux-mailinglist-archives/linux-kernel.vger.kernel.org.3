Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663FA557347
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiFWGqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiFWGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:46:15 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C6B342A13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:46:14 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5E12C1E80C85;
        Thu, 23 Jun 2022 14:45:56 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B06JfwXUQAjO; Thu, 23 Jun 2022 14:45:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: lvqian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9A95E1E80C7D;
        Thu, 23 Jun 2022 14:45:53 +0800 (CST)
From:   Lv qian <lvqian@nfschina.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Lv qian <lvqian@nfschina.com>
Subject: [PATCH] vmalloc:Merge multiple if conditional sentences
Date:   Thu, 23 Jun 2022 14:45:27 +0800
Message-Id: <20220623064527.4238-1-lvqian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge multiple if statements to improve code readability

Signed-off-by: Lv qian <lvqian@nfschina.com>
---
 mm/vmalloc.c | 66 ++++++++++++++--------------------------------------
 1 file changed, 18 insertions(+), 48 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index effd1ff6a4b4..6902a180f8f7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -135,22 +135,12 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
-	if (max_page_shift < PMD_SHIFT)
-		return 0;
-
-	if (!arch_vmap_pmd_supported(prot))
-		return 0;
-
-	if ((end - addr) != PMD_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, PMD_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
-		return 0;
-
-	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
+	if (max_page_shift < PMD_SHIFT ||
+			!arch_vmap_pmd_supported(prot) ||
+			(end - addr) != PMD_SIZE ||
+			!IS_ALIGNED(addr, PMD_SIZE) ||
+			!IS_ALIGNED(phys_addr, PMD_SIZE) ||
+			(pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr)))
 		return 0;
 
 	return pmd_set_huge(pmd, phys_addr, prot);
@@ -185,22 +175,12 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
-	if (max_page_shift < PUD_SHIFT)
-		return 0;
-
-	if (!arch_vmap_pud_supported(prot))
-		return 0;
-
-	if ((end - addr) != PUD_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, PUD_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
-		return 0;
-
-	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
+	if (max_page_shift < PUD_SHIFT ||
+			!arch_vmap_pud_supported(prot) ||
+			(end - addr) != PUD_SIZE ||
+			!IS_ALIGNED(addr, PUD_SIZE) ||
+			!IS_ALIGNED(phys_addr, PUD_SIZE) ||
+			(pud_present(*pud) && !pud_free_pmd_page(pud, addr)))
 		return 0;
 
 	return pud_set_huge(pud, phys_addr, prot);
@@ -236,22 +216,12 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
-	if (max_page_shift < P4D_SHIFT)
-		return 0;
-
-	if (!arch_vmap_p4d_supported(prot))
-		return 0;
-
-	if ((end - addr) != P4D_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, P4D_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
-		return 0;
-
-	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
+	if (max_page_shift < P4D_SHIFT ||
+			!arch_vmap_p4d_supported(prot) ||
+			(end - addr) != P4D_SIZE ||
+			!IS_ALIGNED(addr, P4D_SIZE) ||
+			!IS_ALIGNED(phys_addr, P4D_SIZE) ||
+			(p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr)))
 		return 0;
 
 	return p4d_set_huge(p4d, phys_addr, prot);
-- 
2.18.2

