Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465B8505DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347162AbiDRR73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241697AbiDRR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:59:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5918D3466D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:56:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c64so18257812edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1E7Ts386sKVAH7+jIanD8UQPmSLGesSvaWCqD54Wgw=;
        b=WwbM0f8zF5Y8W0wt7jEc0r3fvsBMhaGs1CVLq/a/i+HPsEJMaB/La8Yh4AARtI7qpL
         XOuUOpP+qZPTsZr9kRRcIUVbm/VgIg/VCNQPhu0bNbDh66o88434UHiXflLE3k16vNfi
         +QVCa/0K2JXyqb/65Ol6vJ66T4YhFJpOfMijv48PEk1i3TQjJXafB1yoY+bTVxQ8SRej
         1W/DPsrA3pHUK3SKhPHyTGekrIk6/k7GFn1NHcTBhdemplWpw1lLC+ExXlwsc4NxyyH/
         GA/2Iahx5BqDNnV6iBWkgN9JcBQ4NT10jfscB6dj66Q8/mpVAFPyyzicylWrVKdLohjQ
         IItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1E7Ts386sKVAH7+jIanD8UQPmSLGesSvaWCqD54Wgw=;
        b=TBLwvDOj+wCZ2dYcIvFuBjYDg8WHcSf7HGi5QF+ss3JPzYVygMmYON95xsESnb0hWU
         KTd+L4viz4MNCc1UB0WtZ2dAu57age8rnJjp2Z8176wTyxeGmjwF+rxnpswpz/7P9y7H
         1o28tmaxaAY2GxAU/3HWKm0ISsZ31kZcSyI8lHc47KiEHX+P3l30Q9HghK/pDVgRcxhg
         rOAMX39+AhEl50tmUOxnPulzubEGRPrSBr/eAgPamDM8pRrZTm4BQt1Bril2vMSyChH5
         U6hySyhT0ePtj2LKQe0+kmVXrui2nUceOSYXKhbixKJF8wTV1Q2rwwJbhkZzFEZzhd/E
         U8xQ==
X-Gm-Message-State: AOAM5315qpujnQaOpk8DAnaMVfwlDSzkRuX1O1Eh9Bnn24zSfoA3dFsZ
        g+TuGppm5BSg9HZX/69ggU8=
X-Google-Smtp-Source: ABdhPJwy5yL7UaRad6BVYWw8wXFOviOlGpuvjAgU1trs9KwsdyqlpDrmgRppquaqLOHq0ZNdLa5gSw==
X-Received: by 2002:a05:6402:1b07:b0:41d:7abf:8337 with SMTP id by7-20020a0564021b0700b0041d7abf8337mr13170834edb.185.1650304605813;
        Mon, 18 Apr 2022 10:56:45 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090622ce00b006e898c912e5sm4776154eja.217.2022.04.18.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:56:44 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Mon, 18 Apr 2022 19:56:38 +0200
Message-Id: <20220418175638.30018-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`scripts/kernel-doc -none include/linux/highmem*` reports the following
warnings:

include/linux/highmem.h:160: warning: expecting prototype for kunmap_atomic(). Prototype was for nr_free_highpages() instead
include/linux/highmem-internal.h:256: warning: Function parameter or member '__addr' not described in 'kunmap_atomic'
include/linux/highmem-internal.h:256: warning: Excess function parameter 'addr' description in 'kunmap_atomic'

Fix these warnings by (1) move the kernel-doc comments from highmem.h to
highmem-internal.h (which is the file were the kunmap_atomic() macro is
actually defined), (2) merge it with the comment which already was in
highmem-internal.h, and (3) use correct parameter names.

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Re-word the last sentence of the commit message and add a missing
	number to the second entry in the fixes list. Add Mike Rapoport's
	"Acked-by:" tag (thanks!).

 include/linux/highmem-internal.h | 14 +++++++++++---
 include/linux/highmem.h          | 13 +------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a77be5630209..7307de391288 100644
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
+ * Counterpart to kmap_atomic().
+ *
+ * Effectively a wrapper around kunmap_local() which additionally undoes
+ * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
+ * preemption. Prevent people trying to call kunmap_atomic() as if it
+ * were kunmap() because kunmap_atomic() should get the return value of
+ * kmap_atomic(), not its argument which is a pointer to struct page.
  */
 #define kunmap_atomic(__addr)					\
 do {								\
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 39bb9b47fa9c..0a7a89721e5d 100644
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
-- 
2.34.1

