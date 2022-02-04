Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C420C4AA0AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiBDUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbiBDT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588DC061748
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ftzBL1oQK/5m9sfLfLIA/LTM6FPP6XsHZDiqOCAGWzc=; b=H2dX/q11Q9ClCFy2/MvBToAJcV
        9Md1MDr5aOYF3Au433b8O6hWakKwyCONAC45KIij72PrbAeLsrYXS4SNuWcO1F4do6wTphYv1Q+OP
        WH/TZDFFRTbx6OswNeLlAGXPRjJmd76o0gyfJYqz+YzQtqVow3QX4xthWX72yJjngXlSS3nu0RNyb
        jr2Lp+uRFfRCmf6+3vs2DKCD8EaAUuTl1rbndc6XyR/t27paPXvNickA8Dg4Oo6D2pCR3iUl9wili
        pHc8Csg88xI3PLXnrCxOsqG+wXFPhbfBOD5arrgorCsayn1wugTQ9kovyX5pPRdDhzjM8jL50+327
        4NL4aYuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4ja-007Lpl-CA; Fri, 04 Feb 2022 19:59:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 60/75] mm/rmap: Constify the rmap_walk_control argument
Date:   Fri,  4 Feb 2022 19:58:37 +0000
Message-Id: <20220204195852.1751729-61-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rmap walking functions do not modify the rmap_walk_control, and
page_idle_clear_pte_refs() takes advantage of that to move construction
of the rmap_walk_control to compile time.  This lets us remove an
unclean cast.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/ksm.h  |  4 ++--
 include/linux/rmap.h |  4 ++--
 mm/ksm.c             |  2 +-
 mm/page_idle.c       |  2 +-
 mm/rmap.c            | 14 +++++++-------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 0b4f17418f64..0630e545f4cb 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -51,7 +51,7 @@ static inline void ksm_exit(struct mm_struct *mm)
 struct page *ksm_might_need_to_copy(struct page *page,
 			struct vm_area_struct *vma, unsigned long address);
 
-void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
+void rmap_walk_ksm(struct folio *folio, const struct rmap_walk_control *rwc);
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
 
 #else  /* !CONFIG_KSM */
@@ -79,7 +79,7 @@ static inline struct page *ksm_might_need_to_copy(struct page *page,
 }
 
 static inline void rmap_walk_ksm(struct folio *folio,
-			struct rmap_walk_control *rwc)
+			const struct rmap_walk_control *rwc)
 {
 }
 
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 4e4c4412b295..96522944739e 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -294,8 +294,8 @@ struct rmap_walk_control {
 	bool (*invalid_vma)(struct vm_area_struct *vma, void *arg);
 };
 
-void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
-void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
+void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc);
+void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc);
 
 #else	/* !CONFIG_MMU */
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 0ec3d9035419..e95c454303a2 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2601,7 +2601,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 	return new_page;
 }
 
-void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
+void rmap_walk_ksm(struct folio *folio, const struct rmap_walk_control *rwc)
 {
 	struct stable_node *stable_node;
 	struct rmap_item *rmap_item;
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 3563c3850795..982f35d91b96 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -107,7 +107,7 @@ static void page_idle_clear_pte_refs(struct page *page)
 	if (need_lock && !folio_trylock(folio))
 		return;
 
-	rmap_walk(folio, (struct rmap_walk_control *)&rwc);
+	rmap_walk(folio, &rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
diff --git a/mm/rmap.c b/mm/rmap.c
index 1ade44970ab1..1d22cb825931 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2273,7 +2273,7 @@ void __put_anon_vma(struct anon_vma *anon_vma)
 }
 
 static struct anon_vma *rmap_walk_anon_lock(struct folio *folio,
-					struct rmap_walk_control *rwc)
+					const struct rmap_walk_control *rwc)
 {
 	struct anon_vma *anon_vma;
 
@@ -2308,8 +2308,8 @@ static struct anon_vma *rmap_walk_anon_lock(struct folio *folio,
  * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
  * LOCKED.
  */
-static void rmap_walk_anon(struct folio *folio, struct rmap_walk_control *rwc,
-		bool locked)
+static void rmap_walk_anon(struct folio *folio,
+		const struct rmap_walk_control *rwc, bool locked)
 {
 	struct anon_vma *anon_vma;
 	pgoff_t pgoff_start, pgoff_end;
@@ -2361,8 +2361,8 @@ static void rmap_walk_anon(struct folio *folio, struct rmap_walk_control *rwc,
  * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
  * LOCKED.
  */
-static void rmap_walk_file(struct folio *folio, struct rmap_walk_control *rwc,
-		bool locked)
+static void rmap_walk_file(struct folio *folio,
+		const struct rmap_walk_control *rwc, bool locked)
 {
 	struct address_space *mapping = folio_mapping(folio);
 	pgoff_t pgoff_start, pgoff_end;
@@ -2404,7 +2404,7 @@ static void rmap_walk_file(struct folio *folio, struct rmap_walk_control *rwc,
 		i_mmap_unlock_read(mapping);
 }
 
-void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc)
+void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc)
 {
 	if (unlikely(folio_test_ksm(folio)))
 		rmap_walk_ksm(folio, rwc);
@@ -2415,7 +2415,7 @@ void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc)
 }
 
 /* Like rmap_walk, but caller holds relevant rmap lock */
-void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
+void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc)
 {
 	/* no ksm support for now */
 	VM_BUG_ON_FOLIO(folio_test_ksm(folio), folio);
-- 
2.34.1

