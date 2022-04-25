Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301B850E59B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiDYQ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbiDYQ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E211F95E;
        Mon, 25 Apr 2022 09:24:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g23so12065308edy.13;
        Mon, 25 Apr 2022 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uCI5XJJQhEl0Rvu0MUBKvOSHqWoc72nC9Ng5croQe20=;
        b=GWM426VVKttgpvPwF1MZmSeP7wVjoc6F9U6TxK5zuzh3hInFVLrofTmC7gs/A7wkDz
         akCLKZ9mSDwVs/qqYEpiliNdmn5eLZ24eIB+ePTBkhb/b4t+eqt//hHwAM3WHbJTKS9G
         QLrx2eqH/x9j3iK4IqURkQcuDYamABjO78otOx6tH45RFL55Q1WSHNdDMviZxxXfTDC4
         5haJedFtVLO9df98juFNJ3wkeNw6QjLBevlU4Y9OiyjMs/8xCuVJCC9banu7y21ZKaFx
         TBCC7MTlEAN3EMTsnHKcH9DUin/wRfYJsZNagW3S1E7bW78/z8R1bOYHRr9xxuNMsH1c
         L07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCI5XJJQhEl0Rvu0MUBKvOSHqWoc72nC9Ng5croQe20=;
        b=m00EWAoJjvtxQsjMqRImKRjMvOHhARI2f03W33j6MVnnfpAm4CU2wA7DatmJA9u8U7
         tNb0cJWlMF9vLesEoMAlMU4KWa2sqtjodzFHbWKD7tHdDavCdssJpU3P/Nnc4yFH8+K0
         msOI+XCQDZ3ogTcm25U7GyiysHEO3vOL4qp1wHFHtUFfKhRUgLPU41SLYNb8lLg9nId9
         OZpG5keOLvx/CGOnYmxOFqZKrqeClRxWNbn3+DlPi2yVGPFF4sLSRX/sPNLiYaeJRooD
         EVZajOvZOM6SV1I9v8ZpNOBa5CIYTokRPbWZPliI9UmxpWyT4yDpI5Mlv95CTeFXClkd
         OqoQ==
X-Gm-Message-State: AOAM532EQ6ltscF84g5vc8240+02iVLWi16DDkGnxgtfaVnSxazJM8TS
        egERtj4f1JPgsltMETFKpao=
X-Google-Smtp-Source: ABdhPJwQbgy60NHrcrLBuAejcY/4n0Ir6e8Pjhj1ueo4kxtfr5zsTKcRDPd8DUgRRQwPwMqZpgP9oQ==
X-Received: by 2002:aa7:d5c5:0:b0:425:b144:ab84 with SMTP id d5-20020aa7d5c5000000b00425b144ab84mr19906210eds.200.1650903847284;
        Mon, 25 Apr 2022 09:24:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709062ecc00b006e8558c9a5csm3784122eji.94.2022.04.25.09.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:24:05 -0700 (PDT)
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
        "Acked-by : Mike Rapoport" <rppt@linux.ibm.com>
Subject: [PATCH v2 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Mon, 25 Apr 2022 18:23:57 +0200
Message-Id: <20220425162400.11334-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220425162400.11334-1-fmdefrancesco@gmail.com>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
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

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem-internal.h | 14 +++++++++++---
 include/linux/highmem.h          | 15 +++------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a77be5630209..aa22daeed617 100644
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
+ * Unmaps an address previously mapped by kmap_atomic() and re-enables
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
index 39bb9b47fa9c..3456dc1d38db 100644
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

