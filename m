Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE14C9F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiCBIam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbiCBIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:30:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21AB2E0A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:29:47 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p17so940672plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FG/K6837zQPVwcpe+tAz7OlRAj17PMacY8wX1oMHrEs=;
        b=PGIGAurL4qs724ojSh6WoXxqvhMvCZBybFDAP3gGqIW/vXElNJIqLMJ/ek2d2i0/Gj
         DRVyI03bPjU1MyjcBUJTjfRKlpRh6REUP4Rt0TEw0TdfFlVjGLHr1ts1xWOCoIa7Z7n7
         6DAdde+I05MtZqGsiYmzRKyAtq9xB1MsB6FjAP2m+1TtPnQ/DIP34Uyd2JbVYISQp65R
         nExPxZLC4MOYKdnifRbtN8d5JhZm/XLiy126P2Kzu2fi4yBFh+KKVB0MtSyH0tDfDene
         hXngnrmCnb/fLZ4hmhGh4D1wKUyfXyi/PmnXMyC3kUQnv8Nc0yCrZnmlAOgBygTB2HZu
         AAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FG/K6837zQPVwcpe+tAz7OlRAj17PMacY8wX1oMHrEs=;
        b=uoFEnxv8F0T9xW9xp1526/ByQsV5cLZgTaszmXHDdQmjQNw/pUozuNDsArv8Xs15Cx
         P9lcmA8JXpEUmF9bFqdYiTDD6H+4H8b5p/IrnhDLJ77P2NBeeFOj3QkxyLrQfCK7QGtV
         Om5ODfRgLqmRXC3EOnCYQyS2ZztpvnREJaZPlpabX/OiWs7FMgPbMKkF3b90uqpN6EHJ
         jfvT4hAQvW2yA/S8u2FA21zmAIIIudhM/qTvyA8Q/UFeict+lvHqr2JoriJ0ggTH9ZNo
         XSIZMpfdWUUNDgKHSjEtAgnjyzvHsk20IVVvsa5FguRwzRa6+wWqR28v9r8KqUUYT8EI
         W5oQ==
X-Gm-Message-State: AOAM531Jd+1HOmGChJvr9dt3ApvsP3IUuUH39Uanw7j97FB/MG3J6N3/
        vxpder5n/pUgonskkyhBiZYXMQ==
X-Google-Smtp-Source: ABdhPJwPYghkWYEC4o+1xoq9Wh92BCG8knxGA3IJCRknHamVSwQdJF2a2sTBIdNnyYfvR3xQbvXLCQ==
X-Received: by 2002:a17:902:e5c4:b0:151:9bf6:f47f with SMTP id u4-20020a170902e5c400b001519bf6f47fmr637485plf.110.1646209786386;
        Wed, 02 Mar 2022 00:29:46 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm20922228pfv.49.2022.03.02.00.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:29:46 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 5/6] dax: fix missing writeprotect the pte entry
Date:   Wed,  2 Mar 2022 16:27:17 +0800
Message-Id: <20220302082718.32268-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302082718.32268-1-songmuchun@bytedance.com>
References: <20220302082718.32268-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dax_mapping_entry_mkclean() fails to clean and write protect
the pte entry within a DAX PMD entry during an *sync operation. This
can result in data loss in the following sequence:

  1) process A mmap write to DAX PMD, dirtying PMD radix tree entry and
     making the pmd entry dirty and writeable.
  2) process B mmap with the @offset (e.g. 4K) and @length (e.g. 4K)
     write to the same file, dirtying PMD radix tree entry (already
     done in 1)) and making the pte entry dirty and writeable.
  3) fsync, flushing out PMD data and cleaning the radix tree entry. We
     currently fail to mark the pte entry as clean and write protected
     since the vma of process B is not covered in dax_entry_mkclean().
  4) process B writes to the pte. These don't cause any page faults since
     the pte entry is dirty and writeable. The radix tree entry remains
     clean.
  5) fsync, which fails to flush the dirty PMD data because the radix tree
     entry was clean.
  6) crash - dirty data that should have been fsync'd as part of 5) could
     still have been in the processor cache, and is lost.

Just to use pfn_mkclean_range() to clean the pfns to fix this issue.

Fixes: 4b4bb46d00b3 ("dax: clear dirty entry tags on cache flush")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dax.c | 83 ++++++----------------------------------------------------------
 1 file changed, 7 insertions(+), 76 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index a372304c9695..7fd4a16769f9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -24,6 +24,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <linux/rmap.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
@@ -789,87 +790,17 @@ static void *dax_insert_entry(struct xa_state *xas,
 	return entry;
 }
 
-static inline
-unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
-{
-	unsigned long address;
-
-	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
-	return address;
-}
-
 /* Walk all mappings of a given index of a file and writeprotect them */
-static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
-		unsigned long pfn)
+static void dax_entry_mkclean(struct address_space *mapping, unsigned long pfn,
+			      unsigned long npfn, pgoff_t start)
 {
 	struct vm_area_struct *vma;
-	pte_t pte, *ptep = NULL;
-	pmd_t *pmdp = NULL;
-	spinlock_t *ptl;
+	pgoff_t end = start + npfn - 1;
 
 	i_mmap_lock_read(mapping);
-	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
-		struct mmu_notifier_range range;
-		unsigned long address;
-
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, start, end) {
+		pfn_mkclean_range(pfn, npfn, start, vma);
 		cond_resched();
-
-		if (!(vma->vm_flags & VM_SHARED))
-			continue;
-
-		address = pgoff_address(index, vma);
-
-		/*
-		 * follow_invalidate_pte() will use the range to call
-		 * mmu_notifier_invalidate_range_start() on our behalf before
-		 * taking any lock.
-		 */
-		if (follow_invalidate_pte(vma->vm_mm, address, &range, &ptep,
-					  &pmdp, &ptl))
-			continue;
-
-		/*
-		 * No need to call mmu_notifier_invalidate_range() as we are
-		 * downgrading page table protection not changing it to point
-		 * to a new page.
-		 *
-		 * See Documentation/vm/mmu_notifier.rst
-		 */
-		if (pmdp) {
-#ifdef CONFIG_FS_DAX_PMD
-			pmd_t pmd;
-
-			if (pfn != pmd_pfn(*pmdp))
-				goto unlock_pmd;
-			if (!pmd_dirty(*pmdp) && !pmd_write(*pmdp))
-				goto unlock_pmd;
-
-			flush_cache_range(vma, address,
-					  address + HPAGE_PMD_SIZE);
-			pmd = pmdp_invalidate(vma, address, pmdp);
-			pmd = pmd_wrprotect(pmd);
-			pmd = pmd_mkclean(pmd);
-			set_pmd_at(vma->vm_mm, address, pmdp, pmd);
-unlock_pmd:
-#endif
-			spin_unlock(ptl);
-		} else {
-			if (pfn != pte_pfn(*ptep))
-				goto unlock_pte;
-			if (!pte_dirty(*ptep) && !pte_write(*ptep))
-				goto unlock_pte;
-
-			flush_cache_page(vma, address, pfn);
-			pte = ptep_clear_flush(vma, address, ptep);
-			pte = pte_wrprotect(pte);
-			pte = pte_mkclean(pte);
-			set_pte_at(vma->vm_mm, address, ptep, pte);
-unlock_pte:
-			pte_unmap_unlock(ptep, ptl);
-		}
-
-		mmu_notifier_invalidate_range_end(&range);
 	}
 	i_mmap_unlock_read(mapping);
 }
@@ -937,7 +868,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	count = 1UL << dax_entry_order(entry);
 	index = xas->xa_index & ~(count - 1);
 
-	dax_entry_mkclean(mapping, index, pfn);
+	dax_entry_mkclean(mapping, pfn, count, index);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
-- 
2.11.0

