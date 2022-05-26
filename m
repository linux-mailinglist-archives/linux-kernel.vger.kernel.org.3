Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8C453526A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348228AbiEZRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiEZRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:08:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88A14F9F4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:08:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x143so2165555pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OcC8f2hFYyHfueTeOB0cD4jDBmTaItpMpyDOzwiQxIA=;
        b=NcW66NRGSofp55oDmy9/TtsSNjTH7zASspQnPWXRX3o3oWzHXB7G6eyb0qndNR8QHw
         F8yuM2LGaVI8repLaUa6Q9Cvt1wXiMtls+mGyIkWyg9zeqtbkH8MuwclpANBNTwY9NSD
         khuwdRQBQyJpGHqkHgcFUG8fUudrtHJnJ+Ef6NXpn+OVlnxdowPNEBAhykYf9EXQFtLQ
         9sGAjxpOH067IYOGBJg8d9bHURznZHUZPlvqCzTa0ZbRlotnyMjMfjJBqXmc1d/5KIBq
         XB8cf8AeZ0FAl3AjrqJQSaPhg7JDtz1EWYJ8fUtRNt9mmbRzQTgAkDSmGFNMvG3Uw2tE
         bzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=OcC8f2hFYyHfueTeOB0cD4jDBmTaItpMpyDOzwiQxIA=;
        b=REVJ5k37t/QIsICTW6LZPY/mYBSfdYcbPhf4AljFbyeFzxX5TjpXRaRRYMZqSMqlhZ
         X4dBE7AcMg/VjVb/vea9/uC2SD8AMa2861gQS3IZMQLIxFJhW5PEggqCBJQs5WIQROM/
         PP+4K0GYo9CJmG6ikHdn7qBv4BJakjknpGrSApmE8x8+n3jTyxYto7Fj/1//uIi/7YL3
         24Pkl5J6A1gYiFrhtASx8T3RGgizsGMO5i7FbtOIloDsAic4/9IGXONGTXl1ZWGZPdsN
         s/44VGvxw4jDkA9MdT+gNGphBhxZhzHDZdoJFNcwsJT/FkwsKoolp187m9JESO9Mk007
         xKuw==
X-Gm-Message-State: AOAM532JQ23pifGDvb3xSZrfaQRt6e0mQGJRX9W2Sq/IMbDOi11Uou8k
        1zqRBFtyN5Udzs0QUfeStVBlDrSfNV4=
X-Google-Smtp-Source: ABdhPJwuup7so9XNpSp/cfKWd4CIzIYeOsKBC/XI92dfbS6cCN2iPa0VV4yfjqtCTw37mZIMG3/twQ==
X-Received: by 2002:a63:8aca:0:b0:3f9:f9ed:7426 with SMTP id y193-20020a638aca000000b003f9f9ed7426mr22819562pgd.176.1653584927373;
        Thu, 26 May 2022 10:08:47 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:492b:befb:16f:e62])
        by smtp.gmail.com with ESMTPSA id m5-20020a63f605000000b003faebbb772esm1800120pgh.25.2022.05.26.10.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 10:08:46 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 26 May 2022 10:08:44 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Martin Liu <liumartin@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] mm: throttle LRU pages skipping on rmap_lock contention
Message-ID: <Yo+0HMJYuhiJv+Ak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Thu, May 12, 2022 at 12:55:16PM -0700, Minchan Kim wrote:
> On Wed, May 11, 2022 at 07:05:23PM -0700, Andrew Morton wrote:
> > On Wed, 11 May 2022 15:57:09 -0700 Minchan Kim <minchan@kernel.org> wrote:
> > 
> > > > 
> > > > Could we burn much CPU time pointlessly churning though the LRU?  Could
> > > > it mess up aging decisions enough to be performance-affecting in any
> > > > workload?
> > > 
> > > Yes, correct. However, we are already churning LRUs by several
> > > ways. For example, isolate and putback from LRU list for page
> > > migration from several sources(typical example is compaction)
> > > and trylock_page and sc->gfp_mask not allowing page to be
> > > reclaimed in shrink_page_list.
> > 
> > Well.  "we're already doing a risky thing so it's OK to do more of that
> > thing"?
> 
> I meant the aging is not rocket science.
> 
> 
> > 
> > > > 
> > > > Something else?
> > > 
> > > One thing I am worry about was the granularity of the churning.
> > > Example above was page granuarity churning so might be execuse
> > > but this one is address space's churning, especically for file LRU
> > > (i_mmap_rwsem) which might cause too many rotating and live-lock
> > > in the end(keey rotating in small LRU with heavy memory pressure).
> > > 
> > > If it could be a problem, maybe we use sc->priority to stop
> > > the skipping on a certain level of memory pressure.
> > > 
> > > Any thought? Do we really need it?
> > 
> > Are we able to think of a test which might demonstrate any worst case? 
> > Whip that up and see what the numbers say?
> 
> Yeah, let me create a worst test case to see how it goes.
> 
> A thread keep reading a file-backed vma with 2xRAM file but other threads
> keep changing other vmas mapped at the same file so heavy i_mmap_rwsem
> contention in aging path.

Forking new thread

I checked what happens the worst case. I am not sure how the worst
case is realistic but would be great to have safety net.

From 5ccc8b170af5496f803243732e96b131419d7462 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Thu, 19 May 2022 19:48:12 -0700
Subject: [PATCH] mm: throttle LRU pages skipping on rmap_lock contention

On heavy contention on rmap_lock(e.g., i_mmap_rwsem), VM can keep
skipping LRU pages so reclaim efficiency(steal/scanning) would drop
from 48% to 27% and workingset would be reclaimed faster than old
so workingset_refault rate increased to 240%.

We need a safe net to throttle the skipping LRU pages. This patch
throttle the skipping policy using (DEF_PRIRORITY - 2) magic value
VM has used for indicating non-light memory pressure.
IOW, let's skip rmap_lock contendeded pages only when
only when sc->priority >= (DEF_PRIRORITY - 2).

The test scenario to see the worst case:

1. A thread mmap a big file(e.g., 2x times of RAM) and keep touching
   the address space up to three times.
2. B thread keeps doing mmap/munmap with the same file to cause
   heavy lock contention in i_mmap_rwsem until the A thread finish
   the job.
3. measure vmstat and thread A's elapsed time.

Thread's elapsed time:

1. vanilla
24.64sec(5.04%)

2. rmap_skip(i.e., mm-dont-be-stuck-to-rmap-lock-on-reclaim-path.patch)
25.20sec(4.16%)

3. priority(2 + this patch)
23.62sec(6.61%)

Vmstat Comparison:
				     vanilla    rmap_skip    priority
	     allocstall_movable          582         9772       14643
		     pgactivate          232        25865        4906
      		   pgdeactivate           78        17265         651
        	     pgmajfault           58        10639        1376
    		 pgsteal_kswapd     15947857     15133195    15095445
    		 pgsteal_direct       105439       583092      943195
     	          pgscan_kswapd     24647536     52768898    28103170
     		  pgscan_direct      8398139      3767100     7966353
	workingset_refault_file     12582926     12248353    12565934

B test scenario

1. A thread mmap a big file(e.g., 2x times of RAM) and keep touching
   the address space up to three times.
2. B thread keeps doing mmap/munmap with the same file to cause
   heavy lock contention in i_mmap_rwsem until the A thread finish
   the job.
3. C thread keep reading other big file using read(2) syscall
4. measure vmstat and thread A's elapsed time.

1. vanilla
27.24sec(5.29%)

2. rmap_skip
33.54sec(3.20%)

3. priority
28.68sec(1.26%)

Vmstat Comparison:
				     vanilla    rmap_skip    priority
	     allocstall_movable        15262        81258       21644
        	     pgactivate      3042004      3086906     3502959
      		   pgdeactivate      2307849      8959162     3605768
        	     pgmajfault          566         1059	  557
    		 pgsteal_kswapd     17557735     30861283    18385674
    		 pgsteal_direct       955389      6353527     1233605
     		  pgscan_kswapd     31622695     59670433    35372575
		  pgscan_direct      4924052     13939254     4310247
	workingset_refault_file     13466538     32193161    14588019

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/rmap.h | 5 +++--
 mm/rmap.c            | 6 ++++--
 mm/vmscan.c          | 6 ++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 9ec23138e410..2893da3f1cd3 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -296,7 +296,8 @@ static inline int page_try_share_anon_rmap(struct page *page)
  * Called from mm/vmscan.c to handle paging out
  */
 int folio_referenced(struct folio *, int is_locked,
-			struct mem_cgroup *memcg, unsigned long *vm_flags);
+			struct mem_cgroup *memcg, unsigned long *vm_flags,
+			bool rmap_try_lock);
 
 void try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
@@ -418,7 +419,7 @@ void page_unlock_anon_vma_read(struct anon_vma *anon_vma);
 
 static inline int folio_referenced(struct folio *folio, int is_locked,
 				  struct mem_cgroup *memcg,
-				  unsigned long *vm_flags)
+				  unsigned long *vm_flags, bool rmap_try_lock)
 {
 	*vm_flags = 0;
 	return 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index d4cf3ea1b616..a75c7f7a0392 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -888,6 +888,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
  * @is_locked: Caller holds lock on the folio.
  * @memcg: target memory cgroup
  * @vm_flags: A combination of all the vma->vm_flags which referenced the folio.
+ * @rmap_try_lock: bail out if the rmap lock is contended
  *
  * Quick test_and_clear_referenced for all mappings of a folio,
  *
@@ -895,7 +896,8 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
  * the function bailed out due to rmap lock contention.
  */
 int folio_referenced(struct folio *folio, int is_locked,
-		     struct mem_cgroup *memcg, unsigned long *vm_flags)
+		     struct mem_cgroup *memcg, unsigned long *vm_flags,
+		     bool rmap_try_lock)
 {
 	int we_locked = 0;
 	struct folio_referenced_arg pra = {
@@ -906,7 +908,7 @@ int folio_referenced(struct folio *folio, int is_locked,
 		.rmap_one = folio_referenced_one,
 		.arg = (void *)&pra,
 		.anon_lock = folio_lock_anon_vma_read,
-		.try_lock = true,
+		.try_lock = rmap_try_lock,
 	};
 
 	*vm_flags = 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ac168f4b0492..f0987e027aba 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1381,7 +1381,8 @@ static enum page_references folio_check_references(struct folio *folio,
 	unsigned long vm_flags;
 
 	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
-					   &vm_flags);
+					   &vm_flags,
+					   sc->priority >= DEF_PRIORITY - 2);
 	referenced_folio = folio_test_clear_referenced(folio);
 
 	/*
@@ -2497,7 +2498,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 		/* Referenced or rmap lock contention: rotate */
 		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
-				     &vm_flags) != 0) {
+				     &vm_flags,
+				     sc->priority >= DEF_PRIORITY - 2) != 0) {
 			/*
 			 * Identify referenced, file-backed active pages and
 			 * give them one more trip around the active list. So
-- 
2.36.1.124.g0e6072fb45-goog

