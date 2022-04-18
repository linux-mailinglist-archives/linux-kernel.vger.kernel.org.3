Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76CD504D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiDRHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiDRHzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:55:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9182DC9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 00:53:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so16629572edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3nZpZoTm/4GzQl9vlLPVEuRqbmxcJd/wkxQHsqfN9A=;
        b=VbaTu+nLoCyCEqc5gpJL1pubsBRB3q2MCQfmRvnBUZo1DP+9EcjETfF5BrLqKxwOQo
         aXN6XzmK+DeBGA2i1JL4RdbT6nCvUrWvgLy7pr4vSjTp3pigSTNuo58UCljjejQ5fW+f
         eNPpj495FnkekAfXet0DzJEogD16CjfdAQUVKskEdWSVl++eDyFZCnCLnPQp08v7A9QF
         ws7Stx7TwosxNL1CsF/KT+9TzHN9lyANULBae7R1IkaczFxfBZ+163un8cU4CfCfoWnt
         Mf0FEyGmWi7V6swvDta4oOkt3qMj/13fCYEemjjwB3/WT0xcao5raWnIRmpbDeuF3RoW
         +wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3nZpZoTm/4GzQl9vlLPVEuRqbmxcJd/wkxQHsqfN9A=;
        b=JckF1xsuJc/w9leLc0HmIFe/jseN7VhXsdGKkW9PokHlF/5O2/NiGKUdM786A/19fD
         wnhKbY5DYpeT1PqXkbqPmqRpzLZEqPGHwGc7CY0YnEiM7Cq38/D9+d3TvwI28Wfwlohl
         YDGdYj/fToA6HTCBIb4Y53WteurB6GgzeInFcsIxRd7MySS2YT9jPDBR2oIHQHCWq6ND
         9r8LYGVZ1YcbMyG0QqmIpEF1zFAZ2JdAfAyckpZmdL05XH83BQjqxDvHU3H4BbKRJf4V
         Xgo1z2KWB6FwkX5QZ50q0O3oiEyFUTRxrrJkdli1i2WUE3EyYVVqIrXW8EuC8/qi9Md4
         VgcQ==
X-Gm-Message-State: AOAM533rWNmCqrh2KQpWOO+kVJHX5qd9EECtMvnSFyvBpe+MZz/4zsFV
        MWH/hRLCoHiphPRX7SrJwcQ=
X-Google-Smtp-Source: ABdhPJwrBbSYw5Sen0RcqaytjovQapyz1OJ0kWnbr6Nw1R5G0LDiWLDvT5g6vUQ4u8CZpiE2m/qHSQ==
X-Received: by 2002:a05:6402:2554:b0:423:f3e3:81da with SMTP id l20-20020a056402255400b00423f3e381damr529850edb.87.1650268390524;
        Mon, 18 Apr 2022 00:53:10 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm4339932ejm.103.2022.04.18.00.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 00:53:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Mon, 18 Apr 2022 09:53:04 +0200
Message-Id: <20220418075304.20259-1-fmdefrancesco@gmail.com>
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
actually defined), merge it with the comment which already was in
highmem-internal.h, and (3) replace "@addr" with "@__addr".

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
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

