Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1394A2A9D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiA2Adc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiA2Ada (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:33:30 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80CC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:33:30 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-53-ed;
 t=1643416409; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=Ks58RD92sFw1u4MB19gv/koeUljumN7OZNwwzwqESMg=;
 b=GydC0FU6vw4+iPN7EbvznPgucVy/xofT+Usuu4cmXupf8aIP5votm1UGluhzGJVYhYHX0
 VgBMfvgzy49ZWUnAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-53-rsa; t=1643416409; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=Ks58RD92sFw1u4MB19gv/koeUljumN7OZNwwzwqESMg=;
 b=BQP2aVVJwWLZaQGslcdEA4461tfkn3lV+mH53sNQ4HqTI2qpWTXRzwZarK4tah61Tm20L
 m0c+G76dwHAt+ycXy/dA30Q7OVPsTqIRpwSbJxK7VnADm8SN2dwwTshQj0q1xSz+3gB7+ph
 D049T9ZuLYmaChIFAaseiwvhGtumJbL++TpDybWha/F6lSOsVZmbIBqj7aJwX03n3c9bx0n
 fMoTpXA8guGQQV46TrZJ+GECgavBKXRbvsQMsuF5u63Agz1q/ljaCFYBUZQchYhtL+n3udy
 KBvjjwQDdHnrM5Hyb0/f9J58vZw6IrxWxQXVMqtCQUl85n5zrVEWxWYh9pLA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 84F5116094C; Fri, 28 Jan 2022 16:33:29 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:33:29 -0800
From:   Michel Lespinasse <michel@lespinasse.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 12/35] mm: separate mmap locked assertion from find_vma
Message-ID: <20220129003329.GB18863@lespinasse.org>
References: <20220128131006.67712-13-michel@lespinasse.org>
 <202201290752.GKB0XPLn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201290752.GKB0XPLn-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 08:08:15AM +0800, kernel test robot wrote:
> >> mm/nommu.c:666:24: error: redefinition of 'find_vma'
>    struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>                           ^
>    include/linux/mm.h:2759:24: note: previous definition is here
>    struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>                           ^
>    1 error generated.

Nice catch. The following amended patch should fix this:
(I only added the mm/nommu.c changes)

----------------------------------- 8< ----------------------------------

mm: separate mmap locked assertion from find_vma

This adds a new __find_vma() function, which implements find_vma minus
the mmap_assert_locked() assertion.

find_vma() is then implemented as an inline wrapper around __find_vma().

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
 include/linux/mm.h                    | 9 ++++++++-
 mm/mmap.c                             | 5 ++---
 mm/nommu.c                            | 4 ++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 5ae812d60abe..94ab71a9b493 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -515,7 +515,7 @@ static void error_print_context(struct drm_i915_error_state_buf *m,
 }
 
 static struct i915_vma_coredump *
-__find_vma(struct i915_vma_coredump *vma, const char *name)
+__i915_find_vma(struct i915_vma_coredump *vma, const char *name)
 {
 	while (vma) {
 		if (strcmp(vma->name, name) == 0)
@@ -529,7 +529,7 @@ __find_vma(struct i915_vma_coredump *vma, const char *name)
 static struct i915_vma_coredump *
 find_batch(const struct intel_engine_coredump *ee)
 {
-	return __find_vma(ee->vma, "batch");
+	return __i915_find_vma(ee->vma, "batch");
 }
 
 static void error_print_engine(struct drm_i915_error_state_buf *m,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4600dbb98cef..6f7712179503 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2751,10 +2751,17 @@ extern int expand_upwards(struct vm_area_struct *vma, unsigned long address);
 #endif
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
-extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
+extern struct vm_area_struct * __find_vma(struct mm_struct * mm, unsigned long addr);
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
 					     struct vm_area_struct **pprev);
 
+static inline
+struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+{
+	mmap_assert_locked(mm);
+	return __find_vma(mm, addr);
+}
+
 /**
  * find_vma_intersection() - Look up the first VMA which intersects the interval
  * @mm: The process address space.
diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..b09a2c875507 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2276,12 +2276,11 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 EXPORT_SYMBOL(get_unmapped_area);
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *__find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
 
-	mmap_assert_locked(mm);
 	/* Check the cache first. */
 	vma = vmacache_find(mm, addr);
 	if (likely(vma))
@@ -2308,7 +2307,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
-EXPORT_SYMBOL(find_vma);
+EXPORT_SYMBOL(__find_vma);
 
 /*
  * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
diff --git a/mm/nommu.c b/mm/nommu.c
index 55a9e48a7a02..8d2582ff319f 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -663,7 +663,7 @@ static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
  * look up the first VMA in which addr resides, NULL if none
  * - should be called with mm->mmap_lock at least held readlocked
  */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *__find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
 
@@ -685,7 +685,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 
 	return NULL;
 }
-EXPORT_SYMBOL(find_vma);
+EXPORT_SYMBOL(__find_vma);
 
 /*
  * find a VMA
-- 
2.20.1

