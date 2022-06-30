Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232D4561525
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiF3Ibe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiF3Ibb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:31:31 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FE01DF3F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:31:31 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 922401E80D21;
        Thu, 30 Jun 2022 16:30:10 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7PTsfS-RFcZ1; Thu, 30 Jun 2022 16:30:07 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6AC881E80D11;
        Thu, 30 Jun 2022 16:30:07 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] mm/mmap.c: Fix typo and space mistake
Date:   Thu, 30 Jun 2022 16:31:24 +0800
Message-Id: <20220630083124.71336-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
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

Change 'writeable' to 'writable'.
Delete or add spaces around ','.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8f776f257893..e3a7da24e83c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1603,7 +1603,7 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 }
 
 /*
- * We account for memory if it's a private writeable mapping,
+ * We account for memory if it's a private writable mapping,
  * not hugepages and VM_NORESERVE wasn't set.
  */
 static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
@@ -2642,7 +2642,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
 				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
 		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX , NULL))) {
+				       NULL_VM_UFFD_CTX, NULL))) {
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
@@ -3146,7 +3146,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	vma = mas_prev(&mas, 0);
 	if (!vma || vma->vm_end != addr || vma_policy(vma) ||
 	    !can_vma_merge_after(vma, flags, NULL, NULL,
-				 addr >> PAGE_SHIFT,NULL_VM_UFFD_CTX, NULL))
+				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
 		vma = NULL;
 
 	ret = do_brk_flags(&mas, vma, addr, len, flags);
-- 
2.34.1

