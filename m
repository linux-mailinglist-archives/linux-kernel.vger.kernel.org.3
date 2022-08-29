Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F25A5615
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiH2VZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiH2VZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:25:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2778F57200
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33daeaa6b8eso146119777b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=r66X5QU6Hd1zKKrQM4VdH4G/hUbDUrS2PjBFocCJ7kE=;
        b=f0ZITQpEExaLaSKDQb+h3/jYVFf5BjWfu0A0p9NMJ80xDBwkhscojqDzgDQ6W2gLIU
         JqyvlNc6N0TYQxhXpPiBzGuyzj1xr5cqDIbNzDR0v00qVutFwkDUQtyKnSj2Dn+NYRmF
         XbYPUhr7ZlEh9zlxoVr+7UyC5/R2ipvFX7ptRmhGZgjobP0J3ITaBrEOKND2CAY9iU2J
         fnwalrszPulqwRWfSp/VwWSeSLynEBR581yqV4QALN8e0aPzId5HIRtAjN2fmV4usJpw
         ghPowcSLA4CLZg9Bm0wFQDYbe3eb9NsWWsLPsurv1jkHcSRK8KYhRIFhxtRmb7OcOQkd
         NeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=r66X5QU6Hd1zKKrQM4VdH4G/hUbDUrS2PjBFocCJ7kE=;
        b=UiwEdxtkM35KNZtuQzLnuh0nrNVjlMUE52Z9AXby6hwIZJDjDYJnjADX7d0nZ8ZEyM
         Rd1f1OCrDEhVig6XlcOMbVai6ZaW/ce8wWZuYM0u80H+tsKsXeW155ghhzG9LFtj9+t+
         ZmVudga/Yf492Am9bsll8uWNtdpl6PDoA6jDYohQ/cmrIrvWvrxPUePRRM4rD6294CZM
         JuwSkR12Cb744EttyQc9zPGrjDPzJNGy0P+cswJQuXVytovXzo2+y1y4zFkzy/XsL56S
         pHdtNOwsrG0vjzZWLGumnx9eTuv/a4e4txP36rFLkpMN819tzOUPK6vESFTdtk9MvUH5
         eYFQ==
X-Gm-Message-State: ACgBeo0dcufAtSkoipyKWMKr11nSprS7MiM8ARNRoedFSGwxe8Rz3xlW
        5juPM5PxuUZPeHZ37xuruGVBWD2k3Y0=
X-Google-Smtp-Source: AA6agR7RORyYEvgHp7XQu1QQYhj/biZijMsx0xRWZsAvcqgghjoomkWy7B4TiExDCzWJq5q+aaEXQCYL4WE=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a25:254f:0:b0:695:7c37:9202 with SMTP id
 l76-20020a25254f000000b006957c379202mr10232936ybl.79.1661808341087; Mon, 29
 Aug 2022 14:25:41 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:06 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-4-surenb@google.com>
Subject: [RFC PATCH 03/28] mm: introduce __find_vma to be used without
 mmap_lock protection
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
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
2.37.2.672.g94769d06f0-goog

