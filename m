Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1346513D88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352302AbiD1V2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346246AbiD1V2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:28:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D679328E02;
        Thu, 28 Apr 2022 14:25:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh6so12089933ejb.0;
        Thu, 28 Apr 2022 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1x1kv/2gsKv5kOdZxXlxwoC/jLBT43h35UaSYyMNEo0=;
        b=hP7IaUTq3VQr6MTRLm48mtplWcj1hE4aDP0etWxNI5zXEF1mHnWwHHeBDrosiX9+gA
         v1lqA1UQd1Rc8zGMnLg3pjc6M1FdDJChmhkTOSv/CcPzvyyubWCSFbrUYfodz/mNnhWz
         L3yIX8iWmKb+qLTBD1SDviq1BQY2oaa1ZeuRA51ghUxrEFrOPS/r0Gus+pl9rVQ/miVz
         MujJAMMywglFlLvzcmpAZRzkKGB3Cl5TWE9bk3TqNa+REUJ3v808W3XN9URO3VFvCCrD
         kPfMzT9iujmq2ulb2mOT99RcI2ZQqCnY0LRifR6MCAsM2Vw10/3z1EOjIG1/6NVrwDCp
         vMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1x1kv/2gsKv5kOdZxXlxwoC/jLBT43h35UaSYyMNEo0=;
        b=myEttL6Jx3qs/qMjCL4RXE1hCIitoDZ45H0Wno0xB6EAEnURqOYIXoVVzcbDmXNwnX
         YfCP96CG+YkOjb5lx20FgkVbti81uFeGHtR4X/fpuweYSI+lF/yr0tjySiHyp7n6dSly
         XGtWFYK03MGQTTTPDRxAumyycc3oWQQidmTYDUWduBRK7R+w13S6Bto29GekHuRu3vHA
         lpSD1gY1qbXJ03q3UuOcUzYo1VFlXAet3VQNeKxEWHIz+fI+O10ZigInW5gpRtyX/qPg
         rxa62qtz1rEkfQJU3VW5EnZyZZ26YNNzBOEw1fdlnbK1RFKXJevw7JvtGLTssqw+8eEj
         b0og==
X-Gm-Message-State: AOAM533CRuqNe/t/17HQhzegE8U7vybR2V53HAx1kx1FsaZhSfPHnsn3
        y37qEVlaDy19KrgblVFaGR0=
X-Google-Smtp-Source: ABdhPJynxAyQSQnhNPeCkGhKlNMBkNxtJ6xvuiPBpZT0sbcO6KQsyJhX5vCfoQjpVm95uTzcMNfOiA==
X-Received: by 2002:a17:906:7947:b0:6da:892f:2503 with SMTP id l7-20020a170906794700b006da892f2503mr32835681ejo.710.1651181107326;
        Thu, 28 Apr 2022 14:25:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ze12-20020a170906ef8c00b006f3ef214e68sm37147ejb.206.2022.04.28.14.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:25:06 -0700 (PDT)
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
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 3/4] Documentation/vm: Move "Using kmap-atomic" to highmem.h
Date:   Thu, 28 Apr 2022 23:24:54 +0200
Message-Id: <20220428212455.892-4-fmdefrancesco@gmail.com>
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

The use of kmap_atomic() is new code is being deprecated in favor of
kmap_local_page(). For this reason the "Using kmap_atomic" section in
highmem.rst is obsolete and unnecessary, but it can still help developers
if it were moved to kdocs in highmem.h.

Therefore, move the relevant parts of this section from highmem.rst and
merge them with the kdocs in highmem.h.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 35 -----------------------------------
 include/linux/highmem.h      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index ccff08a8211d..e05bf5524174 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -72,41 +72,6 @@ The kernel contains several ways of creating temporary mappings:
   It may be assumed that k[un]map_atomic() won't fail.
 
 
-Using kmap_atomic
-=================
-
-When and where to use kmap_atomic() is straightforward.  It is used when code
-wants to access the contents of a page that might be allocated from high memory
-(see __GFP_HIGHMEM), for example a page in the pagecache.  The API has two
-functions, and they can be used in a manner similar to the following::
-
-	/* Find the page of interest. */
-	struct page *page = find_get_page(mapping, offset);
-
-	/* Gain access to the contents of that page. */
-	void *vaddr = kmap_atomic(page);
-
-	/* Do something to the contents of that page. */
-	memset(vaddr, 0, PAGE_SIZE);
-
-	/* Unmap that page. */
-	kunmap_atomic(vaddr);
-
-Note that the kunmap_atomic() call takes the result of the kmap_atomic() call
-not the argument.
-
-If you need to map two pages because you want to copy from one page to
-another you need to keep the kmap_atomic calls strictly nested, like::
-
-	vaddr1 = kmap_atomic(page1);
-	vaddr2 = kmap_atomic(page2);
-
-	memcpy(vaddr1, vaddr2, PAGE_SIZE);
-
-	kunmap_atomic(vaddr2);
-	kunmap_atomic(vaddr1);
-
-
 Cost of Temporary Mappings
 ==========================
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index f6c2d9beff2c..b37e8079fc40 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -145,6 +145,37 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  * Mappings should always be released by kunmap_atomic().
  *
  * Do not use in new code. Use kmap_local_page() instead.
+ *
+ * It is used in atomic context when code wants to access the contents of a
+ * page that might be allocated from high memory (see __GFP_HIGHMEM), for
+ * example a page in the pagecache.  The API has two functions, and they
+ * can be used in a manner similar to the following:
+ *
+ * -- Find the page of interest. --
+ * struct page *page = find_get_page(mapping, offset);
+ *
+ * -- Gain access to the contents of that page. --
+ * void *vaddr = kmap_atomic(page);
+ *
+ * -- Do something to the contents of that page. --
+ * memset(vaddr, 0, PAGE_SIZE);
+ *
+ * -- Unmap that page. --
+ * kunmap_atomic(vaddr);
+ *
+ * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
+ * call, not the argument.
+ *
+ * If you need to map two pages because you want to copy from one page to
+ * another you need to keep the kmap_atomic calls strictly nested, like:
+ *
+ * vaddr1 = kmap_atomic(page1);
+ * vaddr2 = kmap_atomic(page2);
+ *
+ * memcpy(vaddr1, vaddr2, PAGE_SIZE);
+ *
+ * kunmap_atomic(vaddr2);
+ * kunmap_atomic(vaddr1);
  */
 static inline void *kmap_atomic(struct page *page);
 
-- 
2.34.1

