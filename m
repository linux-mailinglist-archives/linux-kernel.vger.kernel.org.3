Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F7350A7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391110AbiDUSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390799AbiDUSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:05:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457E44A914;
        Thu, 21 Apr 2022 11:02:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s18so11717272ejr.0;
        Thu, 21 Apr 2022 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JB/7ga9Q6TH0mrE4s60UvEIeZRakvM8pM/E/1QVCfnw=;
        b=OzI8w7XL/hOdeRu/BlIhPUUAkcjzlS4wHs4wFwrOUS1RkilWZndk9ka2kVIw4YaOS+
         HdXsxCnlzpLybt4R4TA1EG5IKNVBQbigStdX7Mom+ToR2DM/4Rk4wd62obNEeJiQascV
         te4yRPPDm0/rHZLY0P6iMpIMoKPfoccKE1xv89yGGGsqWRE5bOBf329gYjMvAXUIklqv
         76CHoFC2oKYxg91WG6IieGVMbXKweCSH8vcfq7ca8Irse45E5lwsn7pZN0RsMf+7XpRa
         EPPsbpHyaZzHzcnSIZ4WyKahOV6zzp/h3g2PMJC6MO9AByPDs1OU/Slc4TeZWLJE/C2/
         XCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JB/7ga9Q6TH0mrE4s60UvEIeZRakvM8pM/E/1QVCfnw=;
        b=a5BPwBl8uxrmGQQ6SO26f1XwQC56mHqa7OecNFQ/hSI2wqF/iVLMlwsMUGsm2fW10f
         Qdp/YP860EWqKGd+JdBq31BvR4lRAWVy3er3iBlTEwxbrAPO/0S6ZqXLGYfaFZqU8QOT
         yDImGYU/PeQC0a2TfPX9Gp0te6VV5sxeQkv48Rn/2Yw+9wKg9KdkKlJXxVgSrs/eQp3I
         l7g34HEs5CH28nB14HPnFxhjksoA9LfQlQGYs9wIy5Pf65KaWO7F481u5R6o6KOXQSBS
         fNufhWspCakV6hWQYfys5F12/RHWfLbXQyDu3UFua80VQZ/P+7gfXGBZvIot58FVIdAe
         EZIg==
X-Gm-Message-State: AOAM531XDY23jo4uchNxzepV9Rqv+R4nXVZBKSan/JPkoQ3I7qTEucDX
        3IyXTPgzHF1Lvgx6jGSNAXnPWfHp2ac=
X-Google-Smtp-Source: ABdhPJxN2/2vvOT4+KlkpAaB+H1hSeJuQm6eo4Gp0L7Oqc4BrVd5Vp3oARm66MGJK5pEGRA8rgMAFQ==
X-Received: by 2002:a17:907:97d3:b0:6ef:f445:dd96 with SMTP id js19-20020a17090797d300b006eff445dd96mr664318ejc.416.1650564130686;
        Thu, 21 Apr 2022 11:02:10 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402231100b0041d98ed7ad8sm11836204eda.46.2022.04.21.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:02:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Thu, 21 Apr 2022 20:01:57 +0200
Message-Id: <20220421180200.16901-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220421180200.16901-1-fmdefrancesco@gmail.com>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
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
already in highmem-internal.h, and (3) using correct parameter names.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem-internal.h | 14 +++++++++++---
 include/linux/highmem.h          | 15 +++------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a77be5630209..b099a08e29d3 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -236,9 +236,17 @@ static inline unsigned long totalhigh_pages(void) { return 0UL; }
 
 #endif /* CONFIG_HIGHMEM */
 
-/*
- * Prevent people trying to call kunmap_atomic() as if it were kunmap()
- * kunmap_atomic() should get the return value of kmap_atomic, not the page.
+/**
+ * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
+ * @__addr:       Virtual address to be unmapped
+ *
+ * Unmap an address previously mapped by kmap_atomic() and re-enables
+ * pagefaults and preemption. Mappings should be unmapped in the reverse
+ * order that they were mapped. See kmap_local_page() for details.
+ * @__addr can be any address within the mapped page, so there is no need
+ * to subtract any offset that has been added. In contrast to kunmap(),
+ * this function takes the address returned from kmap_atomic(), not the
+ * page passed to it. The compiler will warn you if you pass the page.
  */
 #define kunmap_atomic(__addr)					\
 do {								\
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 39bb9b47fa9c..c3d562b5f0c1 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -37,7 +37,7 @@ static inline void *kmap(struct page *page);
 
 /**
  * kunmap - Unmap the virtual address mapped by kmap()
- * @addr:	Virtual address to be unmapped
+ * @page:	Virtual address to be unmapped
  *
  * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
  * pages in the low memory area.
@@ -145,17 +145,6 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
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
@@ -191,6 +180,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
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

