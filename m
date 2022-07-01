Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A255562C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiGAHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiGAHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:05:52 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 519A7677D1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:05:51 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 87A9E1E80D90;
        Fri,  1 Jul 2022 15:04:22 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w7qXELU5YKyf; Fri,  1 Jul 2022 15:04:19 +0800 (CST)
Received: from localhost.localdomain (unknown [112.65.12.78])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4F0491E80D21;
        Fri,  1 Jul 2022 15:04:17 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] mm/pgtable: Fix typo in comments
Date:   Fri,  1 Jul 2022 15:05:34 +0800
Message-Id: <20220701070534.9874-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 typo (writeable) in init.c and pgtable.c's comments.
Fix it.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/x86/mm/init.c    | 2 +-
 arch/x86/mm/pgtable.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d8cfce221275..e027239406d5 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -893,7 +893,7 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 		/*
 		 * We just marked the kernel text read only above, now that
 		 * we are going to free part of that, we need to make that
-		 * writeable and non-executable first.
+		 * writable and non-executable first.
 		 */
 		set_memory_nx(begin, (end - begin) >> PAGE_SHIFT);
 		set_memory_rw(begin, (end - begin) >> PAGE_SHIFT);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a932d7712d85..95f930104deb 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -480,7 +480,7 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
  * Used to set accessed or dirty bits in the page table entries
  * on other architectures. On x86, the accessed and dirty bits
  * are tracked by hardware. However, do_wp_page calls this function
- * to also make the pte writeable at the same time the dirty bit is
+ * to also make the pte writable at the same time the dirty bit is
  * set. In that case we do actually need to write the PTE.
  */
 int ptep_set_access_flags(struct vm_area_struct *vma,
-- 
2.25.1

