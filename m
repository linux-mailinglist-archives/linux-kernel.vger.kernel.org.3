Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2B5284BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiEPMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243606AbiEPMyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:54:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED013A1BE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so8569008wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Tb/G+5lkfHnvtEKe+geJ9MpHVXcxF0ik9q8tJTT9QY=;
        b=MBJ5UVxFXZQ3Bbmw7lohTUXD9BhgHvbzqqUwZ4d8YFzAN3UuUh1QCM6pq0g7YLfYMN
         eW3GbDhSHySEAVroDk/PVm39k7ugxJM3/2Yvh/OCdZBBjQPqlGVV8kT2LGQA12Hd5RWi
         Vi9VWMnTegV11lKhOk+gdtP1wq93Fx6WXHJGPTHT85och0Y0yMoNzKJnJtoFkKstu6M2
         YrjodRqz2tfFBKib14RA5CsIQAy9EAItKkqAwpTXk94o/m5cG1bVZUapEORJRwPEmcen
         HKMEOMscXgAfTJC82gnQMt3UrVaUhiFkkds5FM4ZxRrSd9Z/M43rAE7HWm7Yk36041Tf
         4RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Tb/G+5lkfHnvtEKe+geJ9MpHVXcxF0ik9q8tJTT9QY=;
        b=aifIrokk76LBw+gpcZbNqyb5n9QqWJK3H5ySfNZqtXoOPDtC3N9U07j7voI5eNWyb1
         udGzYohBYfEA5c7os1U5taC1IMG7zo8I/dFkNoTIiXiubYaiTzRc7tIfZWRJ7pfEHDGl
         Ee42BBbRgx8H1o6eVspEmvRX9fbhgeUVdQSGNUbPciXLinu+RYnUALVBOD+i47ezjm9G
         gbqgStZ6S3YeDnOTw5z+vPYSMYkgfBnrIX6TAM1qLKIAQUiQV3ajUIjFVvpS3KK3rIPU
         9eUpbrdc5hSIsq4Fydis8SzPbMeKx78Ftbzw71Si2+gfdczDEk6J4U0rGl+zfHfHJPcD
         mCRQ==
X-Gm-Message-State: AOAM531GRYsDmxbFWlelEdu+3Y1WADnLF1zgmcAYOcrqj0iupQJ9vUhn
        jc4pky8gHb6zZ4/k39YnAyA=
X-Google-Smtp-Source: ABdhPJyPytLIRy+Nv9XrDz0YVXtUAseeu631D+FB5fIf9KftrEScobtVidHF58lNQ04ZrdDKgsBybQ==
X-Received: by 2002:a05:600c:20e:b0:394:2985:6d0c with SMTP id 14-20020a05600c020e00b0039429856d0cmr26778458wmi.106.1652705626579;
        Mon, 16 May 2022 05:53:46 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id r15-20020a7bc08f000000b00394615cf468sm13162481wmh.28.2022.05.16.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:53:45 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 92F45A0E78; Mon, 16 May 2022 14:54:07 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org, david@redhat.com,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v3 3/6] [PATCH 3/6] mm: add migration waiting and rmap locking to pagewalk
Date:   Mon, 16 May 2022 14:54:02 +0200
Message-Id: <20220516125405.1675-4-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516125405.1675-1-matenajakub@gmail.com>
References: <20220516125405.1675-1-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches need to wait for migration and take rmap locks before
they work with the pte itself. This feature is a compact change and is
therefore extracted into this patch.

In order to wait for migration when a page is being migrated, new flag
is added to pagewalk to optionally enable waiting for migration at the
walk_pte_range_inner() level. Similar flag was added to take rmap locks
at the same level.

When waiting for migration pte lock and rmap locks must be dropped and
taken again after the migration has ended. Similar mechanism is taken if
pte_entry() sets ACTION_AGAIN, which happens in the following patch when
a deadlock is encountered, because of a different lock order used during
the page update.

Migration waiting is done only at the PTE level and is presumes no pmd
entry is specified. If pmd_entry() is set together with page migration
flag a warning is logged. PMD migration waiting can implemented later if
anyone needs it.

At this time flags can be specified only by calling walk_page_vma(). If
needed flags can also be added to other pagewalk API calls.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 fs/proc/task_mmu.c       |  4 +--
 include/linux/pagewalk.h | 11 ++++++-
 include/linux/rmap.h     |  2 ++
 mm/mremap.c              | 17 +---------
 mm/pagewalk.c            | 71 +++++++++++++++++++++++++++++++++++++---
 mm/rmap.c                | 16 +++++++++
 6 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f46060eb91b5..fd72263456e9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -794,7 +794,7 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 #endif
 	/* mmap_lock is held in m_start */
 	if (!start)
-		walk_page_vma(vma, ops, mss);
+		walk_page_vma(vma, ops, mss, 0);
 	else
 		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
 }
@@ -1938,7 +1938,7 @@ static int show_numa_map(struct seq_file *m, void *v)
 		seq_puts(m, " huge");
 
 	/* mmap_lock is held by m_start */
-	walk_page_vma(vma, &show_numa_ops, md);
+	walk_page_vma(vma, &show_numa_ops, md, 0);
 
 	if (!md->pages)
 		goto out;
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index ac7b38ad5903..07345df51324 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -70,6 +70,13 @@ enum page_walk_action {
 	ACTION_AGAIN = 2
 };
 
+/* Walk flags */
+
+/* Wait for migration before pte entry, not implemented for pmd entries */
+#define WALK_MIGRATION  0x1
+/* Take rmap locks before pte entries */
+#define WALK_LOCK_RMAP	0x2
+
 /**
  * struct mm_walk - walk_page_range data
  * @ops:	operation to call during the walk
@@ -77,6 +84,7 @@ enum page_walk_action {
  * @pgd:	pointer to PGD; only valid with no_vma (otherwise set to NULL)
  * @vma:	vma currently walked (NULL if walking outside vmas)
  * @action:	next action to perform (see enum page_walk_action)
+ * @flags:	flags performing additional operations (see walk flags)
  * @no_vma:	walk ignoring vmas (vma will always be NULL)
  * @private:	private data for callbacks' usage
  *
@@ -88,6 +96,7 @@ struct mm_walk {
 	pgd_t *pgd;
 	struct vm_area_struct *vma;
 	enum page_walk_action action;
+	unsigned long flags;
 	bool no_vma;
 	void *private;
 };
@@ -100,7 +109,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  pgd_t *pgd,
 			  void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
-		void *private);
+		void *private, unsigned long flags);
 int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 		      pgoff_t nr, const struct mm_walk_ops *ops,
 		      void *private);
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 17230c458341..d2d5e511dd93 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -138,6 +138,8 @@ static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
  */
 void anon_vma_init(void);	/* create anon_vma_cachep */
 int  __anon_vma_prepare(struct vm_area_struct *);
+void take_rmap_locks(struct vm_area_struct *vma);
+void drop_rmap_locks(struct vm_area_struct *vma);
 void unlink_anon_vmas(struct vm_area_struct *);
 int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *);
 int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
diff --git a/mm/mremap.c b/mm/mremap.c
index 75cda854ec58..309fab7ed706 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -24,6 +24,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/uaccess.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/rmap.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlb.h>
@@ -101,22 +102,6 @@ static pmd_t *alloc_new_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
 	return pmd;
 }
 
-static void take_rmap_locks(struct vm_area_struct *vma)
-{
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-	if (vma->anon_vma)
-		anon_vma_lock_write(vma->anon_vma);
-}
-
-static void drop_rmap_locks(struct vm_area_struct *vma)
-{
-	if (vma->anon_vma)
-		anon_vma_unlock_write(vma->anon_vma);
-	if (vma->vm_file)
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-}
-
 static pte_t move_soft_dirty_pte(pte_t pte)
 {
 	/*
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..0bfb8c9255f3 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,6 +3,9 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/rmap.h>
 
 /*
  * We want to know the real level where a entry is located ignoring any
@@ -20,14 +23,62 @@ static int real_depth(int depth)
 	return depth;
 }
 
+/*
+ * Relock pte lock and optionally rmap locks to prevent possible deadlock
+ * @pte: Locked pte
+ * @addr: Address of the pte
+ * @walk: Pagewalk structure
+ * @ptl: Pte spinlock
+ * @pmd: Pmd to wait for migration *
+ */
+static void walk_pte_relock(pte_t **pte, unsigned long addr, struct mm_walk *walk,
+			spinlock_t *ptl, pmd_t *pmd)
+{
+	if (walk->no_vma)
+		pte_unmap(*pte);
+	else
+		pte_unmap_unlock(*pte, ptl);
+
+	if (walk->flags & WALK_LOCK_RMAP)
+		drop_rmap_locks(walk->vma);
+
+	if (walk->flags & WALK_MIGRATION)
+		migration_entry_wait(walk->mm, pmd, addr);
+
+	if (walk->flags & WALK_LOCK_RMAP)
+		take_rmap_locks(walk->vma);
+
+	if (walk->no_vma)
+		*pte = pte_offset_map(pmd, addr);
+	else
+		*pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+}
+
 static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
-				unsigned long end, struct mm_walk *walk)
+				unsigned long end, struct mm_walk *walk,
+				spinlock_t *ptl, pmd_t *pmd)
 {
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
 	for (;;) {
+		walk->action = ACTION_SUBTREE;
+		if ((walk->flags & WALK_MIGRATION) && !pte_present(*pte)) {
+			swp_entry_t entry;
+
+			if (!pte_none(*pte)) {
+				entry = pte_to_swp_entry(*pte);
+				if (is_migration_entry(entry)) {
+					walk_pte_relock(&pte, addr, walk, ptl, pmd);
+					continue; /* retry iteration */
+				}
+			}
+		}
 		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
+		if (walk->action == ACTION_AGAIN) {
+			walk_pte_relock(&pte, addr, walk, ptl, pmd);
+			continue; /* retry iteration */
+		}
 		if (err)
 		       break;
 		if (addr >= end - PAGE_SIZE)
@@ -45,16 +96,22 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	int err = 0;
 	spinlock_t *ptl;
 
+	if (walk->flags & WALK_LOCK_RMAP)
+		take_rmap_locks(walk->vma);
+
 	if (walk->no_vma) {
 		pte = pte_offset_map(pmd, addr);
-		err = walk_pte_range_inner(pte, addr, end, walk);
+		err = walk_pte_range_inner(pte, addr, end, walk, ptl, pmd);
 		pte_unmap(pte);
 	} else {
 		pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-		err = walk_pte_range_inner(pte, addr, end, walk);
+		err = walk_pte_range_inner(pte, addr, end, walk, ptl, pmd);
 		pte_unmap_unlock(pte, ptl);
 	}
 
+	if (walk->flags & WALK_LOCK_RMAP)
+		drop_rmap_locks(walk->vma);
+
 	return err;
 }
 
@@ -124,8 +181,11 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		 * This implies that each ->pmd_entry() handler
 		 * needs to know about pmd_trans_huge() pmds
 		 */
-		if (ops->pmd_entry)
+		if (ops->pmd_entry) {
+			/* Migration waiting is not implemented for pmd entries */
+			WARN_ON_ONCE(walk->flags & WALK_MIGRATION);
 			err = ops->pmd_entry(pmd, addr, next, walk);
+		}
 		if (err)
 			break;
 
@@ -507,13 +567,14 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 }
 
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
-		void *private)
+		void *private, unsigned long flags)
 {
 	struct mm_walk walk = {
 		.ops		= ops,
 		.mm		= vma->vm_mm,
 		.vma		= vma,
 		.private	= private,
+		.flags		= flags
 	};
 	int err;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index fedb82371efe..d4d95ada0946 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2200,6 +2200,22 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 EXPORT_SYMBOL_GPL(make_device_exclusive_range);
 #endif
 
+void take_rmap_locks(struct vm_area_struct *vma)
+{
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (vma->anon_vma)
+		anon_vma_lock_write(vma->anon_vma);
+}
+
+void drop_rmap_locks(struct vm_area_struct *vma)
+{
+	if (vma->anon_vma)
+		anon_vma_unlock_write(vma->anon_vma);
+	if (vma->vm_file)
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+}
+
 void __put_anon_vma(struct anon_vma *anon_vma)
 {
 	struct anon_vma *root = anon_vma->root;
-- 
2.35.1

