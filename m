Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C84447C21D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhLUPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhLUPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:01:48 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B667AC061747
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:47 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 69so265169qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/Bz+RH2sd3d5dh0W3emMfNr+x1w1TZodqurj+f1M1QQ=;
        b=KidDaTtrQ8tAIOl8DDgN3FOj8v1GQoe8AsMNbfRPu+zCoyTqxLCHTwzt9TbJbGovo0
         6Q9nLCCLveS3W+IiLFrcheP6UIKLC/0UIEGvzCdIJEB3tS03dwPcqR5y4Gx65v2xT1pJ
         9DSwSVolFxtdTKHj0Ik+YdvPhw6379bJal5U2mQLhnKWK+y+akA/COr5nZyW37G/V5Pt
         LnhAmG0s96vB1BlwKg3qDz836SVwtKNrueM8zE6fy78U14axejFvjq5Gfq1OVGF5Z/7C
         Wk9q1LEkgVQYUNYNyzxS2vRVpOaUifCNJ5eGJPO6psx4JzNMhN5x+6NRyXbvV/t0qYjL
         UO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Bz+RH2sd3d5dh0W3emMfNr+x1w1TZodqurj+f1M1QQ=;
        b=TugVr/aQs5XJNCfx3akmZjTAqb/d/q/ahxDQsmt6ELDXl0DL9d0hoyyX5Qlui6IYAk
         7ZIMeEq+M7HAc8BR8D0fxfikC5DqoJnJyQLfbj1TSXmC3xuhS9Daj2/ZXuhCXgnD0/6r
         q78vPMP7skapIydEH+RpfUeW68TGO+z5y8n2JCwX/59LqV1IAA7Z+dPxoDodzRpXD7oq
         5Euz0AHIou7BlL4/WLK7eV+WU6UPU+IHPn1cWV6L1L5mizKHM/jVtkG0xw6pRzxs4c4l
         BSxp7XyDenXDN/GVBodQrYPAP1ko7uW5AKTjEdKhwc34v2ojuTCW0Rf4ceTgeV/X3hRW
         Krcw==
X-Gm-Message-State: AOAM531zGGE32vg9ab3T5Ph239hph3JzHppA3D+pQQLVp7S0+oN+L9WU
        HJ+l9CRJovtXm1vukJx8mc6ggg==
X-Google-Smtp-Source: ABdhPJwWtWwvP9UVXTIMJbtTvAxC6RyjKtLEk/a3kJ8GOYA632y7N+nkICuXAEpwnyyJVHEAouzJYA==
X-Received: by 2002:a37:60a:: with SMTP id 10mr1540467qkg.19.1640098906882;
        Tue, 21 Dec 2021 07:01:46 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d4sm1991371qkn.79.2021.12.21.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:01:46 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: [PATCH v2 3/9] mm: remove set_page_count() from page_frag_alloc_align
Date:   Tue, 21 Dec 2021 15:01:34 +0000
Message-Id: <20211221150140.988298-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211221150140.988298-1-pasha.tatashin@soleen.com>
References: <20211221150140.988298-1-pasha.tatashin@soleen.com>
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
index edfd6c81af82..b5554767b9de 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5523,6 +5523,7 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 	unsigned int size = PAGE_SIZE;
 	struct page *page;
 	int offset;
+	int refcnt;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -5561,8 +5562,9 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
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
2.34.1.307.g9b7440fafd-goog

