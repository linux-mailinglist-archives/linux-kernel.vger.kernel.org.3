Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF215259D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376591AbiEMC6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376599AbiEMC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:58:02 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B7025C84F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:58:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6C2B51E80C82;
        Fri, 13 May 2022 10:52:20 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PaVTrAFpiRlA; Fri, 13 May 2022 10:52:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A27F71E80C80;
        Fri, 13 May 2022 10:52:17 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kernel@nfschina.com, Xu Pengfei <xupengfei@nfschina.com>
Subject: [PATCH] mm: Optimize the statement to make it clearer
Date:   Fri, 13 May 2022 10:57:54 +0800
Message-Id: <20220513025754.9230-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Pengfei <xupengfei@nfschina.com>

Optimize the statement to make it clearer

Signed-off-by: Xu Pengfei <xupengfei@nfschina.com>
---
 mm/filemap.c | 4 ++--
 mm/mmap.c    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9a1eef6c5d35..f6b2b915052a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1374,9 +1374,9 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	 * waiter, but an exclusive one requires WQ_FLAG_DONE.
 	 */
 	if (behavior == EXCLUSIVE)
-		return wait->flags & WQ_FLAG_DONE ? 0 : -EINTR;
+		return (wait->flags & WQ_FLAG_DONE) ? 0 : -EINTR;
 
-	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
+	return (wait->flags & WQ_FLAG_WOKEN) ? 0 : -EINTR;
 }
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..28196b93515a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2975,9 +2975,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 			goto out;
 	}
 
-	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
-	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
-	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
+	prot |= (vma->vm_flags & VM_READ) ? PROT_READ : 0;
+	prot |= (vma->vm_flags & VM_WRITE) ? PROT_WRITE : 0;
+	prot |= (vma->vm_flags & VM_EXEC) ? PROT_EXEC : 0;
 
 	flags &= MAP_NONBLOCK;
 	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-- 
2.18.2

