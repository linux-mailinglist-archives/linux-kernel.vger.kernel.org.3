Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB254AA0CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbiBDUDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DCC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3f3cABEO7ZU76rIj5Z6RSC1I2hQp6Gt7nT0OzvXmhCQ=; b=g/TdzEVQbwCBPzSUkESe4MCIMY
        VHBF5Vtrmldq+KV76C53D6M2cppL5DR3pTyq3teiwm/eQLswLZmlXwEAolNl3KE+k3QOCyYYRsJUj
        14JlqAaR+6WPJWETml0oPDbmLV6YUq3vInWI93V0SAw/nIVG5PRLZ+1Z7g3B0UmeO+98Z8TWe9j6W
        EbNKU6cXuCS2JNaJo4HJYU8qyqFFOtGiBAT2R7TcByhJFoJbRR8doqI274fq4/vyHM5C1+cckykS7
        p+Ma/N1Q2PhIMNdkjKYppvUNDPY1an01CisWSu7ubeACjL5elHKj1yuhkI/RAiCM9ZiSX1b0ZUa5l
        42Fu5bvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jZ-007LpM-UD; Fri, 04 Feb 2022 19:59:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 57/75] mm/rmap: Turn page_lock_anon_vma_read() into folio_lock_anon_vma_read()
Date:   Fri,  4 Feb 2022 19:58:34 +0000
Message-Id: <20220204195852.1751729-58-willy@infradead.org>
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

Add back page_lock_anon_vma_read() as a wrapper.  This saves a few calls
to compound_head().  If any callers were passing a tail page before,
this would have failed to lock the anon VMA as page->mapping is not
valid for tail pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rmap.h |  1 +
 mm/folio-compat.c    |  5 +++++
 mm/memory-failure.c  |  3 ++-
 mm/rmap.c            | 12 ++++++------
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 85d17a38642c..71798112a575 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -269,6 +269,7 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
  * Called by memory-failure.c to kill processes.
  */
 struct anon_vma *page_lock_anon_vma_read(struct page *page);
+struct anon_vma *folio_lock_anon_vma_read(struct folio *folio);
 void page_unlock_anon_vma_read(struct anon_vma *anon_vma);
 int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 3804fd8c1f20..e04fba5e45e5 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -185,3 +185,8 @@ void page_mlock(struct page *page)
 {
 	folio_mlock(page_folio(page));
 }
+
+struct anon_vma *page_lock_anon_vma_read(struct page *page)
+{
+	return folio_lock_anon_vma_read(page_folio(page));
+}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 1c7a71b5248e..ed1a47d9c35d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -487,12 +487,13 @@ static struct task_struct *task_early_kill(struct task_struct *tsk,
 static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 				int force_early)
 {
+	struct folio *folio = page_folio(page);
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct anon_vma *av;
 	pgoff_t pgoff;
 
-	av = page_lock_anon_vma_read(page);
+	av = folio_lock_anon_vma_read(folio);
 	if (av == NULL)	/* Not actually mapped anymore */
 		return;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index ffc1b2f0cf24..ba65d5d3eb5a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -526,28 +526,28 @@ struct anon_vma *page_get_anon_vma(struct page *page)
  * atomic op -- the trylock. If we fail the trylock, we fall back to getting a
  * reference like with page_get_anon_vma() and then block on the mutex.
  */
-struct anon_vma *page_lock_anon_vma_read(struct page *page)
+struct anon_vma *folio_lock_anon_vma_read(struct folio *folio)
 {
 	struct anon_vma *anon_vma = NULL;
 	struct anon_vma *root_anon_vma;
 	unsigned long anon_mapping;
 
 	rcu_read_lock();
-	anon_mapping = (unsigned long)READ_ONCE(page->mapping);
+	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
 	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
 		goto out;
-	if (!page_mapped(page))
+	if (!folio_mapped(folio))
 		goto out;
 
 	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
 	root_anon_vma = READ_ONCE(anon_vma->root);
 	if (down_read_trylock(&root_anon_vma->rwsem)) {
 		/*
-		 * If the page is still mapped, then this anon_vma is still
+		 * If the folio is still mapped, then this anon_vma is still
 		 * its anon_vma, and holding the mutex ensures that it will
 		 * not go away, see anon_vma_free().
 		 */
-		if (!page_mapped(page)) {
+		if (!folio_mapped(folio)) {
 			up_read(&root_anon_vma->rwsem);
 			anon_vma = NULL;
 		}
@@ -560,7 +560,7 @@ struct anon_vma *page_lock_anon_vma_read(struct page *page)
 		goto out;
 	}
 
-	if (!page_mapped(page)) {
+	if (!folio_mapped(folio)) {
 		rcu_read_unlock();
 		put_anon_vma(anon_vma);
 		return NULL;
-- 
2.34.1

