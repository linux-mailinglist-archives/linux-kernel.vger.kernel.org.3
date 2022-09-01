Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485255A9E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiIARg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiIARfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E033E2C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33f8988daecso226839287b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=LVrV0vnZTvQ/veouCVIJ2VKTA1Jw28r4MCl6DiRcaDY=;
        b=l1V4yVONtNOUfesG20Bnq72dRtkCeRcz+SXGtADVXwnLsewU/bV2Wj+5K0ek8rbJL5
         /VnIb4yjvzQAA64ppyeiv2tN7SgqNypFCNDrFPFTIYKrt4K6WTB+yC3yHFvMB+ausBHt
         SSGrmorbtqBk+v9sXJa+cknHYK7SdsAdZfIlHKdNs08dvIfwUr5y5G+bCOuk9GDx3jZe
         o3Fb422GusB/mLwU2fWqp5J3gMNLaE1B/UaEPdikTdaz6ywBZryiSPL/0bdT3F8UE3iA
         1RBsfylmTB6McidRxeHwpl546i9VITPOIoqZ/5tnno4M6ww922Mvm4adk4fXxTHJ359z
         mtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=LVrV0vnZTvQ/veouCVIJ2VKTA1Jw28r4MCl6DiRcaDY=;
        b=yc1mqCDoCZW4zVJFLkxn37oFUIZNzisU/nI3evCXlTu94R9J5pojlLfMarNCZ4sjl2
         Jw8XSj+jru+/SkVJ8zUwCIMdzWzlU214CSGnArdo+KvUMkVYlXWB/eCVD4ktjEX0fzou
         P8N1IEEPlWhmuyfOVWQ5l2zN5GfaR/ll+XzOnFSKPJcrlUxBF1cWoQIQ0IAE5fmTwl5s
         v59QEQYSUlLb0TbECNwbPeUvYJdKJtn6f6/BHl3J7J3GOC8rbt6xIcja5zUWvkjY/vli
         XkV+lD/wxSFvoUgncUZO8Dd6r5j0M4x7WXiCTv0bXv4ggvD5Rja65X5OfS+DiuwzLdKD
         eD5g==
X-Gm-Message-State: ACgBeo23Q/aOfrNS4fljq8MKh078q+FyI9oyCuw7tnU4EkBSQnmZEFBs
        fV3Pu3VkCFF+LPbjXuUqQtUNbuRYPkE=
X-Google-Smtp-Source: AA6agR5xL9cSC69c+1y/uWKTqLFokWxQZenGw3Ln10dS2nyve2acvx9iJCiS8dOE4h1muByL940MlpUFLCY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:25cf:0:b0:6a2:fe22:657 with SMTP id
 l198-20020a2525cf000000b006a2fe220657mr784117ybl.481.1662053729233; Thu, 01
 Sep 2022 10:35:29 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:51 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-4-surenb@google.com>
Subject: [RFC PATCH RESEND 03/28] mm: introduce __find_vma to be used without
 mmap_lock protection
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __find_vma function to be used for VMA lookup under rcu protection.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
 include/linux/mm.h                    | 9 ++++++++-
 mm/mmap.c                             | 6 ++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 32e92651ef7c..fc94985c95c8 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -507,7 +507,7 @@ static void error_print_context(struct drm_i915_error_state_buf *m,
 }
 
 static struct i915_vma_coredump *
-__find_vma(struct i915_vma_coredump *vma, const char *name)
+__i915_find_vma(struct i915_vma_coredump *vma, const char *name)
 {
 	while (vma) {
 		if (strcmp(vma->name, name) == 0)
@@ -521,7 +521,7 @@ __find_vma(struct i915_vma_coredump *vma, const char *name)
 struct i915_vma_coredump *
 intel_gpu_error_find_batch(const struct intel_engine_coredump *ee)
 {
-	return __find_vma(ee->vma, "batch");
+	return __i915_find_vma(ee->vma, "batch");
 }
 
 static void error_print_engine(struct drm_i915_error_state_buf *m,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21f8b27bd9fd..7d322a979455 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2712,7 +2712,14 @@ extern int expand_upwards(struct vm_area_struct *vma, unsigned long address);
 #endif
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
-extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
+extern struct vm_area_struct *__find_vma(struct mm_struct *mm, unsigned long addr);
+static inline
+struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+{
+	mmap_assert_locked(mm);
+	return __find_vma(mm, addr);
+}
+
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
 					     struct vm_area_struct **pprev);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 9d780f415be3..693e6776be39 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2250,12 +2250,11 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
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
@@ -2281,8 +2280,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
-EXPORT_SYMBOL(find_vma);
+EXPORT_SYMBOL(__find_vma);
 
 /*
  * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
-- 
2.37.2.789.g6183377224-goog

