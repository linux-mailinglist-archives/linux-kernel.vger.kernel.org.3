Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6549D1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiAZSet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiAZSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:34:38 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE38C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:35 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id q5so413082qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6rktNgcbrbK1gQESupfA4dHtrh4dYlEFYGvtlevr0bg=;
        b=ZOPvyP2LJa1z3UAKsmFkGIvb9SGcukKRw1eJDnZ03Qy7wZ4AeqMOKXH3MMBQGrbIrD
         /K1gtEKq72kR4D2ZLluXJ7N65IkST6vYrjwupXq4pYplOy24Hwrbt019FVcqjyTfs4uM
         lsxV8J1HoLT678mTxAyiXcz4eRp1gSd1iPLhXoXTOfQioYdf5YHp5LPIvXTIzhL/PYZg
         tFa4DDUfUv2/nhf4ixyqPQOrpe0bQFsJHGraZDElfYhxqzwN7HggCEhbvvXk+a5O2CJ8
         zuTcV5TSk5C5M3X8ND+XcwEmPXrCXMwHne1ra/PCaFUMgtU1czwB78aFNGC/vAvu+kVG
         NUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rktNgcbrbK1gQESupfA4dHtrh4dYlEFYGvtlevr0bg=;
        b=qcgpYmyS2N4AnmEcO1pat3E+5k037wD/XaswA9LDJ5l+WQi11CJwSOoJAcevhzEVNN
         f7Sf8gxN0OT7FfgCKsyaWG98OHWNri8ypCmLPRPFZqLJX2o6FdFjmOvmlkjmKklVBDfC
         v3HLYckTOtnDGuNDmVe9fPi3iYliWdUM9uyYG4RX4/7JXST+gPUDDHYmnjO/xnh449Ge
         CYPuEMZfIjql7T1NBaVNRjxeXm2WEo7Rv7OZbduTgm4xSdxV91TgnDmBbMVnwutRrFWM
         U4OxazgUboZ0nbYYAbD87Slu9BixKkEq5r+ty+jaozbrHulNMFmVzYRDEcdwgUS/Jccf
         y/Cw==
X-Gm-Message-State: AOAM530HR6vnsAFG/K9c+eedXVR0ugOgAqDkOOSb8qysemJBzMTXNnD9
        wx6aWgJAfUn96sDG8FXjBj4xBA==
X-Google-Smtp-Source: ABdhPJyOZcmiDwXUXWvvn+PHKnj59WKkQW/1KnbYA3kyw9zl35YOaxOviGVfeae+pb/kVHJjKl9WDQ==
X-Received: by 2002:a05:620a:25ca:: with SMTP id y10mr59059qko.546.1643222074652;
        Wed, 26 Jan 2022 10:34:34 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id u17sm35886qki.12.2022.01.26.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:34:34 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com, hughd@google.com
Subject: [PATCH v3 3/9] mm: remove set_page_count() from page_frag_alloc_align
Date:   Wed, 26 Jan 2022 18:34:23 +0000
Message-Id: <20220126183429.1840447-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_count() unconditionally resets the value of _ref_count and that
is dangerous, as it is not programmatically verified. Instead we rely on
comments like: "OK, page count is 0, we can safely set it".

Add a new refcount function: page_ref_add_return() to return the new
refcount value after adding to it. Use the return value to verify that
the _ref_count was indeed the expected one.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h | 11 +++++++++++
 mm/page_alloc.c          |  6 ++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index fe4864f7f69c..03e21ce2f1bd 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -115,6 +115,17 @@ static inline void init_page_count(struct page *page)
 	set_page_count(page, 1);
 }
 
+static inline int page_ref_add_return(struct page *page, int nr)
+{
+	int old_val = atomic_fetch_add(nr, &page->_refcount);
+	int new_val = old_val + nr;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, nr, new_val);
+	return new_val;
+}
+
 static inline void page_ref_add(struct page *page, int nr)
 {
 	int old_val = atomic_fetch_add(nr, &page->_refcount);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8dd6399bafb5..5a9167bda279 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5528,6 +5528,7 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 	unsigned int size = PAGE_SIZE;
 	struct page *page;
 	int offset;
+	int refcnt;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -5566,8 +5567,9 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 		/* if size can vary use size else just use PAGE_SIZE */
 		size = nc->size;
 #endif
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		/* page count is 0, set it to PAGE_FRAG_CACHE_MAX_SIZE + 1 */
+		refcnt = page_ref_add_return(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		VM_BUG_ON_PAGE(refcnt != PAGE_FRAG_CACHE_MAX_SIZE + 1, page);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-- 
2.35.0.rc0.227.g00780c9af4-goog

