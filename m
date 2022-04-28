Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E677D513D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352280AbiD1V2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346246AbiD1V2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:28:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E649A2AC74;
        Thu, 28 Apr 2022 14:25:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z99so6947636ede.5;
        Thu, 28 Apr 2022 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppYYO/QcHXh+XwuTgyF/cB3OHqHt+JEBwYTQgvTmB4w=;
        b=S4w2DpJOy6Gm9MbpSPAWiXEqsxK7mI0aoRqoY49TL8lej2yqCvi+JHWEWhsLBQVeTY
         PEXwPd9KoiX+O+BmnuFKE1PZF7QCLsz/z3spRiPZwd2LPrHit7DeiAFsYuxDnHDWMlW3
         pHjUmIA1X9hfIac19ag8aUyveCRuAs8b/6a0NmIrH+qiYCa8FMkc5kG2Rsm2cn8yi9R4
         jciWKjCdlLLG0W/mI5ZkXL5YQQLjQ8JpIhT/bG5WHED4kzEBPn0zBBLIDMYkqRlt3jXj
         JXRyz4QMD0q8CTf2g1fvNq6O+/uHmPmOW8EDXEUMzy8UIlhLLW4YMr346zQhjvtS7qOX
         J2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppYYO/QcHXh+XwuTgyF/cB3OHqHt+JEBwYTQgvTmB4w=;
        b=GgRXhVkZti/CNfUc9cIrLHvq3kBQ5iReQ5m3d+7bTL5nzpFXQUqajw252139vCGIZA
         FDOWeDl00URIIZUoxliEuS74nxnMLO9JjToFo+VgEHv0Lo2A5xlaLQUwnPpL/u4D/mg7
         tNI9X/qmwOMg2bDIjQCXTM/OPgJHOjbDjXRue+T0q0qHXR85NZ0+HxV5TXvWmkfWYUIs
         WyMRgUaTq3YD/yLBSBs33fn58bUOlmWcOy4zmSuwyIKF9DeIYeemdZF/9wD2Wdwh9DMZ
         lzqvIIK37DyqfKidqmucGZL9SlybrQLn52kCwr7vqPUtkrczsfenHmWs9/BXO3YdlIgZ
         IZHg==
X-Gm-Message-State: AOAM531cKg8rp/SsNKsLgj8iSH05mfleb8dTX6XnmkFHE7NkE6bR9udH
        gPhOsYb86Fu3GBNDQJK5z7pwPlvoNJ0=
X-Google-Smtp-Source: ABdhPJyCn1ofuojZO83kgw/52oDRKyEiV+0sOg0pthepaEqDl1+xumjDuiKzE4rqgXz2Feo4PrwZjQ==
X-Received: by 2002:a05:6402:2753:b0:423:3895:7031 with SMTP id z19-20020a056402275300b0042338957031mr38053336edd.170.1651181102319;
        Thu, 28 Apr 2022 14:25:02 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ze12-20020a170906ef8c00b006f3ef214e68sm37147ejb.206.2022.04.28.14.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:25:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Thu, 28 Apr 2022 23:24:52 +0200
Message-Id: <20220428212455.892-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220428212455.892-1-fmdefrancesco@gmail.com>
References: <20220428212455.892-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`scripts/kernel-doc -v -none include/linux/highmem*` reports the following
warnings:

include/linux/highmem.h:160: warning: expecting prototype for kunmap_atomic(). Prototype was for nr_free_highpages() instead
include/linux/highmem.h:204: warning: No description found for return value of 'alloc_zeroed_user_highpage_movable'
include/linux/highmem-internal.h:256: warning: Function parameter or member '__addr' not described in 'kunmap_atomic'
include/linux/highmem-internal.h:256: warning: Excess function parameter 'addr' description in 'kunmap_atomic'

Fix these warnings by (1) moving the kernel-doc comments from highmem.h to
highmem-internal.h (which is the file were the kunmap_atomic() macro is
actually defined), (2) extending and merging it with the comment which was
already in highmem-internal.h, and (3) using correct parameter names (4)
correcting a few technical inaccuracies in comments, and (5) adding a
deprecation notice in kunmap_atomic() for consistency with kmap_atomic().

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem-internal.h | 18 +++++++++++++++---
 include/linux/highmem.h          | 22 ++++++++--------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a77be5630209..a694ca95c4ed 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -236,9 +236,21 @@ static inline unsigned long totalhigh_pages(void) { return 0UL; }
 
 #endif /* CONFIG_HIGHMEM */
 
-/*
- * Prevent people trying to call kunmap_atomic() as if it were kunmap()
- * kunmap_atomic() should get the return value of kmap_atomic, not the page.
+/**
+ * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic() - deprecated!
+ * @__addr:       Virtual address to be unmapped
+ *
+ * Unmaps an address previously mapped by kmap_atomic() and re-enables
+ * pagefaults. Depending on PREEMP_RT configuration, re-enables also
+ * migration and preemption. Users should not count on these side effects.
+ *
+ * Mappings should be unmapped in the reverse order that they were mapped.
+ * See kmap_local_page() for details on nesting.
+ *
+ * @__addr can be any address within the mapped page, so there is no need
+ * to subtract any offset that has been added. In contrast to kunmap(),
+ * this function takes the address returned from kmap_atomic(), not the
+ * page passed to it. The compiler will warn you if you pass the page.
  */
 #define kunmap_atomic(__addr)					\
 do {								\
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 39bb9b47fa9c..f6c2d9beff2c 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -37,7 +37,7 @@ static inline void *kmap(struct page *page);
 
 /**
  * kunmap - Unmap the virtual address mapped by kmap()
- * @addr:	Virtual address to be unmapped
+ * @page:	Pointer to the page which was mapped by kmap()
  *
  * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
  * pages in the low memory area.
@@ -138,24 +138,16 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  *
  * Returns: The virtual address of the mapping
  *
- * Effectively a wrapper around kmap_local_page() which disables pagefaults
- * and preemption.
+ * In fact a wrapper around kmap_local_page() which also disables pagefaults
+ * and, depending on PREEMPT_RT configuration, also CPU migration and
+ * preemption. Therefore users should not count on the latter two side effects.
+ *
+ * Mappings should always be released by kunmap_atomic().
  *
  * Do not use in new code. Use kmap_local_page() instead.
  */
 static inline void *kmap_atomic(struct page *page);
 
-/**
- * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
- * @addr:	Virtual address to be unmapped
- *
- * Counterpart to kmap_atomic().
- *
- * Effectively a wrapper around kunmap_local() which additionally undoes
- * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
- * preemption.
- */
-
 /* Highmem related interfaces for management code */
 static inline unsigned int nr_free_highpages(void);
 static inline unsigned long totalhigh_pages(void);
@@ -191,6 +183,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
  * @vma: The VMA the page is to be allocated for
  * @vaddr: The virtual address the page will be inserted into
  *
+ * Returns: The allocated and zeroed HIGHMEM page
+ *
  * This function will allocate a page for a VMA that the caller knows will
  * be able to migrate in the future using move_pages() or reclaimed
  *
-- 
2.34.1

