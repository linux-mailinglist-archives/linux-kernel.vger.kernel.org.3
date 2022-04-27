Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC095121A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiD0SxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiD0SwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:52:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D392DD3731;
        Wed, 27 Apr 2022 11:38:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so5096844ejj.10;
        Wed, 27 Apr 2022 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3A9Xsphph+SQIianXjBh4+4o7zyb9BLunLh+E/0CQio=;
        b=UnfU+HKtW2D06NU0bNOq17sb224h2OOputwJe94u41Qt8hwta0lHaQFIp972VNxMxw
         NidlrzU1EDNDzfMvPXwIjMrmvr1NjR37cOhY1nYV+roOMxaNJKralBkSBGKZ/BN5Th8s
         N9lRPYTPjGbr0cSTjbxEspuArLVLDdoBPgK6+upGAizAiELcdp5a9hMp/Xoahvusgq57
         Th2ISXRFFfvep7ONNLZ0oteYokL2E120n27AHTizXeVhQ6Z8Bx7kArRZNl0nJnyk3Zz+
         9wm2qfNSgd9FOpItl1vN8l1QYWQbKpnNcH79auchDN29l0o91cDPqLo/49TJ8Kt/t9PO
         5Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3A9Xsphph+SQIianXjBh4+4o7zyb9BLunLh+E/0CQio=;
        b=vdh5uG0cCkMHAU/TaFvgEZOTPuQtb/u1By18gXovY/oQYHoN/IZweRiMbQ7xB5XNWL
         jxvW1nIit6SRlUsY4uITjp1pus3z9lirClGUZIgvkaItYQLNMr5fpzRyobrig2dZhNrj
         GXxoIEcAbUiNemxDF0ibRMZsXtHs7YarBytjmFe7SYaEH4mziBXOQOIrULORlH2nM2fi
         TtcrVwP7mlT9jwS5TKqLipYvoeo8E3bZqqNtbkCfo2doxGDNKh3AT8bvQ83Bfup/uzLj
         Uaej56kkE5UyFEBsQ1K4fczf0KowK44eJ/BM2u9S/8N+z7aCYjS7gmSXWZTmhiTqx6np
         329g==
X-Gm-Message-State: AOAM5327NR0Q6Iwf/2IDNOnHVcGR7IQIBJ/BrbgdQ90Q9SErMmFQP5lM
        iM1bDzqCrAfhqcCOy1hyZfo=
X-Google-Smtp-Source: ABdhPJwbRHA28mPeqny4TiNCbUmpYR75vpZN6jbYw41zpIX7FDWDTPi4S99nZfjEdPb0JJjaOjNyZw==
X-Received: by 2002:a17:907:da0:b0:6df:d4a4:9d0f with SMTP id go32-20020a1709070da000b006dfd4a49d0fmr29043562ejc.407.1651084708394;
        Wed, 27 Apr 2022 11:38:28 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b006f38f2e9ebesm4691667ejc.64.2022.04.27.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:38:27 -0700 (PDT)
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
Subject: [PATCH v3 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Wed, 27 Apr 2022 20:38:18 +0200
Message-Id: <20220427183821.1979-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220427183821.1979-1-fmdefrancesco@gmail.com>
References: <20220427183821.1979-1-fmdefrancesco@gmail.com>
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
already in highmem-internal.h, (3) using correct parameter names, (4)
adding description of return value of alloc_zeroed_user_highpage_movable(),
(5) correcting some technical inaccuracies in comments, and (5) adding a
deprecation notice in kunmap_atomic() for consistency with kmap_atomic().

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem-internal.h | 15 ++++++++++++---
 include/linux/highmem.h          | 20 ++++++--------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a77be5630209..9968a1282317 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -236,9 +236,18 @@ static inline unsigned long totalhigh_pages(void) { return 0UL; }
 
 #endif /* CONFIG_HIGHMEM */
 
-/*
- * Prevent people trying to call kunmap_atomic() as if it were kunmap()
- * kunmap_atomic() should get the return value of kmap_atomic, not the page.
+/**
+ * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic() - deprecated!
+ * @__addr:       Virtual address to be unmapped
+ *
+ * Unmaps an address previously mapped by kmap_atomic() and re-enables
+ * pagefaults, migration, preemption (the latter was disabled only for
+ * !PREEMP_RT configurations). Mappings should be unmapped in the reverse
+ * order that they were mapped. See kmap_local_page() for details.
+ * @__addr can be any address within the mapped page, so there is no need
+ * to subtract any offset that has been added. In contrast to kunmap(),
+ * this function takes the address returned from kmap_atomic(), not the
+ * page passed to it. The compiler will warn you if you pass the page.
  */
 #define kunmap_atomic(__addr)					\
 do {								\
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 39bb9b47fa9c..3623319a659d 100644
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
@@ -138,24 +138,14 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  *
  * Returns: The virtual address of the mapping
  *
- * Effectively a wrapper around kmap_local_page() which disables pagefaults
- * and preemption.
+ * In fact a wrapper around kmap_local_page() which disables pagefaults,
+ * migration, preemption (the latter disabled only for !PREEMP_RT
+ * configurations).
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
@@ -191,6 +181,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
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

