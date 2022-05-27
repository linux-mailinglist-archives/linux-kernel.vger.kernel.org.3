Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5E7535899
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242085AbiE0EwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiE0Evz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:51:55 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6083FC6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:51:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VEVWXbX_1653627109;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEVWXbX_1653627109)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 12:51:50 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        naresh.kamboju@linaro.org, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/hugetlb: Fix building errors in huge_ptep_clear_flush()
Date:   Fri, 27 May 2022 12:51:38 +0800
Message-Id: <814e20c19b110209ee12ecae7cb05f8a78d021c8.1653625820.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below building errors which was caused by commit ae07562909f3
("mm: change huge_ptep_clear_flush() to return the original pte")
interacting with commit fb396bb459c1 ("arm64/hugetlb: Drop TLB flush
from get_clear_flush()").

Due to the new get_clear_contig() has dropped TLB flush, we should
add an explicit TLB flush in huge_ptep_clear_flush() to keep original
semantics when changing to use new get_clear_contig().

"
arch/arm64/mm/hugetlbpage.c: In function ‘huge_ptep_clear_flush’:
arch/arm64/mm/hugetlbpage.c:515:9: error: implicit declaration of
function ‘get_clear_flush’; did you mean ‘ptep_clear_flush’?
[-Werror=implicit-function-declaration]
  515 |  return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
      |         ^~~~~~~~~~~~~~~
      |         ptep_clear_flush
"

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm64/mm/hugetlbpage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0f0c17dfeb9c..e2a5ec9fdc0d 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -507,12 +507,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 	size_t pgsize;
 	int ncontig;
+	pte_t orig_pte;
 
 	if (!pte_cont(READ_ONCE(*ptep)))
 		return ptep_clear_flush(vma, addr, ptep);
 
 	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
-	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
+	return orig_pte;
 }
 
 static int __init hugetlbpage_init(void)
-- 
2.27.0

