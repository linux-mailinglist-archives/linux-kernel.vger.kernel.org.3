Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C717C51B40B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiEEAFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380766AbiEDXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:51:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34B2A708
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:47:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so6504469pjv.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j6CzDM1WQ1731Av9cU1L+oYd+q4PP23xeD40nU98Nko=;
        b=EljRlgbclc3Y+ZqAglQ4g56iKrAuOSq8YUI91uSSoDHcRPF6yuNc7YRm/yrbEPUu56
         SnnhaD6E7eJ34TsanHzOddlDSFF1PPnU/CFRzeNf3KNFt1oYFN3YJFkhFOqogyjpr73H
         MzDJb0+Qu3kIt8F+JBkQKdhzrCs3urvcw5OYsdS6at/q2G4px14CiX7ASdzBXAh45UWC
         CWkCbw2Vs0OPsiYcdi6ubhBdfmK8zjRx2/1RNk8rggNO3L0VpO5VtwKGN9BQmyT/jmNP
         RcE/99Oac7RyKAyNUFDKKz9zzkNNCOxRizMNSMgwVs99UepZplyAQCDklDDO1QanJJR4
         b1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=j6CzDM1WQ1731Av9cU1L+oYd+q4PP23xeD40nU98Nko=;
        b=E5zcecqxJEKYIegU6tkp8+4pad+i0yOLWPY6MqU4iD6ytr07FD1c2JyjKnjeSc6BV1
         v1gEC08Nvy1os7WdoNNtPA++FwppQn9wHYwqQDCWVn2+tRzI64T3FbLVPDjt24rPEazP
         f1ys4mb0GkZZkozVDuViHm0nXByAYwo/nbrfLuIquVgSlSKmL5NuugzLri/1vAg6kYtu
         gshbHTKaLsOKq8FWnh4bQQPFqWM4I/bz8odHdDoLrtoEdxtfpig1auHLeZaCoNAgNUEa
         6AhCXP+UnwfvM/57DNv2jo5RQ/QRM4mJGEPHcG2NW7EO5sRY81P14Mge/RXfIaTJTr1P
         HKKA==
X-Gm-Message-State: AOAM532Kk6gCmoVzslirrIMNlhJ9kXcHYQ6qaVFv6FiYtOaff1wnXlMZ
        jDSU+LDNlA+cdy2mTibgkKQ=
X-Google-Smtp-Source: ABdhPJwpqv2n+a9T8BsInUCcx/7qMnJIW8A0uFmJ9J7q/7hSe28d0zT/xLc3clrEU/1evPe3jABunQ==
X-Received: by 2002:a17:90a:4a8a:b0:1d5:a3df:ab5 with SMTP id f10-20020a17090a4a8a00b001d5a3df0ab5mr2538895pjh.64.1651708074031;
        Wed, 04 May 2022 16:47:54 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8435:b3e7:62fc:4dfa])
        by smtp.gmail.com with ESMTPSA id gg7-20020a17090b0a0700b001d97f17f9b5sm3875576pjb.35.2022.05.04.16.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:47:53 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 4 May 2022 16:47:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnMQp/zJVHu9Qq/S@google.com>
References: <20220503170341.1413961-1-minchan@kernel.org>
 <YnHzvV2Uz2ynENnG@casper.infradead.org>
 <YnIBbjRYACzvuZpp@google.com>
 <YnIYofrw/GGEvc0U@casper.infradead.org>
 <YnKhLX+jzJc+2KwB@google.com>
 <YnKwBeRAWwIlEVqy@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnKwBeRAWwIlEVqy@casper.infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:55:33PM +0100, Matthew Wilcox wrote:
> On Wed, May 04, 2022 at 08:52:13AM -0700, Minchan Kim wrote:
> > On Wed, May 04, 2022 at 07:09:37AM +0100, Matthew Wilcox wrote:
> > > On Tue, May 03, 2022 at 09:30:38PM -0700, Minchan Kim wrote:
> > > > On Wed, May 04, 2022 at 04:32:13AM +0100, Matthew Wilcox wrote:
> > > > > On Tue, May 03, 2022 at 10:03:41AM -0700, Minchan Kim wrote:
> > > > > > -void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc);
> > > > > > -void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc);
> > > > > > +void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
> > > > > > +void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
> > > > > 
> > > > > I see the build bot already beat me to pointing out why this is wrong,
> > > > > but do you not look at git log to figure out why code was changed to be
> > > > > the way it is now, before you change it back?
> > > > 
> > > > This patch added a new field as out param like compact_control so
> > > > the rmap_walk_control is not immutable.
> > > 
> > > ... but we have a user which treats it as if it is.
> > 
> > True. I don't think it will show sizable benefit on runtime overhead
> > since rmap_walk is already one of the most expensive operation in MM.
> > 
> > I could reintroduce the typecast for page_idle_clear_pte_refs to remove
> > the const as we had several years.
> > 
> > If your concern was to make rmap_walk_control mutable back, I could
> > change rmap_walk function having return value or adding a addtional
> > new out param. However, I thought rmap_walk_control is more readable/
> > easier than them.
> 
> I haven't thought deeply about it, but I suspect the right approach is
> to remove the rather dubious optimisation in page_idle_clear_pte_refs().

Ccing Vladimir

From a7f755e7e5cbe5d33893f9d4ca6bd95638ce1b16 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 3 May 2022 09:47:37 -0700
Subject: [PATCH v2] mm: don't be stuck to rmap lock on reclaim path

The rmap locks(i_mmap_rwsem and anon_vma->root->rwsem) could be
contented under memory pressure if processes keep working on
their vmas(e.g., fork, mmap, munmap). It makes reclaim path
stuck. In our real workload traces, we see kswapd is waiting the
lock for 300ms+(worst case, a sec) and it makes other processes
entering direct reclaim, which were also stuck on the lock.

This patch makes LRU aging path try_lock mode like shink_page_list
so the reclaim context will keep working with next LRU pages
without being stuck.

Since this patch introduces a new "contended" field as out param
in rmap_walk_control, it's not immutable any longer so remove
const keywords on rmap related functions. Since rmap walking
is already expensive operation, I doubt the const would help sizable
benefit(And we didn't have it until 5.17).

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/fs.h   |  5 +++++
 include/linux/ksm.h  |  4 ++--
 include/linux/rmap.h | 28 +++++++++++++++++-------
 mm/ksm.c             | 10 +++++++--
 mm/memory-failure.c  |  2 +-
 mm/page_idle.c       |  7 ++----
 mm/rmap.c            | 52 ++++++++++++++++++++++++++++++++++----------
 mm/vmscan.c          |  6 ++++-
 8 files changed, 84 insertions(+), 30 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5ec00b2f073..5a169066f463 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -477,6 +477,11 @@ static inline void i_mmap_unlock_write(struct address_space *mapping)
 	up_write(&mapping->i_mmap_rwsem);
 }
 
+static inline int i_mmap_trylock_read(struct address_space *mapping)
+{
+	return down_read_trylock(&mapping->i_mmap_rwsem);
+}
+
 static inline void i_mmap_lock_read(struct address_space *mapping)
 {
 	down_read(&mapping->i_mmap_rwsem);
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 0630e545f4cb..0b4f17418f64 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -51,7 +51,7 @@ static inline void ksm_exit(struct mm_struct *mm)
 struct page *ksm_might_need_to_copy(struct page *page,
 			struct vm_area_struct *vma, unsigned long address);
 
-void rmap_walk_ksm(struct folio *folio, const struct rmap_walk_control *rwc);
+void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
 
 #else  /* !CONFIG_KSM */
@@ -79,7 +79,7 @@ static inline struct page *ksm_might_need_to_copy(struct page *page,
 }
 
 static inline void rmap_walk_ksm(struct folio *folio,
-			const struct rmap_walk_control *rwc)
+			struct rmap_walk_control *rwc)
 {
 }
 
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index cbe279a6f0de..9ec23138e410 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -128,6 +128,11 @@ static inline void anon_vma_lock_read(struct anon_vma *anon_vma)
 	down_read(&anon_vma->root->rwsem);
 }
 
+static inline int anon_vma_trylock_read(struct anon_vma *anon_vma)
+{
+	return down_read_trylock(&anon_vma->root->rwsem);
+}
+
 static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
 {
 	up_read(&anon_vma->root->rwsem);
@@ -366,17 +371,14 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 
 void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
 
-/*
- * Called by memory-failure.c to kill processes.
- */
-struct anon_vma *folio_lock_anon_vma_read(struct folio *folio);
-void page_unlock_anon_vma_read(struct anon_vma *anon_vma);
 int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
 
 /*
  * rmap_walk_control: To control rmap traversing for specific needs
  *
  * arg: passed to rmap_one() and invalid_vma()
+ * try_lock: bail out if the rmap lock is contended
+ * contended: indicate the rmap traversal bailed out due to lock contention
  * rmap_one: executed on each vma where page is mapped
  * done: for checking traversing termination condition
  * anon_lock: for getting anon_lock by optimized way rather than default
@@ -384,6 +386,8 @@ int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
  */
 struct rmap_walk_control {
 	void *arg;
+	bool try_lock;
+	bool contended;
 	/*
 	 * Return false if page table scanning in rmap_walk should be stopped.
 	 * Otherwise, return true.
@@ -391,12 +395,20 @@ struct rmap_walk_control {
 	bool (*rmap_one)(struct folio *folio, struct vm_area_struct *vma,
 					unsigned long addr, void *arg);
 	int (*done)(struct folio *folio);
-	struct anon_vma *(*anon_lock)(struct folio *folio);
+	struct anon_vma *(*anon_lock)(struct folio *folio,
+				      struct rmap_walk_control *rwc);
 	bool (*invalid_vma)(struct vm_area_struct *vma, void *arg);
 };
 
-void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc);
-void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc);
+void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
+void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
+
+/*
+ * Called by memory-failure.c to kill processes.
+ */
+struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
+					  struct rmap_walk_control *rwc);
+void page_unlock_anon_vma_read(struct anon_vma *anon_vma);
 
 #else	/* !CONFIG_MMU */
 
diff --git a/mm/ksm.c b/mm/ksm.c
index ee607d3f8720..26da7f813f23 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2614,7 +2614,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 	return new_page;
 }
 
-void rmap_walk_ksm(struct folio *folio, const struct rmap_walk_control *rwc)
+void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 {
 	struct stable_node *stable_node;
 	struct rmap_item *rmap_item;
@@ -2638,7 +2638,13 @@ void rmap_walk_ksm(struct folio *folio, const struct rmap_walk_control *rwc)
 		struct vm_area_struct *vma;
 
 		cond_resched();
-		anon_vma_lock_read(anon_vma);
+		if (!anon_vma_trylock_read(anon_vma)) {
+			if (rwc->try_lock) {
+				rwc->contended = true;
+				return;
+			}
+			anon_vma_lock_read(anon_vma);
+		}
 		anon_vma_interval_tree_foreach(vmac, &anon_vma->rb_root,
 					       0, ULONG_MAX) {
 			unsigned long addr;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a83d32bbc567..09d60bc93140 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -485,7 +485,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 	struct anon_vma *av;
 	pgoff_t pgoff;
 
-	av = folio_lock_anon_vma_read(folio);
+	av = folio_lock_anon_vma_read(folio, NULL);
 	if (av == NULL)	/* Not actually mapped anymore */
 		return;
 
diff --git a/mm/page_idle.c b/mm/page_idle.c
index fc0435abf909..fdff8c6dcd2d 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -86,11 +86,8 @@ static bool page_idle_clear_pte_refs_one(struct folio *folio,
 static void page_idle_clear_pte_refs(struct page *page)
 {
 	struct folio *folio = page_folio(page);
-	/*
-	 * Since rwc.arg is unused, rwc is effectively immutable, so we
-	 * can make it static const to save some cycles and stack.
-	 */
-	static const struct rmap_walk_control rwc = {
+
+	static struct rmap_walk_control rwc = {
 		.rmap_one = page_idle_clear_pte_refs_one,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
diff --git a/mm/rmap.c b/mm/rmap.c
index 61e63db5dc6f..bbf32dbeb8ee 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -527,9 +527,11 @@ struct anon_vma *page_get_anon_vma(struct page *page)
  *
  * Its a little more complex as it tries to keep the fast path to a single
  * atomic op -- the trylock. If we fail the trylock, we fall back to getting a
- * reference like with page_get_anon_vma() and then block on the mutex.
+ * reference like with page_get_anon_vma() and then block on the mutex
+ * on !rwc->try_lock case.
  */
-struct anon_vma *folio_lock_anon_vma_read(struct folio *folio)
+struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
+					  struct rmap_walk_control *rwc)
 {
 	struct anon_vma *anon_vma = NULL;
 	struct anon_vma *root_anon_vma;
@@ -557,6 +559,12 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio)
 		goto out;
 	}
 
+	if (rwc && rwc->try_lock) {
+		anon_vma = NULL;
+		rwc->contended = true;
+		goto out;
+	}
+
 	/* trylock failed, we got to sleep */
 	if (!atomic_inc_not_zero(&anon_vma->refcount)) {
 		anon_vma = NULL;
@@ -883,7 +891,8 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
  *
  * Quick test_and_clear_referenced for all mappings of a folio,
  *
- * Return: The number of mappings which referenced the folio.
+ * Return: The number of mappings which referenced the folio. Return -1 if
+ * the function bailed out due to lock contention.
  */
 int folio_referenced(struct folio *folio, int is_locked,
 		     struct mem_cgroup *memcg, unsigned long *vm_flags)
@@ -897,6 +906,7 @@ int folio_referenced(struct folio *folio, int is_locked,
 		.rmap_one = folio_referenced_one,
 		.arg = (void *)&pra,
 		.anon_lock = folio_lock_anon_vma_read,
+		.try_lock = true,
 	};
 
 	*vm_flags = 0;
@@ -927,7 +937,7 @@ int folio_referenced(struct folio *folio, int is_locked,
 	if (we_locked)
 		folio_unlock(folio);
 
-	return pra.referenced;
+	return rwc.contended ? -1 : pra.referenced;
 }
 
 static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
@@ -2307,12 +2317,12 @@ void __put_anon_vma(struct anon_vma *anon_vma)
 }
 
 static struct anon_vma *rmap_walk_anon_lock(struct folio *folio,
-					const struct rmap_walk_control *rwc)
+					    struct rmap_walk_control *rwc)
 {
 	struct anon_vma *anon_vma;
 
 	if (rwc->anon_lock)
-		return rwc->anon_lock(folio);
+		return rwc->anon_lock(folio, rwc);
 
 	/*
 	 * Note: remove_migration_ptes() cannot use folio_lock_anon_vma_read()
@@ -2324,7 +2334,17 @@ static struct anon_vma *rmap_walk_anon_lock(struct folio *folio,
 	if (!anon_vma)
 		return NULL;
 
+	if (anon_vma_trylock_read(anon_vma))
+		goto out;
+
+	if (rwc->try_lock) {
+		anon_vma = NULL;
+		rwc->contended = true;
+		goto out;
+	}
+
 	anon_vma_lock_read(anon_vma);
+out:
 	return anon_vma;
 }
 
@@ -2338,7 +2358,7 @@ static struct anon_vma *rmap_walk_anon_lock(struct folio *folio,
  * contained in the anon_vma struct it points to.
  */
 static void rmap_walk_anon(struct folio *folio,
-		const struct rmap_walk_control *rwc, bool locked)
+		struct rmap_walk_control *rwc, bool locked)
 {
 	struct anon_vma *anon_vma;
 	pgoff_t pgoff_start, pgoff_end;
@@ -2386,7 +2406,7 @@ static void rmap_walk_anon(struct folio *folio,
  * contained in the address_space struct it points to.
  */
 static void rmap_walk_file(struct folio *folio,
-		const struct rmap_walk_control *rwc, bool locked)
+		struct rmap_walk_control *rwc, bool locked)
 {
 	struct address_space *mapping = folio_mapping(folio);
 	pgoff_t pgoff_start, pgoff_end;
@@ -2405,8 +2425,18 @@ static void rmap_walk_file(struct folio *folio,
 
 	pgoff_start = folio_pgoff(folio);
 	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
-	if (!locked)
+	if (!locked) {
+		if (i_mmap_trylock_read(mapping))
+			goto lookup;
+
+		if (rwc->try_lock) {
+			rwc->contended = true;
+			return;
+		}
+
 		i_mmap_lock_read(mapping);
+	}
+lookup:
 	vma_interval_tree_foreach(vma, &mapping->i_mmap,
 			pgoff_start, pgoff_end) {
 		unsigned long address = vma_address(&folio->page, vma);
@@ -2428,7 +2458,7 @@ static void rmap_walk_file(struct folio *folio,
 		i_mmap_unlock_read(mapping);
 }
 
-void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc)
+void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc)
 {
 	if (unlikely(folio_test_ksm(folio)))
 		rmap_walk_ksm(folio, rwc);
@@ -2439,7 +2469,7 @@ void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc)
 }
 
 /* Like rmap_walk, but caller holds relevant rmap lock */
-void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc)
+void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
 {
 	/* no ksm support for now */
 	VM_BUG_ON_FOLIO(folio_test_ksm(folio), folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6918fff06e1..e68c5715270a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1391,6 +1391,10 @@ static enum page_references folio_check_references(struct folio *folio,
 	if (vm_flags & VM_LOCKED)
 		return PAGEREF_ACTIVATE;
 
+	/* page_referenced didn't work due to lock contention */
+	if (referenced_ptes == -1)
+		return PAGEREF_KEEP;
+
 	if (referenced_ptes) {
 		/*
 		 * All mapped folios start out with page table
@@ -2492,7 +2496,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 		}
 
 		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
-				     &vm_flags)) {
+				     &vm_flags) > 0) {
 			/*
 			 * Identify referenced, file-backed active pages and
 			 * give them one more trip around the active list. So
-- 
2.36.0.512.ge40c2bad7a-goog

